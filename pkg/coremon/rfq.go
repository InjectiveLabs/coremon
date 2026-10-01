package coremon

import (
	"encoding/json"
	"fmt"
	"regexp"
	"sort"
	"strconv"
	"strings"
	"time"

	wasmtypes "github.com/CosmWasm/wasmd/x/wasm/types"
	abci "github.com/cometbft/cometbft/abci/types"
	"github.com/cosmos/gogoproto/proto"

	wasmxtypes "github.com/InjectiveLabs/sdk-go/chain/wasmx/types"
)

// Default mainnet RFQ deployment. Can be overridden via CLI options.
const (
	DefaultRFQContracts      = "inj12stwq95jet57edcu4a65r48r46s9rzrs938n8k"
	DefaultRFQProxyContracts = "inj1tkjjpav9mvxl2uaek0khkv2hu9mrmqp6a37e57"

	rfqAcceptQuoteEventType = "wasm-rfq-accept-quote"

	// blockTimeCacheSize keeps ~1h of blocks, enough to resolve stale rfq_id nonces
	// that the contract rejects with "nonce outside window" (±60s..120s).
	blockTimeCacheSize = 3600
)

type RFQConfig struct {
	// Reverse is set when blocks are processed in backward direction.
	Reverse bool
	// StopHeight is the lowest height processed in backward direction (0 = genesis).
	StopHeight uint64

	// Contracts is the set of RFQ settlement contracts (accept_quote / accept_signed_intent).
	Contracts map[string]struct{}
	// ProxyContracts is the set of contracts that wrap an RFQ accept_quote (e.g. atomic RFQ proxy).
	ProxyContracts map[string]struct{}
}

func NewRFQConfig(contracts, proxyContracts string) RFQConfig {
	return RFQConfig{
		Contracts:      parseAddrSet(contracts),
		ProxyContracts: parseAddrSet(proxyContracts),
	}
}

func parseAddrSet(s string) map[string]struct{} {
	set := make(map[string]struct{})
	for _, addr := range strings.Split(s, ",") {
		if addr = strings.TrimSpace(addr); addr != "" {
			set[addr] = struct{}{}
		}
	}

	return set
}

// blockTimeCache keeps recent (height, time) pairs sorted by height, used to find the latest
// block that was already committed at the moment a tx has been signed / requested.
type blockTimeCache struct {
	heights []int64
	times   []time.Time
	size    int
}

func newBlockTimeCache(size int) *blockTimeCache {
	return &blockTimeCache{size: size}
}

// Add records a block time. Blocks may come in forward or backward order, the cache keeps
// the most recently added contiguous range.
func (c *blockTimeCache) Add(height int64, t time.Time) {
	n := len(c.heights)

	switch {
	case n == 0:
		c.heights = append(c.heights, height)
		c.times = append(c.times, t)
	case height >= c.heights[0] && height <= c.heights[n-1]:
		// already known
		return
	case height == c.heights[n-1]+1:
		c.heights = append(c.heights, height)
		c.times = append(c.times, t)

		if len(c.heights) > c.size {
			drop := len(c.heights) - c.size
			c.heights = append(c.heights[:0], c.heights[drop:]...)
			c.times = append(c.times[:0], c.times[drop:]...)
		}
	case height == c.heights[0]-1:
		c.heights = append([]int64{height}, c.heights...)
		c.times = append([]time.Time{t}, c.times...)

		if len(c.heights) > c.size {
			c.heights = c.heights[:c.size]
			c.times = c.times[:c.size]
		}
	default:
		// non-contiguous (restart), start over
		c.heights = append(c.heights[:0], height)
		c.times = append(c.times[:0], t)
	}
}

// Covers reports whether the cache reaches back to ts, i.e. FloorHeight(ts) is final.
func (c *blockTimeCache) Covers(ts time.Time) bool {
	return len(c.times) > 0 && !c.times[0].After(ts)
}

// Lowest returns the lowest cached height.
func (c *blockTimeCache) Lowest() (int64, bool) {
	if len(c.heights) == 0 {
		return 0, false
	}

	return c.heights[0], true
}

// FloorHeight returns the latest cached block with time <= ts. Returns false when the cache
// doesn't reach back to ts, so the answer would be ambiguous.
func (c *blockTimeCache) FloorHeight(ts time.Time) (int64, bool) {
	idx := sort.Search(len(c.times), func(i int) bool {
		return c.times[i].After(ts)
	})
	if idx == 0 {
		return 0, false
	}

	return c.heights[idx-1], true
}

