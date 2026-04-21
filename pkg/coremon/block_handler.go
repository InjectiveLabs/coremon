package coremon

import (
	"context"
	"fmt"
	"math"
	"regexp"
	"sort"
	"strconv"
	"time"

	sdkmath "cosmossdk.io/math"
	abci "github.com/cometbft/cometbft/abci/types"
	bfttypes "github.com/cometbft/cometbft/types"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/authz"
	"github.com/cosmos/gogoproto/proto"
	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxdb2api "github.com/influxdata/influxdb-client-go/v2/api"
	influxwrite "github.com/influxdata/influxdb-client-go/v2/api/write"
	"github.com/pkg/errors"
	"github.com/xlab/pace"
	metrics "github.com/xlab/statsd_metrics"
	log "github.com/xlab/suplog"
)

var nINJ = sdkmath.LegacyMustNewDecFromStr("1000000000")

const (
	txFeesEventType      = "txfees"
	txFeesBaseFeeAttrKey = "basefee"
)

func NewBlockHandlerWithMetrics(
	logger log.Logger,
	chainID string,
	influxWriteAPI influxdb2api.WriteAPI,
) NewBlockHandlerFn {
	logger = logger.WithField("fn", "block_handler")
	metricTags := metrics.NewTags(map[string]string{
		"svc":      "coremon",
		"chain_id": chainID,
	})

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

	return func(prevBlock, nextBlock NewBlockData) error {
		handlerStart := time.Now()

		blockNumber := uint64(nextBlock.Block.Height)
		txsInBlock := len(nextBlock.BlockResults.TxResults)
		blockEvents := len(nextBlock.BlockResults.FinalizeBlockEvents)

		latency := time.Since(nextBlock.Block.Time)
		logger.WithFields(log.Fields{
			"height":  blockNumber,
			"latency": latency,
		}).Debug("got new block")

		allTags := metricTags.WithBaseTags()

		var (
			// blockTimeDiff is the difference between two finalized block timestamps,
			// enough to compute avg blocktime in the metrics postprocessing.
			blockTimeDiff time.Duration

			// txTroughputAbs is the absolute throughput, based on num of transactions
			// included in the block that was finalized in blockTimeDiff.
			txTroughputAbs float64

			// txBytes is the cummulative size of all txns in the block
			txBytes int

			// txGasUsed is the cummulative gas spent on all txns in the block
			txGasUsed int64

			// txGasWanted is the cummulative gas spent on all txns in the block
			txGasWanted int64

			// txEventsPerBlock is the number of tx events per block
			txEventsPerBlock int64
		)

		blockTimeDiff = nextBlock.Block.Time.Sub(prevBlock.Block.Time)
		txTroughputAbs = float64(txsInBlock) / (float64(blockTimeDiff) / float64(time.Second))

		if txsInBlock > 0 {
			for _, tx := range nextBlock.Block.Txs {
				txBytes += len(tx)
			}

			for _, txResult := range nextBlock.BlockResults.TxResults {
				txGasUsed += txResult.GasUsed
				txGasWanted += txResult.GasWanted
				txEventsPerBlock += int64(len(txResult.Events))
			}
		}

		activeSet := make(map[string]ActiveSetValidator, len(nextBlock.ActiveSet))
		for _, validator := range nextBlock.ActiveSet {
			activeSet[validator.Address.String()] = ActiveSetValidator{
				Address:  validator.Address.String(),
				Shares:   float64(validator.VotingPower),
				Priority: validator.ProposerPriority,
			}
		}

		lastCommitSigs, stdDev := lastCommitMetrics(nextBlock.Block, activeSet)

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

		txFeeCollected := sdkmath.LegacyNewDec(0)

		pointsToWrite := make([]*influxwrite.Point, 0, 1)
		{
			for validatorAddress, validatorMetrics := range lastCommitSigs {
				p := influxdb2.NewPointWithMeasurement("coremon_validator_report")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddField("count", 1)
				p = p.AddTag("validator", validatorAddress)
				p = p.AddTag("proposer", nextBlock.Block.Header.ProposerAddress.String())

				switch validatorMetrics.Status {
				case bfttypes.BlockIDFlagCommit:
					p = p.AddField("sig_ok", 1)
				case bfttypes.BlockIDFlagNil:
					p = p.AddField("sig_skipped", 1)
				case bfttypes.BlockIDFlagAbsent:
					p = p.AddField("sig_missing", 1)
				}

				if validatorMetrics.Status != bfttypes.BlockIDFlagAbsent {
					if validatorMetrics.AbsoluteDelay != 0 {
						p = p.AddField("abs_delay", float64(validatorMetrics.AbsoluteDelay)/float64(time.Millisecond))
					}

					if validatorMetrics.StdDevDistance != 0 {
						p = p.AddField("std_dev_distance", validatorMetrics.StdDevDistance)
					}

					if validatorMetrics.ReactionTime != 0 {
						p = p.AddField("reaction_time", float64(validatorMetrics.ReactionTime)/float64(time.Millisecond))
					}

					if validatorMetrics.IsProposer {
						p = p.AddField("is_proposer", 1)

						if validatorMetrics.ProposerDelay != nil && *validatorMetrics.ProposerDelay != 0 {
							p = p.AddField("proposer_delay", float64(*validatorMetrics.ProposerDelay)/float64(time.Millisecond))
						}
					}
				}

				if val, ok := activeSet[validatorAddress]; ok {
					if val.Shares != 0 {
						p = p.AddField("shares", val.Shares)
					}

					if val.Priority != 0 {
						p = p.AddField("priority", val.Priority)
					}
				}

				allTags.Range(func(k, v string) bool {
					p = p.AddTag(k, v)
					return false
				})

				pointsToWrite = append(pointsToWrite, p)
			}
		}

		for evIdx, event := range nextBlock.BlockResults.FinalizeBlockEvents {
			p := influxdb2.NewPointWithMeasurement("coremon_block_events")
			p = p.SetTime(nextBlock.Block.Time)
			p = p.AddField("height", nextBlock.Block.Height)
			p = p.AddTag("ev_type", event.Type)
			p = p.AddField("ev_idx", evIdx)
			p = p.AddField("ev_id", fmt.Sprintf("fin_%d_%d", nextBlock.Block.Height, evIdx))
			p = p.AddField("count", 1)

			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)

			if event.Type == txFeesEventType {
				baseFeeDec, _, found, err := parseTxFeesBaseFeeEvent(event)
				if err != nil {
					logger.WithFields(log.Fields{
						"height": nextBlock.Block.Height,
						"error":  err,
					}).Warning("failed to parse txfees basefee event")
				} else if found {
					baseFeeFloat, _ := baseFeeDec.Float64()
					p := influxdb2.NewPointWithMeasurement("coremon_txfees_basefee")
					p = p.SetTime(nextBlock.Block.Time)
					p = p.AddField("height", nextBlock.Block.Height)
					p = p.AddField("count", 1)
					p = p.AddField("base_fee", baseFeeFloat)

					allTags.Range(func(k, v string) bool {
						p = p.AddTag(k, v)
						return false
					})

					pointsToWrite = append(pointsToWrite, p)
				}
			}

			for _, attr := range event.Attributes {
				p := influxdb2.NewPointWithMeasurement("coremon_block_events_attrs")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddField("count", 1)
				p = p.AddTag("ev_type", event.Type)
				p = p.AddField("ev_idx", evIdx)
				p = p.AddField("ev_id", fmt.Sprintf("fin_%d_%d", nextBlock.Block.Height, evIdx))
				p = p.AddTag("attr_key", attr.Key)
				p = p.AddField("valsize", len(attr.Value))
				if val, err := strconv.Atoi(attr.Value); err == nil {
					p = p.AddField("val", int64(val))
				}

				allTags.Range(func(k, v string) bool {
					p = p.AddTag(k, v)
					return false
				})

				pointsToWrite = append(pointsToWrite, p)
			}

			arityFieldsMap, err := parseEventArity(event)
			if err != nil {
				err = errors.Wrap(err, "failed to parse block event arity")
				return err
			}

			for fieldName, arity := range arityFieldsMap {
				if arity == 0 {
					continue
				}

				p := influxdb2.NewPointWithMeasurement("coremon_block_event_arity")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddField("count", 1)
				p = p.AddTag("ev_type", event.Type)
				p = p.AddField("ev_idx", evIdx)
				p = p.AddField("ev_id", fmt.Sprintf("fin_%d_%d", nextBlock.Block.Height, evIdx))
				p = p.AddTag("arity_field", fieldName)
				p = p.AddField("arity", arity)

				allTags.Range(func(k, v string) bool {
					p = p.AddTag(k, v)
					return false
				})

				pointsToWrite = append(pointsToWrite, p)
			}
		}

		authzUnpackings := 0

		for txIndex, txResult := range nextBlock.BlockResults.TxResults {
			var txFee sdktypes.DecCoin
			var txFeeSpender string
			var txFeeFound bool

			for evIdx, event := range txResult.Events {
				p := influxdb2.NewPointWithMeasurement("coremon_tx_events")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddField("tx_idx", txIndex)
				p = p.AddField("tx_id", fmt.Sprintf("%d_%d", nextBlock.Block.Height, txIndex))
				p = p.AddTag("ev_type", event.Type)
				p = p.AddField("ev_idx", evIdx)
				p = p.AddField("ev_id", fmt.Sprintf("evtx_%d_%d_%d", nextBlock.Block.Height, txIndex, evIdx))
				p = p.AddField("count", 1)

				allTags.Range(func(k, v string) bool {
					p = p.AddTag(k, v)
					return false
				})

				pointsToWrite = append(pointsToWrite, p)

				for _, attr := range event.Attributes {
					p := influxdb2.NewPointWithMeasurement("coremon_tx_events_attrs")
					p = p.SetTime(nextBlock.Block.Time)
					p = p.AddField("height", nextBlock.Block.Height)
					p = p.AddField("count", 1)
					p = p.AddField("tx_idx", txIndex)
					p = p.AddField("tx_id", fmt.Sprintf("%d_%d", nextBlock.Block.Height, txIndex))
					p = p.AddTag("ev_type", event.Type)
					p = p.AddField("ev_idx", evIdx)
					p = p.AddField("ev_id", fmt.Sprintf("evtx_%d_%d_%d", nextBlock.Block.Height, txIndex, evIdx))
					p = p.AddTag("attr_key", attr.Key)
					p = p.AddField("valsize", len(attr.Value))
					if val, err := strconv.Atoi(attr.Value); err == nil {
						p = p.AddField("val", int64(val))
					}

					if event.Type == "tx" {
						if attr.Key == "fee" {
							fee, err := sdktypes.ParseDecCoin(attr.Value)
							if err != nil {
								err = errors.Wrapf(err, "failed to parse coin in tx fee event: %s", attr.Value)
								return err
							}

							txFee = fee
							txFeeFound = true
						} else if attr.Key == "fee_payer" {
							txFeeSpender = attr.Value
						}
					}

					allTags.Range(func(k, v string) bool {
						p = p.AddTag(k, v)
						return false
					})

					pointsToWrite = append(pointsToWrite, p)
				}

				arityFieldsMap, err := parseEventArity(event)
				if err != nil {
					err = errors.Wrap(err, "failed to parse tx event arity")
					return err
				}

				for fieldName, arity := range arityFieldsMap {
					if arity == 0 {
						continue
					}

					p := influxdb2.NewPointWithMeasurement("coremon_tx_event_arity")
					p = p.SetTime(nextBlock.Block.Time)
					p = p.AddField("height", nextBlock.Block.Height)
					p = p.AddField("count", 1)
					p = p.AddField("tx_idx", txIndex)
					p = p.AddField("tx_id", fmt.Sprintf("%d_%d", nextBlock.Block.Height, txIndex))
					p = p.AddTag("ev_type", event.Type)
					p = p.AddField("ev_idx", evIdx)
					p = p.AddField("ev_id", fmt.Sprintf("evtx_%d_%d_%d", nextBlock.Block.Height, txIndex, evIdx))
					p = p.AddTag("arity_field", fieldName)
					p = p.AddField("arity", arity)

					allTags.Range(func(k, v string) bool {
						p = p.AddTag(k, v)
						return false
					})

					pointsToWrite = append(pointsToWrite, p)
				}
			}

			parsedTx, err := decodeABCITx(nextBlock.Block.Txs[txIndex])
			if err != nil {
				err = errors.Wrap(err, "failed to decode ABCI Tx")
				return err
			}

			msgs := parsedTx.GetMsgs()

			authzUnpackStart := time.Now()
			var authzExecMsgs int

			filteredMsgs := make([]proto.Message, 0, len(msgs))
			for _, msg := range msgs {
				if msgExec, ok := msg.(*authz.MsgExec); ok {
					authzExecMsgs++

					for _, authzInternalAny := range msgExec.Msgs {
						// append interal authz msgs only
						var authzInternalMsg proto.Message
						authzUnpackings++
						if err := injectiveCdc.UnpackAny(authzInternalAny, &authzInternalMsg); err != nil {
							err = errors.Wrapf(err, "failed to unpack any from %s", authzInternalAny.TypeUrl)
							return err
						}

						filteredMsgs = append(filteredMsgs, authzInternalMsg)
					}
				} else {
					// not authz, append as-is
					filteredMsgs = append(filteredMsgs, msg)
				}
			}

			metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
				s.Timing("report.authz_unpackings_dur", time.Duration(time.Since(authzUnpackStart).Nanoseconds()), tagSpec)
			}, metricTags)

			var singleMsgName string
			var singleMsgArity int

			for msgIndex, msg := range filteredMsgs {
				arityFieldsMap, err := parseMsgArity(msg)
				if err != nil {
					err = errors.Wrap(err, "failed to parse msg arity")
					return err
				}

				var totalArity int
				for fieldName, arity := range arityFieldsMap {
					if arity == 0 {
						continue
					}

					totalArity += arity

					p := influxdb2.NewPointWithMeasurement("coremon_tx_msg_arity")
					p = p.SetTime(nextBlock.Block.Time)
					p = p.AddField("height", nextBlock.Block.Height)
					p = p.AddField("tx_idx", txIndex)
					p = p.AddField("msg_idx", msgIndex)
					p = p.AddField("msg_id", fmt.Sprintf("%d_%d_%d", nextBlock.Block.Height, txIndex, msgIndex))
					p = p.AddTag("msg_name", proto.MessageName(msg))
					p = p.AddTag("arity_field", fieldName)
					p = p.AddField("arity", arity)
					p = p.AddField("count", 1)

					allTags.Range(func(k, v string) bool {
						p = p.AddTag(k, v)
						return false
					})

					pointsToWrite = append(pointsToWrite, p)
				}

				if totalArity == 0 {
					totalArity = 1
				}

				p := influxdb2.NewPointWithMeasurement("coremon_tx_msgs")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddField("tx_idx", txIndex)
				p = p.AddField("msg_idx", msgIndex)
				p = p.AddField("count", 1)
				p = p.AddField("msg_id", fmt.Sprintf("%d_%d_%d", nextBlock.Block.Height, txIndex, msgIndex))
				p = p.AddTag("msg_name", proto.MessageName(msg))
				p = p.AddField("msg_arity", totalArity)

				if len(filteredMsgs) == 1 {
					singleMsgName = proto.MessageName(msg)
					singleMsgArity = totalArity
				}

				allTags.Range(func(k, v string) bool {
					p = p.AddTag(k, v)
					return false
				})

				pointsToWrite = append(pointsToWrite, p)
			}

			p := influxdb2.NewPointWithMeasurement("coremon_txs")
			p = p.SetTime(nextBlock.Block.Time)
			p = p.AddField("height", nextBlock.Block.Height)
			p = p.AddField("count", 1)
			p = p.AddField("tx_idx", txIndex)
			p = p.AddField("tx_id", fmt.Sprintf("%d_%d", nextBlock.Block.Height, txIndex))
			p = p.AddField("gas_wanted", txResult.GasWanted)
			p = p.AddField("gas_used", txResult.GasUsed)
			p = p.AddField("events", len(txResult.Events))

			if txFeeFound {
				if txFee.Denom == "inj" {
					txFeeNINJ := txFee.Amount.Quo(nINJ)
					txFeeCollected = txFeeCollected.Add(txFeeNINJ)
					feeFloat, _ := txFeeNINJ.Float64()
					p = p.AddField("fee", feeFloat)

					gasPriceNINJ := txFeeNINJ.Quo(sdkmath.LegacyNewDec(txResult.GasWanted))
					gasPriceFloat, _ := gasPriceNINJ.Float64()
					p = p.AddField("gas_price", gasPriceFloat)

					// retarded gas price with >= 1 nINJ when min was 0.16 nINJ
					if gasPriceFloat >= 1 {
						p = p.AddTag("fee_spender", txFeeSpender)
					}
				} else {
					logger.WithFields(log.Fields{
						"block":  nextBlock.Block.Height,
						"tx_idx": txIndex,
						"denom":  txFee.Denom,
					}).Warning("unexpected tx fee denom")
				}
			}

			p = p.AddField("datasize", len(txResult.Data))
			p = p.AddTag("code", fmt.Sprintf("%d", txResult.Code))
			p = p.AddTag("codespace", txResult.Codespace)

			if txResult.Code != 0 {
				p = p.AddField("error", 1)

				sender, marketID, subaccountID := extractOrderFailureData(txResult.Log)
				if sender != "" && sender != "Value" {
					p = p.AddTag("sender", sender)
				}
				if marketID != "" && marketID != "Value" {
					p = p.AddTag("market_id", marketID)
				}
				if subaccountID != "" {
					p = p.AddTag("subaccount_id", subaccountID)
				}
			}

			p = p.AddField("raw_msgs", int64(len(msgs)))
			p = p.AddField("authz_msgs", int64(authzExecMsgs))
			p = p.AddField("msgs", int64(len(filteredMsgs)))

			if singleMsgName != "" {
				p = p.AddTag("msg_name", singleMsgName)
			}

			if singleMsgArity > 0 {
				p = p.AddField("msg_arity", singleMsgArity)
			}

			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)
		}

		{
			p := influxdb2.NewPointWithMeasurement("coremon_block_report")
			p = p.SetTime(nextBlock.Block.Time)
			p = p.AddField("height", nextBlock.Block.Height)
			p = p.AddTag("proposer", nextBlock.Block.Header.ProposerAddress.String())

			p = p.AddField("txs", txsInBlock)
			p = p.AddField("txs_bytes", txBytes)
			p = p.AddField("txs_gas", txGasUsed)
			p = p.AddField("txs_gas_wanted", txGasWanted)
			p = p.AddField("txs_events", txEventsPerBlock)
			p = p.AddField("block_events", blockEvents)

			if txFeeCollected.IsPositive() {
				txFeeCollectedFloat, _ := txFeeCollected.Float64()
				p = p.AddField("txs_fee", txFeeCollectedFloat)
				p = p.AddField("txs_gas_price", txFeeCollectedFloat/float64(txGasWanted))
			}

			if blockTimeDiff != 0 {
				p = p.AddField("time_diff", float64(blockTimeDiff)/float64(time.Millisecond))

				if txTroughputAbs > 0 {
					p = p.AddField("txs_throughput", txTroughputAbs)
				}
			}

			if nextBlock.Block.LastCommit.Round > 0 {
				p = p.AddField("rounds_missed", nextBlock.Block.LastCommit.Round)
			}

			if !nextBlock.Block.Time.After(prevBlock.Block.Time) {
				// could be 0ms but count() will show it anyways
				p = p.AddField("time_skew", float64(nextBlock.Block.Time.Sub(prevBlock.Block.Time))/float64(time.Millisecond))
			}

			if lastCommitRoundDuration := lastCommitRoundDuration(nextBlock.Block); lastCommitRoundDuration > 0 {
				p = p.AddField("round_dur", float64(lastCommitRoundDuration)/float64(time.Millisecond))
			}

			sigOK, sigSkipped, sigMissing := blockSignaturesStats(nextBlock.Block)

			if sigOK > 0 {
				p = p.AddField("sig_ok", sigOK)
				if len(nextBlock.ActiveSet) > 0 {
					p = p.AddField("sig_ok_pct", float64(sigOK)/float64(len(nextBlock.ActiveSet)))
				}
			}

			if sigSkipped > 0 {
				p = p.AddField("sig_skipped", sigSkipped)

				if len(nextBlock.ActiveSet) > 0 {
					p = p.AddField("sig_skipped_pct", float64(sigSkipped)/float64(len(nextBlock.ActiveSet)))
				}
			}

			if sigMissing > 0 {
				p = p.AddField("sig_missing", sigMissing)

				if len(nextBlock.ActiveSet) > 0 {
					p = p.AddField("sig_missing_pct", float64(sigMissing)/float64(len(nextBlock.ActiveSet)))
				}
			}

			if stdDev > 0 {
				p = p.AddField("sig_time_std_dev", stdDev)
			}

			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)
		}

		if authzUnpackings > 0 {
			metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
				s.Count("report.authz_unpackings", authzUnpackings, tagSpec)
			}, metricTags)
		}

		metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
			s.Timing("report.block_handler_dur", time.Since(handlerStart), tagSpec)
		}, metricTags)

		if len(pointsToWrite) > 0 {
			ctx, cancelFn := context.WithTimeout(
				context.Background(),
				1*time.Minute,
			)
			writeInfluxPoints(ctx, logger, influxWriteAPI, pointsToWrite, metricTags)
			cancelFn()

			influxPointsOutPace.StepN(len(pointsToWrite))
		}

		return nil
	}
}

