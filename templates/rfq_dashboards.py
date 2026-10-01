#!/usr/bin/env python3
"""Generates RFQ / WASM error Grafana panels for coremon.

Outputs (next to this script):
  - coremon_rfq.gen.json:        standalone "Coremon: RFQ & WASM Errors" dashboard
  - coremon_rfq_row.gen.json:    RFQ latency row panels for the main "Coremon: Mainnet" dashboard

Error series names ("<codespace>:<code>") are mapped using errors.json, RFQ reasons using RFQ_ERRORS.
"""

import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))
DS = {"type": "influxdb", "uid": "febedkgp47y0wa"}
CHAIN = '"chain_id" =~ /^$ChainID$/'

OFFICIAL = "\"official\" = 'true'"
UNOFFICIAL = "\"official\" = 'false'"

# Keep in sync with rfqErrPatterns in pkg/coremon/rfq.go
RFQ_ERRORS = {
    "quote_expired": "stale: maker quote expired",
    "rfq_id_outside_window": "stale: rfq_id outside ±60s window",
    "maker_nonce_too_old": "stale: maker nonce too old",
    "intent_deadline_passed": "stale: signed intent deadline passed",
    "nonce_in_future": "clock: nonce in the future",
    "nonce_already_used": "replay: nonce already used",
    "nonce_too_low": "replay: nonce too low",
    "quote_duplicated": "replay: quote duplicated",
    "stale_epoch": "intent: stale epoch (cancelled)",
    "stale_lane_version": "intent: stale lane version (cancelled)",
    "invalid_signature": "signature: invalid",
    "mark_price_band": "price: outside mark price band",
    "worse_than_worst_price": "price: worse than worst_price",
    "trigger_not_satisfied": "price: trigger not satisfied",
    "price_tick": "price: not a multiple of tick",
    "min_total_fill": "fill: below min_total_fill_quantity",
    "maker_min_fill": "fill: below maker min_fill_quantity",
    "min_notional": "fill: below market min_notional",
    "quantity_tick": "fill: quantity tick",
    "reduce_only_quantity": "fill: reduce-only quantity",
    "no_quote_filled": "fill: no quote was filled",
    "atomic_order_partial_fill": "proxy: atomic order partially filled",
    "maker_insufficient_balance": "funds: maker insufficient balance",
    "insufficient_funds": "funds: insufficient funds",
    "margin_below_required": "margin: below required",
    "maker_authz_grant": "authz: maker grant",
    "not_registered": "maker: not registered",
    "open_position": "settlement: open position",
    "other": "settlement: other",
    "invalid_intent": "intent: invalid",
    "unauthorized": "input: unauthorized",
    "invalid_input": "input: invalid",
    "out_of_gas": "chain: out of gas",
    "unknown": "other: unknown",
    "none": "ok",
}

STALE_COLOR = "red"


def load_error_names():
    with open(os.path.join(HERE, "errors.json")) as f:
        errs = json.load(f)
    return {f"{e['codespace']}:{e['code']}": f"{e['codespace']}({e['code']}): {e['description']}" for e in errs}


def rename_overrides(names):
    return [
        {"matcher": {"id": "byName", "options": k}, "properties": [{"id": "displayName", "value": v}]}
        for k, v in names.items()
    ]


def color_override(name, color):
    return {
        "matcher": {"id": "byName", "options": name},
        "properties": [{"id": "color", "value": {"fixedColor": color, "mode": "fixed"}}],
    }


def stale_overrides():
    # stale reasons in red shades to stand out
    shades = ["red", "dark-red", "semi-dark-red", "light-red"]
    return [color_override(k, shades[i % len(shades)]) for i, k in enumerate(
        ["quote_expired", "rfq_id_outside_window", "maker_nonce_too_old", "intent_deadline_passed"])]


def target(ref, query, alias=None, fmt="time_series"):
    t = {"datasource": DS, "rawQuery": True, "query": query, "refId": ref, "resultFormat": fmt}
    if alias:
        t["alias"] = alias
    return t


