# Cycle 027 — T5 (Select)

Topic: `cti-ai-reliability`. Task from `state/queue/next_task.json` (created cycle 26): run T5
per `prompts/t5_select.md`. I read that prompt file myself rather than relying on the queue
entry's or any log's description of it, per the standing instruction.

Phase check, re-derived rather than inherited: `prompts/system.md` gives T1→T2, T2→T3, T3→T4,
T4→T5, T5→T3. `state/queue/last_completed_task.txt` reads `T4 assess`; `scores.json` has
`last_assessed_cycle: 26`. So cycle 27 is the T5. Confirmed.

Refresh-rule check: `schedule.collect_refresh_every` is 7 in `config.yml`; 27 mod 7 = 6 ≠ 0.
**The refresh rule does not fire. I emit a T3, not a T1.**

---

## Task performed

T5 — select the weakest link and write the next task. Selection worked below, mechanically, with
the full ranking table. I also hit the tie-break wall that carry-forward [11] has predicted since
cycle 20, and I say so explicitly rather than papering over it.

---

## Retrospection

**Target chosen: `src-0017` (github.com/xschen-beb/CyberThreat-Eval), added cycle 21, never
verified.** Recommended by carry-forward [8] on two grounds — it and src-0018 are the only two
sources in the base that have never faced a G2, and this one is a *different kind* of check
(file paths and code lines rather than table cells). It was also double-value: carry-forward [34]
wants src-0007's TTP and rubric scorers from that same repository.

Method, applying all five parts of the standing methodological rule ([31], [38]):

1. `https://raw.githubusercontent.com/xschen-beb/CyberThreat-Eval/main/stage3_ti_drafting/ioc/eval/eval_ioc.py`
   — asked for the **entire file verbatim**, with an explicit instruction to write `CANNOT READ`
   rather than infer, plus exact-string checks on every stored quotation and stored token.
   **This returned the whole file for the first time.** Cycle 21 had recorded that "the `test()`
   function body was returned only in part"; that limitation is now discharged.
2. `https://raw.githubusercontent.com/xschen-beb/CyberThreat-Eval/main/stage3_ti_drafting/ioc/README.md`
   — the IoC **sub-README**, as a second URL form, to confirm the five sub-README quotations.
3. `https://github.com/xschen-beb/CyberThreat-Eval` — the rendered repository page, for the
   top-level listing, the self-description, and whether any TTP/rubric scorer path is named.

Note on ABSENT verdicts, per [38]: the *top-level* README fetch returned the micro-averaged /
recall-definition / all-IOCs quotations as **ABSENT**. That is **not** a defect — those strings
were always attributed to the IoC sub-README, not the top-level one. I did not record an absence;
I fetched the correct URL form and all five came back PRESENT and exact. [38] earned its keep
again, this time by stopping me recording a defect that was a URL-form error on my side.

### What re-verified exactly (the positive half)

- Key claim 1, all four strings: `precision = total_true_positives / (total_true_positives +
  total_false_positives)`, `recall = total_true_positives / (total_true_positives +
  total_false_negatives)`, `print(f"Overall Precision: {precision:.4f}")`,
  `print(f"Overall Recall: {recall:.4f}")` — **all PRESENT, exact.** And now confirmed against the
  **full** text rather than an excerpt: there is genuinely no flag, argument or branch producing
  precision without recall. The `argparse` block takes only `--dataset` and `--prediction`.
- Key claim 5: no `F1` or `f1` token anywhere in the evaluator or the sub-README. **Confirmed
  against full text.**
- Key claim 2 and 4, all five sub-README quotations — the micro-averaged sentence, the
  `Recall: TP / (TP + FN)` definition, the all-IOCs pitfall, the "Recall Calculation" restatement,
  and "**High Precision, Low Recall**: Your system is accurate but misses many IOCs" —
  **all PRESENT, exact.**
- Key claim 3: top-level listing re-read verbatim and unchanged — `.DS_Store`, `.gitignore`,
  `README.md`, `stage1_triage/`, `stage2_deep_search/`, `stage3_ti_drafting/`.
- Key claim 6: self-description PRESENT. One nuance worth recording — the printed tag is
  `[TMLR '25]` **with an apostrophe**; `src-0017.md` renders it correctly, `index.json`
  key_claims[3] renders it without. Not a defect, but the index form is not the quotation.
- The sub-README still displays the illustrative `Overall Precision: 0.8000` /
  `Overall Recall: 0.6667`, so `src-0017.md`'s loudest warning — that these are toy numbers from
  a worked example and are not src-0007's missing recall — remains live and correctly placed.

### What FAILED re-verification — `ctr-0004` opened

**The state says the evaluator matches in BOTH directions. It does not. It matches in ONE.**

This issue's cycle-21 `open_question` asserts that "src-0017's evaluator matches predicted IoCs to
ground truth with a SUBSTRING rule in both directions", and three `scores.json` rationales
(`ttp-attack-mapping-reliability`, `task-dependent-reliability-framing`,
`extraction-vs-reasoning-ordinal-axis`, written at cycles 22 and 26) repeat it as settled fact in
the form "src-0017 shows src-0007's released IoC evaluator matches by two-directional SUBSTRING
CONTAINMENT". The executing code, now read whole:

```python
true_positives = sum(
    any(pred.lower() in gt.lower() for gt in gt_set)
    for pred in pred_list
)
false_positives = len(pred_list) - true_positives
false_negatives = sum(
    not any(pred.lower() in gt.lower() for pred in pred_list)
    for gt in gt_set
)
```

The two-directional variant (`(pred.lower() in gt.lower()) or (gt.lower() in pred.lower())`) and
the exact-match variant are **each enclosed in a triple-quoted string literal** and never execute.
The four comment lines cycle 21 quoted are the *headers standing above that dead code*. The
sub-README independently states the live rule in prose, verbatim: "A prediction is considered a
**True Positive (TP)** if `pred.lower() in gt.lower()` for any ground truth IOC from the same
source". Code and documentation agree with each other and against the state.

**Why the direction matters and this is not pedantry.** The direction fixes the *sign* of the
bias, and every downstream use assumed one sign. The actual rule is **asymmetric**:

- **Lenient** toward short or fragmentary predictions — anything that is a substring of a longer
  ground-truth entry scores TP.
- **Strict** against verbose predictions — a prediction containing the IoC plus surrounding text
  scores a **false positive**. That is the characteristic failure mode of a free-form LLM
  extractor, and it is precisely the case the dead two-directional block would have scored TP.

So `src-0017.md`'s limitation "a substring-permissive matcher inflates true positives relative to
strict equality" is **half right**: relative to strict equality this matcher inflates on one axis
and **deflates on the other**.

