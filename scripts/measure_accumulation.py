#!/usr/bin/env python3
"""Per-cycle error-accumulation and growth metrics from git history (RQ2).

Walks every commit that changed state/meta.json, reconstructs the state at that
commit, and measures:
  cycle, task, n_sources, n_issues, score_min, score_mean,
  open_contradictions, dangling_evidence_refs, citation_validity_rate*

*citation_validity_rate re-checks every source URL at measurement time (set
 SPIRAL_SKIP_URL_CHECK=1 to skip; then column is empty). Checking at measurement
 time (not collection time) is intentional: it captures link rot AND fabrication.

Usage: python scripts/measure_accumulation.py [-o eval/metrics.csv]
"""
import argparse
import csv
import json
import os
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def git(*a: str) -> str:
    return subprocess.run(["git", *a], capture_output=True, text=True, cwd=ROOT).stdout


def show(ref: str, path: str):
    r = subprocess.run(["git", "show", f"{ref}:{path}"], capture_output=True, text=True, cwd=ROOT)
    return json.loads(r.stdout) if r.returncode == 0 and r.stdout.strip() else None


def url_alive(url: str) -> bool:
    import requests
    try:
        r = requests.head(url, timeout=15, allow_redirects=True,
                          headers={"User-Agent": "Mozilla/5.0 (spiral-eval)"})
        if r.status_code < 400:
            return True
        r = requests.get(url, timeout=15, allow_redirects=True, stream=True,
                         headers={"User-Agent": "Mozilla/5.0 (spiral-eval)"})
        return r.status_code < 400
    except requests.RequestException:
        return False


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", "--out", default="eval/metrics.csv")
    args = ap.parse_args()

    shas = git("log", "--reverse", "--format=%H", "--", "state/meta.json").split()
    skip_urls = os.environ.get("SPIRAL_SKIP_URL_CHECK") == "1"
    url_cache: dict[str, bool] = {}
    rows = []

    for sha in shas:
        meta = show(sha, "state/meta.json")
        if not meta:
            continue
        index = show(sha, "state/knowledge/index.json") or {"sources": []}
        graph = show(sha, "state/issues/graph.json") or {"issues": [], "contradictions": []}
        scores = (show(sha, "state/assessments/scores.json") or {}).get("scores", {})

        known = {s["id"] for s in index["sources"]}
        dangling = 0
        for iss in graph["issues"]:
            for c in iss.get("candidate_resolutions", []):
                dangling += sum(1 for e in c.get("evidence", []) if e not in known)
        for entry in scores.values():
            dangling += sum(1 for e in entry.get("evidence", []) if e not in known)

        vals = [v.get("score") for v in scores.values() if isinstance(v.get("score"), (int, float))]
        open_contra = sum(1 for c in graph.get("contradictions", []) if c.get("resolved_cycle") is None)

        validity = ""
        if not skip_urls and index["sources"]:
            ok = 0
            for s in index["sources"]:
                u = s.get("url", "")
                if u not in url_cache:
                    url_cache[u] = url_alive(u)
                ok += url_cache[u]
            validity = round(ok / len(index["sources"]), 3)

        subject = git("log", "-1", "--format=%s", sha).strip()
        rows.append({
            "cycle": meta.get("cycle"),
            "commit": sha[:8],
            "task": subject[:40],
            "n_sources": len(index["sources"]),
            "n_issues": len(graph["issues"]),
            "score_min": min(vals) if vals else "",
            "score_mean": round(sum(vals) / len(vals), 2) if vals else "",
            "open_contradictions": open_contra,
            "dangling_refs": dangling,
            "citation_validity_rate": validity,
        })

    out = ROOT / args.out
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()) if rows else ["cycle"])
        w.writeheader()
        w.writerows(rows)

    for r in rows:
        print(r)
    print(f"\nwrote {out} ({len(rows)} cycle snapshots)")


if __name__ == "__main__":
    main()