def ts_panel(title, targets, desc="", unit="short", draw="line", stack=False, overrides=None,
             log=False, legend_calcs=None, min_=None, fill=10, points="auto"):
    custom = {
        "drawStyle": draw,
        "lineWidth": 0 if draw == "bars" else 1,
        "fillOpacity": 70 if draw == "bars" else fill,
        "showPoints": points,
        "pointSize": 4,
        "spanNulls": False,
        "stacking": {"group": "A", "mode": "normal" if stack else "none"},
        "scaleDistribution": {"type": "log", "log": 2} if log else {"type": "linear"},
        "axisPlacement": "auto",
        "gradientMode": "none",
        "lineInterpolation": "linear",
        "barAlignment": 0,
        "insertNulls": False,
        "thresholdsStyle": {"mode": "off"},
    }
    defaults = {"color": {"mode": "palette-classic"}, "custom": custom, "unit": unit, "mappings": []}
    if min_ is not None:
        defaults["min"] = min_
    return {
        "type": "timeseries",
        "title": title,
        "description": desc,
        "datasource": DS,
        "fieldConfig": {"defaults": defaults, "overrides": overrides or []},
        "options": {
            "legend": {"calcs": legend_calcs or ["sum"], "displayMode": "table", "placement": "bottom",
                       "showLegend": True, "sortBy": "Total" if (legend_calcs or ["sum"]) == ["sum"] else None,
                       "sortDesc": True},
            "tooltip": {"mode": "multi", "sort": "desc", "hideZeros": True},
        },
        "targets": targets,
    }


def row(title, collapsed=False):
    return {"type": "row", "title": title, "collapsed": collapsed, "panels": []}


# ---------------------------------------------------------------------------------------------
# Queries

def q_lat(field, where, pct):
    return (f'SELECT percentile("{field}", {pct}) FROM "coremon_rfq_txs" '
            f'WHERE {CHAIN} AND {where} AND $timeFilter GROUP BY time($Interval) fill(none)')


def latency_panel(title, desc, where, fields):
    targets = []
    ref = ord("A")
    for field, label in fields:
        for pct in (50, 90, 99):
            targets.append(target(chr(ref), q_lat(field, where, pct), f"{label} p{pct}"))
            ref += 1
    return ts_panel(title, targets, desc, unit="ms", draw="line", points="always",
                    legend_calcs=["mean", "max"], log=True, min_=0)


def blocks_missed_panel(title, desc, where, fields):
    targets = []
    ref = ord("A")
    for field, label in fields:
        targets.append(target(chr(ref), (
            f'SELECT mean("{field}") FROM "coremon_rfq_txs" WHERE {CHAIN} AND {where} AND $timeFilter '
            f'GROUP BY time($Interval) fill(none)'), f"{label} mean"))
        ref += 1
        targets.append(target(chr(ref), (
            f'SELECT max("{field}") FROM "coremon_rfq_txs" WHERE {CHAIN} AND {where} AND $timeFilter '
            f'GROUP BY time($Interval) fill(none)'), f"{label} max"))
        ref += 1
    return ts_panel(title, targets, desc, unit="short", draw="bars", legend_calcs=["mean", "max"], min_=0)


def outcomes_panel(title, desc, where, error_names):
    q = (f'SELECT count("count") FROM "coremon_rfq_txs" WHERE {CHAIN} AND {where} AND $timeFilter '
         f'GROUP BY time($Interval), "err" fill(none)')
    overrides = rename_overrides({**RFQ_ERRORS, **error_names}) + stale_overrides() + [
        color_override("none", "green")]
    return ts_panel(title, [target("A", q, "$tag_err")], desc, draw="bars", stack=True, overrides=overrides)


def histogram_panel(title, desc, queries, unit="short", bucket_size=None):
    targets = [target(chr(ord("A") + i), q, alias) for i, (q, alias) in enumerate(queries)]
    opts = {"combine": False, "fillOpacity": 60, "legend": {"displayMode": "list", "placement": "bottom",
                                                            "showLegend": True}}
    if bucket_size:
        opts["bucketSize"] = bucket_size
        opts["bucketOffset"] = -0.5 if unit == "short" else 0
    return {
        "type": "histogram",
        "title": title,
        "description": desc,
        "datasource": DS,
        "fieldConfig": {"defaults": {"color": {"mode": "palette-classic"}, "unit": unit,
                                     "custom": {"lineWidth": 1, "fillOpacity": 60}}, "overrides": []},
        "options": opts,
        "targets": targets,
    }


