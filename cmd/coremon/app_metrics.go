package main

import (
	"os"
	"time"

	cli "github.com/jawher/mow.cli"
	"github.com/xlab/closer"
	metrics "github.com/xlab/statsd_metrics"
	log "github.com/xlab/suplog"
)

func initMetrics(c *cli.Cmd) {
	var (
		statsdPrefix  *string
		statsdAddr    *string
		statsdEnabled *string
	)

	initStatsdOptions(
		c,
		&statsdPrefix,
		&statsdAddr,
		&statsdEnabled,
	)

	if toBool(*statsdEnabled) {
		appLogger.WithFields(log.Fields{
			"target": *statsdAddr,
		}).Info("statsd reporter is enabled")

		go func() {
			for {
				hostname, _ := os.Hostname()
				err := metrics.Init(
					*statsdAddr,
					checkStatsdPrefix(*statsdPrefix),
					&metrics.StatterConfig{
						EnvName:  *envName,
						HostName: hostname,
					},
				)

				if err != nil {
					appLogger.WithError(err).Warning("failed to init statsd reporter")
					time.Sleep(time.Minute)
					continue
				}

				break
			}

			closer.Bind(func() {
				metrics.Close()
			})
		}()
	} else {
		metrics.Disable()
	}

}