**Where the blame sits, stated plainly because it is a finding about this loop's failure mode.**
`src-0017.md` itself was honest: it says "*the comments* show substring matching in both
directions" and explicitly flags that "the surrounding matching loop is not fully transcribed".
The `open_question` and the three `scores.json` rationales **dropped the hedge and asserted the
mechanism**. The defect was not introduced by the source file; it was introduced by downstream
paraphrase of a correctly hedged source file, over six cycles. That is a new instance of the
[31] defect class, and it is the first one where the *original* record was clean.

**Two further properties of the live code**, first-time observations, recorded as observation and
**not** used to support any candidate:

- Ground truth is built as a **set** per source while predictions stay a **list**, so duplicate
  correct predictions each count as a separate TP while false negatives are counted over the
  deduplicated ground-truth set.
- The shared normalisation chain is
  `item.replace("[", "").replace("]", "").replace("hxxp", "http").replace("hxxps", "https").replace("[.]", "[]").split(" - ")[0].strip()`
  then `.lower()`. Within it the `"[.]"` → `"[]"` step is **unreachable**: both bracket characters
  are already gone by then.

**What this also settled for free.** The cycle-21 open_question said "Resolving this needs the
remainder of `eval_ioc.py` read, and ideally src-0003's own matching rule read alongside it." The
first half is **done**. The second half stays open and is almost certainly unanswerable — [33] and
`src-0003.md` line 141 both record that src-0003 never states its matching rule.

**What I did NOT do.** The ATT&CK/TTP scorer and the drafting-rubric scorer are still unread. The
repository page names `stage3_ti_drafting/ttp/` as the TTP path and names **no** path for a rubric
or judge scorer. Reading them is [34]'s route to restoring `task-dependent-reliability-framing` to
4 — but that is T3 work on a different issue, and a T5 doing it would be doing the next cycle's
task. Recorded as a located, cheap, still-open lead.

Verdict: **FAILED re-verification. `ctr-0004` opened** against `ioc-extraction-reliability`, and
the correction appended to **both** `index.json` and `src-0017.md` per the repair-both-places
pattern ([21], [32]). Reported plainly: the system caught a claim that six cycles had hardened
past its evidence. That is the mechanism working.

---

## Changes made

1. `state/issues/graph.json` — **added contradiction `ctr-0004`** (issue
   `ioc-extraction-reliability`, `opened_cycle: 27`, `resolved_cycle: null`) recording the
   one-directional matcher finding, the second-URL-form confirmation, the asymmetric-leniency
   consequence, the two observation-only code properties, and a three-step resolution path for a
   T3. Validated with `jq -e`. **No issue, candidate_resolution or open_question was edited or
   deleted** — append-only respected; the disputed `open_question` stays exactly as written and is
   corrected by the contradiction entry, not by erasure.
2. `state/knowledge/index.json` — **appended one key_claim to src-0017** (now 5), covering both
   the positive re-verification and the correction. Nothing removed or rewritten. Validated with
   `jq -e`.
3. `state/knowledge/src-0017.md` — **appended** a "Cycle-27 G2 re-verification" section. Nothing
   above it altered.
4. `logs/cycle-027.md` — this file.
5. `state/queue/next_task.json` — T3 targeting `attribution-confident-wrong-gap`.
6. `state/queue/last_completed_task.txt` — `T5 select`.

**Not changed:** `scores.json` (a T5 does not score, and `ctr-0004` gives a T4 something to weigh,
not me); every issue body; every other source file.

---

## Next task rationale

### Step 1 — candidate set

All issues with score < 5. All eight qualify. Scores from `scores.json`,
`last_assessed_cycle: 26`.

### Step 2 and 3 — the ranking table

Attempt penalty (`scoring.tie_break_recent_attempt_penalty: 1` per attempt within the last 5
cycles). **Window arithmetic, checked myself rather than inherited:** current cycle 27. The three
readings of "within the last 5 cycles" are {22..26}, {23..27}, and `27 − attempt ≤ 5` i.e.
{22..27}. **All three agree on every attempt in the graph this cycle** — cycle 25 is inside all
three, cycle 21 is outside all three (27 − 21 = 6). So the boundary ambiguity does not bite at
cycle 27 and I did not have to choose. A future T5 will not be so lucky; recorded as [11]'s
neighbour.

| Issue | Score | Attempts | In-window | Penalty | Effective | Depends on | Depended on by | created | Rank |
|---|---|---|---|---|---|---|---|---|---|
| `ioc-extraction-reliability` | 2 | [9, 21] | none | 0 | **2** | — | task-dependent | 2 | **1 =** |
| `attribution-confident-wrong-gap` | 2 | [16] | none | 0 | **2** | consistency | task-dependent | 2 | **1 =** ← **SELECTED** |
| `automated-triage-under-refusal` | 2 | [] | none | 0 | **2** | — | — | 16 | **3** |
| `consistency-calibration-as-failure-mode` | 2 | [3,15,16,25] | **25** | **+1** | **3** | — | attribution, task-dependent | 2 | 4 |
| `ttp-attack-mapping-reliability` | 3 | [16] | none | 0 | **3** | — | task-dependent | 2 | 5 |
| `task-dependent-reliability-framing` | 3 | [6, 16] | none | 0 | **3** | ttp, ioc, consistency, attribution | extraction-vs-reasoning | 2 | 6 |
| `institutional-incident-real-world-impact` | 3 | [12] | none | 0 | **3** | — | — | 2 | 7 |
| `extraction-vs-reasoning-ordinal-axis` | 3 | [17, 18] | none | 0 | **3** | task-dependent | — | 16 | 8 |

Ranks 4–8 are not separated from one another; nothing turned on it, so I did not manufacture an
order among them beyond effective score.

### The 3a-versus-3b ordering problem, and the reading I used

`prompts/t5_select.md` lists 3a (upstream first) **before** 3b (attempt penalty). Taken
literally, 3a would fire first and rule `consistency-calibration-as-failure-mode` **above**
`attribution-confident-wrong-gap` (the latter `depends_on` the former), and 3b would then push
consistency to effective 3 — **below** attribution. The two steps give opposite verdicts on the
same pair and the prompt does not say which wins.

**The reading I applied, stated as mine and not as the prompt's:** the attempt penalty is
described as an addition *to the score*, and rule 2 makes score the base priority — so the penalty
modifies the quantity being ranked, and 3a is a tie-break among issues of **equal effective
score**. Procedure: effective = score + penalty → rank → 3a (strict pairwise) → 3c. I chose this
because it is the only ordering under which 3b's stated purpose ("prevents thrashing on a stuck
issue") actually functions; under strict lexicographic a-then-b, an upstream issue could be
selected for the fifth time in twenty-five cycles with the anti-thrashing rule unable to reach it.
**This is a judgement, not a rule the prompt states, and I flag that it is the second cycle in a
row to have to make one.** Note it did not change the outcome here: `consistency` is out under
both readings — under mine on effective score, under the literal one it wins 3a against
attribution but then still loses 3b to `ioc` and `triage`, which 3a never ordered.

