# Cycle 036 — T4 (Assess)

**Task type:** T4 — Assess
**Queue entry:** `state/queue/next_task.json`, `cycle_created: 35`, `task_type: T4`,
`target_issue: ioc-extraction-reliability`, `attempt_count: 0`
**Phase verified three ways before acting**, per carry-forward [50]: `next_task.json` says T4;
`last_completed_task.txt` reads `T3 investigate`; `git show --stat` on `de070bc` shows cycle 35
landed `state/issues/graph.json`, `state/queue/*` and `logs/cycle-035.md`. All three agree, and the
state machine re-derived from `config.yml` independently gives cycle 36 = T4. No disagreement to
resolve this cycle.

---

## Task performed

Scored **every one of the eight issues** in `state/issues/graph.json` per `prompts/t4_assess.md`,
which I read at source rather than trusting the queue entry's account of it. Set `assessed_cycle: 36`
on all eight entries and `last_assessed_cycle: 36`. Discharged **`ctr-0010` step (i)**, the named
action item, which is a T4's job and nobody else's.

### The scores

| Issue | Score | Move | Open contradictions | G3 ceiling bind? |
|---|---|---|---|---|
| `institutional-incident-real-world-impact` | **3** | held | none | n/a |
| `ttp-attack-mapping-reliability` | **2** | held | none (`ctr-0006` resolved c31) | n/a |
| `ioc-extraction-reliability` | **2** | held | `ctr-0001`, `ctr-0004`, `ctr-0010` | no — merit 2 under ceiling 3 |
| `consistency-calibration-as-failure-mode` | **2** | held | `ctr-0003`, `ctr-0005` | no |
| `attribution-confident-wrong-gap` | **2** | held | `ctr-0008` | no |
| `task-dependent-reliability-framing` | **2** | held | `ctr-0009` | no |
| `extraction-vs-reasoning-ordinal-axis` | **2** | held | none | n/a |
| `automated-triage-under-refusal` | **2** | held | none | n/a |

**No score moved.** The distribution is unchanged from cycle 33: one issue at 3, seven at 2. Per
carry-forward [54] that means the weakest-link selector is fully degenerate across seven issues and
**the tie-break is the selector**. I flag it; a T4 has no standing to change a selection rule.

I did not treat "no score moved" as a reason to move one. Three of the four issues I might have been
tempted on are argued below.

### G3 gate arithmetic, stated separately so it is auditable

I re-verified the gate at source. `scripts/validate_state.py` lines 144–156 implement a **CEILING**:
it errors only when an issue with an open contradiction scores **greater than**
`scale_max − g3_contradiction_demotion` = 3. `prompts/t4_assess.md` step 3 says **subtract 2 points**,
and `config.yml` line 35's comment agrees with the subtraction. **These are different rules and the
conflict is unresolved.** Cycle 16 ruled for the ceiling and every T4 since has applied it; I did the
same and **refused the subtraction**.

Four issues carry open contradictions. All four sit at merit 2, under a ceiling of 3, so **the ceiling
bound none of them** — the seventh consecutive cycle in which the validator's G3 check is effectively
dead code (carry-forward [41]). Under the subtraction reading, `ioc` reads 0 or −6-floored-to-0
depending on a per-issue/per-contradiction choice **nobody has ever specified**, which would stamp an
issue holding four `candidate_resolutions` and eight `open_questions` with the rubric label "no
candidate resolutions". The two readings agree on `ioc` **only because a ceiling saturates**. That is
exactly why carry-forward [4] needs a human and not another T4's opinion. **Twenty-seventh cycle.**

### `ctr-0010` step (i) — discharged

The defect: `ioc-extraction-reliability`'s rationale said the 0.09–0.15 range was
"reconciliation by metric artefact alone would demand IoC recall of 0.09-0.15" against src-0003.
`logs/cycle-018.md` derives it under the heading *"Solving 2PR/(P+R) for the unreported IoC recall at
which each model's IoC F1 falls to its own derived TTP F1"* — a **within-src-0007 IoC-versus-TTP
crossover** in which src-0003's 97.6% is not an input anywhere.

I **replaced the sentence in place**. `scores.json` is not append-only-protected — validator lines
100–107 cover only `index.json` `key_claims` and the *existence* of `src-*.md` files — and the
superseded wording is quoted inside the replacement so the correction stays auditable.

**I re-derived the entailment argument rather than copying it, as instructed.** `F1 = 2PR/(P+R)` has
`dF1/dR = 2P²/(P+R)² > 0`, so F1 is strictly increasing in R and is bounded by its value at `R = 1`,
namely `2P/(P+1)`. Setting `2P/(P+1) ≥ 0.976` gives `2P ≥ 0.976P + 0.976`, i.e. `1.024P ≥ 0.976`, i.e.
**`P ≥ 0.953125`**. Margins: `0.953125 − 0.8846 = 0.0685` against src-0007's best model and
`0.953125 − 0.8240 = 0.1291` against vanilla GPT-4o. Both reproduce. src-0003's published 97.6% F1
therefore **entails** a precision of at least 0.9531, which compares like-with-like against src-0007's
precisions and needs no recall value at all. **The METRIC confound is eliminated deductively.**

The 0.09–0.15 figure is **retained with its true scope named** — the per-model crossover recalls
0.1475 / 0.1354 / 0.1180 / 0.0887 against actual TTP recalls 0.2270 / 0.1759 / 0.1846 / 0.1414 — and
cycle 18's argument on top of it survives intact as an *abductive* argument that is no longer
load-bearing. Steps (ii) and (iii) of `ctr-0010` are **not mine** and are passed on undone.

### One argument for a 3 that no prior cycle has had to answer, recorded because a successor will meet it

Candidate 4's entailment leg cites **src-0003 and src-0007, which are genuinely independent of each
other**, so on a mechanical count candidate 4 now has two independent sources. I rejected it: candidate
4 is **eliminative** and says so in its own words — *"it rules a confound out; it does not establish
what the gap IS"* — and an issue titled for the *reliability* of IoC extraction cannot be scored 3 on a
candidate that answers no part of that question. Designating a non-answer primary to reach a 3 is the
same move cycle 33 refused on `consistency-calibration-as-failure-mode`, and I refuse it here for
consistency. Candidate 1 rests on src-0003 alone, candidate 2 on src-0007 alone, and candidate 4's
third id (src-0017) is the **same team's** artefact release for src-0007.

### Two rationale overstatements corrected in place

Both flow from cycle 35's finding that the one-directional IoC matcher's bias is **asymmetric with
unknown net sign** (lenient toward fragmentary predictions, strict against verbose ones, which are
scored FP *and* FN simultaneously).

1. **`task-dependent-reliability-framing`** said *"The confound's SIGN is known and it points the same
   way as the finding."* **Too strong.** Restated: the IoC matcher **has** a leniency channel and the
   ATT&CK matcher — exact technique-ID set intersection that discards the parent column — has **none**,
   so the two rules are of known different *character*, but the net direction and magnitude of the IoC
   side are unquantified. A confound of unknown net sign is still a confound; it simply cannot be
   asserted to *manufacture* the 3× spread, only to make it uninterpretable.
2. **`ttp-attack-mapping-reliability`**'s *"a leniently scored number was being compared against a
   strictly scored one"* got the same qualification. Candidate 2's withdrawal stands regardless: a
   comparison between a rule of unknown net bias and a rule of known strict bias is not a control either.

**Neither score moved, and I checked that explicitly rather than assuming it.** The level-3 bar turns
on independent-source support for the primary candidate, which is untouched in both cases. *A 3 is not
restored by weakening an objection when the thing the rubric measures has not changed.*

**No contradiction was opened for either.** These are over-precise glosses inside `scores.json`
rationales, not conflicts between two supported claims in the graph. `ctr-0010` set the precedent that
a T4 restates such a gloss in place. Carry-forward [32]'s filing test does not cover this case and
should be widened when a human writes it into `prompts/system.md` — see [60].

---

## Retrospection (G2)

**Target: `src-0014` (PromptAudit), `https://arxiv.org/html/2605.24171`.** Chosen by staleness —
last checked cycle 19, the stalest source in the base, and one of the three whose **provenance label
has never been checked at all**. Three fetches: `/abs` (provenance), `/html` (content), `/html…v1`
(second rendering, whole tables).

### Verdict: **CLEAN.** No contradiction warranted. Seventh consecutive clean check.

