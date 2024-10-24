package coremon

import (
	"encoding/base64"
	"encoding/json"

	abci "github.com/tendermint/tendermint/abci/types"
	"github.com/minio/simdjson-go"
	"github.com/pkg/errors"
)

func parseEventArity(event abci.Event) (map[string]int, error) {
	arityMap := make(map[string]int)

	switch event.Type {
	case "injective.exchange.v1beta1.EventBatchSpotExecution":
		parsed, err := parseAttrAsJSON("trades", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["trades"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventBatchDerivativeExecution":
		parsed, err := parseAttrAsJSON("trades", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["trades"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventBatchDerivativePosition":
		parsed, err := parseAttrAsJSON("positions", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["positions"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventNewSpotOrders":
		parsed, err := parseAttrAsJSON("buy_orders", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["buyOrders"], err = arrayArity(iter)
				return err
			})
		}

		parsed, err = parseAttrAsJSON("sell_orders", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["sellOrders"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventNewDerivativeOrders":
		parsed, err := parseAttrAsJSON("buy_orders", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["buyOrders"], err = arrayArity(iter)
				return err
			})
		}

		parsed, err = parseAttrAsJSON("sell_orders", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["sellOrders"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventBatchDepositUpdate":
		parsed, err := parseAttrAsJSON("deposit_updates", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["depositUpdates_deposits"], err = arrayFieldArity(iter, "deposits")
				return err
			})
		}
	case "injective.exchange.v1beta1.EventTradingRewardCampaignUpdate":
		parsed, err := parseAttrAsJSON("campaign_reward_pools", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["campaignRewardPools"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventTradingRewardDistribution":
		parsed, err := parseAttrAsJSON("account_rewards", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["accountRewards"], err = arrayArity(iter)
				return err
			})
		}
	case "injective.exchange.v1beta1.EventAtomicMarketOrderFeeMultipliersUpdated":
		parsed, err := parseAttrAsJSON("market_fee_multipliers", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["marketFeeMultipliers"], err = arrayArity(iter)
				return err
			})
		}

	case "injective.exchange.v1beta1.EventOrderbookUpdate":
		parsed, err := parseAttrAsJSON("spot_updates", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["spotUpdates_buyLevels"], err = arrayObjectFieldArity(iter, "orderbook", "buyLevels")
				return err
			})
		}

		parsed, err = parseAttrAsJSON("spot_updates", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["spotUpdates_sellLevels"], err = arrayObjectFieldArity(iter, "orderbook", "sellLevels")
				return err
			})
		}

		parsed, err = parseAttrAsJSON("derivative_updates", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["derivativeUpdates_buyLevels"], err = arrayObjectFieldArity(iter, "orderbook", "buyLevels")
				return err
			})
		}

		parsed, err = parseAttrAsJSON("derivative_updates", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["derivativeUpdates_sellLevels"], err = arrayObjectFieldArity(iter, "orderbook", "sellLevels")
				return err
			})
		}

	case "injective.exchange.v1beta1.EventGrantAuthorizations":
		parsed, err := parseAttrAsJSON("grants", event)
		if err != nil {
			return nil, err
		} else if parsed != nil {
			parsed.ForEach(func(iter simdjson.Iter) error {
				arityMap["grants"], err = arrayArity(iter)
				return err
			})
		}
	}

	return arityMap, nil
}

// arrayArity is len(arr) where arr is simdjson.Iter
func arrayArity(i simdjson.Iter) (arity int, err error) {
	arr, err := i.Array(nil)
	if err != nil {
		return 0, err
	}

	arr.ForEach(func(i simdjson.Iter) {
		arity++
	})

	return arity, nil
}

// arrayFieldArity is sum(len(arr[idx].fieldElem)) where arr is simdjson.Iter, and fieldElem is a string name
// iterates over the array of objects and sums lenghts of a certain field.
func arrayFieldArity(i simdjson.Iter, fieldElem string) (arity int, err error) {
	arr, err := i.Array(nil)
	if err != nil {
		return 0, err
	}

	arr.ForEach(func(i simdjson.Iter) {
		elem, err := i.FindElement(nil, fieldElem)
		if err != nil {
			return
		}

		fieldArity, _ := arrayArity(elem.Iter)
		arity += fieldArity
	})

	return arity, err
}

// same as arrayFieldArity, but sum(len(arr[idx].objectElem.fieldElem))
func arrayObjectFieldArity(i simdjson.Iter, objectElem, fieldElem string) (arity int, err error) {
	arr, err := i.Array(nil)
	if err != nil {
		return 0, err
	}

	arr.ForEach(func(i simdjson.Iter) {
		objectElem, err := i.FindElement(nil, objectElem)
		if err != nil {
			return
		}

		fieldElem, err := objectElem.Iter.FindElement(nil, fieldElem)
		if err != nil {
			return
		}

		fieldArity, _ := arrayArity(fieldElem.Iter)
		arity += fieldArity
	})

	return arity, err
}

func parseAttrAsJSON(attrKey string, targetEvent abci.Event) (parsed *simdjson.ParsedJson, err error) {
	attrValue := ""
	for _, attr := range targetEvent.Attributes {
		if string(attr.Key) == attrKey {
			attrValue = string(attr.Value)
			break
		}
	}

	if len(attrValue) > 0 {
		if json.Valid([]byte(attrValue)) {
			if parsed, err = simdjson.Parse([]byte(attrValue), nil); err != nil {
				err = errors.Wrapf(err, "failed to parse str[key=%s] as JSON: %s", attrKey, attrValue)
				return nil, err
			}
		}

		if bz, err := base64.StdEncoding.DecodeString(attrValue); err == nil {
			if json.Valid(bz) {
				if parsed, err = simdjson.Parse(bz, nil); err != nil {
					err = errors.Wrapf(err, "failed to parse str[key=%s] as base64(JSON): %s", attrKey, attrValue)
					return nil, err
				}
			}
		}
	}

	return parsed, nil
}
