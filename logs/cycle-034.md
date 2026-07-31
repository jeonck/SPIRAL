# Cycle 034 — T5 (Select)

**Task type:** T5 select
**Queue entry executed:** `state/queue/next_task.json` (written by cycle 33)
**Phase verified before acting:** `last_completed_task.txt` read `T4 assess`; `git show --stat HEAD`
showed commit `a53a9eb` "cycle 33: T4 assess" with 9 changed files including
`state/assessments/scores.json` and `state/issues/graph.json`. Queue entry, completion marker and
commit diff all agree. Per carry-forward [50] I did not trust the commit message alone.

**Refresh rule checked at source:** `config.yml` line 17 gives `collect_refresh_every: 7`.
34 % 7 = 6 ≠ 0, so the refresh does **not** fire and the next task is a **T3**, not a T1.

---

## Task performed

I ran the selection policy in `prompts/t5_select.md`, which I read at source rather than trusting
the queue entry's account of it. The queue entry's account turned out to be **accurate** — the six
clean handoffs in a row noted at [29] is now seven — but the check is cheap and its failure mode is
expensive.

**Selected: `ioc-extraction-reliability`.** The next task is a T3 targeting that issue.

### Step 1 — candidate set

Verified at source:

```
$ jq -r '.scores|to_entries[]|"\(.key) \(.value.score)"' state/assessments/scores.json
ttp-attack-mapping-reliability 2
task-dependent-reliability-framing 2
extraction-vs-reasoning-ordinal-axis 2
attribution-confident-wrong-gap 2
ioc-extraction-reliability 2
consistency-calibration-as-failure-mode 2
institutional-incident-real-world-impact 3
automated-triage-under-refusal 2
```

All eight issues score < 5, so **all eight are candidates**. Cycle 33's handoff described the
distribution correctly: one issue at 3, **seven tied at 2**.

### Step 2 — base priority

`institutional-incident-real-world-impact` (3) is the only issue separated by score. It ranks last.
The other seven are tied and **the tie-break is therefore the entire selector**, exactly as
carry-forward [54] predicted.

### Step 3a — upstream first

Dependency edges, read from the graph:

```
$ jq -r '.issues[]|"\(.id) created=\(.created_cycle) depends_on=\(.depends_on|tostring) attempts=\(.attempts|tostring)"' state/issues/graph.json
ttp-attack-mapping-reliability            created=2   depends_on=[]                                    attempts=[16,31,32]
ioc-extraction-reliability                created=2   depends_on=[]                                    attempts=[9,21]
consistency-calibration-as-failure-mode   created=2   depends_on=[]                                    attempts=[3,15,16,25]
attribution-confident-wrong-gap           created=2   depends_on=["consistency-calibration-as-failure-mode"]  attempts=[16,28]
task-dependent-reliability-framing        created=2   depends_on=[ttp, ioc, consistency, attribution]  attempts=[6,16]
extraction-vs-reasoning-ordinal-axis      created=16  depends_on=["task-dependent-reliability-framing"] attempts=[17,18]
institutional-incident-real-world-impact  created=2   depends_on=[]                                    attempts=[12]
automated-triage-under-refusal            created=16  depends_on=[]                                    attempts=[]
```

Rule 3a is **pairwise**: "an issue that others `depend_on` outranks its dependents." Applied
literally it is a partial order, not a total one. It demotes exactly the issues that appear in some
other issue's `depends_on` list — i.e. the **dependents**:

- `attribution-confident-wrong-gap` — dependent of `consistency-calibration-as-failure-mode`
- `task-dependent-reliability-framing` — dependent of four issues
- `extraction-vs-reasoning-ordinal-axis` — dependent of `task-dependent-reliability-framing`

**Three of the seven eliminated.** Note the reading I did *not* take, and why: one could read 3a as
"an issue with no dependents is not upstream of anything, so it loses." That reading would also bury
`automated-triage-under-refusal`, which has no edges in either direction. But 3a as written only
lets an issue be outranked **by something it depends on**, and `automated-triage-under-refusal`
depends on nothing, so nothing outranks it under 3a. It survives to 3b. This is precisely the
ambiguity carry-forward [11](a)/[30] have been flagging; I record which reading I used so a
successor can audit it. **Under the other reading the outcome of this cycle is unchanged**, because
`automated-triage-under-refusal` loses at 3c anyway — see below.

Surviving after 3a: `ttp`, `ioc`, `consistency`, `automated-triage` (plus `institutional` on score).

### Step 3b — attempt penalty

`config.yml` line 40: `tie_break_recent_attempt_penalty: 1` per attempt within the last 5 cycles.
I read the window as cycles **29–33** (the five completed cycles preceding this one). Per [11](c)
this phrase has three defensible readings; **all three give the same answer here**, because the only
attempts anywhere near the window are `ttp`'s at 31 and 32, which fall inside every reading, and
`consistency`'s at 25, which falls outside every reading.

- `ttp-attack-mapping-reliability`: attempts 31 and 32 → **+2** → effective **4**
- `ioc`, `consistency`, `automated-triage`: **+0** → effective **2**

`ttp` drops out. This is the tie-break working as designed: it was worked twice in the last three
research cycles and it should not be worked a third time.

### Step 3c — older `created_cycle` first

- `ioc-extraction-reliability`: created 2
- `consistency-calibration-as-failure-mode`: created 2
- `automated-triage-under-refusal`: created **16** → **eliminated**

### Step 3d — there is no 3d. The policy is exhausted and the tie is terminal.

`ioc-extraction-reliability` and `consistency-calibration-as-failure-mode` are tied on **score,
3a, 3b and 3c simultaneously**. `prompts/t5_select.md` provides nothing further. This is the
terminal-tie hole recorded at [11](a) since cycle 20, hit for the third time (cycle 30 hit it twice).

### The full ranking table (evaluation data for the paper)

| Rank | Issue | Score | 3a tier | 3b penalty | Effective | `created_cycle` | Eliminated at |
|---:|---|---:|---|---:|---:|---:|---|
| **1** | **`ioc-extraction-reliability`** | 2 | upstream-maximal | 0 | **2** | 2 | **SELECTED** (terminal tie broken by judgement) |
| 2 | `consistency-calibration-as-failure-mode` | 2 | upstream-maximal | 0 | 2 | 2 | terminal tie, runner-up |
| 3 | `automated-triage-under-refusal` | 2 | no edges (survives 3a) | 0 | 2 | **16** | **3c** — sixth consecutive loss |
| 4 | `ttp-attack-mapping-reliability` | 2 | upstream-maximal | **+2** (c31, c32) | **4** | 2 | 3b |
| 5 | `attribution-confident-wrong-gap` | 2 | dependent (of `consistency`) | 0 | 2 | 2 | 3a |
| 6 | `task-dependent-reliability-framing` | 2 | dependent (of 4 issues) | 0 | 2 | 2 | 3a |
| 7 | `extraction-vs-reasoning-ordinal-axis` | 2 | dependent (of `task-dependent`) | 0 | 2 | 16 | 3a |
| 8 | `institutional-incident-real-world-impact` | **3** | upstream-maximal | 0 | 3 | 2 | **step 2** (base priority) |

### Breaking the terminal tie — my reasoning, stated explicitly because the reasoning *is* the decision

Cycle 33's handoff instructed me to state this openly and to say plainly if the mechanical rule
would hand the selection to an issue with no actionable job. **It does not** — the mechanical rule
put two well-stocked issues in a dead heat, so no override was needed and none was exercised. What
follows is a tie-break *within* the space the policy left undetermined, not a departure from it.

I used three discriminators, in this order, chosen to extend the *principle* of the tie-breaks
already in the prompt rather than to import a new preference:

1. **Staleness of last attempt** — the natural continuation of 3c's "older first" principle, moved
   from creation to last contact. `ioc` was last worked at **cycle 21** (13 cycles ago);
   `consistency` at **cycle 25** (9 cycles ago). → **`ioc`**.
2. **Open-contradiction load** — `ioc` carries **three** open entries (`ctr-0001` c9, `ctr-0004`
   c27, `ctr-0007` c29), the most of any issue in the graph; `consistency` carries two (`ctr-0003`,
   `ctr-0005`). Verified:
   ```
   $ jq -r '[.contradictions[]|select(.resolved_cycle==null)]|group_by(.issue_id)[]|"\(.[0].issue_id): \(length)"' state/issues/graph.json
   attribution-confident-wrong-gap: 1
   consistency-calibration-as-failure-mode: 2
   ioc-extraction-reliability: 3
   task-dependent-reliability-framing: 1
   ```
   → **`ioc`**.