### Step 3a — upstream first, strict pairwise

Cycle 20 ruled for the **strict pairwise** reading and cycle 23 endorsed it: 3a orders a pair only
where one member directly `depends_on` the other. Among the effective-2 tier
{`ioc-extraction-reliability`, `attribution-confident-wrong-gap`, `automated-triage-under-refusal`}
there is **no `depends_on` relation of any kind**. `attribution` depends on `consistency`, which is
outside the tier; `ioc` and `attribution` are both depended on by `task-dependent`, also outside
the tier; `triage` is isolated. **3a is silent.**

I checked what the rejected non-pairwise reading would do, because [30] says it matters: under a
"has dependents" reading, `ioc` and `attribution` (each depended on by `task-dependent`) would
outrank `triage` (no dependents). **Same outcome for `triage` either way**, which is worth
recording — the two readings of 3a diverge on this tier only in *why*, not in *what*.

### Step 3b — applied above. Step 3c — older `created_cycle` first

`ioc-extraction-reliability` and `attribution-confident-wrong-gap` are both `created_cycle: 2`;
`automated-triage-under-refusal` is `created_cycle: 16`. **3c eliminates `automated-triage-under-refusal`**,
and it does so on a rule the prompt actually states, not on a rule I invented. That matters
because [30] warns that "never attempted" is *not* a tie-break and cycle 19 wrongly asserted it
was — I have not used it, in either direction. This issue has now **lost three consecutive
selections** while still holding `attempts: []`, and the curl/HackerOne source ([15]) goes
uncollected for a third cycle. That is a real cost and I record it rather than minimising it.

### The wall

**`ioc-extraction-reliability` and `attribution-confident-wrong-gap` are tied on every rule the
prompt supplies**: same score (2), same penalty (0), no pairwise dependency, same `created_cycle`
(2). There is no 3d. This is exactly the residue carry-forward [11] has flagged since cycle 20,
and cycle 27 is the cycle where the four-way bottom tier made it bind.

**I broke it on an explicitly extra-prompt criterion, labelled as such: repair refuted content
before deepening thin content.**

1. **The graph currently asserts something the state itself has refuted.**
   `attribution-confident-wrong-gap`'s primary candidate, at status **`supported`**, still reads
   "every one of the 5 tested models' 'plausible-sounding' attribution rate substantially exceeds
   its 'correct' attribution rate (e.g. GPT-4-turbo: 86% plausible vs 52% correct)". `ctr-0002`
   established from src-0002's own Section 4.2 that Plausible Accuracy *contains* Correct
   Accuracy, so that sentence is true by construction and evidences nothing — and that the scare-quoted
   "plausible-sounding" does not occur in the paper at all. A refuted claim sitting at status
   `supported` in the issue graph is a **worse** defect than an issue that is merely thin, and the
   system's own append-only-with-correction discipline treats unrepaired contradictions as defects
   of record. `ioc-extraction-reliability` has no comparable falsehood on its face; its problem is
   an absence.
2. **The repair is fully specified and source-complete.** Carry-forward [36] gives three ordered
   steps; the derived replacement numbers are already computed and stored in `index.json`
   key_claims[4] and [5]; src-0002 has been fetched successfully three times. **No new collection
   is required**, which matters because the next T1 is cycle 43 ([28]).
3. **Step (iii) has reach into two other issues and nobody has scoped it.** src-0002's other two
   key_claims feed `ttp-attack-mapping-reliability` and `task-dependent-reliability-framing`, and
   neither has been checked for the same unstated-gloss defect class. One cycle's work touches
   three issues.
4. **Expected movement.** Cycle 26's T4 states in terms that if a T3 adopts reading (a) and
   rewrites the candidate with its derivation stated, "this issue returns to 3 immediately and I
   would expect it to", and calls the demotion "a POINTER TO NEEDED WORK, which is what the
   weakest-link selector is for". By contrast the same T4 states that what would move
   `ioc-extraction-reliability` is "a second independent measurement of report-level IoC extraction,
   or a head-to-head" — **no such source exists in the base**, and while a T3 may add one ([29]),
   that is a gamble on a search, not a specified repair.
5. **A weaker but real point:** my own G2 this cycle just did work *on* `ioc-extraction-reliability`
   — I read the matcher whole, closed half of its cycle-21 open_question, and opened `ctr-0004`
   against it. Sending the T3 there as well would double-cover it in a single cycle.

**Recorded honestly: point 4 is a forward-looking judgement about expected score movement, which
is nowhere in `prompts/t5_select.md`. Under a different terminal tie-break — lexicographic issue
id, for instance, as [11] proposes — `attribution-confident-wrong-gap` also wins (a < i). Under
"longest-open contradiction first" `ioc-extraction-reliability` would win instead (`ctr-0001`,
18 cycles, against `ctr-0002`, 4). A human should pick one and write it into the prompt.** The
residue is in [11].

### The task written

T3 (investigate) targeting **`attribution-confident-wrong-gap`**, with all three of the issue's
current `open_questions` quoted verbatim in the instructions, `ctr-0002`'s resolution path spelled
out step by step, and the derived replacement numbers restated so the next cycle does not have to
re-derive or re-fetch them. `attempt_count: 0`.

---

## Budget

- Web fetches: **3** (raw `eval_ioc.py`; raw IoC `README.md`; rendered repository page). No web
  searches. All three served the G2; none was spent on the selection, which is derivable entirely
  from state files.
- `jq` invocations: 8 (inspection + post-edit validation of both JSON files).
- File reads: 9. Edits: 2 `Edit`, 1 heredoc append, 3 `Write`.
- Assistant turns: ~16. Comfortably inside `max_turns: 50`.
- Cheapest thing that would have improved this cycle: nothing on the research side. On the harness
  side, a terminal tie-break in `prompts/t5_select.md` would have removed the only genuinely
  discretionary decision in it.

---

## Carry-forward items

