package main

import (
	"os"

	log "github.com/xlab/suplog"
)

func initLogger(env *string, appLogger *log.Logger) {
	var (
		logFormat  *string
		logVerbose *string
	)

	initLoggerOptions(
		&logFormat,
		&logVerbose,
	)

	var logger log.Logger

	if *logFormat == "json" {
		logger = log.NewLogger(
			os.Stderr,
			&log.JSONFormatter{},
		)
	} else {
		logger = log.NewLogger(
			os.Stderr,
			&log.TextFormatter{},
		)
	}

	if toBool(*logVerbose) {
		(logger.(LevelledLogger)).SetLevel(log.DebugLevel)
	} else {
		(logger.(LevelledLogger)).SetLevel(log.InfoLevel)
	}

	*appLogger = logger
	return
}

type LevelledLogger interface {
	SetLevel(level log.Level)
}
