package coremon

import (
	"cosmossdk.io/x/upgrade"
	"github.com/cosmos/cosmos-sdk/codec"
	sdk "github.com/cosmos/cosmos-sdk/types"
	"github.com/cosmos/cosmos-sdk/types/module/testutil"
	"github.com/cosmos/cosmos-sdk/x/auth"
	authTx "github.com/cosmos/cosmos-sdk/x/auth/tx"
	"github.com/cosmos/cosmos-sdk/x/authz"
	"github.com/cosmos/cosmos-sdk/x/bank"
	"github.com/cosmos/cosmos-sdk/x/consensus"
	distr "github.com/cosmos/cosmos-sdk/x/distribution"
	"github.com/cosmos/cosmos-sdk/x/genutil"
	genutiltypes "github.com/cosmos/cosmos-sdk/x/genutil/types"
	"github.com/cosmos/cosmos-sdk/x/gov"
	govclient "github.com/cosmos/cosmos-sdk/x/gov/client"
	"github.com/cosmos/cosmos-sdk/x/mint"
	"github.com/cosmos/cosmos-sdk/x/params"
	paramsclient "github.com/cosmos/cosmos-sdk/x/params/client"
	"github.com/cosmos/cosmos-sdk/x/slashing"
	"github.com/cosmos/cosmos-sdk/x/staking"
	"github.com/cosmos/ibc-go/modules/capability"

	transfer "github.com/cosmos/ibc-go/v8/modules/apps/transfer"
	ibccore "github.com/cosmos/ibc-go/v8/modules/core"
	ibctm "github.com/cosmos/ibc-go/v8/modules/light-clients/07-tendermint"
	ccvprovider "github.com/cosmos/interchain-security/v5/x/ccv/provider"
	ibcwasm "github.com/strangelove-ventures/interchaintest/v8/chain/cosmos/08-wasm-types"

	wasm "github.com/CosmWasm/wasmd/x/wasm"
	auctiontypes "github.com/InjectiveLabs/sdk-go/chain/auction/types"
	chaincodec "github.com/InjectiveLabs/sdk-go/chain/codec"
	exchangetypes "github.com/InjectiveLabs/sdk-go/chain/exchange/types"
	insurancetypes "github.com/InjectiveLabs/sdk-go/chain/insurance/types"
	ocrtypes "github.com/InjectiveLabs/sdk-go/chain/ocr/types"
	oracletypes "github.com/InjectiveLabs/sdk-go/chain/oracle/types"
	peggytypes "github.com/InjectiveLabs/sdk-go/chain/peggy/types"
	permissionstypes "github.com/InjectiveLabs/sdk-go/chain/permissions/types"
	tokenfactorytypes "github.com/InjectiveLabs/sdk-go/chain/tokenfactory/types"
	ctypes "github.com/InjectiveLabs/sdk-go/chain/types"
	wasmxtypes "github.com/InjectiveLabs/sdk-go/chain/wasmx/types"
	evm "github.com/evmos/ethermint/x/evm"
	evmtypes "github.com/evmos/ethermint/x/evm/types"
	feemarket "github.com/evmos/ethermint/x/feemarket"
	feemarkettypes "github.com/evmos/ethermint/x/feemarket/types"
)

var (
	injectiveCdc codec.Codec
)

func init() {
	setAccountPrefixes("inj")

	interfaceRegistry := defaultEncoding().InterfaceRegistry
	chaincodec.RegisterInterfaces(interfaceRegistry)

	authz.RegisterInterfaces(interfaceRegistry)
	peggytypes.RegisterInterfaces(interfaceRegistry)
	auctiontypes.RegisterInterfaces(interfaceRegistry)
	exchangetypes.RegisterInterfaces(interfaceRegistry)
	insurancetypes.RegisterInterfaces(interfaceRegistry)
	ocrtypes.RegisterInterfaces(interfaceRegistry)
	oracletypes.RegisterInterfaces(interfaceRegistry)
	peggytypes.RegisterInterfaces(interfaceRegistry)
	permissionstypes.RegisterInterfaces(interfaceRegistry)
	tokenfactorytypes.RegisterInterfaces(interfaceRegistry)
	wasmxtypes.RegisterInterfaces(interfaceRegistry)
	evmtypes.RegisterInterfaces(interfaceRegistry)
	feemarkettypes.RegisterInterfaces(interfaceRegistry)

	injectiveCdc = codec.NewProtoCodec(interfaceRegistry)
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

func defaultEncoding() testutil.TestEncodingConfig {
	return testutil.MakeTestEncodingConfig(
		auth.AppModuleBasic{},
		genutil.NewAppModuleBasic(genutiltypes.DefaultMessageValidator),
		bank.AppModuleBasic{},
		capability.AppModuleBasic{},
		staking.AppModuleBasic{},
		mint.AppModuleBasic{},
		distr.AppModuleBasic{},
		gov.NewAppModuleBasic(
			[]govclient.ProposalHandler{
				paramsclient.ProposalHandler,
			},
		),
		params.AppModuleBasic{},
		slashing.AppModuleBasic{},
		upgrade.AppModuleBasic{},
		consensus.AppModuleBasic{},
		transfer.AppModuleBasic{},
		ibccore.AppModuleBasic{},
		ibctm.AppModuleBasic{},
		ibcwasm.AppModuleBasic{},
		ccvprovider.AppModuleBasic{},
		wasm.AppModuleBasic{},
		evm.AppModuleBasic{},
		feemarket.AppModuleBasic{},
	)
}

func decodeABCITx(txbz []byte) (sdk.Tx, error) {
	return authTx.DefaultTxDecoder(injectiveCdc)(txbz)
}