**Numbers — all PRESENT and exact.** The four stored F1 figures reproduce verbatim, and are confirmed
**still body-sentence-only**: *"Gemma serves as the prompt-sensitivity baseline: it exhibits the largest
cross-strategy F1 range (0.398)"*; *"with standard F1 spanning from 0.102 under A-CoT to 0.499 under
self-consistency"*; *"Mistral serves as the stability baseline: it achieves the smallest cross-strategy
F1 range (0.103)"*; *"The evaluated CoT template achieves the highest mean F1 (0.465)"* / *"and mean
effective F1 (0.427)"*; *"with a low mean abstention rate of 7.28%"*. The eight A-CoT recall-drop
figures reproduce in **one sentence**: *"The A-CoT template reduces recall relative to CoT for every
model, with the largest drops in CodeLlama (0.685 → 0.279), Falcon (0.541 → 0.223), Gemma (0.420 →
0.057), and Mistral (0.423 → 0.280)."* The per-model F1-by-strategy table lives in Appendix E (Table 4)
and returned **CANNOT READ** on both renderings, so it remains unpulled.

**New and load-bearing: the five coverage percentages are now anchored to a table.** Table 2 was pulled
whole — caption *"Abstention rate (%) by model and prompt template"* — and its self-consistency column
reads DeepSeek 60.96%, Mistral 51.07%, Gemma 39.15%, Falcon 75.96%, CodeLlama 49.00%, with the CoT
column mean 7.28%. The paper defines *"coverage as one minus abstention rate"*, and `100 − cell`
reproduces the stored figures **exactly**: CodeLlama 51.00, Mistral 48.93, Gemma 60.85, DeepSeek 39.04,
Falcon 24.04. The source is internally consistent.

**Provenance, checked for the first time and confirming the recorded weakness.** `arxiv.org/abs/2605.24171`
lists **v1 only**, submitted Fri 22 May 2026 19:44:51 UTC (80 KB). `Comments:` **ABSENT**.
`Journal reference:` **ABSENT**. No venue, acceptance or "to appear" statement anywhere on `/abs` or in
the HTML body. Subjects verbatim: `Machine Learning (cs.LG); Artificial Intelligence (cs.AI)` — filed
**cs.LG primary, not cs.CR**, for a vulnerability-detection paper. Authors: Steffen J. Camarato, Yahya
Hmaiti, Mandana Ghadamian, David Mohaisen; no affiliations shown. The standing label "v1 preprint, no
stated venue" is **confirmed at source**, not merely inherited, and no [53] renumbering hazard exists.

### The near-miss, which is the most useful thing this G2 produced

The **first** fetch returned a *summarised* claim that Table 2's percentages *"refer to abstention
rates … not a separate coverage column"*. Taken at face value that reads as a **metric-identity defect
of exactly the `ctr-0007` shape** — a body sentence labelling as "coverage" the same numbers a table
labels "abstention" — and it would have been filed. **The verbatim table pull disproved it.**

Methodological rule (ix) has always said a summarised PRESENT is as untrustworthy as a bare ABSENT.
What this cycle adds is the **direction**: a summarised read can **manufacture** a defect that is not
there, not only conceal one that is. **A false contradiction is more expensive than a missed one,
because it is entered as a finding and inherited.** New carry-forward [60].

### Recorded to the knowledge base

Appended (append-only-safe) a cycle-36 `key_claim` to src-0014's `index.json` entry and a matching
section to `state/knowledge/src-0014.md`, carrying the provenance, the Table 2 anchoring, the near-miss
caution, and **two scope notes**: (1) Gemma's top standard F1 of 0.499 is achieved *under
self-consistency*, i.e. under the strategy at which it abstains on 39.15% of inputs, so the 0.398 range
is not a like-for-like coverage comparison; (2) src-0014's abstention/coverage/effective-F1 family is a
**selective-prediction** construct and must never be pooled with the ECE/Brier proper-scoring
calibration of src-0001 and src-0013. That is now **three** distinct non-calibration constructs in this
base sharing the vocabulary of calibration — src-0014's coverage, src-0015's action thresholds,
src-0018's FDR/FNR.

**This does not move any score.** src-0014 measures vulnerability detection over CVE code samples, not
CTI, and contributes nothing under the cycle-16 scope ruling. Recorded so no successor re-spends it.

---

## Changes made

- `state/assessments/scores.json` — **rewritten in place**, ten `Edit`s, all `jq -e` validated and
  `jq -r` read back. `last_assessed_cycle` 33 → 36; `assessed_cycle` 36 on all eight entries; no score
  changed; `ctr-0010` step (i) restatement on `ioc`; cycle-36 addenda on all eight rationales; the two
  gloss corrections above.
- `state/knowledge/index.json` — one **appended** `key_claim` on src-0014 (G2 record). Nothing removed.
  Source count unchanged at 18.
- `state/knowledge/src-0014.md` — appended cycle-36 G2 section. Nothing removed.
- `state/queue/next_task.json` — T5 (select) for cycle 37, `attempt_count: 0`.
- `state/queue/last_completed_task.txt` — `T4 assess`.
- `logs/cycle-036.md` — this file.

**`state/issues/graph.json` is untouched.** A T4 has no standing to alter `candidate_resolutions`,
`open_questions` or `contradictions`, and I altered none. All three of `ioc`'s contradictions stay open.

---

## Next task rationale

State machine `T4 → T5`, re-derived from `config.yml` rather than inherited: cycle 37 = **T5 (select)**,
38 = T3 targeting whatever the T5 picks. `collect_refresh_every: 7` and the refresh fires only when a
T5 *runs on* a multiple of 7 — cycle 49 is both, so **the next T1 is cycle 50 and the next T2 is cycle
51**. The T3 that cycle 37 schedules is therefore the **only realistic collection vehicle for the next
thirteen cycles**, and I told the T5 so.

The handoff carries three things the T5 must not lose: the **starvation proof** ([55]) with its
consequences priced ([15], [27]); the current attempts arrays and `created_cycle` values read from the
graph this cycle, so the tie-break arithmetic can be done without re-reading 180 KB; and the standing
instruction to read `prompts/t5_select.md` at source and **state the rule applied and the inputs fed to
it**, since with seven issues tied at 2 the tie-break *is* the decision. I explicitly told it that it
may **not** invent or amend a selection rule, and that it must say plainly which way it went and why.

---

## Budget

| Item | Count |
|---|---|
| Web fetches | 3 (`/abs`, `/html`, `/html…v1` of src-0014) |
| Web searches | 0 |
| `jq` / `grep` reads | 9 |
| File reads | 6 |
| Edits | 11 (10 on `scores.json`, 1 on `index.json`) |
| Writes | 4 (`src-0014.md` append, both queue files, this log) |
| Assistant turns | ~32 of `max_turns: 50` |

Both queue files were written **before** the log, per [50](2). No fetch failed; no ABSENT verdict was
recorded this cycle, so [38]'s second-URL rule was not triggered — though the second rendering was
fetched anyway, and it is what caught the near-miss.

---

## Carry-forward items

All items from `logs/cycle-035.md` reproduced **including those I cannot act on**. Discharged items stay
marked rather than deleted. **New: [60], [61]. Discharged this cycle: [57] step (i) only. Updated: [4],
[8], [9], [11], [20], [24], [27], [28], [30], [31], [34], [37], [39], [41], [50], [51], [53], [54],
[55], [57], [59].**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed; ordinal
axis moved to `extraction-vs-reasoning-ordinal-axis`. Cited as the precedent behind [37] and [45]. Both
halves of that split are now at 2 and fell for the same root defect — weak evidence that the split was
along the right seam.

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK metric at
all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in its
**twenty-fifth** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**. [44] puts
the 0.6388 itself in question. Now that the scorer's rule is known to be exact-ID matching with no
partial credit, a useful human baseline would have to be scored under the **same** rule — and exact
sub-technique assignment is a task on which two competent analysts would themselves disagree.

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30] and [55]. **Now seven
consecutive lost selections**, and [55] upgrades the prediction to a proof: **structurally unreachable,
not merely unlucky.**

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 27 CYCLES. VERBATIM FOR A HUMAN.**
The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line
35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The enforced
reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in `logs/cycle-016.md`
"Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside this agent's output surface.
**Until a human applies it, T4s must apply the ceiling.** Under subtraction four of eight issues would
read 0 today. The per-issue-versus-per-contradiction question stays live on `ioc` (three open) and
`consistency` (two): under subtraction, is `ioc` −2 or −6? *Cycle 36 applied the ceiling on all four
contradicted issues and it bound on none.* Awaiting a human, verbatim, with [11], [30], [41], [55].

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is a
**self-contradiction in the source**, and our stored mapping is the **majority reading**. No
contradiction entry per [32]'s test. *Standing lesson: an item recorded as "blocked by an infrastructure
limit" may only be blocked by the route the recording cycle happened to try.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv 2506.11325;
third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines; the paywalled
eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not retry). Forward-citation sweeps have
**FAILED on two arXiv ids**. **SEvenLLM** uncollected and downgraded. **AthenaBench** still has no URL.
No arXiv companion exists for src-0018. Unavailable: OpenReview, spiegel.de ([13]). **CTIBench's own
released evaluation artefact has never been sought** — now `ttp`'s `open_question[3]`, and the **only**
route left to move `ttp` off 2. *Cycles 31–36 spent nothing here.*

