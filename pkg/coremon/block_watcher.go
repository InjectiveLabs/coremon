// Package coremon implements the service.
package coremon

import (
	"context"
	"sync"
	"time"

	retry "github.com/avast/retry-go/v4"
	ctypes "github.com/cometbft/cometbft/rpc/core/types"
	tmtypes "github.com/cometbft/cometbft/types"
	"github.com/cosmos/cosmos-sdk/codec"
	"github.com/pkg/errors"
	log "github.com/xlab/suplog"

	"github.com/InjectiveLabs/coremon/pkg/tmclient"
)

type TmBlockWatcher interface {
	StartWatching(latestSyncedBlock uint64, direction BlockGetterDirection)
	LastSyncedBlock() uint64
	IsSynced() bool
	WaitForSync()
	Close() error
}

type BlockGetter interface {
	NewBlockDataChan() <-chan NewBlockData
	Close()
}

type NewBlockHandlerFn func(
	prevBlock,
	nextBlock NewBlockData,
) error

func NewTmBlockWatcher(
	ctx context.Context,
	logger log.Logger,
	chainID string,
	bftRPC string,
	protoCodec *codec.ProtoCodec,
	parallelBlockFetchJobs int,
	blockDataHandler NewBlockHandlerFn,
) (watcher TmBlockWatcher, err error) {
	tmClient, err := tmclient.NewRPCClient(bftRPC)
	if err != nil {
		return nil, err
	}

	w := &tmBlockWatcher{
		rootCtx:  ctx,
		chainID:  chainID,
		bftRPC:   bftRPC,
		tmClient: tmClient,

		parallelBlockFetchJobs: parallelBlockFetchJobs,
		blockDataHandler:       blockDataHandler,

		handlerWG:            new(sync.WaitGroup),
		protoCodec:           protoCodec,
		latestSyncedBlockMux: new(sync.RWMutex),
		isSynced:             make(chan struct{}, 1),
		isClosing:            make(chan struct{}, 1),
		isDone:               make(chan struct{}, 1),

		logger: logger.WithField("svc", "block_watcher"),
	}

	return w, nil
}

type Status struct {
	LastBlock     uint64    `json:"last_block"`
	LastBlockTime time.Time `json:"last_block_time"`
}

type tmBlockWatcher struct {
	rootCtx  context.Context
	chainID  string
	bftRPC   string
	tmClient tmclient.TendermintClient

	blockGetter            BlockGetter
	parallelBlockFetchJobs int
	blockDataHandler       NewBlockHandlerFn

	handlerWG            *sync.WaitGroup
	latestSyncedBlock    uint64
	latestSyncedBlockMux *sync.RWMutex
	protoCodec           *codec.ProtoCodec

	isSynced  chan struct{}
	isClosing chan struct{}
	isDone    chan struct{}

	logger log.Logger
}

func (w *tmBlockWatcher) Close() (err error) {
	w.logger.Info("TmBlockWatcher exits")

	defer func() {
		w.logger.Info("TmBlockWatcher exited")
	}()

	close(w.isClosing)

	w.handlerWG.Wait()

	deadlineT := time.NewTimer(3 * time.Second)
	select {
	case <-w.isDone:
		// closed upon the latest block processed, no more blocks will be processed
	case <-deadlineT.C:
		// no new block in 3s, consider this stale
	}

	return
}

func (w *tmBlockWatcher) WaitForSync() {
	select {
	case <-w.isSynced:
	case <-w.isClosing:
	}
}

func (w *tmBlockWatcher) IsSynced() bool {
	select {
	case <-w.isSynced:
		return true
	default:
		return false
	}
}

func (w *tmBlockWatcher) LastSyncedBlock() uint64 {
	w.latestSyncedBlockMux.RLock()
	defer w.latestSyncedBlockMux.RUnlock()

	return w.latestSyncedBlock
}

