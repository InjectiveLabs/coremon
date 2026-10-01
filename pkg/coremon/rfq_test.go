package coremon

import (
	"testing"
	"time"

	wasmtypes "github.com/CosmWasm/wasmd/x/wasm/types"
	bfttypes "github.com/cometbft/cometbft/types"
	"github.com/cosmos/cosmos-sdk/x/authz"
	"github.com/cosmos/gogoproto/proto"
	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxwrite "github.com/influxdata/influxdb-client-go/v2/api/write"

	wasmxtypes "github.com/InjectiveLabs/sdk-go/chain/wasmx/types"
)

func TestParseRFQMemo(t *testing.T) {
	cases := []struct {
		name     string
		memo     string
		format   string
		official bool
		source   string
		sentAtMs float64
	}{
		{name: "empty", memo: "", format: "none"},
		{
			name:     "web json with t",
			memo:     `{"m":"r3;c=w;h=1;i=tm4ol4;e=tm4otg;k=p1;a=inj1ntzp6egl4z6e7gfmvsc63mh8ee5h4m2xqhn3lk;s=8BUB","t":1790689206306.5}`,
			format:   "json",
			official: true,
			source:   "w",
			sentAtMs: 1790689206306.5,
		},
		{
			name:     "mobile bare token",
			memo:     "r3;c=m;h=1;i=tm4izu;e=tm4j86;k=p1;a=inj18z375n0taxkeh84m7p4fvg5r54kdnrs86qksgc;s=Lf2U",
			format:   "token",
			official: true,
			source:   "m",
		},
		{
			name:     "mobile json with t",
			memo:     `{"m":"r3;c=m;h=0;i=tm513d;e=tm51bp;k=p1;a=inj16n8psgw8g272hruar99dx8048ayjcqwd7fdpkc;s=mTBi","t":1790705353000}`,
			format:   "json",
			official: true,
			source:   "m",
			sentAtMs: 1790705353000,
		},
		{name: "unrelated memo", memo: "Ledger Live", format: "other"},
		{name: "unrelated json", memo: `{"foo":1}`, format: "other"},
		{name: "broken json", memo: `{"m":`, format: "other"},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			m := parseRFQMemo(tc.memo)
			if m.Format != tc.format || m.Official != tc.official || m.Source != tc.source {
				t.Fatalf("got %+v", m)
			}

			if tc.sentAtMs == 0 {
				if !m.SentAt.IsZero() {
					t.Fatalf("unexpected SentAt %v", m.SentAt)
				}
				return
			}

			if got := float64(m.SentAt.UnixMicro()) / 1000; got != tc.sentAtMs {
				t.Fatalf("SentAt ms: got %v, want %v", got, tc.sentAtMs)
			}
		})
	}
}

func TestClassifyRFQError(t *testing.T) {
	cases := []struct {
		text  string
		class string
		key   string
		stale bool
	}{
		{
			text:  `failed to execute message; message index: 0: kind: Other, error: No quote was filled: [0] inj10ecjqkt0hplsyeksysrt8ypfj5tu6vp5d86p6e: kind: Other, error: quote expired at ts=1790691647310, current=1790691647386: execute wasm contract failed`,
			class: "stale", key: "quote_expired", stale: true,
		},
		{
			text:  `failed to execute message; message index: 0: failed to execute message; message sender:"inj1xah26mtc37j3rt5rd3u8heg07rhvhjr64l9u5g" contract:"inj12stwq95jet57edcu4a65r48r46s9rzrs938n8k" msg:"{\"accept_quote\": {\"rfq_id\": 1, \"worst_price\": \"1\", \"note\": \"quote price is worse than worst_price\"}}" : kind: Other, error: nonce outside window [current_time-60000ms; current_time+60000ms] or [1790689824767; 1790689944767]: execute wasm contract failed`,
			class: "stale", key: "rfq_id_outside_window", stale: true,
		},
		{text: "nonce too old (< 60s)", class: "stale", key: "maker_nonce_too_old", stale: true},
		{text: "signed intent deadline 10 has passed at 20", class: "stale", key: "intent_deadline_passed", stale: true},
		{text: "nonce already used", class: "replay", key: "nonce_already_used"},
		{text: "No quote was filled: [0] inj1x: quote price 1 is outside mark price band [1, 2], current mark price: 1", class: "price", key: "mark_price_band"},
		{text: "No quote was filled: [0] inj1x: fill below maker min_fill_quantity", class: "fill", key: "maker_min_fill"},
		{text: "No quote was filled: none", class: "fill", key: "no_quote_filled"},
		{text: "Maker missing AuthZ grant for /cosmos.bank.v1beta1.MsgSend", class: "authz", key: "maker_authz_grant"},
		{text: "eip712 signature verification failed", class: "signature", key: "invalid_signature"},
		{text: "taker isolated position margin ratio 0.01 is below required threshold 0.05", class: "margin", key: "margin_below_required"},
		{
			text:  `failed to execute message; message index: 0: failed to execute message; message sender:"inj1gtdg7svek9w5zppu4u4j5qm5wge0jl87936h7e" contract:"inj1tkjjpav9mvxl2uaek0khkv2hu9mrmqp6a37e57" msg:"{\"atomic_exec\":{}}" funds:<denom:"inj" amount:"1" > : reply: atomic order partially filled: expected 0.035, actual 1000000000000000: execute wasm contract failed`,
			class: "proxy", key: "atomic_order_partial_fill",
		},
		{text: "something completely different", class: "other", key: "unknown"},
	}

	for _, tc := range cases {
		got := classifyRFQError(tc.text)
		if got.Class != tc.class || got.Key != tc.key || got.Stale != tc.stale {
			t.Errorf("%q: got %+v, want %s/%s stale=%v", tc.text, got, tc.class, tc.key, tc.stale)
		}
	}

	if got := classifyRFQTxFailure("sdk", 11, "out of gas"); got.Class != "sdk" || got.Key != "sdk:11" {
		t.Errorf("non-wasm failure: got %+v", got)
	}
}

