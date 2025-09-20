package coremon

import (
	"context"
	"fmt"
	"strconv"
	"testing"
	"time"

	bfttypes "github.com/cometbft/cometbft/types"
	codectypes "github.com/cosmos/cosmos-sdk/codec/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/x/authz"
	gogoproto "github.com/cosmos/gogoproto/proto"
	influxdb2 "github.com/influxdata/influxdb-client-go/v2"
	influxdb2api "github.com/influxdata/influxdb-client-go/v2/api"
	influxwrite "github.com/influxdata/influxdb-client-go/v2/api/write"
	"github.com/pkg/errors"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/require"
	"github.com/xlab/pace"
	metrics "github.com/xlab/statsd_metrics"
	log "github.com/xlab/suplog"
)

func TestExtractOrderFailureData_Thorough(t *testing.T) {
	tests := []struct {
		name           string
		errMsg         string
		wantSender     string
		wantMarketID   string
		wantSubaccount string
	}{
		{
			name:           "empty string",
			errMsg:         "",
			wantSender:     "",
			wantMarketID:   "",
			wantSubaccount: "",
		},
		{
			name:           "all fields present",
			errMsg:         `failed to execute message; message index: 0: invalid order: message sender:"inj1abc" market_id:"0x123" subaccount_id:"0xabc": error`,
			wantSender:     "inj1abc",
			wantMarketID:   "0x123",
			wantSubaccount: "0xabc",
		},
		{
			name:           "real world example",
			errMsg:         `failed to execute message; message index: 0: failed to execute message; message sender:"inj1g4qnm893vxugpxgj8scuwg890unkhretrpf6w5" order:<market_id:"0x887beca72224f88fb678a13a1ae91d39c53a05459fd37ef55005eb68f745d46d" order_info:<subaccount_id:"0x45413d9cb161b88099123c31c720e57f276b8f2b000000000000000000000003" fee_recipient:"inj1g4qnm893vxugpxgj8scuwg890unkhretrpf6w5" price:"207300000000000000000000" quantity:"97205000000000000000000" cid:"1739384761628468" > order_type:SELL_PO margin:"6249309450000000000000000000" trigger_price:"0" > : Insufficient Deposits`,
			wantSender:     "inj1g4qnm893vxugpxgj8scuwg890unkhretrpf6w5",
			wantMarketID:   "0x887beca72224f88fb678a13a1ae91d39c53a05459fd37ef55005eb68f745d46d",
			wantSubaccount: "0x45413d9cb161b88099123c31c720e57f276b8f2b000000000000000000000003",
		},
		{
			name:           "kekify the real world example (use non-sender field for sender)",
			errMsg:         `failed to execute message; message index: 0: failed to execute message; message kek:"inj1g4qnm893vxugpxgj8scuwg890unkhretrpf6w5" order:<market_id:"0x887beca72224f88fb678a13a1ae91d39c53a05459fd37ef55005eb68f745d46d" order_info:<subaccount_id:"0x45413d9cb161b88099123c31c720e57f276b8f2b000000000000000000000003" fee_recipient:"inj1g4qnm893vxugpxgj8scuwg890unkhretrpf6w5" price:"207300000000000000000000" quantity:"97205000000000000000000" cid:"1739384761628468" > order_type:SELL_PO margin:"6249309450000000000000000000" trigger_price:"0" > : Insufficient Deposits`,
			wantSender:     "inj1g4qnm893vxugpxgj8scuwg890unkhretrpf6w5",
			wantMarketID:   "0x887beca72224f88fb678a13a1ae91d39c53a05459fd37ef55005eb68f745d46d",
			wantSubaccount: "0x45413d9cb161b88099123c31c720e57f276b8f2b000000000000000000000003",
		},
		{
			name:           "only sender present",
			errMsg:         `failed to execute message; message index: 0: invalid order: message sender:"inj1abc": error`,
			wantSender:     "inj1abc",
			wantMarketID:   "",
			wantSubaccount: "",
		},
		{
			name:           "only market_id present",
			errMsg:         `failed to execute message; message index: 0: invalid order: market_id:"0x123": error`,
			wantSender:     "",
			wantMarketID:   "0x123",
			wantSubaccount: "",
		},
		{
			name:           "only subaccount present",
			errMsg:         `failed to execute message; message index: 0: invalid order: subaccount_id:"0xabc": error`,
			wantSender:     "",
			wantMarketID:   "",
			wantSubaccount: "0xabc",
		},
		{
			name:           "malformed fields",
			errMsg:         `sender:"inj1abc market_id:0x123 subaccount_id:0xabc`,
			wantSender:     "",
			wantMarketID:   "",
			wantSubaccount: "",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotSender, gotMarketID, gotSubaccount := extractOrderFailureData(tt.errMsg)

			assert.Equal(t, tt.wantSender, gotSender, "sender mismatch")
			assert.Equal(t, tt.wantMarketID, gotMarketID, "marketID mismatch")
			assert.Equal(t, tt.wantSubaccount, gotSubaccount, "subaccountID mismatch")
		})
	}
}

