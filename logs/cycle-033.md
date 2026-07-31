# Cycle 033 — T4 (Assess)

**Topic:** Reliability assessment of AI-generated Cyber Threat Intelligence (CTI)
**Queue entry executed:** `state/queue/next_task.json`, `task_type: T4`, `target_issue: null`,
`attempt_count: 0`, created cycle 32.

**Phase verified three ways before starting**, per the standing lesson from cycles 31–32:
`next_task.json` said T4; `last_completed_task.txt` read `T3 investigate`;
`git show --stat HEAD~1` showed cycle 32's T3 landing eight files. `HEAD` itself is a **human
commit** (`956a36c`, "Roll back cycles whose agent died…"), not a cycle — it patches
`run_cycle.sh` so that an agent death routes through the same rollback as a gate rejection.
**That is carry-forward [26]/[50] being acted on by a human**, and it is the first time in this
log's history that has happened. It does not change my task.

I also re-read `prompts/t4_assess.md` myself rather than trusting the queue entry's account of
it, and re-read `scripts/validate_state.py` lines 95–158 at source. The queue entry's account
was accurate on every point I checked — **five clean handoffs in a row**.

---

## Task performed

Scored **all eight** issues in `state/issues/graph.json` into `state/assessments/scores.json`,
per `prompts/t4_assess.md` steps 1–5. Two scores moved, both **downward**. I added no source,
split no issue and rewrote no `candidate_resolution`. I opened one contradiction entry, which
G3 (common rules, rule 3) requires of every cycle and is not a T4-specific action.

### Result

| Issue | c29 | c33 | Movement |
|---|---|---|---|
| `institutional-incident-real-world-impact` | 3 | **3** | held — backed by this cycle's G2 |
| `ttp-attack-mapping-reliability` | 2 | **2** | held — G3 ceiling lifted, deliberately not used |
| `ioc-extraction-reliability` | 2 | **2** | held |
| `consistency-calibration-as-failure-mode` | 2 | **2** | held |
| `attribution-confident-wrong-gap` | 2 | **2** | held — ceiling reapplied via `ctr-0008`, did not bind |
| `task-dependent-reliability-framing` | 3 | **2** | **LOWERED** |
| `extraction-vs-reasoning-ordinal-axis` | 3 | **2** | **LOWERED** |
| `automated-triage-under-refusal` | 2 | **2** | held |

### The two demotions, and why one root defect cost two points

Both trace to **`ctr-0008`** (opened cycle 30, still open) plus the systemic pattern in
carry-forward [34]. `ctr-0008` established — from src-0007's Appendix C.2, confirmed by two
fetches on two URL renderings, and again at cycle 31 from the **live `sys_prompt` string** in
`eval/root_cause.py` retrieved whole — that the rubric dimension named **"Attribution" is
defined differently in the two rubric blocks**: source linking in the Threat Actor block
("*5: Fully attributable; all details are clearly linked to the original article*", and no
anchor in that block mentions identifying an actor), actor identification in the Root Cause
block ("*5: Perfect attribution; accurately identifies the threat actor…*").

**`task-dependent-reliability-framing` 3 → 2.** Cycle 29 held it at 3 on the explicit ground
that its level-3 bar was "**CLEARED BY LEGS THAT ARE IMMUNE TO THE OBJECTION**", naming first
"src-0007's rubric contrast (1.140 against 3.612) is measured on ONE instrument within ONE
table". One instrument and one table it is; **one metric definition it is not.** The leg
designated immune is itself an instance of the objection.

I then read the graph rather than the rationale (rule (vi)) and found **the exposure is worse
than carry-forward [47](d) reports.** Candidate 2 (`supported`, evidence `[src-0007, src-0013]`)
makes **two** src-0007 comparisons, not one, and both are now known non-commensurable — and its
stated methodological warrant is false. Verbatim: "*both of the strongest available kind,
holding team, corpus, models and harness constant and **varying only the sub-task**… the same
four models reach IoC-extraction precision 0.8240–0.8846 while scoring 0.2787/0.2270 … on MITRE
ATT&CK TTP identification, and GPT-4o scores 1.140 out of 5 … against 3.612 … — roughly a 3x
spread across sub-tasks with everything else held constant.*"

The **first** of those is the identical inference that `ttp-attack-mapping-reliability`'s
candidate 2 formally **withdrew** at cycle 31 under the heading "CLAIM (b) IS NOW WITHDRAWN".
So one issue asserts as *supported* exactly what another issue has *withdrawn*, on the same
table and the same numbers. That is a conflict between two supported claims, it is filed
nowhere, and it is why I opened `ctr-0009`.

**The decisive argument is new this cycle rather than a restatement of cycle 22's.** Cycle 22
lowered this issue from 4 because a within-study design does not hold the scoring rule constant
— at the time an *unquantified possibility*. It is no longer a possibility and **it is no longer
unsigned**. Both rules are now known from executing code in one artefact: the IoC side is
one-directional substring containment (`ctr-0004`), the ATT&CK side is exact technique-ID set
intersection that discards the parent column (cycle 31, replicated cycle 32).
**The leniently scored task is the one that scores high and the strictly scored task is the one
that scores low. The sign of the confound is known and it points the same way as the finding.**
The headline 3x spread is exactly what those two rules would manufacture from equal underlying
performance. That leaves src-0006 alone as determinate support — a 2.

**`extraction-vs-reasoning-ordinal-axis` 3 → 2.** Cycle 29 signposted this outcome in terms: "*A
successor that takes the other view should drop it to 2 and say so plainly.*" I take the other
view, **with a reason cycle 29 did not have**. Its route 2 is built on the **wrong cell** — it
uses the 1.140 *source-linking* score as the *attribution* rung of an ordinal axis.

I kept cycle 29's asymmetry reasoning and applied it again: findings of non-commensurability
cannot weaken a claim whose content is that the ordering is **unsupported**, and the negative
claim survives either reading. **What does not survive is its two-source support**, which is
what the rubric actually asks about. Route 2's work was specific and positive — that src-0007,
the source which *appears* to support the ordering, reverses its own middle-to-third rung — and
that argument cannot be run on cells that are not the rung they are claimed to be. Route 1
(src-0006, gap 0.034, locally inverted at TTP Extraction 0.673) stands alone, and its own
caveat (d) concedes its matching rules have never been pulled.

### What I checked and did *not* change

- **`ttp-attack-mapping-reliability`: the G3 ceiling was lifted this cycle and I did not use
  it.** `ctr-0006` resolved at cycle 31, so nothing caps this issue. Cycle 29 recorded its
  demotion as a **merit** judgement taken *under* the ceiling, with the instruction that a
  successor must not restore a 3 by arguing the gate was misapplied. I honour it. Substantively:
  cycles 31–32 repaired **one of the two comparands** (src-0007's rule is now known, verified and
  replicated); the other (src-0002) still has **no stated ATT&CK correctness rule** and a metric
  identity ambiguous *by its own paper's text*, and cycle 31 tried and could not repair it from
  the paper. Half a repair is not a level.
- **A point against that issue's headline that no cycle had stated.** Candidate 3's content is
  not neutral for it — it partly **undermines** it. Knowing the TTP scorer double-penalises
  granularity mismatches means some unknown share of the 0.2787/0.2270 deficit is attributable to
  **the rule** rather than **the model**. The issue is much better *understood* and is not better
  *supported* on its titular question. A successor must not read candidate 3's excellent
  verification as evidence that ATT&CK mapping is unreliable; it is evidence about an instrument.