var (
	// note that senderRegexp takes the first field having address value and ignores the name (not always `sender:"..."`)
	senderRegexp     = regexp.MustCompile(`message [^:]+:"(inj1[^"]+)"`)
	marketIDRegexp   = regexp.MustCompile(`market_id:"([^"]+)"`)
	subaccountRegexp = regexp.MustCompile(`subaccount_id:"([^"]+)"`)
)

// lastCommitRoundDuration returns the duration of the last commit round.
// It returns 0 if the last commit is not found or if the last commit is unknown.
func lastCommitRoundDuration(block *bfttypes.Block) time.Duration {
	if block.LastCommit == nil || len(block.LastCommit.Signatures) == 0 {
		return 0
	}

	var minTime, maxTime time.Time
	found := false

	for _, sig := range block.LastCommit.Signatures {
		if sig.BlockIDFlag == bfttypes.BlockIDFlagAbsent ||
			sig.BlockIDFlag == bfttypes.BlockIDFlagNil {
			continue
		}

		sigTime := sig.Timestamp

		if !found {
			minTime = sigTime
			maxTime = sigTime
			found = true
			continue
		}

		if sigTime.Before(minTime) {
			minTime = sigTime
		}
		if sigTime.After(maxTime) {
			maxTime = sigTime
		}
	}

	if !found {
		return 0
	}

	return maxTime.Sub(minTime)
}

