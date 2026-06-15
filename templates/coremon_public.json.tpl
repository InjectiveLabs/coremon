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
  "id": 9,
  "links": [],
  "panels": [
    {
      "datasource": {
        "type": "influxdb",
        "uid": "cedgggmypa39cb"
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
        "h": 6,
        "w": 12,
        "x": 0,
        "y": 0
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "Last",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
        "uid": "cedgggmypa39cb"
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
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 0
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "blocktime_pct99.95",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
        "uid": "cedgggmypa39cb"
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
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 6
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "slow blocks \u003e1.2s",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
        "uid": "cedgggmypa39cb"
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
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 7
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "txn_bytes_max",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
        "uid": "cedgggmypa39cb"
      },
      "description": "Sum all missed rounds and group by block proposer. \n\nShows that the biggest contributor to potential round issues is the block contents that can't be processed in time, no matter which proposer it was.",
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
                "color": "green",
                "value": 0
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
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 14
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "$tag_proposer",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
      "title": "Rounds Missed Per Block Proposer",
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
        "uid": "cedgggmypa39cb"
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
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 14
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "tpb_max",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
        "uid": "cedgggmypa39cb"
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
        "y": 21
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
          "sortBy": "Total",
          "sortDesc": true
        },
        "tooltip": {
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "",
      "targets": [
        {
          "alias": "$tag_validator",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
      "title": "StdDev Distance per Validator Sig Timestamp",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "cedgggmypa39cb"
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
        "y": 21
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
      "pluginVersion": "",
      "targets": [
        {
          "alias": "$tag_validator",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
      "title": "Missing Signatures per Validator",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "cedgggmypa39cb"
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
                "color": "green",
                "value": 0
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
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 31
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
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "all_blocks",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
      "title": "Skipped Signatures over a (late) Proposal",
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
        "uid": "cedgggmypa39cb"
      },
      "description": "When a validator signed a nil block",
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
          {{ template "validator_overrides" . }}
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 12,
        "y": 31
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
            "uid": "cedgggmypa39cb"
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
      "title": "Skipped Signatures per Validator",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "influxdb",
        "uid": "cedgggmypa39cb"
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
                "color": "green",
                "value": 0
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
          {{ template "validator_overrides" . }},
          {
            "__systemRef": "hideSeriesFrom",
            "matcher": {
              "id": "byNames",
              "options": {
                "mode": "exclude",
                "names": [
                  "%_missing_avg"
                ],
                "prefix": "All except:",
                "readOnly": true
              }
            },
            "properties": [
              {
                "id": "custom.hideFrom",
                "value": {
                  "legend": false,
                  "tooltip": false,
                  "viz": true
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 10,
        "w": 12,
        "x": 0,
        "y": 41
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
          "hideZeros": false,
          "mode": "multi",
          "sort": "desc"
        }
      },
      "pluginVersion": "12.1.0",
      "targets": [
        {
          "alias": "all_blocks",
          "datasource": {
            "type": "influxdb",
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
            "uid": "cedgggmypa39cb"
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
      "title": "Missing Signatures Per Block Proposal",
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
        "uid": "cedgggmypa39cb"
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
        "x": 12,
        "y": 41
      },
      "id": 44,
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
            "uid": "cedgggmypa39cb"
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
          "uid": "cedgggmypa39cb"
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
        "allValue": ".*",
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
  "title": "Injective BFT Metrics",
  "uid": "injective-bft-metrics",
  "version": 6
}