- **`attribution-confident-wrong-gap`: the ceiling reapplied since the last T4** (it had none at
  cycle 29 after `ctr-0002` closed; `ctr-0008` opened at cycle 30). Merit 2 sits under it, so
  nothing is capped. `ctr-0008` both **cost** it (candidate 3's load-bearing sentence is refuted)
  and **paid** it (the replication gap that was candidate 3's stated reason for being `proposed`
  is discharged — cycle 30's third pull returned all 34 rows identical). Net zero.

### The G3 gate — which rule I applied

`scripts/validate_state.py` lines 144–156 implement a **CEILING** (error only if an issue with
an open contradiction scores **> `scale_max − g3_contradiction_demotion` = 3**).
`prompts/t4_assess.md` step 3 says **SUBTRACT 2 points**. These are different rules and the
conflict is unresolved. **I verified both at source this cycle, applied the CEILING, and refused
the SUBTRACTION**, as cycle 16 ruled and every T4 since has done. Under subtraction, five of
eight issues would read **0** — stamping issues with multiple supported candidates and up to
eight sources with the rubric label "no candidate resolutions". Carry-forward [4], **24th
cycle**, still awaiting a human.

**The ceiling did not bind on any issue this cycle.** Every issue carrying an open contradiction
scored 2, which is under 3. That is carry-forward [41]'s observation holding for a fifth cycle:
an honest, stingy T4 moves contradicted issues *away* from the ceiling, so the validator's G3
check is very nearly dead code.

---

## Retrospection

**Subject: `src-0011` (GhostCite), `https://arxiv.org/html/2602.06718v1`.** Chosen by staleness
per carry-forward [8]/[51]: last verified **cycle 14**, the stalest source in the base, and
**recommended and skipped twice**. It belongs to `institutional-incident-real-world-impact`,
which — as it turned out — this cycle leaves as the **only issue in the graph above 2**, so it
was also the least-checked load-bearing thing in the project.

**Verdict: PASSES. No contradiction warranted. Three additions, one of them a live hazard.**

**What passed.** The abstract reproduces **word for word** against the stored quotation. Table 3
was pulled **entire** (rule (iv)) and every stored per-venue cell is exact: NeurIPS 391/308/1.51%,
ICML 125/104/0.93%, AAAI 106/86/0.62%, IJCAI 53/51/0.96%, NDSS 23/18/2.56%, CCS 20/20/1.14%,
USENIX 12/11/0.57%, S&P 8/6/0.56%. All ten exact-string checks returned PRESENT.

**The per-paper unit is now confirmed by an explicit sentence rather than inferred** — the
`Limitations` bullet had been asserting it without a quotation. Verbatim: "*In total, 604 papers
(1.07% of 56,381) contained at least one invalid citation, with 133 papers (0.24%) containing
error citations and 486 papers (0.86%) containing ghost citations, with 15 papers having both
types.*" (133 + 486 − 15 = 604, internally consistent.) **This hardens the reason
`institutional-incident-real-world-impact` is not a 4**: the prohibition on comparing these
rates against src-0004's per-footnote 26/492 now rests on the paper's own words.

**Addition 1 — carry-forward [18] is DISCHARGED as CONFIRMED, and the state's account was
correct.** Body text, verbatim: "*Invalid citations are present across all venues, with NeurIPS
exhibiting the highest absolute count (391 papers) and NDSS showing the highest proportion (2.56%
of papers) with invalid citations.*" The table's NeurIPS row gives **Invalid = 391, Papers =
308**. 391 is a *citation* count mislabelled as a *paper* count in the prose. Reproduced
identically from **v1 and v2**, so the defect is durable, not a rendering artefact.

**Addition 2 — the table's Error/Ghost decomposition, never captured in twenty-one cycles.**
Rule (iv) again: NeurIPS 59 Error / 332 Ghost, ICML 22/103, AAAI 21/85, IJCAI 11/42, NDSS 4/19,
CCS 11/9, USENIX 6/6, S&P 1/7; Total 135 / 603 / 738 / 604 / 1.07%.

**Addition 3 — a small intra-source arithmetic discrepancy, new.** The body says "*739 (29.2%)
were confirmed as invalid (136 error citations and 603 ghost citations)*" — 136 + 603 = 739 —
while the table's Total row reads 135 + 603 = **738**. **Each side is internally consistent**, so
a single-digit fetch transcription slip would have had to alter two numbers coherently on one
side; and the body sentence was reproduced identically from **two different versions**. I judge
it real. It is a one-count slip out of 739 that touches **nothing this state claims**.
**No contradiction entry was opened**, on the cycle-12 and cycle-29 precedent that a conflict
*internal to a source*, where our state records **neither** of the conflicting numbers, does not
meet G3's two-supported-claims-in-conflict test. The consistency of that test across cycles 12,
29 and 33 is deliberate.

**The bolt-on version check (carry-forward [39]) paid off, and this is the finding worth
keeping.** `arxiv.org/abs/2602.06718` lists **two** versions — v1 (6 Feb 2026), which this state
cites, and **v2 (14 May 2026)**, which no cycle had noticed. Every headline quantity survives
the revision unchanged. **But the table numbering changed.** The per-venue breakdown is **Table 3
in v1 and Table V in v2**, and **v2's Table 3 is an entirely different per-model table**
(CiteVerifier validation; Model / Valid Recall / Invalid Precision / Accuracy; thirteen model
rows plus an Average). A future cycle fetching the current version and asking for "Table 3"
would receive unrelated content **and could record a spurious contradiction against a clean
source.** The v2 abstract is also reworded, so the stored abstract quotation is verbatim of **v1
only**. Both facts are now recorded in `index.json` and `src-0011.md`.

**Thirteen source-checks have now run and nine produced a defect. The last four were CLEAN**
(src-0012 c31, src-0017 c32, and now src-0011 c33 — plus src-0005 at c26). Per cycle 32's
addendum that is itself a result and I report it as one rather than burying it: it is now
reasonable evidence that this discipline is **exhausting the backlog rather than sampling it**.

---

## Changes made

1. **`state/assessments/scores.json`** — full-file rewrite (permitted; it is not
   append-only-protected, and this is the approach that worked at cycles 26 and 29). All eight
   issues scored, `assessed_cycle: 33` on every entry, `last_assessed_cycle: 33`. Two demotions
   as above. Every rationale states its G3 arithmetic separately so the merit judgement is
   auditable independently of the gate.
2. **`state/issues/graph.json`** — appended **`ctr-0009`** against
   `task-dependent-reliability-framing`, the first contradiction ever filed against that issue.
   Single-line `Edit` anchor at the head of the `contradictions` array. Content and resolution
   path summarised above; the path's step (iii) — **pull src-0006's per-task scoring
   definitions** — is the highest-value fetch now available in the project.
3. **`state/knowledge/index.json`** — appended **two** `key_claims` to `src-0011` (the G2
   re-verification with its three additions, and the version hazard). Nothing removed;
   `key_claims` went 5 → 7 and the source count is unchanged at 18.
4. **`state/knowledge/src-0011.md`** — appended a matching "Cycle-33 G2 re-verification" section
   and a "VERSION HAZARD" section, including Table 3 transcribed whole. **Repaired in both places**,
   per the standing rule that fixing only `index.json` is how src-0016's defect survived six cycles.
5. **`state/queue/next_task.json`** — T5 (select) for cycle 34, `target_issue: null`,
   `attempt_count: 0`.
6. **`state/queue/last_completed_task.txt`** — `T4 assess`.

**Validation.** `jq -e .` run on all four JSON files after every edit, followed by `jq -r`
read-backs of the fields added. Cross-checked by hand: all 8 score keys match graph issue ids
exactly; all 8 have non-empty `evidence` (validator line 138); every evidence id is in
`src-0001…src-0018` (lines 140–142); every issue with an open contradiction scores ≤ 3 (lines
144–156).

**New sandbox constraint discovered:** `jq --slurpfile` is **refused** by the permission layer as
a dangerous flag, so cross-file `jq` queries are impossible. One `jq` per file, compare by eye.
Recorded in [9]/[24] and in the handoff.

---

## Next task rationale

**State machine, re-derived from `config.yml` rather than copied.** T1→T2, T2→T3, T3→T4, T4→T5,
T5→T3. Cycle 33 = T4, so **cycle 34 = T5**, 35 = T3, 36 = T4, then T5 on 37, 40, 43, 46, **49**.
The refresh fires only when a T5 *runs on* a multiple of `collect_refresh_every` (7, line 17);
49 is both, so **the next T1 is cycle 50 and the next T2 is cycle 51.** This independently
reproduces cycle 32's derivation.

**The T5's central problem is one I created, and I say so plainly.** With two demotions the graph
now reads **one issue at 3 and seven at 2**. A weakest-link selector facing a **seven-way tie**
is not selecting on score at all — **the tie-break is the selector**, and per carry-forward [30]
the fallback is `created_cycle`, which permanently disadvantages the newest issue with no expiry.
`automated-triage-under-refusal` has lost **five consecutive selections** by that mechanism and
holds three cheap actionable jobs including the project's top uncollected source.

I considered whether this is a reason to score less harshly and concluded it is not: step 5 is
explicit that optimistic scoring breaks the selector, and inflating a score to make a downstream
mechanism behave is exactly the failure the instruction guards against. **The right response is
to flag the mechanism, not to distort the input**, so the T5 entry tells it to state its
tie-break reasoning explicitly and to record it as a finding if the mechanism buries that issue a
sixth time.

I gave the T5 the seven candidates with their named undone jobs and flagged
`task-dependent-reliability-framing`'s src-0006 fetch as the highest-value one available:
**both** that issue's candidate 1 **and** `extraction-vs-reasoning-ordinal-axis`'s route 1 rest on
the untested assumption that src-0006's nine F1 rows share one matching rule. Given that **every
one of the three scoring rules actually read in this project has differed from what the state
assumed**, that is now the largest untested load-bearing assumption here, and the fetch either
repairs two issues at once or breaks them both. Either outcome beats another confirmatory read.

G2 for cycle 34 is recommended as **src-0009/src-0010** (the ENISA pages, now the stalest, and
the independent basis of the only issue above 2), then src-0013.

---

## Budget

| | |
|---|---|
| Web fetches | **3** (arxiv.org/html/2602.06718v1; arxiv.org/abs/2602.06718; arxiv.org/html/2602.06718v2) |
| Web searches | 0 |
| Bash calls | 7 (all `jq`/`grep`/`git`; one refused for `--slurpfile`) |
| File reads | 9 |
| Edits / Writes | 6 |
| Assistant turns | ~24 of `max_turns: 50` |

Cheap cycle. The three fetches were all one source; scoring eight issues was reading and
judgement, not I/O. No budget spent on carry-forward [6]'s dead search directions.

---

## Carry-forward items

All items from `logs/cycle-032.md` reproduced **including those I cannot act on**. Discharged
items stay marked rather than deleted. **Discharged this cycle: [18], [34]'s pricing instruction,
[47](d). New: [52], [53], [54].**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Still vindicated. Cited as the
precedent behind [37] and [45]. *Cycle 33 note: **both halves of that split are now at 2**, and
they fell for the same root defect — which is weak evidence that the split was along the right
seam, since a defect in a shared source propagated to both children rather than to one.*

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK
metric at all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in
its **twenty-second** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**,
and does NOT discharge it. [44] puts the 0.6388 itself in question. Cycle 31 sharpened it: now
that the scorer's rule is known to be exact-ID matching with no partial credit, a useful human
baseline would have to be scored under the SAME rule — and exact sub-technique assignment is a
task on which two competent analysts would themselves disagree.

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30]. *It has lost **five**
consecutive selections; 3a was the mechanism each time. **[54] makes a sixth loss more likely,
not less.***

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 24 CYCLES. VERBATIM FOR A
HUMAN.** The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**),
`config.yml` line 35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156
(**ceiling**, = 3). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**;
replacement text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`,
`scripts/` are outside this agent's output surface. **Until a human applies it, T4s must apply
the ceiling.** *Cycle 33 applied the ceiling on four contradicted issues and refused the
subtraction on all four; under subtraction five of eight issues would read 0. The
per-issue-versus-per-contradiction question stays live on `ioc` (three open) and `consistency`
(two). Awaiting a human, verbatim, with [11], [30] and [41].*

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is a
**self-contradiction in the source**, and our stored mapping is the **majority reading**. No
contradiction entry per [32]'s test. *Standing lesson: an item recorded as "blocked by an
infrastructure limit" may only be blocked by the route the recording cycle happened to try.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv
2506.11325; third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines;
the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not retry).
Forward-citation sweeps have **FAILED on two arXiv ids**. **SEvenLLM** uncollected and
downgraded. **AthenaBench** still has no URL. No arXiv companion exists for src-0018.
Unavailable: OpenReview, spiegel.de ([13]). **CTIBench's own released evaluation artefact has
never been sought** — now `ttp`'s `open_question[3]`. *Cycles 31–33 spent nothing here. **Cycle
33 adds that this is now the ONLY route left to move `ttp` off 2**, since src-0002's missing
ATT&CK correctness rule is unrepairable from src-0002 itself.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT 22; ONE STEP AT 27; ANOTHER AT 31.** `ctr-0001`'s
resolution path. **Done:** released-code route exhausted; METRIC confound eliminated; cycle 31
read the TTP scorer. **Still open:** no head-to-head; the **CORPUS confound is completely
untouched and is the largest gap**. Cheapest first:
`huggingface.co/datasets/xse/CyberThreat-Eval`; then corpus difficulty. Every code-reading step
on this path is now done; what remains is genuinely about corpora.

**[8] — UPDATED cycle 33. G2 COVERAGE COMPLETE; TRACKED BY STALENESS, NOW ALSO BY REPLICATION.**
src-0004 (c4, c12), src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 —
`ctr-0002`; c28 — `ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial
fail [21]; re-pulled c18), src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), src-0012
(c13; c31 — PASSES CLEANLY), **src-0011 (c14; c33 — PASSES CLEANLY, [18] discharged, version
hazard found)**, src-0007 (c15; c21; c30 — `ctr-0008`), src-0009/src-0010 (c16), src-0013 (c18),
src-0014 (c19), src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]), src-0017 (c27 —
`ctr-0004`; c32 — PASSES CLEANLY), src-0018 (c28 — `ctr-0005`). *Next G2 by staleness:
**src-0009/src-0010** (c16), then src-0013 (c18), then src-0014/src-0015/src-0016. **src-0009 and
src-0010 are now the stalest and they carry the independent basis of the only issue in the graph
above 2**, so they are the least-checked load-bearing thing in the project. Not recommended:
src-0011 (c33), src-0017 (c32), src-0012 (c31), src-0007 (c30), src-0008 (c29), src-0002/src-0018
(c28), src-0005 (c26), src-0001 (c25).* **But see [51]: staleness is the default, not the rule.**

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25–33.** `python3` present but the
**permission layer** blocks it; compound commands rejected if any segment is unapproved. **No PDF
text extraction exists** — prefer `/html` always. `gh` not approved. `awk` refused. **`sed -n` and
`cat >>` heredoc ARE approved**; a heredoc append must be its **own** call. `jq -e . <file> >
/dev/null` approved, as is a compound `jq … && jq …` chain. Prefer **single-line `Edit` anchors**.
`scores.json` and `graph.json` are NOT protected by validator lines 105–107.
**`raw.githubusercontent.com` returns whole files.** *Cycle 33: all held, plus **two new facts**.
**(a) `jq --slurpfile` is REFUSED as a dangerous flag**, so cross-file `jq` queries are
impossible — run one `jq` per file and compare the outputs yourself. **(b) Bash `grep -n` and
`grep -c` ARE approved on the small files** (`index.json`, `config.yml`) and are the cheapest way
to find and uniqueness-check an `Edit` anchor; the `Grep` **tool** remains necessary on the big
JSON files. Single-quoting every internal quotation again made multi-kilobyte `Edit`s
escape-free — **five cycles of evidence** for pattern (c).*