All items from `logs/cycle-026.md` reproduced **including those I could not act on**, with cycle-27
updates. Discharged items stay marked rather than deleted. **One new item: [42].**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2 candidate moved
verbatim. Still vindicated: the two halves score 3 and 3 and moved for different reasons at cycle
22. Cited again as the precedent behind [37].

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** Attach src-0007 to
`ttp-attack-mapping-reliability`. The three-team count is withdrawn: **src-0005 reports no ATT&CK
metric at all**. The issue is a two-team claim (src-0002 CTI-ATE F1 0.6388; src-0007
precision/recall), which still clears level 3. Blocker remains `open_question[1]`, the missing
human-analyst baseline, now in its **sixteenth** cycle.

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First scored cycle 19
(2), held at 2 at cycles 22 and 26. *Cycle 27: it has now **lost three consecutive selections**,
this time to tie-break **3c** (`created_cycle` 16 against 2) — a rule the prompt actually states.
See [30]; still `attempts: []`.*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 18 CYCLES.** The G3 gate is
specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under
current config). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**;
replacement text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`,
`scripts/` are outside this agent's output surface. **Until a human applies it, T4s must apply the
ceiling.** *Cycle 27: unchanged, and now with a fourth contradiction in the base — `ctr-0004`,
against `ioc-extraction-reliability`, which already carried `ctr-0001`. Two open contradictions on
one issue is a case neither reading of the gate addresses at all: subtraction would presumably
subtract twice (score −2), the ceiling reading caps once. **Nobody has specified whether the gate
is per-issue or per-contradiction.** Add that to what the human must decide. Awaiting a human,
verbatim, with [11], [30] and [41].*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6, the
paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no contradiction
opened. Needs a PDF-level check, blocked by [14]. Per-phase percentages exist ONLY as pie charts
(Figure 2); Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0,
Cohere 0) are verified exact. Not touched at cycles 25, 26 or 27. **src-0008 is now the stalest
verified source in the base (c10) and is the natural G2 target for cycle 28** — see [8].

**[6] — UPDATED cycle 25.** Unfinished search directions, open since cycle 9: citation-graph sweep
of arXiv 2506.11325; **third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines** (much more valuable since [32]); the paywalled eLLM-CTI paper (ScienceDirect
S0167739X26001482, HTTP 403, no preprint — do not retry). **Forward-citation sweeps have FAILED on
two different arXiv ids — unavailable infrastructure, not an unsearched direction.** **CTIArena is
resolved and dead for consistency/calibration purposes** (arXiv 2510.11974, fetched cycle 25;
measures neither repeat-query consistency nor calibration) — may still suit a
`ttp-attack-mapping-reliability` T1, but **never re-propose it for
`consistency-calibration-as-failure-mode`**. **SEvenLLM** (`arxiv.org/pdf/2405.03446`) uncollected
and downgraded. **AthenaBench** still has no URL. **No arXiv companion exists for src-0018.**
Unavailable: OpenReview, spiegel.de ([13]).

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT CYCLE 22; ONE STEP ADVANCED AT CYCLE 27.**
`ctr-0001`'s resolution path. **Done:** the released-code route is exhausted — recall is NOT
recoverable, but the release proves the omission was a reporting choice. **METRIC confound
ELIMINATED.** **Still open:** no head-to-head; the **CORPUS confound is completely untouched and
is the largest gap**. The SYSTEM confound gained its first paper-stated anchor at cycle 22 ([33]);
the src-0003 matching-rule limb is **closed as unanswerable from this base**. *Cycle 27: the
**src-0007 side** of the matching-rule limb, which was NOT closed, is now read — see [42] — and the
answer changes its sign. Remaining steps, cheapest first: src-0007's **TTP and rubric scorers** in
the src-0017 artefact, still unread and now with a located path (`stage3_ti_drafting/ttp/`) ([34]);
`huggingface.co/datasets/xse/CyberThreat-Eval`, still unfetched; then corpus difficulty.*

**[8] — UPDATED cycle 27. G2 COVERAGE IS NOW COMPLETE FOR EVERY SOURCE BUT ONE.** src-0004 (c4,
c12), src-0003 (c5; c22 — substance passed, provenance partial fail, [32]), src-0002 (c6; c23 —
numbers exact, interpretation failed, `ctr-0002`), src-0001 (c7; c25 — numbers and protocol exact,
interpretation failed, `ctr-0003`, and peer-reviewed after all, [39]), src-0006 (c8; c17 partial
fail [21]; re-pulled c18), src-0005 (c9, c11; c26 — full pass plus six appended key_claims),
src-0008 (c10), src-0012 (c13), src-0011 (c14), src-0007 (c15; c21 Table 4 whole), src-0009 /
src-0010 (c16), src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21 — provenance partial
fail, [31]), **src-0017 (c27 — positive on all six key claims and every stored string, but the
DOWNSTREAM characterisation of its matcher failed; `ctr-0004`)**. **Never verified: src-0018
(added c25) — it is now the only one.** *Next G2 should prefer, by never-checked status then
staleness: **src-0018** (the highest-value thing there is any route at all to the numbers locked
in its four images); then **src-0008** (c10, stalest verified, and [5] wants a check it probably
cannot get); then **src-0012** / **src-0011** (c13/c14). Not recommended next: src-0017 (c27),
src-0005 (c26), src-0001 (c25), src-0002 (c23), src-0003 (c22), src-0016 / src-0007 (c21),
src-0015 (c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25, 26 AND 27.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks every
invocation; compound/piped commands are rejected if any segment is unapproved. **No PDF text
extraction exists** — prefer `/html` always; `/abs` carries no tables **but does carry the
abstract**, which is why [38] works. `gh` is **not** approved. `awk` refused. **`sed -n` and
`cat >>` heredoc ARE approved**; a heredoc append must be its **own** call. `jq -e . <file> >
/dev/null` **is** approved, as is a compound `jq … && jq …` chain. Prefer **single-line `Edit`
anchors** — a multi-line `old_string` spanning an array-element boundary failed to match at c25.
A full-file `Write` of `scores.json` worked at c26; `scores.json` and `graph.json` are NOT
protected by validator lines 105–107, only `index.json` key_claims and the `src-*.md` files are.
*Cycle 27: all held. **`raw.githubusercontent.com` works and returns whole files** — it returned
a ~150-line Python file complete, which no arXiv `/html` fetch has ever managed for a table. **New
trap, cost me one extra edit:** inserting a new array element by anchoring on the *last two
fields* of the previous element means the previous element's closing `}` closes the NEW element,
so the new element silently loses whatever fields you did not restate. `jq -r` on the added ids
caught it immediately (`opened=null`). **Always `jq -r` the new element's own fields back, not
just `jq -e` the file** — the file parsed fine while being wrong.*

**[10] — DISCHARGED CYCLE 26, AND THE ANSWER IS THAT IT WAS NEVER ACHIEVABLE.** ~~src-0005 has
never had a number captured.~~ It now has: **Malware Analysis 23–34%** (random ~0.63%), **Threat
Intelligence Reasoning 43–53%** (random ~1.7%), both verbatim. **But the per-model numbers do not
exist in the text at all** — no results table; every per-model score is inside Figures 8, 9, 12,
13, 14, 15, 16. Confirmed by two independent fetches under [38]. **Do not re-attempt without a new
route** (published raw results, the CyberSecEval 4 repo, or OCR). See [40].

**[11] — APPLIED cycle 20, ENDORSED cycle 23, AND IT BOUND FOR THE FIRST TIME AT CYCLE 27.**
Tie-break 3a in `prompts/t5_select.md` is under-specified and there is **no deterministic
tie-break after 3c**. Cycle 20 ruled for the **strict pairwise** reading; cycle 23 endorsed it.
*Cycle 27 — the residue, for a human, in three parts:* **(a)** the four-way bottom tier reduced to
a genuine two-way tie between `ioc-extraction-reliability` and `attribution-confident-wrong-gap`,
**identical on score, penalty, dependency and `created_cycle`**, and the prompt supplied nothing
further. I broke it on an **explicitly extra-prompt** criterion (repair refuted content before
deepening thin content) and said so. Under lexicographic issue id the same issue wins; under
"longest-open contradiction first" the other one does. **A terminal tie-break must be written into
the prompt.** **(b)** A second, separate defect surfaced: the prompt lists **3a before 3b**, but 3b
is an addition *to the score*, so a literal a-then-b ordering lets 3a and 3b return **opposite
verdicts on the same pair** (they do so for `consistency` vs `attribution` this cycle). I applied
penalty-then-3a and flagged it as my reading. **The prompt should state whether the penalty
modifies the ranked quantity or is a later tie-break.** **(c)** The "within the last 5 cycles"
window has three defensible readings ({22..26}, {23..27}, `cycle − attempt ≤ 5`); they happened to
agree on every attempt this cycle, so nothing turned on it, **but that is luck and will not
recur**. Same class as [4] and [30]; anyone fixing one should fix all.

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — and this item's stronger claim
was WRONG; see [17]. T2 is the only task type with standing to split an issue, add an issue, or
reconcile the prompt/validator disagreement. The claim that the loop "never returns to T2" is
false; cycle 16 disproved it. *Cycles 25–27: bit again — the consistency/calibration split ([37])
is a T2 job and nothing else can do it, and the next T2 is reachable only via a T1, i.e. **cycle
44 at the earliest**.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
footnote-count route is also closed ([14]). Prof. Christian Dietrich's / Institut für
Internet-Sicherheit's own writeup is the only remaining route known to this agent. OpenReview
joins this category ([6]). *Load-bearing for a score since cycle 26: `ctr-0002` removed the
src-0002 quantified leg from `attribution-confident-wrong-gap` and the weight fell onto src-0004,
whose AI-causation limb is exactly the one that cannot be strengthened from here. **The cycle-28
T3 targets that issue, so it will meet this wall directly — the next task tells it not to spend
budget there.***

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here.** That leg **cannot strengthen**.
**Do not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED A THIRD
TIME.** The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated
"slop" reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from
~15% to under 5%) is an **open_question on `automated-triage-under-refusal`**. **It is a question,
not evidence — no curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22 and 26 all judged it the highest-value uncollected source in the project and cycle
27 agrees. *Cycle 27: that issue lost selection again on 3c, so the earliest route is now the
**cycle-30** T5's target, i.e. **cycle 31** — or cycle 43's T1. **Three cycles have now called it
the top target and none has been able to reach it. That is a finding about the state machine
worth putting in the paper: the selector optimises for the weakest issue, and the highest-value
uncollected evidence sits behind an issue that keeps losing tie-breaks it is not allowed to win.***

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`: an
"automated pipeline to search for vibe citations by finding and scanning public reports from major
consulting firms", releasing findings "one report at a time", having already investigated "a
government publication, two different Deloitte reports, and prestigious machine learning /
artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor reporting on its own
product's value; no *rate* published; the scorecard widget renders as "0 of N" to automated fetch
— read body text, not the widget. **Still the only route any cycle has found to a base rate**, the
binding constraint on `institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: `prompts/system.md` specifies `T1→T2`, and the refresh rule makes a T5 landing on a
multiple-of-7 cycle emit a T1, so the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles
14→15→16. Structural finding for the paper: the only task type that can restructure the issue
graph fires when a T5 coincides with a multiple of 7 — under a clean three-cycle loop, **once
every 21 cycles**, not every 7.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was opened**.
Any cycle quoting src-0011's *counts* should take them from Table 3's columns.

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLES 22 AND 26.** src-0007's Table 4 pulled
**whole and verbatim** into `state/knowledge/src-0007.md`. Triage rows: precision (Accepted)
**0.2717–0.3982**, recall (Accepted) **0.9091–1.0000**. Fine-tuning does not fix the asymmetry and
on the Article task worsens precision (GPT-4o 0.3037 → GPT-4o (FT) 0.2717). **RESIDUE, UNRESOLVED
AND REPRODUCED:** GPT-4o (FT) tracks o3-mini to within 0.001 on **all six** `Content: Threat Actor`
rubric rows, identically in two independent pulls (c15, c21) — as-printed, not a fetch artefact.
**Cause unknown; do not guess. Any claim resting on that column must say it is suspect.** *Cycle
27: the cycle-28 T3 targets `attribution-confident-wrong-gap`, whose candidate 1 rests on exactly
that table — the next task carries this warning explicitly.*

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy is **narrowed but not closed** —
33.9% is TABLE II's per-model aggregate, 16.9% → 83.2% is the SALLM-to-repository comparison;
different scopes, not arithmetically reconcilable, so **quote them only with their scopes named**.
Gemini's 0.161 → 0.721 was **not** re-checked. **Residue: src-0014's F1 figures
(0.398/0.103/0.465/0.427) are still body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a
specialized agent vs. 0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true
general-purpose peak is **G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1
range roughly 0.20–0.90" against a true span of **0.286–0.882**. Cycle 18 appended a corrective
key_claim to `index.json`; **`src-0006.md` itself is still untouched and still contains the wrong
sentence.** Column split: 8 general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0,
ZYS, LLY, CBS, SPT, DHT). **`src-0006.md` is the only known source file still carrying an
uncorrected sentence** and it is a cheap fix for any cycle touching that source. *The
repair-both-places pattern now holds for cycles 22, 23, 25, 26 and 27.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** An unexplained regularity in src-0006's Table 2:
eleven of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose
columns in exactly the printed column order**. Four are in the nine-row F1 subset
`extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements, one row matching
a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** Cause
unknown; do not speculate. **Any finding resting on src-0006's Table 2 must carry a robustness
check excluding these rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same
direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly
0.20–0.90" as evidence that reliability varies sharply by sub-task. Mean between-**model** range
within a task (0.272) and mean between-**task** range within a model (0.263) are equal to within
0.009. **This does NOT negate the supported claim** — cycles 19, 22 and 26 all tested it and all
concluded it is not a counterargument; it qualifies the implication that sub-task is the
*privileged* explanatory variable. A T2 should annotate the parent's candidate rather than
re-scope it. No contradiction entry: both facts hold simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23 AND 25–27. `jq` IS INSTALLED AND APPROVED.**
`jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r '<filter>'` reads structure
without a full-file Read. **Every cycle from 9 to 17 recorded that this agent cannot validate JSON
and must check "by construction". That advice is wrong and it is expensive** — cycle 17 made five
blind edits to a 57 KB JSON file and had its entire `state/` output reverted. **Every JSON edit
should be followed by a `jq -e` check** — *and, per [9], by a `jq -r` read-back of the specific
fields you added, because cycle 27 produced a file that parsed perfectly while missing two
required fields.* The permission layer is **not uniform** — probe once, don't infer from class.
The `Grep` **tool** works on the big JSON files where Bash `grep -n` does not. Cheapest
append-only edit pattern: **`Grep` tool → `Read` with `offset`/`limit` → `Edit` → `jq -e` →
`jq -r` read-back**. Keep `jq` path arguments inside the repo; redirecting output to `/dev/null`
is fine, passing it as a path argument is refused.