// blockSignaturesStats returns the number of commit, nil and absent signatures in the last commit.
func blockSignaturesStats(block *bfttypes.Block) (ok, skipped, missing int) {
	if block.LastCommit == nil || len(block.LastCommit.Signatures) == 0 {
		return 0, 0, 0
	}

	for _, sig := range block.LastCommit.Signatures {
		switch sig.BlockIDFlag {
		case bfttypes.BlockIDFlagCommit:
			ok++
		case bfttypes.BlockIDFlagNil:
			skipped++
		case bfttypes.BlockIDFlagAbsent:
			missing++
		}
	}

	return ok, skipped, missing
}

func extractOrderFailureData(errMsg string) (sender string, marketID string, subaccountID string) {
	if matches := senderRegexp.FindStringSubmatch(errMsg); len(matches) > 1 {
		sender = matches[1]
	}
	if matches := marketIDRegexp.FindStringSubmatch(errMsg); len(matches) > 1 {
		marketID = matches[1]
	}
	if matches := subaccountRegexp.FindStringSubmatch(errMsg); len(matches) > 1 {
		subaccountID = matches[1]
	}
	return
}

func parseTxFeesBaseFeeEvent(event abci.Event) (sdkmath.LegacyDec, string, bool, error) {
	for _, attr := range event.Attributes {
		if attr.Key != txFeesBaseFeeAttrKey {
			continue
		}

		if attr.Value == "" {
			return sdkmath.LegacyDec{}, "", false, nil
		}

		baseFeeDec, err := sdkmath.LegacyNewDecFromStr(attr.Value)
		if err != nil {
			return sdkmath.LegacyDec{}, "", false, errors.Wrap(err, "invalid basefee value")
		}

		return baseFeeDec, attr.Value, true, nil
	}

	return sdkmath.LegacyDec{}, "", false, nil
}