**[7] — WORKED AT 21; PATH REDRAWN AT 22; STEPS AT 27, 31; SCHEDULED AT 34; THE LAST CHEAP STEP EXECUTED
AND EXHAUSTED AT CYCLE 35.** `ctr-0001`'s resolution path. **Done:** released-code route exhausted;
METRIC confound eliminated (and now *deductively*, see [57]); TTP scorer read; the HuggingFace mirror
fetched at last and it does **NOT** contain the per-model IoC predictions — a complete 52-file tree
listing with byte sizes confirms the only IoC prediction artefact is the 1,298-byte manual example, and
`TTP_Mapping.csv` at 1,083,078 bytes proves the mirror is the same repository as GitHub, not a superset.
**src-0007's recall is unobtainable from any released artefact.** Also settled negatively: the ground
truth is **nowhere stated to be exhaustive per article** (two URL forms). **Still open:** no head-to-head;
**the CORPUS confound is completely untouched**; and a **MATCHER confound** ([57]). **Every cheap step on
this path is spent. What remains is a corpus study or a new source.**

**[8] — UPDATED cycle 36. G2 COVERAGE COMPLETE; TRACKED BY STALENESS, ALSO BY REPLICATION.** src-0004
(c4, c12), src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 — `ctr-0002`; c28 —
`ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial fail [21]; re-pulled c18),
src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), src-0012 (c13; c31 — CLEAN), src-0011 (c14;
c33 — CLEAN, version hazard found), src-0007 (c15; c21; c30 — `ctr-0008`; c35 `/abs` bolt-on — v1 only,
TMLR provenance found, see [58]), src-0009/src-0010 (c16; c34 — BOTH CLEAN), src-0013 (c18; c35 —
CLEAN), **src-0014 (c19; c36 — CLEAN, provenance confirmed v1-only / no venue / cs.LG, coverage figures
newly anchored to Table 2)**, src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]), src-0017
(c27 — `ctr-0004`; c32 — CLEAN), src-0018 (c28 — `ctr-0005`). *Next G2 by staleness: **src-0015** (c20,
**provenance never checked** and it is labelled the weakest-provenance source in this base — verifying
that label is overdue), then src-0016 (c21, and it carries the known [31](a) quotation defect, so
re-checking tests whether the defect was correctly characterised), then src-0006 (c18 — and see [21]),
then **src-0003**, never re-checked since collection and the sole support for `ioc` candidate 1.* But
see [51]: staleness is the default, not the rule.

**[9] — CORRECTED cycle 18, re-confirmed 19–23, 25–36.** `python3` present but the **permission layer**
blocks it, so **`scripts/validate_state.py` cannot be run by this agent**; compound commands rejected if
any segment is unapproved. **No PDF text extraction exists** — prefer `/html`. `gh` not approved. `awk`
refused. **`sed -n` and `cat >>` heredoc ARE approved**; a heredoc append must be its **own** call.
`jq -e . <file> > /dev/null` approved, as is a compound `jq … && jq …` chain and a `;`-separated chain of
approved commands. **`jq --slurpfile` is REFUSED**, so cross-file `jq` is impossible. **Bash `grep -n` /
`grep -c` ARE approved on the small files**; the `Grep` **tool** is necessary on the big JSON files.
Prefer **single-line `Edit` anchors**. `scores.json` and `graph.json` are NOT protected by validator lines
105–107. **`raw.githubusercontent.com` returns whole files.** **Shell variables and `for` loops are
REFUSED** (`Contains simple_expansion`). A bare Bash `grep -o -E` with a context-width pattern is REFUSED;
the `Grep` **tool** with `-o` + `output_mode: content` does it. *Cycle 36 addition: **`jq -r
'…rationale[-90:]'` prints the TAIL of a long single-line JSON value**, which manufactures ready-made
end-of-string `Edit` anchors for append-style edits — but **check uniqueness**: two of the eight
rationales ended identically and needed 230-character tails. Single-quoting every internal quotation
kept a 20,886-character `instructions` string escape-free — **eight cycles of evidence**.*

**[10] — DISCHARGED CYCLE 26; NEVER ACHIEVABLE.** src-0005's per-model numbers do not exist in text —
every per-model score is inside Figures 8, 9, 12–16. **Do not re-attempt without a new route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27, 30, 34. VERBATIM FOR A HUMAN.** Tie-break 3a in
`prompts/t5_select.md` is under-specified and there is **no deterministic tie-break after 3c**. In four
parts: **(a)** a terminal tie **must** be written into the prompt; **(b)** the prompt lists **3a before
3b**, but 3b is an addition *to the score*, so a literal a-then-b ordering lets them return **opposite
verdicts on the same pair**; **(c)** "within the last 5 cycles" has three defensible readings — cycle 34
resolved (c) as harmless in practice but found the two readings of **3a** differ on whether an issue with
*no edges at all* survives it, which is the ambiguity burying `automated-triage-under-refusal`;
**(d)** the prompt has **no aging term** — see [55]. Cycle 34 hit a terminal tie for the third time and
broke it by documented judgement. *Cycle 37 is a T5 and will meet this again with seven issues tied.*
Passed on verbatim with [4], [30], [41], [55].

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with standing to
split an issue, add an issue, or reconcile the prompt/validator disagreement. The claim that the loop
"never returns to T2" is false; cycle 16 disproved it. *The next T2 is **cycle 51**. [37] and [45] are
both T2 jobs and both wait another fifteen cycles.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is the
upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF route is also
closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own writeup is the only
remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2 PDFs
cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level and UNVERIFIABLE
at document level here. **Do not re-spend budget.** Cycle 34 re-confirmed the landing-page half cleanly at
both pages without touching the PDFs.

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, DEFERRED A TWELFTH TIME.** The
curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports; ~20% of
submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%) is an
`open_question` on `automated-triage-under-refusal`. **It is a question, not evidence — no curl source
exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–36 all judge it the highest-value uncollected source. *The earliest T1 route is **cycle
50**; a T3 targeting that issue could reach it sooner ([29]) — but per **[55]** no T3 will ever target that
issue under the current tie-break, so **this is blocked on a prompt change, not on budget**.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the base-rate
question. Verbatim from `https://gptzero.me/investigations/ey`: an *"automated pipeline to search for vibe
citations by finding and scanning public reports from major consulting firms"*. A T1 should chase
`gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor; no *rate* published; the
scorecard widget renders as "0 of N" to automated fetch. **Still the only route any cycle has found to a
base rate**, the binding constraint on `institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the escape to
T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural finding for the
paper: the only task type that can restructure the issue graph fires when a T5 coincides with a multiple of
7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18] — DISCHARGED CYCLE 33 AS *CONFIRMED*.** src-0011 contradicts itself in prose vs table: body text
*"NeurIPS exhibiting the highest absolute count (**391 papers**)"* against a table row giving **Invalid =
391, Papers = 308**. Reproduced verbatim from **both v1 and v2**, so it is durable. No claim in our base
repeats the error; **no G3 entry was opened**. **Quote src-0011's *counts* from the table's columns, never
from that sentence.** *Self-contradicting sources in this base: src-0011 (prose vs table, and a 738-vs-739
slip, [53]), src-0002 (Micro-F1 vs Macro-F1, [44]), src-0008 twice (phase labels [5]; metric definitions
[46]), src-0007 (rubric dimension defined twice, [47]), src-0017 (docstring/README vs live code). **Five
sources, eight instances.** Cycle 36 checked src-0014 for a ninth and found none — its body-sentence
coverage figures are exactly `100 −` its Table 2 abstention cells.*

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4 pulled **whole
and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall (Accepted) **0.9091–1.0000**.
**THE ANOMALY IS UNRESOLVED AND REPRODUCED THREE TIMES:** GPT-4o (FT) tracks o3-mini to within 0.001 on
**all six** `Content: Threat Actor` rubric rows, identically at c15, c21 and c30, on two URL forms.
**As-printed, cause unknown, DO NOT GUESS.**

**[20] — DISCHARGED cycle 21; RESIDUE **FULLY DISCHARGED AT CYCLE 36**.** All four cycle-15 sources
verified: src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21). Cycle 35's G2 on src-0013 verified
the Gemini 0.161 → 0.721 leg verbatim; **the FT discrepancy does NOT close and the prohibition stands** —
Table I is "SALLM, n=2,000 per temperature" and Table IV is "verbatim averages across six temperature
settings", and 33.9% is not recoverable from 16.9%→83.2% by any aggregation the paper states. *Cycle 36
closed the src-0014 half: the four F1 figures **are** body-sentence-only, confirmed, and that is now a
recorded fact rather than an open residue — Appendix E's Table 4 does not render on either URL form. **Still
live: src-0015's and src-0016's provenance labels are unchecked.***