**[25] — DISCHARGED CYCLE 21.** `state/knowledge/src-0007.md` now contains the
`Content: Threat Actor` rubric block in full, verbatim, all six rows and four columns, alongside
the whole of Table 4. **The two caveats travel with it and must keep travelling:** the rubric's
**absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a
normalisation the paper never states), so **only within-table contrasts may be cited**; and the
GPT-4o (FT) column is suspect per [19].

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to stdout,
but `logs/cycle-017-transcript.txt` captures the agent's own output only, and the reverted
`state/` files were never committed. Suggested harness fix for a human: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before reverting,
and `git stash` the rejected `state/` diff rather than discarding it. Cycle 24 is the mirror-image
case and worked correctly — the transcript captured the single line `API Error: 529 Overloaded`.
The mechanism is fine for **crashes**; it is blind to **validator rejections**, which is exactly
the fix requested.

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH.** src-0015's Table 1 has a **`Reward`** column
no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61, DeepSeek 3.2 **3.45**.
**The model the paper calls best-calibrated earns the lowest reward**, and the two
highest-containment models take the two highest rewards. Bears directly on
`automated-triage-under-refusal`'s `open_questions[0]` — models versus harness. **Caveats:** the
fetched material does not state the reward's composition; n = 40 per model, no CIs; the
association is not strictly monotone. An observation about an **already-collected** source, so
**no new citation is needed**. Cycles 22 and 26 recorded it in that issue's `rationale`, but a
rationale is not the graph. **Still unentered** — and with that issue losing a third selection,
still nobody with standing to enter it.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25, 26 AND 27.** The state machine is T1→T2,
T2→T3, T3→T4, T4→T5, T5→T3. Cycle 24's T3 died before writing anything and cycle 25 re-ran it,
shifting the phase by one. Positions: **cycle 25 = T3, cycle 26 = T4, cycle 27 = T5 (this one, as
predicted), cycle 28 = T3**, and T5 thereafter lands on 30, 33, 36, 39, **42**.
`collect_refresh_every: 7`, and the refresh fires only when a T5 **runs on** a multiple-of-7 cycle
(pinned from git history: cycle 14 T5 → cycle 15 T1 collect). *Cycle 27 re-derived it from
`config.yml` and confirmed: 27 mod 7 = 6, so no T1 this cycle.* Of the multiples of 7 ahead — 28,
35, 42 — only **42** is a T5 cycle. **So the next T1 is cycle 43.** *The single most consequential
structural fact in this project: **one infrastructure failure, costing one cycle, pushed the next
collection cycle back by eight** — because the refresh rule depends on a coincidence between two
periods (3 and 7) and a one-cycle shift breaks the alignment for a full lcm.* **Re-derive rather
than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21 AND 25.** A T3 **MAY** add sources.
`prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot answer
(and if you fetch something substantial, add it properly as a source per T1 rules — it counts
toward the same `max_new_sources` budget)." Cycle 21 exercised this and added src-0017; cycle 25
exercised it and added src-0018, which broke a blocker standing since cycle 3. **Standing lesson:
read the task's own prompt file, not only the queue entry's description of it.** *Cycle 27
followed it and found the queue entry's summary of `t5_select.md` accurate — but the entry could
not have told me about the 3a/3b ordering defect, which is only visible in the prompt's own
wording. Same lesson.*

**[30] — NEW cycle 20; PREDICTION CORRECT THREE TIMES.** `automated-triage-under-refusal`, the
only issue in the graph never worked on (`attempts: []`, created cycle 16), has **lost three
consecutive selections**. **"Never attempted" is not a tie-break in `prompts/t5_select.md`**, and
cycle 19's `scores.json` rationale wrongly asserted it was. **This is a prompt change for a human,
not a reading an agent may adopt.** *Cycle 27 did not use it in either direction; the issue lost on
**3c** (`created_cycle` 16 vs 2), which is a stated rule. Note the interaction with [11]: the
non-pairwise reading of 3a would also rank it last, so **both** readings of 3a bury it — the
mechanism is `created_cycle`, and the newest issues in a graph are structurally disadvantaged
forever. Anyone fixing [11] should fix [30] at the same time, and should note that an issue's
`created_cycle` is a permanent handicap under 3c with no expiry.*

**[31] — NEW cycle 21, EXTENDED cycles 22, 23, 25, 26 AND 27. THE EXACT-STRING / VERBATIM CHECK
HAS NOW BEEN RUN ON SIX SOURCES; FIVE PRODUCED A DEFECT, ONE OF THEM IN A NEW PLACE.** (a)
**src-0016** (c21): the stored "verbatim" quotation about 80 of 161 unique-unmatched findings
**does not exist on the page** — it splices a real sentence to a table cell. (b) **src-0003**
(c22): quotations passed, stored *numbers* 76/72/86 are **figure-image-only**; [32]. (c)
**src-0002** (c23): all 25 numbers exact, but the **interpretation attached to two of them is
contradicted by the paper's own metric definition**; `ctr-0002`. (d) **src-0001** (c25): numbers
exact, protocol *stronger* than recorded, but the **calibration gloss is contradicted by the full
table** and **four of nine rows had never been collected**; `ctr-0003`. (e) **src-0005** (c26):
all three key claims and all four quotations **PASS verbatim** — but the source was stored with no
task format, no metric definition, no sample counts, no stated limitations and no numbers at all.
(f) **src-0017** (c27): **every stored string and every key claim PASSES**, and the source file's
own hedges are **correct** — but the **DOWNSTREAM PARAPHRASE** of it in an `open_question` and
three `scores.json` rationales dropped those hedges and asserted a mechanism the code contradicts;
`ctr-0004`. **The defect class is now six-way: spliced quotations, unverifiable numbers,
unsupported interpretive glosses, partial table capture, correct-but-hollow entries — and now
CORRECT SOURCE, CORRUPTED DOWNSTREAM, where the source file is clean and the corruption entered
when a later cycle paraphrased it.** *(f) is the most alarming, because checking the source cannot
catch it: **the G2 must re-read what the STATE says about the source, not only what the source
says.*** **Standing lesson, upgraded again: pull the whole file/table AND the metric definition AND
the task format AND the paper's own limitations — then check what the rest of the state claims the
source shows.** **Eleven sources have stored values or quotes that have never faced any of these
checks.**

**[32] — NEW cycle 22. src-0003's THREE BASELINE F1 VALUES ARE FIGURE-IMAGE-ONLY AND NOT
TEXT-VERIFIABLE; REPAIRED BY APPEND.** `src-0003.md` key claim 1 and `index.json` key_claims[1]
state LANCE's 97.6% beats "IoC Searcher + whitelist (76% F1), AlienVault OTX (72% F1), VirusTotal
threshold=1 (86% F1)". On `https://arxiv.org/html/2506.11325v2` the exact strings **`76` and `72`
do not occur at all**, and the only `86%` is LANCE's own per-type recall. They live only in
**Figure 6**, an image this agent cannot read. **The ordering is textually supported**, so nothing
is falsified — but **cite 76/72/86 as figure-derived and not text-verified.** Also unverifiable:
**`~0.88 F1 with Llama`**. Repaired by appending to both `index.json` and `src-0003.md`. **No
contradiction entry** — file when the source's own legible text conflicts with the stored claim;
do not file when the stored claim is merely unverifiable. *Caveat from [38]: the exact-string limb
rests on a **single fetch's ABSENT** and should be re-confirmed against a second URL form. Still
not done at cycle 27.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted
candidate set**, not on free-form extraction. Verbatim: "We assume a total of 1,789 candidate
indicators, extracted using IoC Searcher, a state-of-the-art rule-based tool"; "LANCE labeled over
99% of all extracted indicators"; Figure 9's caption "… on IoC Classification." **A difference in
task format, not only in scaffolding**, and *stated by the paper*. **Companion finding: src-0003
NEVER STATES ITS MATCHING RULE**, so that half of the cycle-21 open_question is **unanswerable
from this base**. *Cycle 27 closed the **other** half — see [42].* **A T3 on
`ioc-extraction-reliability` should carry these into `ctr-0001` and the issue's candidates; a T4
has no standing to.**

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE — WITH ONE PREMISE NOW CORRECTED.** **A within-study design holds team, corpus, models
and harness constant but does NOT hold the scoring rule constant.** A cross-sub-task score spread
is a task-difficulty fact only if the sub-tasks are scored comparably. *Cycle 27 correction: this
item has said since cycle 22 that "src-0017 shows src-0007's IoC evaluator matches by
**two-directional** substring containment". **That is wrong — it is one-directional; see [42].**
The objection itself is UNAFFECTED and if anything sharper: a one-directional matcher is lenient
toward fragments and strict against verbose output, so it is still not obviously commensurable
with any other task's scorer.* The ground truth is still never stated to be exhaustive. **The
scoring rules for src-0007's ATT&CK and rubric tasks have STILL never been pulled**, and neither
have the per-task scoring definitions behind src-0006's nine F1 rows. **What restores the 4:** read
`stage3_ti_drafting`'s TTP and rubric scorers in the src-0017 repo and src-0006's metric
definitions, then state and answer the objection in the issue. *Cycle 27 located the path —
**`stage3_ti_drafting/ttp/`** — and confirmed `raw.githubusercontent.com` returns whole files
reliably, so this is now a **one-fetch job for whoever gets there**. No rubric/judge scorer path
is named in the top-level README; that one will need directory browsing.* **Note the asymmetry:**
the same finding is neutral-to-favourable for `extraction-vs-reasoning-ordinal-axis`, whose
supported claim is *negative*.

