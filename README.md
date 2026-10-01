## CoreMon

CoreMon is a block processing service that allows to monitor various chain metrics with enhanced accuracy (per-block measurements, etc). This provides an alternative pipeline to Prometheus and used to gather more info on testnets and mainnet relayers, could be used for chain debugging purposes.

## Usage

Options may be set as flags, env vars, also via `.env` file (dotenv format).

```
> coremon -h

Usage: coremon [OPTIONS] COMMAND [arg...]

Daemon for cosmos chain monitoring and accurate stats exporting.

Options:
  -e, --env          The environment name this app runs in. Used for metrics and error reporting. (env $COREMON_ENV) (default "local")
      --log-format   Format of log output: console | json (env $COREMON_LOG_FORMAT) (default "json")
  -v, --verbose      Turns on verbose logging. (env $COREMON_LOG_VERBOSE) (default "false")

Commands:
  process            Start chain blocks processing

Run 'coremon COMMAND --help' for more information on a command.
```

Processing subcommand:

```
> coremon process -h

Usage: coremon process [OPTIONS]

Start chain blocks processing

Options:
      --chain-id       Specify Chain ID of the network. (env $COREMON_CHAIN_ID) (default "stressinj-1337")
      --bft-rpc        CometBFT RPC endpoint (env $COREMON_BFT_RPC) (default "http://localhost:26657")
      --parallel-fetch-jobs   Number of sumultaneous jobs fetching the blocks from the RPC. Change only if need to access historical. (env $COREMON_BLOCK_FETCH_JOBS) (default 1)
```

## Building

```bash
make install
```

## Docker

```bash
make buildx TAG=v1.17.0

# optionally, to publish build
make buildx-push TAG=v1.17.0
```

Use GH pipeline to push a proper release into registry.

## Env Watching

* `COREMON_APP_HOME` (also `-H` flag):  Specify the home directory for the injectived to watch its disk space usage.

You can set alternative locations for various system directories by using the following environment variables:

* `/`: HOST_ROOT
* `/proc/N/mountinfo`: HOST_PROC_MOUNTINFO

## RFQ tracking

Transactions calling the RFQ contract (directly, via authz, `MsgExecuteContractCompat` or the atomic RFQ proxy) are exported into:

* `coremon_rfq_txs`: one point per RFQ tx. Tags: `official` (tx carries the r3 taker memo of FE / mobile), `source` (memo `c=`: `w` web, `m` mobile), `memo_fmt`, `kind`, `status`, `err_class`, `err`, `lat_bucket`, `taker`. Fields: `memo_latency_ms` / `memo_blocks_missed` (memo `t`, client timestamp), `rfq_id_latency_ms` / `rfq_id_blocks_missed` (`rfq_id` is the gateway ms timestamp of the RFQ request), `t_minus_rfq_id_ms` (only when both are set), `error`, `stale`, `late_by_ms` (stale rejections: how much sooner the tx had to land).
* `coremon_rfq_quotes`: one point per quote result of `wasm-rfq-accept-quote` (per-quote rejections, incl. `late_by_ms`).
* `coremon_wasm_errors`: every failed wasm tx, by contract, method and normalized innermost error (`err_tpl`).

Blocks missed = `[inclusion height] - (N+1)`, where N is the latest block committed at the client timestamp.

* `COREMON_RFQ_CONTRACTS` (`--rfq-contracts`): RFQ settlement contracts, comma-separated.
* `COREMON_RFQ_PROXY_CONTRACTS` (`--rfq-proxy-contracts`): contracts wrapping RFQ `accept_quote`.
* `COREMON_RFQ_ONLY` (`--rfq-only`): write only the three measurements above (no validator sets fetched), to backfill them without touching other stats.
* `COREMON_STOP_HEIGHT` (`--stop-height`): lowest height for `--reverse`, the process idles after reaching it.

Backfill example (RFQ contract was created at 168980334):

```
COREMON_RFQ_ONLY=true COREMON_STOP_HEIGHT=168980334 coremon process --reverse <height>
```

## Dashboards

* `templates/errors.json`: `<codespace>:<code>` error names used by dashboards. Refresh from injective-core (`make gen-error-docs`) and regenerate with `go generate ./templates`.
* `templates/rfq_dashboards.py`: generates `coremon_rfq.gen.json` (RFQ & WASM errors dashboard) and `coremon_rfq_row.gen.json` (RFQ latency row of the main dashboard).