def bucket_rate_panel(title, desc, field):
    # failure (or stale) rate per latency bucket over the selected range, official vs unofficial
    q = (f'SELECT count("{field}") / count("count") AS "rate" FROM "coremon_rfq_txs" '
         f'WHERE {CHAIN} AND $timeFilter GROUP BY "lat_bucket", "official"')
    return {
        "type": "barchart",
        "title": title,
        "description": desc,
        "datasource": DS,
        "fieldConfig": {
            "defaults": {"color": {"mode": "palette-classic"}, "unit": "percentunit", "min": 0,
                         "custom": {"fillOpacity": 80, "lineWidth": 1, "axisPlacement": "auto"}},
            "overrides": [],
        },
        "options": {
            "xField": "lat_bucket",
            "orientation": "vertical",
            "showValue": "auto",
            "groupWidth": 0.8,
            "barWidth": 0.9,
            "stacking": "none",
            "legend": {"displayMode": "list", "placement": "bottom", "showLegend": True},
            "tooltip": {"mode": "multi", "sort": "none"},
            "xTickLabelRotation": -30,
        },
        "targets": [target("A", q, fmt="table")],
        "transformations": [
            {"id": "merge", "options": {}},
            {"id": "organize", "options": {"excludeByName": {"Time": True}}},
            {"id": "groupingToMatrix", "options": {"columnField": "official", "rowField": "lat_bucket",
                                                   "valueField": "rate", "emptyValue": "zero"}},
            {"id": "organize", "options": {"renameByName": {"lat_bucket\\official": "lat_bucket",
                                                            "true": "official rate",
                                                            "false": "unofficial rate"}}},
            {"id": "sortBy", "options": {"sort": [{"field": "lat_bucket"}]}},
        ],
    }


def bucket_count_panel(title, desc):
    q = (f'SELECT count("count") AS "txs", count("error") AS "failed", count("stale") AS "stale" '
         f'FROM "coremon_rfq_txs" WHERE {CHAIN} AND $timeFilter GROUP BY "lat_bucket", "official"')
    return {
        "type": "table",
        "title": title,
        "description": desc,
        "datasource": DS,
        "fieldConfig": {"defaults": {"custom": {"align": "auto"}}, "overrides": [
            {"matcher": {"id": "byName", "options": "stale %"},
             "properties": [{"id": "unit", "value": "percentunit"},
                            {"id": "custom.cellOptions", "value": {"type": "color-background", "mode": "gradient"}},
                            {"id": "color", "value": {"mode": "continuous-GrYlRd"}}, {"id": "max", "value": 1},
                            {"id": "min", "value": 0}]},
            {"matcher": {"id": "byName", "options": "failed %"},
             "properties": [{"id": "unit", "value": "percentunit"}, {"id": "max", "value": 1},
                            {"id": "min", "value": 0}]},
        ]},
        "options": {"showHeader": True, "sortBy": [{"displayName": "lat_bucket", "desc": False}]},
        "targets": [target("A", q, fmt="table")],
        "transformations": [
            {"id": "organize", "options": {"excludeByName": {"Time": True}}},
            {"id": "calculateField", "options": {"mode": "binary", "alias": "failed %",
                                                 "binary": {"left": "failed", "operator": "/", "right": "txs"}}},
            {"id": "calculateField", "options": {"mode": "binary", "alias": "stale %",
                                                 "binary": {"left": "stale", "operator": "/", "right": "txs"}}},
        ],
    }