type LastCommitMetricsPerValidator struct {
	Timestamp      time.Time
	IsProposer     bool
	Status         bfttypes.BlockIDFlag
	AbsoluteDelay  time.Duration
	RelativeDelay  time.Duration
	StdDevDistance float64
	ProposerDelay  *time.Duration // Only set for proposer, measures delay relative to earliest non-proposer signature
	ReactionTime   time.Duration  // Time since earliest non-proposer signature, zero for proposer and earliest signer
}

type ActiveSetValidator struct {
	Address  string
	Shares   float64
	Priority int64
}

type ValidtatorSigSortable struct {
	Timestamp time.Time
	Address   string
}

// computeSortedValidatorSigs returns a sorted slice of ValidtatorSigSortable
// containing validator signatures sorted by timestamp
func computeSortedValidatorSigs(block *bfttypes.Block) []ValidtatorSigSortable {
	if block.LastCommit == nil || len(block.LastCommit.Signatures) == 0 {
		return nil
	}

	sigs := make([]ValidtatorSigSortable, 0, len(block.LastCommit.Signatures))
	for _, sig := range block.LastCommit.Signatures {
		if sig.BlockIDFlag == bfttypes.BlockIDFlagAbsent ||
			sig.BlockIDFlag == bfttypes.BlockIDFlagNil {
			continue
		}

		// Convert validator address to hex string
		hexAddr := fmt.Sprintf("%X", sig.ValidatorAddress)
		sigs = append(sigs, ValidtatorSigSortable{
			Timestamp: sig.Timestamp,
			Address:   hexAddr,
		})
	}

	// Sort by timestamp
	sort.Slice(sigs, func(i, j int) bool {
		return sigs[i].Timestamp.Before(sigs[j].Timestamp)
	})

	return sigs
}

