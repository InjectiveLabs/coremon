package tmclient

import (
	"context"
	"time"

	rpcclient "github.com/cometbft/cometbft/rpc/client"
	rpchttp "github.com/cometbft/cometbft/rpc/client/http"
	ctypes "github.com/cometbft/cometbft/rpc/core/types"
	tmctypes "github.com/cometbft/cometbft/rpc/core/types"
	"github.com/pkg/errors"
)

type TendermintClient interface {
	GetBlock(ctx context.Context, height int64) (*tmctypes.ResultBlock, error)
	GetLatestBlockHeight(ctx context.Context) (int64, time.Time, error)
	GetBlockResults(ctx context.Context, height int64) (*ctypes.ResultBlockResults, error)
}

type tmClient struct {
	rpcClient rpcclient.Client
}

func NewRPCClient(rpcNodeAddr string) (TendermintClient, error) {
	rpcClient, err := rpchttp.NewWithTimeout(rpcNodeAddr, "/websocket", 10)
	if err != nil {
		err = errors.Wrap(err, "failed to init rpcClient")
		return nil, err
	}

	return &tmClient{
		rpcClient: rpcClient,
	}, nil
}

// GetBlock queries for a block by height. An error is returned if the query fails.
func (c *tmClient) GetBlock(ctx context.Context, height int64) (*tmctypes.ResultBlock, error) {
	return c.rpcClient.Block(ctx, &height)
}

// GetBlock queries for a block by height. An error is returned if the query fails.
func (c *tmClient) GetBlockResults(ctx context.Context, height int64) (*ctypes.ResultBlockResults, error) {
	return c.rpcClient.BlockResults(ctx, &height)
}

// GetLatestBlockHeight returns the latest block height and time on the active chain.
func (c *tmClient) GetLatestBlockHeight(ctx context.Context) (int64, time.Time, error) {
	status, err := c.rpcClient.Status(ctx)
	if err != nil {
		return -1, time.Time{}, err
	}

	height := status.SyncInfo.LatestBlockHeight

	return height, status.SyncInfo.LatestBlockTime, nil
}