func (w *tmBlockWatcher) runInitialSync(ctx context.Context, latestSyncedBlock uint64) error {
	var upperBound uint64

	height, ts, err := w.tmClient.GetLatestBlockHeight(ctx)
	if err != nil {
		err = errors.Wrap(err, "failed to get latest block info from chain daemon")
		return err
	}

	if !ts.IsZero() {
		w.logger.Infof("Block Sync: At block height %d while chain is at %d (%s)",
			latestSyncedBlock, height, ts.Format(time.RFC3339),
		)
	} else {
		w.logger.Infof("Block Sync: At block height %d while chain is at %d",
			latestSyncedBlock, height,
		)
	}

	upperBound = uint64(height)

	if latestSyncedBlock >= upperBound {
		// already synced
		return nil
	}

	// TODO: inital sync logic there if needed to access past blocks

	w.latestSyncedBlockMux.Lock()
	w.latestSyncedBlock = uint64(height)
	w.latestSyncedBlockMux.Unlock()

	return nil
}

func (w *tmBlockWatcher) StartWatching(latestSyncedBlock uint64, direction BlockGetterDirection) {
	rewindTo := latestSyncedBlock

	// initial sync: wait until getting up to chain height
	if err := w.runInitialSync(w.rootCtx, latestSyncedBlock); err != nil {
		w.logger.WithError(err).Fatal("failed to run initial block sync")
		return
	}

	w.latestSyncedBlockMux.Lock()
	if rewindTo != 0 {
		w.latestSyncedBlock = uint64(latestSyncedBlock) - 1
	}

	w.blockGetter = w.initBlockGetter(w.latestSyncedBlock+1, w.parallelBlockFetchJobs, direction)
	w.latestSyncedBlockMux.Unlock()

	newBlocks := w.blockGetter.NewBlockDataChan()

	// signal that the syncing is officially done
	close(w.isSynced)

	if rewindTo != 0 {
		w.logger.Infof("Block Sync: Initial sync done. Rewinding to block %d", rewindTo)
	} else {
		w.logger.Info("Block Sync: Initial sync done. Continuing to poll BFT RPC for the new blocks.")
	}

	// forward direction loop fetcing the next block and handling it,
	// keeping the previous block for the next iteration.
	if direction == BlockGetterDirectionForward {
		var prevBlock *NewBlockData

		for {
			select {
			case <-w.isClosing:
				// no more new blocks
				return
			case <-w.isDone:
				// no more new blocks
				return
			case nextBlock, ok := <-newBlocks:
				if !ok {
					// no more new blocks
					return
				} else if prevBlock == nil {
					// no previous block for now, skip
					prevBlock = &nextBlock
					continue
				}

				if prevBlock.Block.Height != nextBlock.Block.Height-1 {
					w.logger.Fatalf("sequentieal block height mismatch: %d != %d", prevBlock.Block.Height, nextBlock.Block.Height)
					return
				}

				if err := w.handleNewBlockData(prevBlock, &nextBlock); err != nil {
					if err == ErrShuttingDown {
						return
					}

					w.logger.WithError(err).Fatalf("failed to sync recent block, stopped at %d", w.LastSyncedBlock())
					return
				}

				// store the processed block for the next iteration
				prevBlock = &nextBlock
			}
		}
	}

	if direction == BlockGetterDirectionBackward {
		var nextBlock *NewBlockData

		for {
			select {
			case <-w.isClosing:
				// no more new blocks
				return
			case <-w.isDone:
				// no more new blocks
				return
			case prevBlock, ok := <-newBlocks:
				if !ok {
					// no more new blocks
					return
				} else if nextBlock == nil {
					// no previous block for now, skip
					nextBlock = &prevBlock
					continue
				}

				if prevBlock.Block.Height != nextBlock.Block.Height-1 {
					w.logger.Fatalf("sequentieal block height mismatch: %d != %d", prevBlock.Block.Height, nextBlock.Block.Height)
					return
				}

				if err := w.handleNewBlockData(&prevBlock, nextBlock); err != nil {
					if err == ErrShuttingDown {
						return
					}

					w.logger.WithError(err).Fatalf("failed to sync recent block, stopped at %d", w.LastSyncedBlock())
					return
				}

				// store the non-processed block for the next iteration
				nextBlock = &prevBlock
			}
		}
	}

	panic("unsupported direction")
}