func TestWasmErrorTemplate(t *testing.T) {
	cases := map[string]string{
		`failed to execute message; message index: 0: kind: Other, error: No quote was filled: [0] inj10ecjqkt0hplsyeksysrt8ypfj5tu6vp5d86p6e: kind: Other, error: quote expired at ts=1790691647310, current=1790691647386: execute wasm contract failed`:                                                        "quote expired at ts=N, current=N",
		`failed to execute message; message index: 0: failed to execute msg: reply: dispatch: reply: Minimum receive amount not met. Minimum: 100, Received: 99: execute wasm contract failed`:                                                                                                                    "Minimum receive amount not met. Minimum: N, Received: N",
		`failed to execute message; message index: 0: failed to execute message; message sender:"inj1zzzzzzzzxda5uu4vlhp3c8qa4ee4q7e7tppxw9" contract:"inj18hllkv88dp3jnpjamgslp5ez6u8az3q4s0lkxf" msg:"{\"execute_route\":{}}" funds:<denom:"inj" amount:"100" > : Assertion fail: execute wasm contract failed`: "Assertion fail",
		`failed to execute message; message index: 0: Invalid single sided strategy, only quote allowed: execute wasm contract failed`:                                                                                                                                                                            "Invalid single sided strategy, only quote allowed",
	}

	for in, want := range cases {
		if got := wasmErrorTemplate(in); got != want {
			t.Errorf("got %q, want %q", got, want)
		}
	}
}

func TestBlockTimeCache(t *testing.T) {
	base := time.UnixMilli(1790689200000)
	c := newBlockTimeCache(5)
	for h := int64(100); h < 110; h++ {
		c.Add(h, base.Add(time.Duration(h-100)*time.Second))
	}

	// only 105..109 retained
	if c.Covers(base.Add(4500 * time.Millisecond)) {
		t.Fatal("expected no coverage before the oldest retained block")
	}

	h, ok := c.FloorHeight(base.Add(6500 * time.Millisecond))
	if !ok || h != 106 {
		t.Fatalf("floor: got %d %v", h, ok)
	}

	// backward direction: prepend, trim the high end
	r := newBlockTimeCache(5)
	for h := int64(109); h >= 100; h-- {
		r.Add(h, base.Add(time.Duration(h-100)*time.Second))
	}
	if lowest, _ := r.Lowest(); lowest != 100 {
		t.Fatalf("lowest: got %d", lowest)
	}
	if h, ok := r.FloorHeight(base.Add(3500 * time.Millisecond)); !ok || h != 103 {
		t.Fatalf("reverse floor: got %d %v", h, ok)
	}
	if !r.Covers(base) || r.Covers(base.Add(-time.Second)) {
		t.Fatal("unexpected coverage")
	}

	// non-contiguous height resets the cache
	c.Add(50, base)
	if h, ok := c.FloorHeight(base.Add(time.Hour)); !ok || h != 50 {
		t.Fatalf("after reset: got %d %v", h, ok)
	}
}

func testBlock(height int64, ts time.Time) NewBlockData {
	return NewBlockData{Block: &bfttypes.Block{Header: bfttypes.Header{Height: height, Time: ts}}}
}

