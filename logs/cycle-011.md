# Cycle 011 — T5 Select

## Task performed

T5 (Select) per `prompts/t5_select.md`, executing the queue entry written by cycle 10.
Read `logs/cycle-010.md`, `state/assessments/scores.json`, `state/issues/graph.json`,
`config.yml` and `prompts/t3_investigate.md` before ranking. No score was recomputed —
`last_assessed_cycle` is 10, so the numbers are one cycle old and taken as given.

**Selected: `institutional-incident-real-world-impact`. Next task: T3 (investigate).**

The selection required judgement beyond the written policy, and one premise I was handed
turned out to be factually wrong. Both are set out below.

---

## The ranking table (evaluation data — full derivation)

### Step 1 — candidate set

All issues with `score < 5`. Every one of the six qualifies; no issue in this graph has
ever scored above 3. Candidate set = all six.

### Step 2 — base priority = score (lower first)

| issue | score |
|---|---|
| `ioc-extraction-reliability` | 2 |
| `consistency-calibration-as-failure-mode` | 2 |
| `institutional-incident-real-world-impact` | 2 |
| `ttp-attack-mapping-reliability` | 3 |
| `attribution-confident-wrong-gap` | 3 |
| `task-dependent-reliability-framing` | 3 |

Three-way tie at the bottom. Tie-breaks are applied in the order a → b → c.

### Step 3a — upstream first

The policy reads: *"an issue that others `depend_on` outranks its dependents."*