def latency_vs_stale_panel():
    targets = [
        target("A", q_lat("memo_latency_ms", OFFICIAL, 90), "official p90 latency (memo t)"),
        target("B", q_lat("rfq_id_latency_ms", UNOFFICIAL + ' AND "rfq_id_latency_ms" < 60000', 90),
               "unofficial p90 latency (rfq_id, <60s)"),
        target("C", (f'SELECT count("stale") FROM "coremon_rfq_txs" WHERE {CHAIN} AND $timeFilter '
                     f'GROUP BY time($Interval), "official" fill(none)'), "stale tx rejections official=$tag_official"),
        target("D", (f'SELECT count("stale") FROM "coremon_rfq_quotes" WHERE {CHAIN} AND $timeFilter '
                     f'GROUP BY time($Interval), "official" fill(none)'), "stale quote rejections official=$tag_official"),
    ]
    p = ts_panel("Latency vs Stale Rejections", targets,
                 "Lines: p90 inclusion latency (left axis). Bars: RFQ rejections caused by staleness "
                 "(quote expired, rfq_id outside window, nonce too old, intent deadline) on the right axis.",
                 unit="ms", draw="line", points="always", legend_calcs=["mean", "max", "sum"], min_=0)
    p["fieldConfig"]["overrides"] = [{
        "matcher": {"id": "byRegexp", "options": "stale.*"},
        "properties": [
            {"id": "unit", "value": "short"},
            {"id": "custom.drawStyle", "value": "bars"},
            {"id": "custom.fillOpacity", "value": 80},
            {"id": "custom.axisPlacement", "value": "right"},
            {"id": "custom.axisLabel", "value": "stale rejections"},
            {"id": "color", "value": {"fixedColor": STALE_COLOR, "mode": "fixed"}},
        ],
    }, {
        "matcher": {"id": "byRegexp", "options": "stale quote.*"},
        "properties": [{"id": "color", "value": {"fixedColor": "orange", "mode": "fixed"}}],
    }]
    return p


def table_panel(title, desc, query, overrides=None, sort=None):
    return {
        "type": "table",
        "title": title,
        "description": desc,
        "datasource": DS,
        "fieldConfig": {"defaults": {"custom": {"align": "auto", "filterable": True}}, "overrides": overrides or []},
        "options": {"showHeader": True, "sortBy": sort or []},
        "targets": [target("A", query, fmt="table")],
        "transformations": [{"id": "organize", "options": {"excludeByName": {"Time": True}}}],
    }


def err_value_mappings(error_names):
    mapping = {k: {"text": v} for k, v in {**RFQ_ERRORS, **error_names}.items()}
    return [{"type": "value", "options": mapping}]


# ---------------------------------------------------------------------------------------------
# Layout helpers

# Grafana version the panels are written for; without it Grafana runs panel migrations on load
# (e.g. xychart series matchers get re-wrapped as if they were in the legacy format).
PLUGIN_VERSION = "12.1.0"


def layout(items):
    """items: list of (panel, w, h) or row. Packs panels left-to-right in a 24 column grid."""
    out, x, y, row_h, pid = [], 0, 0, 0, 1
    for it in items:
        panel = it if isinstance(it, dict) else it[0]
        if panel.get("type") != "row":
            panel["pluginVersion"] = PLUGIN_VERSION
        if isinstance(it, dict):
            if x:
                y += row_h
            x, row_h = 0, 0
            it["gridPos"] = {"h": 1, "w": 24, "x": 0, "y": y}
            it["id"] = pid
            pid += 1
            out.append(it)
            y += 1
            continue
        p, w, h = it
        if x + w > 24:
            x, y, row_h = 0, y + row_h, 0
        p["gridPos"] = {"h": h, "w": w, "x": x, "y": y}
        p["id"] = pid
        pid += 1
        out.append(p)
        x += w
        row_h = max(row_h, h)
    return out


# ---------------------------------------------------------------------------------------------
# Panels

T_NOTE = " Empty when no official tx with memo t landed in the range."


def deviation_panel():
    field = "t_minus_rfq_id_ms"
    where = f'{OFFICIAL} AND "{field}" > -1000000000000'
    targets = [target(chr(ord("A") + i), (
        f'SELECT {sel} FROM "coremon_rfq_txs" WHERE {CHAIN} AND {where} AND $timeFilter '
        f'GROUP BY time($Interval) fill(none)'), alias)
        for i, (sel, alias) in enumerate([
            (f'min("{field}")', "min"),
            (f'percentile("{field}", 10)', "p10"),
            (f'percentile("{field}", 50)', "p50"),
            (f'percentile("{field}", 90)', "p90"),
            (f'max("{field}")', "max"),
            (f'count("{field}")', "txs"),
        ])]
    p = ts_panel("t − rfq_id Deviation (official)", targets,
                 "Memo t (client timestamp) minus rfq_id (RFQ gateway request timestamp), per tx, only when both "
                 "are set. Positive: t stamped after the request (quotes collection, user confirmation). "
                 "Negative: rfq_id assigned after t was stamped (re-quote). Also includes client vs gateway "
                 "clock skew." + T_NOTE,
                 unit="ms", draw="line", points="always", legend_calcs=["mean", "min", "max"])
    p["fieldConfig"]["overrides"] = [{
        "matcher": {"id": "byName", "options": "txs"},
        "properties": [{"id": "unit", "value": "short"}, {"id": "custom.drawStyle", "value": "bars"},
                       {"id": "custom.fillOpacity", "value": 25}, {"id": "custom.axisPlacement", "value": "right"},
                       {"id": "color", "value": {"fixedColor": "text", "mode": "fixed"}}],
    }, {
        "matcher": {"id": "byRegexp", "options": "min|max"},
        "properties": [{"id": "custom.lineStyle", "value": {"fill": "dash", "dash": [4, 4]}}],
    }]
    return p