// rfqMemo is the taker memo attached by the official RFQ clients (web frontend and mobile).
//
// Formats observed on mainnet:
//
//	mobile: r3;c=m;h=1;i=<issued, base36 unix s>;e=<expires, base36 unix s>;k=p1;a=<taker>;s=<sig>
//	web:    {"m":"r3;c=w;...","t":<unix ms when tx was signed, float>}
//
// The r3 token is issued by the RFQ backend and reused for its lifetime (5min), so only
// the "t" field of the JSON wrapper is a per-tx timestamp (any source may add it).
type rfqMemo struct {
	Format   string // none | token | json | other
	Official bool
	Source   string // raw c= value of the token: w (web), m (mobile), empty if unknown
	SentAt   time.Time
}

var rfqTokenRegexp = regexp.MustCompile(`^r\d+;`)

func parseRFQMemo(memo string) rfqMemo {
	memo = strings.TrimSpace(memo)
	if memo == "" {
		return rfqMemo{Format: "none"}
	}

	token := memo
	res := rfqMemo{Format: "token"}

	if strings.HasPrefix(memo, "{") {
		var wrapped struct {
			M string          `json:"m"`
			T json.RawMessage `json:"t"`
		}
		if err := json.Unmarshal([]byte(memo), &wrapped); err != nil {
			return rfqMemo{Format: "other"}
		}

		token = wrapped.M
		res.Format = "json"

		if ms, err := strconv.ParseFloat(string(wrapped.T), 64); err == nil && ms > 0 {
			res.SentAt = time.UnixMicro(int64(ms * 1000))
		}
	}

	if !rfqTokenRegexp.MatchString(token) {
		return rfqMemo{Format: "other"}
	}

	res.Official = true

	for _, kv := range strings.Split(token, ";") {
		if v, ok := strings.CutPrefix(kv, "c="); ok {
			res.Source = v
		}
	}

	return res
}

// rfqTxInfo describes the RFQ action found in a tx.
type rfqTxInfo struct {
	Kind     string // accept_quote | signed_intent | atomic_exec
	Taker    string
	Contract string
	// RequestedAt is derived from rfq_id: a ms timestamp nonce assigned by the RFQ gateway when the
	// request has been created, i.e. before quotes were collected and the user has confirmed.
	RequestedAt time.Time
	RFQID       uint64
	Quotes      int
}

type rfqAcceptArgs struct {
	RFQID  *uint64           `json:"rfq_id"`
	Quotes []json.RawMessage `json:"quotes"`
}

type rfqSignedIntentArgs struct {
	QuoteRFQID *uint64           `json:"quote_rfq_id"`
	Quotes     []json.RawMessage `json:"quotes"`
}

// findRFQTx returns the first RFQ action in the (authz-unwrapped) tx messages.
func findRFQTx(cfg RFQConfig, msgs []proto.Message) (rfqTxInfo, bool) {
	for _, msg := range msgs {
		var sender, contract string
		var payload []byte

		switch m := msg.(type) {
		case *wasmtypes.MsgExecuteContract:
			sender, contract, payload = m.Sender, m.Contract, m.Msg
		case *wasmxtypes.MsgExecuteContractCompat:
			sender, contract, payload = m.Sender, m.Contract, []byte(m.Msg)
		default:
			continue
		}

		_, isRFQ := cfg.Contracts[contract]
		_, isProxy := cfg.ProxyContracts[contract]
		if !isRFQ && !isProxy {
			continue
		}

		var top map[string]json.RawMessage
		if err := json.Unmarshal(payload, &top); err != nil {
			continue
		}

		info := rfqTxInfo{
			Taker:    sender,
			Contract: contract,
		}

		if isProxy {
			info.Kind = "atomic_exec"
			if raw, ok := findJSONKey(payload, "accept_quote", 6); ok {
				info.fillFromAcceptQuote(raw)
			}

			return info, true
		}

		if raw, ok := top["accept_quote"]; ok {
			info.Kind = "accept_quote"
			info.fillFromAcceptQuote(raw)

			return info, true
		}

		if raw, ok := top["accept_signed_intent"]; ok {
			info.Kind = "signed_intent"

			// intent.rfq_id is set when the intent is signed (could be long before the trigger fires),
			// only quote_rfq_id reflects the moment of execution.
			var args rfqSignedIntentArgs
			if err := json.Unmarshal(raw, &args); err == nil {
				info.Quotes = len(args.Quotes)
				if args.QuoteRFQID != nil {
					info.RFQID = *args.QuoteRFQID
					info.RequestedAt = rfqIDToTime(*args.QuoteRFQID)
				}
			}

			return info, true
		}
	}

	return rfqTxInfo{}, false
}