// computeRelativeDelays returns a map of validator addresses to their relative delays
// from the minimum timestamp in the sorted signatures slice
func computeRelativeDelays(sortedSigs []ValidtatorSigSortable) map[string]time.Duration {
	if len(sortedSigs) == 0 {
		return nil
	}

	minTime := sortedSigs[0].Timestamp
	relativeDelays := make(map[string]time.Duration, len(sortedSigs))

	for _, sig := range sortedSigs {
		delay := sig.Timestamp.Sub(minTime)
		relativeDelays[sig.Address] = delay
	}

	return relativeDelays
}

// computeStdDevOfDelays calculates the standard deviation of relative delays
// excluding zero delays (which correspond to the minimum timestamp signature)
func computeStdDevOfDelays(delays map[string]time.Duration) float64 {
	if len(delays) == 0 {
		return 0
	}

	// Convert delays to milliseconds and filter out zero delays
	var nonZeroDelays []float64
	for _, delay := range delays {
		if delay != 0 {
			nonZeroDelays = append(nonZeroDelays, float64(delay)/float64(time.Millisecond))
		}
	}

	if len(nonZeroDelays) == 0 || len(nonZeroDelays) == 1 {
		return 0
	}

	// Calculate mean
	var sum float64
	for _, delay := range nonZeroDelays {
		sum += delay
	}
	mean := sum / float64(len(nonZeroDelays))

	// Calculate variance
	var variance float64
	for _, delay := range nonZeroDelays {
		diff := delay - mean
		variance += diff * diff
	}
	variance = variance / float64(len(nonZeroDelays))

	// Return standard deviation
	return math.Sqrt(variance)
}