STALE_DESC = ("Only txs (or quotes) rejected as stale: maker quote expired, rfq_id outside the ±60s window, "
              "maker nonce too old, signed intent deadline passed.")


def stale_late_by_panel():
    targets = [
        target("A", (f'SELECT "late_by_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND "stale" = 1 AND $timeFilter '
                     f'GROUP BY "err", "official"'), "tx: $tag_err official=$tag_official"),
        target("B", (f'SELECT "late_by_ms" FROM "coremon_rfq_quotes" WHERE {CHAIN} AND "stale" = 1 AND $timeFilter '
                     f'GROUP BY "err", "official"'), "quote: $tag_err official=$tag_official"),
    ]
    p = ts_panel("Stale Rejections: How Late (wallclock)", targets,
                 STALE_DESC + " How much sooner the tx had to land (by block time) to pass the check: "
                 "block time − quote expiry, block time − (rfq_id + window), block time − intent deadline. "
                 "With several expired quotes, the least late one.",
                 unit="ms", draw="points", points="always", legend_calcs=["mean", "max", "count"], log=True)
    return p


def stale_latency_panel():
    targets = [
        target("A", (f'SELECT "rfq_id_latency_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND "stale" = 1 '
                     f'AND $timeFilter GROUP BY "official"'), "rfq_id latency official=$tag_official"),
        target("B", (f'SELECT "memo_latency_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND "stale" = 1 '
                     f'AND $timeFilter GROUP BY "official"'), "memo t latency official=$tag_official"),
    ]
    return ts_panel("Stale Rejections: Inclusion Latency", targets,
                    STALE_DESC + " Wallclock latency from the client timestamps (rfq_id, memo t) to the block "
                    "time of the tx that was rejected.",
                    unit="ms", draw="points", points="always", legend_calcs=["mean", "max", "count"], log=True)


def latency_scatter_panel():
    q = (f'SELECT "memo_latency_ms", "rfq_id_latency_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND {OFFICIAL} '
         f'AND "memo_latency_ms" > -1000000000000 AND $timeFilter')
    return {
        "type": "xychart",
        "title": "Latency per Tx: memo t vs rfq_id (official)",
        "description": "Each point is one official RFQ tx with memo t. X: latency from memo t, Y: latency from rfq_id. "
                       "Points on the diagonal mean rfq_id ≈ t." + T_NOTE,
        "datasource": DS,
        "fieldConfig": {"defaults": {"unit": "ms", "color": {"mode": "palette-classic"},
                                     "custom": {"show": "points", "pointSize": {"fixed": 6}}}, "overrides": []},
        "options": {
            "mapping": "manual",
            "series": [{"frame": {"matcher": {"id": "byIndex", "options": 0}},
                        "x": {"matcher": {"id": "byName", "options": "memo_latency_ms"}},
                        "y": {"matcher": {"id": "byName", "options": "rfq_id_latency_ms"}}}],
            "legend": {"showLegend": False, "displayMode": "list", "placement": "bottom"},
            "tooltip": {"mode": "single", "sort": "none"},
        },
        "targets": [target("A", q, fmt="table")],
    }


