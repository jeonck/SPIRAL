# Cycle 032 — T3 Investigate — `ttp-attack-mapping-reliability`

Queue entry: `state/queue/next_task.json`, **written by cycle 30**, task type **T3**,
`target_issue: ttp-attack-mapping-reliability`, `attempt_count: 0`. I read
`prompts/t3_investigate.md` myself rather than trusting the queue entry's account of it
(carry-forward [29]). The handoff was accurate on the rules I checked: a T3 **may** add sources
(step 2), **may not** split an issue, **may not** rescore. **Four clean handoffs in a row.**

**No new source added.** Everything read this cycle lives at URLs already covered by `src-0017`.
`max_new_sources` untouched; `index.json` still holds **18** sources.

---

## Task performed

### First, the thing that determines what this cycle even was: cycle 31 did not fail

`git log` records cycle 31 as **"cycle 31: T3 investigate run failed, no state change"**. **Both
halves of that message are wrong and I verified it at source before acting on anything.**

`git show --stat 3bd4379` shows cycle 31 committed **`state/issues/graph.json`,
`state/knowledge/index.json`, `state/knowledge/src-0012.md` and `state/knowledge/src-0017.md`**.
Its transcript ends `Error: Reached max turns (50)`. So cycle 31 ran out of turns **after** landing
its research and **before** finishing its bookkeeping. What it actually left undone:

- `logs/cycle-031.md` has **`## Task performed` and `## Retrospection` only** — no
  `## Changes made`, no `## Next task rationale`, no `## Budget`, **and no carry-forward section
  at all**, so items [1]–[47] were about to be dropped from the chain entirely.
- `state/queue/next_task.json` was **never rewritten** — it still held cycle 30's T3 entry.
- `state/queue/last_completed_task.txt` still read **`T5 select`**.

That last one is the dangerous one. A successor trusting `last_completed_task.txt` would have
concluded T5 was the last completed task and re-derived the phase as T3-next — which happens to be
right by accident, because the unconsumed queue entry *was* a T3. **The two files agreed only by
coincidence.** New carry-forward **[50]**.

**So this cycle's honest job was not to redo cycle 31's T3.** Its substantive work had landed and
`prompts/t3_investigate.md` steps 1–6 were all discharged against the target issue (I checked each
one in `graph.json`: candidate 1 rewritten, candidate 2 given a withdrawal addendum, candidate 3
added, `open_questions` rewritten to five entries, `attempts` = `[16, 31]`, `ctr-0006`
`resolved_cycle` = 31). Re-doing it would have overwritten better-sourced text with a second
opinion. My job was **(a)** the mandatory G2, **(b)** one genuine increment on the issue, and
**(c)** the bookkeeping cycle 31 never reached.

### The increment: what cycle 31's log and its state disagree about

Reading `index.json`'s `src-0017` entry against `logs/cycle-031.md` produced a live instance of
methodological rule (vi) **running backwards**. Cycle 31's `key_claims[5]` records five findings
its own log never mentions — the naive-CSV-parser problem, the broken `--ttp-mapping` option, the
F1-only-in-`main()` point, and two `README.md` self-inconsistencies. **The state is richer than the
log that describes it.** Rule (vi) warns that a source can be clean while the state's account of it
is not; the converse holds too, and a successor reading only the log would have re-derived work
already banked. Recorded as **[51]**.

That is why my addition below is narrower than it would otherwise have been: most of what I found
independently, cycle 31 had already written down. What survives as new is one finding, and it is
the good kind — it makes an existing supported claim **stronger**, not weaker.

---

## Retrospection

**G2 subject: `ttp-attack-mapping-reliability`'s candidate 3 (`evidence: [src-0017, src-0007]`)**,
the ATT&CK/TTP scorer reading added at cycle 31. **Result: PASSES CLEANLY.** No contradiction
opened; none warranted.

**I departed from the queue's recommended subject and the reason matters.** The queue recommended
by **staleness** (`src-0012`, then `src-0011`). Cycle 31 took `src-0012`. Staleness would have sent
me to `src-0011` (last verified cycle 14). I chose by **replication count** instead, because
candidate 3 was:

- **one fetch old** — the least replicated conclusion anywhere in the state;
- the stated basis on which **`ctr-0006` was closed**, lifting a G3 exposure; and
- produced in a cycle that, by its own admission, had **one fetch return a summary instead of
  verbatim text** (`threat_actor.py`) and **two fetches return truncation artefacts** it nearly
  recorded as findings.

A contradiction closed on an unreplicated fetch from a cycle with three known bad fetches is
exactly the exposure G2 exists to catch. Staleness is the right default; it is not the right
criterion when something load-bearing is one fetch old. New carry-forward **[51]**.

**Method.** `stage3_ti_drafting/ttp/eval/compute.py` re-fetched whole from
`raw.githubusercontent.com`, instructed to reproduce verbatim or write CANNOT READ; ten
exact-string checks against the strings stored in the state; then one separate targeted question.

**All ten checks PRESENT and exact** — the `article_ttps_set` comprehension, the
`validated_ttps_set` assignment, the `tp`/`fp`/`fn` lines, both `overall_` ratio lines, the
docstring sentence *"do NOT add this TTP to the final validated TTPs"*,
`corrected_details = ttp_mapping[ttp_id]`, `validated_ttps_final[ttp_id] = corrected_details`,
`json5`, `except Exception`.

**The load-bearing point was checked separately, because no string match can settle it.** Cycle
31's central claim is that the live `else`-branch *contradicts* the docstring above it. A string
match confirms both texts exist; it cannot tell you which one runs. So I asked for the branch
reproduced with its indentation **plus an explicit verdict on whether it is live code or sits
inside a triple-quoted string, comment or docstring**. Answer: **LIVE**. The
docstring-contradicts-code finding is replicated, and it is confirmed as a *different* mechanism
from `ctr-0004`'s dead string literals rather than another instance of them.

### The one addition: the scorer discards the data that would let it be lenient

I read the **head** of `data/TTP_Mapping.csv` under an explicit instruction to **make no claim
about the whole file** — it is 1,083,078 bytes, it truncates, and cycle 31 retracted two readings
of it that were truncation artefacts. Header row, verbatim:

```
,TechniqueID,name,longdescription,is sub-technique,sub-technique of,description,tactics
```

On a 0-based naive comma split, field 1 = `TechniqueID` and field 2 = `name`. That **confirms**
`load_ttp_mapping`'s `fields[1]`/`fields[2]` select the intended columns — an inference cycle 31
made without having checked the column order.

