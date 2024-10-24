package main

import (
	"github.com/cosmos/cosmos-sdk/codec"
	cosmtypes "github.com/cosmos/cosmos-sdk/codec/types"
	"github.com/cosmos/cosmos-sdk/std"
	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxdb2api "github.com/influxdata/influxdb-client-go/v2/api"
	cli "github.com/jawher/mow.cli"
	"github.com/xlab/closer"

	"github.com/InjectiveLabs/coremon/pkg/coremon"
)

func processCmd(c *cli.Cmd) {
	var (
		chainID                *string
		bftRPC                 *string
		parallelBlockFetchJobs *int

		influxEnabled  *bool
		influxEndpoint *string
		influxDBName   *string
		influxUser     *string
		influxPassword *string

		// args
		rewindFromBlock *int
	)

	initCosmosOptions(
		c,
		&chainID,
		&bftRPC,
		&parallelBlockFetchJobs,
	)

	initInfluxOptions(
		c,
		&influxEnabled,
		&influxEndpoint,
		&influxDBName,
		&influxUser,
		&influxPassword,
	)

	rewindFromBlock = c.IntArg("REWIND_FROM", 0, "Rewind from block - starts watching from this block in the past.")

	c.Before = func() {
		initMetrics(c)

		appLogger.Info("CoreMon Block Watching routine starts")
	}

	c.Action = func() {
		defer closer.Close()

		closer.Bind(func() {
			rootCancelFn()
		})

		var (
			influxClient   influxdb2.Client
			influxWriteAPI influxdb2api.WriteAPIBlocking
		)

		if *influxEnabled {
			influxClient = influxdb2.NewClient(*influxEndpoint, *influxUser+":"+*influxPassword)
			influxWriteAPI = influxClient.WriteAPIBlocking("", *influxDBName)

			// errorsCh := influxWriteAPI.Errors()
			// go func() {
			// 	for err := range errorsCh {
			// 		appLogger.WithError(err).Warning("InfluxDB write error")
			// 	}
			// }()

			closer.Bind(func() {
				influxClient.Close()
			})
		}

		interfaceRegistry := cosmtypes.NewInterfaceRegistry()
		std.RegisterInterfaces(interfaceRegistry)
		protoCodec := codec.NewProtoCodec(interfaceRegistry)

		blockWatcher, err := coremon.NewTmBlockWatcher(
			rootCtx,
			appLogger,
			*chainID,
			*bftRPC,
			protoCodec,
			*parallelBlockFetchJobs,
			coremon.NewBlockHandlerWithMetrics(appLogger, *chainID, influxWriteAPI),
		)
		if err != nil {
			panic(err)
		}

		// Launch chain block watcher routine
		//

		rewindFrom := *rewindFromBlock
		if rewindFrom < 0 {
			rewindFrom = 0
		}

		go blockWatcher.StartWatching(uint64(rewindFrom))
		closer.Bind(func() {
			blockWatcher.Close()
		})

		//
		// Wait till Ctrl+C
		//

		closer.Hold()
	}
}