func (info *rfqTxInfo) fillFromAcceptQuote(raw json.RawMessage) {
	var args rfqAcceptArgs
	if err := json.Unmarshal(raw, &args); err != nil {
		return
	}

	info.Quotes = len(args.Quotes)
	if args.RFQID != nil {
		info.RFQID = *args.RFQID
		info.RequestedAt = rfqIDToTime(*args.RFQID)
	}
}

// rfqIDToTime converts rfq_id (unix ms) into time, ignoring values that are not plausible timestamps.
func rfqIDToTime(rfqID uint64) time.Time {
	// 2020-01-01 .. 2100-01-01 in ms
	if rfqID < 1577836800000 || rfqID > 4102444800000 {
		return time.Time{}
	}

	return time.UnixMilli(int64(rfqID))
}

// findJSONKey does a bounded depth-first search for an object key in a JSON document.
func findJSONKey(doc []byte, key string, maxDepth int) (json.RawMessage, bool) {
	if maxDepth <= 0 {
		return nil, false
	}

	var obj map[string]json.RawMessage
	if err := json.Unmarshal(doc, &obj); err != nil {
		return nil, false
	}

	if raw, ok := obj[key]; ok {
		return raw, true
	}

	keys := make([]string, 0, len(obj))
	for k := range obj {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		if raw, ok := findJSONKey(obj[k], key, maxDepth-1); ok {
			return raw, true
		}
	}

	return nil, false
}

// rfqQuoteResult is an element of the "results" attribute of the accept quote event.
type rfqQuoteResult struct {
	Maker string  `json:"maker"`
	E     *string `json:"e,omitempty"`
}

func parseRFQQuoteResults(events []abci.Event) []rfqQuoteResult {
	var out []rfqQuoteResult

	for _, ev := range events {
		if ev.Type != rfqAcceptQuoteEventType {
			continue
		}

		for _, attr := range ev.Attributes {
			if attr.Key != "results" {
				continue
			}

			var results []rfqQuoteResult
			if err := json.Unmarshal([]byte(attr.Value), &results); err == nil {
				out = append(out, results...)
			}
		}
	}

	return out
}

// latencyBucket groups latency for correlation with error rates (tag-friendly, bounded cardinality).
// Labels sort lexically in latency order, as InfluxDB returns tag groups sorted by value.
func latencyBucket(d time.Duration) string {
	switch {
	case d < 0:
		return "-0s (clock skew)"
	case d < time.Second:
		return "00-01s"
	case d < 2*time.Second:
		return "01-02s"
	case d < 3*time.Second:
		return "02-03s"
	case d < 5*time.Second:
		return "03-05s"
	case d < 10*time.Second:
		return "05-10s"
	case d < 30*time.Second:
		return "10-30s"
	case d < 60*time.Second:
		return "30-60s"
	default:
		return "60s+"
	}
}

// rfqErr is a classified RFQ execution error.
type rfqErr struct {
	Class string // coarse group: stale, replay, price, fill, margin, funds, signature, authz, ...
	Key   string // fine-grained reason within the class
	Stale bool   // rejected because of time passed between request/sign and execution
}

type rfqErrPattern struct {
	re  *regexp.Regexp
	err rfqErr
}

