#!/usr/bin/env python3
"""LLM-judge rubric scoring of a research report (RQ1).

Blind protocol: pass reports through export_report.py --blind (or strip headers of
baseline reports) BEFORE judging. Run with different --model values to get
independent judges from different model families where available.

Usage:
  python scripts/rubric_score.py eval/report.md [--label spiral] [--model MODEL]
                                 [--judge-cmd claude] [--dry-run]
Output: eval/scores/<label>.<model>.json
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

JUDGE_INSTRUCTIONS = """You are an evaluation judge. Score the research report below \
against the rubric, exactly as the rubric specifies. You do not know which system \
produced the report; do not speculate. Return ONLY a JSON object of the form:
{"D1": {"score": <0-10>, "rationale": "..."},
 "D2": {...}, "D3": {...}, "D4": {...}, "D5": {...},
 "aggregate": <unweighted mean, one decimal>,
 "notable_quotes": ["passage cited for extreme scores", ...]}
"""


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("report")
    ap.add_argument("--label", default="report")
    ap.add_argument("--model", default="")
    ap.add_argument("--judge-cmd", default="claude")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    rubric = (ROOT / "eval/rubric.md").read_text()
    report = Path(args.report).read_text()

    prompt = (
        f"{JUDGE_INSTRUCTIONS}\n\n=== RUBRIC ===\n{rubric}\n\n"
        f"=== REPORT (blinded) ===\n{report}\n=== END REPORT ==="
    )

    if args.dry_run:
        print(prompt[:2000])
        print(f"\n[dry-run] prompt length: {len(prompt)} chars")
        return

    cmd = [args.judge_cmd, "-p", prompt, "--output-format", "text"]
    if args.model:
        cmd += ["--model", args.model]
    out = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    if out.returncode != 0:
        sys.exit(f"judge failed: {out.stderr[:500]}")

    m = re.search(r"\{.*\}", out.stdout, re.DOTALL)
    if not m:
        sys.exit(f"no JSON in judge output: {out.stdout[:500]}")
    scores = json.loads(m.group(0))

    dest = ROOT / "eval/scores"
    dest.mkdir(parents=True, exist_ok=True)
    name = f"{args.label}.{args.model or 'default'}.json"
    (dest / name).write_text(json.dumps(scores, indent=2, ensure_ascii=False))
    print(f"wrote eval/scores/{name} — aggregate {scores.get('aggregate')}")


if __name__ == "__main__":
    main()
