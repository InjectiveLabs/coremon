package main

import (
	"fmt"

	"github.com/cosmos/cosmos-sdk/codec"
	cosmtypes "github.com/cosmos/cosmos-sdk/codec/types"
	"github.com/cosmos/cosmos-sdk/std"
	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxdb2api "github.com/influxdata/influxdb-client-go/v2/api"
	cli "github.com/jawher/mow.cli"
	"github.com/xlab/closer"
	log "github.com/xlab/suplog"

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

		appHomeDir *string

		// args
		rewindFromBlock *int
		reverse         *bool
	)

	initCosmosOptions(
		c,
		&chainID,
		&bftRPC,
		&parallelBlockFetchJobs,
		&appHomeDir,
	)

	initInfluxOptions(
		c,
		&influxEnabled,
		&influxEndpoint,
		&influxDBName,
		&influxUser,
		&influxPassword,
	)

	c.Before = func() {
		initMetrics(c)

		appLogger.Info("CoreMon Block Watching routine starts")
	}

	rewindFromBlock = c.IntArg("REWIND_FROM", 0, "Rewind from block - starts watching from this block in the past.")
	reverse = c.BoolOpt("reverse", false, "Reverse the block fetching direction. If reverse, starts pulling historical blocks starting from the specified block.")

	c.Action = func() {
		defer closer.Close()

		closer.Bind(func() {
			rootCancelFn()
		})

		var (
			influxClient   influxdb2.Client
			influxWriteAPI influxdb2api.WriteAPI
		)

		if *influxEnabled {
			influxClient = influxdb2.NewClient(*influxEndpoint, *influxUser+":"+*influxPassword)
			influxWriteAPI = influxClient.WriteAPI("", *influxDBName)

			errorsCh := influxWriteAPI.Errors()
			go func() {
				for err := range errorsCh {
					appLogger.WithError(err).Warning("InfluxDB write error")
				}
			}()

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

		direction := coremon.BlockGetterDirectionForward
		if *reverse {
			direction = coremon.BlockGetterDirectionBackward

			// log the mode active

			startBlockDesc := "latest"
			if rewindFrom > 0 {
				startBlockDesc = fmt.Sprintf("%d", rewindFrom)
			}

			appLogger.WithFields(log.Fields{
				"start_block": startBlockDesc,
			}).Infoln("Pulling blocks in reverse direction.")
		}

		go blockWatcher.StartWatching(uint64(rewindFrom), direction)
		closer.Bind(func() {
			blockWatcher.Close()
		})

		if len(*appHomeDir) > 0 {
			sysWatcher, err := coremon.NewSysWatcher(
				*chainID,
				rootCtx,
				appLogger,
				*appHomeDir,
			)
			if err != nil {
				appLogger.WithFields(log.Fields{
					"app_home_dir": *appHomeDir,
				}).Errorln("Failed to start system watcher.")
			} else {
				go sysWatcher.StartWatching()
				closer.Bind(func() {
					sysWatcher.Close()
				})
			}
		}

		//
		// Wait till Ctrl+C
		//

		closer.Hold()
	}
}