// computeStdDevDistance calculates how many standard deviations a given value
// is from the mean of the relative delays
func computeStdDevDistance(value time.Duration, stdDev float64, allValues map[string]time.Duration) float64 {
	if stdDev == 0 || len(allValues) == 0 {
		return 0
	}

	// Convert value to milliseconds
	valueMs := float64(value) / float64(time.Millisecond)

	// Calculate mean of non-zero values
	var sum float64
	var count int
	for _, v := range allValues {
		if v != 0 {
			sum += float64(v) / float64(time.Millisecond)
			count++
		}
	}

	if count == 0 {
		return 0
	}

	mean := sum / float64(count)

	// Calculate how many standard deviations the value is from the mean
	return (valueMs - mean) / stdDev
}

func lastCommitMetrics(
	block *bfttypes.Block,
	activeSet map[string]ActiveSetValidator,
) (map[string]LastCommitMetricsPerValidator, float64) {
	if block.LastCommit == nil || len(block.LastCommit.Signatures) == 0 {
		return nil, 0
	}

	metricsPerValidator := make(map[string]LastCommitMetricsPerValidator)
	proposerAddress := block.Header.ProposerAddress.String()

	// Get sorted validator signatures for timing analysis
	sortedSigs := computeSortedValidatorSigs(block)
	if len(sortedSigs) == 0 {
		return metricsPerValidator, 0
	}

	// Find earliest non-proposer signature time and address
	var earliestNonProposerTime *time.Time
	var earliestNonProposerAddr string
	for _, sig := range sortedSigs {
		if sig.Address != proposerAddress {
			t := sig.Timestamp
			earliestNonProposerTime = &t
			earliestNonProposerAddr = sig.Address
			break
		}
	}

	// Compute relative delays for each validator
	relativeDelays := computeRelativeDelays(sortedSigs)

	// Compute standard deviation of delays
	stdDev := computeStdDevOfDelays(relativeDelays)

	// Process each signature
	for _, sig := range block.LastCommit.Signatures {
		if sig.BlockIDFlag == bfttypes.BlockIDFlagAbsent {
			// no validator info, even address
			continue
		}

		valAddress := sig.ValidatorAddress.String()

		// Get relative delay for this validator
		relativeDelay := relativeDelays[valAddress]

		// Compute standard deviation distance
		stdDevDistance := computeStdDevDistance(relativeDelay, stdDev, relativeDelays)

		// Create metrics object
		metrics := LastCommitMetricsPerValidator{
			Timestamp:      sig.Timestamp,
			Status:         sig.BlockIDFlag,
			RelativeDelay:  relativeDelay,
			AbsoluteDelay:  sig.Timestamp.Sub(sortedSigs[0].Timestamp),
			StdDevDistance: stdDevDistance,
			IsProposer:     valAddress == proposerAddress,
		}

		// For proposer, compute delay relative to earliest non-proposer signature
		if valAddress == proposerAddress && earliestNonProposerTime != nil {
			proposerDelay := sig.Timestamp.Sub(*earliestNonProposerTime)
			metrics.ProposerDelay = &proposerDelay
			// Proposer has zero reaction time by definition
			metrics.ReactionTime = 0
		} else if earliestNonProposerTime != nil {
			// For non-proposers, compute reaction time relative to earliest non-proposer
			if valAddress == earliestNonProposerAddr {
				// Earliest non-proposer has zero reaction time
				metrics.ReactionTime = 0
			} else {
				// Everyone else's reaction time is their delay from earliest non-proposer
				metrics.ReactionTime = sig.Timestamp.Sub(*earliestNonProposerTime)
			}
		}

		metricsPerValidator[valAddress] = metrics
	}

	for _, val := range activeSet {
		if _, ok := metricsPerValidator[val.Address]; !ok {
			metricsPerValidator[val.Address] = LastCommitMetricsPerValidator{
				Status: bfttypes.BlockIDFlagAbsent,
			}
		}
	}

	return metricsPerValidator, stdDev
}

func writeInfluxPoints(
	ctx context.Context,
	logger log.Logger,
	writeAPI influxdb2api.WriteAPI,
	points []*influxwrite.Point,
	metricTags metrics.Tags,
) {
	defer metrics.ReportFuncTiming(metricTags)()

	defer func() {
		writeAPI.Flush()
	}()

	for _, point := range points {
		writeAPI.WritePoint(point)
	}
}
