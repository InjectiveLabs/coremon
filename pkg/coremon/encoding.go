package coremon

import (
	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	authTx "github.com/cosmos/cosmos-sdk/x/auth/tx"

	ctypes "github.com/InjectiveLabs/sdk-go/chain/types"
	chainclient "github.com/InjectiveLabs/sdk-go/client/chain"
	consensustypes "github.com/cosmos/cosmos-sdk/x/consensus/types"
)

var (
	injectiveCdc codec.Codec
)

func init() {
	setAccountPrefixes("inj")
	chainCtx, _ := chainclient.NewClientContext("", "", nil)

	interfaceRegistry := chainCtx.InterfaceRegistry
	consensustypes.RegisterInterfaces(interfaceRegistry)

	injectiveCdc = codec.NewProtoCodec(chainCtx.InterfaceRegistry)
}

const (
	Bech32MainPrefix          = "inj"
	InjectiveBondDenom        = "inj"
	InjectiveCoinType         = 60
	InjectiveSigningAlgorithm = "eth_secp256k1"
)

func setAccountPrefixes(accountAddressPrefix string) {
	// Set prefixes
	accountPubKeyPrefix := accountAddressPrefix + "pub"
	validatorAddressPrefix := accountAddressPrefix + "valoper"
	validatorPubKeyPrefix := accountAddressPrefix + "valoperpub"
	consNodeAddressPrefix := accountAddressPrefix + "valcons"
	consNodePubKeyPrefix := accountAddressPrefix + "valconspub"

	// Set and seal config
	config := sdk.GetConfig()
	config.SetBech32PrefixForAccount(accountAddressPrefix, accountPubKeyPrefix)
	config.SetBech32PrefixForValidator(validatorAddressPrefix, validatorPubKeyPrefix)
	config.SetBech32PrefixForConsensusNode(consNodeAddressPrefix, consNodePubKeyPrefix)

	ctypes.SetBech32Prefixes(config)
	ctypes.SetBip44CoinType(config)
}

func decodeABCITx(txbz []byte) (sdk.Tx, error) {
	return authTx.DefaultTxDecoder(injectiveCdc)(txbz)
}
