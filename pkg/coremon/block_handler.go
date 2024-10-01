package coremon

import (
	"context"
	"time"

	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxdb2api "github.com/influxdata/influxdb-client-go/v2/api"
	influxwrite "github.com/influxdata/influxdb-client-go/v2/api/write"
	"github.com/xlab/pace"
	metrics "github.com/xlab/statsd_metrics"
	log "github.com/xlab/suplog"
)

func NewBlockHandlerWithMetrics(
	logger log.Logger,
	chainID string,
	influxWriteAPI influxdb2api.WriteAPIBlocking,
) NewBlockHandlerFn {
	logger = logger.WithField("fn", "block_handler")
	metricTags := metrics.NewTags(map[string]string{
		"svc":      "coremon",
		"chain_id": chainID,
	})

	blockTimestamps := make(map[uint64]time.Time)

	newBlockHandlerPace := pace.New("blocks synced", 1*time.Minute, newPaceReporter(logger))
	txsInBlocksPace := pace.New("tx throughput", 1*time.Minute, newPaceReporter(logger))
	influxPointsOutPace := pace.New("influx points out", 1*time.Minute, newPaceReporter(logger))

	txThroughputReporting := pace.New("", 15*time.Second, func(_ string, timeframe time.Duration, value float64) {
		// throughputReal is the tx throughput measured relative to the real-world time clock
		throughputReal := value / (float64(timeframe) / float64(time.Second))

		metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
			s.Gauge("report.observed_txs_throughput", throughputReal, tagSpec)
		}, metricTags)
	})

	blocksPaceReporting := pace.New("", 15*time.Second, func(_ string, timeframe time.Duration, value float64) {
		// blocksPace is the block produce speed measured relative to the real-world time clock
		blocksPace := value / (float64(timeframe) / float64(time.Second))

		metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
			s.Gauge("report.observed_blocks_pace", blocksPace, tagSpec)
		}, metricTags)
	})

	return func(data NewBlockData) error {
		blockNumber := uint64(data.Block.Height)
		txsInBlock := len(data.Block.Txs)

		latency := time.Since(data.Block.Time)
		logger.WithFields(log.Fields{
			"height":  blockNumber,
			"latency": latency,
		}).Debug("got new block")

		var (
			// blockTimeDiff is the difference between two finalized block timestamps,
			// enough to compute avg blocktime in the metrics postprocessing.
			blockTimeDiff time.Duration

			// txTroughputAbs is the absolute throughput, based on num of transactions
			// included in the block that was finalized in blockTimeDiff.
			txTroughputAbs float64

			// txBytes is the cummulative size of all txns in the block
			txBytes int

			// txGas is the cummulative gas spent on all txns in the block
			txGas int64
		)

		blockTimestamps[blockNumber] = data.Block.Time
		if prevBlockTimestamp, ok := blockTimestamps[blockNumber-1]; ok {
			blockTimeDiff = data.Block.Time.Sub(prevBlockTimestamp)
			txTroughputAbs = float64(txsInBlock) / (float64(blockTimeDiff) / float64(time.Second))
		}

		if txsInBlock > 0 {
			for _, tx := range data.Block.Txs {
				txBytes += len(tx)
			}

			for _, txResult := range data.BlockResults.TxsResults {
				txGas += txResult.GasUsed
			}
		}

		newBlockHandlerPace.StepN(1)
		blocksPaceReporting.StepN(1)
		txsInBlocksPace.StepN(txsInBlock)
		txThroughputReporting.StepN(txsInBlock)

		metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
			s.Timing("report.ingest_latency", latency, tagSpec)
			s.Gauge("report.observed_height", blockNumber, tagSpec)

			if txsInBlock > 0 {
				s.Count("report.observed_txs_total", txsInBlock, tagSpec)
			}
		}, metricTags)

		pointsToWrite := make([]*influxwrite.Point, 0, 1)
		{
			// assemble 'coremon_block_report' measurement point with all fields about particular block

			p := influxdb2.NewPointWithMeasurement("coremon_block_report")
			p = p.SetTime(data.Block.Time)
			p = p.AddField("height", data.Block.Height)

			if txsInBlock > 0 {
				p = p.AddField("txs", txsInBlock)

				p = p.AddField("txs_bytes", txBytes)
				p = p.AddField("txs_gas", txGas)
			}

			if blockTimeDiff > 0 {
				p = p.AddField("time_diff", float64(blockTimeDiff)/float64(time.Millisecond))

				if txTroughputAbs > 0 {
					p = p.AddField("txs_throughput", txTroughputAbs)
				}
			}

			allTags := metricTags.WithBaseTags()
			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)
		}

		if len(pointsToWrite) > 0 {
			ctx, cancelFn := context.WithTimeout(
				context.Background(),
				10*time.Second,
			)
			writeInfluxPoints(ctx, logger, influxWriteAPI, pointsToWrite)
			cancelFn()

			influxPointsOutPace.StepN(len(pointsToWrite))
		}

		return nil
	}
}

func writeInfluxPoints(
	ctx context.Context,
	logger log.Logger,
	writeAPI influxdb2api.WriteAPIBlocking,
	points []*influxwrite.Point,
) {
	// defer func() {
	// 	writeAPI.Flush()
	// }()

	for _, point := range points {
		if err := writeAPI.WritePoint(ctx, point); err != nil {
			logger.WithError(err).Warning("failed to write point to InfluxDB")
			return
		}
	}
}
