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
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(1): internal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(2): stop iterating"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:111222"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(111222): panic"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(2): value is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(3): duplicate value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(4): limit exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(5): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(6): invalid value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(7): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(8): modified"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(9): expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "math:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "math(10): invalid decimal string"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(11): iterator done"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(12): invalid iterator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(13): unique constraint violation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(14): invalid argument"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(15): key exceeds max length"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(47): cannot use empty key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibchooks:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibchooks(2): error in wasmhook message validation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(3): cannot marshal the ICS20 packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(4): invalid packet data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(5): cannot create response"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(6): wasm error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(7): bad sender"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tx:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tx(1): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tx:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tx(2): unknown protobuf field"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(2): invalid proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(3): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(4): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(5): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(6): conflict"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(7): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(2): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(3): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(4): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(5): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(6): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(7): invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(8): invalid pubkey"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(9): unknown address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(10): invalid coins"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(11): out of gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(12): memo too large"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(13): insufficient fee"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(14): maximum number of signatures exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(15): no signatures supplied"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(16): failed to marshal JSON bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(17): failed to unmarshal JSON bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(18): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(19): tx already in mempool"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(20): mempool is full"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(21): tx too large"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(22): key not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(23): invalid account password"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(24): tx intended signer does not match the given signer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(25): invalid gas adjustment"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(26): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(27): invalid version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(28): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(29): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(30): tx timeout height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(31): unknown extension options"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(32): incorrect account sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(33): failed packing protobuf message to Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(34): failed unpacking protobuf message from Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(35): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(36): conflict"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(37): feature not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(38): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(39): Internal IO error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(40): error in app.toml"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(41): invalid gas limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(1): owasm compilation failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(2): bad wasm execution"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(3): data source not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(4): oracle script not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(5): request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(6): raw request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(7): reporter not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(8): result not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(9): reporter already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(10): validator not requested"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(11): validator already reported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(12): invalid report size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(13): reporter not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(14): editor not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(16): validator already active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(17): too soon to activate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(18): too long name"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(19): too long description"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(20): empty executable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(21): empty wasm code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(22): too large executable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(23): too large wasm code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(24): invalid min count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(25): invalid ask count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(26): too large calldata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(27): too long client id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(28): empty raw requests"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(29): empty report"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(30): duplicate external id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(31): too long schema"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(32): too long url"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(33): too large raw report data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(34): insufficient available validators"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(35): cannot create with [do-not-modify] content"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(36): cannot reference self as reporter"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(37): obi decode failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(38): uncompression failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(39): request already expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(40): bad drbg initialization"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(41): max oracle channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(42): invalid ICS20 version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(43): not enough fee"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(44): invalid owasm gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(45): sending oracle request via IBC is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:46"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(46): invalid request key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(47): too long request key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(2): fee limit exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(3): fee allowance expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(4): invalid duration"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(5): no allowance"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(6): allowed messages are empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(7): message not allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "table_testdata:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "table_testdata(2): test"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(2): authorization not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(3): expiration time of authorization should be more than current time"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(4): unknown authorization type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(5): grant key not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(6): authorization expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(7): grantee and granter should be different"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(9): authorization can be given to msg with only one signer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(12): max tokens should be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(2): capability name not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(3): provided capability is nil"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(4): capability name already taken"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(5): given owner already claimed capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(6): capability not owned by module"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(7): capability not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(8): owners not found for capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(2): invalid proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(3): invalid prefix"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(4): invalid merkle proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(2): invalid identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(3): invalid path"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(4): invalid packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(1): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(2): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(3): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(4): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(5): invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(6): invalid coins"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(7): out of gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(8): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(9): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(10): invalid version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(11): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(12): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(13): failed packing protobuf message to Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(14): failed unpacking protobuf message from Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(15): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(16): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "injective:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "injective(3): invalid chain ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "auction:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "auction(1): invalid bid denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "auction:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "auction(2): invalid bid round"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(2): no inputs to send transaction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(3): no outputs to send transaction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(4): sum inputs != sum outputs"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(5): send transactions are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(6): client denom metadata not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(7): invalid key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(8): duplicate entry"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(9): multiple senders not allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(2): attempting to create a denom that already exists (has bank metadata)"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(3): unauthorized account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(4): invalid denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(5): invalid creator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(6): invalid authority metadata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(7): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(8): subdenom too long, max length is 44 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(9): subdenom too short, min length is 1 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(10): nested subdenom too short, each one should have at least 1 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(11): creator too long, max length is 75 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(12): denom does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(13): amount has to be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(2): attempting to create a namespace for denom that already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(3): unauthorized account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(4): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(5): invalid namespace"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(6): invalid permissions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(7): unknown role"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(8): unknown contract address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(9): restricted action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(10): invalid role"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(11): namespace for denom is not existing"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(12): wasm hook query error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(13): voucher was not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(14): invalid wasm hook"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "crisis:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "crisis(2): sender address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "crisis:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "crisis(3): unknown invariant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(2): empty validator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(3): validator does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(4): validator already exist for this operator address; must use new validator operator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(5): validator already exist for this pubkey; must use new validator pubkey"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(6): validator pubkey type is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(7): validator for this address is currently jailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(8): failed to remove validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(9): commission must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(10): commission cannot be more than 100%"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(11): commission cannot be more than the max rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(12): commission cannot be changed more than once in 24h"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(13): commission change rate must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(14): commission change rate cannot be more than the max rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(15): commission cannot be changed more than max change rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(16): validator's self delegation must be greater than their minimum self delegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(17): minimum self delegation cannot be decrease"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(18): empty delegator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(19): no delegation for (address, validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(20): delegator does not exist with address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(21): delegator does not contain delegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(22): insufficient delegation shares"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(23): cannot delegate to an empty validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(24): not enough delegation shares"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(25): entry not mature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(26): no unbonding delegation found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(27): too many unbonding delegation entries for (delegator, validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(28): no redelegation found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(29): cannot redelegate to the same validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(30): too few tokens to redelegate (truncates to zero tokens)"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(31): redelegation destination validator not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(32): redelegation to this validator already in progress; first redelegation to this validator must complete before next redelegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(33): too many redelegation entries for (delegator, src-validator, dst-validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(34): cannot delegate to validators with invalid (zero) ex-rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(35): both shares amount and shares percent provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(36): neither shares amount nor shares percent provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(37): invalid historical info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(38): no historical info found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(39): empty validator public key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(40): commission cannot be less than min rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(41): unbonding operation not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(42): cannot un-hold unbonding operation that is not on hold"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(43): expected authority account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(44): redelegation source validator not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(45): unbonding type not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:70"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(70): commission rate too small"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(2): unregistered handler for evidence type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(3): invalid evidence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(5): evidence already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(3): inactive proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(4): proposal already active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(5): invalid proposal content"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(6): invalid proposal type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(7): invalid vote option"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(8): invalid genesis state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(9): no handler exists for proposal type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(10): proposal message not recognized by router"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(11): no messages proposed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(12): invalid proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(13): expected gov account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(15): metadata too long"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(16): minimum deposit is too small"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(18): invalid proposer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(20): voting period already ended"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(21): invalid proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(22): summary too long"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(23): invalid deposit denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(2): module version not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(3): upgrade plan not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(4): upgraded client not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(5): upgraded consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(6): expected authority account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(1): stale report"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(2): incomplete proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(3): repeated oracle address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(4): too many signers"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(5): incorrect config"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(6): config digest doesn't match"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(7): wrong number of signatures"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(8): incorrect signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(9): no transmitter specified"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(10): incorrect transmission data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(11): no transmissions found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(12): median value is out of bounds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(13): LINK denom doesn't match"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(14): Reward Pool doesn't exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(15): wrong number of payees and transmitters"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(16): action is restricted to the module admin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(17): feed already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(19): feed doesnt exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(20): action is admin-restricted"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(21): insufficient reward pool"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(22): payee already set"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(23): action is payee-restricted"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(24): feed config not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(2): delegator address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(3): withdraw address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(4): validator address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(5): no delegation distribution info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(6): no validator distribution info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(7): no validator commission to withdraw"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(8): set withdraw address disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(9): community pool does not have sufficient coins to distribute"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(10): invalid community pool spend proposal amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(11): invalid community pool spend proposal recipient"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(12): validator does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(13): delegation does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(2): unknown subspace"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(3): failed to set parameter"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(4): submitted parameter changes are empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(5): parameter subspace is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(6): parameter key is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(7): parameter value is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(2): address is not associated with any known validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(3): validator does not exist for that address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(4): validator still jailed; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(5): validator not jailed; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(6): validator has no self-delegation; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(7): validator's self delegation less than minimum; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(8): no validator signing info found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(9): validator already tombstoned"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(1): internal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(2): duplicate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(3): invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(4): timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(5): unknown"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(6): empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(7): outdated"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(8): unsupported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(9): non contiguous event nonce"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(10): no unbatched txs found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(11): can not set orchestrator addresses more than once"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(12): supply cannot exceed max ERC20 value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(13): invalid ethereum sender on claim"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(14): invalid ethereum destination"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(15): missing previous claim for validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "icahost:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "icahost(2): host submodule is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(2): light client already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(3): light client is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(4): light client not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(5): light client is frozen due to misbehaviour"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(6): invalid client metadata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(7): consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(8): invalid consensus state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(9): client type not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(10): invalid client type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(11): commitment root not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(12): invalid client header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(13): invalid light client misbehaviour"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(14): client state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(15): client consensus state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(16): connection state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(17): channel state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(18): packet commitment verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(19): packet acknowledgement verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(20): packet receipt verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(21): next sequence receive verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(22): self consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(23): unable to update light client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(24): invalid recovery client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(25): invalid client upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(26): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(27): invalid client state substitute"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(28): invalid upgrade proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(29): client state is not active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(30): membership verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(31): non-membership verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(32): client type not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(2): connection already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(3): connection not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(4): light client connection paths not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(5): connection path is not associated to the given light client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(6): invalid connection state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(7): invalid counterparty connection"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(8): invalid connection"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(9): invalid connection version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(10): connection version negotiation failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(11): invalid connection identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(2): channel already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(3): channel not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(4): invalid channel"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(5): invalid channel state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(6): invalid channel ordering"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(7): invalid counterparty channel"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(8): invalid channel capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(9): channel capability not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(10): sequence send not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(11): sequence receive not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(12): sequence acknowledgement not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(13): invalid packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(14): packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(15): too many connection hops"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(16): invalid acknowledgement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(17): acknowledgement for packet already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(18): invalid channel identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(19): packet already received"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(20): packet commitment not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(21): packet sequence is out of order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(22): packet messages are redundant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(23): message is redundant, no-op will be performed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(24): invalid channel version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(25): packet has not been sent"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(26): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(27): upgrade error receipt not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(28): invalid upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(29): invalid upgrade sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(30): upgrade not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(31): incompatible counterparty upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(32): invalid upgrade error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(33): restore failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(34): upgrade timed-out"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(35): upgrade timeout is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(36): pending inflight packets exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(37): upgrade timeout failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(38): invalid pruning limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(39): timeout not reached"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(40): timeout elapsed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(41): pruning sequence start not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(42): recv start sequence not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(2): create wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(3): contract account already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(4): instantiate wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(5): execute wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(6): insufficient gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(7): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(8): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(9): query wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(10): invalid CosmosMsg from the contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(11): migrate wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(12): empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(13): exceeds limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(14): invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(15): duplicate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(16): max transfer channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(17): unsupported for this contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(18): pinning contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(19): unpinning contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(20): unknown message from the contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(21): invalid event"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(22): no such contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(27): max query stack size exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(28): no such code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(29): wasmvm error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(1): relayer address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(2): bad rates count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(3): bad resolve times"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(4): bad request ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(5): relayer not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(6): bad price feed base count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(7): bad price feed quote count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(8): unsupported oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(9): bad messages count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(10): bad Coinbase message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(11): bad Ethereum signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(12): bad Coinbase message timestamp"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(13): Coinbase price not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(14): Prices must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(15): Prices must be less than 10 million."
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(16): Invalid Band IBC Request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(17): sample error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(18): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(19): invalid symbols count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(20): could not claim port capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(21): invalid IBC Port ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(22): invalid IBC Channel ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(23): invalid Band IBC request interval"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(24): Invalid Band IBC Update Request Proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(25): Band IBC Oracle Request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(26): Base Info is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(27): provider is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(28): invalid provider name"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(29): invalid symbol"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(30): relayer already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(31): provider price not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(32): invalid oracle request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(33): no price for oracle was found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(34): no address for Pyth contract found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(35): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(36): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(37): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(38): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(39): empty price attestations"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(40): bad Stork message timestamp"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(41): sender stork is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(42): invalid stork signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(43): stork asset id not unique"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(1): insurance fund already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(2): insurance fund not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(3): redemption already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(4): invalid deposit amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(5): invalid deposit denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(6): insurance payout exceeds deposits"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(7): invalid ticker"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(8): invalid quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(9): invalid oracle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(10): invalid expiration time"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(11): invalid marketID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(12): invalid share denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(1): invalid gas limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(2): invalid gas price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(3): invalid contract address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(4): contract already registered"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(5): duplicate contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(6): no contract addresses found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(7): invalid code id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(8): not possible to deduct gas fees"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(9): missing granter address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(10): granter address does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(11): invalid funding mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(1): failed to validate order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(2): spot market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(3): spot market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(4): struct field error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(5): failed to validate market"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(6): subaccount has insufficient deposits"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(7): unrecognized order type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(8): position quantity insufficient for order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(9): order hash is not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(10): subaccount id is not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(11): invalid ticker"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(12): invalid base denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(13): invalid quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(14): invalid oracle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(15): invalid expiry"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(16): invalid price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(17): invalid quantity"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(18): unsupported oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(19): order doesnt exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(20): spot limit orderbook fill invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(21): perpetual market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(22): expiry futures market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(23): expiry futures market expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(24): no liquidity on the orderbook!"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(25): Orderbook liquidity cannot satisfy current worst price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(26): insufficient margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(27): Derivative market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(28): Position not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(29): Position direction does not oppose the reduce-only order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(30): Price Surpasses Bankruptcy Price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(31): Position not liquidable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(32): invalid trigger price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(33): invalid oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(34): invalid minimum price tick size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(35): invalid minimum quantity tick size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(36): invalid minimum order margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(37): Exceeds order side count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(38): Subaccount cannot place a market order when a market order in the same market was already placed in same block"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(39): cannot place a conditional market order when a conditional market order in same relative direction already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(40): An equivalent market launch proposal already exists."
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(41): Invalid Market Status"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(42): base denom cannot be same with quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(43): oracle base cannot be same with oracle quote"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(44): MakerFeeRate does not match TakerFeeRate requirements"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(45): MaintenanceMarginRatio cannot be greater than InitialMarginRatio"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:46"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(46): OracleScaleFactor cannot be greater than MaxOracleScaleFactor"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(47): Spot exchange is not enabled yet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:48"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(48): Derivatives exchange is not enabled yet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:49"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(49): Oracle price delta exceeds threshold"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:50"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(50): Invalid hourly interest rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:51"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(51): Invalid hourly funding rate cap"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:52"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(52): Only perpetual markets can update funding parameters"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:53"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(53): Invalid trading reward campaign"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:54"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(54): Invalid fee discount schedule"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:55"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(55): invalid liquidation order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:56"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(56): Unknown error happened for campaign distributions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:57"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(57): Invalid trading reward points update"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:58"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(58): Invalid batch msg update"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:59"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(59): Post-only order exceeds top of book price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:60"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(60): Order type not supported for given message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:61"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(61): Sender must match dmm account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:62"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(62): already opted out of rewards"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:63"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(63): Invalid margin ratio"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:64"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(64): Provided funds are below minimum"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:65"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(65): Position is below initial margin requirement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:66"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(66): Pool has non-positive total lp token supply"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:67"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(67): Passed lp token burn amount is greater than total lp token supply"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:68"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(68): unsupported action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:69"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(69): position quantity cannot be negative"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:70"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(70): binary options market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:71"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(71): binary options market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:72"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(72): invalid settlement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:73"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(73): account doesnt exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:74"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(74): sender should be a market admin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:75"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(75): market is already scheduled to settle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:76"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(76): market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:77"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(77): denom decimal cannot be below 1 or above max scale factor"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:78"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(78): state is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:79"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(79): transient orders up to cancellation not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:80"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(80): invalid trade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:81"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(81): no margin locked in subaccount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:82"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(82): Invalid access level to perform action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:83"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(83): Invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:84"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(84): Invalid argument"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:85"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(85): Invalid funds direction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:86"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(86): No funds provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:87"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(87): Invalid signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:88"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(88): no funds to unlock"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:89"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(89): No msgs provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:90"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(90): No msg provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:91"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(91): Invalid amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:92"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(92): The current feature has been disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:93"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(93): Order has too much margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:94"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(94): Subaccount nonce is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:95"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(95): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:96"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(96): exchange is in post-only mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:97"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(97): client order id already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:98"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(98): client order id is invalid. Max length is 36 chars"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:99"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(99): market cannot be settled in emergency mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:100"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(100): invalid notional"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:101"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(101): stale oracle price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:102"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(102): invalid stake grant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:103"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(103): insufficient stake for grant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:104"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(104): invalid permissions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(2): unknown data type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(3): account already exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(4): port is already bound"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(5): invalid message sent to channel end"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(6): invalid outgoing data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(7): invalid route"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(8): interchain account not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(9): interchain account is already set"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(10): active channel already set for this owner"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(11): no active channel for this owner"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(12): invalid interchain accounts version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(13): invalid account address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(14): interchain account does not support this action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(15): invalid controller port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(16): invalid host port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(17): timeout timestamp must be in the future"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(18): codec is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(19): invalid account reopening"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "icacontroller:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "icacontroller(2): controller submodule is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(2): invalid ICS29 middleware version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(3): no account found for given refund address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(4): balance not found for given account address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(5): there is no fee escrowed for the given packetID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(6): relayers must not be set. This feature is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(7): counterparty payee must not be empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(8): forward relayer address not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(9): fee module is not enabled for this channel. If this error occurs after channel setup, fee module may not be enabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(10): relayer address must be stored for async WriteAcknowledgement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(11): the fee module is currently locked, a severe bug has been detected"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(12): unsupported action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(2): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(3): invalid denomination for cross-chain transfer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(4): invalid ICS20 version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(5): invalid token amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(6): denomination trace not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(7): fungible token transfers from this chain are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(8): fungible token transfers to this chain are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(9): max transfer channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(10): invalid transfer authorization"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(11): invalid memo"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(2): port is already binded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(3): port not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(4): invalid port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(5): route not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(2): invalid header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(3): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(4): invalid signature and data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(5): signature verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(6): invalid solo machine proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(2): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(3): invalid trusting period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(4): invalid unbonding period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(5): invalid header height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(6): invalid header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(7): invalid max clock drift"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(8): processed time not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(9): processed height not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(10): packet-specified delay period has not been reached"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(11): time since latest trusted state has passed the trusting period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(12): time since latest trusted state has passed the unbonding period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(13): invalid proof specs"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(14): invalid validator set"
              }
            ]
          }
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
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(1): internal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(2): stop iterating"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:111222"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(111222): panic"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(2): value is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(3): duplicate value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(4): limit exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(5): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(6): invalid value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(7): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(8): modified"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(9): expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "math:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "math(10): invalid decimal string"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(11): iterator done"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(12): invalid iterator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(13): unique constraint violation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(14): invalid argument"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(15): key exceeds max length"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(47): cannot use empty key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibchooks:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibchooks(2): error in wasmhook message validation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(3): cannot marshal the ICS20 packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(4): invalid packet data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(5): cannot create response"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(6): wasm error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(7): bad sender"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tx:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tx(1): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tx:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tx(2): unknown protobuf field"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(2): invalid proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(3): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(4): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(5): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(6): conflict"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(7): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(2): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(3): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(4): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(5): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(6): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(7): invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(8): invalid pubkey"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(9): unknown address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(10): invalid coins"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(11): out of gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(12): memo too large"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(13): insufficient fee"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(14): maximum number of signatures exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(15): no signatures supplied"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(16): failed to marshal JSON bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(17): failed to unmarshal JSON bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(18): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(19): tx already in mempool"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(20): mempool is full"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(21): tx too large"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(22): key not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(23): invalid account password"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(24): tx intended signer does not match the given signer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(25): invalid gas adjustment"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(26): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(27): invalid version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(28): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(29): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(30): tx timeout height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(31): unknown extension options"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(32): incorrect account sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(33): failed packing protobuf message to Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(34): failed unpacking protobuf message from Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(35): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(36): conflict"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(37): feature not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(38): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(39): Internal IO error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(40): error in app.toml"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(41): invalid gas limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(1): owasm compilation failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(2): bad wasm execution"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(3): data source not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(4): oracle script not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(5): request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(6): raw request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(7): reporter not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(8): result not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(9): reporter already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(10): validator not requested"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(11): validator already reported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(12): invalid report size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(13): reporter not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(14): editor not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(16): validator already active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(17): too soon to activate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(18): too long name"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(19): too long description"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(20): empty executable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(21): empty wasm code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(22): too large executable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(23): too large wasm code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(24): invalid min count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(25): invalid ask count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(26): too large calldata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(27): too long client id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(28): empty raw requests"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(29): empty report"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(30): duplicate external id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(31): too long schema"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(32): too long url"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(33): too large raw report data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(34): insufficient available validators"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(35): cannot create with [do-not-modify] content"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(36): cannot reference self as reporter"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(37): obi decode failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(38): uncompression failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(39): request already expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(40): bad drbg initialization"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(41): max oracle channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(42): invalid ICS20 version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(43): not enough fee"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(44): invalid owasm gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(45): sending oracle request via IBC is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:46"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(46): invalid request key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(47): too long request key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(2): fee limit exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(3): fee allowance expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(4): invalid duration"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(5): no allowance"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(6): allowed messages are empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(7): message not allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "table_testdata:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "table_testdata(2): test"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(2): authorization not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(3): expiration time of authorization should be more than current time"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(4): unknown authorization type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(5): grant key not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(6): authorization expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(7): grantee and granter should be different"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(9): authorization can be given to msg with only one signer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(12): max tokens should be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(2): capability name not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(3): provided capability is nil"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(4): capability name already taken"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(5): given owner already claimed capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(6): capability not owned by module"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(7): capability not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(8): owners not found for capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(2): invalid proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(3): invalid prefix"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(4): invalid merkle proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(2): invalid identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(3): invalid path"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(4): invalid packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(1): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(2): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(3): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(4): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(5): invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(6): invalid coins"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(7): out of gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(8): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(9): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(10): invalid version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(11): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(12): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(13): failed packing protobuf message to Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(14): failed unpacking protobuf message from Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(15): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(16): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "injective:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "injective(3): invalid chain ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "auction:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "auction(1): invalid bid denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "auction:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "auction(2): invalid bid round"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(2): no inputs to send transaction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(3): no outputs to send transaction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(4): sum inputs != sum outputs"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(5): send transactions are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(6): client denom metadata not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(7): invalid key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(8): duplicate entry"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(9): multiple senders not allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(2): attempting to create a denom that already exists (has bank metadata)"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(3): unauthorized account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(4): invalid denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(5): invalid creator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(6): invalid authority metadata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(7): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(8): subdenom too long, max length is 44 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(9): subdenom too short, min length is 1 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(10): nested subdenom too short, each one should have at least 1 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(11): creator too long, max length is 75 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(12): denom does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(13): amount has to be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(2): attempting to create a namespace for denom that already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(3): unauthorized account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(4): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(5): invalid namespace"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(6): invalid permissions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(7): unknown role"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(8): unknown contract address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(9): restricted action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(10): invalid role"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(11): namespace for denom is not existing"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(12): wasm hook query error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(13): voucher was not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(14): invalid wasm hook"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "crisis:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "crisis(2): sender address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "crisis:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "crisis(3): unknown invariant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(2): empty validator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(3): validator does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(4): validator already exist for this operator address; must use new validator operator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(5): validator already exist for this pubkey; must use new validator pubkey"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(6): validator pubkey type is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(7): validator for this address is currently jailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(8): failed to remove validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(9): commission must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(10): commission cannot be more than 100%"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(11): commission cannot be more than the max rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(12): commission cannot be changed more than once in 24h"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(13): commission change rate must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(14): commission change rate cannot be more than the max rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(15): commission cannot be changed more than max change rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(16): validator's self delegation must be greater than their minimum self delegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(17): minimum self delegation cannot be decrease"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(18): empty delegator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(19): no delegation for (address, validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(20): delegator does not exist with address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(21): delegator does not contain delegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(22): insufficient delegation shares"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(23): cannot delegate to an empty validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(24): not enough delegation shares"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(25): entry not mature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(26): no unbonding delegation found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(27): too many unbonding delegation entries for (delegator, validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(28): no redelegation found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(29): cannot redelegate to the same validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(30): too few tokens to redelegate (truncates to zero tokens)"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(31): redelegation destination validator not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(32): redelegation to this validator already in progress; first redelegation to this validator must complete before next redelegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(33): too many redelegation entries for (delegator, src-validator, dst-validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(34): cannot delegate to validators with invalid (zero) ex-rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(35): both shares amount and shares percent provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(36): neither shares amount nor shares percent provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(37): invalid historical info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(38): no historical info found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(39): empty validator public key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(40): commission cannot be less than min rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(41): unbonding operation not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(42): cannot un-hold unbonding operation that is not on hold"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(43): expected authority account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(44): redelegation source validator not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(45): unbonding type not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:70"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(70): commission rate too small"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(2): unregistered handler for evidence type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(3): invalid evidence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(5): evidence already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(3): inactive proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(4): proposal already active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(5): invalid proposal content"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(6): invalid proposal type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(7): invalid vote option"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(8): invalid genesis state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(9): no handler exists for proposal type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(10): proposal message not recognized by router"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(11): no messages proposed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(12): invalid proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(13): expected gov account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(15): metadata too long"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(16): minimum deposit is too small"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(18): invalid proposer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(20): voting period already ended"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(21): invalid proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(22): summary too long"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(23): invalid deposit denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(2): module version not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(3): upgrade plan not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(4): upgraded client not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(5): upgraded consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(6): expected authority account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(1): stale report"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(2): incomplete proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(3): repeated oracle address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(4): too many signers"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(5): incorrect config"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(6): config digest doesn't match"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(7): wrong number of signatures"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(8): incorrect signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(9): no transmitter specified"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(10): incorrect transmission data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(11): no transmissions found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(12): median value is out of bounds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(13): LINK denom doesn't match"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(14): Reward Pool doesn't exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(15): wrong number of payees and transmitters"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(16): action is restricted to the module admin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(17): feed already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(19): feed doesnt exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(20): action is admin-restricted"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(21): insufficient reward pool"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(22): payee already set"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(23): action is payee-restricted"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(24): feed config not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(2): delegator address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(3): withdraw address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(4): validator address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(5): no delegation distribution info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(6): no validator distribution info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(7): no validator commission to withdraw"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(8): set withdraw address disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(9): community pool does not have sufficient coins to distribute"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(10): invalid community pool spend proposal amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(11): invalid community pool spend proposal recipient"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(12): validator does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(13): delegation does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(2): unknown subspace"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(3): failed to set parameter"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(4): submitted parameter changes are empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(5): parameter subspace is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(6): parameter key is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(7): parameter value is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(2): address is not associated with any known validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(3): validator does not exist for that address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(4): validator still jailed; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(5): validator not jailed; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(6): validator has no self-delegation; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(7): validator's self delegation less than minimum; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(8): no validator signing info found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(9): validator already tombstoned"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(1): internal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(2): duplicate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(3): invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(4): timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(5): unknown"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(6): empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(7): outdated"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(8): unsupported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(9): non contiguous event nonce"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(10): no unbatched txs found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(11): can not set orchestrator addresses more than once"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(12): supply cannot exceed max ERC20 value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(13): invalid ethereum sender on claim"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(14): invalid ethereum destination"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(15): missing previous claim for validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "icahost:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "icahost(2): host submodule is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(2): light client already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(3): light client is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(4): light client not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(5): light client is frozen due to misbehaviour"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(6): invalid client metadata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(7): consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(8): invalid consensus state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(9): client type not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(10): invalid client type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(11): commitment root not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(12): invalid client header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(13): invalid light client misbehaviour"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(14): client state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(15): client consensus state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(16): connection state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(17): channel state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(18): packet commitment verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(19): packet acknowledgement verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(20): packet receipt verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(21): next sequence receive verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(22): self consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(23): unable to update light client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(24): invalid recovery client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(25): invalid client upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(26): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(27): invalid client state substitute"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(28): invalid upgrade proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(29): client state is not active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(30): membership verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(31): non-membership verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(32): client type not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(2): connection already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(3): connection not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(4): light client connection paths not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(5): connection path is not associated to the given light client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(6): invalid connection state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(7): invalid counterparty connection"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(8): invalid connection"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(9): invalid connection version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(10): connection version negotiation failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(11): invalid connection identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(2): channel already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(3): channel not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(4): invalid channel"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(5): invalid channel state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(6): invalid channel ordering"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(7): invalid counterparty channel"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(8): invalid channel capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(9): channel capability not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(10): sequence send not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(11): sequence receive not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(12): sequence acknowledgement not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(13): invalid packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(14): packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(15): too many connection hops"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(16): invalid acknowledgement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(17): acknowledgement for packet already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(18): invalid channel identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(19): packet already received"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(20): packet commitment not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(21): packet sequence is out of order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(22): packet messages are redundant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(23): message is redundant, no-op will be performed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(24): invalid channel version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(25): packet has not been sent"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(26): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(27): upgrade error receipt not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(28): invalid upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(29): invalid upgrade sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(30): upgrade not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(31): incompatible counterparty upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(32): invalid upgrade error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(33): restore failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(34): upgrade timed-out"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(35): upgrade timeout is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(36): pending inflight packets exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(37): upgrade timeout failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(38): invalid pruning limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(39): timeout not reached"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(40): timeout elapsed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(41): pruning sequence start not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(42): recv start sequence not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(2): create wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(3): contract account already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(4): instantiate wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(5): execute wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(6): insufficient gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(7): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(8): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(9): query wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(10): invalid CosmosMsg from the contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(11): migrate wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(12): empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(13): exceeds limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(14): invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(15): duplicate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(16): max transfer channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(17): unsupported for this contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(18): pinning contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(19): unpinning contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(20): unknown message from the contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(21): invalid event"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(22): no such contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(27): max query stack size exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(28): no such code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(29): wasmvm error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(1): relayer address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(2): bad rates count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(3): bad resolve times"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(4): bad request ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(5): relayer not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(6): bad price feed base count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(7): bad price feed quote count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(8): unsupported oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(9): bad messages count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(10): bad Coinbase message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(11): bad Ethereum signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(12): bad Coinbase message timestamp"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(13): Coinbase price not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(14): Prices must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(15): Prices must be less than 10 million."
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(16): Invalid Band IBC Request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(17): sample error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(18): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(19): invalid symbols count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(20): could not claim port capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(21): invalid IBC Port ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(22): invalid IBC Channel ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(23): invalid Band IBC request interval"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(24): Invalid Band IBC Update Request Proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(25): Band IBC Oracle Request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(26): Base Info is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(27): provider is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(28): invalid provider name"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(29): invalid symbol"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(30): relayer already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(31): provider price not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(32): invalid oracle request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(33): no price for oracle was found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(34): no address for Pyth contract found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(35): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(36): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(37): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(38): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(39): empty price attestations"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(40): bad Stork message timestamp"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(41): sender stork is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(42): invalid stork signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(43): stork asset id not unique"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(1): insurance fund already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(2): insurance fund not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(3): redemption already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(4): invalid deposit amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(5): invalid deposit denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(6): insurance payout exceeds deposits"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(7): invalid ticker"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(8): invalid quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(9): invalid oracle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(10): invalid expiration time"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(11): invalid marketID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(12): invalid share denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(1): invalid gas limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(2): invalid gas price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(3): invalid contract address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(4): contract already registered"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(5): duplicate contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(6): no contract addresses found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(7): invalid code id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(8): not possible to deduct gas fees"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(9): missing granter address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(10): granter address does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(11): invalid funding mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(1): failed to validate order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(2): spot market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(3): spot market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(4): struct field error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(5): failed to validate market"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(6): subaccount has insufficient deposits"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(7): unrecognized order type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(8): position quantity insufficient for order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(9): order hash is not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(10): subaccount id is not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(11): invalid ticker"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(12): invalid base denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(13): invalid quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(14): invalid oracle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(15): invalid expiry"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(16): invalid price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(17): invalid quantity"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(18): unsupported oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(19): order doesnt exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(20): spot limit orderbook fill invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(21): perpetual market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(22): expiry futures market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(23): expiry futures market expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(24): no liquidity on the orderbook!"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(25): Orderbook liquidity cannot satisfy current worst price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(26): insufficient margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(27): Derivative market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(28): Position not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(29): Position direction does not oppose the reduce-only order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(30): Price Surpasses Bankruptcy Price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(31): Position not liquidable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(32): invalid trigger price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(33): invalid oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(34): invalid minimum price tick size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(35): invalid minimum quantity tick size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(36): invalid minimum order margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(37): Exceeds order side count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(38): Subaccount cannot place a market order when a market order in the same market was already placed in same block"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(39): cannot place a conditional market order when a conditional market order in same relative direction already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(40): An equivalent market launch proposal already exists."
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(41): Invalid Market Status"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(42): base denom cannot be same with quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(43): oracle base cannot be same with oracle quote"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(44): MakerFeeRate does not match TakerFeeRate requirements"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(45): MaintenanceMarginRatio cannot be greater than InitialMarginRatio"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:46"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(46): OracleScaleFactor cannot be greater than MaxOracleScaleFactor"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(47): Spot exchange is not enabled yet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:48"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(48): Derivatives exchange is not enabled yet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:49"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(49): Oracle price delta exceeds threshold"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:50"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(50): Invalid hourly interest rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:51"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(51): Invalid hourly funding rate cap"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:52"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(52): Only perpetual markets can update funding parameters"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:53"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(53): Invalid trading reward campaign"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:54"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(54): Invalid fee discount schedule"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:55"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(55): invalid liquidation order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:56"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(56): Unknown error happened for campaign distributions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:57"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(57): Invalid trading reward points update"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:58"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(58): Invalid batch msg update"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:59"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(59): Post-only order exceeds top of book price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:60"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(60): Order type not supported for given message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:61"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(61): Sender must match dmm account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:62"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(62): already opted out of rewards"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:63"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(63): Invalid margin ratio"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:64"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(64): Provided funds are below minimum"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:65"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(65): Position is below initial margin requirement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:66"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(66): Pool has non-positive total lp token supply"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:67"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(67): Passed lp token burn amount is greater than total lp token supply"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:68"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(68): unsupported action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:69"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(69): position quantity cannot be negative"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:70"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(70): binary options market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:71"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(71): binary options market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:72"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(72): invalid settlement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:73"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(73): account doesnt exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:74"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(74): sender should be a market admin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:75"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(75): market is already scheduled to settle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:76"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(76): market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:77"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(77): denom decimal cannot be below 1 or above max scale factor"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:78"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(78): state is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:79"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(79): transient orders up to cancellation not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:80"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(80): invalid trade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:81"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(81): no margin locked in subaccount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:82"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(82): Invalid access level to perform action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:83"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(83): Invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:84"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(84): Invalid argument"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:85"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(85): Invalid funds direction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:86"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(86): No funds provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:87"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(87): Invalid signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:88"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(88): no funds to unlock"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:89"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(89): No msgs provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:90"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(90): No msg provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:91"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(91): Invalid amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:92"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(92): The current feature has been disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:93"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(93): Order has too much margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:94"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(94): Subaccount nonce is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:95"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(95): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:96"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(96): exchange is in post-only mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:97"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(97): client order id already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:98"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(98): client order id is invalid. Max length is 36 chars"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:99"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(99): market cannot be settled in emergency mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:100"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(100): invalid notional"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:101"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(101): stale oracle price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:102"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(102): invalid stake grant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:103"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(103): insufficient stake for grant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:104"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(104): invalid permissions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(2): unknown data type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(3): account already exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(4): port is already bound"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(5): invalid message sent to channel end"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(6): invalid outgoing data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(7): invalid route"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(8): interchain account not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(9): interchain account is already set"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(10): active channel already set for this owner"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(11): no active channel for this owner"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(12): invalid interchain accounts version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(13): invalid account address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(14): interchain account does not support this action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(15): invalid controller port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(16): invalid host port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(17): timeout timestamp must be in the future"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(18): codec is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(19): invalid account reopening"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "icacontroller:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "icacontroller(2): controller submodule is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(2): invalid ICS29 middleware version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(3): no account found for given refund address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(4): balance not found for given account address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(5): there is no fee escrowed for the given packetID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(6): relayers must not be set. This feature is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(7): counterparty payee must not be empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(8): forward relayer address not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(9): fee module is not enabled for this channel. If this error occurs after channel setup, fee module may not be enabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(10): relayer address must be stored for async WriteAcknowledgement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(11): the fee module is currently locked, a severe bug has been detected"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(12): unsupported action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(2): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(3): invalid denomination for cross-chain transfer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(4): invalid ICS20 version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(5): invalid token amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(6): denomination trace not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(7): fungible token transfers from this chain are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(8): fungible token transfers to this chain are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(9): max transfer channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(10): invalid transfer authorization"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(11): invalid memo"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(2): port is already binded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(3): port not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(4): invalid port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(5): route not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(2): invalid header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(3): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(4): invalid signature and data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(5): signature verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(6): invalid solo machine proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(2): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(3): invalid trusting period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(4): invalid unbonding period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(5): invalid header height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(6): invalid header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(7): invalid max clock drift"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(8): processed time not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(9): processed height not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(10): packet-specified delay period has not been reached"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(11): time since latest trusted state has passed the trusting period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(12): time since latest trusted state has passed the unbonding period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(13): invalid proof specs"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(14): invalid validator set"
              }
            ]
          },
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
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(1): internal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(2): stop iterating"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "undefined:111222"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "undefined(111222): panic"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(2): value is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(3): duplicate value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(4): limit exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(5): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(6): invalid value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(7): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(8): modified"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "group:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "group(9): expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "math:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "math(10): invalid decimal string"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(11): iterator done"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(12): invalid iterator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(13): unique constraint violation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(14): invalid argument"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(15): key exceeds max length"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "legacy_orm:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "legacy_orm(47): cannot use empty key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibchooks:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibchooks(2): error in wasmhook message validation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(3): cannot marshal the ICS20 packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(4): invalid packet data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(5): cannot create response"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(6): wasm error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm-hooks:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm-hooks(7): bad sender"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tx:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tx(1): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tx:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tx(2): unknown protobuf field"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(2): invalid proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(3): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(4): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(5): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(6): conflict"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "store:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "store(7): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(2): tx parse error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(3): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(4): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(5): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(6): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(7): invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(8): invalid pubkey"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(9): unknown address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(10): invalid coins"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(11): out of gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(12): memo too large"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(13): insufficient fee"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(14): maximum number of signatures exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(15): no signatures supplied"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(16): failed to marshal JSON bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(17): failed to unmarshal JSON bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(18): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(19): tx already in mempool"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(20): mempool is full"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(21): tx too large"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(22): key not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(23): invalid account password"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(24): tx intended signer does not match the given signer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(25): invalid gas adjustment"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(26): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(27): invalid version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(28): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(29): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(30): tx timeout height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(31): unknown extension options"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(32): incorrect account sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(33): failed packing protobuf message to Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(34): failed unpacking protobuf message from Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(35): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(36): conflict"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(37): feature not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(38): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(39): Internal IO error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(40): error in app.toml"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "sdk:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "sdk(41): invalid gas limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(1): owasm compilation failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(2): bad wasm execution"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(3): data source not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(4): oracle script not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(5): request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(6): raw request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(7): reporter not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(8): result not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(9): reporter already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(10): validator not requested"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(11): validator already reported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(12): invalid report size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(13): reporter not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(14): editor not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(16): validator already active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(17): too soon to activate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(18): too long name"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(19): too long description"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(20): empty executable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(21): empty wasm code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(22): too large executable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(23): too large wasm code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(24): invalid min count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(25): invalid ask count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(26): too large calldata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(27): too long client id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(28): empty raw requests"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(29): empty report"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(30): duplicate external id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(31): too long schema"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(32): too long url"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(33): too large raw report data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(34): insufficient available validators"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(35): cannot create with [do-not-modify] content"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(36): cannot reference self as reporter"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(37): obi decode failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(38): uncompression failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(39): request already expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(40): bad drbg initialization"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(41): max oracle channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(42): invalid ICS20 version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(43): not enough fee"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(44): invalid owasm gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(45): sending oracle request via IBC is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:46"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(46): invalid request key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bandoracle:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bandoracle(47): too long request key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(2): fee limit exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(3): fee allowance expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(4): invalid duration"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(5): no allowance"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(6): allowed messages are empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feegrant:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feegrant(7): message not allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "table_testdata:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "table_testdata(2): test"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(2): authorization not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(3): expiration time of authorization should be more than current time"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(4): unknown authorization type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(5): grant key not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(6): authorization expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(7): grantee and granter should be different"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(9): authorization can be given to msg with only one signer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "authz:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "authz(12): max tokens should be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(2): capability name not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(3): provided capability is nil"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(4): capability name already taken"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(5): given owner already claimed capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(6): capability not owned by module"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(7): capability not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "capability:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "capability(8): owners not found for capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(2): invalid proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(3): invalid prefix"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "commitment:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "commitment(4): invalid merkle proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(2): invalid identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(3): invalid path"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "host:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "host(4): invalid packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(1): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(2): unauthorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(3): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(4): unknown request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(5): invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(6): invalid coins"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(7): out of gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(8): invalid request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(9): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(10): invalid version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(11): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(12): invalid type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(13): failed packing protobuf message to Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(14): failed unpacking protobuf message from Any"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(15): internal logic error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "ibc:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "ibc(16): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "injective:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "injective(3): invalid chain ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "auction:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "auction(1): invalid bid denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "auction:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "auction(2): invalid bid round"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(2): no inputs to send transaction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(3): no outputs to send transaction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(4): sum inputs != sum outputs"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(5): send transactions are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(6): client denom metadata not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(7): invalid key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(8): duplicate entry"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "bank:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "bank(9): multiple senders not allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(2): attempting to create a denom that already exists (has bank metadata)"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(3): unauthorized account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(4): invalid denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(5): invalid creator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(6): invalid authority metadata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(7): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(8): subdenom too long, max length is 44 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(9): subdenom too short, min length is 1 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(10): nested subdenom too short, each one should have at least 1 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(11): creator too long, max length is 75 bytes"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(12): denom does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "tokenfactory:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "tokenfactory(13): amount has to be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(2): attempting to create a namespace for denom that already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(3): unauthorized account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(4): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(5): invalid namespace"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(6): invalid permissions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(7): unknown role"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(8): unknown contract address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(9): restricted action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(10): invalid role"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(11): namespace for denom is not existing"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(12): wasm hook query error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(13): voucher was not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "permissions:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "permissions(14): invalid wasm hook"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "crisis:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "crisis(2): sender address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "crisis:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "crisis(3): unknown invariant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(2): empty validator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(3): validator does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(4): validator already exist for this operator address; must use new validator operator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(5): validator already exist for this pubkey; must use new validator pubkey"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(6): validator pubkey type is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(7): validator for this address is currently jailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(8): failed to remove validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(9): commission must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(10): commission cannot be more than 100%"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(11): commission cannot be more than the max rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(12): commission cannot be changed more than once in 24h"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(13): commission change rate must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(14): commission change rate cannot be more than the max rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(15): commission cannot be changed more than max change rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(16): validator's self delegation must be greater than their minimum self delegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(17): minimum self delegation cannot be decrease"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(18): empty delegator address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(19): no delegation for (address, validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(20): delegator does not exist with address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(21): delegator does not contain delegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(22): insufficient delegation shares"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(23): cannot delegate to an empty validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(24): not enough delegation shares"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(25): entry not mature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(26): no unbonding delegation found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(27): too many unbonding delegation entries for (delegator, validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(28): no redelegation found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(29): cannot redelegate to the same validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(30): too few tokens to redelegate (truncates to zero tokens)"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(31): redelegation destination validator not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(32): redelegation to this validator already in progress; first redelegation to this validator must complete before next redelegation"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(33): too many redelegation entries for (delegator, src-validator, dst-validator) tuple"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(34): cannot delegate to validators with invalid (zero) ex-rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(35): both shares amount and shares percent provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(36): neither shares amount nor shares percent provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(37): invalid historical info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(38): no historical info found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(39): empty validator public key"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(40): commission cannot be less than min rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(41): unbonding operation not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(42): cannot un-hold unbonding operation that is not on hold"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(43): expected authority account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(44): redelegation source validator not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(45): unbonding type not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "staking:70"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "staking(70): commission rate too small"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(2): unregistered handler for evidence type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(3): invalid evidence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "evidence:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "evidence(5): evidence already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(3): inactive proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(4): proposal already active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(5): invalid proposal content"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(6): invalid proposal type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(7): invalid vote option"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(8): invalid genesis state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(9): no handler exists for proposal type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(10): proposal message not recognized by router"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(11): no messages proposed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(12): invalid proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(13): expected gov account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(15): metadata too long"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(16): minimum deposit is too small"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(18): invalid proposer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(20): voting period already ended"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(21): invalid proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(22): summary too long"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "gov:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "gov(23): invalid deposit denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(2): module version not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(3): upgrade plan not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(4): upgraded client not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(5): upgraded consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "upgrade:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "upgrade(6): expected authority account as only signer for proposal message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(1): stale report"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(2): incomplete proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(3): repeated oracle address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(4): too many signers"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(5): incorrect config"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(6): config digest doesn't match"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(7): wrong number of signatures"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(8): incorrect signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(9): no transmitter specified"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(10): incorrect transmission data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(11): no transmissions found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(12): median value is out of bounds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(13): LINK denom doesn't match"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(14): Reward Pool doesn't exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(15): wrong number of payees and transmitters"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(16): action is restricted to the module admin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(17): feed already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(19): feed doesnt exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(20): action is admin-restricted"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(21): insufficient reward pool"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(22): payee already set"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(23): action is payee-restricted"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "chainlink:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "chainlink(24): feed config not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(2): delegator address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(3): withdraw address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(4): validator address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(5): no delegation distribution info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(6): no validator distribution info"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(7): no validator commission to withdraw"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(8): set withdraw address disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(9): community pool does not have sufficient coins to distribute"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(10): invalid community pool spend proposal amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(11): invalid community pool spend proposal recipient"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(12): validator does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "distribution:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "distribution(13): delegation does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(2): unknown subspace"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(3): failed to set parameter"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(4): submitted parameter changes are empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(5): parameter subspace is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(6): parameter key is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "params:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "params(7): parameter value is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(2): address is not associated with any known validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(3): validator does not exist for that address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(4): validator still jailed; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(5): validator not jailed; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(6): validator has no self-delegation; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(7): validator's self delegation less than minimum; cannot be unjailed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(8): no validator signing info found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "slashing:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "slashing(9): validator already tombstoned"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(1): internal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(2): duplicate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(3): invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(4): timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(5): unknown"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(6): empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(7): outdated"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(8): unsupported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(9): non contiguous event nonce"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(10): no unbatched txs found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(11): can not set orchestrator addresses more than once"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(12): supply cannot exceed max ERC20 value"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(13): invalid ethereum sender on claim"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(14): invalid ethereum destination"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "peggy:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "peggy(15): missing previous claim for validator"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "icahost:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "icahost(2): host submodule is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(2): light client already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(3): light client is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(4): light client not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(5): light client is frozen due to misbehaviour"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(6): invalid client metadata"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(7): consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(8): invalid consensus state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(9): client type not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(10): invalid client type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(11): commitment root not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(12): invalid client header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(13): invalid light client misbehaviour"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(14): client state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(15): client consensus state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(16): connection state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(17): channel state verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(18): packet commitment verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(19): packet acknowledgement verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(20): packet receipt verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(21): next sequence receive verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(22): self consensus state not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(23): unable to update light client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(24): invalid recovery client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(25): invalid client upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(26): invalid height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(27): invalid client state substitute"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(28): invalid upgrade proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(29): client state is not active"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(30): membership verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(31): non-membership verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "client:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "client(32): client type not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(2): connection already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(3): connection not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(4): light client connection paths not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(5): connection path is not associated to the given light client"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(6): invalid connection state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(7): invalid counterparty connection"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(8): invalid connection"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(9): invalid connection version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(10): connection version negotiation failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "connection:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "connection(11): invalid connection identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(2): channel already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(3): channel not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(4): invalid channel"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(5): invalid channel state"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(6): invalid channel ordering"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(7): invalid counterparty channel"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(8): invalid channel capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(9): channel capability not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(10): sequence send not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(11): sequence receive not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(12): sequence acknowledgement not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(13): invalid packet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(14): packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(15): too many connection hops"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(16): invalid acknowledgement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(17): acknowledgement for packet already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(18): invalid channel identifier"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(19): packet already received"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(20): packet commitment not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(21): packet sequence is out of order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(22): packet messages are redundant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(23): message is redundant, no-op will be performed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(24): invalid channel version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(25): packet has not been sent"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(26): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(27): upgrade error receipt not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(28): invalid upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(29): invalid upgrade sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(30): upgrade not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(31): incompatible counterparty upgrade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(32): invalid upgrade error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(33): restore failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(34): upgrade timed-out"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(35): upgrade timeout is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(36): pending inflight packets exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(37): upgrade timeout failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(38): invalid pruning limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(39): timeout not reached"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(40): timeout elapsed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(41): pruning sequence start not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "channel:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "channel(42): recv start sequence not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(2): create wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(3): contract account already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(4): instantiate wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(5): execute wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(6): insufficient gas"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(7): invalid genesis"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(8): not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(9): query wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(10): invalid CosmosMsg from the contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(11): migrate wasm contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(12): empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(13): exceeds limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(14): invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(15): duplicate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(16): max transfer channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(17): unsupported for this contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(18): pinning contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(19): unpinning contract failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(20): unknown message from the contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(21): invalid event"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(22): no such contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(27): max query stack size exceeded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(28): no such code"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "wasm:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "wasm(29): wasmvm error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(1): relayer address is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(2): bad rates count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(3): bad resolve times"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(4): bad request ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(5): relayer not authorized"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(6): bad price feed base count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(7): bad price feed quote count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(8): unsupported oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(9): bad messages count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(10): bad Coinbase message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(11): bad Ethereum signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(12): bad Coinbase message timestamp"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(13): Coinbase price not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(14): Prices must be positive"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(15): Prices must be less than 10 million."
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(16): Invalid Band IBC Request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(17): sample error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(18): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(19): invalid symbols count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(20): could not claim port capability"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(21): invalid IBC Port ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(22): invalid IBC Channel ID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(23): invalid Band IBC request interval"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(24): Invalid Band IBC Update Request Proposal"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(25): Band IBC Oracle Request not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(26): Base Info is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(27): provider is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(28): invalid provider name"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(29): invalid symbol"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(30): relayer already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(31): provider price not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(32): invalid oracle request"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(33): no price for oracle was found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(34): no address for Pyth contract found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(35): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(36): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(37): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(38): unauthorized Pyth price relay"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(39): empty price attestations"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(40): bad Stork message timestamp"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(41): sender stork is empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(42): invalid stork signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "oracle:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "oracle(43): stork asset id not unique"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(1): insurance fund already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(2): insurance fund not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(3): redemption already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(4): invalid deposit amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(5): invalid deposit denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(6): insurance payout exceeds deposits"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(7): invalid ticker"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(8): invalid quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(9): invalid oracle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(10): invalid expiration time"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(11): invalid marketID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "insurance:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "insurance(12): invalid share denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(1): invalid gas limit"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(2): invalid gas price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(3): invalid contract address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(4): contract already registered"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(5): duplicate contract"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(6): no contract addresses found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(7): invalid code id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(8): not possible to deduct gas fees"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(9): missing granter address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(10): granter address does not exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "xwasm:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "xwasm(11): invalid funding mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:1"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(1): failed to validate order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(2): spot market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(3): spot market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(4): struct field error"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(5): failed to validate market"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(6): subaccount has insufficient deposits"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(7): unrecognized order type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(8): position quantity insufficient for order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(9): order hash is not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(10): subaccount id is not valid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(11): invalid ticker"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(12): invalid base denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(13): invalid quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(14): invalid oracle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(15): invalid expiry"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(16): invalid price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(17): invalid quantity"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(18): unsupported oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(19): order doesnt exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:20"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(20): spot limit orderbook fill invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:21"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(21): perpetual market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:22"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(22): expiry futures market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:23"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(23): expiry futures market expired"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:24"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(24): no liquidity on the orderbook!"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:25"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(25): Orderbook liquidity cannot satisfy current worst price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:26"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(26): insufficient margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:27"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(27): Derivative market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:28"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(28): Position not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:29"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(29): Position direction does not oppose the reduce-only order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:30"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(30): Price Surpasses Bankruptcy Price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:31"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(31): Position not liquidable"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:32"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(32): invalid trigger price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:33"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(33): invalid oracle type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:34"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(34): invalid minimum price tick size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:35"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(35): invalid minimum quantity tick size"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:36"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(36): invalid minimum order margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:37"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(37): Exceeds order side count"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:38"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(38): Subaccount cannot place a market order when a market order in the same market was already placed in same block"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:39"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(39): cannot place a conditional market order when a conditional market order in same relative direction already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:40"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(40): An equivalent market launch proposal already exists."
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:41"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(41): Invalid Market Status"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:42"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(42): base denom cannot be same with quote denom"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:43"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(43): oracle base cannot be same with oracle quote"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:44"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(44): MakerFeeRate does not match TakerFeeRate requirements"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:45"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(45): MaintenanceMarginRatio cannot be greater than InitialMarginRatio"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:46"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(46): OracleScaleFactor cannot be greater than MaxOracleScaleFactor"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:47"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(47): Spot exchange is not enabled yet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:48"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(48): Derivatives exchange is not enabled yet"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:49"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(49): Oracle price delta exceeds threshold"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:50"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(50): Invalid hourly interest rate"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:51"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(51): Invalid hourly funding rate cap"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:52"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(52): Only perpetual markets can update funding parameters"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:53"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(53): Invalid trading reward campaign"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:54"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(54): Invalid fee discount schedule"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:55"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(55): invalid liquidation order"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:56"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(56): Unknown error happened for campaign distributions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:57"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(57): Invalid trading reward points update"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:58"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(58): Invalid batch msg update"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:59"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(59): Post-only order exceeds top of book price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:60"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(60): Order type not supported for given message"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:61"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(61): Sender must match dmm account"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:62"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(62): already opted out of rewards"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:63"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(63): Invalid margin ratio"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:64"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(64): Provided funds are below minimum"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:65"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(65): Position is below initial margin requirement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:66"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(66): Pool has non-positive total lp token supply"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:67"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(67): Passed lp token burn amount is greater than total lp token supply"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:68"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(68): unsupported action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:69"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(69): position quantity cannot be negative"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:70"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(70): binary options market exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:71"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(71): binary options market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:72"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(72): invalid settlement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:73"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(73): account doesnt exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:74"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(74): sender should be a market admin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:75"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(75): market is already scheduled to settle"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:76"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(76): market not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:77"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(77): denom decimal cannot be below 1 or above max scale factor"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:78"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(78): state is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:79"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(79): transient orders up to cancellation not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:80"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(80): invalid trade"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:81"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(81): no margin locked in subaccount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:82"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(82): Invalid access level to perform action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:83"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(83): Invalid address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:84"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(84): Invalid argument"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:85"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(85): Invalid funds direction"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:86"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(86): No funds provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:87"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(87): Invalid signature"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:88"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(88): no funds to unlock"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:89"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(89): No msgs provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:90"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(90): No msg provided"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:91"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(91): Invalid amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:92"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(92): The current feature has been disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:93"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(93): Order has too much margin"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:94"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(94): Subaccount nonce is invalid"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:95"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(95): insufficient funds"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:96"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(96): exchange is in post-only mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:97"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(97): client order id already exists"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:98"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(98): client order id is invalid. Max length is 36 chars"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:99"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(99): market cannot be settled in emergency mode"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:100"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(100): invalid notional"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:101"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(101): stale oracle price"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:102"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(102): invalid stake grant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:103"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(103): insufficient stake for grant"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "exchange:104"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "exchange(104): invalid permissions"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(2): unknown data type"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(3): account already exist"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(4): port is already bound"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(5): invalid message sent to channel end"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(6): invalid outgoing data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(7): invalid route"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(8): interchain account not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(9): interchain account is already set"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(10): active channel already set for this owner"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(11): no active channel for this owner"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(12): invalid interchain accounts version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(13): invalid account address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(14): interchain account does not support this action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:15"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(15): invalid controller port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:16"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(16): invalid host port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:17"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(17): timeout timestamp must be in the future"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:18"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(18): codec is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "interchainaccounts:19"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "interchainaccounts(19): invalid account reopening"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "icacontroller:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "icacontroller(2): controller submodule is disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(2): invalid ICS29 middleware version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(3): no account found for given refund address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(4): balance not found for given account address"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(5): there is no fee escrowed for the given packetID"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(6): relayers must not be set. This feature is not supported"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(7): counterparty payee must not be empty"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(8): forward relayer address not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(9): fee module is not enabled for this channel. If this error occurs after channel setup, fee module may not be enabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(10): relayer address must be stored for async WriteAcknowledgement"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(11): the fee module is currently locked, a severe bug has been detected"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "feeibc:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "feeibc(12): unsupported action"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(2): invalid packet timeout"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(3): invalid denomination for cross-chain transfer"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(4): invalid ICS20 version"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(5): invalid token amount"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(6): denomination trace not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(7): fungible token transfers from this chain are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(8): fungible token transfers to this chain are disabled"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(9): max transfer channels"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(10): invalid transfer authorization"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "transfer:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "transfer(11): invalid memo"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(2): port is already binded"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(3): port not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(4): invalid port"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "port:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "port(5): route not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(2): invalid header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(3): invalid sequence"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(4): invalid signature and data"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(5): signature verification failed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "06-solomachine:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "06-solomachine(6): invalid solo machine proof"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:2"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(2): invalid chain-id"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:3"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(3): invalid trusting period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:4"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(4): invalid unbonding period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:5"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(5): invalid header height"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:6"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(6): invalid header"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:7"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(7): invalid max clock drift"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:8"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(8): processed time not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:9"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(9): processed height not found"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:10"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(10): packet-specified delay period has not been reached"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:11"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(11): time since latest trusted state has passed the trusting period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:12"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(12): time since latest trusted state has passed the unbonding period"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:13"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(13): invalid proof specs"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "07-tendermint:14"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "07-tendermint(14): invalid validator set"
              }
            ]
          },
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