**[10] — DISCHARGED CYCLE 26; NEVER ACHIEVABLE.** src-0005's per-model numbers do not exist in
text — every per-model score is inside Figures 8, 9, 12–16. **Do not re-attempt without a new
route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27 AND AGAIN AT 30. VERBATIM FOR A HUMAN.**
Tie-break 3a in `prompts/t5_select.md` is under-specified and there is **no deterministic
tie-break after 3c**. In three parts: **(a)** a terminal tie **must** be written into the prompt;
**(b)** the prompt lists **3a before 3b**, but 3b is an addition *to the score*, so a literal
a-then-b ordering lets them return **opposite verdicts on the same pair**; **(c)** "within the
last 5 cycles" has three defensible readings. *Cycle 30 remains the richest data point: two
terminal ties in one cycle. **Cycle 33 makes this item urgent rather than latent: the graph now
holds a SEVEN-WAY tie at 2, so the under-specified tie-break is no longer an edge case — it IS
the selector.** See [54]. Passed on verbatim with [4], [30], [41].*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The
claim that the loop "never returns to T2" is false; cycle 16 disproved it. *The next T2 is
**cycle 51**. [37] and [45] are both T2 jobs and both wait another eighteen cycles.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
route is also closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own
writeup is the only remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level
and UNVERIFIABLE at document level here. **Do not re-spend budget.** *Caution from [5]: such
limits deserve one re-test by a **different** route. This one has had several.*

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, DEFERRED A NINTH TIME.**
The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop"
reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15%
to under 5%) is an `open_question` on `automated-triage-under-refusal`. **It is a question, not
evidence — no curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–33 all judge it the highest-value uncollected source. *The earliest T1 route is
**cycle 50**; a T3 targeting that issue could reach it sooner, since a T3 may add sources ([29]).*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated pipeline
to search for vibe citations by finding and scanning public reports from major consulting firms".
A T1 should chase `gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor;
no *rate* published; the scorecard widget renders as "0 of N" to automated fetch. **Still the only
route any cycle has found to a base rate**, the binding constraint on
`institutional-incident-real-world-impact` reaching 4. *Cycle 33's G2 hardened that constraint:
src-0011's per-paper unit is now confirmed **verbatim**, so the "adjacent-population audit is not
a CTI base rate" ruling rests on the paper's own sentence rather than on our inference.*

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural
finding for the paper: the only task type that can restructure the issue graph fires when a T5
coincides with a multiple of 7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18] — DISCHARGED CYCLE 33 AS *CONFIRMED*, AND THE STATE'S ACCOUNT WAS RIGHT.** src-0011
contradicts itself in prose vs table: body text "*NeurIPS exhibiting the highest absolute count
(**391 papers**)*" against a table row giving **Invalid = 391, Papers = 308**. **Re-fetched at
cycle 33 and reproduced verbatim from BOTH v1 and v2**, so it is durable and not a rendering
artefact. No claim in our base repeats the error; **no G3 entry was opened**, consistent with
cycles 12 and 29. **Quote src-0011's *counts* from the table's columns, never from that
sentence.** *Self-contradicting sources in this base: src-0011 (prose vs table, **and now also a
738-vs-739 arithmetic slip between its table total and its body**, see [53]), src-0002
(Micro-F1 text vs Macro-F1 header, [44]), src-0008 twice (phase labels [5]; metric definitions
[46]), src-0007 (rubric dimension defined twice, [47]), src-0017 (docstring/README vs live code).
**Five sources, eight instances.***

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4
pulled **whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall
(Accepted) **0.9091–1.0000**. The rubric rows are **no longer single-pull** — a third pull
returned all 34 rows identical. **THE ANOMALY ITSELF IS UNRESOLVED AND REPRODUCED THREE TIMES:**
GPT-4o (FT) tracks o3-mini to within 0.001 on **all six** `Content: Threat Actor` rubric rows,
identically at c15, c21 and c30, on two URL forms. **As-printed, cause unknown, DO NOT GUESS.**

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy **narrowed but not closed** —
quote 33.9% and 16.9%→83.2% only with their scopes named. Gemini's 0.161 → 0.721 was **not**
re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still
body-sentence-only.**

**[21] — CONFIRMED AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688 for a general
model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5 at 0.677**.
Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a true
span of **0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md`
is still untouched and still carries the wrong sentence — the only known source file still
carrying an uncorrected sentence, and a cheap fix.** *Cycle 33 note: **`ctr-0009` step (iii)
sends a T3 to src-0006 anyway**, so that cycle should fix this in the same visit.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are
**strictly monotone decreasing across all eight general-purpose columns in exactly the printed
column order**; four are in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends
on. One row matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch
artefact.** **Any finding resting on that table must carry a robustness check excluding those
rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.** Mean between-**model** range within
a task (0.272) and mean between-**task** range within a model (0.263) are equal to within 0.009.
This does **NOT** negate `task-dependent-reliability-framing`'s supported claim — cycles 19, 22,
26, 29 and 33 all tested it — it qualifies the implication that sub-task is the *privileged*
explanatory variable. A T2 should annotate rather than re-scope. No contradiction: both facts hold.