3. **Actionability** — [54](b) proposed this as the tie-break the system actually needs. Both issues
   have named, costed, undone jobs, so it **does not discriminate**: `ioc` has `ctr-0004` step (i)
   + [42]'s T3 half, `ctr-0007`'s three steps + [46]'s action item, and `ctr-0001`'s unfetched
   HuggingFace step; `consistency` has `ctr-0003`'s and `ctr-0005`'s untouched resolution paths.
   → **tie**.

Two of three discriminators point to `ioc` and the third is neutral, so the decision is not
close and does not depend on which discriminator is weighted first. **`consistency-calibration-as-failure-mode`
is the strongest candidate for cycle 37's T5** and I record that here so it is not re-derived from
scratch; it is also the issue [37] wants split, which only cycle 51's T2 can do.

### The finding this cycle owes the paper: `automated-triage-under-refusal` is *permanently* starved, not merely unlucky

Carry-forward [30] has predicted this issue's loss five times and been right five times. Cycle 34 is
the sixth. But this cycle I can say something stronger than "it lost again", because the loss is now
**provable in advance** rather than observed after the fact.

The three issues that beat it are `ttp`, `ioc` and `consistency`: all `created_cycle` 2, all
upstream-maximal under 3a, all scored 2. `automated-triage-under-refusal` (`created_cycle` 16) can
only win when **all three simultaneously** carry a 3b attempt penalty. Now count the opportunities.
Under the T5→T3→T4→T5 loop, T5 fires every 3 cycles and each T5's selection produces exactly one T3
attempt 1 cycle later — so attempts land on cycles 35, 38, 41, 44, 47 … , spaced 3 apart. A 5-cycle
lookback window therefore contains **at most two** of them. At most two of the three can be
penalised at any T5; **at least one always has a clean penalty of 0 and beats `created_cycle` 16.**

The selector will rotate `ttp` → `ioc` → `consistency` → `ttp` → … indefinitely and
`automated-triage-under-refusal` is **structurally unreachable**, not merely low-priority. This is
not a scheduling delay that patience fixes.

**Caveats, stated so the claim is not over-sold.** The proof holds only while (a) those three stay
tied at 2, (b) no T1/T2 alters the graph — cycle 50 and cycle 51 are both capable of breaking it,
and (c) the loop does not fail a cycle, which perturbs the attempt spacing. Any one of those
dissolves the argument. But none of them is *scheduled to help*: cycle 50's T1 targets whatever the
cycle-49 T5 selects, which by this same argument will not be `automated-triage-under-refusal`.

**I did not override the mechanism to fix this.** Overriding would have hidden the defect behind a
one-off correction, and the issue I was steered toward (`ioc`) is the better-stocked target on
merit anyway. The honest move is to run the rule, record that it starves an issue, and hand a human
a specific fix. Filed as **[55]**, verbatim for a human, with a proposed remedy: an **aging term**
(effective score − 1 per N cycles since last attempt, with never-attempted issues aging from
`created_cycle`) which would dominate a never-expiring `created_cycle` fallback and cost one line in
`prompts/t5_select.md`. Note this is the *third* instance of the perverse-coupling shape [41] and
[54] describe: a mechanism that works less well the better the rest of the loop performs.

---

## Retrospection (G2)

**Conclusion re-checked:** the two ENISA revision-notice claims that are the entire independent
basis of `institutional-incident-real-world-impact`'s existence claim — `src-0009` and `src-0010`,
last verified at **cycle 16**, the stalest sources in the base.

**Why these:** [8] and [51] both point here by staleness, and there is a sharper reason.
`institutional-incident-real-world-impact` is now the **only issue in the graph scored above 2**, so
these two pages are the least-checked load-bearing artefacts in the project. Nothing load-bearing
was one fetch old, so [51](a)'s replication override did not apply and staleness governed.

**Method:** one fetch each, instructed per rule (i) to reproduce verbatim and to write `ABSENT`
rather than infer, and per rules (ii)/(iii) to return the revision notice, the publication date, the
served PDF filename **and its full URL path**, and every occurrence of `AI` / `artificial
intelligence` / `generative` / `LLM` / `footnote` / `typo`.

**Result: BOTH PASS CLEANLY. Every stored quotation, date and path is exact.**

| Stored claim | Re-fetch result |
|---|---|
| src-0009 notice: *"Revision Notice – Version 1.2. (09 January 2026): This publication has been updated to edit some links."* | **Exact, character for character**, including the period after `1.2` |
| src-0009 publication date October 1 2025 | **October 1, 2025** ✓ |
| src-0009 served as `ENISA Threat Landscape 2025_v1.2.pdf` from a `2026-01/` path | `…/sites/default/files/**2026-01**/ENISA%20Threat%20Landscape%202025_v1.2.pdf` ✓ |
| src-0009: no mention of AI / artificial intelligence / generative | **ABSENT** — still absent, now ~9 months after the incident became public ✓ |
| src-0009: no footnote count, no cause assigned | **ABSENT** ✓ |
| src-0010 notice: *"Revision Notice – Version 1.2 (09 January 2026): This publication has been updated to correct some broken links and typos."* | **Exact**, including the *absence* of the period after `1.2` that src-0009 has — the two notices genuinely differ in punctuation and our state records both correctly |
| src-0010 publication date November 6 2025 | **November 6, 2025** ✓ |
| src-0010: no mention of AI / artificial intelligence / generative | **ABSENT**; only `typos`, inside the notice already quoted ✓ |
| Both reports revised on the **same date**, 09 January 2026 | ✓ on both pages |

**No contradiction opened.** Per [32]'s filing test, nothing in either source's legible text
conflicts with a stored claim.

**Version-staleness bolt-on ([39]/[53]):** both pages still serve **v1.2**. No v1.3 exists. The
version axis found nothing here, which is the expected outcome and worth recording as such.

**One new observation, recorded but NOT entered into the state, because a T5 has no standing to
touch knowledge.** src-0010's PDF is served as `ENISA Public Administration TL **2024** - v1.2.pdf`
— the filename says **2024** while the page's stated publication date is **November 6 2025** and the
report is the one src-0004 places in the "published last October and November" pair. This does
**not** conflict with any stored claim (no cycle has ever recorded that filename), so under [32] it
is not a contradiction, and I did not manufacture one. But it is a loose thread on the *only* issue
in the graph above 2, and a filename is weaker evidence than a page's own date field, so I am not
asserting a defect. **Filed as [56] for whichever cycle next touches
`institutional-incident-real-world-impact`:** ask whether ENISA's Public Administration Threat
Landscape is a 2024-titled report republished in November 2025, or whether the filename is a legacy
artefact. Either answer is cheap and one of them would sharpen the incident's timeline.

**Standing tally updated:** this is the **fourteenth** source-check. Nine produced a defect; the last
**five** have been clean (src-0012 c31, src-0017's TTP scorer c32, src-0011 c33, src-0009 and
src-0010 c34). Cycle 32 called three consecutive clean checks "the first evidence that this
discipline is exhausting the backlog rather than sampling it." Five strengthens that materially —
though I note the sampling is not random: cycles 31–34 checked sources that had *already* survived
one pass, so the clean streak partly reflects **where** G2 has been pointed, not only how much
backlog is left. The remaining unchecked-since-first-pass sources are src-0013, src-0014, src-0015
and src-0016, and their provenance labels have never been checked at all.

---

## Changes made

A T5 selects; it does not score, collect, split or rewrite. I made **no changes to
`state/knowledge/`, `state/issues/graph.json` or `state/assessments/scores.json`**, and I verified
before finishing that none of those files is modified.

| File | Change |
|---|---|
| `state/queue/next_task.json` | Rewritten: **T3**, `target_issue: ioc-extraction-reliability`, `attempt_count: 0`, `cycle_created: 34`. Instructions quote the issue's six current `open_questions` in condensed form (with an explicit instruction to read them in full from the graph), and name five specific jobs — A: repair `open_questions[5]`'s false two-directional-substring claim; B: decide whether the one-directional asymmetry changes cycle 18's 0.09–0.15 recall arithmetic; C: rewrite candidate 3's false encryption-boundary sentence and relabel the figure-derived src-0008 percentages; D: record in the graph that three stale `scores.json` rationales need a T4 to restate them; E: fetch `huggingface.co/datasets/xse/CyberThreat-Eval`, the cheapest untried step on `ctr-0001`'s path and never attempted by any cycle. Validated with `jq -e` and read back with `jq -r`. |
| `state/queue/last_completed_task.txt` | `T4 assess` → `T5 select` |
| `logs/cycle-034.md` | This file |

Jobs A–D need **no fetch at all** — they are graph repairs whose evidence was already bought by
cycles 27 and 29 and never spent. That is deliberate: `ioc-extraction-reliability` is carrying three
open contradictions largely because two written resolution paths have sat unexecuted for seven and
five cycles respectively, and a cycle that discharges them costs almost nothing in budget.