**But field 5 is `sub-technique of`, and it carries the parent ID.** Verified on real data rows:
`T1548` with `is sub-technique` = `FALSE` and an empty parent; `T1548.001`, `T1548.002`,
`T1548.003`, `T1548.004` and `T1548.005` each with `is sub-technique` = `TRUE` and
`sub-technique of` = `T1548`. (`.005` is new — cycle 31 quoted only `.001`–`.004`.)

`load_ttp_mapping` reads **only** `fields[1]` and `fields[2]`. **It discards field 5.**

> The parent-child relation needed to award parent-level credit for a sub-technique prediction is
> **present in the scorer's own mapping file and thrown away by the loader.**

This upgrades candidate 3's central finding. "The scorer implements no partial credit" is a fact
about an omission; "the scorer discards the parent-child data that would enable partial credit" is
a fact about a **choice**, and it is the sharper claim. It also puts the double-penalty scenario
beyond inference: a parent ID and its sub-technique IDs are **simultaneously admissible keys in
the same mapping**, so both legs of the double penalty are demonstrably reachable rather than
hypothesised.

**Two smaller points, recorded so they are not later mistaken for defects.** (1) Cycle 31's
naive-parser pollution is **scoring-inert**, for a reason it left unstated: continuation lines of
quoted long descriptions do enter as candidate rows, but their `fields[1]` values are prose
fragments that cannot equal a technique ID — and even if one did, the only corruptible thing is a
mapped **name**, which is inert because a name mismatch *keeps* the entry anyway. No `tp`, `fp` or
`fn` can change. (2) The header line itself satisfies the parser's conditions and enters as
`ttp_mapping['TechniqueID'] = 'name'`. Also inert.

**Cycle 31's retraction stands unchanged.** My own fetch of that file was truncated too, by design
and by instruction. **No cycle has yet found a route to the mapping's row count** and none may
state its coverage.

**Twelve source-checks have now run; nine produced a defect.** This is the **third** consecutive
clean one (`src-0012` at c31, this at c32). Worth stating plainly rather than treating a clean
result as a non-event: three clean checks in a row is the first evidence in this project that the
verbatim-plus-metric-definition discipline has begun to exhaust the defect backlog rather than
merely sampling it.

---

## Changes made

**`state/issues/graph.json`** (not append-only-protected; every edit `jq -e`-validated and
`jq -r`-read-back):

1. `attempts` on `ttp-attack-mapping-reliability`: `[16, 31]` → **`[16, 31, 32]`**.
2. **Candidate 3** — cycle-32 addendum **appended, nothing substituted**: the ten-check
   replication, the separate live-code verdict on the mismatch branch, the `sub-technique of`
   discard, the two inertness notes, and an explicit statement that nothing is retracted.
3. **`open_questions[4]`** — updated in place. Sub-question **(b)** is now **partly answered**:
   the mapping's *schema* is known and demonstrably admits both granularities, so candidate 3's
   double-penalty consequence **no longer depends on the unknown total**. The total remains
   unknown and cycle 31's retraction is restated. Sub-question **(a)** — ground-truth granularity
   in `100-days-articles.json` — is **completely untouched and is now the more important of the
   two**, since it determines *how often* the exact-ID rule double-penalises. I named **two cheap
   routes neither cycle 31 nor I tried**: `stage3_ti_drafting/ttp/example/` and the worked
   two-article example in `ttp/README.md`. I also recorded that the `if " - " in ttp` filter makes
   this a question about the **recall denominator**, not only about granularity.

**`state/knowledge/index.json`** — one key_claim **appended** to `src-0017` (now 9), carrying the
G2 verdict, all ten verified strings, the live-code verdict, the `sub-technique of` finding and the
two inertness notes.

**`state/knowledge/src-0017.md`** — matching section appended, per the repair-both-places
discipline that cycles 22, 23, 25–31 all followed and whose omission let `src-0016`'s defect
survive six cycles.

**No score changed** — a T3 has no standing. **No contradiction opened** — the G2 passed. **No
existing `src-*.md` file or key_claim was deleted or rewritten.** **`ctr-0006` was left closed at
`resolved_cycle: 31`**; I re-read its closure argument and it is sound, and my replication
strengthens rather than disturbs it.

**What I deliberately did not do.** I did not re-run cycle 31's T3, did not touch candidates 1 or
2, and did not act on `ctr-0008`'s repair (a job for a T3 targeting
`attribution-confident-wrong-gap`) or on [42]/[46] (jobs on `ioc-extraction-reliability`). All are
passed on undone and named below.

---

## Next task rationale

**T3 → T4** per the state machine, `target_issue: null` — a T4 scores **every** issue.

**The phase has shifted a second time, and the collection cycle has moved again.** Cycle 30
predicted the next T1 at cycle 43 and the next T2 at 44. That is now **void**, because cycles 31
and 32 were **both T3s on the same queue entry**. Re-deriving from `config.yml`
(`collect_refresh_every: 7`) and the T3→T4→T5→T3 loop: 33 = T4, 34 = T5, then T5s at **37, 40, 43,
46, 49**. Multiples of 7 are 35, 42, **49** — and 49 **is** a T5 cycle. So **the next T1 is cycle
50 and the next T2 is cycle 51.**