**[24] — NEW cycle 18, USED THROUGHOUT 19–23 AND 25–33. `jq` IS INSTALLED AND APPROVED.** **Every
cycle from 9 to 17 recorded that this agent cannot validate JSON and must check "by construction".
That advice is wrong and expensive** — cycle 17 lost its entire `state/` output. **Every JSON edit
should be followed by `jq -e`** *and* a `jq -r` read-back of the fields added. The permission
layer is **not uniform** — probe once. The `Grep` **tool** works on the big JSON files where Bash
`grep -n` does not. Cheapest append-only pattern: **`grep`/`Grep` → `Read` with `offset`/`limit`
→ `Edit` → `jq -e` → `jq -r` read-back.** *Cycle 33: **`--slurpfile` is refused**, so the
read-back cannot cross files; verify cross-file invariants (score keys ↔ issue ids, evidence ids ↔
index ids) by printing both lists and comparing them yourself. That check caught nothing this
cycle but is the only defence against validator lines 136–142.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the
`Content: Threat Actor` rubric block in full, and the two caveats keep travelling: the rubric's
**absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a
normalisation the paper never states, **re-confirmed ABSENT at c30**), so **only within-table
contrasts may be cited**; and the GPT-4o (FT) column is suspect per [19]. **CYCLE 30 REOPENED
IT:** having the rubric block's *values* is not having its *definition*. **A third caveat is
required: `Attribution` means SOURCE LINKING in the Threat Actor block and ACTOR IDENTIFICATION
in the Root Cause block, so cross-block contrasts are NOT automatically safe either.** See [47].
*Standing lesson: "the table is captured verbatim" and "the metric is understood" are different
claims. **Cycle 33 priced that lesson at two full points across two issues.***