func pointFields(p *influxwrite.Point) map[string]any {
	fields := map[string]any{}
	for _, f := range p.FieldList() {
		fields[f.Key] = f.Value
	}

	return fields
}

func TestRFQTrackerBlocksMissed(t *testing.T) {
	base := time.UnixMilli(1790689200000)
	blockAt := func(h int64) time.Time { return base.Add(time.Duration(h-100) * time.Second) }

	newPending := func(tr *rfqTracker) {
		// tx included in block 109, signed at 106.5 -> target block 107 -> 2 blocks missed
		tr.pending = append(tr.pending, &rfqPendingPoint{
			point:   influxdb2.NewPointWithMeasurement(rfqTxsMeasurement),
			height:  109,
			missing: []rfqMissedField{{field: "memo_blocks_missed", ts: blockAt(106).Add(500 * time.Millisecond)}},
		})
	}

	t.Run("forward", func(t *testing.T) {
		tr := newRFQTracker(RFQConfig{})
		for h := int64(101); h <= 109; h++ {
			tr.ObserveBlocks(testBlock(h-1, blockAt(h-1)), testBlock(h, blockAt(h)))
		}

		newPending(tr)
		ready := tr.Flush()
		if len(ready) != 1 || pointFields(ready[0])["memo_blocks_missed"] != int64(2) {
			t.Fatalf("got %d points", len(ready))
		}
	})

	t.Run("forward, timestamp before cache", func(t *testing.T) {
		tr := newRFQTracker(RFQConfig{})
		tr.ObserveBlocks(testBlock(108, blockAt(108)), testBlock(109, blockAt(109)))

		newPending(tr)
		ready := tr.Flush()
		if len(ready) != 1 {
			t.Fatalf("expected point to be flushed without blocks missed, got %d", len(ready))
		}
		if _, ok := pointFields(ready[0])["memo_blocks_missed"]; ok {
			t.Fatal("unexpected memo_blocks_missed")
		}
	})

	t.Run("reverse", func(t *testing.T) {
		tr := newRFQTracker(RFQConfig{Reverse: true})
		tr.ObserveBlocks(testBlock(108, blockAt(108)), testBlock(109, blockAt(109)))

		newPending(tr)
		if ready := tr.Flush(); len(ready) != 0 {
			t.Fatal("expected point to wait for earlier blocks")
		}

		tr.ObserveBlocks(testBlock(107, blockAt(107)), testBlock(108, blockAt(108)))
		if ready := tr.Flush(); len(ready) != 0 {
			t.Fatal("expected point to still wait")
		}

		tr.ObserveBlocks(testBlock(106, blockAt(106)), testBlock(107, blockAt(107)))
		ready := tr.Flush()
		if len(ready) != 1 || pointFields(ready[0])["memo_blocks_missed"] != int64(2) {
			t.Fatalf("got %d points", len(ready))
		}
	})

	t.Run("reverse, timestamp below stop height", func(t *testing.T) {
		// handling block 108 (with previous 107) is the last step when stopping at 108
		tr := newRFQTracker(RFQConfig{Reverse: true, StopHeight: 108})
		tr.ObserveBlocks(testBlock(108, blockAt(108)), testBlock(109, blockAt(109)))

		newPending(tr)
		if ready := tr.Flush(); len(ready) != 0 {
			t.Fatal("expected point to wait for earlier blocks")
		}

		tr.ObserveBlocks(testBlock(107, blockAt(107)), testBlock(108, blockAt(108)))
		ready := tr.Flush()
		if len(ready) != 1 {
			t.Fatalf("expected point flushed at stop height, got %d", len(ready))
		}
		if _, ok := pointFields(ready[0])["memo_blocks_missed"]; ok {
			t.Fatal("unexpected memo_blocks_missed")
		}
	})
}

func TestStaleLateBy(t *testing.T) {
	cases := []struct {
		text  string
		rfqID uint64
		want  time.Duration
		ok    bool
	}{
		{
			text: "No quote was filled: [0] inj1a: quote expired at ts=1790691647310, current=1790691647386",
			want: 76 * time.Millisecond, ok: true,
		},
		{
			// the least late of several expired quotes
			text: "[0] a: quote expired at ts=1000, current=5000; [1] b: quote expired at ts=4000, current=5000",
			want: time.Second, ok: true,
		},
		{
			text:  "nonce outside window [current_time-60000ms; current_time+60000ms] or [1790689824767; 1790689944767]",
			rfqID: 1790689687767,
			want:  137 * time.Second, ok: true,
		},
		{
			text:  "nonce outside window [current_time-60000ms; current_time+60000ms] or [1000; 2000]",
			rfqID: 2500,
			want:  -500 * time.Millisecond, ok: true,
		},
		{text: "signed intent deadline 1000 has passed at 1250", want: 250 * time.Millisecond, ok: true},
		{text: "nonce too old (< 60s)"},
		{text: "nonce outside window [..] or [1000; 2000]"},
	}

	for _, tc := range cases {
		got, ok := staleLateBy(tc.text, tc.rfqID)
		if ok != tc.ok || got != tc.want {
			t.Errorf("%q: got %v %v, want %v %v", tc.text, got, ok, tc.want, tc.ok)
		}
	}
}