**[21] — CONFIRMED AND PARTIALLY REPAIRED cycle 18; STILL THE ONLY KNOWN UNCORRECTED SOURCE FILE.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688 for a
general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5 at 0.677**.
Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a true span of
**0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md` is still
untouched and still carries the wrong sentence.** *`ctr-0009` step (iii) sends a T3 to src-0006 anyway.
Still undone at cycle 36.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are **strictly
monotone decreasing across all eight general-purpose columns in exactly the printed column order**; four are
in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends on. One row matching a fixed
eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** **Any finding resting on
that table must carry a robustness check excluding those rows** (cycle 18's: drop all four → 0.641 vs 0.592,
gap 0.049, same direction).

**[23] — STANDS, for the next T2.** Mean between-**model** range within a task (0.272) and mean
between-**task** range within a model (0.263) are equal to within 0.009. This does **NOT** negate
`task-dependent-reliability-framing`'s supported claim — it qualifies the implication that sub-task is the
*privileged* explanatory variable. A T2 should annotate rather than re-scope. No contradiction: both facts
hold. *Note [57]: both figures are themselves **unaudited derived quantities**.*

**[24] — NEW cycle 18, USED THROUGHOUT 19–23 AND 25–36. `jq` IS INSTALLED AND APPROVED.** Every cycle from 9
to 17 recorded that this agent cannot validate JSON and must check "by construction". **That advice is wrong
and expensive** — cycle 17 lost its entire `state/` output. **Every JSON edit should be followed by `jq -e`**
*and* a `jq -r` read-back of the fields added. The permission layer is **not uniform** — probe once. The
`Grep` **tool** works on the big JSON files where Bash `grep -n` does not. Cheapest pattern:
**`grep`/`Grep`/`jq` → `Read` with `offset`/`limit` → `Edit` → `jq -e` → `jq -r` read-back.** *Cycle 36 ran
eleven `Edit`s across two JSON files through this pattern with zero failures, and re-confirms the economy: a
**single small `Read`** (one line, `offset`/`limit`) unlocks the whole file for editing.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the `Content: Threat
Actor` rubric block in full, and the caveats keep travelling: the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, **re-confirmed ABSENT at c30**), so
**only within-table contrasts may be cited**; the GPT-4o (FT) column is suspect per [19]; and **`Attribution`
means SOURCE LINKING in the Threat Actor block and ACTOR IDENTIFICATION in the Root Cause block**, so
cross-block contrasts are not automatically safe either. See [47]. *Standing lesson: "the table is captured
verbatim" and "the metric is understood" are different claims.*

**[26] — NEW cycle 18, PARTLY ACTED ON BY A HUMAN AT CYCLE 33.** **Why cycle 17 failed validation is unknown
and unrecoverable.** Suggested fix: tee `python scripts/validate_state.py` output into
`logs/cycle-NNN-validation.txt` before reverting, and `git stash` the rejected `state/` diff. *Commit
`956a36c` (a human) fixed the **agent-death** half. **The logging half is still undone.*** *Per [9] the agent
cannot run the validator itself, so a cycle has **no way to see why it failed** — which is what makes the
logging half matter.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER SIXTEEN CYCLES.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61,
DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward.** Bears on
`automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward composition unstated; n=40 per model,
no CIs; association not strictly monotone. **A rationale is not the graph.** *Cycle 36 verified against the
graph per [59] rather than trusting the tracker: `automated-triage-under-refusal` has **one**
`candidate_resolution` and five `open_questions`, and no Reward figure appears in either. **The item is
genuinely still undone.** A T4 has no standing to enter it; only a T3 targeting that issue can — and per
[55] no T3 ever will under the current tie-break.*

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–36.** The state machine is T1→T2, T2→T3, T3→T4, T4→T5,
T5→T3. **Positions: cycle 36 = T4 (this one), 37 = T5**, T5 thereafter on 40, 43, 46, **49**. The refresh
fires only when a T5 **runs on** a multiple of 7; 49 is both, so **the next T1 is cycle 50 and the next T2 is
cycle 51.** *Cycle 36 re-derived this from `config.yml` independently and it matches cycles 32–35.* **THE
HEADLINE: cycle 24's crash pushed collection back eight cycles and cycle 31's max-turns death another seven.
Two partial failures have cost fifteen cycles of collection and restructuring capacity.** **Re-derive rather
than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25, 30–35.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018. **Standing lesson:
read the task's own prompt file, not only the queue entry's description of it.** *Cycle 36 read
`prompts/t4_assess.md` at source and found the handoff accurate on it — nine clean handoffs in a row on the
prompt itself. **Cycle 35's finding that handoffs err on their own job PREMISES rather than on the prompt
holds again**: see [59] and the note at the top of cycle 37's queue entry.*

**[30] — NEW cycle 20; PREDICTION CORRECT SEVEN TIMES; UPGRADED TO A PROOF AT CYCLE 34, SEE [55]. VERBATIM
FOR A HUMAN.** `automated-triage-under-refusal`, the only issue never worked on (`attempts: []`, created
cycle 16), has **lost seven consecutive selections**. **"Never attempted" is not a tie-break in
`prompts/t5_select.md`**, and cycle 19's rationale wrongly asserted it was. **This is a prompt change for a
human.** Note the interaction with [11]: under one reading of 3a it is eliminated outright for having no
dependents; under the literal pairwise reading it survives 3a and dies at `created_cycle`, so **the newest
issues in a graph are structurally disadvantaged forever, with no expiry**. With seven issues tied at 2
([54]), `created_cycle` is doing almost all the selecting in this project.