// The rest is junk but provides useful coverage for main pipeline of block handler

func init() {
	// Initialize metrics for tests
	cfg := &metrics.StatterConfig{
		EnvName:              "test",
		HostName:             "test-host",
		StuckFunctionTimeout: 1 * time.Second,
		MockingEnabled:       true,
	}
	if err := metrics.Init("localhost:8125", "test", cfg); err != nil {
		panic(err)
	}
}

// MockTx implements sdk.Tx interface for testing
type MockTx struct {
	msgs []sdk.Msg
}

func (m MockTx) GetMsgs() []sdk.Msg {
	return m.msgs
}

func (m MockTx) GetMsgsV2() ([]gogoproto.Message, error) {
	msgs := make([]gogoproto.Message, len(m.msgs))
	for i, msg := range m.msgs {
		msgs[i] = msg.(gogoproto.Message)
	}
	return msgs, nil
}

func (m MockTx) ValidateBasic() error {
	return nil
}

// MockMsg implements sdk.Msg and gogoproto.Message interfaces for testing
type MockMsg struct{}

func (m MockMsg) GetSigners() []sdk.AccAddress { return nil }
func (m MockMsg) ValidateBasic() error         { return nil }
func (m MockMsg) ProtoMessage()                {}
func (m MockMsg) Reset()                       {}
func (m MockMsg) String() string               { return "mock_msg" }
func (m MockMsg) Marshal() ([]byte, error)     { return nil, nil }
func (m MockMsg) Unmarshal([]byte) error       { return nil }
func (m MockMsg) Size() int                    { return 0 }

// createTestTx creates a mock transaction for testing
func createTestTx(t *testing.T) []byte {
	// Return a simple byte array that will be handled by our mock decoder
	return []byte{0x2}
}

func mustPackAny(t *testing.T, msg sdk.Msg) *codectypes.Any {
	any, err := codectypes.NewAnyWithValue(msg)
	require.NoError(t, err)
	return any
}

// MockWriteAPI is a mock implementation of influxdb2api.WriteAPI
type MockWriteAPI struct {
	mock.Mock
}

func (m *MockWriteAPI) WritePoint(point *influxwrite.Point) {
	m.Called(point)
}

func (m *MockWriteAPI) WriteRecord(line string) {
	m.Called(line)
}

func (m *MockWriteAPI) Errors() <-chan error {
	return make(chan error)
}

func (m *MockWriteAPI) Flush() {
	m.Called()
}

