package coremon

import (
	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	authTx "github.com/cosmos/cosmos-sdk/x/auth/tx"
	"github.com/sei-protocol/sei-chain/app"
	"github.com/sei-protocol/sei-chain/app/params"
)

var (
	seiCdc codec.ProtoCodecMarshaler
)

func init() {
	setAccountPrefixes("sei")

	seiCdc = codec.NewProtoCodec(defaultEncoding().InterfaceRegistry)
}

const (
	Bech32MainPrefix    = "sei"
	SeiBondDenom        = "usei"
	SeiCoinType         = 118
	SeiSigningAlgorithm = "secp256k1"
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
}

func defaultEncoding() params.EncodingConfig {
	return app.MakeEncodingConfig()
}

func decodeABCITx(txbz []byte) (sdk.Tx, error) {
	return authTx.DefaultTxDecoder(seiCdc)(txbz)
}