**[31] — NEW cycle 21, EXTENDED 22–36. THE VERBATIM CHECK HAS NOW RUN ON **SIXTEEN** SOURCE-CHECKS; NINE
PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation **does not exist on the page**.
(b) **src-0003** (c22): quotations passed, stored *numbers* 76/72/86 are **figure-image-only**. (c)
**src-0002** (c23): all 25 numbers exact, **interpretation contradicted by the paper's own metric
definition**; `ctr-0002`. (d) **src-0001** (c25): numbers exact, **calibration gloss contradicted by the full
table**; `ctr-0003`. (e) **src-0005** (c26): all claims **PASS** — but stored with no task format, metric
definition, sample counts, limitations or numbers. (f) **src-0017** (c27): every stored string **PASSES**,
the **DOWNSTREAM PARAPHRASE** dropped the hedges; `ctr-0004`. (g) **src-0018** (c28): every quotation
**PASSES** — the stored **SCOPE** is wrong by being **TOO RESTRICTIVE**; `ctr-0005`. (h) **src-0002 again**
(c28): two more glosses, one **FALSE against the printed table**; `ctr-0006`. (i) **src-0008** (c29):
quotations and numbers **PASS**, one claim **OVER-GENERAL**; `ctr-0007`. (j) **src-0007** (c30): all 34 rows
PASS, **THE METRIC IS DEFINED TWICE UNDER ONE NAME**; `ctr-0008`. (k) **src-0012** (c31): CLEAN. (l)
**src-0017's TTP scorer** (c32): CLEAN. (m) **src-0011** (c33): CLEAN. (n) **src-0009 + src-0010** (c34):
CLEAN. (o) **src-0013** (c35): CLEAN. **(p) src-0014 (c36): CLEAN — four F1 figures and eight recall-drop
figures verbatim, five coverage percentages newly anchored to Table 2 by exact arithmetic, provenance
confirmed v1-only / no venue / cs.LG for the first time.** **The defect class is nine-way** — spliced
quotations, unverifiable numbers, unsupported interpretive glosses, partial table capture, correct-but-hollow
entries, correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity.
**SEVEN consecutive clean checks.** *Cycle 34's caveat has now weakened but not vanished: cycles 31–35 all
checked sources that had already survived one pass, and **cycle 36 is the second of the four second-pass
backlog sources cleared** (after src-0013) and the **second provenance label checked among them**. src-0015
and src-0016 remain untested on both axes. **A long clean run is also what a checking process that has
stopped biting looks like — [60] is the first evidence this cycle that it has not.***

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1 values are
figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not text-verified.** Also
unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction when the source's own legible text
conflicts with the stored claim; do not file when the stored claim is merely unverifiable.** *Cycle 35 found
the test's first edge (`ctr-0010`: state versus a prior cycle's own derivation, no source on either side).*
**Cycle 36 found a second edge: an over-precise gloss inside a `scores.json` rationale, where the gloss
conflicts with a graph finding but neither is a source claim.** *Cycle 36 restated two such glosses in place
and filed nothing, on `ctr-0010`'s precedent that `scores.json` is unprotected and a T4 owns it.* **Six uses,
correct every time, but its scope needs widening on two axes when a human writes it into
`prompts/system.md`.**

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.** src-0003's
97.6% is measured on a **closed-set classification task over a regex-extracted candidate set**, not free-form
extraction — *"We assume a total of 1,789 candidate indicators, extracted using IoC Searcher"*; Figure 9's
caption "… on IoC Classification." **A difference in task format, stated by the paper.** **Companion finding:
src-0003 NEVER STATES ITS MATCHING RULE** (`src-0003.md` line 141). *Cycle 36 note: this is why the
`P ≥ 0.9531` entailment eliminates only the METRIC confound and not the gap — the entailed precision is a
**classification** precision, and the MATCHER correction is unsigned on src-0003's side too. **Do not re-buy
it** — probably unresolvable from this base.*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3. HALF DISCHARGED AT CYCLE
31; PRICING DISCHARGED AT CYCLE 33; **THE SIGN CLAIM WITHDRAWN AT CYCLE 36**.** **A within-study design holds
team, corpus, models and harness constant but does NOT hold the scoring rule constant.** Cycle 31's fetch gave
the **worst case for the objection's target**: src-0007's IoC and ATT&CK sub-tasks are scored by **different
kinds of rule**, so the within-study comparison is **refuted, not rescued**. *Cycle 22's sharpest form — "the
sign of the confound is known and it points the same way as the finding" — **IS NOW WITHDRAWN AS TOO STRONG,
and cycle 36 corrected it in `scores.json` in both places it appeared.** Per `ctr-0004` and `open_questions[6]`
the one-directional IoC rule is lenient toward fragmentary predictions and strict toward verbose ones, so its
**net sign is the difference of two unmeasured quantities and is UNKNOWN**. **The surviving form: the IoC
matcher HAS a leniency channel and the ATT&CK matcher has NONE, so the rules are of known different
character.** A confound of unknown net sign is still a confound — it just cannot be asserted to MANUFACTURE
the observed spread, only to make it uninterpretable. **Neither score moved**, because the level-3 bar turns
on independent-source support, not on the strength of the objection.* Known non-commensurable instances:
src-0017/`ctr-0004`, src-0003, src-0005, src-0002/`ctr-0006`, src-0007's rubric against itself ([47]),
src-0007's IoC rule against its own ATT&CK rule, src-0008's body against its Table 6 caption ([46]).
**Seven.** **STILL OPEN AND THE PROJECT'S LARGEST UNTESTED LOAD-BEARING ASSUMPTION: src-0006's per-task metric
definitions have never been pulled** — `ctr-0009` step (iii). *Cycle 36 endorses that ranking explicitly.
Blocked by the tie-break, not by budget (the other such block is [15]).*

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible` columns are
**nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements (incorrect = 100 − Plausible =
**14 / 38 / 26 / 20 / 64%**) are in the graph **with their derivation stated**; `ctr-0002` CLOSED. *Note [57]:
those five derived points are **unaudited against their own derivation**.*

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all executed. **The
consequences did not stay inside the issue: see `ctr-0006` and [44].** *The G2 staleness heuristic and the
scoring rationales work as a pipeline. **Closing a contradiction should itself schedule a replication.** **A
finding's effect on the scores can lag its discovery by several cycles, and nothing in the loop tracks that
debt except carry-forward.*** *Cycle 35 closed the extreme case: `ctr-0004`'s T3 half waited **eight** cycles
and `ctr-0007`'s **six**, both for want of a selection — and both were discharged in a single cycle once the
selection came. **Cycle 36 supplies the T4-side counterpart: `ctr-0010` step (i) waited exactly one cycle,
because the handoff named it and the state machine put a T4 next.** The lag is bounded by the selector, not by
attention.*

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28–30, 33, 34, **36**. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent sources** (src-0001 +
src-0018, **both at temperature 0**), calibration-on-CTI on **one** (src-0001, gpt4o only), and `ctr-0003`
sits on the calibration half alone. Natural cut: `consistency-under-repeated-query` vs
`confidence-calibration-on-CTI`. **Only a T2 can split an issue** ([12]); **next T2 is cycle 51.** *One of
**three** issues in that position. This issue was the runner-up in cycle 34's terminal tie and is a live
cycle-37 candidate.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AT 30, 31, 33, 35 AND **36**. A SINGLE FETCH'S
"ABSENT" IS NOT EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT verdict
must be confirmed against a second URL form.** Before recording an absence check **(1)** the abstract, **(2)**
a different URL rendering, **(3)** that you fetched the file the claim actually cites, **(4)** that the
**VERSION** you fetched contains the material at all. **The rule also applies to a PARAPHRASED verdict: a
summarised PRESENT is as untrustworthy as a bare ABSENT.** *Cycle 31 found the rule's limit — both URL forms
of `TTP_Mapping.csv` failed the same way ([49]). Cycle 32 added that a verdict about which of two competing
texts EXECUTES is not a PRESENT verdict at all. Cycle 33 added: when two fetched numbers conflict by one
digit, ask whether EACH SIDE IS INTERNALLY CONSISTENT before suspecting the fetch.* **Cycle 36 paid off on the
paraphrase limb specifically and in a new direction — see [60]. Cycle 36 recorded no ABSENT verdict at all, so
the primary limb was not exercised.**

**[39] — NEW cycle 25, EXTENDED 26–29; THE VERSION AXIS PAID OFF AT 33; THE PROVENANCE AXIS PAID OFF AGAIN AT
35 AND **36**.** Provenance labels in this base were set at collection time and are mostly still unchecked.
src-0001 **is peer-reviewed** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` — and this base called
it a preprint for 24 cycles. src-0005 goes the other way: **an unreviewed preprint**. *Cycle 35: src-0013's
"ICSME 2026 Research Track" **CONFIRMED exactly**. **Cycle 36: src-0014's "v1 preprint, no stated venue"
CONFIRMED exactly** — `Comments:` and `Journal reference:` both ABSENT, no venue anywhere, v1 only (22 May
2026), and it is filed **cs.LG primary, not cs.CR**, which no cycle had recorded. **Still unchecked:
src-0015's "single-author preprint" label — now the last one, and the next G2 target.** **And src-0007 turns
out to be published — see [58], STILL UNRECORDED after two cycles of flagging.*** Version checks run:
src-0008 (c29), src-0011 (c33), src-0009/src-0010 (c34), src-0013 and src-0007 (c35), **src-0014 (c36, v1
only)**. **Run the `/abs` check on every arXiv source you touch: one fetch, and it has now produced a finding
on three of seven sources checked.**

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND THIS BASE
CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: *"the share of questions for which the system
selects all correct options and only the correct options."* Questions **generated by Llama 3.2 90B and Llama 4
Maverick**; the paper concedes *"performance bias … where the model under test is the same, or has
similarities with the set of models that were used in synthetic data generation pipelines"*. **(a)** Its
percentages are not commensurable with src-0002's F1 or src-0007's precision/recall. **(b)** It reports **no
ATT&CK metric at all**. **(c)** 23–34% (MA) against 43–53% (TIR) is **NOT a controlled contrast**. **Anyone
using it must state those three confounds.**

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30, 32, 33, 34, 35. THE G3
CEILING BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS. VERBATIM FOR A HUMAN.** An honest,
stingy T4 demotes issues carrying open contradictions, which moves them *away* from the ceiling. **So the
validator's G3 check is very nearly dead code, while the prompt's subtraction rule — which every T4 has
correctly refused to apply — would fire on four of eight issues today and drive them toward 0 without
tripping anything.** Shapes documented: **(1) undermining** (`ctr-0001`); **(2) strengthening** (`ctr-0005`);
**(3) two-directional** (`ctr-0007`); **(4) support-relocating** (`ctr-0008`); **(5) closes without the
underlying source defect being repaired** (`ctr-0006`); **(6) damages issues OTHER than the one it is filed
against** ([52]); **(7) closed by the very cycle sent to act on it, with a simultaneous opening leaving the
per-issue count unchanged — so the gate sees no change from a cycle that materially repaired the issue**
(`ctr-0007`/`ctr-0010`). **Seven shapes, one binary gate. A binary per-issue gate cannot represent repair.**
*The dead-code observation holds for an **eighth** cycle: at cycle 36 the ceiling binds on **zero** of the
four contradicted issues.* **Cycle 34's generalisation, restated: this is the THIRD instance of a mechanism
that degrades as the rest of the loop improves — the G3 ceiling ([41]), the weakest-link selector under
compressive scoring ([54]), and the starvation proof ([55]). Whoever designs the successor system should treat
"does this mechanism get worse when the agent gets better?" as a standing design question, not three separate
bugs.** Passed on verbatim with [4], [11], [30], [55].

