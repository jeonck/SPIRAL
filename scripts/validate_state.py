#!/usr/bin/env python3
"""SPIRAL verification gates — mechanical checks run after every agent cycle.

Exit 0 = state accepted. Exit 1 = state rejected (orchestrator reverts).
Checks:
  S. Schema/consistency: JSON parses; queue points to a valid task; cycle log exists.
  G1. Source gate: every source has a URL that resolves (< 400); knowledge is
      append-only (no source removed, no key_claims removed); evidence ids referenced
      by issues/assessments exist in the knowledge index.
  G3. Contradiction gate: issues with open contradictions are not scored above the
      demotion ceiling implied by config.
"""
import json
import os
import subprocess
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
ERRORS: list[str] = []


def err(msg: str) -> None:
    ERRORS.append(msg)


def load_json(path: str):
    try:
        return json.loads((ROOT / path).read_text())
    except Exception as e:  # noqa: BLE001
        err(f"[schema] {path}: {e}")
        return None


def git_show(path: str):
    """Previous committed version of a file, or None if new/unavailable."""
    pre_sha_file = Path("/tmp/spiral_pre_sha")
    ref = pre_sha_file.read_text().strip() if pre_sha_file.exists() else "HEAD"
    r = subprocess.run(
        ["git", "show", f"{ref}:{path}"], capture_output=True, text=True, cwd=ROOT
    )
    return r.stdout if r.returncode == 0 else None


def url_alive(url: str, timeout: int) -> bool:
    import requests

    headers = {"User-Agent": "Mozilla/5.0 (spiral-validator)"}
    for method in ("head", "get"):
        try:
            resp = getattr(requests, method)(
                url, timeout=timeout, allow_redirects=True, headers=headers,
                **({"stream": True} if method == "get" else {}),
            )
            if resp.status_code < 400:
                return True
            if method == "get":
                return False
        except requests.RequestException:
            if method == "get":
                return False
    return False


def main() -> int:
    cfg = yaml.safe_load((ROOT / "config.yml").read_text())

    meta = load_json("state/meta.json")
    index = load_json("state/knowledge/index.json")
    graph = load_json("state/issues/graph.json")
    scores = load_json("state/assessments/scores.json")
    queue = load_json("state/queue/next_task.json")
    if any(x is None for x in (meta, index, graph, scores, queue)):
        return report()

    cycle = meta["cycle"]

    # --- S: queue sanity -----------------------------------------------------
    if queue.get("task_type") not in {"T1", "T2", "T3", "T4", "T5"}:
        err(f"[S] queue task_type invalid: {queue.get('task_type')}")
    issue_ids = {i["id"] for i in graph.get("issues", [])}
    if queue.get("target_issue") and queue["target_issue"] not in issue_ids:
        err(f"[S] queue target_issue '{queue['target_issue']}' not in issue graph")

    # --- S: cycle log exists -------------------------------------------------
    log_path = ROOT / "logs" / f"cycle-{cycle:03d}.md"
    if not log_path.exists():
        err(f"[S] missing cycle log {log_path.name}")
    elif "## Retrospection" not in log_path.read_text():
        err("[S/G2] cycle log lacks '## Retrospection' section")

    # --- G1: append-only knowledge -------------------------------------------
    prev_raw = git_show("state/knowledge/index.json")
    if prev_raw:
        try:
            prev_index = json.loads(prev_raw)
            prev = {s["id"]: s for s in prev_index.get("sources", [])}
            cur = {s["id"]: s for s in index.get("sources", [])}
            for sid, psrc in prev.items():
                if sid not in cur:
                    err(f"[G1] source {sid} was removed (append-only violation)")
                    continue
                missing = set(psrc.get("key_claims", [])) - set(cur[sid].get("key_claims", []))
                if missing:
                    err(f"[G1] source {sid}: key_claims removed: {missing}")
        except Exception as e:  # noqa: BLE001
            err(f"[G1] could not compare with previous index: {e}")

    # --- G1: source files + URL liveness (new sources only) ------------------
    prev_ids = set()
    if prev_raw:
        try:
            prev_ids = {s["id"] for s in json.loads(prev_raw).get("sources", [])}
        except Exception:  # noqa: BLE001
            pass
    known_ids = set()
    for src in index.get("sources", []):
        known_ids.add(src["id"])
        f = src.get("file", "")
        if not (ROOT / f).exists():
            err(f"[G1] source {src['id']}: file {f} does not exist")
        skip_urls = os.environ.get("SPIRAL_SKIP_URL_CHECK") == "1"
        if cfg["gates"]["g1_check_urls"] and not skip_urls and src["id"] not in prev_ids:
            if not url_alive(src.get("url", ""), cfg["gates"]["g1_url_timeout_sec"]):
                err(f"[G1] source {src['id']}: URL did not resolve: {src.get('url')}")

    # --- G1: dangling evidence references -------------------------------------
    for issue in graph.get("issues", []):
        for cand in issue.get("candidate_resolutions", []):
            for ev in cand.get("evidence", []):
                if ev not in known_ids:
                    err(f"[G1] issue {issue['id']}: evidence '{ev}' not in knowledge index")
    for iid, entry in scores.get("scores", {}).items():
        if iid not in issue_ids:
            err(f"[S] assessment for unknown issue '{iid}'")
        if entry.get("score", 0) >= 2 and not entry.get("evidence"):
            err(f"[G1] issue {iid}: score >=2 requires evidence citations")
        for ev in entry.get("evidence", []):
            if ev not in known_ids:
                err(f"[G1] assessment {iid}: evidence '{ev}' not in knowledge index")

    # --- G3: contradiction demotion ceiling -----------------------------------
    demotion = cfg["gates"]["g3_contradiction_demotion"]
    open_contra = {
        c["issue_id"] for c in graph.get("contradictions", [])
        if c.get("resolved_cycle") is None
    }
    for iid in open_contra:
        entry = scores.get("scores", {}).get(iid)
        if entry and entry.get("score", 0) > cfg["scoring"]["scale_max"] - demotion:
            err(
                f"[G3] issue {iid} has an open contradiction but score "
                f"{entry['score']} > ceiling {cfg['scoring']['scale_max'] - demotion}"
            )

    return report()


def report() -> int:
    if ERRORS:
        print("VALIDATION ERRORS:")
        for e in ERRORS:
            print(f"  - {e}")
        return 1
    print("validation OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
