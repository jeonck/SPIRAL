# Cycle 009 — T3 Investigate: `ioc-extraction-reliability`

## Task performed

T3 (Investigate) against `ioc-extraction-reliability`, per `state/queue/next_task.json`
written by cycle 8. The queue's primary directive was explicit: do not re-read src-0003,
because single-source support is the only thing capping this issue at 2, and only an
independent second source can move it. Cycle 6 had already searched for a LANCE/PRISM
replication and found none, so the instruction was to widen the search rather than
repeat it.

**Outcome: the widened search succeeded.** Two new sources added, one of them a direct
independent measurement of the issue's core quantity, and one contradiction opened.

### What was searched (recorded so a later cycle can see the net was genuinely widened)

Queries run via web search (all 2026-current):

1. `independent evaluation LLM indicator of compromise extraction threat reports F1
   manually validated ground truth 2026`
2. `"IoC extraction" LLM evaluation 2026 benchmark precision recall independent study
   "threat reports" not LANCE`
3. `"Enhanced-LLM extraction of CTI from unstructured threat reports" "tough nut to
   crack"` (chasing a specific hit from query 1)

Pages fetched: `arxiv.org/abs/2603.09452`, `arxiv.org/html/2603.09452v1` (three separate
fetches with different extraction prompts), `arxiv.org/html/2605.06910`,
`arxiv.org/abs/2605.06910`, `arxiv.org/abs/2509.20166` (G2).

Direction (b) from the queue instructions — a citation-graph sweep of papers citing
arXiv 2506.11325 — was **attempted and failed**: `semanticscholar.org/arxiv/2506.11325`
returns HTTP 404 and no alternative citation-graph endpoint was tried. Direction (c)
(third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines
themselves) was **not reached** — the cycle's budget went to (a), which paid off first.
Both remain available to a future cycle. Recording this rather than implying full
coverage.

Dead end worth recording: `Enhanced-LLM extraction of CTI from unstructured threat
reports. A tough nut to crack or a walk in the park?` (ScienceDirect
S0167739X26001482, eLLM-CTI, a RAG-enhanced GPT-OSS:20B pipeline emitting STIX 2.1)
looks directly relevant but is paywalled — the publisher returns HTTP 403 to fetch. No
preprint was located. It is a live candidate for a future cycle with a different access
route; it was NOT added, since a source cannot be entered on the strength of a search
snippet.

### Findings

**src-0007 — CyberThreat-Eval (arXiv 2603.09452, Mar 2026, Microsoft Research /
Microsoft / HKUST).** An expert-annotated benchmark built from the daily CTI workflow of
an unnamed "world-leading company", covering the triage → deep search → TI drafting
pipeline. Its Table 4 reports **IoC extraction precision 0.8240 (GPT-4o), 0.8503
(o3-mini), 0.8846 (GPT-4o fine-tuned), 0.6944 (GPT-4o-mini fine-tuned)** over 1310 IoCs.
This is the first non-src-0003 numeric measurement of LLM IoC extraction against
human-expert ground truth in the knowledge base. The authors are unaffiliated with
PRISM/LANCE's team and the paper does not cite arXiv 2506.11325 — independence is
incidental rather than adversarial, which is the more useful kind.

Per the cycle-8 whole-row rule, Table 4 was pulled **in full and verbatim across all
four model columns** rather than accepting a summarised answer, and the IoC row was
cross-checked against the body-text sentence "LLMs demonstrate strong precision (around
0.82-0.85)", which agrees. The abstract was captured from two independent fetches
(/abs and /html) and matched word-for-word.

**src-0008 — IoC Recovery under Adversarial Code Obfuscation and Encryption (arXiv
2605.06910, May 2026, Universidad Carlos III de Madrid).** Added opportunistically and
scoped tightly in its own source file: it measures recovery of a planted indicator from
obfuscated JavaScript, NOT extraction from narrative reports, so it is explicitly not a
replication of src-0003. Its value is as a boundary condition (~100% detection on
plaintext, ~0-1% under XOR/AES-256) and as the knowledge base's first evidence on
adversary-side evasion of LLM extraction — a threat model no other source covers. Its
per-level percentages were read from tables by the fetcher and are flagged as
approximate pending a verbatim pull; this limitation is written into the source file so
a later cycle cannot cite them as verified.

### The judgement call, stated plainly

src-0007 does **not** replicate LANCE and does not refute it. It measures a different
system (vanilla LLM vs regex + LLM + human validation), on a different corpus, with a
different metric (precision only — no recall or F1 anywhere for this task, with no
reason given). But it does put an independently-measured number on the same underlying
question, and that number — a bare LLM erring on roughly 1 in 6 indicators it emits —
sits below even the 86% VirusTotal baseline that src-0003 presents as the tool to beat.
A reader of src-0003 alone and a reader of src-0007 alone come away with opposite
impressions of whether mechanical IoC extraction is solved.