**[42] — NEW cycle 27; `ctr-0004` OPENED; T3 HALF FULLY DISCHARGED AT CYCLE 35 AFTER EIGHT CYCLES.**
src-0007's released IoC matcher is **one-directional, not two**: `any(pred.lower() in gt.lower() for gt in
gt_set)` — **a prediction must be a SUBSTRING OF a ground-truth entry**. The two-directional and exact-match
variants are **inside triple-quoted string literals and never run**. **The bias is ASYMMETRIC:** lenient
toward short/fragmentary predictions, **strict against verbose predictions**, which are penalised **TWICE**
(FP and FN). The shared normalisation chain partly mitigates the deflation by stripping defanging and
truncating at `" - "`. **"Substring-permissive, inflates true positives" is half right and must not be
repeated unqualified. NET SIGN UNKNOWN.** *Cycle 36 propagated this into `scores.json` on two issues — see
[34] — which is the downstream half nobody had done.* **`ctr-0004` STAYS OPEN** because its subject is now the
live MATCHER confound on `ctr-0001`.

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005` OPENED; REPAIRED
BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images — **confirmed a third time**. But
the page states in plain text: a **41 min/report human-analyst baseline** against ~**3.3 min**; **17 metrics
each a ratio 0–1**; and **"the LLM temperature parameter was set to 0"**. **The temperature-0 fact strengthens
`consistency-calibration-as-failure-mode`** and was fenced off for three cycles by an over-broad hedge.
**Standing lesson: a hedge is a claim and must be scoped as precisely as an assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED AGAINST
`ttp-attack-mapping-reliability`; CLOSED AT CYCLE 31.** **(a)** Section 4.2 says *"We adopt the **Micro-F1**
score…"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's metric is ambiguous by the paper's own
text.** **(b)** The cross-task difficulty comparison was **ours** and subtracts multi-class **accuracy** from
multi-label **F1**. **(c)** key_claims[2] is **FALSE against Table 1**. **(d)** The **ATT&CK correctness rule
is never stated**. **(e) arXiv v2 has NO CTI-ATE task at all** — always fetch v3. *(a) and (d) are NOT
repaired and cannot be from this paper — they travel as permanent qualifiers, and they are why `ttp` is held
at 2.*

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29 AND AGAIN BY 33 AND 36.**
`attribution-confident-wrong-gap` **bundles a well-evidenced question with an unevidenced one, and only a T2
can fix it.** The **error-rate** half is well grounded (src-0002's derived 14–64% incorrect bucket on 50
alias-tolerant real reports). The **confidence** half has **no evidence at all** — no source in this base
measures expressed confidence on threat-actor attribution. Natural cut: `attribution-error-rate` vs
`attribution-confidence-calibration`. **Next T2 is cycle 51.** *Successors must not quote the corroborating
parenthesis unqualified: the "within-table rubric contrast" as stated differences two different metric
definitions ([47]). The direction survives at **block** level only.*

**[46] — NEW cycle 29; `ctr-0007` OPENED; FULLY DISCHARGED AND `ctr-0007` RESOLVED AT CYCLE 35 AFTER SIX
CYCLES.** src-0008 contains two self-contradictions and its per-phase numbers are image-locked. **(a) THE
STORED CLAIM IS OVER-GENERAL** — *"Cohere, however, shows progressive degradation: 1% missed detections in P1,
2% in P2, 5% in P3, and in P4, 65% misses plus 35% explicit 'Don't Know' responses"* — and **P1–P4 contain no
cryptography**. **(b) IT DEFINES ITS METRICS TWICE, INCOMPATIBLY.** **(c) PHASE LABELS** — see [5]. **(d)
PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so the stored percentages are **figure-derived**. **(e)
TABLE 6 IS READABLE AND WAS NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 / 35 / 22.8%, **aggregates over all
thirteen phases, never per-phase**. **(f) PASSED:** Table 7 and the abstract. *Cycle 35 decided the question
cycle 29 declined: the model-side variance **cuts both ways**, the candidate stays `proposed`, and **src-0008
cannot adjudicate the hypothesis at all** because its task is JavaScript source code while the candidate is
about narrative threat reports. src-0008 is **demoted to illustration only**, retained to preserve the trail.*
**What the closure does NOT repair: `key_claims[0]` still literally contains the over-general sentence and
cannot be deleted; its correction is `key_claims[3]`; anyone citing [0] must read [3].**

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME; THE JUDGE IS A
MODEL UNDER TEST; `ctr-0008` OPENED. (d) DISCHARGED AT CYCLE 33.** **(a)** Appendix C.2 prints separate
criteria blocks. **Threat Actor**: *"…5: Fully attributable; all details are clearly linked to the original
article."* — **source linking**. **Root Cause**: *"…5: Perfect attribution; clearly identifies the threat
actor."* — **actor identification.** **The labels run OPPOSITE to how the state read them.** **(b) WHAT
SURVIVES:** the **block-level** contrast — GPT-4o lower on **all six** dimensions (1.547 / 1.528 / 1.145 /
2.019 / 1.734 / 1.140 vs 3.686 / 3.458 / 3.362 / 3.932 / 3.753 / 3.612). **(c) THE JUDGE IS GPT-4o**, one of
the four scored models; in the source's favour, *"an agreement rate … exceeding 95%"*; self-preference would
inflate GPT-4o's own scores and GPT-4o scores **lowest**. **Any citation of the GPT-4o-vs-o3-mini gap must
state that GPT-4o was the judge.** **(d) — DISCHARGED CYCLE 33.** **(e)** The third candidate's stated reason
for being `proposed` is discharged ([19]). **(f) ACTION, STILL OPEN AND NOT MINE:** `eval/threat_actor.py` **was
NOT obtained verbatim** — the fetch returned a summary, untrustworthy under rule (ix). **Re-fetching it
verbatim is step 1 of `ctr-0008`'s repair and remains a job for a T3 targeting
`attribution-confident-wrong-gap`.** *Cycle 35 confirmed the file exists and its size —
`stage3_ti_drafting/score_evaluation/eval/threat_actor.py`, 7,017 bytes — so the fetch is known to be cheap and
the file small enough to return whole. **Passed on undone for the third time at cycle 36.***

**[48] — FORMALISED AT CYCLE 32. A PROVENANCE GRANULARITY SPLIT IN src-0012.** `src-0012.md` carries the
corroborating Going Concern URL in full, but `index.json`'s `key_claims[3]` names the outlet **without its
URL** and `key_claims[0]` attributes the study's **2025** date **with no outlet at all**. The `consulting.ca`
headline URL states **no year**; the year **is** supported verbatim by Going Concern. **A granularity weakness,
not a fabrication.** No contradiction warranted. **Cheap fix for any future cycle touching src-0012: append
the outlet and URL to the two `index.json` key_claims.**

**[49] — FORMALISED AT CYCLE 32 FROM CYCLE 31's NEAR-MISS; APPLIED PRE-EMPTIVELY AND SUCCESSFULLY AT CYCLE
35.** A byte-size check from the hosting API must precede any ABSENT verdict over a large file. Cycle 31
fetched `data/TTP_Mapping.csv` twice and got 57 lines / 59 TechniqueIDs with four ABSENT verdicts. **Taken at
face value that is a devastating finding. It is false.** The GitHub contents API reports the file at
**1,083,078 bytes**; both readings were **truncation artefacts** and the ABSENT verdicts are **void**. **This
is the limit of [38]: both URL forms can fail the same way for the same reason.** *Cycle 35's Job E applied
this **before** fetching: the **HuggingFace tree API with `recursive=true`** returned a complete 52-file
listing with byte sizes in one call, made the "no per-model predictions" verdict authoritative, and
independently re-confirmed the 1,083,078-byte figure from a different host. **For any HuggingFace repo, hit
the tree API first.***

**[50] — NEW cycle 32; HARNESS HALF FIXED BY A HUMAN AT CYCLE 33.** A cycle can land its research, fail its
bookkeeping, and be committed as "run failed, no state change". Cycle 31 exhausted `max_turns: 50` after
committing four state files but before writing its last three log sections, **any carry-forward section**, or
either queue file, and `git log` describes it as **"run failed, no state change"** — **wrong on both counts**.
**THREE THINGS FOR A HUMAN. (1)** The commit message should be derived from `git diff --stat` on `state/`, not
from the CLI's exit status. **(2)** Writing the queue and `last_completed_task.txt` **before** the log would
fail safe. **(3)** A cycle that hits `max_turns` should be retried as the SAME task. *(3) is fixed by commit
`956a36c`. **(1) and (2) remain undone**, and (1) is the one that misleads successors.* **FOR SUCCESSORS:
verify the phase from `next_task.json` AND `last_completed_task.txt` AND `git show --stat`, and disbelieve the
commit message.** *Cycles 35 and 36 both did this (all three agreed each time) and both **voluntarily adopted
(2)**, writing the queue files before the log.*

