package coremon

import (
	"github.com/cosmos/gogoproto/proto"

	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
)

func parseMsgArity(msg proto.Message) (map[string]int, error) {
	arityMap := make(map[string]int)

	switch targetMsg := msg.(type) {
	case *exchangetypes.MsgBatchCreateSpotLimitOrders:
		arityMap["orders"] = len(targetMsg.Orders)
	case *exchangetypes.MsgBatchCreateDerivativeLimitOrders:
		arityMap["orders"] = len(targetMsg.Orders)
	case *exchangetypes.MsgBatchCancelSpotOrders:
		arityMap["data"] = len(targetMsg.Data)
	case *exchangetypes.MsgBatchCancelBinaryOptionsOrders:
		arityMap["data"] = len(targetMsg.Data)
	case *exchangetypes.MsgBatchUpdateOrders:
		arityMap["spotMarketIdsToCancelAll"] = len(targetMsg.SpotMarketIdsToCancelAll)
		arityMap["derivativeMarketIdsToCancelAll"] = len(targetMsg.DerivativeMarketIdsToCancelAll)
		arityMap["spotOrdersToCancel"] = len(targetMsg.SpotOrdersToCancel)
		arityMap["derivativeOrdersToCancel"] = len(targetMsg.DerivativeOrdersToCancel)
		arityMap["spotOrdersToCreate"] = len(targetMsg.SpotOrdersToCreate)
		arityMap["derivativeOrdersToCreate"] = len(targetMsg.DerivativeOrdersToCreate)
		arityMap["binaryOptionsOrdersToCancel"] = len(targetMsg.BinaryOptionsOrdersToCreate)
		arityMap["binaryOptionsMarketIdsToCancelAll"] = len(targetMsg.BinaryOptionsMarketIdsToCancelAll)
		arityMap["binaryOptionsOrdersToCreate"] = len(targetMsg.BinaryOptionsOrdersToCreate)
	case *exchangetypes.MsgBatchCancelDerivativeOrders:
		arityMap["data"] = len(targetMsg.Data)
	case *exchangetypes.MsgAuthorizeStakeGrants:
		arityMap["grants"] = len(targetMsg.Grants)
	}

	return arityMap, nil
}