---

## Next task rationale

**T3 (investigate) on `ioc-extraction-reliability`**, per the state machine T5→T3 and the refresh
rule not firing (34 % 7 = 6).

The selection is justified above. On *what the T3 should do*, three points:

1. **It is a repair cycle, not a collection cycle.** Two contradictions on this issue carry written
   resolution paths whose T3 half has never run: `ctr-0004` step (i) has waited since cycle 27,
   `ctr-0007`'s steps since cycle 29. Both are wrong-sentence-in-the-graph problems, both are fixable
   without a single fetch, and both are *known* defects sitting in the state right now — the issue's
   `open_questions[5]` still asserts a substring rule that cycle 27 proved does not execute, and its
   third candidate still asserts that encryption is the boundary of LLM IoC recovery when one of
   src-0008's five models lost two thirds of its detections to **dead-code injection**. Leaving known
   false sentences in the graph while spending the cycle on new fetches would be the wrong trade.
2. **One fetch is worth buying.** `huggingface.co/datasets/xse/CyberThreat-Eval` is named in
   `ctr-0001`'s own cycle-21 update and in [7] as the cheapest remaining step, and **no cycle has
   ever fetched it**. If src-0007's per-model IoC outputs are there, the missing recall becomes
   computable and `ctr-0001`'s METRIC confound moves from eliminated-by-argument to settled-by-number.
   If they are not, rules (v) and (x) apply before any absence is recorded — cycle 31's near-miss on
   a 1,083,078-byte CSV is the cautionary case.
3. **Job B is the intellectually live one and I have flagged it as such.** Cycle 18's arithmetic —
   that reconciling 97.6% F1 with 0.82–0.88 precision by metric artefact alone demands IoC recall of
   0.09–0.15 — assumed the matcher's bias ran one way. Cycle 27 showed it runs **both** ways
   asymmetrically. Nobody has checked whether the elimination survives. The instructions tell the T3
   to derive the answer and, if the elimination does **not** survive, to open a contradiction against
   this issue's fourth candidate rather than quietly editing it.

The T3 is also told explicitly what is **not** its job — `[47](f)`'s `threat_actor.py` re-fetch,
`[27]`'s src-0015 Reward column, `ctr-0009`'s path, `ctr-0003`/`ctr-0005`'s paths, and the
curl/HackerOne source — because those belong to other issues, and a T3 that wanders costs the loop
a cycle it cannot spare with the next T1 at 50 and the next T2 at 51.

---

## Budget

- **Fetches: 2** (both G2: the two ENISA publication pages). Zero fetches spent on selection — the
  selection is a pure state computation and should be.
- **Searches: 0.**
- **Bash calls: 7** (phase verification; `jq` over `scores.json`, `graph.json` ×3, `index.json`;
  queue validation + read-back).
- **File reads: 4** (`next_task.json`, `meta.json`, `prompts/t5_select.md`, `config.yml`, plus
  cycle 33's carry-forward section).
- **Writes: 3** (`next_task.json`, `last_completed_task.txt`, this log).
- **Turns used: ~13 of 50.** Comfortable margin; queue files were written **before** the log per
  [50], so a max-turns death here would have cost the log but not the chain.

---

## Carry-forward items

All items from `logs/cycle-033.md` reproduced **including those I cannot act on**. Discharged items
stay marked rather than deleted. **New: [55], [56]. Updated this cycle: [3], [8], [11], [30], [31],
[39], [51], [54].** Nothing was discharged this cycle — a T5 has standing to discharge almost
nothing, which is itself worth noting.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Still vindicated. Cited as the
precedent behind [37] and [45]. *Both halves of that split are now at 2, and they fell for the same
root defect — weak evidence that the split was along the right seam, since a defect in a shared
source propagated to both children rather than to one.*

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK metric
at all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in its
**twenty-third** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**, and
does NOT discharge it. [44] puts the 0.6388 itself in question. Cycle 31 sharpened it: now that the
scorer's rule is known to be exact-ID matching with no partial credit, a useful human baseline would
have to be scored under the SAME rule — and exact sub-technique assignment is a task on which two
competent analysts would themselves disagree.

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30] and now **[55]**. *It has
now lost **six** consecutive selections. Cycle 33 predicted a sixth loss was "more likely, not less";
it happened, at **3c** this time rather than 3a. **Cycle 34 upgrades the prediction to a proof: see
[55]. This issue is structurally unreachable, not merely unlucky.***

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 25 CYCLES. VERBATIM FOR A
HUMAN.** The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**),
`config.yml` line 35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156
(**ceiling**, = 3). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**;
replacement text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`,
`scripts/` are outside this agent's output surface. **Until a human applies it, T4s must apply the
ceiling.** *Under subtraction five of eight issues would read 0. The per-issue-versus-per-contradiction
question stays live on `ioc` (three open) and `consistency` (two): under subtraction, is `ioc` −2 or
−6? Awaiting a human, verbatim, with [11], [30], [41], [55].*

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is a
**self-contradiction in the source**, and our stored mapping is the **majority reading**. No
contradiction entry per [32]'s test. *Standing lesson: an item recorded as "blocked by an
infrastructure limit" may only be blocked by the route the recording cycle happened to try.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv 2506.11325;
third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines; the paywalled
eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not retry). Forward-citation sweeps
have **FAILED on two arXiv ids**. **SEvenLLM** uncollected and downgraded. **AthenaBench** still has
no URL. No arXiv companion exists for src-0018. Unavailable: OpenReview, spiegel.de ([13]).
**CTIBench's own released evaluation artefact has never been sought** — now `ttp`'s
`open_question[3]`, and the **only** route left to move `ttp` off 2, since src-0002's missing ATT&CK
correctness rule is unrepairable from src-0002 itself. *Cycles 31–34 spent nothing here.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT 22; ONE STEP AT 27; ANOTHER AT 31; **SCHEDULED AT 34**.**
`ctr-0001`'s resolution path. **Done:** released-code route exhausted; METRIC confound eliminated;
cycle 31 read the TTP scorer. **Still open:** no head-to-head; the **CORPUS confound is completely
untouched and is the largest gap**. Cheapest first: `huggingface.co/datasets/xse/CyberThreat-Eval`;
then corpus difficulty. Every code-reading step on this path is done; what remains is genuinely about
corpora. *Cycle 34 wrote the HuggingFace fetch into cycle 35's queue entry as **Job E** — the first
time this step has been scheduled rather than merely recommended.*

**[8] — UPDATED cycle 34. G2 COVERAGE COMPLETE; TRACKED BY STALENESS, NOW ALSO BY REPLICATION.**
src-0004 (c4, c12), src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 —
`ctr-0002`; c28 — `ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial fail
[21]; re-pulled c18), src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), src-0012 (c13; c31
— PASSES CLEANLY), src-0011 (c14; c33 — PASSES CLEANLY, version hazard found), src-0007 (c15; c21;
c30 — `ctr-0008`), **src-0009/src-0010 (c16; c34 — BOTH PASS CLEANLY, every quotation, date and PDF
path exact, still v1.2, AI still ABSENT on both)**, src-0013 (c18), src-0014 (c19), src-0015 (c20),
src-0016 (c21 — provenance partial fail, [31]), src-0017 (c27 — `ctr-0004`; c32 — PASSES CLEANLY),
src-0018 (c28 — `ctr-0005`). *Next G2 by staleness: **src-0013** (c18), then src-0014 (c19), then
src-0015 (c20) and src-0016 (c21). **These four are now the entire remaining backlog of
never-re-checked-twice sources, and their provenance labels have never been checked at all.** Not
recommended: src-0009/src-0010 (c34), src-0011 (c33), src-0017 (c32), src-0012 (c31), src-0007 (c30),
src-0008 (c29), src-0002/src-0018 (c28), src-0005 (c26), src-0001 (c25).* **But see [51]: staleness
is the default, not the rule.**

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25–34.** `python3` present but the
**permission layer** blocks it; compound commands rejected if any segment is unapproved. **No PDF
text extraction exists** — prefer `/html` always. `gh` not approved. `awk` refused. **`sed -n` and
`cat >>` heredoc ARE approved**; a heredoc append must be its **own** call. `jq -e . <file> >
/dev/null` approved, as is a compound `jq … && jq …` chain. **`jq --slurpfile` is REFUSED as a
dangerous flag**, so cross-file `jq` queries are impossible — run one `jq` per file and compare
outputs yourself. **Bash `grep -n`/`grep -c` ARE approved on the small files** (`index.json`,
`config.yml`); the `Grep` **tool** remains necessary on the big JSON files. Prefer **single-line
`Edit` anchors**. `scores.json` and `graph.json` are NOT protected by validator lines 105–107.
**`raw.githubusercontent.com` returns whole files.** *Cycle 34: all held. Single-quoting every
internal quotation made a 23,634-character `next_task.json` `instructions` string escape-free —
**six cycles of evidence** for that pattern.*

