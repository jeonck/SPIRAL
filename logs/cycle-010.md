# Cycle 010 — T4 Assess

## Task performed

T4 (Assess) per `prompts/t4_assess.md` and the queue entry written by cycle 9. All six
issues in `state/issues/graph.json` were re-scored and `assessed_cycle` set to 10 on
every entry; `last_assessed_cycle` → 10.

### Scores

| issue | c7 | c10 | movement |
|---|---|---|---|
| `ttp-attack-mapping-reliability` | 3 | **3** | held; gained an unattached third source |
| `ioc-extraction-reliability` | 2 | **2** | held; g3 gate fired for the first time |
| `consistency-calibration-as-failure-mode` | 2 | **2** | held |
| `attribution-confident-wrong-gap` | 3 | **3** | held |
| `task-dependent-reliability-framing` | 3 | **3** | held; both halves moved, in opposite directions |
| `institutional-incident-real-world-impact` | 2 | **2** | held |

No score moved. That is the honest outcome and I am not dressing it up: cycle 9 added
two real sources, and neither of them changed a score, because in every case the new
evidence either attaches to a different candidate than the one carrying the issue, or
has not been attached to the graph at all, or strengthens one half of a bundled issue
while sharpening the dispute in the other half.

### The g3 call on `ioc-extraction-reliability`, stated so the arithmetic is auditable

This is the first time the contradiction gate has ever fired in this project.

- **Pre-demotion score on the merits: 2.**
- **Post-demotion score: 2.**
- Under the *subtraction* reading it would be 0 (from 2) or 1 (from 3). Under the
  *ceiling* reading it is 2, unchanged.

**Which reading I applied: the CEILING** (`validate_state.py` lines 144-156: error only
if score > `scale_max - demotion` = 3), not the subtraction described in
`prompts/t4_assess.md` step 3. I knew they differ before I did the arithmetic — cycle 9
checked the code and wrote the discrepancy into my queue entry — and the reason I chose
the ceiling is not simply that it is what the validator enforces. The rubric's levels
are *definitions of states*, not points on an arithmetic scale: level 0 means "no
candidate resolutions", level 1 means "no supported resolution". This issue has three
candidate_resolutions, two with status `supported`. A subtraction that lands on 0 or 1
assigns a label that is flatly false of the issue, and the weakest-link selector reads
these numbers. The ceiling achieves what the gate is for — an open conflict blocks the
top of the scale — without corrupting the bottom of it.

**Where I departed from the framing I was handed.** Cycle 9's queue entry asserted that
the issue "now has genuinely 2 independent sources, which is the rubric's stated bar for
3". I do not accept that the pre-demotion score is 3. The rubric's bar is that the
*primary candidate* be supported by ≥2 independent sources, not that the issue
accumulate 2 sources. Per candidate: candidate 1 (LANCE 97.6% F1) = `[src-0003]` alone;
candidate 2 (vanilla-LLM precision 0.8240/0.8503/0.8846/0.6944) = `[src-0007]` alone;
candidate 3 (scaffolding-not-the-model) is the only multi-source one and cycle 9
deliberately set it `proposed`. Two single-source candidates plus a proposed synthesis
is the textbook shape of a 2.

The formal point and the substantive point coincide here, which is why I trust it:
src-0003 and src-0007 do not jointly support one claim, they pull in opposite directions
on magnitude — a bare LLM at 0.82-0.88 precision lands at or below the 86%
VirusTotal@threshold=1 baseline that src-0003 presents as the tool LANCE beats. Sources
that leave a reader with opposite impressions are not corroboration. That is what
ctr-0001 is for.

I also declined to score *below* 2. ctr-0001's own text names three confounds (SYSTEM /
METRIC / CORPUS) and states that if the SYSTEM confound is confirmed the contradiction
should be closed and folded into candidate 3. The honest position is that this issue is
simultaneously better evidenced than at cycle 4 and less settled, and 2 says so.