**[51] — NEW cycle 32. FOUR REFINEMENTS TO THE G2 MECHANISM.** **(a) SELECT BY REPLICATION COUNT, NOT ONLY BY
STALENESS, WHEN SOMETHING LOAD-BEARING IS ONE FETCH OLD** — extends [36]. **(b) "WHICH TEXT EXECUTES" IS NOT A
PRESENT VERDICT AND CANNOT BE TRUSTED FROM A STRING MATCH.** Where a docstring and a live branch describe
**different** rules, both are PRESENT and exact-string checks settle nothing. **`ctr-0004` and the cycle-31
finding are the two known instances of documentation-vs-execution divergence; assume more.** **(c) READ THE
STATE BEFORE RE-DERIVING ANYTHING FROM A LOG.** **(d) READ THE LOG WHEN THE STATE CITES A DERIVED NUMBER** —
`ctr-0010` exists because the state's description of a derived quantity was checked against
`logs/cycle-018.md`. (c) and (d) are not in tension: (c) says do not re-derive a fact from a log when the state
holds it; (d) says a DERIVATION's provenance lives only in the log. *Cycle 34's third selection criterion:
**SELECT BY WHAT THE SCORE DISTRIBUTION DEPENDS ON** — when one issue stands alone at the top of the graph, its
evidence is the least-checked load-bearing thing in the project by definition.* *Cycle 36 adds **(e): SELECT BY
UNCHECKED PROVENANCE.** Two of the last two G2s found their most durable result on the `/abs` page rather than
in the numbers, and provenance is the one axis where a source can be wrong in a way that no amount of
number-checking reveals.*

**[52] — NEW cycle 33. A CONTRADICTION ENTRY CARRIES EXACTLY ONE `issue_id`, BUT ITS CONTENT CAN DAMAGE
SEVERAL ISSUES — AND THE GATE SEES ONLY ONE OF THEM. A SIXTH SHAPE FOR [41]; FOR A HUMAN.** `ctr-0008` is filed
against `attribution-confident-wrong-gap`. Its content materially damaged **three** issues, and by its own text
the largest exposure was **elsewhere**. But `jq` over `.contradictions[] | select(.resolved_cycle==null)`
groups by `issue_id`, so the G3 gate, the T5 selector and every per-issue query saw the exposure on **exactly
one** of the three. **Three options for a human, in ascending cost: (i) allow `issue_id` to be an array; (ii)
require the opening cycle to file a stub entry against each affected issue, cross-referenced; (iii) accept the
limitation and require every T4 to grep contradiction *bodies* for issue ids rather than trusting the
`issue_id` field.** *Cycle 33 chose (iii) plus `ctr-0009`. **Cycle 36 is a live instance in the other
direction: `ctr-0004`, filed against `ioc`, produced the finding that forced two `scores.json` corrections on
`ttp` and `task-dependent` ([34]). The gate saw none of it.***

**[53] — NEW cycle 33. THE ARXIV VERSION CHECK IS CHEAP, IT HAS PAID OFF, AND A REVISION CAN RENUMBER THE
TABLES A STORED CLAIM CITES.** One fetch of `arxiv.org/abs/2602.06718` revealed a **v2 (14 May 2026)** of
src-0011 that no cycle had noticed in twenty-one cycles. **Every headline quantity survives unchanged.** **But
the per-venue table is `Table 3` in v1 and `Table V` in v2, and v2's `Table 3` is an entirely different
per-model table.** A future cycle fetching the current version and asking for "Table 3" would receive unrelated
content **and could open a spurious contradiction against a clean source**. **Two standing rules: (a) run the
`/abs` version check on every arXiv source you touch; (b) when a stored claim cites a table BY NUMBER, either
pin the version in the URL or ask for the table BY DESCRIPTION.** *Known version traps: src-0002 (v2 has no
CTI-ATE task — fetch v3), src-0011 (v2 renumbers). Cycles 35 and 36 cleared src-0007, src-0013 and **src-0014**
— all v1 only, none carries the hazard. **Seven of eighteen sources now checked on this axis.***

**[54] — NEW cycle 33, CONFIRMED AND SHARPENED AT CYCLE 34, **RE-CONFIRMED AT CYCLE 36**. THE SCORE
DISTRIBUTION HAS COLLAPSED TO A SEVEN-WAY TIE AND THE WEAKEST-LINK SELECTOR IS NOW EFFECTIVELY THE TIE-BREAK.
FOR A HUMAN, AND FOR THE PAPER.** The graph reads `institutional-incident-real-world-impact` 3, all seven other
issues 2. A selector that picks the weakest issue cannot discriminate among seven equals, so the
under-specified tie-break of [11] and the never-expiring `created_cycle` fallback of [30] are doing **almost
all of the selecting**. *Cycle 33 considered whether this justifies scoring less harshly and concluded it does
not: `prompts/t4_assess.md` step 5 is explicit that optimistic scoring breaks the selector. **The right
response is to flag the mechanism, not to distort its input.** **Cycle 36 faced the same temptation from the
other side** — a cycle of genuine investigative progress on `ioc` that moves no score — **and reached the same
answer: "better understood" is not "better supported", and inflating to reward effort would corrupt the one
input the selector has.*** **(a)** A stingy rubric applied honestly is **compressive** — issues fall toward the
level their weakest leg supports and pile up there — so a weakest-link selector degrades exactly as assessment
discipline improves. **(b)** The scoring scale does two jobs at once — *reporting* evidential state and
*ranking* work — and they need different resolutions. **CYCLE 34's EMPIRICAL TEST: actionability DID NOT
DISCRIMINATE — five of seven tied issues have named undone jobs. Actionability is a good *filter* and a poor
*ranker*.** What decided cycle 34 was **staleness of last attempt**. **Recommendation: replace the
`created_cycle` fallback with a staleness/aging term.**

**[55] — NEW cycle 34. `automated-triage-under-refusal` IS PERMANENTLY STARVED BY THE TIE-BREAK, AND THIS IS
PROVABLE IN ADVANCE RATHER THAN OBSERVED AFTER THE FACT. VERBATIM FOR A HUMAN. THE STRONGEST FORM OF [30].**
Three issues beat it on `created_cycle`: `ttp`, `ioc` and `consistency` (all created 2, all upstream-maximal
under 3a, all scored 2). It can only win when **all three simultaneously** carry a 3b recent-attempt penalty.
Under the T5→T3→T4→T5 loop a T5 fires every 3 cycles and each produces exactly one T3 attempt one cycle later,
so attempts land on cycles 35, 38, 41, 44, 47 … spaced 3 apart, and **a 5-cycle lookback window contains at
most two of them**. At most two of the three can ever be penalised at one T5; **at least one always has penalty
0 and beats `created_cycle` 16.** The selector rotates `ttp` → `ioc` → `consistency` indefinitely and this
issue is **structurally unreachable**. **Caveats:** the proof holds only while those three stay tied at 2,
while no T1/T2 alters the graph (cycles 50 and 51 could), and while the loop does not fail a cycle. **Cycle 36
re-scored all three at 2, so the proof's precondition is re-established for cycle 37.** **CONSEQUENCES ALREADY
VISIBLE:** [15]'s curl/HackerOne case (twelve cycles as the top uncollected source), [27]'s src-0015 Reward
column (sixteen cycles unentered, and verified genuinely undone this cycle), and the **never-read triage
scorer** in the src-0017 artefact — the one evaluator of three in that repository nobody has read, by a route
proven at cycles 27, 31, 32 and 35. **PROPOSED FIX, one line in `prompts/t5_select.md`:** add an **aging term**
before the `created_cycle` fallback — subtract 1 from the effective score per N cycles since `last_attempt`
(using `created_cycle` for never-attempted issues). **Cycle 34 did NOT override the mechanism to fix this**:
overriding hides the defect behind a one-off correction. Passed on verbatim with [4], [11], [30], [41].

**[56] — NEW cycle 34, from the G2 bolt-on. A LOOSE THREAD ON THE ONLY ISSUE SCORED ABOVE 2. NOT A
CONTRADICTION.** src-0010's page serves its PDF as `ENISA Public Administration TL **2024** - v1.2.pdf` while
the same page states a publication date of **November 6 2025**, and src-0004 places that report in the
"published last October and November" pair. **No stored claim records that filename, so nothing conflicts and
[32]'s test says DO NOT FILE.** But a filename is weaker evidence than a page's own date field and no defect is
asserted. **For whichever cycle next touches `institutional-incident-real-world-impact`:** ask whether ENISA's
Public Administration Threat Landscape is a **2024-titled report republished in November 2025** or whether the
filename is a legacy artefact. *Related: [14] says the v1.2 PDFs cannot be opened, so try the page's own
metadata or the EU publications catalogue instead.*