`depends_on` edges as actually recorded in `graph.json` (I checked rather than accepting
the queue entry's summary — see the correction below):

| issue | `depends_on` | is depended upon by | in-degree |
|---|---|---|---|
| `ttp-attack-mapping-reliability` | `[]` | task-dependent | 1 |
| `ioc-extraction-reliability` | `[]` | task-dependent | 1 |
| `consistency-calibration-as-failure-mode` | `[]` | attribution, task-dependent | **2** |
| `attribution-confident-wrong-gap` | `[consistency-calibration]` | task-dependent | 1 |
| `task-dependent-reliability-framing` | `[ttp, ioc, consistency, attribution]` | — | 0 |
| `institutional-incident-real-world-impact` | `[]` | — | **0** |

**CORRECTION TO THE QUEUE ENTRY I WAS GIVEN.** Cycle 10's instructions asserted, under
item (a), that "none of the three tied issues is depended upon by anything," and told me
to check that against `graph.json` rather than take its word. I checked, and it is
**false**. `consistency-calibration-as-failure-mode` is depended upon by two issues
(`attribution-confident-wrong-gap` and `task-dependent-reliability-framing`), and
`ioc-extraction-reliability` is depended upon by one (`task-dependent-reliability-framing`).
Only `institutional-incident-real-world-impact` has in-degree 0. The rest of that queue
entry's claim (a) — that `task-dependent-reliability-framing` is a dependent, not an
upstream — is correct.

**What 3a does with those edges, and the reading I applied.** Two readings are available
and they give opposite answers, so I state the choice explicitly:

- **(i) STRICT PAIRWISE (applied).** The rule's comparison class is written as *"its
  dependents"* — it orders an issue against issues that depend on it, and says nothing
  about two issues that are unrelated in the DAG. Constraints it yields:
  `consistency` ≻ `attribution`; and `{ttp, ioc, consistency, attribution}` ≻
  `task-dependent`. This is not a vacuous rule — it has real content — but **none of the
  three tied issues is a dependent of another of the three**, so 3a does not separate the
  bottom tie. It stays a three-way tie going into 3b.
- **(ii) IN-DEGREE (not applied).** Rank by *how many* issues depend on you.
  `consistency` (2) ≻ `ioc` (1) ≻ `institutional` (0). Under this reading
  `consistency-calibration-as-failure-mode` wins the tie **mechanically** at step 3a, the
  cycle never reaches 3b or 3c, and the judgement call I make below never arises.

I applied (i) because it is what the sentence says: "an issue that others `depend_on`
outranks *its dependents*" names a relation between an issue and its own downstream
nodes, not a scalar ranking by degree. Reading (ii) is a different rule with different
content, not a paraphrase of this one. I record plainly that this choice **changed the
outcome of the cycle**, that I made it before knowing where the judgement in step 3d
would land, and that a reader who prefers reading (ii) should read this cycle's target as
`consistency-calibration-as-failure-mode` instead. This is a second under-specification in
the system's own rules (see carry-forward item 4 for the first) and is flagged for a
cycle with standing to fix it.

### Step 3b — attempt penalty

`scoring.tie_break_recent_attempt_penalty` = 1, "per attempt within the last 5 cycles".

**Window interpretation, stated explicitly because it decides the cycle:** current cycle
is 11, so "the last 5 cycles" = the five completed cycles preceding this one = **6, 7, 8,
9, 10 inclusive**. (Cycle 11 is this cycle and has no logged attempt.)

| issue | `attempts` | in window (6–10) | penalty |
|---|---|---|---|
| `ttp-attack-mapping-reliability` | `[]` | — | 0 |
| `ioc-extraction-reliability` | `[9]` | **9 ✓** | **+1** |
| `consistency-calibration-as-failure-mode` | `[3]` | 3 ✗ (8 cycles ago) | 0 |
| `attribution-confident-wrong-gap` | `[]` | — | 0 |
| `task-dependent-reliability-framing` | `[6]` | **6 ✓** (boundary) | **+1** |
| `institutional-incident-real-world-impact` | `[]` | — | 0 |

Two boundary notes. `consistency-calibration`'s attempt at cycle 3 is comfortably
outside the window under any reading — 8 cycles back — so no interpretation rescues it
from the tie. `task-dependent-reliability-framing`'s attempt at cycle 6 sits exactly on
the edge; under the alternative window 7–11 it would drop out and that issue would come
to effective 3 instead of 4. It is at base 3 and not in contention for the bottom either
way, so the boundary is immaterial to the selection. I note it for auditability rather
than because it matters here.

### Effective ranking after 3a and 3b

| rank | issue | base | 3a | 3b | **effective** |
|---:|---|---:|---:|---:|---:|
| **=1** | `consistency-calibration-as-failure-mode` | 2 | 0 | 0 | **2** |
| **=1** | `institutional-incident-real-world-impact` | 2 | 0 | 0 | **2** |
| =3 | `ioc-extraction-reliability` | 2 | 0 | +1 | 3 |
| =3 | `ttp-attack-mapping-reliability` | 3 | 0 | 0 | 3 |
| =3 | `attribution-confident-wrong-gap` | 3 | 0 | 0 | 3 |
| 6 | `task-dependent-reliability-framing` | 3 | 0 | +1 | 4 |

`ioc-extraction-reliability`, the graph's most-worked issue, drops out of the bottom tie
on its own attempt penalty — which is exactly what 3b is for. Note also what this depends
on: under the *subtraction* reading of the g3 gate (carry-forward item 4) that issue would
have been scored 1 at cycle 10 and would be the unique weakest link here, penalty and all.
The gate reading determines the research agenda, not just a presentation detail.

### Step 3c — older `created_cycle` first

`consistency-calibration-as-failure-mode`: `created_cycle` **2**.
`institutional-incident-real-world-impact`: `created_cycle` **2**.

Identical. **The written policy is now exhausted with the tie unbroken.**

### Step 3d — judgement beyond the policy

I am stating plainly, as the queue entry required: **from here I am exercising
judgement, not applying the policy.** The policy has no fourth tie-break and I have no
standing to add one to `prompts/t5_select.md`.

**Selected: `institutional-incident-real-world-impact`.** Three reasons, weighted:

1. **Ten cycles, zero visits.** This is the only issue in the graph with no new evidence
   since cycle 1 and the only one never targeted by any T1 or T3 (`attempts: []`, and no
   T1 has ever aimed at it either). Cycle 10's rationale states its score "has not moved"
   *because* nothing has been done to it — the 2 measures our neglect, not the world.
   A weakest-link selector that can leave an issue untouched for ten cycles while
   returning to the same worked-over ones has a coverage defect, and this is the cheapest
   possible cycle in which to correct it.
2. **Unexplored search space, therefore higher expected yield.** Its open questions are
   answerable by search over 2025–2026 reporting (other publishers' incidents, ENISA's
   disclosure policy, the primary Der Spiegel article), and *no cycle has ever run those
   searches* — the space is untouched. `consistency-calibration`'s open questions need a
   second study measuring repeated-query consistency or ECE/Brier on CTI material, and
   that space has already been probed and come up dry twice: cycle 10 checked both
   cycle-9 sources against it and rejected both (src-0007 reports precision/recall only,
   no consistency measure and no ECE/Brier anywhere; src-0008 measures JavaScript code
   analysis, not CTI reasoning).
3. **It is the whole real-world-impact arm of the topic, resting on one secondary
   article.** `state/meta.json` scopes the topic to include "documented incidents". This
   is the only issue covering that, its sole candidate_resolution cites `src-0004` alone,
   and `src-0004` is Heise reporting *Der Spiegel's* reporting. Its own open_question[2]
   asks whether the primary source confirms the 26/492 figure independently. An entire
   arm of the topic currently hangs on an unverified second-hand number.

**The case against, which is real and which I am not hiding.** `institutional` is a leaf
with in-degree 0: progress there unblocks nothing else in the graph.
`consistency-calibration` is the most structurally central issue in the graph (in-degree
2) and its weakness propagates into `attribution-confident-wrong-gap` and
`task-dependent-reliability-framing`. On pure graph centrality, `consistency` is the
better pick, and under reading (ii) of 3a it would have won without my involvement. I
chose against centrality because centrality is precisely what has kept `institutional` at
2 for ten cycles, and because a selector that only ever optimises centrality will never
discover what is in the unvisited part of its own topic.

**Recommendation for a cycle with standing (do NOT act on it here).** `prompts/t5_select.md`
needs a final deterministic tie-break after 3c so this is never a judgement call again.
The obvious candidate, and the one this cycle's reasoning supports: *fewest total attempts
first; then longest time since the issue last received new evidence.* That would have
selected `institutional` mechanically. I have deliberately **not** edited that file —
T5 has no standing to change the system's own rules.

### Step 4 — refresh rule

`current_cycle % schedule.collect_refresh_every` = **11 % 7 = 4 ≠ 0**, so this is not a
refresh cycle. The next task is a **T3**, not a T1. (Refresh cycles are 7, 14, 21, …;
cycle 7 was indeed a T4 in practice, so the refresh rule has never yet fired — worth
noting for the paper that a schedule keyed to `current_cycle` rather than to T5
occurrences may never trigger. Recorded, not acted on.)

I confirmed against `prompts/t3_investigate.md` step 2 that a T3 **may** web-search and
add sources ("if you fetch something substantial, add it properly as a source per T1
rules — it counts toward the same `max_new_sources` budget"). This matters: the selected
issue is evidence-starved, so a T3 that could not collect would have been a wasted cycle.
It can.

---

## Retrospection

**Target: `src-0005` (CyberSOCEval, arXiv 2509.20166)** and, through it, the supported
candidate_resolution of `ttp-attack-mapping-reliability`, whose evidence array is
`[src-0002, src-0005]`.

Chosen over `src-0007` (the only never-re-verified source) for the reason cycle 10's
carry-forward item 8 gives: `src-0007`'s Table 4 was pulled verbatim across all four model
columns at collection time and its abstract cross-checked against two independent fetches,
making it a low-value target; whereas `src-0005` was collected by automated
abstract-page summarisation in cycle 1, cycle 9's G2 pass on it confirmed its claims **in
substance but explicitly NOT verbatim**, and it is one of only two sources holding
`ttp-attack-mapping-reliability` at 3. A source whose wording has never been confirmed
should not be carrying an issue's score.

Per the standing methodological rule I asked for the **full abstract verbatim, word for
word, with no summarising**, plus any sentence containing the keywords, and refused any
"the claim is/isn't supported" answer. One fetch of `https://arxiv.org/abs/2509.20166`.

**Result: PASS — and this time verbatim, not merely in substance.** All four quotes stored
in `state/knowledge/src-0005.md` are present in the returned abstract exactly as recorded:

1. "core defensive domains with inadequate coverage in current benchmarks" — **exact**.
2. "larger, more modern LLMs tend to perform better, confirming the training scaling laws
   paradigm" — **exact**.
3. "reasoning models leveraging test time scaling do not achieve the same boost as in
   coding and math" — **exact**. The paper continues "…suggesting these models have not
   been trained to reason about cybersecurity analysis, and pointing to a key opportunity
   for improvement", which is the basis for key claim 2's gloss and is fairly rendered.
4. "current LLMs are far from saturating our evaluations" — **exact**, with one trivial
   difference: `src-0005.md` quotes it sentence-initially as "Current…" whereas in the
   paper it is mid-sentence ("Finally, current LLMs are far from saturating our
   evaluations, showing that CyberSOCEval presents a significant challenge…"). Capital
   letter only; no substantive discrepancy, and I did not open a contradiction for it.

The author list also confirms the affiliation claim behind the source's recorded
limitation: Sven Krasser and Joshua Saxe are both present, as recorded in cycle 1.

**What the pass does NOT establish, and this is the point worth carrying.** Cycle 9's
recorded limitation on `src-0005` — *no per-model numeric scores have ever been captured*
— is **unchanged**. Everything now verified verbatim is abstract-level prose. The claim
this source contributes to `ttp-attack-mapping-reliability` is directional ("test-time
scaling doesn't transfer"; "far from saturating") and carries no number that could be
compared against `src-0002`'s 0.6388 F1 or `src-0007`'s 0.2787/0.2270. So the issue's
score of 3 rests on one source with a number (`src-0002`) and one source with a direction
(`src-0005`). I deliberately did **not** go and pull the numeric tables: that is
collection work on a non-selected issue and belongs to a T1/T3, not to a T5 whose job this
cycle is selection. Recorded as carry-forward item 10.

---

## Changes made

- `logs/cycle-011.md` (this file).
- `state/queue/next_task.json` — replaced with a **T3** targeting
  `institutional-incident-real-world-impact`, quoting all three of that issue's
  `open_questions` verbatim from `graph.json`.
- `state/queue/last_completed_task.txt` — `T5 select`.
- `state/issues/graph.json` — **unchanged**. T5 does not touch the graph; no contradiction
  was warranted (the one discrepancy found in retrospection is a capital letter).
- `state/assessments/scores.json` — **unchanged** (`last_assessed_cycle` stays 10).
- `state/knowledge/` — **unchanged**; append-only respected, no new sources this cycle.

---

## Carry-forward items (all preserved; new items 10–12 appended)

1. **SPLIT `task-dependent-reliability-framing`** into the NARROW claim (CTI reliability
   varies by sub-task — `src-0001`, `src-0002`, `src-0006`, `src-0007`; merits 3) and the
   SPECIFIC ORDINAL AXIS ("mechanical extraction < classification < attribution <
   generation"), which cycle 10 found is no longer merely doubted but actively
   **DISPUTED**: `src-0007`'s Table 4 supports it (IoC extraction precision 0.82–0.88 vs
   TTP identification 0.2787/0.2270, same team/corpus/models) while `src-0006`'s Table 5
   opposes it (failure subtypes span all four pipeline stages, e.g. "Co-mention bias
   (Type 1.1) — stages 1234"). Cycle 10 explicitly **declined** to open a contradiction
   for that tension, reasoning that `src-0006` is about where failure MECHANISMS occur and
   `src-0007` about where performance LEVELS differ, which are compatible; do not overturn
   that without reading both tables. **CARRIED BY CYCLES 7, 8, 9, 10 AND NOW 11 — FIVE
   CONSECUTIVE CYCLES.** Only a T2 has standing. My ranking legitimately pointed at a T3,
   so I carried it again rather than smuggling structural work into a selection cycle —
   but see item 12: five consecutive carries is no longer a curiosity, it is a finding.
2. **ATTACH `src-0007` to `ttp-attack-mapping-reliability`.** It is an unattached third
   independent source (ATT&CK TTP identification P/R 0.2787/0.2270 GPT-4o, 0.3480/0.1759
   o3-mini, 0.2387/0.1846 GPT-4o-FT, 0.1771/0.1414 GPT-4o-mini-FT on real production
   material vs CTIBench's 0.6388 F1 ceiling) that cycle 10's rationale cites but
   `graph.json`'s candidate_resolutions do not list (still `[src-0002, src-0005]`). It also
   gives that issue's open_question[2] its first direct evidence, and the answer is that
   fine-tuning made ATT&CK mapping **worse**. Not a contradiction with `src-0002`
   (different benchmark and corpus; real-world material being harder is the expected
   direction).
3. **NEW-ISSUE CANDIDATE for a T2: LLM triage precision.** `src-0007` reports recall
   (Accepted) 0.90–1.00 vs precision (Accepted) 0.27–0.40 across all four models — an
   automated triage stage passes through roughly two of every three items a human analyst
   would reject. No existing issue covers triage.
4. **THE G3 GATE IS SPECIFIED TWO INCOMPATIBLE WAYS**, and this demonstrably affects
   agenda-setting, not just presentation. `prompts/t4_assess.md` step 3 says an issue with
   an open contradiction LOSES `gates.g3_contradiction_demotion` points (a subtraction);
   `scripts/validate_state.py` lines 144–156 implements a CEILING (error only if
   score > `scale_max - demotion` = 3). Cycle 10 applied the CEILING and argued why: the
   rubric's levels are definitions of states (0 = "no candidate resolutions", 1 = "no
   supported resolution"), and `ioc-extraction-reliability` has three candidate_resolutions
   with two supported, so a subtraction to 0 or 1 would assign a label that is factually
   false of the issue. **Confirmed live this cycle:** under the subtraction reading that
   issue would have been the unique weakest link at 1 and would have been selected despite
   its attempt penalty; under the ceiling it sat at 2 and 3b removed it. **THIRD CYCLE
   CARRIED.** No task type in the state machine has standing to reconcile the prompt and
   the validator.
5. **`src-0008` phase-label discrepancy** found by cycle 10's G2: `state/knowledge/src-0008.md`
   key claim 2 says AES-256 is at P5–P6, but the paper's body text says "Both XOR (P5, P6)
   and AES-256 (P7, P8)". Substance is unaffected (encryption collapses detection either
   way) and no contradiction was opened, because both readings are automated fetches of
   the same HTML and one of them demonstrably mis-rendered characters. Needs a PDF-level
   check before anyone cites `src-0008`'s phase structure. Also: `src-0008`'s per-phase
   percentages exist ONLY as pie charts (Figure 2) and cannot be verified by table pull at
   all, whereas its Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini
   4.8%, Grok 0, Cohere 0) are verified exact and their "approximate" caveat can be lifted.
6. **THREE UNFINISHED SEARCH DIRECTIONS, open since cycle 9:** citation-graph sweep of
   arXiv 2506.11325 (`semanticscholar.org/arxiv/2506.11325` returns 404 — try Google
   Scholar, arXiv listing pages, or Connected Papers); third-party evaluations of the IoC
   Searcher / AlienVault OTX / VirusTotal baselines themselves; and the paywalled eLLM-CTI
   paper (ScienceDirect S0167739X26001482, "Enhanced-LLM extraction of CTI from
   unstructured threat reports. A tough nut to crack or a walk in the park?", HTTP 403 to
   automated fetch, no preprint located).
7. **`ctr-0001` RESOLUTION PATH:** recover recall/F1 from `src-0007`'s released code
   (GitHub/HuggingFace per its abstract) to make its precision-only numbers comparable
   with `src-0003`'s F1, and/or find any source running an unscaffolded LLM against PRISM
   or a LANCE-style scaffolded pipeline against CyberThreat-Eval. If the SYSTEM confound is
   confirmed as the explanation, `ctr-0001` should be CLOSED and folded into
   `ioc-extraction-reliability`'s third candidate_resolution rather than left open.
8. **G2 re-verification coverage to date:** `src-0004` (c4), `src-0003` (c5), `src-0002`
   (c6), `src-0001` (c7), `src-0006` (c8), `src-0005` (c9 substance-only, **c11
   verbatim**), `src-0008` (c10). **`src-0007` is now the only source never re-verified**
   — natural target for cycle 12, though still a low-value one for the reason in item 8 of
   cycle 10's log. The higher-value G2 angle after this cycle is `src-0004`: it was last
   re-verified at cycle 4, it is a *secondary* news source, and it is about to become the
   sole existing evidence base for the issue cycle 12 will investigate.
9. **METHODOLOGICAL RULE, APPLY IT:** when re-verifying a claim against a table or an
   abstract, ask the fetch for the ENTIRE ROW/TABLE/PASSAGE VERBATIM across all columns and
   never accept a summarised "the value is/isn't X" as confirmation or refutation. Cycle 8
   nearly opened a spurious contradiction that way; cycle 9's pass on `src-0005` got a
   paraphrase back and could only be recorded as passing on substance, not wording; cycle
   10's pass on `src-0008` followed the rule and discovered both that Table 7 is exactly
   right AND that the per-phase figures are not in a table at all; cycle 11 followed it and
   converted `src-0005` from substance-only to verbatim in a single fetch.
10. **NEW (c11): `src-0005` has still never had a number captured.** Its wording is now
    verified exact, but every claim it contributes is abstract-level and directional
    ("test time scaling does not achieve the same boost"; "far from saturating"). It is
    one of two sources holding `ttp-attack-mapping-reliability` at 3, and the other
    (`src-0002`) is the only one supplying a figure (0.6388 F1). Pulling CyberSOCEval's
    per-model/per-task scores from the full paper is the single cheapest thing that could
    move that issue, and it has been an open limitation since cycle 1.
11. **NEW (c11): TIE-BREAK 3a IS UNDER-SPECIFIED** in `prompts/t5_select.md` — "an issue
    that others `depend_on` outranks its dependents" admits a strict pairwise reading
    (applied this cycle; inert on unrelated nodes) and an in-degree reading (not applied;
    would have selected `consistency-calibration-as-failure-mode` instead). **The two
    readings selected different issues this cycle.** Additionally the policy has no
    deterministic tie-break after 3c and ran out entirely on a genuine 2-vs-2 tie with
    identical `created_cycle`. Suggested fix for a cycle with standing: add "3d. fewest
    total attempts first; then longest time since the issue last received new evidence."
    This is the second rule-level ambiguity in the system after item 4.
12. **NEW (c11): THE STATE MACHINE HAS NO PATH TO STRUCTURAL WORK.** T1→T2→T3→T4→T5→T3 is
    the only cycle, and after the first pass it never returns to T2 — every subsequent lap
    runs T3→T4→T5→T3. T2 is the *only* task type with standing to split an issue, add a
    new issue, or reconcile the prompt/validator disagreement, and items 1, 3 and 4 have
    now been blocked on that for five, two and three cycles respectively. The refresh rule
    provides an escape to T1 every 7th cycle but there is **no analogous escape to T2**.
    This is a structural finding about the loop design, not a complaint about any cycle,
    and it belongs in the paper.

---

## Next task rationale

T5 → T3 per the state machine, with `target_issue = institutional-incident-real-world-impact`
per the ranking above, and T3 rather than T1 because 11 % 7 = 4 ≠ 0.

The instructions written to the queue quote all three of the issue's `open_questions`
verbatim as the prompt requires, and are self-contained: cycle 12 has no memory of this
one beyond the files. I front-loaded the two things a T3 on this issue most needs and
cannot derive from the graph — that `src-0004` is *secondary* reporting (Heise citing Der
Spiegel), which makes open_question[2] a primary-source-verification job rather than a
literature search; and that this issue has never been searched at all, so the T3's step-2
instruction to "use the existing knowledge base FIRST" will exhaust itself in one reading
and the cycle's real work is search. I also carried the warning that its
candidate_resolution claims *existence, explicitly not frequency*, so open_question[0]'s
base rate is not answerable by finding a second anecdote — which is the mistake most
readily available to the next cycle.

## Budget

- Web searches: 0
- Page fetches: 1 (`arxiv.org/abs/2509.20166`, for G2)
- Assistant turns: ~6
- Files read: 9 (`meta.json`, `next_task.json`, `config.yml`, `scores.json`, `graph.json`,
  `index.json`, `logs/cycle-010.md`, `prompts/t5_select.md`, `prompts/t3_investigate.md`,
  plus `src-0005.md` and `src-0004.md`)
- Files written: 3 (this log, `next_task.json`, `last_completed_task.txt`)
- Shell: 0. **Sandbox limitation, unchanged since cycle 9:** `python3` and `curl` are
  blocked, so JSON validity was checked by construction and re-reading, not by a parse.
  This is a weaker check than a parse and is recorded as such.