**Consequence for the agenda, flagged because it is not just a number.** Under the
subtraction reading this issue would now be the graph's unique weakest link at 1 and
would monopolise T5's selection. Under the ceiling reading it sits in a three-way tie at
2, carrying an attempt penalty (`attempts: [9]`, within the last 5 cycles). The gate
reading therefore changes what the system researches next. Reconciling the prompt and
the validator is a change to the system's own rules; T4 has no standing to make it, and
it is carried forward below for the second cycle running.

### `task-dependent-reliability-framing`: considered moving it both ways, held at 3

src-0007 is a fourth *within-study* demonstration of the narrow claim (same team, corpus
and four models: IoC extraction 0.82-0.88 precision vs TTP identification 0.2787/0.2270
for GPT-4o). Crucially it cuts **in favour of** the ordinal axis that cycles 7 and 8
recorded as being in doubt on the strength of src-0006. I did not inherit that one-sided
reading — it is no longer tenable.

But the axis did not get more *settled*, it got more **contested**: src-0007's Table 4
supports it, src-0006's Table 5 opposes it by marking failure subtypes as spanning all
four pipeline stages ("Co-mention bias (Type 1.1) — stages 1234", re-confirmed live by
cycle 8's G2).

**I explicitly declined to open a contradiction entry for that tension**, and the reason
matters: src-0006's claim is about where failure *mechanisms* occur; src-0007's is about
where performance *levels* differ. The same mechanism can operate at every stage while
its impact is far larger on mapping than on extraction. Both can be true. Cycle 8 nearly
opened a spurious contradiction off a summariser's paraphrase; manufacturing one from an
apparent tension between compatible claims would be the same error in a different dress.

Net: narrow claim ≈ 4-source footing, distinguishing axis now actively disputed rather
than merely doubted, one score still averaging both. Scored on the axis alone, 1-2;
on the narrow claim alone, 3. Resultant 3.

## Retrospection

**Target: src-0008** (arXiv 2605.06910, IoC recovery under obfuscation/encryption),
chosen per the queue entry over src-0007 because src-0008's own source file flags its
per-level percentages as **approximate** — read from tables by cycle 9's automated
fetcher and never checked row-by-row. Those figures are cited by
`ioc-extraction-reliability`'s third candidate_resolution, so this was a real
verification rather than a formality. Per the standing methodological rule I asked for
**entire tables verbatim, all columns**, and refused summarised confirm/deny answers.

Two fetches of `arxiv.org/html/2605.06910` (and `/html/2605.06910v1`).

**Result: PASS on substance, with one figure upgraded to verified, one still unverified,
and one transcription discrepancy found.**

1. **Hallucination rates — VERIFIED EXACTLY.** Table 7 came back verbatim: Anthropic
   0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0, Cohere 0. This matches src-0008.md's key
   claim 3 cell for cell. The "approximate" caveat can be lifted for these five numbers.
2. **The ~100% plaintext / ~0-1% encrypted dichotomy — CONFIRMED IN SUBSTANCE, NOT AS A
   PRINTED NUMBER.** The per-phase breakdown turns out **not to exist as a table at
   all** — it is Figure 2, a set of pie charts ("Green sections indicate successful
   detections, red sections indicate missed detections, and yellow sections indicate
   explicit 'Don't Know' responses"). So no verbatim row pull is possible for it, which
   is itself worth recording: the figure cycle 9 stored as approximate is not merely
   unchecked, it is *uncheckable by table pull*. Body text confirms the substance
   verbatim: "all evaluated LLMs achieve 100% detection when the IoC appears in plain
   text"; "ChatGPT, Claude, Gemini and Grok achieve 100% across all four phases without
   reporting uncertainties"; at XOR "positive detections virtually disappear"; "once the
   code is encrypted, detection of IoCs remains essentially zero for all models"; and
   ">95% misses for most". Note that the paper's own wording is *virtually disappear /
   essentially zero / >95% misses* — it never prints "0-1%". src-0008.md's "~0-1%" is a
   defensible reading but is the fetcher's number, not the authors'.
3. **An independent arithmetic cross-check I derived, which raises confidence anyway.**
   Table 6 (pulled verbatim) gives overall detection rate across *all* phases: Anthropic
   38.5%, ChatGPT 38.6%, Gemini 38.5%, Grok 35%, Cohere 22.8%, over ~4,358 queries each.
   The benchmark has 13 phases (P0-P12; 336 programs × 13 = 4,368 ≈ the query counts).
   If detection were 100% at P0-P4 and ~0% at P5-P12, the overall rate would be
   5/13 = **38.46%** — which is what three of the five models report, to the decimal.
   That is a genuine consistency check on the dichotomy from a table I did pull
   verbatim, and it is stronger evidence than the pie charts.
4. **Discrepancy found, recorded, not silently corrected.** src-0008.md's key claim 2
   says "at P5-P6 (XOR and AES-256)". The body text I pulled says "Both XOR (P5, P6) and
   AES-256 (P7, P8)" — i.e. AES-256 is at P7-P8, and cycle 9's phase labelling is off.
   This does not touch the substance (encryption collapses detection either way) and I
   did **not** open a contradiction: G3 covers two supported claims in conflict, not a
   phase-label transcription slip inside one source, and I cannot cleanly adjudicate it
   because *both* readings are automated fetches of the same HTML (mine returned "¿95%"
   for ">95%", so its rendering is demonstrably imperfect too). Append-only discipline
   also forbids me editing the existing key claim. Flagged as carry-forward: needs a
   PDF-level check by whichever cycle next cites src-0008's phase structure.

**Bonus observation, logged and deliberately not scored on.** Table 6's `#DK` column:
Cohere 625 "Don't Know" responses, Anthropic 94, ChatGPT 37, Gemini 0, Grok 0. The model
that *never* abstains (Gemini) is also the one with by far the highest hallucination rate
(4.8%). That is the overconfidence phenomenon `consistency-calibration-as-failure-mode`
is about — but measured on JavaScript source code, unattached to any candidate, and one
correlation across five vendors is not a mechanism. It goes in the rationale as a T2/T3
candidate, not as a second source.

## Changes made

- `state/assessments/scores.json` — all six entries re-scored with rewritten rationales
  (none inherited verbatim), `assessed_cycle: 10` on every entry, `last_assessed_cycle`
  → 10. Every rationale cites source ids; all scores ≥2 carry evidence arrays.
- `state/issues/graph.json` — **unchanged**. Two tensions were examined and both were
  deliberately *not* recorded as contradictions (src-0006 vs src-0007 on the ordinal
  axis; src-0008's phase labelling), with reasons given above.
- `state/knowledge/` — **unchanged** (append-only respected; the G2 finding about
  src-0008's phase labels is recorded here rather than by editing the source file).
- `logs/cycle-010.md` (this file), `state/queue/next_task.json`,
  `state/queue/last_completed_task.txt`.

## Carry-forward items (preserve all of these)

1. **SPLIT `task-dependent-reliability-framing`** into the NARROW claim (CTI reliability
   varies by sub-task — src-0001, src-0002, src-0006, src-0007; merits 3) and the
   SPECIFIC ORDINAL AXIS (mechanical extraction < classification < attribution <
   generation — now *disputed*, src-0007's Table 4 for, src-0006's Table 5 against;
   merits 1-2 alone). **Carried from cycles 7, 8 and 9 — this is the fourth cycle.**
   Only a T2 has standing. This is the highest-value structural change available to the
   graph: it is the only thing that would let either half be scored honestly.
2. **Attach src-0007 to `ttp-attack-mapping-reliability`.** It is a third independent
   source for that issue (ATT&CK TTP identification P/R 0.2787/0.2270 GPT-4o,
   0.3480/0.1759 o3-mini, 0.2387/0.1846 GPT-4o FT, 0.1771/0.1414 GPT-4o-mini FT on real
   production material vs CTIBench's 0.6388 F1 ceiling) but the graph's
   candidate_resolutions still list only `[src-0002, src-0005]`. Cycle 10 cited it in the
   rationale; a T2/T3 must attach it properly. Note it also gives the first direct
   evidence on that issue's open_question[2]: fine-tuning made ATT&CK mapping **worse**,
   not better. Not a contradiction with src-0002 (different benchmark/corpus; harder
   real-world material is the expected direction).
3. **New-issue candidate: LLM triage precision.** src-0007 reports recall (Accepted)
   0.90-1.00 vs precision (Accepted) 0.27-0.40 across all four models — an automated
   triage stage passes through roughly two of every three items a human analyst would
   reject. No existing issue covers triage. For a T2.
4. **The g3 gate is specified two incompatible ways.** `prompts/t4_assess.md` step 3 =
   subtraction; `scripts/validate_state.py` lines 144-156 = ceiling. Cycle 10 applied the
   ceiling and argued why (see above), but this is a change to the system's own rules and
   neither T3, T4 nor T5 has standing to make it. **Second cycle carried.** It now
   demonstrably affects agenda-setting, not just presentation.
5. **src-0008 phase-label discrepancy** (source file says AES-256 at P5-P6; body text
   says XOR P5-P6 and AES-256 P7-P8). Needs a PDF-level check before anyone cites the
   phase structure. Its per-phase percentages are in pie charts (Figure 2) and cannot be
   verified by table pull at all; its Table 7 hallucination rates ARE now verified exact.
6. **Three unfinished search directions** (from cycle 9, still open): citation-graph
   sweep of arXiv 2506.11325 (`semanticscholar.org/arxiv/2506.11325` → 404; try Google
   Scholar, arXiv listing pages, or Connected Papers); third-party evaluations of the IoC
   Searcher / AlienVault OTX / VirusTotal baselines themselves; and the paywalled
   eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 to automated fetch, no
   preprint found) which is directly relevant to `ioc-extraction-reliability`.
7. **ctr-0001 resolution path** (from cycle 9): recover recall/F1 from src-0007's
   released code (GitHub/HuggingFace per its abstract) to make metrics comparable with
   src-0003's F1, and/or find any source running an unscaffolded LLM against PRISM or a
   LANCE-style pipeline against CyberThreat-Eval. If the SYSTEM confound is confirmed,
   close ctr-0001 and fold it into the issue's third candidate_resolution.
8. **G2 re-verification coverage to date**: src-0004 (c4), src-0003 (c5), src-0002 (c6),
   src-0001 (c7), src-0006 (c8), src-0005 (c9), src-0008 (c10). **src-0007 is the only
   source never re-verified** — natural target for cycle 11. Its Table 4 was pulled
   verbatim across all four model columns at collection time, so it is a lower-value
   target than most; a higher-value angle would be re-verifying an *older* source's
   figures that now carry more weight, e.g. src-0005, whose per-model numeric scores have
   never been captured at all and which holds `ttp-attack-mapping-reliability` at 3.
9. **Sandbox limitation, unchanged from cycle 9**: `python3` and `curl` are blocked, so
   JSON validity was checked by construction and re-reading, not by a parse. This is a
   weaker check than a parse and is recorded as such.

## Next task rationale

T4 → T5 per the state machine. T5 selects the weakest link and writes the next research
task; cycle 11 is not a refresh cycle (11 % 7 ≠ 0), so T5 should write a T3 unless its
own mechanical policy says otherwise.

I have deliberately **not** pre-selected the target. The scores leave a genuine three-way
tie at 2 (`ioc-extraction-reliability`, `consistency-calibration-as-failure-mode`,
`institutional-incident-real-world-impact`) which T5's tie-break policy exists precisely
to resolve, and pre-empting it would corrupt the evaluation data the ranking table is
supposed to produce. What I *have* done is give T5 the inputs it cannot derive from the
scores alone: the attempt penalty that applies to `ioc-extraction-reliability`, the fact
that `institutional-incident-real-world-impact` has never been targeted by any T1 or T3
in ten cycles, and the standing T2-shaped work (items 1-3) that no T3 can do.

## Budget

- Web searches: 0
- Page fetches: 2 (both `arxiv.org/html/2605.06910`, different extraction prompts, for G2)
- Assistant turns: ~8
- Files written: 3 (`scores.json`, this log, queue files); `graph.json` and
  `state/knowledge/` deliberately untouched
- Shell: 1 listing succeeded; 3 attempts at `python3`/validator blocked by the sandbox