**[26] — NEW cycle 18, a question about the harness. PARTLY ACTED ON BY A HUMAN AT CYCLE 33.**
**Why cycle 17 failed validation is unknown and unrecoverable.** Suggested fix: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before reverting,
and `git stash` the rejected `state/` diff. *Cycle 33: commit `956a36c` (a human) fixed the
**agent-death** half — `run_cycle.sh` ran under `set -e`, so a non-zero `claude -p` exit aborted
before `validate_state.py`, skipping the gates and the revert together; deaths now route through
the same rollback as gate rejections (exit 3 vs 2). **The logging half of this item is still
undone**: a rejected diff is still discarded without its validator output being preserved.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER THIRTEEN CYCLES.** src-0015's Table 1
has a **`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**,
Gemini 3 2.61, DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest
reward.** Bears on `automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward
composition unstated; n=40 per model, no CIs; association not strictly monotone. An observation
about an **already-collected** source, so **no new citation is needed**. Cycles 22, 26, 29, 30, 33
recorded it in a rationale or log, but **a rationale is not the graph.** Still unentered; that
issue has lost five selections, so still nobody with standing.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–33.** The state machine is T1→T2, T2→T3,
T3→T4, T4→T5, T5→T3. **Positions: cycle 33 = T4 (this one), 34 = T5**, T5 thereafter on 37, 40,
43, 46, **49**. The refresh fires only when a T5 **runs on** a multiple of 7; 49 is both, so
**the next T1 is cycle 50 and the next T2 is cycle 51.** *Cycle 33 re-derived this from
`config.yml` independently and it matches cycle 32.* **THE HEADLINE: cycle 24's crash pushed
collection back eight cycles, and cycle 31's max-turns death pushed it back another seven. Two
partial failures have cost fifteen cycles of collection and restructuring capacity** — and the
live consequence is that **no new source can enter via T1 until cycle 50** and **no issue can be
split until cycle 51**, while three issues are held at 2 by bundling problems only a T2 can fix.
**Re-derive rather than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25, 30–33.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018, breaking a
blocker standing since cycle 3. **Standing lesson: read the task's own prompt file, not only the
queue entry's description of it.** *Cycle 33 read `prompts/t4_assess.md` and
`scripts/validate_state.py` at source and found the handoff accurate — **five clean handoffs in a
row** after five bad ones. The check stays: it is cheap and its failure mode is expensive.*

**[30] — NEW cycle 20; PREDICTION CORRECT FIVE TIMES. VERBATIM FOR A HUMAN.**
`automated-triage-under-refusal`, the only issue never worked on (`attempts: []`, created cycle
16), has **lost five consecutive selections**. **"Never attempted" is not a tie-break in
`prompts/t5_select.md`**, and cycle 19's rationale wrongly asserted it was. **This is a prompt
change for a human.** Note the interaction with [11]: **both** readings of 3a bury it — no
dependents, so 3a eliminates it outright, and the fallback is `created_cycle`, so **the newest
issues in a graph are structurally disadvantaged forever, with no expiry**. *It sits at 2, holds
the project's top uncollected source ([15]) and an unentered observation bearing on its own
central question ([27], now thirteen cycles old). **Cycle 33 raises the stakes: with seven issues
tied at 2 ([54]), `created_cycle` is now doing almost all the selecting in this project.***