**[10] — DISCHARGED CYCLE 26; NEVER ACHIEVABLE.** src-0005's per-model numbers do not exist in text
— every per-model score is inside Figures 8, 9, 12–16. **Do not re-attempt without a new route.**
See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27, 30 AND **34**. VERBATIM FOR A HUMAN.**
Tie-break 3a in `prompts/t5_select.md` is under-specified and there is **no deterministic tie-break
after 3c**. In three parts: **(a)** a terminal tie **must** be written into the prompt; **(b)** the
prompt lists **3a before 3b**, but 3b is an addition *to the score*, so a literal a-then-b ordering
lets them return **opposite verdicts on the same pair**; **(c)** "within the last 5 cycles" has three
defensible readings. *Cycle 30 remains the richest data point (two terminal ties in one cycle).
**Cycle 34 hit a terminal tie for the third time** — `ioc` vs `consistency`, tied on score, 3a, 3b
**and** 3c — and had to break it by documented judgement. **Cycle 34 also resolves (c) as harmless
in practice and 3a as decisive in principle:** all three readings of the 5-cycle window gave the same
answer this cycle, but the two readings of **3a** differ on whether an issue with *no edges at all*
survives it, and that is the ambiguity burying `automated-triage-under-refusal`. I took the literal
pairwise reading (it survives 3a, loses at 3c) and recorded that the other reading changes nothing
this cycle. **(d) NEW: the prompt has no aging term — see [55].** Passed on verbatim with [4], [30],
[41], [55].*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The claim
that the loop "never returns to T2" is false; cycle 16 disproved it. *The next T2 is **cycle 51**.
[37] and [45] are both T2 jobs and both wait another seventeen cycles.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is the
upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF route is
also closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own writeup is the
only remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2 PDFs
cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level and
UNVERIFIABLE at document level here. **Do not re-spend budget.** *Cycle 34 re-confirmed the
landing-page half cleanly at both pages without touching the PDFs, so the item's boundary is exactly
where cycle 16 drew it. Caution from [5] still applies in principle; this one has had several
re-tests.*

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, DEFERRED A TENTH TIME.** The
curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports;
~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%)
is an `open_question` on `automated-triage-under-refusal`. **It is a question, not evidence — no curl
source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–34 all judge it the highest-value uncollected source. *The earliest T1 route is
**cycle 50**; a T3 targeting that issue could reach it sooner ([29]) — but per **[55]** no T3 will
ever target that issue under the current tie-break, so **this item is now blocked on a prompt change,
not on budget**. That is a stronger statement than nine previous cycles were able to make.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated pipeline to
search for vibe citations by finding and scanning public reports from major consulting firms". A T1
should chase `gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor; no *rate*
published; the scorecard widget renders as "0 of N" to automated fetch. **Still the only route any
cycle has found to a base rate**, the binding constraint on `institutional-incident-real-world-impact`
reaching 4. *Cycle 33's G2 hardened that constraint: src-0011's per-paper unit is confirmed
**verbatim**, so the "adjacent-population audit is not a CTI base rate" ruling rests on the paper's own
sentence rather than on our inference. **Cycle 34's G2 confirms the other leg is solid too** — the
ENISA existence claim is exact at both pages — so this issue's 3 is well-founded and its ceiling is
purely the missing base rate.*

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the escape
to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural finding for
the paper: the only task type that can restructure the issue graph fires when a T5 coincides with a
multiple of 7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18] — DISCHARGED CYCLE 33 AS *CONFIRMED*, AND THE STATE'S ACCOUNT WAS RIGHT.** src-0011 contradicts
itself in prose vs table: body text "*NeurIPS exhibiting the highest absolute count (**391 papers**)*"
against a table row giving **Invalid = 391, Papers = 308**. **Re-fetched at cycle 33 and reproduced
verbatim from BOTH v1 and v2**, so it is durable and not a rendering artefact. No claim in our base
repeats the error; **no G3 entry was opened**, consistent with cycles 12 and 29. **Quote src-0011's
*counts* from the table's columns, never from that sentence.** *Self-contradicting sources in this base:
src-0011 (prose vs table, and a 738-vs-739 arithmetic slip, [53]), src-0002 (Micro-F1 text vs Macro-F1
header, [44]), src-0008 twice (phase labels [5]; metric definitions [46]), src-0007 (rubric dimension
defined twice, [47]), src-0017 (docstring/README vs live code). **Five sources, eight instances.***

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4 pulled
**whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall (Accepted)
**0.9091–1.0000**. The rubric rows are **no longer single-pull** — a third pull returned all 34 rows
identical. **THE ANOMALY ITSELF IS UNRESOLVED AND REPRODUCED THREE TIMES:** GPT-4o (FT) tracks o3-mini
to within 0.001 on **all six** `Content: Threat Actor` rubric rows, identically at c15, c21 and c30, on
two URL forms. **As-printed, cause unknown, DO NOT GUESS.**

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014 (c19),
src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy **narrowed but not closed** — quote 33.9% and
16.9%→83.2% only with their scopes named. Gemini's 0.161 → 0.721 was **not** re-checked. **Residue:
src-0014's F1 figures (0.398/0.103/0.465/0.427) are still body-sentence-only.** *These four are now the
whole G2 backlog ([8]); cycle 35's G2 should start with src-0013.*

**[21] — CONFIRMED AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688 for a general model".
**ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5 at 0.677**. Direction
survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a true span of
**0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md` is still
untouched and still carries the wrong sentence — the only known source file still carrying an
uncorrected sentence, and a cheap fix.** *`ctr-0009` step (iii) sends a T3 to src-0006 anyway, so that
cycle should fix this in the same visit. **Cycle 34 also flagged it to cycle 35 as a conditional
bolt-on — fix it only if visiting src-0006 anyway, do not detour.***

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are
**strictly monotone decreasing across all eight general-purpose columns in exactly the printed column
order**; four are in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends on. One row
matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** **Any
finding resting on that table must carry a robustness check excluding those rows** (cycle 18's: drop all
four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.** Mean between-**model** range within a
task (0.272) and mean between-**task** range within a model (0.263) are equal to within 0.009. This does
**NOT** negate `task-dependent-reliability-framing`'s supported claim — cycles 19, 22, 26, 29 and 33 all
tested it — it qualifies the implication that sub-task is the *privileged* explanatory variable. A T2
should annotate rather than re-scope. No contradiction: both facts hold.

**[24] — NEW cycle 18, USED THROUGHOUT 19–23 AND 25–34. `jq` IS INSTALLED AND APPROVED.** **Every cycle
from 9 to 17 recorded that this agent cannot validate JSON and must check "by construction". That advice
is wrong and expensive** — cycle 17 lost its entire `state/` output. **Every JSON edit should be followed
by `jq -e`** *and* a `jq -r` read-back of the fields added. The permission layer is **not uniform** —
probe once. The `Grep` **tool** works on the big JSON files where Bash `grep -n` does not. Cheapest
append-only pattern: **`grep`/`Grep` → `Read` with `offset`/`limit` → `Edit` → `jq -e` → `jq -r`
read-back.** *`--slurpfile` is refused, so the read-back cannot cross files; verify cross-file invariants
(score keys ↔ issue ids, evidence ids ↔ index ids) by printing both lists and comparing yourself.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the `Content:
Threat Actor` rubric block in full, and the two caveats keep travelling: the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a normalisation the paper never
states, **re-confirmed ABSENT at c30**), so **only within-table contrasts may be cited**; and the GPT-4o
(FT) column is suspect per [19]. **CYCLE 30 REOPENED IT:** having the rubric block's *values* is not
having its *definition*. **A third caveat is required: `Attribution` means SOURCE LINKING in the Threat
Actor block and ACTOR IDENTIFICATION in the Root Cause block, so cross-block contrasts are NOT
automatically safe either.** See [47]. *Standing lesson: "the table is captured verbatim" and "the metric
is understood" are different claims. Cycle 33 priced that lesson at two full points across two issues.*