// rfqErrPatterns are matched in order, most specific first. Errors are nested (e.g. "No quote was
// filled: [0] <maker>: ... quote expired at ts=..."), so the inner reason must win over the wrapper.
// Messages are taken from the RFQ contract (src/error.rs and handler/*).
var rfqErrPatterns = []rfqErrPattern{
	// stale: rejected because of latency between the request / quote and the block time
	{regexp.MustCompile(`quote expired`), rfqErr{"stale", "quote_expired", true}},
	{regexp.MustCompile(`nonce outside window`), rfqErr{"stale", "rfq_id_outside_window", true}},
	{regexp.MustCompile(`nonce too old`), rfqErr{"stale", "maker_nonce_too_old", true}},
	{regexp.MustCompile(`signed intent deadline \S+ has passed`), rfqErr{"stale", "intent_deadline_passed", true}},

	// clock skew
	{regexp.MustCompile(`nonce far into the future`), rfqErr{"clock", "nonce_in_future", false}},

	// replays / double submits
	{regexp.MustCompile(`nonce already used`), rfqErr{"replay", "nonce_already_used", false}},
	{regexp.MustCompile(`nonce too low`), rfqErr{"replay", "nonce_too_low", false}},
	{regexp.MustCompile(`quote duplicated`), rfqErr{"replay", "quote_duplicated", false}},
	{regexp.MustCompile(`Stale signed intent epoch`), rfqErr{"intent", "stale_epoch", false}},
	{regexp.MustCompile(`Stale signed intent lane version`), rfqErr{"intent", "stale_lane_version", false}},

	// signatures
	{regexp.MustCompile(`(?i)signature verification failed|signature recovery failed|invalid signature length|invalid pubkey|secp256k1 pubkey`), rfqErr{"signature", "invalid_signature", false}},

	// price
	{regexp.MustCompile(`outside mark price band`), rfqErr{"price", "mark_price_band", false}},
	{regexp.MustCompile(`is worse than worst_price`), rfqErr{"price", "worse_than_worst_price", false}},
	{regexp.MustCompile(`trigger not satisfied`), rfqErr{"price", "trigger_not_satisfied", false}},
	{regexp.MustCompile(`multiple of market minimum price tick`), rfqErr{"price", "price_tick", false}},

	// fill constraints
	{regexp.MustCompile(`below min_total_fill_quantity`), rfqErr{"fill", "min_total_fill", false}},
	{regexp.MustCompile(`fill below maker min_fill_quantity`), rfqErr{"fill", "maker_min_fill", false}},
	{regexp.MustCompile(`below market min_notional`), rfqErr{"fill", "min_notional", false}},
	{regexp.MustCompile(`below market minimum tick|multiple of market minimum quantity tick`), rfqErr{"fill", "quantity_tick", false}},
	{regexp.MustCompile(`reduce-only quantity`), rfqErr{"fill", "reduce_only_quantity", false}},
	{regexp.MustCompile(`insufficient balance to fill minimum quantity`), rfqErr{"funds", "maker_insufficient_balance", false}},

	// margin / funds
	{regexp.MustCompile(`margin ratio \S+ is below|IMR \S+ is below|IMR margin \S+ is below`), rfqErr{"margin", "margin_below_required", false}},
	{regexp.MustCompile(`(?i)insufficient (funds|balance|deposit)|spendable balance|exceeds (available|total) balance`), rfqErr{"funds", "insufficient_funds", false}},

	// maker setup
	{regexp.MustCompile(`AuthZ`), rfqErr{"authz", "maker_authz_grant", false}},
	{regexp.MustCompile(`Maker not registered`), rfqErr{"maker", "not_registered", false}},

	// settlement
	{regexp.MustCompile(`settlement subaccount already has an open position`), rfqErr{"settlement", "open_position", false}},
	{regexp.MustCompile(`settlement`), rfqErr{"settlement", "other", false}},

	// signed intent validation
	{regexp.MustCompile(`signed intent`), rfqErr{"intent", "invalid_intent", false}},

	// atomic RFQ proxy: its own order leg did not fully fill
	{regexp.MustCompile(`atomic order partially filled`), rfqErr{"proxy", "atomic_order_partial_fill", false}},

	// wrapper, when there is no more specific reason inside
	{regexp.MustCompile(`No quote was filled`), rfqErr{"fill", "no_quote_filled", false}},

	{regexp.MustCompile(`Unauthorized`), rfqErr{"input", "unauthorized", false}},
	{regexp.MustCompile(`(?i)invalid|market not found|must be|is empty|exceeds|not supported|unsupported`), rfqErr{"input", "invalid_input", false}},
	{regexp.MustCompile(`out of gas`), rfqErr{"chain", "out_of_gas", false}},
}

var (
	wasmLogMsgRegexp = regexp.MustCompile(`msg:"(?:\\.|[^"\\])*"`)
	wasmLogCtxRegexp = regexp.MustCompile(`message sender:"[^"]*" contract:"[^"]*" msg:<…>(?: funds:<[^>]*>)*\s*:?\s*`)
	addrRegexp       = regexp.MustCompile(`\binj1[0-9a-z]{38,58}\b`)
	hexRegexp        = regexp.MustCompile(`\b0x[0-9a-fA-F]+\b`)
	numRegexp        = regexp.MustCompile(`-?\d+(\.\d+)?`)
	spaceRegexp      = regexp.MustCompile(`\s+`)
)

// stripWasmLogMsg removes the embedded execute msg JSON from a failed tx log.
func stripWasmLogMsg(log string) string {
	return wasmLogMsgRegexp.ReplaceAllString(log, "msg:<…>")
}

var (
	quoteExpiredRegexp   = regexp.MustCompile(`quote expired at ts=(\d+), current=(\d+)`)
	nonceWindowRegexp    = regexp.MustCompile(`nonce outside window \[[^\]]*\] or \[(\d+); (\d+)\]`)
	intentDeadlineRegexp = regexp.MustCompile(`signed intent deadline (\d+) has passed at (\d+)`)
)