var ErrShuttingDown = errors.New("shutting down")

type NewBlockData struct {
	Block        *tmtypes.Block
	BlockResults *ctypes.ResultBlockResults
	ActiveSet    []*tmtypes.Validator
}

type BlockGetterDirection string

const (
	BlockGetterDirectionForward  BlockGetterDirection = "forward"
	BlockGetterDirectionBackward BlockGetterDirection = "backward"
)

func (w *tmBlockWatcher) handleNewBlockData(prevBlock, nextBlock *NewBlockData) (err error) {
	if err = w.blockDataHandler(*prevBlock, *nextBlock); err != nil {
		return err
	}

	w.latestSyncedBlockMux.Lock()
	w.latestSyncedBlock = uint64(nextBlock.Block.Height)
	w.latestSyncedBlockMux.Unlock()

	select {
	case <-w.isClosing:
		// this is the latest block handled before exit
		close(w.isDone)

		err = ErrShuttingDown
	default:
	}

	return err
}

func (w *tmBlockWatcher) initBlockGetter(
	initHeight uint64,
	parallelJobs int,
	direction BlockGetterDirection,
) BlockGetter {
	getter := &blockGetter{
		tmClient: w.tmClient,

		jobs:      parallelJobs,
		jobMux:    new(sync.RWMutex),
		jobCond:   sync.NewCond(new(sync.Mutex)),
		height:    initHeight,
		direction: direction,

		newBlocksC:   make(chan NewBlockData, parallelJobs*100),
		newBlocksMap: make(map[uint64]NewBlockData, parallelJobs*100),
		closeC:       make(chan struct{}, 1),

		logger: w.logger,
	}

	w.logger.Debug("initBlockGetter ready to announce and pull blocks")

	go getter.announceBlocks(initHeight)
	go getter.pullBlocks()

	return getter
}

type blockGetter struct {
	tmClient tmclient.TendermintClient

	jobs      int
	jobMux    *sync.RWMutex
	jobCond   *sync.Cond
	height    uint64
	direction BlockGetterDirection

	newBlocksC   chan NewBlockData
	newBlocksMap map[uint64]NewBlockData
	closeC       chan struct{}

	logger log.Logger
}

func (b *blockGetter) announceBlocks(startHeight uint64) {
	height := startHeight

	if b.direction == BlockGetterDirectionBackward {
		height = startHeight - 1
	}

	for {
		select {
		case <-b.closeC:
			close(b.newBlocksC)
			return
		default:
			b.jobCond.L.Lock()

			ev, found := b.newBlocksMap[height]
			for !found {
				b.jobCond.Wait()

				ev, found = b.newBlocksMap[height]

				select {
				case <-b.closeC:
					close(b.newBlocksC)
					return
				default:
					continue
				}
			}

			delete(b.newBlocksMap, height)
			b.jobCond.L.Unlock()

			b.newBlocksC <- ev

			if b.direction == BlockGetterDirectionForward {
				height++
			} else if b.direction == BlockGetterDirectionBackward {
				height--
				if height == 0 {
					b.logger.Warningln("Block Sync: Backward sync done. Reached 0 block height.")
					return
				}
			} else {
				b.logger.Fatalf("unsupported block getter direction: %s", b.direction)
			}

			continue
		}
	}
}

