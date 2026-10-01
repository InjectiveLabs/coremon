package coremon

import (
	"fmt"
	"strconv"
	"time"

	abci "github.com/cometbft/cometbft/abci/types"
	sdktypes "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/gogoproto/proto"
	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxwrite "github.com/influxdata/influxdb-client-go/v2/api/write"
	metrics "github.com/xlab/statsd_metrics"
)

// RFQ measurements, the only ones written in RFQ-only mode.
const (
	rfqTxsMeasurement     = "coremon_rfq_txs"
	rfqQuotesMeasurement  = "coremon_rfq_quotes"
	wasmErrorsMeasurement = "coremon_wasm_errors"
)

// rfqPendingPoint is an RFQ tx point waiting for block times at or before its client timestamps
// to be known, which happens later when blocks are processed in backward direction.
type rfqPendingPoint struct {
	point   *influxwrite.Point
	height  int64
	missing []rfqMissedField
}

type rfqMissedField struct {
	field string
	ts    time.Time
}

// rfqTracker produces RFQ and WASM error points, keeping recent block times to compute
// how many blocks were missed between the client timestamps and the tx inclusion.
type rfqTracker struct {
	cfg        RFQConfig
	blockTimes *blockTimeCache
	pending    []*rfqPendingPoint
}

func newRFQTracker(cfg RFQConfig) *rfqTracker {
	return &rfqTracker{
		cfg:        cfg,
		blockTimes: newBlockTimeCache(blockTimeCacheSize),
	}
}

// ObserveBlocks records block times of the handled pair (the previous block is known too).
func (t *rfqTracker) ObserveBlocks(prevBlock, nextBlock NewBlockData) {
	if t.cfg.Reverse {
		t.blockTimes.Add(nextBlock.Block.Height, nextBlock.Block.Time)
		t.blockTimes.Add(prevBlock.Block.Height, prevBlock.Block.Time)
		return
	}

	t.blockTimes.Add(prevBlock.Block.Height, prevBlock.Block.Time)
	t.blockTimes.Add(nextBlock.Block.Height, nextBlock.Block.Time)
}

// Flush returns pending points that can be completed now. In forward direction (or when the
// timestamp is too far behind the tx) blocks missed is left unset.
func (t *rfqTracker) Flush() []*influxwrite.Point {
	if len(t.pending) == 0 {
		return nil
	}

	lowest, hasLowest := t.blockTimes.Lowest()

	// in backward direction, earlier blocks keep coming until the stop height is reached
	canGoLower := t.cfg.Reverse && hasLowest && (t.cfg.StopHeight == 0 || lowest >= int64(t.cfg.StopHeight))

	var ready []*influxwrite.Point
	kept := t.pending[:0]

	for _, pp := range t.pending {
		missing := pp.missing[:0]

		for _, mf := range pp.missing {
			if t.blockTimes.Covers(mf.ts) {
				if floor, ok := t.blockTimes.FloorHeight(mf.ts); ok {
					pp.point = pp.point.AddField(mf.field, pp.height-(floor+1))
				}
				continue
			}

			// can still be resolved only when going backward and within the cache window
			if canGoLower && pp.height-lowest < blockTimeCacheSize {
				missing = append(missing, mf)
			}
		}

		pp.missing = missing
		if len(pp.missing) == 0 {
			ready = append(ready, pp.point)
			continue
		}

		kept = append(kept, pp)
	}

	t.pending = kept

	return ready
}