**[57] — NEW cycle 35. `ctr-0010`: A DERIVED QUANTITY HAS BEEN CARRIED WITH THE WRONG SCOPE FOR SEVENTEEN
CYCLES, AND NO CHECK THIS PROJECT RUNS COULD HAVE CAUGHT IT. **STEP (i) DISCHARGED AT CYCLE 36; STEPS (ii) AND
(iii) OPEN**.** The state said the 0.09–0.15 range is the IoC recall needed to reconcile src-0003's 97.6% F1
with src-0007's 0.82–0.88 precision. `logs/cycle-018.md` shows it is the recall at which **src-0007's IoC F1
falls to src-0007's own TTP F1** — a within-src-0007 crossover in which **src-0003's number is not an input at
all**. **THE UNDERLYING ARGUMENT AND EVERY NUMBER ARE CORRECT; ONLY THE SCOPE IS WRONG.** **(a) THE CONCLUSION
IS TRUE AND HAS A CHEAPER PROOF:** `F1 ≤ 2P/(P+1)`, so an F1 of 0.976 entails `P ≥ 0.9531`; that is a
**precision**, comparable directly with src-0007's precisions, so **the METRIC confound is eliminated
deductively with a margin of 0.069 (vs fine-tuned GPT-4o) to 0.129 (vs vanilla GPT-4o)**. *Cycle 36
**re-derived the algebra independently** (`dF1/dR = 2P²/(P+R)² > 0`; `1.024P ≥ 0.976`; `P ≥ 0.953125`) and it
reproduces, and **replaced the mis-scoped sentence in `scores.json` in place**, retaining the 0.09–0.15 figure
with its true scope as an IoC-versus-TTP crossover. **Step (i) is DONE.*** **(b) A FOURTH CONFOUND IS NOW LIVE
ON `ctr-0001` — MATCHER.** To close 0.069 the one-directional rule would have to net-deflate src-0007's
precision by 6.9 points; the rule is lenient in the other direction too, the normalisation chain closes the
commonest deflation channel, and **src-0003 never states its own rule** ([33]) so the correction is unsigned on
both sides. **Not settleable from any released artefact** ([7]). **(c) THE METHODOLOGICAL POINT:** this defect
is invisible to every check the loop runs — not a quotation, so string-matching cannot reach it; not a source
claim, so no G2 re-fetch can reach it; and the number is correct, so recomputation confirms it. **It was found
only by reading the log that PRODUCED the number rather than the state that cites it.** **DERIVED QUANTITIES IN
THIS BASE HAVE NEVER BEEN SYSTEMATICALLY AUDITED. Known unaudited ones: src-0001's four derived ECE means,
src-0002's five derived plausible-but-not-correct percentage points, src-0006's derived F1 ranges, cycle 18's
src-0006 crossover means (0.272 / 0.263, which [23] and [54] both lean on), and the four normalisation figures
on `extraction-vs-reasoning-ordinal-axis`'s route 2.** A human should consider whether `prompts/system.md`'s G2
rule — "re-check it against its cited sources" — needs a second limb for conclusions whose provenance is a
computation rather than a source. **STILL UNDONE: step (ii)** — `ctr-0001`'s cycle-21 update carries the same
mis-statement and must be annotated by whichever cycle next touches the graph; **a T4 has no standing to edit
`graph.json`.** **Step (iii)** says nobody should re-derive the crossover arithmetic; cycle 36 honoured that and
re-derived only the *entailment*, which is a different quantity.

**[58] — NEW cycle 35, STILL UNRECORDED AT CYCLE 36. src-0007 IS PEER-REVIEWED AND PUBLISHED, AND THIS BASE HAS
NEVER RECORDED IT.** One `/abs` fetch of `arxiv.org/abs/2603.09452` returns, verbatim, **`Comments: Accepted at
TMLR`** and **`Journal reference: Transactions on Machine Learning Research (2025), ISSN 2835-8856`**. Also:
**v1 only**, submitted 10 Mar 2026, so no [53] renumbering hazard on the Table 4 claims. **src-0007's
`index.json` entry records neither fact.** *Appending a provenance key_claim is clean, cheap, self-contained and
**permitted** — cycle 36 did exactly that for src-0014 with no difficulty, which removes the last excuse. **Any
cycle with spare budget should just do it.*** **This is the third provenance label found wrong or unrecorded,
after src-0001 (called a preprint for 24 cycles, actually ARES 2025) and src-0005 (assumed reviewed, actually an
unreviewed preprint).** *src-0017's `[TMLR '25]` badge is **partly explained** — src-0017 is src-0007's artefact
release and src-0007 is a TMLR paper. The year discrepancy (TMLR 2025 against a March 2026 arXiv submission)
remains unexplained and should not be guessed at.*

**[59] — NEW cycle 35, VINDICATED AGAIN AT CYCLE 36. A TRACKING ENTRY THAT SAYS WORK IS OUTSTANDING IS EVIDENCE
THAT SOMEONE ONCE THOUGHT SO, NOT EVIDENCE THAT IT IS OUTSTANDING NOW.** Cycle 34's handoff gave cycle 35 five
jobs and **two premises of Job D were false**: (1) three `scores.json` rationales were said to still repeat a
"two-directional SUBSTRING CONTAINMENT" characterisation — `grep -c` returns **0**; **cycle 33's T4 discharged
it and nobody updated the tracker**; (2) `ctr-0004`'s own step (iii) asserted the rationales "cannot be edited
retroactively under append-only discipline" — **false**, `scripts/validate_state.py` lines 100–107 protect
`index.json` `key_claims` and the **existence** of `src-*.md` files **only**. **THE GENERAL LESSON:** this loop
has no mechanism that marks a carry-forward item or a resolution step as done when some *other* cycle does the
work incidentally. **Before spending a turn on any item described as undone, verify it against the artefact,
not the tracker.** *Cycle 36 applied this to [27] — checked the graph directly rather than trusting sixteen
cycles of carry-forward — and found the item **genuinely still undone**, which is the first time the check has
returned "still open". **The check is worth running in both directions: it is as capable of confirming a stale
item as of retiring one.*** *Related to [51](c) and (d).*

**[60] — NEW cycle 36. RULE (ix) CUTS BOTH WAYS: A SUMMARISED READ CAN MANUFACTURE A DEFECT THAT IS NOT THERE,
NOT ONLY CONCEAL ONE THAT IS. THE FIRST NEAR-MISS OF THIS KIND IN THE PROJECT.** Cycle 36's **first** fetch of
src-0014 returned a summarised claim that Table 2's percentages *"refer to abstention rates … not a separate
coverage column"* — i.e. that the paper's body sentence labels as **coverage** the same numbers its table labels
**abstention**. That is the **`ctr-0007` / `ctr-0008` metric-identity shape exactly**, and on the evidence in
hand it would have been filed. **A second fetch asking for Table 2 VERBATIM disproved it**: the S-C column reads
49.00 / 51.07 / 39.15 / 60.96 / 75.96 and the paper defines *"coverage as one minus abstention rate"*, so the
body sentence's 51.00 / 48.93 / 60.85 / 39.04 / 24.04 are **exactly** `100 − cell` for all five models. **The
source is internally consistent and the defect did not exist.** **THE RULE: BEFORE OPENING A CONTRADICTION ON
THE STRENGTH OF A SUMMARY, GO BACK AND GET THE ARTEFACT VERBATIM.** **A FALSE CONTRADICTION IS MORE EXPENSIVE
THAN A MISSED ONE, because it is entered as a finding and every later cycle inherits it** — this base has spent
cycles 27, 30, 31, 33 and 35 unwinding *correct* findings whose *characterisations* were wrong, and a wholly
spurious entry would be worse. *Note the interaction with [31]: seven consecutive clean checks could mean the
sources are clean or that the checking has stopped biting. **This near-miss is evidence for the first reading —
the check was sharp enough to find a candidate defect and disciplined enough to kill it.***

**[61] — NEW cycle 36. A T4 MAY AND SHOULD RESTATE AN OVER-PRECISE GLOSS INSIDE ITS OWN `scores.json`
RATIONALES, AND THAT IS A THIRD REPAIR CHANNEL THIS LOOP HAD NOT USED.** `ctr-0010` step (i) established the
permission (`scores.json` is unprotected by validator lines 100–107) but framed it as a one-off. Cycle 36 used
it three times: once as instructed, and **twice unprompted** on glosses that cycle 35's `ctr-0004` work had
falsified — see [34]. **THE PATTERN WORTH NAMING: a finding lands in the graph, and its consequences for the
`scores.json` rationales that cite the falsified version are nobody's named job.** G2 cannot reach them (not
source claims), G3 cannot reach them (not conflicts between two graph claims), and the T3 that produced the
finding has no standing over `scores.json`. **Only the next T4 can, and only if it re-reads the rationales
against the graph rather than carrying them forward.** *Cycle 36's practical rule for successors: after any
cycle that reads a scoring rule or falsifies a characterisation, the next T4 should **grep its own rationales
for the falsified wording** before stamping `assessed_cycle`. That is cheap — `grep -c -F` on `scores.json` — and
it caught two instances this cycle.* **For a human: this is a fourth mechanism in the family [41] names — the
better the T3s get at finding characterisation defects, the more stale characterisations accumulate downstream
in `scores.json`, and nothing but a diligent T4 clears them.**