func (b *blockGetter) pullBlocks() {
	clientCtx, cancelFn := context.WithCancel(context.Background())
	defer cancelFn()

	wg := new(sync.WaitGroup)
	defer wg.Wait()

	for i := 0; i < b.jobs; i++ {
		wg.Add(1)
		go func(jobID int) {
			defer wg.Done()

			getHeightToFetch := func() uint64 {
				b.jobMux.Lock()
				defer b.jobMux.Unlock()

				h := b.height

				if b.direction == BlockGetterDirectionForward {
					b.height++
				} else if b.direction == BlockGetterDirectionBackward {
					b.height--
				} else {
					b.logger.Fatalf("unsupported block getter direction: %s", b.direction)
				}

				return h
			}

			// step 1: obtain new height to fetch
			height := getHeightToFetch()

			for {
				select {
				case <-b.closeC:
					return
				default:
					jobLog := b.logger.WithFields(log.Fields{
						"job":    jobID,
						"height": height,
					})

					// step 2: try to fetch it until cancelled
					newBlock, err := b.fetchBlockByNum(clientCtx, height)
					if err != nil {
						// TODO: ignore future block errors
						jobLog.WithError(err).Warning("failed to fully fetch block, retry in 1s")

						time.Sleep(1 * time.Second)
						continue
					}

					var tooFarFromHead = false

					b.jobCond.L.Lock()
					b.newBlocksMap[height] = newBlock
					b.jobCond.Signal()

					if len(b.newBlocksMap) > 1024*b.jobs {
						tooFarFromHead = true
					}
					b.jobCond.L.Unlock()

					// job sleeps until backlog is too high
					for tooFarFromHead {
						time.Sleep(200 * time.Millisecond)

						b.jobCond.L.Lock()
						tooFarFromHead = len(b.newBlocksMap) > 1024*b.jobs
						b.jobCond.L.Unlock()
					}

					// step 3: assign a new height to the job
					height = getHeightToFetch()
				}
			}
		}(i)
	}
}

func (b *blockGetter) fetchBlockByNum(ctx context.Context, height uint64) (NewBlockData, error) {
	blockC := make(chan *ctypes.ResultBlock, 1)
	blockResultsC := make(chan *ctypes.ResultBlockResults, 1)
	validatorSetC := make(chan []*tmtypes.Validator, 1)
	errC := make(chan error, 4)

	retryOpts := []retry.Option{
		retry.Attempts(10),
		retry.MaxDelay(5 * time.Second),
	}

	go func() {
		defer close(blockC)

		if err := retry.Do(func() error {
			block, err := b.tmClient.GetBlock(ctx, int64(height))
			if err != nil {
				err = errors.Wrapf(err, "failed to get block info (%d) from chain daemon, will retry", height)
				return err
			}

			blockC <- block
			return nil
		}, retryOpts...); err != nil {
			errC <- err
		}
	}()

	go func() {
		defer close(blockResultsC)

		if err := retry.Do(func() error {
			blockResults, err := b.tmClient.GetBlockResults(ctx, int64(height))
			if err != nil {
				err = errors.Wrapf(err, "failed to get block results (%d) from chain daemon", height)
				return err
			}

			blockResultsC <- blockResults
			return nil
		}, retryOpts...); err != nil {
			errC <- err
		}
	}()

	go func() {
		defer close(validatorSetC)

		validatorSet, err := b.tmClient.GetValidators(ctx, int64(height))
		if err != nil {
			errC <- errors.Wrapf(err, "failed to get validator set (%d)", height)
			return
		} else if validatorSet == nil {
			errC <- errors.Errorf("failed to get validator set (%d)", height)
			return
		}

		validatorSetC <- validatorSet.Validators
	}()

	block := <-blockC
	blockResults := <-blockResultsC
	validatorSet := <-validatorSetC

	select {
	case err := <-errC:
		return NewBlockData{}, err
	default:
		close(errC)
	}

	return NewBlockData{
		Block:        block.Block,
		BlockResults: blockResults,
		ActiveSet:    validatorSet,
	}, nil
}

func (b *blockGetter) NewBlockDataChan() <-chan NewBlockData {
	return b.newBlocksC
}

func (b *blockGetter) Close() {
	if b.jobCond != nil {
		b.jobCond.Signal()
	}

	close(b.closeC)
}