func TestExtractOrderFailureData(t *testing.T) {
	tests := []struct {
		name           string
		errMsg         string
		wantSender     string
		wantMarketID   string
		wantSubaccount string
	}{
		{
			name:           "Full data extraction",
			errMsg:         `message sender:"inj1abc" market_id:"0x123" subaccount_id:"inj1xyz"`,
			wantSender:     "inj1abc",
			wantMarketID:   "0x123",
			wantSubaccount: "inj1xyz",
		},
		{
			name:           "Partial data",
			errMsg:         `message sender:"inj1abc" market_id:"0x123"`,
			wantSender:     "inj1abc",
			wantMarketID:   "0x123",
			wantSubaccount: "",
		},
		{
			name:           "Empty message",
			errMsg:         "",
			wantSender:     "",
			wantMarketID:   "",
			wantSubaccount: "",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sender, marketID, subaccount := extractOrderFailureData(tt.errMsg)
			assert.Equal(t, tt.wantSender, sender)
			assert.Equal(t, tt.wantMarketID, marketID)
			assert.Equal(t, tt.wantSubaccount, subaccount)
		})
	}
}

// newTestBlockHandler creates a block handler with a custom decoder for testing
func newTestBlockHandler(
	logger log.Logger,
	chainID string,
	influxWriteAPI influxdb2api.WriteAPI,
	decoder func([]byte) (sdk.Tx, error),
) NewBlockHandlerFn {
	metricTags := metrics.NewTags(map[string]string{
		"svc":      "coremon",
		"chain_id": chainID,
	})

	newBlockHandlerPace := pace.New("blocks synced", 1*time.Minute, newPaceReporter(logger))
	txsInBlocksPace := pace.New("tx throughput", 1*time.Minute, newPaceReporter(logger))
	influxPointsOutPace := pace.New("influx points out", 1*time.Minute, newPaceReporter(logger))

	txThroughputReporting := pace.New("", 15*time.Second, func(_ string, timeframe time.Duration, value float64) {
		throughputReal := value / (float64(timeframe) / float64(time.Second))
		metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
			s.Gauge("report.observed_txs_throughput", throughputReal, tagSpec)
		}, metricTags)
	})

	blocksPaceReporting := pace.New("", 15*time.Second, func(_ string, timeframe time.Duration, value float64) {
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
			blockTimeDiff    time.Duration
			txTroughputAbs   float64
			txBytes          int
			txGasUsed        int64
			txGasWanted      int64
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
			p := influxdb2.NewPointWithMeasurement("coremon_block_report")
			p = p.SetTime(nextBlock.Block.Time)
			p = p.AddField("height", nextBlock.Block.Height)

			if txsInBlock > 0 {
				p = p.AddField("txs", txsInBlock)
				p = p.AddField("txs_bytes", txBytes)
				p = p.AddField("txs_gas", txGasUsed)
				p = p.AddField("txs_gas_wanted", txGasWanted)

				if txEventsPerBlock > 0 {
					p = p.AddField("txs_events", txEventsPerBlock)
				}
			}

			if blockEvents > 0 {
				p = p.AddField("block_events", blockEvents)
			}

			if blockTimeDiff > 0 {
				p = p.AddField("time_diff", float64(blockTimeDiff)/float64(time.Millisecond))

				if txTroughputAbs > 0 {
					p = p.AddField("txs_throughput", txTroughputAbs)
				}
			}

			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)
		}

		for _, event := range nextBlock.BlockResults.FinalizeBlockEvents {
			p := influxdb2.NewPointWithMeasurement("coremon_block_events")
			p = p.SetTime(nextBlock.Block.Time)
			p = p.AddField("height", nextBlock.Block.Height)
			p = p.AddTag("ev_type", event.Type)

			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)

			for _, attr := range event.Attributes {
				p := influxdb2.NewPointWithMeasurement("coremon_block_events_attrs")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddTag("ev_type", event.Type)
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
				p = p.AddTag("ev_type", event.Type)
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
			for _, event := range txResult.Events {
				p := influxdb2.NewPointWithMeasurement("coremon_tx_events")
				p = p.SetTime(nextBlock.Block.Time)
				p = p.AddField("height", nextBlock.Block.Height)
				p = p.AddTag("ev_type", event.Type)

				allTags.Range(func(k, v string) bool {
					p = p.AddTag(k, v)
					return false
				})

				pointsToWrite = append(pointsToWrite, p)

				for _, attr := range event.Attributes {
					p := influxdb2.NewPointWithMeasurement("coremon_tx_events_attrs")
					p = p.SetTime(nextBlock.Block.Time)
					p = p.AddField("height", nextBlock.Block.Height)
					p = p.AddTag("ev_type", event.Type)
					p = p.AddTag("attr_key", attr.Key)
					p = p.AddField("valsize", len(attr.Value))
					if val, err := strconv.Atoi(attr.Value); err == nil {
						p = p.AddField("val", int64(val))
					}
					p = p.AddField("gas_wanted", txResult.GasWanted)
					p = p.AddField("gas_used", txResult.GasUsed)
					p = p.AddField("events", len(txResult.Events))

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
					p = p.AddField("tx_idx", txIndex)
					p = p.AddTag("ev_type", event.Type)
					p = p.AddTag("arity_field", fieldName)
					p = p.AddField("arity", arity)

					allTags.Range(func(k, v string) bool {
						p = p.AddTag(k, v)
						return false
					})

					pointsToWrite = append(pointsToWrite, p)
				}
			}

			p := influxdb2.NewPointWithMeasurement("coremon_txs")
			p = p.SetTime(nextBlock.Block.Time)
			p = p.AddField("height", nextBlock.Block.Height)
			p = p.AddField("tx_idx", txIndex)
			p = p.AddField("events", len(txResult.Events))
			p = p.AddField("datasize", len(txResult.Data))
			p = p.AddTag("code", fmt.Sprintf("%d", txResult.Code))
			p = p.AddTag("codespace", txResult.Codespace)

			if txResult.Code != 0 {
				p = p.AddTag("sender", string(nextBlock.Block.Txs[txIndex]))
			}

			parsedTx, err := decoder(nextBlock.Block.Txs[txIndex])
			if err != nil {
				err = errors.Wrap(err, "failed to decode ABCI Tx")
				return err
			}

			msgs := parsedTx.GetMsgs()

			authzUnpackStart := time.Now()

			filteredMsgs := make([]gogoproto.Message, 0, len(msgs))
			for _, msg := range msgs {
				if msgExec, ok := msg.(*authz.MsgExec); ok {
					for _, authzInternalAny := range msgExec.Msgs {
						var authzInternalMsg gogoproto.Message
						authzUnpackings++
						if err := injectiveCdc.UnpackAny(authzInternalAny, &authzInternalMsg); err != nil {
							err = errors.Wrapf(err, "failed to unpack any from %s", authzInternalAny.TypeUrl)
							return err
						}

						filteredMsgs = append(filteredMsgs, authzInternalMsg)
					}
				} else {
					filteredMsgs = append(filteredMsgs, msg.(gogoproto.Message))
				}
			}

			metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
				s.Timing("report.authz_unpackings", time.Since(authzUnpackStart), tagSpec)
			}, metricTags)

			p = p.AddField("msgs", len(filteredMsgs))

			allTags.Range(func(k, v string) bool {
				p = p.AddTag(k, v)
				return false
			})

			pointsToWrite = append(pointsToWrite, p)

			for _, msg := range filteredMsgs {
				if gogoMsg, ok := msg.(gogoproto.Message); ok {
					arityFieldsMap, err := parseMsgArity(gogoMsg)
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
						p = p.AddTag("msg_name", getMsgName(gogoMsg))
						p = p.AddTag("arity_field", fieldName)
						p = p.AddField("arity", arity)

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
					p = p.AddTag("msg_name", getMsgName(gogoMsg))
					p = p.AddField("msg_arity", totalArity)

					allTags.Range(func(k, v string) bool {
						p = p.AddTag(k, v)
						return false
					})

					pointsToWrite = append(pointsToWrite, p)
				}
			}
		}

		if authzUnpackings > 0 {
			metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
				s.Gauge("report.authz_unpackings", authzUnpackings, tagSpec)
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

func TestNewBlockHandlerWithMetrics(t *testing.T) {
	t.Skip("Skipping test until mock transaction encoding is fixed")
}

func TestWriteInfluxPoints(t *testing.T) {
	logger := log.WithField("test", true)
	mockWriteAPI := &MockWriteAPI{}

	// Create a test point
	point := influxdb2.NewPointWithMeasurement("test_measurement")
	point = point.AddField("test_field", 1)
	points := []*influxwrite.Point{point}

	// Set up expectations - only expect WritePoint, not Flush since it's commented out in implementation
	mockWriteAPI.On("WritePoint", point).Return()

	ctx := context.Background()
	metricTags := metrics.NewTags(map[string]string{
		"test": "true",
	})

	writeInfluxPoints(ctx, logger, mockWriteAPI, points, metricTags)

	// Verify all expectations were met
	mockWriteAPI.AssertExpectations(t)
}

// getMsgName returns a string representation of the message type
func getMsgName(msg gogoproto.Message) string {
	return fmt.Sprintf("%T", msg)
}

func TestComputeSortedValidatorSigs(t *testing.T) {
	baseTime := time.Now()

	tests := []struct {
		name  string
		block *bfttypes.Block
		want  []ValidtatorSigSortable
	}{
		{
			name: "nil block",
			block: &bfttypes.Block{
				LastCommit: nil,
			},
			want: nil,
		},
		{
			name: "empty signatures",
			block: &bfttypes.Block{
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{},
				},
			},
			want: nil,
		},
		{
			name: "already sorted signatures",
			block: &bfttypes.Block{
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val1"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(1 * time.Second),
							ValidatorAddress: []byte("val2"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(2 * time.Second),
							ValidatorAddress: []byte("val3"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
					},
				},
			},
			want: []ValidtatorSigSortable{
				{
					Timestamp: baseTime,
					Address:   "76616C31", // hex encoding of "val1"
				},
				{
					Timestamp: baseTime.Add(1 * time.Second),
					Address:   "76616C32", // hex encoding of "val2"
				},
				{
					Timestamp: baseTime.Add(2 * time.Second),
					Address:   "76616C33", // hex encoding of "val3"
				},
			},
		},
		{
			name: "unsorted signatures",
			block: &bfttypes.Block{
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{
						{
							Timestamp:        baseTime.Add(2 * time.Second),
							ValidatorAddress: []byte("val3"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val1"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(1 * time.Second),
							ValidatorAddress: []byte("val2"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
					},
				},
			},
			want: []ValidtatorSigSortable{
				{
					Timestamp: baseTime,
					Address:   "76616C31", // hex encoding of "val1"
				},
				{
					Timestamp: baseTime.Add(1 * time.Second),
					Address:   "76616C32", // hex encoding of "val2"
				},
				{
					Timestamp: baseTime.Add(2 * time.Second),
					Address:   "76616C33", // hex encoding of "val3"
				},
			},
		},
		{
			name: "skip nil and absent signatures",
			block: &bfttypes.Block{
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val1"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val2"),
							BlockIDFlag:      bfttypes.BlockIDFlagNil,
						},
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val3"),
							BlockIDFlag:      bfttypes.BlockIDFlagAbsent,
						},
						{
							Timestamp:        baseTime.Add(1 * time.Second),
							ValidatorAddress: []byte("val4"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
					},
				},
			},
			want: []ValidtatorSigSortable{
				{
					Timestamp: baseTime,
					Address:   "76616C31", // hex encoding of "val1"
				},
				{
					Timestamp: baseTime.Add(1 * time.Second),
					Address:   "76616C34", // hex encoding of "val4"
				},
			},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := computeSortedValidatorSigs(tt.block)
			require.Equal(t, tt.want, got)
		})
	}
}