// TxPoints produces points of a single tx. RFQ tx points could be deferred until Flush.
func (t *rfqTracker) TxPoints(
	block NewBlockData,
	txIndex int,
	txResult *abci.ExecTxResult,
	tx sdktypes.Tx,
	msgs []proto.Message,
	baseTags metrics.Tags,
) []*influxwrite.Point {
	var points []*influxwrite.Point

	height := block.Block.Height
	blockTime := block.Block.Time
	txID := fmt.Sprintf("%d_%d", height, txIndex)

	// InfluxDB dedups points with identical measurement, tags and timestamp, so points get a unique
	// sub-microsecond offset from block time (tx index, then quote index) to keep counts exact.
	txTime := blockTime.Add(time.Duration(txIndex) * time.Microsecond)

	addBaseTags := func(p *influxwrite.Point) *influxwrite.Point {
		baseTags.Range(func(k, v string) bool {
			p = p.AddTag(k, v)
			return false
		})

		return p
	}

	rfqInfo, isRFQ := findRFQTx(t.cfg, msgs)

	var memo rfqMemo
	if isRFQ {
		var memoText string
		if txWithMemo, ok := tx.(sdktypes.TxWithMemo); ok {
			memoText = txWithMemo.GetMemo()
		}

		memo = parseRFQMemo(memoText)
	}

	addMemoTags := func(p *influxwrite.Point) *influxwrite.Point {
		p = p.AddTag("official", strconv.FormatBool(memo.Official))
		if memo.Source != "" {
			p = p.AddTag("source", memo.Source)
		}

		return p
	}

	failed := txResult.Code != 0

	if failed && txResult.Codespace == "wasm" {
		contract, method, _ := firstWasmExec(msgs)

		p := influxdb2.NewPointWithMeasurement(wasmErrorsMeasurement)
		p = p.SetTime(txTime)
		p = p.AddField("height", height)
		p = p.AddField("count", 1)
		p = p.AddField("tx_id", txID)
		p = p.AddTag("contract", contract)
		p = p.AddTag("method", method)
		p = p.AddTag("err_tpl", wasmErrorTemplate(txResult.Log))
		p = p.AddTag("rfq", strconv.FormatBool(isRFQ))

		if isRFQ {
			rErr := classifyRFQError(txResult.Log)
			p = addMemoTags(p)
			p = p.AddTag("err_class", rErr.Class)
			p = p.AddTag("err", rErr.Key)
		}

		points = append(points, addBaseTags(p))
	}

	if !isRFQ {
		return points
	}

	p := influxdb2.NewPointWithMeasurement(rfqTxsMeasurement)
	p = p.SetTime(txTime)
	p = p.AddField("height", height)
	p = p.AddField("count", 1)
	p = p.AddField("tx_id", txID)
	p = addMemoTags(p)
	p = p.AddTag("memo_fmt", memo.Format)
	p = p.AddTag("kind", rfqInfo.Kind)
	p = p.AddTag("taker", rfqInfo.Taker)

	if rfqInfo.Quotes > 0 {
		p = p.AddField("quotes", rfqInfo.Quotes)
	}

	var missing []rfqMissedField

	// latency of the "best" (closest to signing) timestamp available decides the bucket
	var (
		bestLatency time.Duration
		bestSource  = "none"
	)

	if !rfqInfo.RequestedAt.IsZero() {
		latency := blockTime.Sub(rfqInfo.RequestedAt)
		p = p.AddField("rfq_id_latency_ms", durationMs(latency))
		missing = append(missing, rfqMissedField{field: "rfq_id_blocks_missed", ts: rfqInfo.RequestedAt})

		bestLatency, bestSource = latency, "rfq_id"
	}

	if !memo.SentAt.IsZero() {
		latency := blockTime.Sub(memo.SentAt)
		p = p.AddField("memo_latency_ms", durationMs(latency))
		missing = append(missing, rfqMissedField{field: "memo_blocks_missed", ts: memo.SentAt})

		if !rfqInfo.RequestedAt.IsZero() {
			// deviation of the two client timestamps, only when both are set.
			// Positive: memo t stamped after the RFQ request (quotes collection, user confirmation).
			// Negative: rfq_id assigned after t (re-quote after t was stamped).
			p = p.AddField("t_minus_rfq_id_ms", durationMs(memo.SentAt.Sub(rfqInfo.RequestedAt)))
		}

		bestLatency, bestSource = latency, "memo"
	}

	p = p.AddTag("ts_src", bestSource)
	if bestSource != "none" {
		p = p.AddTag("lat_bucket", latencyBucket(bestLatency))
	}

	if failed {
		rErr := classifyRFQTxFailure(txResult.Codespace, txResult.Code, txResult.Log)
		p = p.AddTag("status", "failed")
		p = p.AddTag("err_class", rErr.Class)
		p = p.AddTag("err", rErr.Key)
		p = p.AddField("error", 1)

		if rErr.Stale {
			p = p.AddField("stale", 1)

			if lateBy, ok := staleLateBy(txResult.Log, rfqInfo.RFQID); ok {
				p = p.AddField("late_by_ms", durationMs(lateBy))
			}
		}
	} else {
		p = p.AddTag("status", "ok")
		p = p.AddTag("err_class", "none")
		p = p.AddTag("err", "none")
		p = p.AddField("ok", 1)
	}

	quoteResults := parseRFQQuoteResults(txResult.Events)
	var quotesRejected, quotesStale int

	for qIdx, qr := range quoteResults {
		qp := influxdb2.NewPointWithMeasurement(rfqQuotesMeasurement)
		qp = qp.SetTime(txTime.Add(time.Duration(qIdx) * time.Nanosecond))
		qp = qp.AddField("height", height)
		qp = qp.AddField("count", 1)
		qp = qp.AddField("tx_id", txID)
		qp = qp.AddField("quote_idx", qIdx)
		qp = addMemoTags(qp)
		qp = qp.AddTag("kind", rfqInfo.Kind)
		qp = qp.AddTag("maker", qr.Maker)

		if qr.E != nil {
			rErr := classifyRFQError(*qr.E)
			quotesRejected++

			qp = qp.AddTag("result", "rejected")
			qp = qp.AddTag("err_class", rErr.Class)
			qp = qp.AddTag("err", rErr.Key)
			qp = qp.AddField("rejected", 1)

			if rErr.Stale {
				quotesStale++
				qp = qp.AddField("stale", 1)

				if lateBy, ok := staleLateBy(*qr.E, rfqInfo.RFQID); ok {
					qp = qp.AddField("late_by_ms", durationMs(lateBy))
				}
			}
		} else {
			qp = qp.AddTag("result", "filled")
			qp = qp.AddTag("err_class", "none")
			qp = qp.AddTag("err", "none")
			qp = qp.AddField("filled", 1)
		}

		if bestSource != "none" {
			qp = qp.AddTag("lat_bucket", latencyBucket(bestLatency))
		}

		points = append(points, addBaseTags(qp))
	}

	if len(quoteResults) > 0 {
		p = p.AddField("quotes_rejected", quotesRejected)
		p = p.AddField("quotes_filled", len(quoteResults)-quotesRejected)

		if quotesStale > 0 {
			p = p.AddField("quotes_stale", quotesStale)
		}
	}

	t.pending = append(t.pending, &rfqPendingPoint{
		point:   addBaseTags(p),
		height:  height,
		missing: missing,
	})

	return points
}

func durationMs(d time.Duration) float64 {
	return float64(d) / float64(time.Millisecond)
}