Per G3 that is a conflict to record, not to adjudicate, so **ctr-0001** was opened. It
names all three confounds (system / metric / corpus) and states a resolution path,
including the explicit possibility that the contradiction dissolves on inspection — if
the scaffolding explanation is confirmed, ctr-0001 should be closed and folded into the
issue's new third candidate_resolution rather than left open. I did not pre-judge which
way it goes.

## Retrospection

**Target: src-0005 (CyberSOCEval, arXiv 2509.20166)** — selected per the queue's note
that it is the only source never re-verified (src-0004 c4, src-0003 c5, src-0002 c6,
src-0001 c7, src-0006 c8).

Re-fetched `https://arxiv.org/abs/2509.20166`. **Result: PASS on substance.** Confirmed
live:

- Title and full 23-author list, including the senior authors recorded in src-0005.md —
  Sven Krasser (CrowdStrike) and Joshua Saxe (Meta). The affiliation claim underpinning
  the source file's industry-affiliation caveat holds.
- Key claim 1 — larger, more modern LLMs perform better: confirmed ("larger, modern LLMs
  perform better").
- Key claim 2 — reasoning models do not get the coding/math boost here: confirmed
  ("reasoning models show diminished benefits compared to coding tasks").
- Key claim 3 — benchmark unsaturated: confirmed ("The benchmark remains unsaturated,
  indicating significant improvement opportunities").

**Honest caveat, per the methodological rule cycle 8 learned.** The fetch was asked for
the abstract *verbatim* and returned a paraphrase instead. So the three exact quoted
strings in src-0005.md — "confirming the training scaling laws paradigm", "reasoning
models leveraging test time scaling do not achieve the same boost as in coding and
math", "Current LLMs are far from saturating our evaluations" — were **not** re-confirmed
word-for-word this cycle. The substance of all three claims was confirmed; the exact
wording was not. That is a weaker pass than cycle 8's on src-0006, and I am recording it
as such rather than rounding up. No contradiction opened: a paraphrase that agrees in
substance is not grounds for one, just as cycle 8 correctly declined to open a spurious
contradiction on a summariser's answer.

src-0005.md's own recorded limitation — that no per-model numeric scores were ever
captured — still stands and was not addressed this cycle. That matters because src-0005
is one of the two sources holding `ttp-attack-mapping-reliability` at 3.

## Changes made

- **NEW** `state/knowledge/src-0007.md` — CyberThreat-Eval. 4 key claims, verbatim
  abstract, verbatim Table 4 rows, 5 recorded limitations.
- **NEW** `state/knowledge/src-0008.md` — IoC recovery under obfuscation/encryption.
  3 key claims (one of which is an explicit scope limit), verbatim abstract,
  4 recorded limitations.
- `state/knowledge/index.json` — added src-0007 and src-0008 entries. Existing entries
  untouched (append-only respected).
- `state/issues/graph.json`, issue `ioc-extraction-reliability`:
  - Added 2 candidate_resolutions (one `supported` on src-0007; one deliberately
    `proposed` scaffolding-vs-model synthesis on src-0003+0007+0008). The original
    src-0003 candidate is left exactly as it was.
  - Rewrote open_questions: 5 now, up from 3. Q0 sharpened from "has anyone replicated
    LANCE" to the head-to-head question that is actually live; Q1 and Q2 annotated with
    what cycle 9 did and did not settle; two genuinely new questions added (recoverable
    recall/F1 from src-0007's released code; adversarial threat model for report-based
    extraction).
  - `attempts` → `[9]`.
- `state/issues/graph.json` — **first contradiction entry, ctr-0001**, src-0003 vs
  src-0007 magnitude conflict, with confounds and resolution path.

**Deviation from instructions, flagged:** the queue said to append `8` to `attempts`.
I appended `9`. The queue entry was authored during cycle 8 and predicted its own
successor's number; the T3 prompt says to append *this* cycle's number, and the existing
convention in the graph agrees (`consistency-calibration` has `[3]` from cycle 3,
`task-dependent-reliability-framing` has `[6]` from cycle 6). Appending 8 would have
recorded work as done by a cycle that did not do it.

## Carry-forward items (preserve these — they will otherwise be lost)

1. **SPLIT `task-dependent-reliability-framing`** (carried from cycle 7's assessment and
   cycle 8's T5; T3 and T5 have no standing to restructure the graph, a T2 does). Its
   single score of 3 averages two claims of very different strength: the NARROW claim
   (CTI reliability varies by sub-task), independently supported by src-0001, src-0002
   and src-0006 and meriting 3, versus the SPECIFIC ordinal axis "mechanical extraction
   < classification < attribution < generation", which is in doubt — cycle 8's G2 pass
   re-confirmed live that src-0006's Table 5 marks its failure subtypes as spanning all
   four pipeline stages (e.g. "Co-mention bias (Type 1.1) — stages 1234") — and would
   score 1 on its own.
2. **NEW this cycle, and it bears directly on item 1:** src-0007 is a fourth
   within-study demonstration of task-dependence, and unlike src-0006 it *cuts in favour
   of* the ordinal axis rather than against it. Same team, same corpus, same four models,
   same table: IoC extraction precision 0.82-0.88 vs MITRE ATT&CK TTP identification
   precision 0.2787 / recall 0.2270 (GPT-4o). Extraction cleanly beats mapping. That is
   evidence a future cycle must weigh against src-0006's cross-stage finding — the two
   are not obviously reconcilable, and whichever cycle takes up the split should look at
   both rather than inheriting cycle 8's one-sided reading.
3. **src-0007 is also unclaimed evidence for `ttp-attack-mapping-reliability`**, which
   currently rests on src-0002 + src-0005 at score 3. Its TTP numbers (P 0.2787 /
   R 0.2270 on real production CTI material) are far below CTIBench's 0.64 F1 ceiling.
   This is not a contradiction — different benchmarks over different corpora can both be
   right, and real-world material being harder than a curated benchmark is the expected
   direction — but it is a third independent source for that issue and nobody has
   attached it yet. T3 scope kept me from editing that issue this cycle.
4. **src-0007's triage finding is uncovered by any issue**: recall (Accepted) 0.90-1.00
   against precision (Accepted) 0.27-0.40 across all four models means an
   LLM-automated triage stage passes through roughly two of every three items a human
   analyst would reject. No current issue covers alert/report triage as a CTI sub-task.
   Possible new issue for a T2.
5. **The G2/G3 gate is specified two different ways and cycle 9 is the first cycle to
   hit it.** `prompts/t4_assess.md` step 3 says an issue with an open contradiction
   "loses `gates.g3_contradiction_demotion` points (floor 0)" — a subtraction, so 3 → 1.
   `scripts/validate_state.py` (lines 144-156) implements a **ceiling** instead: it errors
   only if such an issue scores above `scale_max - demotion`, i.e. above 3. The two agree
   on nothing except that 5 and 4 are forbidden. This never mattered before because the
   contradictions array was empty; ctr-0001 makes it live. I checked the code rather than
   assuming, and I have written the discrepancy into the T4 queue entry so the next cycle
   does not silently pick one. Reconciling the prompt and the validator is out of scope
   for T3 and for T4 — it is a change to the system's own rules, not to the research
   state.
6. **Two unfinished search directions from this cycle's own instructions**: the
   citation-graph sweep of arXiv 2506.11325 (Semantic Scholar returned 404; try
   Google Scholar, arXiv listing pages, or Connected Papers) and third-party evaluation
   of the IoC Searcher / AlienVault OTX / VirusTotal baselines. Also the paywalled
   eLLM-CTI paper (ScienceDirect S0167739X26001482).

## Next task rationale

T3 → T4 per the state machine. T4 assesses every issue, and this cycle changed the
evidence base under two of them plus opened the graph's first contradiction, so a
re-score is exactly what should happen next.

The T4 cycle faces a genuinely non-obvious call and I have written it into the queue
instructions rather than leaving it to be discovered: `ioc-extraction-reliability` now
has two independent sources, which is the rubric's bar for 3 — but `ctr-0001` is open,
and `gates.g3_contradiction_demotion` is 2, which would take it to 1. A mechanical
application gives 1; the issue is better evidenced than it was at 2, not worse. That
tension is real and T4 must resolve it explicitly and stingily rather than quietly
picking whichever number looks nicer. I have deliberately not pre-judged it here — T4
owns scoring, and the honest answer may well be that opening a contradiction *should*
cost the issue points until someone does the head-to-head work.

## Budget

- Web searches: 3
- Page fetches: 6 (3× arXiv 2603.09452 with different extraction prompts, 2× 2605.06910,
  1× 2509.20166 for G2), plus 2 failed (ScienceDirect 403, Semantic Scholar 404)
- Assistant turns: ~10
- Files written: 3 new (src-0007.md, src-0008.md, this log), 3 edited (index.json,
  graph.json ×2 regions), plus queue files
- Shell: 1 successful (directory listing); JSON validation via `python3`/`curl` was
  blocked by the sandbox, so schema validity was checked by reading back the edited
  regions instead. Noting this because it is a weaker check than a parse.
