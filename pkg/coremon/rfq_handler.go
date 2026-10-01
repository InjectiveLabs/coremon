package coremon

import (
	"context"
	"time"

	"github.com/cosmos/cosmos-sdk/x/authz"
	"github.com/cosmos/gogoproto/proto"
	influxdb2api "github.com/influxdata/influxdb-client-go/v2/api"
	influxwrite "github.com/influxdata/influxdb-client-go/v2/api/write"
	"github.com/pkg/errors"
	"github.com/xlab/pace"
	metrics "github.com/xlab/statsd_metrics"
	log "github.com/xlab/suplog"
)

// NewRFQOnlyBlockHandler writes only RFQ and WASM error measurements (coremon_rfq_txs,
// coremon_rfq_quotes, coremon_wasm_errors). Used to backfill these stats without touching
// (overwriting or double counting) any other coremon measurements.
func NewRFQOnlyBlockHandler(
	logger log.Logger,
	chainID string,
	influxWriteAPI influxdb2api.WriteAPI,
	rfqCfg RFQConfig,
) NewBlockHandlerFn {
	logger = logger.WithField("fn", "rfq_block_handler")
	metricTags := metrics.NewTags(map[string]string{
		"svc":      "coremon",
		"chain_id": chainID,
	})

	rfq := newRFQTracker(rfqCfg)

	blocksPace := pace.New("blocks synced", 1*time.Minute, newPaceReporter(logger))
	pointsPace := pace.New("influx points out", 1*time.Minute, newPaceReporter(logger))

	var lastHeightLog time.Time

	return func(prevBlock, nextBlock NewBlockData) error {
		allTags := metricTags.WithBaseTags()
		rfq.ObserveBlocks(prevBlock, nextBlock)

		var pointsToWrite []*influxwrite.Point

		for txIndex, txResult := range nextBlock.BlockResults.TxResults {
			parsedTx, err := decodeABCITx(nextBlock.Block.Txs[txIndex])
			if err != nil {
				return errors.Wrap(err, "failed to decode ABCI Tx")
			}

			msgs := parsedTx.GetMsgs()
			filteredMsgs := make([]proto.Message, 0, len(msgs))

			for _, msg := range msgs {
				msgExec, ok := msg.(*authz.MsgExec)
				if !ok {
					filteredMsgs = append(filteredMsgs, msg)
					continue
				}

				for _, authzInternalAny := range msgExec.Msgs {
					var authzInternalMsg proto.Message
					if err := injectiveCdc.UnpackAny(authzInternalAny, &authzInternalMsg); err != nil {
						return errors.Wrapf(err, "failed to unpack any from %s", authzInternalAny.TypeUrl)
					}

					filteredMsgs = append(filteredMsgs, authzInternalMsg)
				}
			}

			pointsToWrite = append(pointsToWrite, rfq.TxPoints(
				nextBlock,
				txIndex,
				txResult,
				parsedTx,
				filteredMsgs,
				allTags,
			)...)
		}

		pointsToWrite = append(pointsToWrite, rfq.Flush()...)

		blocksPace.StepN(1)

		if time.Since(lastHeightLog) > time.Minute {
			lastHeightLog = time.Now()
			logger.WithFields(log.Fields{
				"height":     nextBlock.Block.Height,
				"block_time": nextBlock.Block.Time.UTC().Format(time.RFC3339),
			}).Info("rfq-only progress")
		}

		if len(pointsToWrite) > 0 {
			ctx, cancelFn := context.WithTimeout(context.Background(), 1*time.Minute)
			writeInfluxPoints(ctx, logger, influxWriteAPI, pointsToWrite, metricTags)
			cancelFn()

			pointsPace.StepN(len(pointsToWrite))
		}

		return nil
	}
}