**[35] — NEW cycle 23. src-0002's CTI-TAA `Correct` AND `Plausible` COLUMNS ARE NESTED, NOT
DISJOINT; `ctr-0002` OPENED; REPAIRED BY APPEND.** Section 4.2 verbatim: "we compute two types of
accuracy: Correct Accuracy, which is the fraction of correct answers, and Plausible Accuracy,
which is the fraction of correct and plausible answers combined." **Plausible ⊇ Correct**, so the
stored claim that the plausible rate "is far higher than" the correct rate is **true by
construction**. "Plausible" is the **underdetermined-input** case and **hallucination lives in the
separate `incorrect` category**. The string `plausible-sounding` **does not occur in the paper**.
**Derived replacements, to be labelled as derived wherever used:** plausible-but-not-correct share
= 34 / 18 / 36 / 28 / 8 pp; the paper's own incorrect (hallucination-inclusive) rate =
`100 − Plausible Accuracy` = **14% / 38% / 26% / 20% / 64%**. **All 25 stored numbers are exact.**
*Cycle 26: this item cost the issue a point (3 → 2). Cycle 27: it is the reason that issue was
selected.*

**[36] — NEW cycle 23. THE T4 HALF IS DONE; THE T3 HALF IS NOW THE CYCLE-28 TASK.** `ctr-0002`'s
resolution path, in order: **(i)** rewrite `attribution-confident-wrong-gap`'s primary candidate to
cite the derived incorrect-bucket rates (14–64%) with the derivation stated, or explicitly retire
the 86-vs-52 framing; **(ii)** decide and record which of two readings holds — **(a)** the leg
survives with a different number, or **(b)** the leg is weaker than scored, which throws more
weight onto the src-0004 ENISA leg that [13] says cannot be strengthened; **(iii)** check whether
src-0002's **other two** key_claims — feeding `ttp-attack-mapping-reliability` and
`task-dependent-reliability-framing` — carry any similar unstated interpretive gloss. *Cycle 27:
**selected this issue for the cycle-28 T3 precisely to execute (i)–(iii)**, and wrote all three
steps into the queue entry with the derived numbers restated so no re-derivation is needed. Step
(iii) remains the one nobody has scoped. **If cycle 28 does this well the issue should return to 3
and `ctr-0002` should close.***

