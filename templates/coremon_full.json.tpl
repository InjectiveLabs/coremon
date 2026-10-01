{{- define "error_overrides" -}}
{{- range $idx, $err := .Errors -}}
{{- if $idx}},{{end -}}
{"matcher":{"id":"byName","options":{{json $err.SeriesName}}},"properties":[{"id":"displayName","value":{{json $err.DisplayName}}}]}
{{- end -}}
{{- end -}}
{{- define "validator_overrides" -}}
{{- range $idx, $validator := .Validators -}}
{{- if $idx}},{{end -}}
{"matcher":{"id":"byName","options":{{json $validator.Address}}},"properties":[{"id":"displayName","value":{{json $validator.DisplayName}}}]}
{{- end -}}
{{- end -}}
{{- define "validator_options" -}}
{{- range $idx, $validator := .Validators -}}
{{- if $idx}},{{end -}}
{"selected":false,"text":{{json $validator.DisplayName}},"value":{{json $validator.Address}}}
{{- end -}}
{{- end -}}
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "grafana",
          "uid": "-- Grafana --"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations \u0026 Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "id": 4,
  "links": [],
  "panels": [
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 8,
      "panels": [],
      "title": "Useful",
      "type": "row"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 50,
            "gradientMode": "opacity",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 5,
        "w": 12,
        "x": 0,
        "y": 1
      },
      "id": 1,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "Last",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "last"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Block Height",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "decimals": 2,
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 3000
              }
            ]
          },
          "unit": "ms"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "blocktime_median"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "green",
                  "mode": "fixed"
                }
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "blocktime_pct99.95"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "yellow",
                  "mode": "fixed"
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 12,
        "y": 1
      },
      "id": 2,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "blocktime_pct99.95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [
                  "99.95"
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "blocktime_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Block Time",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 17,
        "w": 12,
        "x": 0,
        "y": 6
      },
      "id": 28,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_msg_name",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "msg_name::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_tx_msgs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "tx_idx"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Messages Processed",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 4194304
              }
            ]
          },
          "unit": "bytes"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 6,
        "w": 12,
        "x": 12,
        "y": 11
      },
      "id": 7,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "txn_bytes_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_bytes"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "txn_bytes_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_bytes"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "txn_bytes_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_bytes"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Transactions Bytes (Total)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "decimals": 2,
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 6,
        "w": 12,
        "x": 12,
        "y": 17
      },
      "id": 5,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "tpb_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "tpb_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "tpb_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Tx Per Block",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "All transactions broken down into error codes, stacked\nSuccessful transactions are in a separate layer to provide the volume baseline.",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 60,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "success"
            },
            "properties": [
              {
                "id": "custom.stacking",
                "value": {
                  "group": "A",
                  "mode": "none"
                }
              },
              {
                "id": "custom.lineWidth",
                "value": 2
              },
              {
                "id": "custom.lineStyle"
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              },
              {
                "id": "custom.drawStyle",
                "value": "line"
              },
              {
                "id": "color",
                "value": {
                  "fixedColor": "super-light-green",
                  "mode": "fixed"
                }
              },
              {
                "id": "custom.gradientMode",
                "value": "opacity"
              }
            ]
          },
          {{ template "error_overrides" . }}
        ]
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 23
      },
      "id": 12,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": false,
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "success",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "codespace::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "code::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "tx_id"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "=",
              "value": "0"
            }
          ]
        },
        {
          "alias": "$tag_codespace:$tag_code",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "codespace::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "code::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "error"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "\u003c\u003e",
              "value": "0"
            }
          ]
        }
      ],
      "title": "Transaction Errors",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 150000000
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "gas_max"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gas_pct95"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gas_avg"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 23
      },
      "id": 6,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "gas_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_gas"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "gas_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_gas"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "gas_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_gas"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "gas_wanted_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_gas_wanted"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Transactions Gas (Total)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "block_time"
            },
            "properties": [
              {
                "id": "unit",
                "value": "ms"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "block_time"
            },
            "properties": [
              {
                "id": "thresholds",
                "value": {
                  "mode": "absolute",
                  "steps": [
                    {
                      "color": "green",
                      "value": 0
                    },
                    {
                      "color": "red",
                      "value": 5
                    }
                  ]
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 31
      },
      "id": 10,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "none"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "query": "SELECT max(\"time_diff\") FROM \"coremon_block_report\" WHERE (\"chain_id\"::tag =~ /^$ChainID$/) AND $timeFilter GROUP BY time($Interval), \"height\"::field",
          "rawQuery": false,
          "refId": "A",
          "resultFormat": "table",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              },
              {
                "params": [
                  "block_time"
                ],
                "type": "alias"
              }
            ],
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Slow blocks (top-100, ≥1.2s)",
      "transformations": [
        {
          "id": "sortBy",
          "options": {
            "fields": {},
            "sort": [
              {
                "desc": true,
                "field": "block_time"
              }
            ]
          }
        },
        {
          "id": "filterByValue",
          "options": {
            "filters": [
              {
                "config": {
                  "id": "greater",
                  "options": {
                    "value": "1200"
                  }
                },
                "fieldName": "block_time"
              }
            ],
            "match": "any",
            "type": "include"
          }
        },
        {
          "id": "limit",
          "options": {
            "limitField": "100"
          }
        }
      ],
      "type": "table"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 50,
            "gradientMode": "opacity",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "decimals": 2,
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "total_max"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "dark-red",
                  "mode": "fixed"
                }
              },
              {
                "id": "custom.fillOpacity",
                "value": 0
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 31
      },
      "id": 20,
      "options": {
        "legend": {
          "calcs": [
            "max"
          ],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "block_events_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "block_events"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "block_events_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "block_events"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "block_events_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "block_events"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "tx_events_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_events"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "tx_events_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "E",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_events"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "tx_events_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "F",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_events"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "total_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "query": "SELECT max(\"txs_events\") + max(\"block_events\") FROM \"coremon_block_report\" WHERE (\"chain_id\"::tag =~ /^$ChainID$/) AND $timeFilter GROUP BY time($Interval) fill(null)",
          "rawQuery": true,
          "refId": "G",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_events"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Events Per Block",
      "type": "timeseries"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 39
      },
      "id": 33,
      "panels": [],
      "title": "BFT Performance",
      "type": "row"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Sum all missed rounds and group by block proposer. \nShows that the biggest contributor to potential round issues is the block contents that can't be processed in time, no matter which proposer it was.",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisSoftMax": 3,
            "axisSoftMin": -3,
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 52,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {{ template "validator_overrides" . }}
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 40
      },
      "id": 41,
      "options": {
        "legend": {
          "calcs": [
            "min",
            "max",
            "mean",
            "sum",
            "diff"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Mean",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_validator",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "validator::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "none"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_validator_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "std_dev_distance"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "validator::tag",
              "operator": "=~",
              "value": "/^$Validators$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        }
      ],
      "title": "[Validator Perf] StdDev per Validator Sig Timestamp",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": true,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisWidth": 0,
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 4194304
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "max slow time \u003e1.2s"
            },
            "properties": [
              {
                "id": "unit",
                "value": "ms"
              },
              {
                "id": "custom.drawStyle",
                "value": "line"
              },
              {
                "id": "custom.gradientMode",
                "value": "opacity"
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              },
              {
                "id": "custom.axisColorMode",
                "value": "text"
              },
              {
                "id": "color",
                "value": {
                  "fixedColor": "dark-yellow",
                  "mode": "fixed"
                }
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "rounds missed"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "dark-red",
                  "mode": "fixed"
                }
              },
              {
                "id": "custom.lineWidth",
                "value": 1
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slow blocks \u003e1.2s"
            },
            "properties": [
              {
                "id": "custom.axisColorMode",
                "value": "text"
              },
              {
                "id": "custom.fillOpacity",
                "value": 48
              },
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.gradientMode",
                "value": "none"
              },
              {
                "id": "color",
                "value": {
                  "fixedColor": "text",
                  "mode": "fixed"
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 12,
        "y": 40
      },
      "id": 34,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "slow blocks \u003e1.2s",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "query": "SELECT count(\"height\") FROM \"coremon_block_report\" WHERE (\"chain_id\"::tag =~ /^$ChainID$/ AND \"time_diff\"::field \u003e 1200) AND $timeFilter GROUP BY time($Interval) fill(null)",
          "rawQuery": false,
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "time_diff::field",
              "operator": "\u003e",
              "value": "1200"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        },
        {
          "alias": "rounds missed",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "rounds_missed"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        },
        {
          "alias": "max slow time \u003e1.2s",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "query": "SELECT count(\"height\") FROM \"coremon_block_report\" WHERE (\"chain_id\"::tag =~ /^$ChainID$/ AND \"time_diff\"::field \u003e 1200) AND $timeFilter GROUP BY time($Interval) fill(null)",
          "rawQuery": false,
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "time_diff::field",
              "operator": "\u003e",
              "value": "1200"
            }
          ]
        }
      ],
      "title": "Block Rounds Missed vs Block Time",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": true,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisWidth": 0,
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {{ template "validator_overrides" . }},
          {
            "matcher": {
              "id": "byName",
              "options": "all_blocks"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "line"
              },
              {
                "id": "custom.gradientMode",
                "value": "opacity"
              },
              {
                "id": "color",
                "value": {
                  "fixedColor": "green",
                  "mode": "shades"
                }
              },
              {
                "id": "custom.stacking",
                "value": {
                  "group": "A",
                  "mode": "none"
                }
              },
              {
                "id": "custom.lineWidth",
                "value": 1
              },
              {
                "id": "custom.fillOpacity",
                "value": 0
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 12,
        "y": 49
      },
      "id": 43,
      "options": {
        "legend": {
          "calcs": [
            "max",
            "mean",
            "sum"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_validator",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "validator::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "none"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_validator_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "sig_missing"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "validator::tag",
              "operator": "=~",
              "value": "/^$Validators$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        },
        {
          "alias": "all_blocks",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_validator_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              },
              {
                "params": [
                  " / 60"
                ],
                "type": "math"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "[Validator Perf] Missing Signatures per Validator",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": true,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisWidth": 0,
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "decimals": 2,
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 3000
              }
            ]
          },
          "unit": "ms"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "blocktime_median"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "green",
                  "mode": "fixed"
                }
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "blocktime_pct99.95"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "yellow",
                  "mode": "fixed"
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 6,
        "w": 12,
        "x": 0,
        "y": 50
      },
      "id": 37,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "blocktime_pct99.95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [
                  "99.95"
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        },
        {
          "alias": "blocktime_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        }
      ],
      "title": "Block Time",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": true,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisWidth": 0,
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "decimals": 2,
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 500
              }
            ]
          },
          "unit": "ms"
        },
        "overrides": [
          {{ template "validator_overrides" . }}
        ]
      },
      "gridPos": {
        "h": 13,
        "w": 12,
        "x": 0,
        "y": 56
      },
      "id": 44,
      "options": {
        "legend": {
          "calcs": [
            "sum",
            "stdDev",
            "max"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Max",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "none"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_proposer",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "proposer::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "round_dur"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        }
      ],
      "title": "Median Last Commit Round Duration",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 52,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {{ template "validator_overrides" . }}
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 12,
        "y": 59
      },
      "id": 42,
      "options": {
        "legend": {
          "calcs": [
            "max",
            "mean",
            "sum"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_validator",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "validator::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "none"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_validator_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "sig_skipped"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "validator::tag",
              "operator": "=~",
              "value": "/^$Validators$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        }
      ],
      "title": "[Validator Perf] Skipped Signatures per Validator",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": true,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "axisWidth": 0,
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "decimals": 2,
          "fieldMinMax": false,
          "mappings": [],
          "min": 0,
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 3000
              }
            ]
          },
          "unit": "ms"
        },
        "overrides": [
          {{ template "validator_overrides" . }}
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 69
      },
      "id": 55,
      "options": {
        "legend": {
          "calcs": [
            "sum",
            "min",
            "max",
            "stdDev",
            "mean"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Max",
          "sortDesc": false
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "single",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_proposer",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "proposer::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "time_diff"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "proposer::tag",
              "operator": "=~",
              "value": "/^$Proposers$/"
            }
          ]
        }
      ],
      "title": "Median Block Time per Proposer",
      "type": "timeseries"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 79
      },
      "id": 30,
      "panels": [],
      "title": "Client Errors",
      "type": "row"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Successful transactions are in a separate layer to provide the volume baseline.",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 60,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "success"
            },
            "properties": [
              {
                "id": "custom.stacking",
                "value": {
                  "group": "A",
                  "mode": "none"
                }
              },
              {
                "id": "custom.lineWidth",
                "value": 1
              },
              {
                "id": "custom.lineStyle"
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              },
              {
                "id": "custom.drawStyle",
                "value": "line"
              },
              {
                "id": "color",
                "value": {
                  "fixedColor": "super-light-green",
                  "mode": "fixed"
                }
              },
              {
                "id": "custom.gradientMode",
                "value": "opacity"
              }
            ]
          },
          {{ template "error_overrides" . }},
          {
            "matcher": {
              "id": "byName",
              "options": ""
            },
            "properties": []
          }
        ]
      },
      "gridPos": {
        "h": 13,
        "w": 12,
        "x": 0,
        "y": 80
      },
      "id": 29,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_sender",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "sender::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "error"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "\u003c\u003e",
              "value": "0"
            },
            {
              "condition": "AND",
              "key": "sender::tag",
              "operator": "=~",
              "value": "/^inj1.*/"
            }
          ]
        },
        {
          "alias": "success",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "tx_id"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "=",
              "value": "0"
            }
          ]
        }
      ],
      "title": "Errors Per Sender",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Successful transactions are in a separate layer to provide the volume baseline.",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 60,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "success"
            },
            "properties": [
              {
                "id": "custom.stacking",
                "value": {
                  "group": "A",
                  "mode": "none"
                }
              },
              {
                "id": "custom.lineWidth",
                "value": 1
              },
              {
                "id": "custom.lineStyle"
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              },
              {
                "id": "custom.drawStyle",
                "value": "line"
              },
              {
                "id": "color",
                "value": {
                  "fixedColor": "super-light-green",
                  "mode": "fixed"
                }
              },
              {
                "id": "custom.gradientMode",
                "value": "opacity"
              }
            ]
          },
          {{ template "error_overrides" . }},
          {
            "matcher": {
              "id": "byName",
              "options": ""
            },
            "properties": []
          }
        ]
      },
      "gridPos": {
        "h": 13,
        "w": 12,
        "x": 12,
        "y": 80
      },
      "id": 31,
      "options": {
        "legend": {
          "calcs": [
            "sum"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_subaccount_id",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "subaccount_id::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "error"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "\u003c\u003e",
              "value": "0"
            },
            {
              "condition": "AND",
              "key": "sender::tag",
              "operator": "=~",
              "value": "/^inj1.*/"
            }
          ]
        },
        {
          "alias": "success",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "tx_id"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "=",
              "value": "0"
            }
          ]
        }
      ],
      "title": "Errors Per Subaccount",
      "type": "timeseries"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 93
      },
      "id": 15,
      "panels": [],
      "title": "App Breakdown",
      "type": "row"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Count of events grouped by event type from Finalize Block Events. Only Injective modules",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 12,
        "w": 12,
        "x": 0,
        "y": 94
      },
      "id": 16,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_ev_type",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "ev_type::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_events",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "ev_type::tag",
              "operator": "=~",
              "value": "/injective.*/"
            }
          ]
        }
      ],
      "title": "Block Events (Injective) (Total, Stacked)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Count of events grouped by event type from Tx Events. Only Injective modules",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "wasm"
            },
            "properties": [
              {
                "id": "color",
                "value": {
                  "fixedColor": "text",
                  "mode": "fixed"
                }
              },
              {
                "id": "custom.drawStyle",
                "value": "line"
              },
              {
                "id": "custom.fillOpacity",
                "value": 50
              },
              {
                "id": "custom.lineWidth",
                "value": 2
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 12,
        "w": 12,
        "x": 12,
        "y": 94
      },
      "id": 17,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_ev_type",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "ev_type::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_tx_events",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "ev_type::tag",
              "operator": "=~",
              "value": "/injective.*/"
            }
          ]
        },
        {
          "alias": "wasm",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "none"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_tx_events",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "ev_type::tag",
              "operator": "=~",
              "value": "/wasm.*/"
            }
          ]
        }
      ],
      "title": "Tx Events (Injective) (Total, Stacked)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Count of events grouped by event type from Finalize Block Events. Filtered without Injective modules",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 106
      },
      "id": 14,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_ev_type",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "ev_type::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_events",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "ev_type::tag",
              "operator": "!~",
              "value": "/injective.*/"
            }
          ]
        }
      ],
      "title": "Block Events (SDK) (Total)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "Count of events grouped by event type from Tx Events. Filtered without Injective modules and WASM dApps",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 0,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 12,
        "y": 106
      },
      "id": 18,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_ev_type",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "ev_type::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_tx_events",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "height"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "count"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "ev_type::tag",
              "operator": "!~",
              "value": "/injective.*/"
            },
            {
              "condition": "AND",
              "key": "ev_type::tag",
              "operator": "!~",
              "value": "/wasm.*/"
            }
          ]
        }
      ],
      "title": "Tx Events (SDK) (Total)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 116
      },
      "id": 23,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_msg_name.$tag_arity_field",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "arity_field::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "msg_name::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_tx_msg_arity",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "arity"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Batch Messages Arity (Total, Per Field)",
      "transformations": [
        {
          "id": "renameByRegex",
          "options": {
            "regex": "/injective.exchange.v1beta1.(.*)/",
            "renamePattern": "$1"
          }
        }
      ],
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "description": "",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 12,
        "y": 116
      },
      "id": 24,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_ev_type.$tag_arity_field",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "arity_field::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "ev_type::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_event_arity",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "arity"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "$tag_ev_type.$tag_arity_field",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "arity_field::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "ev_type::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_tx_event_arity",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "arity"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Batch Events Arity (Total, Per Field)",
      "transformations": [
        {
          "id": "renameByRegex",
          "options": {
            "regex": "/injective.exchange.v1beta1.(.*)/",
            "renamePattern": "$1"
          }
        }
      ],
      "type": "timeseries"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 126
      },
      "id": 51,
      "panels": [],
      "title": "Chain Fees Study",
      "type": "row"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 65,
            "gradientMode": "opacity",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "min": 0,
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 16,
        "w": 12,
        "x": 0,
        "y": 127
      },
      "id": 49,
      "options": {
        "legend": {
          "calcs": [
            "min",
            "max",
            "mean",
            "stdDev"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Name",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_msg_name",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "msg_name::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "gas_used"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "raw_msgs::field",
              "operator": "\u003c",
              "value": "2"
            },
            {
              "condition": "AND",
              "key": "authz_msgs::field",
              "operator": "\u003e",
              "value": "0"
            },
            {
              "condition": "AND",
              "key": "msg_name::tag",
              "operator": "=~",
              "value": "/^injective|^cosmos/"
            },
            {
              "condition": "AND",
              "key": "code::tag",
              "operator": "=",
              "value": "0"
            }
          ]
        }
      ],
      "title": "Gas Per Message (with Authz, Median)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "INJ"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 127
      },
      "id": 47,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "txns_fee_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_fee"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              },
              {
                "params": [
                  " / 1000000000"
                ],
                "type": "math"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "txns_fee_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_fee"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              },
              {
                "params": [
                  " / 1000000000"
                ],
                "type": "math"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "txns_fee_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_block_report",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "txs_fee"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              },
              {
                "params": [
                  " / 1000000000"
                ],
                "type": "math"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Gas Fee Per Block",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 50
              }
            ]
          },
          "unit": "nINJ"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 135
      },
      "id": 52,
      "options": {
        "legend": {
          "calcs": [
            "min",
            "max",
            "mean"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Max",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_fee_spender",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "fee_spender::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "gas_price"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "fee_spender::tag",
              "operator": "=~",
              "value": "/^inj1/"
            },
            {
              "condition": "AND",
              "key": "gas_price::field",
              "operator": "\u003e",
              "value": "1"
            }
          ]
        }
      ],
      "title": "Gas Price Fools",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 65,
            "gradientMode": "opacity",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "min": 0,
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 16,
        "w": 12,
        "x": 0,
        "y": 143
      },
      "id": 50,
      "options": {
        "legend": {
          "calcs": [
            "min",
            "max",
            "mean",
            "stdDev"
          ],
          "displayMode": "table",
          "placement": "bottom",
          "showLegend": true,
          "sortBy": "Name",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_msg_name",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "msg_name::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "gas_used"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            },
            {
              "condition": "AND",
              "key": "raw_msgs::field",
              "operator": "\u003c",
              "value": "2"
            },
            {
              "condition": "AND",
              "key": "authz_msgs::field",
              "operator": "\u003c",
              "value": "1"
            },
            {
              "condition": "AND",
              "key": "code",
              "operator": "=",
              "value": "0"
            }
          ]
        }
      ],
      "title": "Gas Per Message (no Authz, Median)",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 150000000
              }
            ]
          },
          "unit": "short"
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "price_max"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "price_pct95"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "price_median"
            },
            "properties": [
              {
                "id": "custom.drawStyle",
                "value": "bars"
              },
              {
                "id": "custom.lineWidth",
                "value": 0
              },
              {
                "id": "custom.fillOpacity",
                "value": 100
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 143
      },
      "id": 46,
      "options": {
        "legend": {
          "calcs": [
            "min"
          ],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "price_max",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "gas_price"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "max"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "price_pct95",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "gas_price"
                ],
                "type": "field"
              },
              {
                "params": [
                  95
                ],
                "type": "percentile"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        },
        {
          "alias": "price_median",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "hide": false,
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "gas_price"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "median"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Transactions Gas Price",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "dashed"
            }
          },
          "mappings": [],
          "min": 0,
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              }
            ]
          },
          "unit": "INJ"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 151
      },
      "id": 48,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "fee",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_txs",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "fee"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "sum"
              },
              {
                "params": [
                  " / 1000000000"
                ],
                "type": "math"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Fee Collected",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "febedkgp47y0wa"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisBorderShow": false,
            "axisCenteredZero": false,
            "axisColorMode": "text",
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "barWidthFactor": 0.6,
            "drawStyle": "bars",
            "fillOpacity": 100,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 0,
            "pointSize": 1,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "normal"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": 0
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 159
      },
      "id": 53,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom",
          "showLegend": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "$tag_msg_name.$tag_arity_field",
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "groupBy": [
            {
              "params": [
                "$Interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "arity_field::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "msg_name::tag"
              ],
              "type": "tag"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "coremon_tx_msg_arity",
          "orderByTime": "ASC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "arity"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "chain_id::tag",
              "operator": "=~",
              "value": "/^$ChainID$/"
            }
          ]
        }
      ],
      "title": "Batch Messages Arity (Mean, Per Field)",
      "transformations": [
        {
          "id": "renameByRegex",
          "options": {
            "regex": "/injective.exchange.v1beta1.(.*)/",
            "renamePattern": "$1"
          }
        }
      ],
      "type": "timeseries"
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 169
      },
      "id": 9,
      "panels": [
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "decimals": 2,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 160
          },
          "id": 27,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "tps_observed",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "txs_throughput"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Abs Tx Throughput (tps per block)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 160
          },
          "id": 4,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "txns",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "txs"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "sum"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Transactions Processed",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "cebedhz865erkd"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "decimals": 2,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 168
          },
          "id": 3,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "tps_observed",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_report_observed_txs_throughput",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Observed Tx Throughput (tps)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "Count of events grouped by event type from WASM module and dApps.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "normal"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 168
          },
          "id": 19,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "wasm",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "coremon_tx_events",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "ev_type::tag",
                  "operator": "=~",
                  "value": "/wasm.*/"
                }
              ]
            },
            {
              "alias": "$tag_ev_type",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "ev_type::tag"
                  ],
                  "type": "tag"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": true,
              "measurement": "coremon_tx_events",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "ev_type::tag",
                  "operator": "=~",
                  "value": "/wasm.*/"
                }
              ]
            }
          ],
          "title": "WASM Events (Total)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "cebedhz865erkd"
          },
          "description": "https://sentry.tm.injective.network:443",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "decimals": 2,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 176
          },
          "id": 11,
          "links": [
            {
              "targetBlank": true,
              "title": "RPC",
              "url": "https://sentry.tm.injective.network:443"
            }
          ],
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "ingest_latency_median",
              "datasource": {
                "type": "influxdb",
                "uid": "cebedhz865erkd"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_report_ingest_latency",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "median"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "last"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "ingest_latency_pct99",
              "datasource": {
                "type": "influxdb",
                "uid": "cebedhz865erkd"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_report_ingest_latency",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "99_percentile"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "last"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Observed Ingest Latency",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 100,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 0,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "normal"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 176
          },
          "id": 13,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "tx_events",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "coremon_tx_events",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "block_events",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "none"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_events",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Events Emitted (Total, Stacked)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "cebedhz865erkd"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "decimals": 2,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 184
          },
          "id": 21,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "ingest_latency_median",
              "datasource": {
                "type": "influxdb",
                "uid": "cebedhz865erkd"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_report_block_handler_dur",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "median"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "last"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "ingest_latency_pct99",
              "datasource": {
                "type": "influxdb",
                "uid": "cebedhz865erkd"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_report_block_handler_dur",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "99_percentile"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "last"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Report Block Handler Duration",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 50,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "decimals": 2,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "total_max"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "dark-red",
                      "mode": "fixed"
                    }
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 0
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 184
          },
          "id": 22,
          "options": {
            "legend": {
              "calcs": [
                "max"
              ],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "block_events_max",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_event_arity",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "C",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "arity"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "max"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "block_events_pct95",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_event_arity",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "arity"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [
                      95
                    ],
                    "type": "percentile"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "block_events_median",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_event_arity",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "arity"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "median"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "tx_events_max",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_tx_event_arity",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "D",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "arity"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "max"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "tx_events_pct95",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_tx_event_arity",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "E",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "arity"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [
                      95
                    ],
                    "type": "percentile"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "tx_events_median",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_tx_event_arity",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "F",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "arity"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "median"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Events Arity",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "100% of all active set signatures classified by type, per block.\n\nSkipped means proposer was slow, so validator skipped singing to submit  keep-alive.\n\nMissing means validator was slow to process the proposal in time and commit signature back.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 69,
                "gradientMode": "opacity",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 1,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 0.1
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 6,
            "w": 12,
            "x": 0,
            "y": 192
          },
          "id": 36,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": false,
              "sortBy": "StdDev",
              "sortDesc": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "skipped_out_of_60_avg",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_skipped"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  },
                  {
                    "params": [
                      " / 60"
                    ],
                    "type": "math"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_skipped::field",
                  "operator": "\u003e",
                  "value": "0"
                }
              ]
            },
            {
              "alias": "missing_out_of_60_avg",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "C",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_missing"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  },
                  {
                    "params": [
                      " / 60"
                    ],
                    "type": "math"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_missing::field",
                  "operator": "\u003e",
                  "value": "0"
                }
              ]
            },
            {
              "alias": "ok_out_of_60_avg",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_ok"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  },
                  {
                    "params": [
                      " / 60"
                    ],
                    "type": "math"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_ok::field",
                  "operator": "\u003e",
                  "value": "0"
                }
              ]
            }
          ],
          "title": "[Validator Perf] Last Commit Signature Distribution Peaks",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 100,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 0,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "normal"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 12,
            "w": 12,
            "x": 12,
            "y": 192
          },
          "id": 26,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "$tag_ev_type",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "ev_type::tag"
                  ],
                  "type": "tag"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "coremon_tx_events",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "ev_type::tag",
                  "operator": "=~",
                  "value": "/wasm.*/"
                }
              ]
            }
          ],
          "title": "WASM Events Breakdown (Total, Stacked)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "Sum all missed rounds and group by block proposer. \nShows that the biggest contributor to potential round issues is the block contents that can't be processed in time, no matter which proposer it was.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 62,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 0,
                "pointSize": 1,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "normal"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "ok_baseline"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 12
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "%_skipped_avg"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 0
                  },
                  {
                    "id": "custom.lineWidth",
                    "value": 1
                  },
                  {
                    "id": "custom.gradientMode",
                    "value": "none"
                  },
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "yellow",
                      "mode": "fixed"
                    }
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {{ template "validator_overrides" . }}
            ]
          },
          "gridPos": {
            "h": 5,
            "w": 12,
            "x": 0,
            "y": 198
          },
          "id": 39,
          "options": {
            "legend": {
              "calcs": [
                "max",
                "sum",
                "mean"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": false,
              "sortBy": "Total",
              "sortDesc": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "$tag_proposer",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "proposer::tag"
                  ],
                  "type": "tag"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "rounds_missed"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "sum"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            }
          ],
          "title": "[Validator Perf] Rounds Missed Per Block Proposer",
          "transformations": [
            {
              "id": "filterFieldsByName",
              "options": {
                "byVariable": false,
                "include": {
                  "names": [
                    "Time",
                    "0333D22DCA302543BCD1F5A1444CC80388DC9BA6",
                    "03E0A1287B25629B36D6AA29E2E1F0CE00114162",
                    "04A437062C409FA51EC98A4DD649394BD18BDAD7",
                    "17EB7B0873CCD83EA77A62C34FF84A910C5F3CE0",
                    "1834E8A2FDE4644999EED5BD4B99B4A9A22C4351",
                    "1B85A5FFDC65A23DFB51A32DC1087DCA515EA6CC",
                    "2620065FADD91C5E06AF25A3B7F864483BA1C3B9",
                    "27D87AAA17B86AF55C7E6EC4FB637937FEF39FB2",
                    "307CB9AA68447995515D2AE44EFA82966715B057",
                    "33ED396C904DD8E9A1C2A43FB37C14F5DFDB6E8A",
                    "37B3F9E462967F150F5BF98A7A355F3531B58D12",
                    "37CE71AD8CD4DC01D8798E103A70978591708169",
                    "39633DD07F87E216E0CAD01E0BE216E22F89AB3F",
                    "477858E6BF7E36ADB6062D224A0B06B7B4E5C26E",
                    "545768F1C4F1EE3E7EF93DE8E59FD57A506CEE92",
                    "5A22FB1E69D783401ED3CE77DD3C3D44EDB2E093",
                    "6087607E1E56F6EE7934ABAF65834C92D618104C",
                    "6249218CF53ED5FD3598554F828EC31BB203937E",
                    "6460844B2C81E87F3E2A10667787BB7600CFA970",
                    "66D5C09144B6614E9201E8B7E0931B4D0528541B",
                    "6A7EEC86B32DB79B018BE735ACA63BA5E4FD729A",
                    "6C56084E1CFA331628C8EB1DA6F865922457A975",
                    "75BC207881F939F712C73F0DED5EAAB029F19B2C",
                    "7781FA16ADC57E109F63BD1E29F14F9D3817E14A",
                    "77D3FF15AD886E93068C09F5E5C643537511A3A5",
                    "7A6A9DEE7D8F3BAA83F2C3A0179D74ED1487932C",
                    "7D2D96C14632861337AA62C0EF4E3CA096CE1665",
                    "7DD51A5DA067E9A95FB82E02D5A41A51ADD1EF46",
                    "8E2C70D2292FB3624BAF1F0CFBCB025D2ECC8AFB",
                    "93739258C5626903BA444128CFB7439AA31AA93F",
                    "9AAC0790FFF74F4050DBBBB55EBF59BF134C4038",
                    "9B4E4CD4B66A3E507BB49441291DD838284CEB35",
                    "9DFCC2E344433CBF2DA533E871EDF765E28FB74E",
                    "A2EB44E8F5A9289C2C4E10855F2DC19582F55765",
                    "B62687D180445D5CF84E1A2E85DB2ACAEEFCB19A",
                    "B6CD0957B63DB73E8AC0E51CD0DE53AF40AC47D7",
                    "B785C7308D551BD1B227981BF938FE8AD3D3E3AF",
                    "BBB6B7EB2D754EC2957CA5615DD5AB79415B0B1A",
                    "C07DCD3B5ABE8573BAA616F9DD0E3FCD8EC1F671",
                    "CB807691C50A3B28DABBBBEBAB143A2F36C7C6E3",
                    "CDF55ACD97B31A67662BD0BEBC673E5B5FAAEC04",
                    "D0C143A237A69569CC7CECB0DAC2EA95F88B26B3",
                    "D1CE87BBE89B737495416E8C44B9F58D2372D5D1",
                    "D2ECA4D0345C1107BEAD58D66F3DD1ACCF7618ED",
                    "D857A4BA9745354D9FC1DF91A82CDB87A27563A6",
                    "D8DA9CB98162675E9DEB388EE17C360D702D5B96",
                    "DBDEA0E43C9EB037422D0E27C3FFEDF8692E9C97",
                    "DC65D4AD5B754D643C733470DCC7A44B9FB4DCA5",
                    "DD2C988B278E526870DD97D7BA75EEAA2FEBD55D",
                    "E353C5C89FB60D2EBFC2F238F1CC11673C980E45",
                    "E411277DCD8DEF23ED5BCA3F1FEC169FDB10EF7B",
                    "E6643CC7E375FF889EAA59F7FCB93F4DE35403DB",
                    "E972901583CC003C4C388EF2E6F5570ABF0D5B75",
                    "EC975EDDA923754C6BA6044DC6041B35D7AD92CF",
                    "F39BF9316C07E4F27EE31951F720783C58D09C11",
                    "F530BDDB1CF813670A6F6F1E574474D4C91385F5",
                    "FEAA42B0C3582CF9EBE4BD52082B90636C8BF3A5"
                  ]
                }
              }
            },
            {
              "id": "filterByValue",
              "options": {
                "filters": [],
                "match": "any",
                "type": "exclude"
              }
            }
          ],
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "Count and sum of all missed signatures as reported in the last commit. Means that validators didn't have time to process proposal. This is grouped by proposer. \n\nLastly, it shows % of missed signatures per proposer's block.\n\nSo, this highlights slow proposers.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "line",
                "fillOpacity": 47,
                "gradientMode": "hue",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 1,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "mappings": [],
              "max": 1,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 0.1
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": [
              {{ template "validator_overrides" . }},
              {
                "matcher": {
                  "id": "byName",
                  "options": "blocks_proposed"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "bars"
                  },
                  {
                    "id": "custom.lineWidth",
                    "value": 0
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 100
                  },
                  {
                    "id": "color",
                    "value": {
                      "mode": "palette-classic"
                    }
                  },
                  {
                    "id": "custom.gradientMode",
                    "value": "opacity"
                  },
                  {
                    "id": "max"
                  },
                  {
                    "id": "unit",
                    "value": "short"
                  },
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "yellow",
                      "mode": "fixed"
                    }
                  },
                  {
                    "id": "min",
                    "value": 0
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 0,
            "y": 203
          },
          "id": 40,
          "options": {
            "legend": {
              "calcs": [
                "max",
                "sum",
                "mean"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "$tag_proposer",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "proposer::tag"
                  ],
                  "type": "tag"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_missing_pct"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            },
            {
              "alias": "blocks_proposed",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            }
          ],
          "title": "[Validator Perf] Missing Signatures Per Block Proposal",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 100,
                "gradientMode": "hue",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 0,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "decimals": 2,
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 3000
                  }
                ]
              },
              "unit": "ms"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "blocktime_median"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "green",
                      "mode": "fixed"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "blocktime_pct99.95"
                },
                "properties": [
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "yellow",
                      "mode": "fixed"
                    }
                  }
                ]
              }
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 12,
            "y": 204
          },
          "id": 54,
          "options": {
            "legend": {
              "calcs": [
                "min",
                "max",
                "mean"
              ],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "blocktime_mean",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "time_diff"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            }
          ],
          "title": "Mean Block Time",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "Count and sum of all missed signatures as reported in the last commit. Means that validators didn't have time to process proposal. This is grouped by proposer. \n\nLastly, it shows % of missed signatures per proposer's block.\n\nSo, this highlights slow proposers.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 62,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 0,
                "pointSize": 1,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "normal"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 0.1
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "ok_baseline"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 12
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "%_missing_avg"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 0
                  },
                  {
                    "id": "custom.lineWidth",
                    "value": 1
                  },
                  {
                    "id": "custom.gradientMode",
                    "value": "none"
                  },
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "yellow",
                      "mode": "fixed"
                    }
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {{ template "validator_overrides" . }}
            ]
          },
          "gridPos": {
            "h": 10,
            "w": 12,
            "x": 0,
            "y": 213
          },
          "id": 38,
          "options": {
            "legend": {
              "calcs": [
                "max",
                "sum",
                "mean"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true,
              "sortBy": "Total",
              "sortDesc": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "all_blocks",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "D",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            },
            {
              "alias": "sig_missing",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_missing"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "sum"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_missing::field",
                  "operator": "\u003e",
                  "value": "0"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            },
            {
              "alias": "$tag_proposer",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "proposer::tag"
                  ],
                  "type": "tag"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_missing"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "sum"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_missing::field",
                  "operator": "\u003e",
                  "value": "0"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            }
          ],
          "title": "[Validator Perf] Missing Signatures Per Block Proposal",
          "transformations": [
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": {
                    "matcher": {
                      "id": "byName",
                      "options": "sig_missing"
                    }
                  },
                  "operator": "/",
                  "right": {
                    "matcher": {
                      "id": "byName",
                      "options": "all_blocks"
                    }
                  }
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "alias": "%_missing_avg",
                "binary": {
                  "left": {
                    "matcher": {
                      "id": "byName",
                      "options": "sig_missing / all_blocks"
                    }
                  },
                  "operator": "/",
                  "right": {
                    "fixed": "59"
                  }
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "filterFieldsByName",
              "options": {
                "byVariable": false,
                "include": {
                  "names": [
                    "Time",
                    "006EEE079580CCF0E9C389062256F6C8BCA0B44E",
                    "0333D22DCA302543BCD1F5A1444CC80388DC9BA6",
                    "03E0A1287B25629B36D6AA29E2E1F0CE00114162",
                    "04A437062C409FA51EC98A4DD649394BD18BDAD7",
                    "17EB7B0873CCD83EA77A62C34FF84A910C5F3CE0",
                    "1834E8A2FDE4644999EED5BD4B99B4A9A22C4351",
                    "1B85A5FFDC65A23DFB51A32DC1087DCA515EA6CC",
                    "2476D36C0C9E1B50A66B8CC8E89D75184F374DDF",
                    "2620065FADD91C5E06AF25A3B7F864483BA1C3B9",
                    "27D87AAA17B86AF55C7E6EC4FB637937FEF39FB2",
                    "307CB9AA68447995515D2AE44EFA82966715B057",
                    "33ED396C904DD8E9A1C2A43FB37C14F5DFDB6E8A",
                    "37B3F9E462967F150F5BF98A7A355F3531B58D12",
                    "37CE71AD8CD4DC01D8798E103A70978591708169",
                    "39633DD07F87E216E0CAD01E0BE216E22F89AB3F",
                    "477858E6BF7E36ADB6062D224A0B06B7B4E5C26E",
                    "545768F1C4F1EE3E7EF93DE8E59FD57A506CEE92",
                    "5A22FB1E69D783401ED3CE77DD3C3D44EDB2E093",
                    "6087607E1E56F6EE7934ABAF65834C92D618104C",
                    "6249218CF53ED5FD3598554F828EC31BB203937E",
                    "6460844B2C81E87F3E2A10667787BB7600CFA970",
                    "66D5C09144B6614E9201E8B7E0931B4D0528541B",
                    "6A7EEC86B32DB79B018BE735ACA63BA5E4FD729A",
                    "6C56084E1CFA331628C8EB1DA6F865922457A975",
                    "75BC207881F939F712C73F0DED5EAAB029F19B2C",
                    "7781FA16ADC57E109F63BD1E29F14F9D3817E14A",
                    "77D3FF15AD886E93068C09F5E5C643537511A3A5",
                    "7A6A9DEE7D8F3BAA83F2C3A0179D74ED1487932C",
                    "7D2D96C14632861337AA62C0EF4E3CA096CE1665",
                    "7DD51A5DA067E9A95FB82E02D5A41A51ADD1EF46",
                    "8E2C70D2292FB3624BAF1F0CFBCB025D2ECC8AFB",
                    "93739258C5626903BA444128CFB7439AA31AA93F",
                    "9AAC0790FFF74F4050DBBBB55EBF59BF134C4038",
                    "9B4E4CD4B66A3E507BB49441291DD838284CEB35",
                    "9DFCC2E344433CBF2DA533E871EDF765E28FB74E",
                    "A14FBF76DDE18A016A36576D7E98414B78F9EB03",
                    "A2EB44E8F5A9289C2C4E10855F2DC19582F55765",
                    "B62687D180445D5CF84E1A2E85DB2ACAEEFCB19A",
                    "B6CD0957B63DB73E8AC0E51CD0DE53AF40AC47D7",
                    "B785C7308D551BD1B227981BF938FE8AD3D3E3AF",
                    "BBB6B7EB2D754EC2957CA5615DD5AB79415B0B1A",
                    "C07DCD3B5ABE8573BAA616F9DD0E3FCD8EC1F671",
                    "CB807691C50A3B28DABBBBEBAB143A2F36C7C6E3",
                    "CDF55ACD97B31A67662BD0BEBC673E5B5FAAEC04",
                    "D0C143A237A69569CC7CECB0DAC2EA95F88B26B3",
                    "D1CE87BBE89B737495416E8C44B9F58D2372D5D1",
                    "D2ECA4D0345C1107BEAD58D66F3DD1ACCF7618ED",
                    "D857A4BA9745354D9FC1DF91A82CDB87A27563A6",
                    "D8DA9CB98162675E9DEB388EE17C360D702D5B96",
                    "DBDEA0E43C9EB037422D0E27C3FFEDF8692E9C97",
                    "DC65D4AD5B754D643C733470DCC7A44B9FB4DCA5",
                    "DD2C988B278E526870DD97D7BA75EEAA2FEBD55D",
                    "E353C5C89FB60D2EBFC2F238F1CC11673C980E45",
                    "E411277DCD8DEF23ED5BCA3F1FEC169FDB10EF7B",
                    "E6643CC7E375FF889EAA59F7FCB93F4DE35403DB",
                    "E972901583CC003C4C388EF2E6F5570ABF0D5B75",
                    "EC975EDDA923754C6BA6044DC6041B35D7AD92CF",
                    "F39BF9316C07E4F27EE31951F720783C58D09C11",
                    "F530BDDB1CF813670A6F6F1E574474D4C91385F5",
                    "FEAA42B0C3582CF9EBE4BD52082B90636C8BF3A5",
                    "%_missing_avg"
                  ]
                }
              }
            }
          ],
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "description": "Count and sum of all skipped signatures as reported in the last commit. Means that validator didn't get a valid proposal in time or proposal was invalid. This is grouped by proposer. \n\nLastly, it shows % of skipped signatures per proposer's block.\n\nSo, this shows slow proposers.",
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 62,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineStyle": {
                  "fill": "solid"
                },
                "lineWidth": 0,
                "pointSize": 1,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "normal"
                },
                "thresholdsStyle": {
                  "mode": "dashed"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 0.01
                  }
                ]
              },
              "unit": "short"
            },
            "overrides": [
              {
                "matcher": {
                  "id": "byName",
                  "options": "ok_baseline"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 12
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "%_skipped_avg"
                },
                "properties": [
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 0
                  },
                  {
                    "id": "custom.lineWidth",
                    "value": 1
                  },
                  {
                    "id": "custom.gradientMode",
                    "value": "none"
                  },
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "yellow",
                      "mode": "fixed"
                    }
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {
                "matcher": {
                  "id": "byName",
                  "options": "%_skipped_rolling"
                },
                "properties": [
                  {
                    "id": "custom.gradientMode",
                    "value": "opacity"
                  },
                  {
                    "id": "custom.drawStyle",
                    "value": "line"
                  },
                  {
                    "id": "color",
                    "value": {
                      "fixedColor": "dark-red",
                      "mode": "shades"
                    }
                  },
                  {
                    "id": "unit",
                    "value": "percentunit"
                  },
                  {
                    "id": "custom.lineWidth",
                    "value": 1
                  },
                  {
                    "id": "custom.fillOpacity",
                    "value": 50
                  },
                  {
                    "id": "custom.stacking",
                    "value": {
                      "group": "A",
                      "mode": "none"
                    }
                  }
                ]
              },
              {{ template "validator_overrides" . }}
            ]
          },
          "gridPos": {
            "h": 9,
            "w": 12,
            "x": 0,
            "y": 223
          },
          "id": 35,
          "options": {
            "legend": {
              "calcs": [
                "max",
                "sum",
                "mean"
              ],
              "displayMode": "table",
              "placement": "bottom",
              "showLegend": true,
              "sortBy": "Total",
              "sortDesc": true
            },
            "tooltip": {
              "mode": "multi",
              "sort": "desc"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "all_blocks",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "D",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            },
            {
              "alias": "sig_skipped",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_skipped"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "sum"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_skipped::field",
                  "operator": "\u003e",
                  "value": "0"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            },
            {
              "alias": "$tag_proposer",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "proposer::tag"
                  ],
                  "type": "tag"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "sig_skipped"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "sum"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "sig_skipped::field",
                  "operator": "\u003e",
                  "value": "0"
                },
                {
                  "condition": "AND",
                  "key": "proposer::tag",
                  "operator": "=~",
                  "value": "/^$Proposers$/"
                }
              ]
            }
          ],
          "title": "[Validator Perf] Skipped Signatures over a (late) Proposal",
          "transformations": [
            {
              "id": "calculateField",
              "options": {
                "binary": {
                  "left": {
                    "matcher": {
                      "id": "byName",
                      "options": "sig_skipped"
                    }
                  },
                  "operator": "/",
                  "right": {
                    "matcher": {
                      "id": "byName",
                      "options": "all_blocks"
                    }
                  }
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "id": "calculateField",
              "options": {
                "alias": "%_skipped_avg",
                "binary": {
                  "left": {
                    "matcher": {
                      "id": "byName",
                      "options": "sig_skipped / all_blocks"
                    }
                  },
                  "operator": "/",
                  "right": {
                    "fixed": "59"
                  }
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                }
              }
            },
            {
              "disabled": true,
              "id": "calculateField",
              "options": {
                "alias": "%_skipped_rolling",
                "binary": {
                  "left": {
                    "fixed": ""
                  },
                  "right": {
                    "fixed": ""
                  }
                },
                "cumulative": {
                  "field": "%_skipped_avg",
                  "reducer": "sum"
                },
                "index": {
                  "asPercentile": false
                },
                "mode": "windowFunctions",
                "reduce": {
                  "include": [
                    "%_skipped_avg"
                  ],
                  "reducer": "max"
                },
                "window": {
                  "field": "%_skipped_avg",
                  "reducer": "mean",
                  "windowAlignment": "centered",
                  "windowSize": 10,
                  "windowSizeMode": "fixed"
                }
              }
            },
            {
              "id": "filterFieldsByName",
              "options": {
                "byVariable": false,
                "include": {
                  "names": [
                    "Time",
                    "006EEE079580CCF0E9C389062256F6C8BCA0B44E",
                    "0333D22DCA302543BCD1F5A1444CC80388DC9BA6",
                    "03E0A1287B25629B36D6AA29E2E1F0CE00114162",
                    "04A437062C409FA51EC98A4DD649394BD18BDAD7",
                    "17EB7B0873CCD83EA77A62C34FF84A910C5F3CE0",
                    "1834E8A2FDE4644999EED5BD4B99B4A9A22C4351",
                    "1B85A5FFDC65A23DFB51A32DC1087DCA515EA6CC",
                    "2476D36C0C9E1B50A66B8CC8E89D75184F374DDF",
                    "2620065FADD91C5E06AF25A3B7F864483BA1C3B9",
                    "27D87AAA17B86AF55C7E6EC4FB637937FEF39FB2",
                    "307CB9AA68447995515D2AE44EFA82966715B057",
                    "33ED396C904DD8E9A1C2A43FB37C14F5DFDB6E8A",
                    "37B3F9E462967F150F5BF98A7A355F3531B58D12",
                    "37CE71AD8CD4DC01D8798E103A70978591708169",
                    "39633DD07F87E216E0CAD01E0BE216E22F89AB3F",
                    "477858E6BF7E36ADB6062D224A0B06B7B4E5C26E",
                    "545768F1C4F1EE3E7EF93DE8E59FD57A506CEE92",
                    "5A22FB1E69D783401ED3CE77DD3C3D44EDB2E093",
                    "6087607E1E56F6EE7934ABAF65834C92D618104C",
                    "6249218CF53ED5FD3598554F828EC31BB203937E",
                    "6460844B2C81E87F3E2A10667787BB7600CFA970",
                    "66D5C09144B6614E9201E8B7E0931B4D0528541B",
                    "6A7EEC86B32DB79B018BE735ACA63BA5E4FD729A",
                    "6C56084E1CFA331628C8EB1DA6F865922457A975",
                    "75BC207881F939F712C73F0DED5EAAB029F19B2C",
                    "7781FA16ADC57E109F63BD1E29F14F9D3817E14A",
                    "77D3FF15AD886E93068C09F5E5C643537511A3A5",
                    "7A6A9DEE7D8F3BAA83F2C3A0179D74ED1487932C",
                    "7D2D96C14632861337AA62C0EF4E3CA096CE1665",
                    "7DD51A5DA067E9A95FB82E02D5A41A51ADD1EF46",
                    "8E2C70D2292FB3624BAF1F0CFBCB025D2ECC8AFB",
                    "93739258C5626903BA444128CFB7439AA31AA93F",
                    "9AAC0790FFF74F4050DBBBB55EBF59BF134C4038",
                    "9B4E4CD4B66A3E507BB49441291DD838284CEB35",
                    "9DFCC2E344433CBF2DA533E871EDF765E28FB74E",
                    "A14FBF76DDE18A016A36576D7E98414B78F9EB03",
                    "A2EB44E8F5A9289C2C4E10855F2DC19582F55765",
                    "B62687D180445D5CF84E1A2E85DB2ACAEEFCB19A",
                    "B6CD0957B63DB73E8AC0E51CD0DE53AF40AC47D7",
                    "B785C7308D551BD1B227981BF938FE8AD3D3E3AF",
                    "BBB6B7EB2D754EC2957CA5615DD5AB79415B0B1A",
                    "C07DCD3B5ABE8573BAA616F9DD0E3FCD8EC1F671",
                    "CB807691C50A3B28DABBBBEBAB143A2F36C7C6E3",
                    "CDF55ACD97B31A67662BD0BEBC673E5B5FAAEC04",
                    "D0C143A237A69569CC7CECB0DAC2EA95F88B26B3",
                    "D1CE87BBE89B737495416E8C44B9F58D2372D5D1",
                    "D2ECA4D0345C1107BEAD58D66F3DD1ACCF7618ED",
                    "D857A4BA9745354D9FC1DF91A82CDB87A27563A6",
                    "D8DA9CB98162675E9DEB388EE17C360D702D5B96",
                    "DBDEA0E43C9EB037422D0E27C3FFEDF8692E9C97",
                    "DC65D4AD5B754D643C733470DCC7A44B9FB4DCA5",
                    "DD2C988B278E526870DD97D7BA75EEAA2FEBD55D",
                    "E353C5C89FB60D2EBFC2F238F1CC11673C980E45",
                    "E411277DCD8DEF23ED5BCA3F1FEC169FDB10EF7B",
                    "E6643CC7E375FF889EAA59F7FCB93F4DE35403DB",
                    "E972901583CC003C4C388EF2E6F5570ABF0D5B75",
                    "EC975EDDA923754C6BA6044DC6041B35D7AD92CF",
                    "F39BF9316C07E4F27EE31951F720783C58D09C11",
                    "F530BDDB1CF813670A6F6F1E574474D4C91385F5",
                    "FEAA42B0C3582CF9EBE4BD52082B90636C8BF3A5",
                    "%_skipped_avg"
                  ]
                }
              }
            },
            {
              "id": "filterByValue",
              "options": {
                "filters": [],
                "match": "any",
                "type": "exclude"
              }
            }
          ],
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "influxdb",
            "uid": "febedkgp47y0wa"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "barWidthFactor": 0.6,
                "drawStyle": "bars",
                "fillOpacity": 100,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 0,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green"
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              }
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 232
          },
          "id": 45,
          "options": {
            "legend": {
              "calcs": [
                "min",
                "max",
                "sum"
              ],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "pluginVersion": "11.4.0",
          "targets": [
            {
              "alias": "all_blocks",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "0"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                }
              ]
            },
            {
              "alias": "non_empty_blocks",
              "datasource": {
                "type": "influxdb",
                "uid": "febedkgp47y0wa"
              },
              "groupBy": [
                {
                  "params": [
                    "$Interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "0"
                  ],
                  "type": "fill"
                }
              ],
              "hide": false,
              "measurement": "coremon_block_report",
              "orderByTime": "ASC",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "height"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "count"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "chain_id::tag",
                  "operator": "=~",
                  "value": "/^$ChainID$/"
                },
                {
                  "condition": "AND",
                  "key": "txs::field",
                  "operator": "\u003e",
                  "value": "0"
                }
              ]
            }
          ],
          "title": "Empty Blocks (0 Txns)",
          "transformations": [
            {
              "id": "calculateField",
              "options": {
                "alias": "empty_blocks",
                "binary": {
                  "left": {
                    "matcher": {
                      "id": "byName",
                      "options": "all_blocks"
                    }
                  },
                  "operator": "-",
                  "right": {
                    "matcher": {
                      "id": "byName",
                      "options": "non_empty_blocks"
                    }
                  }
                },
                "mode": "binary",
                "reduce": {
                  "reducer": "sum"
                },
                "replaceFields": true
              }
            }
          ],
          "type": "timeseries"
        }
      ],
      "title": "Internal / Not useful",
      "type": "row"
    }
  ],
  "preload": false,
  "refresh": "1m",
  "schemaVersion": 41,
  "tags": [],
  "templating": {
    "list": [
      {
        "auto": false,
        "auto_count": 30,
        "auto_min": "10s",
        "current": {
          "text": "2m",
          "value": "2m"
        },
        "name": "Interval",
        "options": [
          {
            "selected": false,
            "text": "1s",
            "value": "1s"
          },
          {
            "selected": false,
            "text": "10s",
            "value": "10s"
          },
          {
            "selected": false,
            "text": "30s",
            "value": "30s"
          },
          {
            "selected": true,
            "text": "2m",
            "value": "2m"
          },
          {
            "selected": false,
            "text": "5m",
            "value": "5m"
          },
          {
            "selected": false,
            "text": "10m",
            "value": "10m"
          },
          {
            "selected": false,
            "text": "15m",
            "value": "15m"
          },
          {
            "selected": false,
            "text": "30m",
            "value": "30m"
          },
          {
            "selected": false,
            "text": "1h",
            "value": "1h"
          },
          {
            "selected": false,
            "text": "2h",
            "value": "2h"
          },
          {
            "selected": false,
            "text": "6h",
            "value": "6h"
          },
          {
            "selected": false,
            "text": "12h",
            "value": "12h"
          },
          {
            "selected": false,
            "text": "1d",
            "value": "1d"
          },
          {
            "selected": false,
            "text": "7d",
            "value": "7d"
          },
          {
            "selected": false,
            "text": "14d",
            "value": "14d"
          },
          {
            "selected": false,
            "text": "30d",
            "value": "30d"
          }
        ],
        "query": "1s,10s,30s,2m,5m,10m,15m,30m,1h,2h,6h,12h,1d,7d,14d,30d",
        "refresh": 2,
        "type": "interval"
      },
      {
        "current": {
          "text": "injective-1",
          "value": "injective-1"
        },
        "datasource": {
          "type": "influxdb",
          "uid": "febedkgp47y0wa"
        },
        "definition": "show tag values from coremon_block_report  with key=chain_id;",
        "includeAll": false,
        "name": "ChainID",
        "options": [],
        "query": {
          "query": "show tag values from coremon_block_report  with key=chain_id;",
          "refId": "InfluxVariableQueryEditor-VariableQuery"
        },
        "refresh": 1,
        "regex": "",
        "sort": 1,
        "type": "query"
      },
      {
        "current": {
          "text": [
            "$__all"
          ],
          "value": [
            "$__all"
          ]
        },
        "description": "Filter proposer related metrics by a subset of (problematic) proposers. Useful in context of BFT performance.",
        "includeAll": true,
        "multi": true,
        "name": "Proposers",
        "options": [
          {{ template "validator_options" . }}
        ],
        "query": {{ json .ValidatorQuery }},
        "type": "custom"
      },
      {
        "allValue": ".*",
        "current": {
          "text": [
            "$__all"
          ],
          "value": [
            "$__all"
          ]
        },
        "description": "Select particular validator filter",
        "includeAll": true,
        "multi": true,
        "name": "Validators",
        "options": [
          {{ template "validator_options" . }}
        ],
        "query": {{ json .ValidatorQuery }},
        "type": "custom"
      }
    ]
  },
  "time": {
    "from": "now-12h",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "browser",
  "title": "Coremon: Mainnet",
  "uid": "bdzlj2m9m3a4ga",
  "version": 113
}