**[26] — NEW cycle 18, a question about the harness. PARTLY ACTED ON BY A HUMAN AT CYCLE 33.** **Why
cycle 17 failed validation is unknown and unrecoverable.** Suggested fix: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before reverting, and
`git stash` the rejected `state/` diff. *Commit `956a36c` (a human) fixed the **agent-death** half —
`run_cycle.sh` ran under `set -e`, so a non-zero `claude -p` exit aborted before `validate_state.py`,
skipping the gates and the revert together; deaths now route through the same rollback as gate rejections
(exit 3 vs 2). **The logging half is still undone**: a rejected diff is still discarded without its
validator output being preserved.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER FOURTEEN CYCLES.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61,
DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward.** Bears on
`automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward composition unstated; n=40 per
model, no CIs; association not strictly monotone. An observation about an **already-collected** source, so
**no new citation is needed**. Cycles 22, 26, 29, 30, 33 recorded it in a rationale or log, but **a
rationale is not the graph.** *Cycle 34: still unentered, and **[55] explains why it will stay that way** —
the only issue with standing to enter it is the one the tie-break cannot select. Cycle 34's queue entry
explicitly tells cycle 35 **not** to enter it, since it is not that cycle's target issue.*

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–34.** The state machine is T1→T2, T2→T3, T3→T4, T4→T5,
T5→T3. **Positions: cycle 34 = T5 (this one), 35 = T3, 36 = T4**, T5 thereafter on 37, 40, 43, 46, **49**.
The refresh fires only when a T5 **runs on** a multiple of 7; 49 is both, so **the next T1 is cycle 50 and
the next T2 is cycle 51.** *Cycle 34 re-derived this from `config.yml` independently and it matches cycles
32 and 33.* **THE HEADLINE: cycle 24's crash pushed collection back eight cycles, and cycle 31's max-turns
death pushed it back another seven. Two partial failures have cost fifteen cycles of collection and
restructuring capacity** — and the live consequence is that **no new source can enter via T1 until cycle
50** and **no issue can be split until cycle 51**, while three issues are held at 2 by bundling problems
only a T2 can fix. **Re-derive rather than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25, 30–34.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018, breaking a blocker
standing since cycle 3. **Standing lesson: read the task's own prompt file, not only the queue entry's
description of it.** *Cycle 34 read `prompts/t5_select.md` and `config.yml` at source and found the handoff
accurate — **seven clean handoffs in a row** after five bad ones. The check stays: it is cheap and its
failure mode is expensive. **This is also now the only affordance that can add a source before cycle 50**,
and cycle 34 used it to schedule Job E.*

**[30] — NEW cycle 20; PREDICTION CORRECT SIX TIMES; **UPGRADED TO A PROOF AT CYCLE 34, SEE [55]**.
VERBATIM FOR A HUMAN.** `automated-triage-under-refusal`, the only issue never worked on (`attempts: []`,
created cycle 16), has **lost six consecutive selections**. **"Never attempted" is not a tie-break in
`prompts/t5_select.md`**, and cycle 19's rationale wrongly asserted it was. **This is a prompt change for a
human.** Note the interaction with [11]: under one reading of 3a it is eliminated outright for having no
dependents; under the literal pairwise reading it survives 3a and dies at `created_cycle`, so **the newest
issues in a graph are structurally disadvantaged forever, with no expiry**. *Cycle 34 took the literal
reading, so the loss is attributable to **3c** specifically. It sits at 2, holds the project's top
uncollected source ([15]) and an unentered observation bearing on its own central question ([27], now
fourteen cycles old). With seven issues tied at 2 ([54]), `created_cycle` is now doing almost all the
selecting in this project.*

**[31] — NEW cycle 21, EXTENDED 22, 23, 25–34. THE VERBATIM CHECK HAS NOW RUN ON **FOURTEEN**
SOURCE-CHECKS; NINE PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation **does not
exist on the page**. (b) **src-0003** (c22): quotations passed, stored *numbers* 76/72/86 are
**figure-image-only**. (c) **src-0002** (c23): all 25 numbers exact, **interpretation contradicted by the
paper's own metric definition**; `ctr-0002`. (d) **src-0001** (c25): numbers exact, **calibration gloss
contradicted by the full table**; `ctr-0003`. (e) **src-0005** (c26): all claims **PASS** — but stored with
no task format, metric definition, sample counts, limitations or numbers. (f) **src-0017** (c27): every
stored string **PASSES**, the **DOWNSTREAM PARAPHRASE** dropped the hedges; `ctr-0004`. (g) **src-0018**
(c28): every quotation **PASSES** — the stored **SCOPE** is wrong by being **TOO RESTRICTIVE**; `ctr-0005`.
(h) **src-0002 again** (c28): two more glosses, one **FALSE against the printed table**; `ctr-0006`. (i)
**src-0008** (c29): quotations and numbers **PASS**, one claim **OVER-GENERAL**; `ctr-0007`. (j)
**src-0007** (c30): all 34 rows PASS, **THE METRIC IS DEFINED TWICE UNDER ONE NAME**; `ctr-0008`. (k)
**src-0012** (c31): PASSES CLEANLY. (l) **src-0017's TTP scorer** (c32): PASSES CLEANLY, plus one
strengthening addition. (m) **src-0011** (c33): PASSES CLEANLY. **(n) src-0009 + src-0010 (c34): PASS
CLEANLY — both revision notices exact to the character (including a real punctuation difference between
them that our state records correctly), both publication dates exact, both PDF paths exact, AI still ABSENT
on both, both still v1.2.** **The defect class is nine-way** — spliced quotations, unverifiable numbers,
unsupported interpretive glosses, partial table capture, correct-but-hollow entries,
correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity. *Standing
lesson: **verifying a value does not verify what the value measures.*** **Cycle 34's addendum: FIVE
consecutive clean checks. That is a real result and should be reported as one — but with a caveat cycles
32 and 33 did not state: cycles 31–34 all checked sources that had already survived one pass, so the streak
partly reflects WHERE G2 has been pointed, not only how much backlog remains. The genuinely untested
material is src-0013/14/15/16's second pass and every provenance label.**

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1 values are
figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not text-verified.** Also
unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction when the source's own legible text
conflicts with the stored claim; do not file when the stored claim is merely unverifiable.** *Cycle 33
applied it twice and got opposite answers, correctly. **Cycle 34 applied it once and it correctly said
DO NOT FILE**: src-0010's PDF filename says "2024" against a stated publication date of November 2025, but
no stored claim records that filename, so nothing conflicts. Recorded as an open question ([56]) instead of
a contradiction. The test now has four uses and has discriminated correctly every time; it should be
written into `prompts/system.md` by a human.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.** src-0003's
97.6% is measured on a **closed-set classification task over a regex-extracted candidate set**, not
free-form extraction — *"We assume a total of 1,789 candidate indicators, extracted using IoC Searcher"*;
Figure 9's caption "… on IoC Classification." **A difference in task format, stated by the paper.**
**Companion finding: src-0003 NEVER STATES ITS MATCHING RULE.** *Sources with an unstated scoring rule:
src-0003 (IoC matching) and src-0002 (ATT&CK correctness). **src-0002's is unrepairable from src-0002** and
is now the binding constraint on `ttp` ([6]). Cycle 34's queue entry tells cycle 35 explicitly **not** to
re-buy src-0003's matching rule.*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3. HALF DISCHARGED AT CYCLE
31; PRICING INSTRUCTION DISCHARGED AT CYCLE 33.** **A within-study design holds team, corpus, models and
harness constant but does NOT hold the scoring rule constant.** Cycle 31 executed the fetch this item
demanded and the answer is the **worst case for the objection's target**: src-0007's IoC and ATT&CK
sub-tasks are scored by **different kinds of rule**, so the within-study comparison is **refuted, not
rescued**. *The sharpest form, and the version successors should carry: **the sign of the confound is known
and it points the same way as the finding — the leniently scored sub-task is the one that scores high. A
cross-sub-task spread is no longer merely unproven; it is actively explicable by the scoring rules
alone.*** Known non-commensurable instances: src-0017/`ctr-0004`, src-0003, src-0005, src-0002/`ctr-0006`,
src-0007's rubric against itself ([47]), src-0007's IoC rule against its own ATT&CK rule, and src-0008's
body against its Table 6 caption ([46]). **Seven.** **STILL OPEN AND NOW THE PROJECT'S LARGEST UNTESTED
LOAD-BEARING ASSUMPTION: src-0006's per-task metric definitions have never been pulled** — `ctr-0009` step
(iii). *Cycle 34 note: this fetch belongs to `task-dependent-reliability-framing`, which lost at **3a** as
a dependent. It is not reachable until that issue is selected, and cycle 37's likely target is
`consistency`. **This is the second high-value fetch now blocked by the tie-break rather than by budget**
(the first is [15]).*

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible` columns are
**nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements (incorrect = 100 −
Plausible = **14 / 38 / 26 / 20 / 64%**) are in the graph **with their derivation stated**; `ctr-0002`
CLOSED.

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all three steps
executed. **The consequences did not stay inside the issue: see `ctr-0006` and [44].** *The G2 staleness
heuristic and the scoring rationales work as a pipeline: `ctr-0002` → cycle 29's provenance flag → cycle
30's G2 choice → `ctr-0008` → cycle 33's two demotions. **Closing a contradiction should itself schedule a
replication** (cycle 32). **A finding's effect on the scores can lag its discovery by several cycles, and
nothing in the loop tracks that debt except carry-forward.** Cycle 34 adds the extreme case: `ctr-0004`'s
T3 half has waited **seven** cycles and `ctr-0007`'s **five**, both for want of a selection — the lag is
now bounded by the selector, not by attention.*

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28–30, 33, **34**. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent sources** (src-0001 +
src-0018, **both at temperature 0**), calibration-on-CTI on **one** (src-0001, gpt4o only), and `ctr-0003`
sits on the calibration half alone. Natural cut: `consistency-under-repeated-query` vs
`confidence-calibration-on-CTI`. **Only a T2 can split an issue** ([12]); **next T2 is cycle 51.** Split,
the consistency child would plausibly score 3 and the calibration child 2; unsplit, the weaker leg governs.
*Seventeen more cycles of under-expressiveness — one of **three** issues in that position. **Cycle 34 note:
this issue is the runner-up in the terminal tie and the likeliest cycle-37 target**, so a T3 may reach its
contradictions well before a T2 can split it.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AT 30, 31 AND 33. A SINGLE FETCH'S "ABSENT" IS NOT
EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT verdict must be
confirmed against a second URL form.** Before recording an absence check **(1)** the abstract, **(2)** a
different URL rendering, **(3)** that you fetched the file the claim actually cites, **(4)** that the
**VERSION** you fetched contains the material at all (src-0002 v2 has no CTI-ATE task). **The rule also
applies to a PARAPHRASED verdict: a summarised PRESENT is as untrustworthy as a bare ABSENT.** *Cycle 31
found the rule's limit: **both** URL forms of `TTP_Mapping.csv` failed the same way for the same reason.
See [49]. Cycle 32 added that a verdict about which of two competing texts EXECUTES is not a PRESENT verdict
at all. Cycle 33 added a fourth refinement from the 738-vs-739 slip: when two fetched numbers conflict by
one digit, ask whether EACH SIDE IS INTERNALLY CONSISTENT before suspecting the fetch.* **Cycle 34 note:
the two ENISA ABSENT verdicts on "AI" are now confirmed at **two independent pages** three cycles apart
(c16, c34) rather than at two URL forms of one page — a stronger confirmation than the rule demands, and
the reason that absence can be stated flatly.**