**[37] — NEW cycle 25, ENDORSED AND STRENGTHENED cycle 26. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. consistency-on-CTI rests on **two independent sources**
(src-0001 + src-0018), calibration-on-CTI on **one** (src-0001, gpt4o only, nine rows), and
`ctr-0003` sits on the calibration half alone. **A T4 cannot split an issue and neither can a T3
([12]); only a T2 can.** The natural cut is `consistency-under-repeated-query` vs
`confidence-calibration-on-CTI`, with src-0018 and the CI-width evidence going to the first and
Table 6 plus `ctr-0003` to the second. Split, the two children would plausibly score 3 and 2.
**The next T2 is reachable only via a T1, i.e. cycle 44 at the earliest ([28]) — so this issue will
be under-expressive for seventeen more cycles.** *Cycle 27: and it just took a **+1 attempt
penalty** that pushed it out of the selection tier entirely, so it will not even be investigated in
the meantime. The penalty is doing its job as written; it is worth recording that the rule's effect
here is to defer an issue whose real problem is structural and cannot be fixed by investigating it
anyway.*

**[38] — NEW cycle 25, PAID OFF AT CYCLES 26 AND 27. A SINGLE FETCH'S "ABSENT" IS NOT EVIDENCE OF
ABSENCE.** The `/html` fetch of arXiv 2503.23175 that correctly transcribed all 54 cells of Table 6
**also reported the exact string "inconsistent and overconfident" as ABSENT**; a second fetch of
`/abs` returned it verbatim in the abstract. **Rule: a PRESENT verdict may be trusted from one
fetch; an ABSENT verdict must be confirmed against a second URL form before it is recorded as a
defect.** Cycle 26 hit the trap from the other direction — src-0005's stored quotations come from
the **abstract** while the body paraphrases two of them differently — and without [38] would have
opened a false contradiction. *Cycle 27 hit a **third** variant and the rule caught it again: the
top-level `README.md` returned three stored quotations as ABSENT, but those strings were always
attributed to the **IoC sub-README**; fetching the right file returned all five PRESENT and exact.
**Generalisation now three-way: before recording an absence, check (1) the abstract, (2) a
different URL rendering, and (3) that you fetched the file the claim actually cites.*** For code
repositories specifically, **`raw.githubusercontent.com/<owner>/<repo>/main/<path>` returns whole
files** and is strictly better than the rendered page for any string check.

