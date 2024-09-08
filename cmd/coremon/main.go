package main

import (
	"context"
	"fmt"
	"os"

	cli "github.com/jawher/mow.cli"
	log "github.com/xlab/suplog"

	"github.com/InjectiveLabs/coremon/version"
)

var app = cli.App("coremon", bannerStr+"\nDaemon for Injective Chain monitoring and accurate stats exporting.")

// Global options for the app
var (
	envName *string

	appLogger             = log.Logger(log.DefaultLogger)
	rootCtx, rootCancelFn = context.WithCancel(context.Background())
)

func main() {
	// Allows to set env variables from .env file
	readEnv()

	initGlobalOptions(&envName)
	initLogger(envName, &appLogger)

	app.Command("process", "Start chain blocks processing", processCmd)
	app.Command("version", "Prints versions.", cmdVersion)

	_ = app.Run(os.Args)
}

const bannerStr = `┏┓              
┃ ┏┓┏┓┏┓┏┳┓┏┓┏┓ 
┗┛┗┛┛ ┗ ┛┗┗┗┛┛┗•
`

func cmdVersion(c *cli.Cmd) {
	c.Action = func() {
		fmt.Println(version.Version())
	}
}