**[39] — NEW cycle 25, EXTENDED 26–29; THE VERSION AXIS PAID OFF AT CYCLE 33.** Provenance labels in this
base were set at collection time and are mostly still unchecked. src-0001 **is peer-reviewed** — ARES 2025,
Springer, DOI `10.1007/978-3-032-00627-1_17` — and this base called it a preprint for 24 cycles. src-0005
goes the other way: **an unreviewed preprint**. src-0017's `[TMLR '25]` badge against a March 2026 arXiv
submission is **unresolved and probably permanently so**. Still unchecked: src-0013 ("ICSME 2026 Research
Track"), src-0014 ("v1 preprint, no stated venue"), src-0015 ("single-author preprint"). *Version checks
run: src-0008 (c29), src-0011 (c33), **src-0009/src-0010 (c34 — both still v1.2, no new revision)**. **The
src-0011 check cost ONE fetch of the `/abs` page and found an unnoticed v2 that had RENUMBERED THE TABLES —
see [53]. This axis is now proven, not speculative; run it on every arXiv source you touch.** No claim is
made about src-0007's version count — **cycle 34 wrote that check into cycle 35's queue entry as a
bolt-on.***

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND THIS BASE
CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of questions for which the
system selects all correct options and only the correct options." Questions **generated by Llama 3.2 90B and
Llama 4 Maverick**; the paper concedes "performance bias … where the model under test is the same, or has
similarities with the set of models that were used in synthetic data generation pipelines". **(a)** Its
percentages are not commensurable with src-0002's F1 or src-0007's precision/recall. **(b)** It reports **no
ATT&CK metric at all**. **(c)** 23–34% (MA) against 43–53% (TIR) is **NOT a controlled contrast**. **Anyone
using it must state those three confounds.** *Family resemblance to [47]: **two of eighteen sources have an
evaluator/evaluatee entanglement, and neither was recorded at collection time.***

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30, 32, 33 AND **34**. THE G3
CEILING BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS. VERBATIM FOR A HUMAN.** An honest,
stingy T4 demotes issues carrying open contradictions, which moves them *away* from the ceiling. **So the
validator's G3 check is very nearly dead code, while the prompt's subtraction rule — which every T4 has
correctly refused to apply — would fire on five of eight issues today and drive them toward 0 without
tripping anything.** Shapes documented so far: **(1) undermining** (`ctr-0001`); **(2) strengthening** — a
contradiction whose content improves the issue must not be scored as a demotion (`ctr-0005`, cycle 29);
**(3) two-directional** (`ctr-0007`); **(4) support-relocating** (`ctr-0008`, cycle 30); **(5) closes without
the underlying source defect being repaired** (`ctr-0006`, cycle 32); **(6) damages issues OTHER than the one
it is filed against** ([52], cycle 33). **Six shapes, one binary gate.** *The dead-code observation holds for
a sixth cycle: today the ceiling binds on **zero** of the four contradicted issues. **Cycle 34 adds the
generalisation: this is now the THIRD instance of a mechanism that degrades as the rest of the loop improves
— the G3 ceiling ([41]), the weakest-link selector under compressive scoring ([54]), and the starvation
proof ([55]). Whoever designs the successor system should treat "does this mechanism get worse when the
agent gets better?" as a standing design question, not three separate bugs.** Passed on verbatim with [4],
[11], [30], [55].*

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO; `ctr-0004` OPENED;
REPAIRED BY APPEND.** The executing code is `any(pred.lower() in gt.lower() for gt in gt_set)` — **a
prediction must be a SUBSTRING OF a ground-truth entry**. The two-directional and exact-match variants are
**inside triple-quoted string literals and never run**. **The bias is ASYMMETRIC:** lenient toward
short/fragmentary predictions, **strict against verbose predictions**, which is the characteristic
free-form-LLM failure mode. **"Substring-permissive, inflates true positives" is half right and must not be
repeated unqualified.** The T4 half was discharged at cycle 29. *With the ATT&CK rule now known too, **the
IoC leg is established as the LENIENT one of the pair**, so any future cycle presenting src-0007's 0.82–0.88
IoC precision as evidence that IoC extraction is "solved" relative to other sub-tasks is making the
comparison `ctr-0009` was opened over.* **THE T3 HALF IS FINALLY SCHEDULED: cycle 34 wrote it into cycle
35's queue entry as Jobs A and B — repair `open_questions[5]`, then decide whether the asymmetry changes
cycle 18's 0.09–0.15 recall arithmetic. Seven cycles of waiting; not discharged until cycle 35 runs.**

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005` OPENED;
REPAIRED BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images — **confirmed a third
time, and that ban stands.** But the page states in plain text: a **41 min/report human-analyst baseline**
against ~**3.3 min**; **17 metrics each a ratio 0–1**; and, most importantly, **"the LLM temperature
parameter was set to 0"**. **The temperature-0 fact strengthens `consistency-calibration-as-failure-mode`**
and was fenced off for three cycles by an over-broad hedge. **Standing lesson: a hedge is a claim and must be
scoped as precisely as an assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED AGAINST
`ttp-attack-mapping-reliability`; CLOSED AT CYCLE 31.** **(a)** Section 4.2 says *"We adopt the **Micro-F1**
score…"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's metric is ambiguous by the paper's own
text.** **(b)** The cross-task difficulty comparison was **ours** and subtracts multi-class **accuracy** from
multi-label **F1**. **(c)** key_claims[2] is **FALSE against Table 1**. **(d)** The **ATT&CK correctness rule
is never stated**. **(e) arXiv v2 has NO CTI-ATE task at all** — always fetch v3 or the latest render. *Cycle
31 executed all three resolution steps and closed the entry, adding that the ordering fails **even naively**
(CTI-TAA `Correct` = 52 < 63.88). **(a) and (d) are NOT repaired and cannot be from this paper** — they travel
as permanent qualifiers inside the candidate. Cycle 33 priced the result: `ttp` HELD at 2 rather than
recovering to 3, because closing the contradiction repaired only ONE of the two comparands.*

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29 AND AGAIN BY 33.** `attribution-confident-wrong-gap`
**bundles a well-evidenced question with an unevidenced one, and only a T2 can fix it.** The **error-rate**
half is well grounded (src-0002's derived 14–64% incorrect bucket on 50 alias-tolerant real reports). The
**confidence** half has **no evidence at all** — no source in this base measures expressed confidence on
threat-actor attribution. Natural cut: `attribution-error-rate` vs `attribution-confidence-calibration`, the
second probably merging into whatever [37] produces. **Next T2 is cycle 51.** *Successors must not quote the
corroborating parenthesis unqualified: **the "within-table rubric contrast" as stated differences two
different metric definitions** ([47]). The direction survives at **block** level only.*

**[46] — NEW cycle 29. src-0008 CONTAINS TWO SELF-CONTRADICTIONS AND ITS PER-PHASE NUMBERS ARE IMAGE-LOCKED;
`ctr-0007` OPENED; REPAIRED BY APPEND IN BOTH PLACES.** **(a) THE STORED CLAIM IS OVER-GENERAL.** *"Cohere,
however, shows progressive degradation: 1% missed detections in P1, 2% in P2, 5% in P3, and in P4, 65% misses
plus 35% explicit 'Don't Know' responses"* — and **P1–P4 contain no cryptography**. So plain-text IoC recovery
is **not** near-free "for current LLMs", and **encryption is not the boundary**. The finding **cuts both ways**
and cycle 29 asserted neither direction. **(b) IT DEFINES ITS METRICS TWICE, INCOMPATIBLY.** **(c) PHASE
LABELS** — see [5]. **(d) PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so the stored percentages are
**figure-derived**. **(e) TABLE 6 IS READABLE AND WAS NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 / 35 / 22.8%,
aggregates over all thirteen phases, **never per-phase**. **(f) PASSED:** Table 7 and the abstract. **THE
ACTION IS FINALLY SCHEDULED: cycle 34 wrote it into cycle 35's queue entry as Job C — rewrite the third
candidate_resolution to state Cohere's P1–P4 degradation, DECIDE explicitly whether model-side variance under
syntactic noise supports or undercuts the scaffolding hypothesis, and relabel the figure-derived percentages.
Five cycles of waiting; not discharged until cycle 35 runs.**

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME; THE JUDGE IS A
MODEL UNDER TEST; `ctr-0008` OPENED. (d) DISCHARGED AT CYCLE 33.** **(a)** Appendix C.2 prints separate
criteria blocks. **Threat Actor**: *"Attribution: 1: Information is unverified or unattributed. … 5: Fully
attributable; all details are clearly linked to the original article."* — **source linking**. **Root Cause**:
*"… 5: Perfect attribution; clearly identifies the threat actor."* — **actor identification.** **The labels run
OPPOSITE to how the state read them.** **(b) WHAT SURVIVES:** the **block-level** contrast — GPT-4o lower on
**all six** dimensions (1.547 / 1.528 / 1.145 / 2.019 / 1.734 / 1.140 vs 3.686 / 3.458 / 3.362 / 3.932 / 3.753
/ 3.612). **(c) THE JUDGE IS GPT-4o**, one of the four scored models; in the source's favour, *"an agreement
rate … exceeding 95%"*. **Direction cuts against the easy reading**: self-preference would inflate GPT-4o's own
scores, and GPT-4o scores **lowest**. **Any citation of the GPT-4o-vs-o3-mini gap must state that GPT-4o was
the judge.** **(d) — DISCHARGED CYCLE 33.** The three affected candidates were priced:
`task-dependent-reliability-framing` **3 → 2**, `extraction-vs-reasoning-ordinal-axis` **3 → 2**, and
`attribution-confident-wrong-gap` **held at 2**. **(e)** The third candidate's stated reason for being
`proposed` is discharged ([19]), so a T3 must decide its status on metric-definition ground. **(f) ACTION,
STILL OPEN AND NOT MINE:** cycle 31 confirmed the code side — `eval/root_cause.py`'s live `sys_prompt` anchors
are **unambiguously actor identification**, and **no judge model is hardcoded** (`--model` required, no
default), so Appendix C.2's "using GPT-4o" describes how the authors **ran** the harness, not the released code.
**`eval/threat_actor.py` was NOT obtained verbatim** — the fetch returned a summary, which under rule (ix) is as
untrustworthy as a bare ABSENT. **Re-fetching it verbatim is step 1 of `ctr-0008`'s repair and remains a job for
a T3 targeting `attribution-confident-wrong-gap`.** *Cycle 34: that issue lost at **3a** as a dependent of
`consistency`, so this step is deferred again. Passed on undone.*

**[48] — FORMALISED AT CYCLE 32. A PROVENANCE GRANULARITY SPLIT IN src-0012.** `src-0012.md` carries the
corroborating Going Concern URL in full, but `index.json`'s `key_claims[3]` names the outlet **without its
URL** and `key_claims[0]` attributes the study's **2025** date **with no outlet at all** — so a reader working
only from `index.json` can resolve neither. The `consulting.ca` headline URL states **no year for the EY study
anywhere**; the year **is** supported verbatim by Going Concern: *"the 2025 EY Canada report titled 'Points of
Attack…'"*. **This is a granularity weakness, not a fabrication.** No contradiction warranted. **Cheap fix for
any future cycle touching src-0012: append the outlet and URL to the two `index.json` key_claims.**

**[49] — FORMALISED AT CYCLE 32 FROM CYCLE 31's NEAR-MISS. A BYTE-SIZE CHECK FROM THE HOSTING API MUST PRECEDE
ANY ABSENT VERDICT OVER A LARGE FILE.** Cycle 31 fetched `data/TTP_Mapping.csv` twice and got 57 lines / 59
TechniqueIDs with four ABSENT verdicts. **Taken at face value that is a devastating finding. It is false.** The
GitHub contents API reports the file at **1,083,078 bytes**. Both readings were **truncation artefacts**; the
ABSENT verdicts are **void**. **This is the limit of [38]: it says confirm an absence at a second URL form, and
does not warn that both forms can fail the same way for the same reason.** *Pattern: **when a file is known to
truncate, ask only what its head can answer** — and say so. **Cycle 34 wrote this rule explicitly into cycle
35's Job E**, since a HuggingFace dataset repo is exactly the shape of thing that truncates.*

**[50] — NEW cycle 32; HARNESS HALF FIXED BY A HUMAN AT CYCLE 33.** A cycle can land its research, fail its
bookkeeping, and be committed as "run failed, no state change". Cycle 31 exhausted `max_turns: 50` after
committing four state files but before writing its last three log sections, **any carry-forward section**, or
either queue file, and `git log` describes it as **"run failed, no state change"** — **wrong on both counts**.
**THREE THINGS FOR A HUMAN. (1)** The commit message should be derived from `git diff --stat` on `state/`, not
from the CLI's exit status. **(2)** Writing the queue and `last_completed_task.txt` **before** the log would fail
safe. **(3)** A cycle that hits `max_turns` should be retried as the SAME task. *(3) is now fixed — commit
`956a36c` routes an agent death through the same rollback as a gate rejection, and both count an attempt so a
too-large task escapes after `max_task_attempts`. **(1) and (2) remain undone**, and (1) is the one that misleads
successors.* **FOR SUCCESSORS: verify the phase from `next_task.json` AND `last_completed_task.txt` AND `git show
--stat`, and disbelieve the commit message.** *Cycle 34 did this (all three agreed, `HEAD` was cycle 33's own
commit) and **voluntarily adopted (2)**, writing both queue files before the log. That cost nothing and is now
recommended practice regardless of turn pressure.*

**[51] — NEW cycle 32. TWO REFINEMENTS TO THE G2 MECHANISM.** **(a) SELECT BY REPLICATION COUNT, NOT ONLY BY
STALENESS, WHEN SOMETHING LOAD-BEARING IS ONE FETCH OLD.** Closing a contradiction should itself schedule a
replication of whatever closed it — extends [36]'s pipeline. **(b) "WHICH TEXT EXECUTES" IS NOT A PRESENT VERDICT
AND CANNOT BE TRUSTED FROM A STRING MATCH.** Where a docstring and a live branch describe **different** rules,
both are PRESENT and exact-string checks settle nothing; the question must be asked separately and explicitly.
**`ctr-0004` and the cycle-31 finding are the two known instances of documentation-vs-execution divergence;
assume more.** **(c) A COROLLARY ON WHERE TO LOOK FOR DEFECTS:** `index.json`'s `src-0017` entry records five
findings cycle 31's own log never mentions. Rule (vi) warns the state may misdescribe a clean source; **the
converse also holds — a log may under-describe a rich state — so read the STATE before re-deriving anything from a
log.** *Cycle 33 used (a) in reverse and it worked. **Cycle 34 added a third selection criterion that should be
written down: SELECT BY WHAT THE SCORE DISTRIBUTION DEPENDS ON.** src-0009/src-0010 were both the stalest sources
**and** the sole independent basis of the only issue scored above 2 — the two criteria agreed, but the second is
the one that made the choice obviously right, and it generalises: **when one issue stands alone at the top of the
graph, its evidence is the least-checked load-bearing thing in the project by definition.***

**[52] — NEW cycle 33. A CONTRADICTION ENTRY CARRIES EXACTLY ONE `issue_id`, BUT ITS CONTENT CAN DAMAGE SEVERAL
ISSUES — AND THE GATE SEES ONLY ONE OF THEM. A SIXTH SHAPE FOR [41]; FOR A HUMAN.** `ctr-0008` is filed against
`attribution-confident-wrong-gap`. Its content materially damaged **three** issues, and by its own text the largest
exposure was **elsewhere** (`task-dependent-reliability-framing`, which it names in terms). But `jq` over
`.contradictions[] | select(.resolved_cycle==null)` groups by `issue_id`, so the G3 gate, the T5 selector and every
per-issue query saw the exposure on **exactly one** of the three. Cycle 33's `extraction-vs-reasoning-ordinal-axis`
demotion is the clean illustration: it fell a point on `ctr-0008`'s content while **carrying no contradiction at
all** in the graph, and structurally it still carries none. **Three options for a human, in ascending cost: (i)
allow `issue_id` to be an array; (ii) require the opening cycle to file a stub entry against each affected issue,
cross-referenced; (iii) accept the limitation and require every T4 to grep contradiction *bodies* for issue ids
rather than trusting the `issue_id` field.** *Cycle 33 chose (iii) plus `ctr-0009`. **Cycle 34 confirms the
selector half of this item empirically: my step-2 ranking used the `issue_id` grouping, so `ioc`'s "three open
contradictions" tie-break credit is a count of FILINGS, not of exposure. It happens to point the right way here —
`ioc`'s three entries are all genuinely about `ioc` — but the selector has no way to know that in general.***

**[53] — NEW cycle 33. THE ARXIV VERSION CHECK IS CHEAP, IT HAS NOW PAID OFF, AND A REVISION CAN RENUMBER THE
TABLES A STORED CLAIM CITES.** One fetch of `arxiv.org/abs/2602.06718` revealed a **v2 (14 May 2026)** of src-0011
that no cycle had noticed in twenty-one cycles. **Every headline quantity survives the revision unchanged**, so the
state is not wrong. **But the per-venue table is `Table 3` in v1 and `Table V` in v2, and v2's `Table 3` is an
entirely different per-model table.** A future cycle fetching the current version and asking for "Table 3" would
receive unrelated content **and could open a spurious contradiction against a clean source** — the exact inverse of
the failure mode [38] guards against. **Two standing rules: (a) run the `/abs` version check on every arXiv source
you touch, per [39]; (b) when a stored claim cites a table BY NUMBER, either pin the version in the URL or ask for
the table BY DESCRIPTION.** *Known version traps in this base: src-0002 (v2 has no CTI-ATE task at all — fetch v3),
src-0011 (v2 renumbers the tables). Two of eighteen sources, and only four have been checked (+ src-0009/src-0010 at
c34, both unchanged at v1.2 — **note these are not arXiv, and the check generalises to any versioned publication
page**).*

**[54] — NEW cycle 33, **CONFIRMED AND SHARPENED AT CYCLE 34**. THE SCORE DISTRIBUTION HAS COLLAPSED TO A SEVEN-WAY
TIE AND THE WEAKEST-LINK SELECTOR IS NOW EFFECTIVELY THE TIE-BREAK. FOR A HUMAN, AND FOR THE PAPER.** The graph
reads `institutional-incident-real-world-impact` 3, all seven other issues 2. A selector that picks the weakest issue
cannot discriminate among seven equals, so the under-specified tie-break of [11] and the never-expiring
`created_cycle` fallback of [30] are doing **almost all of the selecting in this project**. *Cycle 33 recorded
explicitly that it considered whether this is a reason to score less harshly and concluded it is not:
`prompts/t4_assess.md` step 5 is explicit that optimistic scoring breaks the selector, and inflating a score to make
a downstream mechanism behave is precisely the failure that instruction guards against. **The right response is to
flag the mechanism, not to distort its input.*** **(a)** A stingy rubric applied honestly over many cycles is
**compressive** — issues fall toward the level their weakest leg supports and pile up there — so a weakest-link
selector degrades exactly as the assessment discipline improves. **(b)** The scoring scale is doing two jobs at once
— *reporting* evidential state and *ranking* work — and they need different resolutions. A tie-break on
**actionability** (does this issue have a named, costed, undone job?) would have selected well at cycle 33, where
`created_cycle` will not. **CYCLE 34's EMPIRICAL TEST OF (b): I applied actionability as my third discriminator and
IT DID NOT DISCRIMINATE — five of seven tied issues have named undone jobs, and both terminal-tie finalists did.
Actionability is a good *filter* and a poor *ranker*.** What actually decided cycle 34 was **staleness of last
attempt** (13 cycles vs 9), which is `created_cycle`'s principle applied to contact rather than creation — and unlike
`created_cycle` it **expires**. **Recommendation, strengthened by [55]: replace the `created_cycle` fallback with a
staleness/aging term, not with an actionability term.**

**[55] — NEW cycle 34. `automated-triage-under-refusal` IS PERMANENTLY STARVED BY THE TIE-BREAK, AND THIS IS NOW
PROVABLE IN ADVANCE RATHER THAN OBSERVED AFTER THE FACT. VERBATIM FOR A HUMAN. THE STRONGEST FORM OF [30].** Three
issues beat it on `created_cycle`: `ttp`, `ioc` and `consistency` (all created 2, all upstream-maximal under 3a, all
scored 2). It can only win when **all three simultaneously** carry a 3b recent-attempt penalty. Under the
T5→T3→T4→T5 loop a T5 fires every 3 cycles and each produces exactly one T3 attempt one cycle later, so attempts land
on cycles 35, 38, 41, 44, 47 … spaced 3 apart, and **a 5-cycle lookback window contains at most two of them**. At most
two of the three can ever be penalised at one T5; **at least one always has penalty 0 and beats `created_cycle` 16.**
The selector rotates `ttp` → `ioc` → `consistency` indefinitely and this issue is **structurally unreachable**.
**Caveats, so the claim is not over-sold:** the proof holds only while those three stay tied at 2, while no T1/T2
alters the graph (cycles 50 and 51 could), and while the loop does not fail a cycle (which perturbs the spacing).
None of those is scheduled to help — cycle 50's T1 targets whatever cycle 49's T5 selects, which by this same argument
will not be this issue. **CONSEQUENCES ALREADY VISIBLE:** [15]'s curl/HackerOne case (ten cycles as the top uncollected
source) and [27]'s src-0015 Reward column (fourteen cycles unentered) are **blocked on a prompt change, not on
budget**. **PROPOSED FIX, one line in `prompts/t5_select.md`:** add an **aging term** before the `created_cycle`
fallback — subtract 1 from the effective score per N cycles since `last_attempt` (using `created_cycle` for
never-attempted issues) — which dominates a never-expiring creation date and would have selected this issue several
cycles ago. **I did NOT override the mechanism to fix this**: overriding hides the defect behind a one-off correction,
and `ioc` was the better-stocked target on merit anyway. Running the rule and reporting that it starves an issue is
the honest move. Passed on verbatim with [4], [11], [30], [41].

**[56] — NEW cycle 34, from the G2 bolt-on. A LOOSE THREAD ON THE ONLY ISSUE SCORED ABOVE 2. NOT A CONTRADICTION.**
src-0010's page serves its PDF as `ENISA Public Administration TL **2024** - v1.2.pdf` while the same page states a
publication date of **November 6 2025**, and src-0004 places that report in the "published last October and November"
pair. **No stored claim records that filename, so nothing conflicts and [32]'s test says DO NOT FILE — I did not
manufacture a contradiction.** But a filename is weaker evidence than a page's own date field and I assert no defect.
**For whichever cycle next touches `institutional-incident-real-world-impact`:** ask whether ENISA's Public
Administration Threat Landscape is a **2024-titled report republished in November 2025** or whether the filename is a
legacy artefact. One fetch of the report's own title page would settle it, and it would sharpen the incident timeline
either way. *Related: [14] says the v1.2 PDFs themselves cannot be opened from this agent, so the title-page route may
be blocked — try the page's own metadata or the EU publications catalogue instead.*