**One cycle running out of turns pushed the next collection cycle back by seven.** Cycle 28
recorded the same mechanism costing eight (cycle 24's crash). **Two partial failures have now cost
this project fifteen cycles of collection and restructuring capacity** — that is the single most
consequential structural fact here, it is worse than [28] recorded, and it belongs in the paper.
It also defers [15] (the curl/HackerOne source, now the top uncollected target for **eight**
consecutive cycles) and both T2 splits, [37] and [45], to cycle 51 at the earliest.

**What the cycle-33 T4 must price.** Four things changed on `ttp-attack-mapping-reliability` since
its cycle-29 demotion to 2, and the T4 should price them on merit: `ctr-0006` is **closed**, so the
issue no longer carries an open contradiction; candidate 1's unsupported cross-task comparison is
**gone**; candidate 3 is **new, and now replicated**; and candidate 2's within-table control is
**withdrawn**. Per the cycle-29 rationale that demotion was a **merit** judgement taken **under**,
not at, the G3 ceiling — so **nothing is automatically restored** by the closure, and the T4 must
not treat it as an entitlement. Separately, [34]/[47] scheduled the **cycle-32** T4 to price the
fifth non-commensurability instance; that is now the **cycle-33** T4's job.

---

## Budget

- **Fetches: 2.** `compute.py` (whole, verbatim, ten checks + live-code verdict) and
  `TTP_Mapping.csv` (head only, under an explicit no-whole-file-claim instruction).
- **Web searches: 0.** Nothing needed one; both targets had known URLs in `index.json`.
- **Turns: ~26 of 50** — deliberately well under, because cycle 31 died at 50 and the failure mode
  it produced is the one I spent the first part of this cycle repairing.
- **Reads/greps: ~12**, mostly `jq -r` projections over `graph.json` (~150 KB) rather than `Read`.
  `jq -e` + `jq -r` read-back after every JSON edit; all passed first time.
- **Edits: 5** (3 × `graph.json`, 1 × `index.json`, 1 heredoc append to `src-0017.md`), plus this
  log and the two queue files.
- **Notable cost saving:** reading `index.json`'s `src-0017` entry *before* fetching anything
  independently. Five of the findings I would have reported as new were already banked there by
  cycle 31, whose own log omits them.

---

## Carry-forward items

All items from `logs/cycle-030.md` reproduced **including those I cannot act on**. Cycle 31 wrote
**no carry-forward section**, so [1]–[47] would have been dropped from the chain here; they are
recovered from `logs/cycle-030.md` and updated with cycle 31's and 32's results. Discharged items
stay marked rather than deleted. **New: [50] and [51]. [48] and [49] are formalised from cycle
31's prose, which never filed them as items.**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Still vindicated. Cited as the
precedent behind [37] and [45].

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK
metric at all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in its
**twenty-first** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**, and
does NOT discharge it. [44] puts the 0.6388 itself in question. *Cycle 31 sharpened it rather than
answering it: now that the scorer's rule is known to be exact-ID matching with no partial credit,
a useful human baseline would have to be scored under the SAME rule — and exact sub-technique
assignment is a task on which two competent analysts would themselves disagree. Cycle 32 adds that
this is why the absolute magnitudes cannot be read as evidence about task difficulty for anyone.*

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30]. *It has lost **five**
consecutive selections; 3a was the mechanism each time.*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 23 CYCLES.** The G3 gate is
specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35 comment
(**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The enforced
reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in
`logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside
this agent's output surface. **Until a human applies it, T4s must apply the ceiling.**
*Cycles 31 and 32 are T3s and do not score, so the gate did not bind; I checked only that my edits
create no breaking state, and they do not — `ttp` sits at 2 and its contradiction is now closed.
The per-issue-versus-per-contradiction question stays live on `ioc` (three open) and `consistency`
(two). Awaiting a human, verbatim, with [11], [30] and [41].*

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is a
**self-contradiction in the source**, and our stored mapping is the **majority reading**. Table 3
puts XOR at P5 and AES-256 at P6; two body sentences agree, one stray sentence disagrees. Probable
cause: Table 3's row descriptions cross-reference level numbers shifted **+1**. No contradiction
entry per [32]'s test. *Standing lesson: an item recorded as "blocked by an infrastructure limit"
may only be blocked by the route the recording cycle happened to try.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv 2506.11325;
third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines; the paywalled
eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not retry). Forward-citation sweeps
have **FAILED on two arXiv ids**. CTIArena resolved and dead for consistency purposes. **SEvenLLM**
uncollected and downgraded. **AthenaBench** still has no URL. No arXiv companion exists for
src-0018. Unavailable: OpenReview, spiegel.de ([13]). **CTIBench's own released evaluation artefact
has never been sought** — and it is now `ttp`'s `open_question[3]`, the remaining half of
`ctr-0006`. *Cycles 31 and 32 spent nothing here.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT 22; ONE STEP AT 27; ANOTHER AT 31.** `ctr-0001`'s
resolution path. **Done:** released-code route exhausted; METRIC confound eliminated; **and cycle
31 read the TTP scorer, which this path also needed.** **Still open:** no head-to-head; the
**CORPUS confound is completely untouched and is the largest gap**. Remaining, cheapest first:
`huggingface.co/datasets/xse/CyberThreat-Eval`; then corpus difficulty. *Cycle 32 adds that the
rubric/judge scorer was located too (see [47]), so every code-reading step on this path is now
done and what remains is genuinely about corpora.*

**[8] — UPDATED cycle 32. G2 COVERAGE COMPLETE; TRACKED BY STALENESS, NOW ALSO BY REPLICATION.**
src-0004 (c4, c12), src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 —
`ctr-0002`; c28 — `ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial
fail [21]; re-pulled c18), src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), **src-0012
(c13; c31 — PASSES CLEANLY)**, src-0011 (c14), src-0007 (c15; c21; c30 — `ctr-0008`),
src-0009/src-0010 (c16), src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21 —
provenance partial fail, [31]), **src-0017 (c27 — `ctr-0004`; c32 — PASSES CLEANLY, one
strengthening addition)**, src-0018 (c28 — `ctr-0005`). *Next G2 by staleness: **src-0011** (c14),
then **src-0009/src-0010** (c16), then src-0013 (c18). **src-0011 is now the stalest source in the
base by four cycles and has been recommended and skipped twice** — it belongs to
`institutional-incident-real-world-impact` (at 3), its `proposed` candidate is unexamined since
collection, and its prose-vs-table self-contradiction ([18]) has never been re-checked. Not
recommended: src-0017 and src-0012 (just done), src-0007 (c30), src-0008 (c29), src-0002/src-0018
(c28), src-0005 (c26), src-0001 (c25).* **But see [51]: staleness is the default, not the rule.**

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25–32.** `python3` present but the
**permission layer** blocks it; compound commands rejected if any segment is unapproved. **No PDF
text extraction exists** — prefer `/html` always. `gh` not approved. `awk` refused. **`sed -n` and
`cat >>` heredoc ARE approved**; a heredoc append must be its **own** call. `jq -e . <file> >
/dev/null` approved, as is a compound `jq … && jq …` chain. Prefer **single-line `Edit` anchors**.
`scores.json` and `graph.json` are NOT protected by validator lines 105–107.
**`raw.githubusercontent.com` returns whole files.** *Cycle 32: all held. A bare `sed -n` over a
log was **refused** as part of a compound command, confirming the chaining rule again; the `Grep`
**tool** did the same job. Single-quoting every internal quotation again made multi-kilobyte
`Edit`s escape-free — that is now four cycles of evidence for pattern (c).*