def main_row_panels(error_names):
    t_desc = ("Official RFQ txs: latency from memo t (client timestamp when the tx is signed) to block time "
              "of inclusion." + T_NOTE)
    rfq_off_desc = ("Official RFQ txs (FE / mobile, carry taker memo): latency from rfq_id (RFQ gateway timestamp "
                    "when the request was created, before quotes and user confirmation) to block time of inclusion.")
    rfq_unoff_desc = ("Unofficial RFQ txs (no taker memo: bots, atomic proxy, direct integrations): latency from "
                      "rfq_id (ms timestamp nonce) to block time of inclusion.")
    missed_desc = (" Blocks missed = [inclusion height] - (N+1), N is the latest block committed at the timestamp, "
                   "so N+1 is the earliest block the tx could have landed in. Negative: client clock ahead of chain.")
    return {
        "latency": [
            (latency_panel("RFQ Latency: Official by memo t", t_desc, OFFICIAL,
                           [("memo_latency_ms", "memo t")]), 8, 9),
            (latency_panel("RFQ Latency: Official by rfq_id", rfq_off_desc, OFFICIAL,
                           [("rfq_id_latency_ms", "rfq_id")]), 8, 9),
            (latency_panel("RFQ Latency: Unofficial by rfq_id", rfq_unoff_desc, UNOFFICIAL,
                           [("rfq_id_latency_ms", "rfq_id")]), 8, 9),
            (blocks_missed_panel("RFQ Blocks Missed: Official by memo t", t_desc + missed_desc, OFFICIAL,
                                 [("memo_blocks_missed", "memo t")]), 8, 8),
            (blocks_missed_panel("RFQ Blocks Missed: Official by rfq_id", rfq_off_desc + missed_desc, OFFICIAL,
                                 [("rfq_id_blocks_missed", "rfq_id")]), 8, 8),
            (blocks_missed_panel("RFQ Blocks Missed: Unofficial by rfq_id", rfq_unoff_desc + missed_desc,
                                 UNOFFICIAL + ' AND "rfq_id_latency_ms" < 60000',
                                 [("rfq_id_blocks_missed", "rfq_id")]), 8, 8),
            (deviation_panel(), 12, 9),
            (latency_scatter_panel(), 12, 9),
            (stale_late_by_panel(), 12, 9),
            (stale_latency_panel(), 12, 9),
        ],
        "outcomes": [
            (outcomes_panel("RFQ Tx Outcomes: Official", "Official RFQ txs by outcome / error reason.",
                            OFFICIAL, error_names), 12, 8),
            (outcomes_panel("RFQ Tx Outcomes: Unofficial", "Unofficial RFQ txs by outcome / error reason.",
                            UNOFFICIAL, error_names), 12, 8),
        ],
    }