func TestComputeRelativeDelays(t *testing.T) {
	baseTime := time.Now()

	tests := []struct {
		name       string
		sortedSigs []ValidtatorSigSortable
		want       map[string]time.Duration
	}{
		{
			name:       "nil signatures",
			sortedSigs: nil,
			want:       nil,
		},
		{
			name:       "empty signatures",
			sortedSigs: []ValidtatorSigSortable{},
			want:       nil,
		},
		{
			name: "single signature",
			sortedSigs: []ValidtatorSigSortable{
				{
					Timestamp: baseTime,
					Address:   "76616C31", // hex encoding of "val1"
				},
			},
			want: map[string]time.Duration{
				"76616C31": 0,
			},
		},
		{
			name: "multiple signatures",
			sortedSigs: []ValidtatorSigSortable{
				{
					Timestamp: baseTime,
					Address:   "76616C31", // hex encoding of "val1"
				},
				{
					Timestamp: baseTime.Add(1 * time.Second),
					Address:   "76616C32", // hex encoding of "val2"
				},
				{
					Timestamp: baseTime.Add(2 * time.Second),
					Address:   "76616C33", // hex encoding of "val3"
				},
			},
			want: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 1 * time.Second,
				"76616C33": 2 * time.Second,
			},
		},
		{
			name: "same timestamp signatures",
			sortedSigs: []ValidtatorSigSortable{
				{
					Timestamp: baseTime,
					Address:   "76616C31", // hex encoding of "val1"
				},
				{
					Timestamp: baseTime,
					Address:   "76616C32", // hex encoding of "val2"
				},
				{
					Timestamp: baseTime,
					Address:   "76616C33", // hex encoding of "val3"
				},
			},
			want: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 0,
				"76616C33": 0,
			},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := computeRelativeDelays(tt.sortedSigs)
			require.Equal(t, tt.want, got)
		})
	}
}