**[39] — NEW cycle 25, SECOND INSTANCE cycle 26, THIRD PARTIALLY CLOSED cycle 27. PROVENANCE
LABELS IN THIS BASE WERE SET AT COLLECTION TIME AND HAVE NEVER BEEN RE-CHECKED.** src-0001 **is
peer-reviewed and published** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` — and this
base called it a preprint for 24 cycles. src-0005 goes the other way: v1 24 Sep 2025, v2 10 Nov
2025, **no venue, no DOI but the arXiv one, no affiliations printed**; an **unreviewed preprint**
whose CrowdStrike/Meta attribution rests on recognising two author names. *Cycle 27 on src-0017:
the repository badge links to **`openreview.net/forum?id=tiFtZHwr7O`** and the self-description
reads **`[TMLR '25]`** (apostrophe), against a March 2026 arXiv submission. **The inconsistency is
unchanged and unresolved — OpenReview is unreachable from this agent ([6]), so this specific
provenance question is probably permanently open here.** Recorded as printed; do not upgrade
src-0007's provenance on a badge.* Still unchecked: src-0013 ("ICSME 2026 Research Track"),
src-0014 ("v1 preprint, no stated venue"), src-0015 ("single-author preprint … no stated venue").
**Provenance staleness is a cheap, unworked check.**

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND
THIS BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "Evaluation is based on
accuracy: the share of questions for which the system selects all correct options and only the
correct options." 609 malware-analysis cases; 588 threat-intel-reasoning pairs from 45 reports,
the report supplied "via a set of images (one per report page)". Questions were **generated by
Llama 3.2 90B and Llama 4 Maverick**, then human-validated, and the paper concedes both that
multiple choice "does not provide a perfect proxy for capabilities" and that there is "performance
bias … where the model under test is the same, or has similarities with the set of models that
were used in synthetic data generation pipelines". **Three consequences.** (a) **src-0005's
percentages are not commensurable with src-0002's F1 or src-0007's precision/recall** — the third
instance of task-format non-commensurability after [33] and src-0017, strengthening [34]. (b)
**src-0005 reports no ATT&CK metric at all** ([2]). (c) **23–34% (MA) against 43–53% (TIR)** is a
within-paper cross-task spread with the scoring rule held constant — **suggestive for
`task-dependent-reliability-framing`, but NOT a controlled contrast** (different corpora, different
question-generation pipelines, different random baselines, 0.63% vs 1.7%). **Anyone using it must
state those three confounds.**

**[41] — NEW cycle 26, REINFORCED cycle 27. THE G3 CEILING BECOMES *LESS* LIKELY TO BE TESTED THE
BETTER THE LOOP WORKS, AND THAT IS AN ARGUMENT FOR A HUMAN NOT WAITING.** [4] has recorded for 18
cycles that the prompt says subtract and the validator enforces a ceiling. Cycle 26 made the reason
structural: **an honest, stingy T4 demotes issues that carry open contradictions, which moves them
*away* from the ceiling.** All three contradiction-carrying issues sit at 2 against a ceiling of 3.
The ceiling can only bind if a T4 scores a contradiction-carrying issue at 4 or 5 — i.e. only if an
issue is simultaneously *robust* and *self-contradictory*. **So the validator's G3 check is very
nearly dead code, while the prompt's subtraction rule — which every T4 has correctly refused to
apply — would fire on all three issues today and drive them to 0 without tripping anything.**
*Cycle 27: now **four** contradictions across **three** issues, with `ioc-extraction-reliability`
carrying two. Under subtraction, is that −2 or −4? **Neither the prompt nor the validator says
whether the gate is per-issue or per-contradiction**, and the ceiling reading hides the question
entirely. A human choosing a reading must answer both questions at once — see [4].*

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO; `ctr-0004`
OPENED; REPAIRED BY APPEND.** The executing code in
`stage3_ti_drafting/ioc/eval/eval_ioc.py` is `any(pred.lower() in gt.lower() for gt in gt_set)` —
**a prediction must be a SUBSTRING OF a ground-truth entry**. The two-directional and exact-match
variants are **inside triple-quoted string literals and never run**; the comment lines cycle 21
quoted are the headers above that dead code. Independently confirmed by the IoC sub-README's own
prose: "A prediction is considered a **True Positive (TP)** if `pred.lower() in gt.lower()` for
any ground truth IOC from the same source". **Consequence — the bias is ASYMMETRIC, and every
downstream use assumed one sign:** lenient toward short/fragmentary predictions that are substrings
of a longer ground truth; **strict against verbose predictions**, which score as false positives —
the characteristic free-form-LLM failure mode, and exactly the case the dead code would have
scored TP. **"Substring-permissive, inflates true positives relative to strict equality" is half
right and must not be repeated unqualified.** *Where the wrong version lives and cannot be edited
(append-only): `ioc-extraction-reliability`'s cycle-21 `open_question`, and the `scores.json`
rationales for `ttp-attack-mapping-reliability`, `task-dependent-reliability-framing` and
`extraction-vs-reasoning-ordinal-axis` (cycles 22, 26), plus [34] above, corrected in place.* **A
T3 on `ioc-extraction-reliability` should rewrite the open_question and decide whether the
asymmetry changes cycle 18's arithmetic on `ctr-0001`'s METRIC confound; a future T4 must restate
the three rationales.** **Two observation-only properties recorded with it, supporting no claim:**
ground truth is a set while predictions are a list, so duplicate correct predictions each count as
a separate TP against FN counted over the deduplicated set; and the `"[.]"` → `"[]"` normalisation
step is unreachable because both brackets are stripped first. **Still unread in that repo: the
ATT&CK/TTP scorer (`stage3_ti_drafting/ttp/`) and any drafting-rubric/judge scorer ([34]).**
