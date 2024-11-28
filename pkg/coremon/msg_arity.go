package coremon

import (
	"github.com/cosmos/gogoproto/proto"
)

func parseMsgArity(msg proto.Message) (map[string]int, error) {
	return make(map[string]int), nil
}