**[31] — NEW cycle 21, EXTENDED 22, 23, 25–33. THE VERBATIM CHECK HAS NOW RUN ON THIRTEEN
SOURCE-CHECKS; NINE PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation
**does not exist on the page**. (b) **src-0003** (c22): quotations passed, stored *numbers*
76/72/86 are **figure-image-only**. (c) **src-0002** (c23): all 25 numbers exact, **interpretation
contradicted by the paper's own metric definition**; `ctr-0002`. (d) **src-0001** (c25): numbers
exact, **calibration gloss contradicted by the full table**; `ctr-0003`. (e) **src-0005** (c26):
all claims **PASS** — but stored with no task format, metric definition, sample counts,
limitations or numbers. (f) **src-0017** (c27): every stored string **PASSES**, the **DOWNSTREAM
PARAPHRASE** dropped the hedges; `ctr-0004`. (g) **src-0018** (c28): every quotation **PASSES** —
the stored **SCOPE** is wrong by being **TOO RESTRICTIVE**; `ctr-0005`. (h) **src-0002 again**
(c28): two more glosses, one **FALSE against the printed table**; `ctr-0006`. (i) **src-0008**
(c29): quotations and numbers **PASS**, one claim **OVER-GENERAL**; `ctr-0007`. (j) **src-0007**
(c30): all 34 rows PASS, **THE METRIC IS DEFINED TWICE UNDER ONE NAME**; `ctr-0008`. (k)
**src-0012** (c31): PASSES CLEANLY. (l) **src-0017's TTP scorer** (c32): PASSES CLEANLY, plus one
strengthening addition. **(m) src-0011 (c33): PASSES CLEANLY — every stored claim exact, the
per-paper unit upgraded from inference to a verbatim sentence, [18] confirmed, and a version
hazard found as a bolt-on.** **The defect class is nine-way** — spliced quotations, unverifiable
numbers, unsupported interpretive glosses, partial table capture, correct-but-hollow entries,
correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity.
*Standing lesson: **verifying a value does not verify what the value measures.*** **Cycle 33's
addendum: FOUR consecutive clean checks now. Cycle 32 called three "the first evidence that this
discipline is exhausting the backlog rather than sampling it"; a fourth strengthens that, and it
should be reported as a result rather than buried — a G2 that stops finding defects is the
outcome the mechanism exists to produce.**

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1
values are figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction
when the source's own legible text conflicts with the stored claim; do not file when the stored
claim is merely unverifiable.** *Cycle 33 applied it twice and got opposite answers, correctly:
**filed nothing** for src-0011's internal 738-vs-739 slip (our state records neither number, so
no stored claim conflicts), and **filed `ctr-0009`** for the `task-dependent` / `ttp` clash (two
**stored, supported** claims in direct conflict). The test discriminates well and should be kept.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted
candidate set**, not free-form extraction — *"We assume a total of 1,789 candidate indicators,
extracted using IoC Searcher"*; Figure 9's caption "… on IoC Classification." **A difference in
task format, stated by the paper.** **Companion finding: src-0003 NEVER STATES ITS MATCHING
RULE.** *Sources with an unstated scoring rule: src-0003 (IoC matching) and src-0002 (ATT&CK
correctness). **src-0002's is unrepairable from src-0002** and is now the binding constraint on
`ttp` ([6]).*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3. HALF
DISCHARGED AT CYCLE 31; **PRICING INSTRUCTION DISCHARGED AT CYCLE 33**.** **A within-study design
holds team, corpus, models and harness constant but does NOT hold the scoring rule constant.**
Cycle 31 executed the fetch this item demanded and the answer is the **worst case for the
objection's target**: src-0007's IoC and ATT&CK sub-tasks are scored by **different kinds of
rule**, so the within-study comparison is **refuted, not rescued**. *Cycle 33 priced the last
two instances as instructed and they cost `task-dependent-reliability-framing` a point (3 → 2)
and contributed to `extraction-vs-reasoning-ordinal-axis` falling too. **The sharpest form of
this item, and the version successors should carry: the sign of the confound is now known and it
points the same way as the finding — the leniently scored sub-task is the one that scores high.
A cross-sub-task spread is no longer merely unproven; it is actively explicable by the scoring
rules alone.*** Known non-commensurable instances: src-0017/`ctr-0004`, src-0003, src-0005,
src-0002/`ctr-0006`, src-0007's rubric against itself ([47]), src-0007's IoC rule against its own
ATT&CK rule, and src-0008's body against its Table 6 caption ([46]). **Seven.** **STILL OPEN AND
NOW THE PROJECT'S LARGEST UNTESTED LOAD-BEARING ASSUMPTION: src-0006's per-task metric
definitions have never been pulled** — `ctr-0009` step (iii).

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible`
columns are **nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements
(incorrect = 100 − Plausible = **14 / 38 / 26 / 20 / 64%**) are in the graph **with their
derivation stated**; `ctr-0002` CLOSED.

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all three
steps executed. **The consequences did not stay inside the issue: see `ctr-0006` and [44].** *The
G2 staleness heuristic and the scoring rationales work as a pipeline: `ctr-0002` → cycle 29's
provenance flag → cycle 30's G2 choice → `ctr-0008` → **cycle 33's two demotions**. **Closing a
contradiction should itself schedule a replication** (cycle 32). **Cycle 33 adds the far end of
that pipeline: a contradiction opened at cycle 30 took THREE cycles to be priced, because the
cycle scheduled to do it (32) turned out to be a T3. A finding's effect on the scores can lag its
discovery by several cycles, and nothing in the loop tracks that debt except carry-forward.***

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28–30, 33. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks
about **consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent
sources** (src-0001 + src-0018, **both at temperature 0**), calibration-on-CTI on **one**
(src-0001, gpt4o only), and `ctr-0003` sits on the calibration half alone. Natural cut:
`consistency-under-repeated-query` vs `confidence-calibration-on-CTI`. **Only a T2 can split an
issue** ([12]); **next T2 is cycle 51.** Split, the consistency child would plausibly score 3 and
the calibration child 2; unsplit, the weaker leg governs. *Eighteen more cycles of
under-expressiveness — and this is now one of **three** issues in that position.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AT 30, 31 AND 33. A SINGLE FETCH'S
"ABSENT" IS NOT EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an
ABSENT verdict must be confirmed against a second URL form.** Before recording an absence check
**(1)** the abstract, **(2)** a different URL rendering, **(3)** that you fetched the file the
claim actually cites, **(4)** that the **VERSION** you fetched contains the material at all
(src-0002 v2 has no CTI-ATE task). **The rule also applies to a PARAPHRASED verdict: a summarised
PRESENT is as untrustworthy as a bare ABSENT.** *Cycle 31 found the rule's limit: **both** URL
forms of `TTP_Mapping.csv` failed the same way for the same reason. See [49]. Cycle 32 added that
a verdict about which of two competing texts EXECUTES is not a PRESENT verdict at all.* **Cycle
33 adds a fourth refinement, from the 738-vs-739 slip: when two fetched numbers conflict by one
digit, ask whether EACH SIDE IS INTERNALLY CONSISTENT before suspecting the fetch. Here 135+603=738
on the table and 136+603=739 in the body, so a transcription slip would have had to alter two
numbers coherently — which is what upgraded it from "probably a fetch artefact" to a real,
reportable, harmless source defect.**

**[39] — NEW cycle 25, EXTENDED 26–29; **THE VERSION AXIS PAID OFF AT CYCLE 33**.** Provenance
labels in this base were set at collection time and are mostly still unchecked. src-0001 **is
peer-reviewed** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` — and this base called
it a preprint for 24 cycles. src-0005 goes the other way: **an unreviewed preprint**. src-0017's
`[TMLR '25]` badge against a March 2026 arXiv submission is **unresolved and probably permanently
so**. Still unchecked: src-0013 ("ICSME 2026 Research Track"), src-0014 ("v1 preprint, no stated
venue"), src-0015 ("single-author preprint"). *Version checks run: src-0008 (c29), **src-0011
(c33)**. **The src-0011 check cost ONE fetch of the `/abs` page and found an unnoticed v2 that had
RENUMBERED THE TABLES — see [53]. This axis is now proven, not speculative; run it on every arXiv
source you touch.** No claim is made about src-0007's version count.*

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND
THIS BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of questions
for which the system selects all correct options and only the correct options." Questions
**generated by Llama 3.2 90B and Llama 4 Maverick**; the paper concedes "performance bias … where
the model under test is the same, or has similarities with the set of models that were used in
synthetic data generation pipelines". **(a)** Its percentages are not commensurable with
src-0002's F1 or src-0007's precision/recall. **(b)** It reports **no ATT&CK metric at all**.
**(c)** 23–34% (MA) against 43–53% (TIR) is **NOT a controlled contrast**. **Anyone using it must
state those three confounds.** *Family resemblance to [47]: **two of eighteen sources have an
evaluator/evaluatee entanglement, and neither was recorded at collection time.***

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30, 32 AND 33. THE
G3 CEILING BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS. VERBATIM FOR A HUMAN.**
An honest, stingy T4 demotes issues carrying open contradictions, which moves them *away* from
the ceiling. **So the validator's G3 check is very nearly dead code, while the prompt's
subtraction rule — which every T4 has correctly refused to apply — would fire on five of eight
issues today and drive them toward 0 without tripping anything.** Shapes documented so far:
**(1) undermining** (`ctr-0001`); **(2) strengthening** — a contradiction whose content improves
the issue must not be scored as a demotion (`ctr-0005`, cycle 29); **(3) two-directional**
(`ctr-0007`); **(4) support-relocating** (`ctr-0008`, cycle 30); **(5) closes without the
underlying source defect being repaired** (`ctr-0006`, cycle 32) — an issue's contradiction count
can fall to zero while the evidential problem persists undiminished. **(6) NEW AT CYCLE 33:
damages issues OTHER than the one it is filed against — see [52].** **Six shapes, one binary
gate.** *Cycle 33 confirms the dead-code observation for a fifth cycle: the ceiling bound on
**zero** of the four contradicted issues. Passed on verbatim with [4], [11], [30].*

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO; `ctr-0004`
OPENED; REPAIRED BY APPEND.** The executing code is
`any(pred.lower() in gt.lower() for gt in gt_set)` — **a prediction must be a SUBSTRING OF a
ground-truth entry**. The two-directional and exact-match variants are **inside triple-quoted
string literals and never run**. **The bias is ASYMMETRIC:** lenient toward short/fragmentary
predictions, **strict against verbose predictions**, which is the characteristic free-form-LLM
failure mode. **"Substring-permissive, inflates true positives" is half right and must not be
repeated unqualified.** The T4 half was discharged at cycle 29. **THE T3 HALF IS STILL OPEN AND
IS NOT MINE: a T3 on `ioc-extraction-reliability` should rewrite the cycle-21 `open_question` and
decide whether the asymmetry changes cycle 18's arithmetic on `ctr-0001`'s METRIC confound.**
*Cycle 33 adds one consequence for scoring: with the ATT&CK rule now known too, **the IoC leg is
established as the LENIENT one of the pair**, so any future cycle presenting src-0007's 0.82–0.88
IoC precision as evidence that IoC extraction is "solved" relative to other sub-tasks is making
the comparison `ctr-0009` was opened over. Passed on undone.*

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005`
OPENED; REPAIRED BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images —
**confirmed a third time, and that ban stands.** But the page states in plain text: a **41
min/report human-analyst baseline** against ~**3.3 min**; **17 metrics each a ratio 0–1**; and,
most importantly, **"the LLM temperature parameter was set to 0"**. **The temperature-0 fact
strengthens `consistency-calibration-as-failure-mode`** and was fenced off for three cycles by an
over-broad hedge. **Standing lesson: a hedge is a claim and must be scoped as precisely as an
assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED
AGAINST `ttp-attack-mapping-reliability`; CLOSED AT CYCLE 31.** **(a)** Section 4.2 says *"We
adopt the **Micro-F1** score…"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's
metric is ambiguous by the paper's own text.** **(b)** The cross-task difficulty comparison was
**ours** and subtracts multi-class **accuracy** from multi-label **F1**. **(c)** key_claims[2] is
**FALSE against Table 1**. **(d)** The **ATT&CK correctness rule is never stated**. **(e) arXiv v2
has NO CTI-ATE task at all** — always fetch v3 or the latest render. *Cycle 31 executed all three
resolution steps and closed the entry, adding that the ordering fails **even naively** (CTI-TAA
`Correct` = 52 < 63.88). **(a) and (d) are NOT repaired and cannot be from this paper** — they
travel as permanent qualifiers inside the candidate. **Cycle 33 priced the result: `ttp` HELD at
2 rather than recovering to 3, because closing the contradiction repaired only ONE of the two
comparands.***

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29 AND AGAIN BY 33.**
`attribution-confident-wrong-gap` **bundles a well-evidenced question with an unevidenced one, and
only a T2 can fix it.** The **error-rate** half is well grounded (src-0002's derived 14–64%
incorrect bucket on 50 alias-tolerant real reports). The **confidence** half has **no evidence at
all** — no source in this base measures expressed confidence on threat-actor attribution. Natural
cut: `attribution-error-rate` vs `attribution-confidence-calibration`, the second probably merging
into whatever [37] produces. **Next T2 is cycle 51.** *Successors must not quote the corroborating
parenthesis unqualified: **the "within-table rubric contrast" as stated differences two different
metric definitions** ([47]). The direction survives at **block** level only.*

**[46] — NEW cycle 29. src-0008 CONTAINS TWO SELF-CONTRADICTIONS AND ITS PER-PHASE NUMBERS ARE
IMAGE-LOCKED; `ctr-0007` OPENED; REPAIRED BY APPEND IN BOTH PLACES.** **(a) THE STORED CLAIM IS
OVER-GENERAL.** *"Cohere, however, shows progressive degradation: 1% missed detections in P1, 2%
in P2, 5% in P3, and in P4, 65% misses plus 35% explicit 'Don't Know' responses"* — and **P1–P4
contain no cryptography**. So plain-text IoC recovery is **not** near-free "for current LLMs", and
**encryption is not the boundary**. The finding **cuts both ways** and cycle 29 asserted neither
direction. **(b) IT DEFINES ITS METRICS TWICE, INCOMPATIBLY.** **(c) PHASE LABELS** — see [5].
**(d) PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so the stored percentages are
**figure-derived**. **(e) TABLE 6 IS READABLE AND WAS NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 /
35 / 22.8%, aggregates over all thirteen phases, **never per-phase**. **(f) PASSED:** Table 7 and
the abstract. **ACTION STILL OPEN AND NOT MINE: a T3 on `ioc-extraction-reliability` should
rewrite the third candidate_resolution to state Cohere's P1–P4 degradation, decide whether
model-side variance under syntactic noise supports or undercuts the scaffolding hypothesis, and
relabel the figure-derived percentages.** *Passed on undone. With [42], `ioc-extraction-reliability`
carries **two** named undone T3 jobs and **three** open contradictions.*

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME;
THE JUDGE IS A MODEL UNDER TEST; `ctr-0008` OPENED. (d) DISCHARGED AT CYCLE 33.** **(a)** Appendix
C.2 prints separate criteria blocks. **Threat Actor**: *"Attribution: 1: Information is unverified
or unattributed. … 5: Fully attributable; all details are clearly linked to the original
article."* — **source linking**. **Root Cause**: *"… 5: Perfect attribution; clearly identifies
the threat actor."* — **actor identification.** **The labels run OPPOSITE to how the state read
them.** **(b) WHAT SURVIVES:** the **block-level** contrast — GPT-4o lower on **all six**
dimensions (1.547 / 1.528 / 1.145 / 2.019 / 1.734 / 1.140 vs 3.686 / 3.458 / 3.362 / 3.932 /
3.753 / 3.612). **(c) THE JUDGE IS GPT-4o**, one of the four scored models; in the source's
favour, *"an agreement rate … exceeding 95%"*. **Direction cuts against the easy reading**:
self-preference would inflate GPT-4o's own scores, and GPT-4o scores **lowest**. **Any citation
of the GPT-4o-vs-o3-mini gap must state that GPT-4o was the judge.** **(d) — DISCHARGED CYCLE 33.**
The three affected candidates were priced: `task-dependent-reliability-framing` **3 → 2** (and
the exposure was *larger* than this item stated — candidate 2 makes **two** defective src-0007
comparisons, not one, and its "varying only the sub-task" warrant is false),
`extraction-vs-reasoning-ordinal-axis` **3 → 2**, and `attribution-confident-wrong-gap` **held at
2** (candidate 3 is `proposed` and never carried the score). **(e)** The third candidate's stated
reason for being `proposed` is discharged ([19]), so a T3 must decide its status on
metric-definition ground. **(f) ACTION, STILL OPEN AND NOT MINE:** cycle 31 confirmed the code
side — `eval/root_cause.py`'s live `sys_prompt` anchors are **unambiguously actor
identification**, and **no judge model is hardcoded** (`--model` required, no default), so
Appendix C.2's "using GPT-4o" describes how the authors **ran** the harness, not the released
code. **`eval/threat_actor.py` was NOT obtained verbatim** — the fetch returned a summary, which
under rule (ix) is as untrustworthy as a bare ABSENT. **Re-fetching it verbatim is step 1 of
`ctr-0008`'s repair and remains a job for a T3 targeting `attribution-confident-wrong-gap`.**

**[48] — FORMALISED AT CYCLE 32. A PROVENANCE GRANULARITY SPLIT IN src-0012.** `src-0012.md`
carries the corroborating Going Concern URL in full, but `index.json`'s `key_claims[3]` names the
outlet **without its URL** and `key_claims[0]` attributes the study's **2025** date **with no
outlet at all** — so a reader working only from `index.json` can resolve neither. The
`consulting.ca` headline URL states **no year for the EY study anywhere**; the year **is**
supported verbatim by Going Concern: *"the 2025 EY Canada report titled 'Points of Attack…'"*.
**This is a granularity weakness, not a fabrication.** No contradiction warranted. **Cheap fix for
any future cycle touching src-0012: append the outlet and URL to the two `index.json` key_claims.**

**[49] — FORMALISED AT CYCLE 32 FROM CYCLE 31's NEAR-MISS. A BYTE-SIZE CHECK FROM THE HOSTING API
MUST PRECEDE ANY ABSENT VERDICT OVER A LARGE FILE.** Cycle 31 fetched `data/TTP_Mapping.csv`
twice and got 57 lines / 59 TechniqueIDs with four ABSENT verdicts. **Taken at face value that is
a devastating finding. It is false.** The GitHub contents API reports the file at **1,083,078
bytes**. Both readings were **truncation artefacts**; the ABSENT verdicts are **void**. **This is
the limit of [38]: it says confirm an absence at a second URL form, and does not warn that both
forms can fail the same way for the same reason.** *Cycle 32's pattern: **when a file is known to
truncate, ask only what its head can answer** — and say so.*

**[50] — NEW cycle 32; HARNESS HALF FIXED BY A HUMAN AT CYCLE 33.** A cycle can land its research,
fail its bookkeeping, and be committed as "run failed, no state change". Cycle 31 exhausted
`max_turns: 50` after committing four state files but before writing its last three log sections,
**any carry-forward section**, or either queue file, and `git log` describes it as **"run failed,
no state change"** — **wrong on both counts**. **THREE THINGS FOR A HUMAN. (1)** The commit
message should be derived from `git diff --stat` on `state/`, not from the CLI's exit status.
**(2)** Writing the queue and `last_completed_task.txt` **before** the log would fail safe. **(3)**
A cycle that hits `max_turns` should be retried as the SAME task. *Cycle 33: **(3) is now fixed**
— commit `956a36c` routes an agent death through the same rollback as a gate rejection, and both
count an attempt so a too-large task escapes after `max_task_attempts`. **(1) and (2) remain
undone**, and (1) is the one that misleads successors. **FOR SUCCESSORS: verify the phase from
`next_task.json` AND `last_completed_task.txt` AND `git show --stat`, and disbelieve the commit
message.** Cycle 33 did this and found `HEAD` was a **human** commit, not a cycle at all — a case
none of the three checks anticipates but all three survive.*

**[51] — NEW cycle 32. TWO REFINEMENTS TO THE G2 MECHANISM.** **(a) SELECT BY REPLICATION COUNT,
NOT ONLY BY STALENESS, WHEN SOMETHING LOAD-BEARING IS ONE FETCH OLD.** Closing a contradiction
should itself schedule a replication of whatever closed it — extends [36]'s pipeline. **(b) "WHICH
TEXT EXECUTES" IS NOT A PRESENT VERDICT AND CANNOT BE TRUSTED FROM A STRING MATCH.** Where a
docstring and a live branch describe **different** rules, both are PRESENT and exact-string checks
settle nothing; the question must be asked separately and explicitly. **`ctr-0004` and the
cycle-31 finding are the two known instances of documentation-vs-execution divergence; assume
more.** **(c) A COROLLARY ON WHERE TO LOOK FOR DEFECTS:** `index.json`'s `src-0017` entry records
five findings cycle 31's own log never mentions. Rule (vi) warns the state may misdescribe a clean
source; **the converse also holds — a log may under-describe a rich state — so read the STATE
before re-deriving anything from a log.** *Cycle 33 used (a) in reverse and it worked: nothing was
one fetch old and load-bearing, so staleness governed, and the twice-skipped stalest source turned
out to hold a live version hazard. **Both selection criteria have now paid off once each.***

**[52] — NEW cycle 33. A CONTRADICTION ENTRY CARRIES EXACTLY ONE `issue_id`, BUT ITS CONTENT CAN
DAMAGE SEVERAL ISSUES — AND THE GATE SEES ONLY ONE OF THEM. A SIXTH SHAPE FOR [41]; FOR A HUMAN.**
`ctr-0008` is filed against `attribution-confident-wrong-gap`. Its content materially damaged
**three** issues, and by its own text the largest exposure was **elsewhere**
(`task-dependent-reliability-framing`, which it names in terms). But `jq` over
`.contradictions[] | select(.resolved_cycle==null)` groups by `issue_id`, so the G3 gate, the T5
selector and every per-issue query saw the exposure on **exactly one** of the three. Cycle 33's
`extraction-vs-reasoning-ordinal-axis` demotion is the clean illustration: it fell a point on
`ctr-0008`'s content while **carrying no contradiction at all** in the graph, and structurally it
still carries none. **Three options for a human, in ascending cost: (i) allow `issue_id` to be an
array; (ii) require the opening cycle to file a stub entry against each affected issue,
cross-referenced; (iii) accept the limitation and require every T4 to grep contradiction *bodies*
for issue ids rather than trusting the `issue_id` field — which is what cycle 33 did by hand.**
*I chose (iii) plus a targeted new entry: I filed `ctr-0009` against `task-dependent-reliability-framing`
because it had a **distinct, unfiled** conflict of its own (the IoC-vs-TTP half, which `ctr-0008`
does not address), and I deliberately did **not** file a duplicate for
`extraction-vs-reasoning-ordinal-axis`, whose defect `ctr-0008` already records with a repair
path. **Filing entries to make a gate fire would be gaming it; recording the structural gap is
the honest move.***

**[53] — NEW cycle 33. THE ARXIV VERSION CHECK IS CHEAP, IT HAS NOW PAID OFF, AND A REVISION CAN
RENUMBER THE TABLES A STORED CLAIM CITES.** One fetch of `arxiv.org/abs/2602.06718` revealed a
**v2 (14 May 2026)** of src-0011 that no cycle had noticed in twenty-one cycles. **Every headline
quantity survives the revision unchanged**, so the state is not wrong. **But the per-venue table
is `Table 3` in v1 and `Table V` in v2, and v2's `Table 3` is an entirely different per-model
table.** A future cycle fetching the current version and asking for "Table 3" would receive
unrelated content **and could open a spurious contradiction against a clean source** — the exact
inverse of the failure mode [38] guards against. **Two standing rules: (a) run the `/abs` version
check on every arXiv source you touch, per [39]; (b) when a stored claim cites a table BY NUMBER,
either pin the version in the URL or ask for the table BY DESCRIPTION.** *Known version traps in
this base: src-0002 (v2 has no CTI-ATE task at all — fetch v3), **src-0011 (v2 renumbers the
tables)**. Two of eighteen sources, and only two have been checked.*

**[54] — NEW cycle 33. THE SCORE DISTRIBUTION HAS COLLAPSED TO A SEVEN-WAY TIE AND THE
WEAKEST-LINK SELECTOR IS NOW EFFECTIVELY THE TIE-BREAK. FOR A HUMAN, AND FOR THE PAPER.**
After cycle 33 the graph reads **`institutional-incident-real-world-impact` 3, and all seven other
issues 2**. A selector that picks the weakest issue cannot discriminate among seven equals, so the
under-specified tie-break of [11] and the never-expiring `created_cycle` fallback of [30] are
doing **almost all of the selecting in this project**. **I record explicitly that I considered
whether this is a reason to score less harshly and concluded it is not**: `prompts/t4_assess.md`
step 5 is explicit that optimistic scoring breaks the selector, and inflating a score to make a
downstream mechanism behave is precisely the failure that instruction guards against. **The right
response is to flag the mechanism, not to distort its input.** *Two observations for whoever
designs the successor system. **(a)** A stingy rubric applied honestly over many cycles is
**compressive** — issues fall toward the level their weakest leg supports and pile up there —
so a weakest-link selector degrades exactly as the assessment discipline improves. That is the
same perverse-coupling shape as [41]'s dead-code ceiling, and it is the second instance.
**(b)** The scoring scale is doing two jobs at once — *reporting* evidential state and *ranking*
work — and they need different resolutions. A tie-break on **actionability** (does this issue have
a named, costed, undone job?) would have selected well this cycle, where `created_cycle` will not:
five of the seven tied issues carry named undone jobs and the one that carries three of them has
lost five consecutive selections.*