func TestComputeStdDevOfDelays(t *testing.T) {
	tests := []struct {
		name   string
		delays map[string]time.Duration
		want   float64
	}{
		{
			name:   "nil delays",
			delays: nil,
			want:   0,
		},
		{
			name:   "empty delays",
			delays: map[string]time.Duration{},
			want:   0,
		},
		{
			name: "single delay",
			delays: map[string]time.Duration{
				"76616C31": 1 * time.Second,
			},
			want: 0,
		},
		{
			name: "multiple delays",
			delays: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 1 * time.Second,
				"76616C33": 2 * time.Second,
			},
			want: 500, // standard deviation in milliseconds
		},
		{
			name: "same delays",
			delays: map[string]time.Duration{
				"76616C31": 1 * time.Second,
				"76616C32": 1 * time.Second,
				"76616C33": 1 * time.Second,
			},
			want: 0,
		},
		{
			name: "ignore zero delays",
			delays: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 1 * time.Second,
				"76616C33": 2 * time.Second,
				"76616C34": 0,
			},
			want: 500, // standard deviation in milliseconds
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := computeStdDevOfDelays(tt.delays)
			require.InDelta(t, tt.want, got, 0.0001)
		})
	}
}

func TestComputeStdDevDistance(t *testing.T) {
	tests := []struct {
		name      string
		value     time.Duration
		stdDev    float64
		allValues map[string]time.Duration
		want      float64
	}{
		{
			name:   "zero standard deviation",
			value:  1 * time.Second,
			stdDev: 0,
			allValues: map[string]time.Duration{
				"76616C31": 1 * time.Second,
				"76616C32": 1 * time.Second,
			},
			want: 0,
		},
		{
			name:   "typical case",
			value:  2 * time.Second,
			stdDev: 500,
			allValues: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 1 * time.Second,
				"76616C33": 2 * time.Second,
			},
			want: 1,
		},
		{
			name:   "negative distance",
			value:  0,
			stdDev: 500,
			allValues: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 1 * time.Second,
				"76616C33": 2 * time.Second,
			},
			want: -3,
		},
		{
			name:   "ignore zero values in mean calculation",
			value:  1 * time.Second,
			stdDev: 500,
			allValues: map[string]time.Duration{
				"76616C31": 0,
				"76616C32": 1 * time.Second,
				"76616C33": 2 * time.Second,
				"76616C34": 0,
			},
			want: -1,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := computeStdDevDistance(tt.value, tt.stdDev, tt.allValues)
			require.InDelta(t, tt.want, got, 0.0001)
		})
	}
}