func TestFindRFQTx(t *testing.T) {
	cfg := NewRFQConfig(DefaultRFQContracts, DefaultRFQProxyContracts)
	taker := "inj1qjdzrhjva5pq2zrjdxe3pt826ujucl4r0mvf6w"

	cases := []struct {
		name   string
		msgs   []proto.Message
		ok     bool
		kind   string
		rfqID  int64
		quotes int
	}{
		{
			name: "direct accept_quote",
			msgs: []proto.Message{&wasmtypes.MsgExecuteContract{
				Sender:   taker,
				Contract: DefaultRFQContracts,
				Msg:      []byte(`{"accept_quote": {"rfq_id": 1790692938007, "quotes": [{"maker": "a"}, {"maker": "b"}]}}`),
			}},
			ok: true, kind: "accept_quote", rfqID: 1790692938007, quotes: 2,
		},
		{
			name: "wasmx compat accept_quote",
			msgs: []proto.Message{&wasmxtypes.MsgExecuteContractCompat{
				Sender:   taker,
				Contract: DefaultRFQContracts,
				Msg:      `{"accept_quote":{"rfq_id":1790692938007,"quotes":[{}]}}`,
				Funds:    "0",
			}},
			ok: true, kind: "accept_quote", rfqID: 1790692938007, quotes: 1,
		},
		{
			name: "atomic proxy",
			msgs: []proto.Message{&wasmtypes.MsgExecuteContract{
				Sender:   taker,
				Contract: DefaultRFQProxyContracts,
				Msg:      []byte(`{"atomic_exec":{"orders":{"atomic_order":{"cid":"atomic-1"},"rfq_trade":{"contract":"x","accept_quote":{"rfq_id":1790693332884,"quotes":[{}]}}}}}`),
			}},
			ok: true, kind: "atomic_exec", rfqID: 1790693332884, quotes: 1,
		},
		{
			name: "signed intent uses quote_rfq_id only",
			msgs: []proto.Message{&wasmtypes.MsgExecuteContract{
				Sender:   taker,
				Contract: DefaultRFQContracts,
				Msg:      []byte(`{"accept_signed_intent":{"intent":{"rfq_id":1000},"quotes":[],"quote_rfq_id":1790693332884}}`),
			}},
			ok: true, kind: "signed_intent", rfqID: 1790693332884,
		},
		{
			name: "admin msg ignored",
			msgs: []proto.Message{&wasmtypes.MsgExecuteContract{
				Sender:   taker,
				Contract: DefaultRFQContracts,
				Msg:      []byte(`{"update_config":{}}`),
			}},
		},
		{
			name: "other contract ignored",
			msgs: []proto.Message{&wasmtypes.MsgExecuteContract{
				Sender:   taker,
				Contract: "inj1other",
				Msg:      []byte(`{"accept_quote":{"rfq_id":1790692938007}}`),
			}},
		},
		{
			name: "non-wasm msg ignored",
			msgs: []proto.Message{&authz.MsgExec{}},
		},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			info, ok := findRFQTx(cfg, tc.msgs)
			if ok != tc.ok {
				t.Fatalf("ok: got %v", ok)
			}
			if !ok {
				return
			}

			if info.Kind != tc.kind || info.Taker != taker || info.Quotes != tc.quotes {
				t.Fatalf("got %+v", info)
			}
			if info.RequestedAt.UnixMilli() != tc.rfqID {
				t.Fatalf("rfq_id: got %d, want %d", info.RequestedAt.UnixMilli(), tc.rfqID)
			}
		})
	}
}

func TestLatencyBucketSortsLexically(t *testing.T) {
	durations := []time.Duration{
		-time.Second, 0, 1500 * time.Millisecond, 2500 * time.Millisecond, 4 * time.Second,
		7 * time.Second, 20 * time.Second, 45 * time.Second, 5 * time.Minute,
	}

	for i := 1; i < len(durations); i++ {
		prev, next := latencyBucket(durations[i-1]), latencyBucket(durations[i])
		if prev >= next {
			t.Fatalf("buckets not lexically ordered: %q >= %q", prev, next)
		}
	}
}