**[10] — DISCHARGED CYCLE 26; NEVER ACHIEVABLE.** src-0005's per-model numbers do not exist in
text — every per-model score is inside Figures 8, 9, 12–16. **Do not re-attempt without a new
route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27 AND AGAIN AT 30. VERBATIM FOR A HUMAN.**
Tie-break 3a in `prompts/t5_select.md` is under-specified and there is **no deterministic
tie-break after 3c**. In three parts: **(a)** a terminal tie **must** be written into the prompt;
**(b)** the prompt lists **3a before 3b**, but 3b is an addition *to the score*, so a literal
a-then-b ordering lets them return **opposite verdicts on the same pair**; **(c)** "within the last
5 cycles" has three defensible readings. *Cycle 30 remains the richest data point: two terminal
ties in one cycle, broken on an explicitly extra-prompt criterion, with the window reading
load-bearing. Cycle 32 adds nothing and changes nothing — passed on verbatim with [4], [30], [41].*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The claim
that the loop "never returns to T2" is false; cycle 16 disproved it. *Cycle 32: **the next T2 is
now cycle 51**, not 44 — see [28]. [37] and [45] are both T2 jobs and both wait another nineteen
cycles.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
route is also closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own
writeup is the only remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level and
UNVERIFIABLE at document level here. **Do not re-spend budget.** *Caution from [5]: such limits
deserve one re-test by a **different** route. This one has had several.*

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, DEFERRED AN EIGHTH TIME.**
The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop"
reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to
under 5%) is an `open_question` on `automated-triage-under-refusal`. **It is a question, not
evidence — no curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–32 all judge it the highest-value uncollected source. *Cycle 32: the earliest
realistic route is now **cycle 50's T1**, seven cycles later than cycle 30 predicted.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated pipeline to
search for vibe citations by finding and scanning public reports from major consulting firms". A T1
should chase `gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor; no
*rate* published; the scorecard widget renders as "0 of N" to automated fetch. **Still the only
route any cycle has found to a base rate**, the binding constraint on
`institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural
finding for the paper: the only task type that can restructure the issue graph fires when a T5
coincides with a multiple of 7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly (NeurIPS "391 papers" in text vs
391 invalid citations across 308 papers in Table 3). No claim in our base repeats the error; **no
G3 entry was opened**. Quote src-0011's *counts* from Table 3. *Self-contradicting sources in this
base: src-0011 (prose vs table), src-0002 (Micro-F1 text vs Macro-F1 header, [44]), src-0008 twice
(phase labels [5]; metric definitions [46]), src-0007 (rubric dimension defined twice, [47]).
**Cycle 31 adds a fifth source and a new kind: src-0017, where the DOCSTRING AND THE README both
describe a filtering rule the LIVE CODE DOES NOT RUN** — not prose-vs-table but
documentation-vs-execution. **Five sources, six instances. Cycle 32 replicated the src-0017 one and
confirmed the branch is live.***

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4 pulled
**whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall (Accepted)
**0.9091–1.0000**. *The rubric rows are **no longer single-pull** — a third pull returned all 34
rows identical.* **THE ANOMALY ITSELF IS UNRESOLVED AND REPRODUCED THREE TIMES:** GPT-4o (FT)
tracks o3-mini to within 0.001 on **all six** `Content: Threat Actor` rubric rows, identically at
c15, c21 and c30, on two URL forms. **As-printed, cause unknown, DO NOT GUESS.** *The judge being
GPT-4o ([47]) explains nothing, since the anomaly is between the o3-mini and GPT-4o (FT) columns.*

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014 (c19),
src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy **narrowed but not closed** — quote 33.9%
and 16.9%→83.2% only with their scopes named. Gemini's 0.161 → 0.721 was **not** re-checked.
**Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still body-sentence-only.**

**[21] — CONFIRMED AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688 for a general
model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5 at 0.677**.
Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a true
span of **0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md`
is still untouched and still carries the wrong sentence — the only known source file still carrying
an uncorrected sentence, and a cheap fix.** *Repair-both-places held for cycles 22, 23, 25–32.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are
**strictly monotone decreasing across all eight general-purpose columns in exactly the printed
column order**; four are in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends
on. One row matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch
artefact.** **Any finding resting on that table must carry a robustness check excluding those
rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.** Mean between-**model** range within
a task (0.272) and mean between-**task** range within a model (0.263) are equal to within 0.009.
This does **NOT** negate `task-dependent-reliability-framing`'s supported claim — cycles 19, 22, 26
and 29 all tested it — it qualifies the implication that sub-task is the *privileged* explanatory
variable. A T2 should annotate rather than re-scope. No contradiction: both facts hold.

**[24] — NEW cycle 18, USED THROUGHOUT 19–23 AND 25–32. `jq` IS INSTALLED AND APPROVED.** **Every
cycle from 9 to 17 recorded that this agent cannot validate JSON and must check "by construction".
That advice is wrong and expensive** — cycle 17 lost its entire `state/` output. **Every JSON edit
should be followed by `jq -e`** *and* a `jq -r` read-back of the fields added. The permission layer
is **not uniform** — probe once. The `Grep` **tool** works on the big JSON files where Bash
`grep -n` does not. Cheapest append-only pattern: **`Grep` → `Read` with `offset`/`limit` → `Edit`
→ `jq -e` → `jq -r` read-back.** *Cycle 32 used `jq -r` projections as the primary reading tool for
`graph.json` throughout, and `Grep -o` to confirm an `Edit` anchor was **unique** before editing —
cheaper than reading the surrounding lines and it is the check that makes single-line anchors safe.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the
`Content: Threat Actor` rubric block in full, and the two caveats keep travelling: the rubric's
**absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a
normalisation the paper never states, **re-confirmed ABSENT at c30**), so **only within-table
contrasts may be cited**; and the GPT-4o (FT) column is suspect per [19]. **CYCLE 30 REOPENED IT:**
having the rubric block's *values* is not having its *definition*, and the definition was in
Appendix C.2 all along, unpulled for fifteen cycles. **A third caveat is required: `Attribution`
means SOURCE LINKING in the Threat Actor block and ACTOR IDENTIFICATION in the Root Cause block, so
cross-block contrasts are NOT automatically safe either.** See [47]. *Standing lesson: "the table
is captured verbatim" and "the metric is understood" are different claims.*

**[26] — NEW cycle 18, a question about the harness, not the research. NOW MUCH LARGER — SEE [50].**
**Why cycle 17 failed validation is unknown and unrecoverable.** Suggested harness fix for a human:
tee `python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before
reverting, and `git stash` the rejected `state/` diff. The mechanism is fine for **crashes** (cycle
24) and blind to **validator rejections** — *and cycle 31 proves it is also blind to
**partial success**, committing a misleading "run failed, no state change" message over four
changed state files.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER TWELVE CYCLES.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3
2.61, DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward.**
Bears on `automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward composition
unstated; n=40 per model, no CIs; association not strictly monotone. An observation about an
**already-collected** source, so **no new citation is needed**. Cycles 22, 26, 29, 30 recorded it in
a rationale or log, but **a rationale is not the graph.** Still unentered; that issue has lost five
selections, so still nobody with standing.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–32. RE-DERIVED AGAIN AND CHANGED AT CYCLE 32.**
The state machine is T1→T2, T2→T3, T3→T4, T4→T5, T5→T3. **Positions: cycle 31 = T3 (unfinished),
cycle 32 = T3 (this one, completing the same queue entry), 33 = T4, 34 = T5**, T5 thereafter on 37,
40, 43, 46, **49**. The refresh fires only when a T5 **runs on** a multiple of 7; 49 is both, so
**the next T1 is cycle 50 and the next T2 is cycle 51.** *Cycle 30 predicted 43 and 44; that is
void.* **THE HEADLINE, AND IT IS WORSE THAN THIS ITEM HAS SAID: cycle 24's crash pushed collection
back eight cycles, and cycle 31's max-turns death pushed it back another seven. Two partial
failures have cost fifteen cycles of collection and restructuring capacity.** **Re-derive rather
than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25, 30, 31 AND 32.** A T3 **MAY** add
sources (`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018,
breaking a blocker standing since cycle 3. **Standing lesson: read the task's own prompt file, not
only the queue entry's description of it.** *Cycles 31 and 32 both did and both found the handoff
accurate — **four clean handoffs in a row** after five bad ones. The check stays: it is cheap and
its failure mode is expensive.*