// staleLateBy returns how late (wallclock, by block time) a stale rejection was: how much sooner
// the tx had to land to pass the check. When several quotes expired, the least late one is used,
// i.e. the tx would have filled at least one quote if it was faster by that much.
// rfqID is required to evaluate "nonce outside window" (negative result: rfq_id is in the future).
func staleLateBy(text string, rfqID uint64) (time.Duration, bool) {
	var (
		best  int64
		found bool
	)

	consider := func(lateMs int64) {
		if !found || lateMs < best {
			best, found = lateMs, true
		}
	}

	for _, m := range quoteExpiredRegexp.FindAllStringSubmatch(text, -1) {
		expiry, _ := strconv.ParseInt(m[1], 10, 64)
		current, _ := strconv.ParseInt(m[2], 10, 64)
		consider(current - expiry)
	}

	for _, m := range intentDeadlineRegexp.FindAllStringSubmatch(text, -1) {
		deadline, _ := strconv.ParseInt(m[1], 10, 64)
		current, _ := strconv.ParseInt(m[2], 10, 64)
		consider(current - deadline)
	}

	if m := nonceWindowRegexp.FindStringSubmatch(text); m != nil && rfqID > 0 {
		minAllowed, _ := strconv.ParseInt(m[1], 10, 64)
		maxAllowed, _ := strconv.ParseInt(m[2], 10, 64)

		switch nonce := int64(rfqID); {
		case nonce < minAllowed:
			consider(minAllowed - nonce)
		case nonce > maxAllowed:
			consider(maxAllowed - nonce)
		}
	}

	return time.Duration(best) * time.Millisecond, found
}

// classifyRFQError classifies an RFQ error text: either a failed tx log or a quote result error.
func classifyRFQError(text string) rfqErr {
	text = stripWasmLogMsg(text)

	for _, p := range rfqErrPatterns {
		if p.re.MatchString(text) {
			return p.err
		}
	}

	return rfqErr{Class: "other", Key: "unknown"}
}

// classifyRFQTxFailure classifies a failed RFQ tx result.
func classifyRFQTxFailure(codespace string, code uint32, log string) rfqErr {
	if codespace != "wasm" {
		// failed outside of contract execution (ante handler, gas, sequence, exchange msgs in the same tx
		// or the atomic proxy order leg). Key matches the "<codespace>:<code>" error mapping in dashboards.
		return rfqErr{Class: codespace, Key: fmt.Sprintf("%s:%d", codespace, code)}
	}

	return classifyRFQError(log)
}

const maxErrTemplateLen = 96

// wasmErrorTemplate extracts the innermost reason from a failed wasm tx log and normalizes it
// into a low-cardinality template (addresses, hex and numbers replaced).
func wasmErrorTemplate(log string) string {
	s := wasmLogCtxRegexp.ReplaceAllString(stripWasmLogMsg(log), "")
	s = strings.TrimSuffix(strings.TrimSpace(s), ": execute wasm contract failed")

	for _, sep := range []string{"error: ", "reply: ", "failed to execute message; "} {
		if idx := strings.LastIndex(s, sep); idx >= 0 {
			s = s[idx+len(sep):]
			break
		}
	}

	s = strings.TrimPrefix(s, "message index: ")
	s = addrRegexp.ReplaceAllString(s, "ADDR")
	s = hexRegexp.ReplaceAllString(s, "HEX")
	s = numRegexp.ReplaceAllString(s, "N")
	s = strings.TrimPrefix(s, "N: ")
	s = spaceRegexp.ReplaceAllString(strings.TrimSpace(s), " ")

	if len(s) > maxErrTemplateLen {
		s = s[:maxErrTemplateLen]
	}

	if s == "" {
		return "unknown"
	}

	return s
}

// firstWasmExec returns contract and top-level execute method of the first wasm execute msg.
func firstWasmExec(msgs []proto.Message) (contract, method string, ok bool) {
	for _, msg := range msgs {
		var payload []byte

		switch m := msg.(type) {
		case *wasmtypes.MsgExecuteContract:
			contract, payload = m.Contract, m.Msg
		case *wasmxtypes.MsgExecuteContractCompat:
			contract, payload = m.Contract, []byte(m.Msg)
		default:
			continue
		}

		var top map[string]json.RawMessage
		if err := json.Unmarshal(payload, &top); err == nil {
			for k := range top {
				method = k
				break
			}
		}

		return contract, method, true
	}

	return "", "", false
}