def rfq_dashboard(error_names, templating):
    main = main_row_panels(error_names)
    stat_q = lambda sel, where="": (f'SELECT {sel} FROM "coremon_rfq_txs" WHERE {CHAIN} '
                                    f'{("AND " + where) if where else ""} AND $timeFilter')

    def stat(title, q, unit="short", desc="", thresholds=None):
        return ({
            "type": "stat",
            "title": title,
            "description": desc,
            "datasource": DS,
            "fieldConfig": {"defaults": {"unit": unit, "color": {"mode": "thresholds"},
                                         "thresholds": {"mode": "absolute", "steps": thresholds or [
                                             {"color": "green", "value": None}]}}, "overrides": []},
            "options": {"reduceOptions": {"calcs": ["lastNotNull"], "fields": "", "values": False},
                        "colorMode": "value", "graphMode": "none", "textMode": "value"},
            "targets": [target("A", q, fmt="table")],
        }, 4, 4)

    rate_thr = [{"color": "green", "value": None}, {"color": "orange", "value": 0.02}, {"color": "red", "value": 0.1}]
    lat_thr = [{"color": "green", "value": None}, {"color": "orange", "value": 2000}, {"color": "red", "value": 5000}]

    items = [
        row("RFQ Overview"),
        stat("RFQ txs", stat_q('count("count")')),
        stat("Official RFQ txs", stat_q('count("count")', OFFICIAL), desc="RFQ txs carrying taker memo (FE / mobile)."),
        stat("Official failure rate", stat_q('count("error") / count("count")', OFFICIAL), "percentunit",
             thresholds=rate_thr),
        stat("Unofficial failure rate", stat_q('count("error") / count("count")', UNOFFICIAL), "percentunit",
             thresholds=rate_thr),
        stat("Stale rejections (txs)", stat_q('count("stale")'),
             thresholds=[{"color": "green", "value": None}, {"color": "red", "value": 1}]),
        stat("Official p90 latency (memo t)", stat_q('percentile("memo_latency_ms", 90)', OFFICIAL), "ms",
             thresholds=lat_thr),
        row("Latency (official = has taker memo)"),
        *main["latency"],
        row("Staleness vs Latency Correlation"),
        (latency_vs_stale_panel(), 24, 10),
        (bucket_rate_panel("Failure Rate by Latency Bucket",
                           "Share of RFQ txs failed on chain, grouped by inclusion latency bucket (memo t for "
                           "official web txs, rfq_id otherwise).", "error"), 12, 10),
        (bucket_rate_panel("Stale Rejection Rate by Latency Bucket",
                           "Share of RFQ txs rejected as stale (quote expired / rfq_id outside window / nonce "
                           "too old / intent deadline), grouped by inclusion latency bucket.", "stale"), 12, 10),
        (bucket_count_panel("Latency Buckets: Counts", "Txs, failures and stale rejections per latency bucket."),
         12, 10),
        (histogram_panel("Blocks Missed Distribution", "Distribution of blocks missed per RFQ tx.", [
            (f'SELECT "memo_blocks_missed" FROM "coremon_rfq_txs" WHERE {CHAIN} AND {OFFICIAL} AND $timeFilter',
             "official (memo t)"),
            (f'SELECT "rfq_id_blocks_missed" FROM "coremon_rfq_txs" WHERE {CHAIN} AND {OFFICIAL} AND $timeFilter',
             "official (rfq_id)"),
            (f'SELECT "rfq_id_blocks_missed" FROM "coremon_rfq_txs" WHERE {CHAIN} AND {UNOFFICIAL} '
             f'AND "rfq_id_latency_ms" < 60000 AND $timeFilter', "unofficial (rfq_id, <60s)"),
        ], bucket_size=1), 12, 10),
        (histogram_panel("t − rfq_id Deviation Distribution (official)",
                         "Distribution of memo t minus rfq_id per tx." + T_NOTE, [
                             (f'SELECT "t_minus_rfq_id_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND {OFFICIAL} '
                              f'AND "t_minus_rfq_id_ms" > -1000000000000 AND $timeFilter', "t − rfq_id"),
                         ], unit="ms"), 12, 10),
        (histogram_panel("Stale Rejections: How Late Distribution", STALE_DESC, [
            (f'SELECT "late_by_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND "stale" = 1 AND {OFFICIAL} '
             f'AND $timeFilter', "txs official"),
            (f'SELECT "late_by_ms" FROM "coremon_rfq_txs" WHERE {CHAIN} AND "stale" = 1 AND {UNOFFICIAL} '
             f'AND $timeFilter', "txs unofficial"),
            (f'SELECT "late_by_ms" FROM "coremon_rfq_quotes" WHERE {CHAIN} AND "stale" = 1 AND $timeFilter',
             "quotes"),
        ], unit="ms"), 12, 10),
        row("RFQ Errors"),
        *main["outcomes"],
        (ts_panel("RFQ Error Classes", [target("A", (
            f'SELECT count("error") FROM "coremon_rfq_txs" WHERE {CHAIN} AND $timeFilter '
            f'GROUP BY time($Interval), "err_class", "official" fill(none)'), "$tag_err_class official=$tag_official")],
                  "Failed RFQ txs by error class. stale = rejected due to latency.", draw="bars", stack=True,
                  overrides=[{"matcher": {"id": "byRegexp", "options": "stale.*"},
                              "properties": [{"id": "color", "value": {"fixedColor": "red", "mode": "fixed"}}]}]),
         12, 8),
        (ts_panel("Quote Rejections (per quote, inside filled txs)", [target("A", (
            f'SELECT count("rejected") FROM "coremon_rfq_quotes" WHERE {CHAIN} AND $timeFilter '
            f'GROUP BY time($Interval), "err", "official" fill(none)'), "$tag_err official=$tag_official")],
                  "Quotes rejected by the RFQ contract while other quotes in the same tx could still fill "
                  "(results[].e of wasm-rfq-accept-quote).", draw="bars", stack=True), 12, 8),
        (table_panel("Failed RFQ Txs by Taker", "Top takers with failed RFQ txs.", (
            f'SELECT count("error") AS "failed" FROM "coremon_rfq_txs" WHERE {CHAIN} AND $timeFilter '
            f'GROUP BY "taker", "official", "err"'),
                     overrides=[{"matcher": {"id": "byName", "options": "err"},
                                 "properties": [{"id": "mappings", "value": err_value_mappings(error_names)}]}],
                     sort=[{"displayName": "failed", "desc": True}]), 12, 10),
        (table_panel("Recent Failed RFQ Txs", "Latest failed RFQ txs with latency.", (
            f'SELECT "height", "tx_id", "official", "source", "kind", "taker", "err", "late_by_ms", '
            f'"memo_latency_ms", "rfq_id_latency_ms", "rfq_id_blocks_missed" '
            f'FROM "coremon_rfq_txs" WHERE {CHAIN} AND "status" = \'failed\' AND $timeFilter '
            f'ORDER BY time DESC LIMIT 200'),
                     overrides=[{"matcher": {"id": "byName", "options": "err"},
                                 "properties": [{"id": "mappings", "value": err_value_mappings(error_names)}]},
                                {"matcher": {"id": "byRegexp", "options": ".*_ms"},
                                 "properties": [{"id": "unit", "value": "ms"}]}]), 12, 10),
        row("WASM Errors (all contracts)"),
        (ts_panel("WASM Failures by Contract", [target("A", (
            f'SELECT count("count") FROM "coremon_wasm_errors" WHERE {CHAIN} AND $timeFilter '
            f'GROUP BY time($Interval), "contract", "method" fill(none)'), "$tag_contract $tag_method")],
                  "Failed txs with codespace=wasm, by first executed contract and method.", draw="bars",
                  stack=True), 12, 9),
        (ts_panel("WASM Failures by Reason", [target("A", (
            f'SELECT count("count") FROM "coremon_wasm_errors" WHERE {CHAIN} AND $timeFilter '
            f'GROUP BY time($Interval), "err_tpl" fill(none)'), "$tag_err_tpl")],
                  "Innermost contract error, normalized (addresses, hex and numbers replaced).", draw="bars",
                  stack=True), 12, 9),
        (table_panel("WASM Failures: Contract × Reason", "Counts over the selected range.", (
            f'SELECT count("count") AS "failed" FROM "coremon_wasm_errors" WHERE {CHAIN} AND $timeFilter '
            f'GROUP BY "contract", "method", "rfq", "err_tpl"'),
                     sort=[{"displayName": "failed", "desc": True}]), 24, 10),
    ]

    return {
        "uid": "coremon-rfq-errors",
        "title": "Coremon: RFQ & WASM Errors",
        "tags": ["coremon", "rfq", "wasm"],
        "timezone": "utc",
        "editable": True,
        "graphTooltip": 1,
        "refresh": "1m",
        "time": {"from": "now-24h", "to": "now"},
        "schemaVersion": 41,
        "templating": {"list": templating},
        "links": [{"title": "Coremon: Mainnet", "type": "link", "url": "/d/bdzlj2m9m3a4ga/coremon3a-mainnet",
                   "icon": "dashboard", "targetBlank": False}],
        "panels": layout(items),
    }


def main():
    error_names = load_error_names()

    templating = [
        {"name": "Interval", "type": "interval", "auto": False, "query": "30s,2m,5m,10m,30m,1h,6h",
         "current": {"text": "5m", "value": "5m"}, "refresh": 2,
         "options": [{"selected": v == "5m", "text": v, "value": v}
                     for v in ["30s", "2m", "5m", "10m", "30m", "1h", "6h"]]},
        {"name": "ChainID", "type": "query", "datasource": DS,
         "definition": "show tag values from coremon_block_report with key=chain_id;",
         "query": {"query": "show tag values from coremon_block_report with key=chain_id;", "refId": "A"},
         "current": {"text": "injective-1", "value": "injective-1"}, "includeAll": False, "refresh": 1},
    ]

    with open(os.path.join(HERE, "coremon_rfq.gen.json"), "w") as f:
        json.dump(rfq_dashboard(error_names, templating), f, indent=2)
        f.write("\n")

    main = main_row_panels(error_names)
    row_items = [row("RFQ")] + main["latency"] + main["outcomes"]
    with open(os.path.join(HERE, "coremon_rfq_row.gen.json"), "w") as f:
        json.dump(layout(row_items), f, indent=2)
        f.write("\n")


if __name__ == "__main__":
    main()