**[30] — NEW cycle 20; PREDICTION CORRECT FIVE TIMES.** `automated-triage-under-refusal`, the only
issue never worked on (`attempts: []`, created cycle 16), has **lost five consecutive selections**.
**"Never attempted" is not a tie-break in `prompts/t5_select.md`**, and cycle 19's rationale wrongly
asserted it was. **This is a prompt change for a human.** Note the interaction with [11]: **both**
readings of 3a bury it — no dependents, so 3a eliminates it outright, and the fallback is
`created_cycle`, so **the newest issues in a graph are structurally disadvantaged forever, with no
expiry**. *It sits at 2, holds the project's top uncollected source ([15]) and an unentered
observation bearing on its own central question ([27], now twelve cycles old). **The cost of this
defect is five selections deep and belongs in the paper.***

**[31] — NEW cycle 21, EXTENDED 22, 23, 25–32. THE VERBATIM CHECK HAS NOW RUN ON TWELVE
SOURCE-CHECKS; NINE PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation
**does not exist on the page**. (b) **src-0003** (c22): quotations passed, stored *numbers*
76/72/86 are **figure-image-only**. (c) **src-0002** (c23): all 25 numbers exact, **interpretation
contradicted by the paper's own metric definition**; `ctr-0002`. (d) **src-0001** (c25): numbers
exact, protocol *stronger* than recorded, **calibration gloss contradicted by the full table**;
`ctr-0003`. (e) **src-0005** (c26): all claims **PASS** — but stored with no task format, metric
definition, sample counts, limitations or numbers. (f) **src-0017** (c27): every stored string
**PASSES**, the **DOWNSTREAM PARAPHRASE** dropped the hedges; `ctr-0004`. (g) **src-0018** (c28):
every quotation **PASSES** — the stored **SCOPE** is wrong, and wrong by being **TOO RESTRICTIVE**;
`ctr-0005`. (h) **src-0002 again** (c28): two more glosses, one **FALSE against the printed table**,
plus a self-contradiction in the source; `ctr-0006`. (i) **src-0008** (c29): quotations and numbers
**PASS**, one claim **OVER-GENERAL**; `ctr-0007`. (j) **src-0007** (c30): all 34 rows PASS,
**THE METRIC IS DEFINED TWICE UNDER ONE NAME**; `ctr-0008`. **(k) src-0012 (c31): PASSES CLEANLY.
(l) src-0017's TTP scorer (c32): PASSES CLEANLY, plus one strengthening addition.** **The defect
class is nine-way** — spliced quotations, unverifiable numbers, unsupported interpretive glosses,
partial table capture, correct-but-hollow entries, correct-source-corrupted-downstream,
over-restriction, over-generalisation, metric-identity. *Standing lesson, upgraded: **verifying a
value does not verify what the value measures.** Ask what the metric is defined as, in the source's
own words, every time — and check whether the same name is defined more than once.* **Cycle 32's
addendum: three consecutive clean checks is itself a result and should be reported as one, not
buried. It is the first evidence that this discipline is exhausting the backlog rather than
sampling it.**

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1
values are figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction when
the source's own legible text conflicts with the stored claim; do not file when the stored claim is
merely unverifiable.** *Cycle 32 applied it and filed **nothing**, correctly: the re-fetch agreed
with the state on every checked string, and the one addition extends a claim rather than conflicting
with it. The test is working in both directions and should be kept.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted candidate
set**, not free-form extraction — *"We assume a total of 1,789 candidate indicators, extracted using
IoC Searcher"*; Figure 9's caption "… on IoC Classification." **A difference in task format, stated
by the paper.** **Companion finding: src-0003 NEVER STATES ITS MATCHING RULE.** *Sources with an
unstated scoring rule: src-0003 (IoC matching) and src-0002 (ATT&CK correctness). **src-0007 is now
OFF this list for the ATT&CK/TTP task** — cycle 31 read the rule off executing code and cycle 32
replicated it. **Two remain, and src-0002's is the remaining half of `ctr-0006`.***

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3. HALF
DISCHARGED AT CYCLE 31.** **A within-study design holds team, corpus, models and harness constant
but does NOT hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty
fact only if the sub-tasks are scored comparably. *Cycle 31 executed the fetch this item demanded
and the answer is the **worst case for the objection's target**: src-0007's IoC and ATT&CK
sub-tasks are scored by **different kinds of rule** (one-directional substring containment vs exact
ID set intersection), so the within-study cross-sub-task comparison is **not** rescued — it is
refuted, and `ttp`'s candidate 2 withdrew its within-table control accordingly. Cycle 32 sharpens
it further: the ATT&CK scorer **discards the parent-child column that would make it lenient**, so
the asymmetry is a design choice, not an oversight.* **STILL OPEN: src-0006's per-task metric
definitions have never been pulled.** Known non-commensurable instances: src-0017/`ctr-0004`,
src-0003, src-0005, src-0002/`ctr-0006`, src-0007's rubric against itself ([47]), **and now
src-0007's IoC rule against its own ATT&CK rule. Six.** **The cycle-33 T4 must price the last two.**

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible` columns
are **nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements (incorrect =
100 − Plausible = **14 / 38 / 26 / 20 / 64%**) are in the graph **with their derivation stated**;
`ctr-0002` CLOSED.

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all three
steps executed. **The consequences did not stay inside the issue: see `ctr-0006` and [44].** *The
G2 staleness heuristic and the scoring rationales are working as a pipeline: `ctr-0002` → cycle 29's
provenance flag → cycle 30's G2 choice → `ctr-0008`. **Cycle 32 extends the pipeline with a second
input: `ctr-0006`'s closure created an unreplicated load-bearing fetch, which is what selected this
cycle's G2 subject. Closing a contradiction should itself schedule a replication.***

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28–30. THE ISSUE ASKS TWO QUESTIONS AND THE EVIDENCE
IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent sources**
(src-0001 + src-0018, **both at temperature 0**), calibration-on-CTI on **one** (src-0001, gpt4o
only), and `ctr-0003` sits on the calibration half alone. Natural cut:
`consistency-under-repeated-query` vs `confidence-calibration-on-CTI`. **Only a T2 can split an
issue** ([12]); **next T2 is now cycle 51.** *Nineteen more cycles of under-expressiveness.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AT 30 AND AT 31. A SINGLE FETCH'S "ABSENT"
IS NOT EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT verdict
must be confirmed against a second URL form.** Before recording an absence check **(1)** the
abstract, **(2)** a different URL rendering, **(3)** that you fetched the file the claim actually
cites, **(4)** that the **VERSION** you fetched contains the material at all (src-0002 v2 has no
CTI-ATE task). **The rule also applies to a PARAPHRASED verdict: a summarised PRESENT is as
untrustworthy as a bare ABSENT.** *Cycle 31 found the rule's limit the hard way — **both** URL
forms of `TTP_Mapping.csv` failed the same way for the same reason (truncation), and it nearly
recorded a spectacular false finding. See [49]. **Cycle 32 adds the complementary refinement: a
PRESENT verdict may be trusted from one fetch, but a verdict about which of two competing texts
EXECUTES is not a PRESENT verdict at all** — both texts are present. It must be asked as its own
question, and cycle 32 did, which is what made the replication meaningful.*

**[39] — NEW cycle 25, EXTENDED 26–29. PROVENANCE LABELS IN THIS BASE WERE SET AT COLLECTION TIME
AND ARE MOSTLY STILL UNCHECKED.** src-0001 **is peer-reviewed** — ARES 2025, Springer, DOI
`10.1007/978-3-032-00627-1_17` — and this base called it a preprint for 24 cycles. src-0005 goes the
other way: **an unreviewed preprint** whose CrowdStrike/Meta attribution rests on recognising two
author names. src-0017's `[TMLR '25]` badge against a March 2026 arXiv submission is **unresolved
and probably permanently so**. Still unchecked: src-0013 ("ICSME 2026 Research Track"), src-0014
("v1 preprint, no stated venue"), src-0015 ("single-author preprint"). *Cycle 29 ran the **version**
check on src-0008. **No claim is made about src-0007's version count** (c30 did not run it).
**Cycle 32 did not run either axis either** — src-0017 is a GitHub repo, where the version axis
would mean a commit/tag check rather than an arXiv `/abs` fetch, and I did not do it; the `[TMLR
'25]` question is untouched. Cheap and still worth running.*

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND
THIS BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of questions
for which the system selects all correct options and only the correct options." 609
malware-analysis cases; 588 threat-intel-reasoning pairs from 45 reports supplied "via a set of
images". Questions **generated by Llama 3.2 90B and Llama 4 Maverick**, then human-validated; the
paper concedes both that multiple choice "does not provide a perfect proxy" and that there is
"performance bias … where the model under test is the same, or has similarities with the set of
models that were used in synthetic data generation pipelines". **(a)** Its percentages are not
commensurable with src-0002's F1 or src-0007's precision/recall. **(b)** It reports **no ATT&CK
metric at all**. **(c)** 23–34% (MA) against 43–53% (TIR) is a within-paper cross-task spread but
**NOT a controlled contrast**. **Anyone using it must state those three confounds.** *Family
resemblance to [47]: src-0005's questions were generated by models related to those under test, and
src-0007's rubric was **scored by a model under test**. **Two of eighteen sources have an
evaluator/evaluatee entanglement, and neither was recorded at collection time.***

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30. THE G3 CEILING
BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS.** An honest, stingy T4 demotes issues
carrying open contradictions, which moves them *away* from the ceiling. **So the validator's G3
check is very nearly dead code, while the prompt's subtraction rule — which every T4 has correctly
refused to apply — would fire on multiple issues today and drive them toward 0 without tripping
anything.** Cycle 29: a contradiction whose content **strengthens** the issue must not be scored as
a demotion. Cycle 30 added a **fourth shape**: `ctr-0008` **relocates** support rather than
undermining or strengthening it. **Four shapes, one binary gate.** *Cycle 32 adds a fifth
observation, and it is about closure rather than opening: `ctr-0006` closed at cycle 31 **without
the underlying source defect being repaired** — the Micro/Macro ambiguity is intrinsic to src-0002
and now travels inside the candidate as a permanent qualifier. So **an issue's contradiction count
can fall to zero while the evidential problem that motivated it persists undiminished.** A gate
keyed to the count cannot see that either. Passed on verbatim with [4], [11], [30].*

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO; `ctr-0004`
OPENED; REPAIRED BY APPEND.** The executing code is
`any(pred.lower() in gt.lower() for gt in gt_set)` — **a prediction must be a SUBSTRING OF a
ground-truth entry**. The two-directional and exact-match variants are **inside triple-quoted
string literals and never run**. **The bias is ASYMMETRIC:** lenient toward short/fragmentary
predictions, **strict against verbose predictions**, which is the characteristic free-form-LLM
failure mode. **"Substring-permissive, inflates true positives" is half right and must not be
repeated unqualified.** The T4 half was discharged at cycle 29. **THE T3 HALF IS STILL OPEN AND IS
NOT MINE: a T3 on `ioc-extraction-reliability` should rewrite the cycle-21 `open_question` and
decide whether the asymmetry changes cycle 18's arithmetic on `ctr-0001`'s METRIC confound.**
*Cycle 32: **both remaining "unread in that repo" items are now read** — the ATT&CK/TTP scorer
(c31, replicated c32) and the rubric/judge scorer (c31, located; `root_cause.py` verbatim,
`threat_actor.py` NOT). Passed on undone.*

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005`
OPENED; REPAIRED BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images —
**confirmed a third time, and that ban stands.** But the page states in plain text: a **41
min/report human-analyst baseline** against ~**3.3 min**; **17 metrics each a ratio 0–1**; and, most
importantly, **"the LLM temperature parameter was set to 0"**. **The temperature-0 fact strengthens
`consistency-calibration-as-failure-mode`** and was fenced off for three cycles by an over-broad
hedge. The page has **ten** figures, not four. **Standing lesson: a hedge is a claim and must be
scoped as precisely as an assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED
AGAINST `ttp-attack-mapping-reliability`; REPAIRED BY APPEND IN BOTH PLACES. `ctr-0006` CLOSED AT
CYCLE 31.** **(a)** Section 4.2 says *"We adopt the **Micro-F1** score as the evaluation metric for
the CTI-ATE task"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's metric is ambiguous
by the paper's own text.** **(b)** The cross-task difficulty comparison is **ours** — `task
difficulty` ABSENT, `most challenging` ABSENT — and it subtracts multi-class **accuracy** from
multi-label **F1**. **(c)** key_claims[2] ("no evaluated model exceeded ~72% on any single task") is
**FALSE against Table 1** (CTI-TAA Plausible: 86 / 80 / 74). **(d)** The **ATT&CK correctness rule
is never stated**. **(e)** **arXiv v2 has NO CTI-ATE task at all** — always fetch v3 or the latest
render. *Cycle 29 priced it: the issue fell 3 → 2. Cycle 31 executed all three resolution steps and
closed the entry, adding that the ordering fails **even naively** (CTI-TAA `Correct` = 52 < 63.88,
so "ATT&CK is the worst CTIBench task" is false on the paper's own printed numbers). **(a) and (d)
are NOT repaired and cannot be from this paper — they now travel as permanent qualifiers inside the
candidate, and `ttp`'s `open_question[3]` turns them into a concrete T1 lead: find CTIBench's
evaluation code and read its ATE scorer.***

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29.**
`attribution-confident-wrong-gap` **bundles a well-evidenced question with an unevidenced one, and
only a T2 can fix it.** The **error-rate** half is well grounded (src-0002's derived 14–64%
incorrect bucket on 50 alias-tolerant real reports, corroborated in direction by src-0007's
within-table rubric contrast). The **confidence** half has **no evidence at all**. Natural cut:
`attribution-error-rate` vs `attribution-confidence-calibration`, the second probably merging into
whatever [37] produces. **Next T2 is now cycle 51.** *Successors must not quote the parenthesis
unqualified: **the "within-table rubric contrast" as stated differences two different metric
definitions** ([47]). The direction survives at block level, so the error-rate half is still the
better-evidenced conjunct — but its corroborating leg is thinner than this item claimed at cycle 28.*

**[46] — NEW cycle 29. src-0008 CONTAINS TWO SELF-CONTRADICTIONS AND ITS PER-PHASE NUMBERS ARE
IMAGE-LOCKED; `ctr-0007` OPENED; REPAIRED BY APPEND IN BOTH PLACES.** **(a) THE STORED CLAIM IS
OVER-GENERAL.** The paper evaluates **five** models; *"Cohere, however, shows progressive
degradation: 1% missed detections in P1, 2% in P2, 5% in P3, and in P4, 65% misses plus 35%
explicit 'Don't Know' responses"* — and **P1–P4 contain no cryptography**. So plain-text IoC
recovery is **not** near-free "for current LLMs", and **encryption is not the boundary**. The
finding **cuts both ways** and cycle 29 asserted neither direction. **(b) IT DEFINES ITS METRICS
TWICE, INCOMPATIBLY** — body *"the proportion of samples in which the model correctly identifies the
presence of an IoC"* against Table 6's caption *"ratio of YES an answers"*. **(c) PHASE LABELS** —
see [5], resolved in our favour. **(d) PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so
"roughly 0–1%" and "~95%+ misses" are **figure-derived, not text-verified**. **(e) TABLE 6 IS
READABLE AND WAS NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 / 35 / 22.8%, aggregates over all
thirteen phases, **never per-phase**. **(f) PASSED:** Table 7's hallucination rates text-confirmed
exactly and the abstract verbatim. **ACTION STILL OPEN AND NOT MINE: a T3 on
`ioc-extraction-reliability` should rewrite the third candidate_resolution to state Cohere's P1–P4
degradation, decide whether model-side variance under syntactic noise supports or undercuts the
scaffolding hypothesis, and relabel the figure-derived percentages.** *Passed on undone. With [42],
`ioc-extraction-reliability` now carries **two** named undone T3 jobs and **three** open
contradictions; it was cycle 30's runner-up in a terminal tie and is the strongest candidate for
the cycle-34 T5.*

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME; THE
JUDGE IS A MODEL UNDER TEST; `ctr-0008` OPENED AGAINST `attribution-confident-wrong-gap`.** **(a)**
Appendix C.2 prints separate criteria blocks for Threat Actor and Root Cause content. **Threat
Actor**: *"Attribution: 1: Information is unverified or unattributed. … 5: Fully attributable; all
details are clearly linked to the original article."* — **source linking, no anchor mentions
identifying an actor.** **Root Cause**: *"1: Completely incorrect attribution. 2: Significant
attribution errors; misidentified threat actor. … 5: Perfect attribution; clearly identifies the
threat actor."* — **actor identification.** **So the state's load-bearing "within-table contrast"
(1.140 against 3.612) differences two different metrics, and the labels run OPPOSITE to how the
state read them.** **(b) WHAT SURVIVES:** the **block-level** contrast — GPT-4o lower on **all six**
dimensions for Threat Actor (1.547 / 1.528 / 1.145 / 2.019 / 1.734 / 1.140) than Root Cause
(3.686 / 3.458 / 3.362 / 3.932 / 3.753 / 3.612) — so "a sub-task-specific deficit, not a general
inability to draft" holds **via the block, not the row**. **(c) THE JUDGE IS GPT-4o**, one of the
four scored models; in the source's favour, *"an agreement rate between the LLM-as-Judge and human
experts exceeding 95%"*. **Direction cuts against the easy reading**: self-preference would inflate
GPT-4o's own scores, and GPT-4o scores **lowest**. **Any citation of the GPT-4o-vs-o3-mini gap must
state that GPT-4o was the judge.** **(d) THREE CANDIDATES AFFECTED**, found with one `jq` `test()`
query: `attribution-confident-wrong-gap`'s third; **`task-dependent-reliability-framing`'s** level-3
leg that the cycle-29 T4 called **immune** to [34] — **the largest scoring exposure, now for the
cycle-33 T4**; and **`extraction-vs-reasoning-ordinal-axis`'s route 2**. **(e)** The third
candidate's stated reason for being `proposed` is discharged ([19]), so a T3 must decide its status
on metric-definition ground. **(f) ACTION, STILL OPEN AND NOT MINE.** *Cycle 31 discharged the last
clause: the rubric/judge scorer **exists** at `stage3_ti_drafting/score_evaluation/`, and
`eval/root_cause.py`'s live `sys_prompt` anchors are **unambiguously actor identification**, so
**the code CONFIRMS `ctr-0008` rather than dissolving it**. Two further facts: **no judge model is
hardcoded** (`--model` required, no default), so Appendix C.2's "using GPT-4o" describes how the
authors **ran** the harness, not the released code; and **`eval/threat_actor.py` was NOT obtained
verbatim** — the fetch returned a summary, which under rule (ix) is as untrustworthy as a bare
ABSENT. **Re-fetching `threat_actor.py` verbatim is step 1 of `ctr-0008`'s repair and remains a job
for a T3 targeting `attribution-confident-wrong-gap`.***

**[48] — FORMALISED AT CYCLE 32 FROM CYCLE 31's G2 PROSE, WHICH NEVER FILED IT. A PROVENANCE
GRANULARITY SPLIT IN src-0012.** `src-0012.md` carries the corroborating Going Concern URL in full,
but `index.json`'s `key_claims[3]` names the outlet **without its URL** and `key_claims[0]`
attributes the study's **2025** date **with no outlet at all** — so a reader working only from
`index.json` can resolve neither. Cycle 31 established that the `consulting.ca` headline URL states
**no year for the EY study anywhere** (whole article reproduced verbatim; its only date is its own,
19 May 2026), and that the year **is** supported verbatim by Going Concern: *"the 2025 EY Canada
report titled 'Points of Attack: Uncovering Cyber Threats and Fraud in Loyalty Systems'"*. **This is
a granularity weakness, not a fabrication** — the `.md` file has disclosed the split honestly since
cycle 12. No contradiction was opened and none is warranted. **Cheap fix for any future cycle
touching src-0012: append the outlet and URL to the two `index.json` key_claims.**

**[49] — FORMALISED AT CYCLE 32 FROM CYCLE 31's NEAR-MISS. A BYTE-SIZE CHECK FROM THE HOSTING API
IS A DECISIVE GUARD AGAINST MISTAKING FETCH TRUNCATION FOR FILE CONTENT, AND MUST PRECEDE ANY
ABSENT VERDICT OVER A LARGE FILE.** Cycle 31 fetched `data/TTP_Mapping.csv` twice; the first
reported **57 lines**, the second listed **59 TechniqueIDs** running alphabetically from `T1548` to
`T1197` and returned **ABSENT** for `T1204`, `T1189`, `T1036`, `T1055`. **Taken at face value that
is a devastating finding** — a scorer whose mapping covers only the A–B slice of ATT&CK would count
nearly every real prediction as `missing_in_mapping`. **It is false.** The GitHub contents API
reports the file at **1,083,078 bytes** (and `data/100-days-articles.json` at **1,441,832**). Both
readings were **truncation artefacts**; the four ABSENT verdicts are **void** and no claim about the
mapping's coverage exists anywhere in the state. **This is the limit of [38]: it says confirm an
absence at a second URL form, and it does not warn that both forms can fail the same way for the
same reason.** *Cycle 32 re-fetched the same file **deliberately head-only**, with an explicit
instruction to claim nothing about the whole file, and got the schema safely. **That is the pattern:
when a file is known to truncate, ask only what the head can answer.***

**[50] — NEW cycle 32. A CYCLE CAN LAND ITS RESEARCH, FAIL ITS BOOKKEEPING, AND BE COMMITTED AS
"run failed, no state change". THIS IS A HARNESS DEFECT AND IT NEARLY COST THE CHAIN 47
CARRY-FORWARD ITEMS.** Cycle 31 exhausted `max_turns: 50` after committing `graph.json`,
`index.json`, `src-0012.md` and `src-0017.md` but before writing `## Changes made`,
`## Next task rationale`, `## Budget`, **any carry-forward section**,
`state/queue/next_task.json`, or `state/queue/last_completed_task.txt`. `git log` describes this as
**"cycle 31: T3 investigate run failed, no state change"** — **wrong on both counts**, and a
successor trusting it would either have redone landed work or reverted it. `last_completed_task.txt`
still read **`T5 select`** while `next_task.json` held an unconsumed **T3**; the two agreed on
"T3 next" **only by coincidence**. **THREE THINGS FOR A HUMAN.** **(1)** The commit message should
be derived from `git diff --stat` on `state/`, not from the CLI's exit status. **(2)** Writing the
queue and `last_completed_task.txt` **before** the log would fail safe — the bookkeeping is what a
successor needs, the log is what the paper needs, and the current order sacrifices the former
first. **(3) A cycle that hits `max_turns` should be retried as the SAME task**, which is what
happened here only because the unconsumed queue entry made it happen by default. **FOR
SUCCESSORS: verify the phase from `next_task.json` AND `last_completed_task.txt` AND
`git show --stat` on the last commit, and disbelieve the commit message.** See also [26] and [28].

**[51] — NEW cycle 32. TWO REFINEMENTS TO THE G2 MECHANISM, BOTH EARNED THIS CYCLE.** **(a) SELECT
BY REPLICATION COUNT, NOT ONLY BY STALENESS, WHEN SOMETHING LOAD-BEARING IS ONE FETCH OLD.** The
queue recommended by staleness; I chose cycle 31's candidate 3 instead because it was **one fetch
old**, was the **stated basis on which `ctr-0006` was closed**, and came from a cycle with **three
known bad fetches** (one summary, two truncations). Staleness would have left a
contradiction-closing, unreplicated fetch unchecked indefinitely. **Generalisation: closing a
contradiction should itself schedule a replication of whatever closed it** — extends [36]'s
pipeline. **(b) "WHICH TEXT EXECUTES" IS NOT A PRESENT VERDICT AND CANNOT BE TRUSTED FROM A STRING
MATCH.** [38] permits trusting a PRESENT verdict from one fetch. But where a docstring and a live
branch describe **different** rules, both are PRESENT — ten exact-string checks confirm that and
settle nothing. The question must be asked separately and explicitly ("is this branch live code, or
inside a triple-quoted string / comment / docstring?"), and it is what made this cycle's
replication meaningful rather than decorative. **`ctr-0004` and the cycle-31 finding are now the
two known instances of documentation-vs-execution divergence in this base; assume more.** **(c) A
COROLLARY ON WHERE TO LOOK FOR DEFECTS:** cycle 32 found that `index.json`'s `src-0017` entry
records **five findings cycle 31's own log never mentions**. Rule (vi) warns the state may misdescribe
a clean source; **the converse also holds — a log may under-describe a rich state — so read the
STATE before re-deriving anything from a log.**