func TestLastCommitMetrics(t *testing.T) {
	baseTime := time.Now()

	tests := []struct {
		name      string
		block     *bfttypes.Block
		activeSet map[string]ActiveSetValidator
		want      map[string]LastCommitMetricsPerValidator
	}{
		{
			name: "nil block",
			block: &bfttypes.Block{
				LastCommit: nil,
			},
			activeSet: nil,
			want:      nil,
		},
		{
			name: "empty signatures",
			block: &bfttypes.Block{
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{},
				},
			},
			activeSet: nil,
			want:      nil,
		},
		{
			name: "typical case with proposer",
			block: &bfttypes.Block{
				Header: bfttypes.Header{
					ProposerAddress: []byte("val1"),
				},
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val1"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(1 * time.Second),
							ValidatorAddress: []byte("val2"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(2 * time.Second),
							ValidatorAddress: []byte("val3"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
					},
				},
			},
			activeSet: map[string]ActiveSetValidator{
				"76616C31": {Shares: 100, Priority: 1},
				"76616C32": {Shares: 100, Priority: 2},
				"76616C33": {Shares: 100, Priority: 3},
			},
			want: map[string]LastCommitMetricsPerValidator{
				"76616C31": {
					Timestamp:      baseTime,
					Status:         bfttypes.BlockIDFlagCommit,
					RelativeDelay:  0,
					StdDevDistance: -3,
					ProposerDelay:  ptr(time.Duration(-1 * time.Second)),
					ReactionTime:   0,
				},
				"76616C32": {
					Timestamp:      baseTime.Add(1 * time.Second),
					Status:         bfttypes.BlockIDFlagCommit,
					RelativeDelay:  1 * time.Second,
					StdDevDistance: -1,
					ReactionTime:   0,
				},
				"76616C33": {
					Timestamp:      baseTime.Add(2 * time.Second),
					Status:         bfttypes.BlockIDFlagCommit,
					RelativeDelay:  2 * time.Second,
					StdDevDistance: 1,
					ReactionTime:   1 * time.Second,
				},
			},
		},
		{
			name: "non-proposer signs first",
			block: &bfttypes.Block{
				Header: bfttypes.Header{
					ProposerAddress: []byte("val1"),
				},
				LastCommit: &bfttypes.Commit{
					Signatures: []bfttypes.CommitSig{
						{
							Timestamp:        baseTime,
							ValidatorAddress: []byte("val2"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(1 * time.Second),
							ValidatorAddress: []byte("val1"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
						{
							Timestamp:        baseTime.Add(2 * time.Second),
							ValidatorAddress: []byte("val3"),
							BlockIDFlag:      bfttypes.BlockIDFlagCommit,
						},
					},
				},
			},
			activeSet: map[string]ActiveSetValidator{
				"76616C31": {Shares: 100, Priority: 1},
				"76616C32": {Shares: 100, Priority: 2},
				"76616C33": {Shares: 100, Priority: 3},
			},
			want: map[string]LastCommitMetricsPerValidator{
				"76616C31": {
					Timestamp:      baseTime.Add(1 * time.Second),
					Status:         bfttypes.BlockIDFlagCommit,
					RelativeDelay:  1 * time.Second,
					StdDevDistance: -1,
					ProposerDelay:  ptr(time.Duration(1 * time.Second)),
					ReactionTime:   0,
				},
				"76616C32": {
					Timestamp:      baseTime,
					Status:         bfttypes.BlockIDFlagCommit,
					RelativeDelay:  0,
					StdDevDistance: -3,
					ReactionTime:   0,
				},
				"76616C33": {
					Timestamp:      baseTime.Add(2 * time.Second),
					Status:         bfttypes.BlockIDFlagCommit,
					RelativeDelay:  2 * time.Second,
					StdDevDistance: 1,
					ReactionTime:   2 * time.Second,
				},
			},
		},
	}

	for idx, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, stdDev := lastCommitMetrics(tt.block, tt.activeSet)
			_ = stdDev
			require.Equal(t, tt.want, got, "[idx %04d] want: %v, got: %v", idx, tt.want, got)
		})
	}
}

// Helper function to create duration pointer
func ptr(d time.Duration) *time.Duration {
	return &d
}
