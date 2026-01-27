package coremon

import (
	"context"
	"fmt"
	"os/exec"
	"strconv"
	"strings"
	"time"

	"github.com/shirou/gopsutil/v4/disk"
	"github.com/shirou/gopsutil/v4/mem"
	metrics "github.com/xlab/statsd_metrics"
	log "github.com/xlab/suplog"
)

type SysWatcher interface {
	StartWatching()
	Close() error
}

type sysWatcher struct {
	rootCtx    context.Context
	appHomeDir string

	logger     log.Logger
	metricTags metrics.Tags
}

func NewSysWatcher(
	chainID string,
	rootCtx context.Context,
	logger log.Logger,
	appHomeDir string,
) (SysWatcher, error) {
	metricTags := metrics.NewTags(map[string]string{
		"svc":      "coremon",
		"chain_id": chainID,
	})

	return &sysWatcher{
		rootCtx:    rootCtx,
		appHomeDir: appHomeDir,
		logger:     logger,
		metricTags: metricTags,
	}, nil
}

func (w *sysWatcher) StartWatching() {
	defaultWatchInterval := time.Second * 10
	timer := time.NewTimer(defaultWatchInterval)

	for {
		select {
		case <-w.rootCtx.Done():
			return
		case <-timer.C:
			w.measureAndReportSysUsage(w.appHomeDir)
			timer.Reset(defaultWatchInterval)
		}
	}
}

func (w *sysWatcher) measureAndReportSysUsage(appHomeDir string) {
	memUsageTimeout, cancelFn := context.WithTimeout(w.rootCtx, time.Second*10)
	defer cancelFn()

	memUsage, err := mem.VirtualMemoryWithContext(memUsageTimeout)
	if err != nil {
		w.logger.WithFields(log.Fields{
			"root": appHomeDir,
		}).Errorln("Failed to get memory usage.")
		return
	}

	diskUsageTimeout, cancelFn := context.WithTimeout(w.rootCtx, time.Second*10)
	defer cancelFn()

	du, err := disk.UsageWithContext(diskUsageTimeout, appHomeDir)
	if err != nil {
		w.logger.WithFields(log.Fields{
			"root": appHomeDir,
		}).Errorln("Failed to get disk usage.")
		return
	}

	w.logger.WithFields(log.Fields{
		"free_root":         du.Free,
		"total_root":        du.Total,
		"used_root":         du.Used,
		"used_root_percent": du.UsedPercent,
	}).Debugln("Disk usage.")

	w.logger.WithFields(log.Fields{
		"free_mem":         memUsage.Free,
		"total_mem":        memUsage.Total,
		"used_mem":         memUsage.Used,
		"used_mem_percent": memUsage.UsedPercent,
	}).Debugln("Memory usage.")

	getDirDiskUsageBytesCtx, cancelFn := context.WithTimeout(w.rootCtx, time.Second*10)
	defer cancelFn()

	homedirUsageBytes, err := w.getDirDiskUsageBytes(getDirDiskUsageBytesCtx, appHomeDir)
	if err != nil {
		w.logger.WithFields(log.Fields{
			"root": appHomeDir,
		}).Errorln("Failed to get disk usage for dir.")
		return
	}

	w.logger.WithFields(log.Fields{
		"homedir_size": homedirUsageBytes,
	}).Debugf("Disk usage bytes for homedir %s.", appHomeDir)

	// Big fat report considering root space, mem usage, and homedir size.
	// We don't measure CPU there, tbh that'd be very noisy.
	metrics.CustomReport(func(s metrics.Statter, tagSpec []string) {
		s.Gauge("report_sys.free_root", du.Free, tagSpec)
		s.Gauge("report_sys.total_root", du.Total, tagSpec)
		s.Gauge("report_sys.used_root", du.Used, tagSpec)
		s.Gauge("report_sys.used_root_percent", du.UsedPercent, tagSpec)
		s.Gauge("report_sys.free_mem", memUsage.Free, tagSpec)
		s.Gauge("report_sys.total_mem", memUsage.Total, tagSpec)
		s.Gauge("report_sys.used_mem", memUsage.Used, tagSpec)
		s.Gauge("report_sys.used_mem_percent", memUsage.UsedPercent, tagSpec)
		s.Gauge("report_sys.homedir_size", homedirUsageBytes, tagSpec)
	}, w.metricTags.WithBaseTags())
}

// GetDiskUsageBytes runs the 'du -bs' command on the specified path and returns the total bytes used.
// This provides a more accurate measurement of actual disk usage for a specific directory.
func (w *sysWatcher) getDirDiskUsageBytes(ctx context.Context, path string) (uint64, error) {
	cmd := exec.CommandContext(ctx, "du", "-bs", path)
	output, err := cmd.Output()
	if err != nil {
		return 0, fmt.Errorf("failed to execute du command: %w", err)
	}

	// Parse the output which is in format: "294011955703\t/path/to/dir/"
	parts := strings.Fields(string(output))
	if len(parts) < 1 {
		return 0, fmt.Errorf("unexpected du command output format")
	}

	// Convert the first part (bytes) to uint64
	bytes, err := strconv.ParseUint(parts[0], 10, 64)
	if err != nil {
		return 0, fmt.Errorf("failed to parse bytes from du output: %w", err)
	}

	return bytes, nil
}

func (w *sysWatcher) Close() error {
	return nil
}
