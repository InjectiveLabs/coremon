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
make buildx

# optionally
make buildx-push
```

Use GH pipeline to push a proper release into registry.

## Env Watching

* `COREMON_APP_HOME` (also `-H` flag):  Specify the home directory for the injectived to watch its disk space usage.

You can set alternative locations for various system directories by using the following environment variables:

* `/`: HOST_ROOT
* `/proc/N/mountinfo`: HOST_PROC_MOUNTINFO
