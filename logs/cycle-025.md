# Cycle 25 — T3 Investigate: `consistency-calibration-as-failure-mode`

**Note on numbering.** The queue entry was written by cycle 23 and told me to write
`logs/cycle-024.md`. Cycle 24 **died before producing any state change** — its transcript
(`logs/cycle-024-transcript.txt`, 150 bytes) contains exactly one line, `API Error: 529
Overloaded`, and the commit is `6fdc983 cycle 24: T3 investigate run failed, no state
change`. So this is cycle 25 executing the unchanged cycle-23 queue entry, and the log is
`logs/cycle-025.md` per `prompts/system.md` ("NNN = current cycle"). **The phase has
shifted by one; see [28], which changes the next-T1 projection substantially.**

## Task performed

T3 on `consistency-calibration-as-failure-mode`, per `prompts/t3_investigate.md` (read
directly, not via the queue entry's description of it).

**The blocker, as the handoff stated it and as I found it:** both supported
candidate_resolutions cited `src-0001` and nothing else, and cycle 16's T2 scope ruling
(endorsed at cycles 19 and 22) held that `src-0013`/`0014`/`0015`/`0016` do not corroborate
because none measures a **CTI** task. The job was to find a CTI-task measurement of
repeat-query consistency or of confidence calibration by a team unrelated to src-0001's.

**Result: found one, for the consistency half only.** `src-0018` — SentinelLabs,
Milenkoski & Cirstea, 9 March 2026 — measures decision consistency across repeated
identical runs on IOC extraction from narrative threat reports. Added as a source per T1
rules (1 of the 5-source budget). The calibration half is untouched and remains
src-0001-only; I did not pretend otherwise, and the new candidate_resolution says so in
its own text.

**The scope ruling was not re-litigated and did not need to be.** src-0018 is CTI proper
(IOCs, hashes, threat-actor playbooks, from real threat reports), so admitting it asserts
no cross-domain generalisation. The four security-adjacent sources stay exactly where
cycle 16 put them.

### Open questions worked

- **[0] gpt4o-specificity — ANSWERED, in the negative.** Table 6 was pulled whole for the
  first time in 25 cycles. It is gpt4o-only and **nine rows**, not the five this base had
  stored. There is **no ECE or Brier figure for gemini-1.5-pro-latest or mistral-large-2
  anywhere in the paper**, so the question cannot be settled from src-0001 at all; it now
  requires a new measurement, and none exists in this base.
- **[1] model overlap — still fully open, and cycle 25 widened it.** src-0018's five
  models (GPT-4.1, GPT-5, GPT-5.2, Claude Sonnet 4.5, Claude Opus 4.5) overlap **no** list
  in this base. The base now holds CTI-task consistency evidence on two disjoint model
  sets a generation apart and **zero** per-model replication.
- **[2] does the framing extend to src-0002/src-0005 sub-tasks — untouched.** Neither
  fetch bore on it; left as-is rather than dressed up.
- **[3] is the fine-tuning degradation a small-data artefact — narrowed, still open.** The
  paper **nowhere** attributes the degradation to dataset size or overfitting (checked
  explicitly). The only sentence about the split came back **elided** from the fetch ("We
  randomly select 70% of the dataset...70% to the few-shot examples section and
  fine-tuning") so it is **not verbatim-captured** and I did not record it as such.
- **Two new open questions added**: recovering src-0018's image-locked numbers, and
  whether any source anywhere measures proper-scoring calibration on CTI other than
  src-0001 (cycle 25: no).

### Leads: one killed, one still standing

- **CTIArena — FOUND, FETCHED, AND KILLED FOR THIS ISSUE.** Carry-forward [6] listed it as
  a lead with no URL since cycle 17. It is `arXiv 2510.11974v1`, Cheng/Liu/Li/Song/Gao
  (Virginia Tech, UC Berkeley), 9 CTI tasks, 10 models. It measures **neither**
  repeat-query consistency **nor** calibration/abstention. **Not collected** — adding a
  source that cannot serve the issue that paid for the fetch would be padding. Recorded in
  the issue's open_questions so no future cycle re-proposes it for this purpose.
- **SEvenLLM** (`arxiv.org/pdf/2405.03446`) — still uncollected, still only a lead, and
  after CTIArena I would rate it **lower** than the handoff did: a 28-task
  understanding/generation benchmark is the right *shape* but benchmarks of this family
  have now twice turned out to report accuracy only.
- **No arXiv companion exists for src-0018** (searched).

## Retrospection

**Target: `src-0001`** (arXiv 2503.23175), as the handoff recommended — stalest source in
the base (last verified cycle 7) and sole support for both of this issue's supported
candidates. I applied all three parts of the methodological rule in [31]: whole-table
verbatim pull with an explicit ABSENT/CANNOT-READ instruction, exact-string checks on
stored quotations *and* stored numbers, and — the part added at cycle 23 — the verbatim
**definition** of the metrics.

### What passed

- **Every one of the five Table 6 cells this base had stored is EXACT.** So are the
  accuracy figures 0.87→0.68, the derived percentages 27.27 / 7.87 / 21.84, and the
  dataset size 350.
- **The consistency protocol is stronger than the base had recorded.** Verbatim: "we
  re-prompt each LLM ten times on the same input, **with temperature=0 and the same seed
  to guarantee maximum determinism**, derive precision, recall, and f1-score, and then
  employ the bootstrapping method to empirically build CIs." The base had this as "10
  re-prompts with bootstrapped CIs" and never recorded the determinism settings. The
  measured spread is therefore **residual non-determinism under maximal determinism
  settings** — this strengthens the finding rather than weakening it.
- **The stored abstract quotation is exact** — but see the false-ABSENT finding below.
- **New provenance fact: src-0001 is peer-reviewed and published.** The page carries
  "Mezzi, E., Massacci, F., & Tuma, K. (2025, August)… International Conference on
  Availability, Reliability and Security (pp. 343-364)… DOI:
  https://doi.org/10.1007/978-3-032-00627-1_17". This base has called it an unreviewed
  preprint since cycle 1 and used that in provenance comparisons. Appended, not rewritten.

### What failed: `ctr-0003` is opened

**The stored claim** (src-0001 `key_claims[4]`, and this issue's candidate_resolutions 1
and 2, both **supported**): calibration "was markedly worse for information-generation
than information-extraction sub-tasks, e.g. CVE-generation ECE 0.15 (zero-shot)".

**Table 6, whole, zero-shot ECE.** Extraction: campaign 0.25, APT 0.16, CVE 0.28, attack
vector 0.13. Generation: goals 0.13, labels 0.45, country 0.19, CVE 0.15, attack vector
0.47.

Three generation rows are **better** calibrated than two extraction rows, and the claim's
own worked example — CVE generation at 0.15 — is better calibrated than CVE extraction at
0.28. **The example cited for the generalisation contradicts it.** This is the [31](c)
defect class exactly: correct numbers, unsupported interpretive gloss, invisible to any
check that stops at "is the number right?".

**What survives, stated so the next cycle does not over-correct.** The generation mean ECE
does exceed the extraction mean at every paradigm — but the gap is small at zero-shot
(0.278 vs 0.205) and large only after fine-tuning (0.538 vs 0.295), and the extreme
miscalibration sits in exactly two fine-tuned generation rows (CVE 0.91, attack vector
0.87). *All four means are derived by me from the printed cells and are not printed in the
paper.* And the strongest version of the fine-tuning finding is not about extraction vs
generation at all: **fine-tuning worsened ECE on 7 of the 9 rows and BS on the same 7**
(derived by cell comparison), improving only extraction CVE (0.28→0.18) and generation
goals (0.13→0.08). "Fine-tuning does not reliably improve calibration and sometimes
destroys it" is well supported. "Generation is markedly worse than extraction" is not, at
least not before fine-tuning.

**The CONSISTENCY half of the extraction-vs-generation split is untouched** — CI widths
0.02 vs 0.06 re-verified. `ctr-0003` says so explicitly, because
`extraction-vs-reasoning-ordinal-axis` and `task-dependent-reliability-framing` both lean
on that split and a careless read of the contradiction would damage them wrongly.

### A methodological by-product that matters more than the contradiction

The `/html` fetch that produced Table 6 reported the exact string "inconsistent and
overconfident" as **ABSENT**. A second fetch of `/abs` returned the abstract in full: "We
show how LLMs cannot guarantee sufficient performance on real-size reports while also
being inconsistent and overconfident." **The ABSENT verdict was a false negative.**

Cycles 21 and 22 recorded quotation/number defects in src-0016 and src-0003 **on the
strength of single-fetch ABSENT verdicts**. Those verdicts may still be right — src-0016's
splice was independently reasoned, and src-0003's 76/72/86 are demonstrably figure-only —
but the inference "one fetch said ABSENT, therefore the string is not on the page" is now
known to be unsound in this harness. **A single fetch's ABSENT is not evidence of absence.**
New carry-forward [38]. I did not open a contradiction for this: it is a claim about my own
tooling, not two supported claims in conflict.

## Changes made

- **`state/knowledge/src-0018.md`** — NEW. Full verbatim capture of the SentinelLabs post:
  bibliographic facts, task and corpus, the repetition protocol, both decision-consistency
  metric definitions, the abstention construct, the independence argument against
  src-0001, and the image-locked-numbers limitation stated three times over.
- **`state/knowledge/index.json`** — `src-0018` entry added (4 key_claims, `type: article`,
  URL verified resolving by two live fetches). **Two key_claims appended to `src-0001`**:
  the whole of Table 6 with caption, the verbatim consistency protocol and metric
  definition, the exact-string results, the ARES 2025 venue, the elided fine-tuning-split
  sentence flagged as not-verbatim; and the calibration-gradient correction with the
  derived means labelled as derived, plus the false-ABSENT warning. **Nothing removed or
  rewritten.**
- **`state/issues/graph.json`**
  - Two candidate_resolutions **added**, both `supported`: the two-independent-source CTI
    consistency claim (`src-0001` + `src-0018`), written with the consistency/calibration
    split spelled out for the T4; and the whole-Table-6 finding (`src-0001`).
  - `open_questions` **rewritten**: 4 → 6. [0] answered-in-the-negative and restated, [1]
    widened, [3] narrowed, two new ones (recover src-0018's images; does any non-src-0001
    CTI calibration measurement exist — with CTIArena recorded as checked and rejected).
  - `attempts`: `[3, 15, 16]` → `[3, 15, 16, 25]`.
  - **`ctr-0003` opened** against this issue (G3).
- **Not changed:** `state/assessments/scores.json` — scoring is T4's work. The two older
  supported candidates were **not** rewritten; `ctr-0003` records the conflict instead, per
  the append-only rule and G3's "do not silently pick a side".

Every JSON edit was validated with `jq -e . <file> > /dev/null`; both files parse. One
edit produced a missing comma between array elements, caught by `jq` immediately and fixed
— which is the whole argument of carry-forward [24].

### What a T4 has to decide, stated plainly

This issue's title asks **two** questions and the evidence is now **asymmetric**:

| axis | on CTI material | status after cycle 25 |
|---|---|---|
| repeat-query consistency | src-0001 (350 reports, 3 models, 10 re-prompts, CI 0.02/0.06) **+ src-0018** (343 IOCs / 1859 attribute instances, 5 current models, repeated identical runs) | **two independent sources** — but src-0018 contributes **direction only**, no readable number |
| confidence calibration (ECE/Brier) | src-0001 alone, gpt4o alone, 9 table rows | **single-source**, and its headline gloss is now under `ctr-0003` |

I am the T3 and have no standing to score. What I will say is that the level-3 bar the
handoff described — "primary candidate rests on at least two independent sources" — is
**met for the consistency claim and not met for the calibration claim**, and that
`ctr-0003` caps this issue at 3 under the G3 **ceiling** regardless (see [4]: apply the
ceiling, not subtraction).

## Next task rationale

**T4 (assess)**, per the state machine `T3→T4`. Target: the whole issue set, as T4 always
does, with `consistency-calibration-as-failure-mode` the one that actually moved.

The next cycle has three things to weigh that did not exist before it: a second
independent CTI source on the consistency axis; a new contradiction against the issue
being rescored; and, carried over untouched, `ctr-0002`'s demand that
`attribution-confident-wrong-gap` be reweighed. **`ctr-0002` is a T3 job, not a T4 job**
([36]) — the T4 must weigh it when scoring but must not try to resolve it, and the cycle-27
T5 should know that a T3 targeting that issue is what [36] actually needs.

## Budget

- Web searches: **4** (one for a CTI consistency/calibration source; one for
  ATT&CK-mapping calibration; one for CTI self-consistency/non-determinism; one for an
  arXiv companion to src-0018).
- Web fetches: **5** — `arxiv.org/html/2503.23175` (G2, whole Table 6 + strings +
  definitions + protocol, one call), `arxiv.org/abs/2503.23175` (abstract, to settle the
  false-ABSENT), `arxiv.org/html/2510.11974v1` (CTIArena, killed as a lead), and the
  SentinelLabs page **twice** (prose capture, then a cell-by-cell number attempt that
  returned IMAGE - CANNOT READ four times).
- New sources: **1** of `max_new_sources: 5`.
- Bash calls: 8 (`jq` inspection and validation, `ls`, `git log`, `sed`). File reads: 8,
  mostly windowed via the Grep-then-offset pattern in [24]. Edits: 8.
- Turns: roughly 25 of 50. No retries, no failed fetches, nothing abandoned.

---

## Carry-forward items

All items from `logs/cycle-023.md` reproduced **including those I could not act on**, with
cycle-25 updates. Discharged items stay marked rather than deleted. Cycle 24 produced no
log at all, so this section is the only continuous thread across the gap. **Three new
items: [37], [38], [39].**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim
stayed; ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2
candidate moved verbatim. Still vindicated: the two halves score 3 and 3 and moved for
different reasons at cycle 22.

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. The
graph records a three-team claim. Did **not** move the score; the blocker is
`open_question[1]`, the missing human-analyst baseline, now in its **fourteenth** cycle.
See [10].

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First-scored
cycle 19 (2), held at 2 cycle 22. It has now **lost two consecutive selections** and still
has `attempts: []` — see [30].

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, AND STILL UNTESTED AFTER 16 CYCLES.**
The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**),
`config.yml` line 35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156
(**ceiling**, = 3 under current config). The enforced reading is in the minority. Cycle 16
ruled for the **CEILING**; replacement text in `logs/cycle-016.md` "Item 3". **NOT
APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside this agent's output surface.
**Until a human applies it, T4s must apply the ceiling.** *Cycle 25 note: **the stakes
tripled.** `ctr-0003` means a **third** issue now carries an open contradiction. Under the
ceiling: `ioc-extraction-reliability` capped at 3 (currently 3, legal),
`attribution-confident-wrong-gap` capped at 3 (currently 3, legal),
`consistency-calibration-as-failure-mode` capped at 3 (currently 2, legal, and the cap does
**not** block the 2→3 move this cycle's evidence supports). Under subtraction those three
would read 0, 1 and 0 — **three of eight issues fabricated to the bottom of the
weakest-link selector, silently, because subtraction never trips the validator.** The
cycle-26 T4 must apply the ceiling.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at
P5–P6, the paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected;
no contradiction opened. Needs a PDF-level check, blocked by [14]. Per-phase percentages
exist ONLY as pie charts (Figure 2); Table 7 hallucination rates (Anthropic 0.11%, ChatGPT
0.23%, Gemini 4.8%, Grok 0, Cohere 0) are verified exact. Not touched at cycle 25.

**[6] — UPDATED cycle 25; ONE LEAD KILLED, ONE DOWNGRADED.** Unfinished search directions,
open since cycle 9: citation-graph sweep of arXiv 2506.11325; **third-party evaluations of
the IoC Searcher / AlienVault OTX / VirusTotal baselines** (much more valuable since [32]);
the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no preprint — do
not retry). **Forward-citation sweeps have FAILED on two different arXiv ids —
unavailable infrastructure, not an unsearched direction.** *Cycle 25: **CTIArena is
resolved and dead for consistency/calibration purposes** — it is `arXiv 2510.11974`
(Cheng, Liu, Li, Song, Gao; Virginia Tech / UC Berkeley; 9 CTI tasks, 10 models), it was
fetched, and it measures neither repeat-query consistency nor calibration/abstention. It
was NOT collected. It may still be a good T1 target for
`ttp-attack-mapping-reliability`-type issues — it is knowledge-augmented and multi-source,
which nothing else in this base is — but never re-propose it for
`consistency-calibration-as-failure-mode`. **SEvenLLM** (`arxiv.org/pdf/2405.03446`, 28 CTI
tasks) remains uncollected and is now **downgraded**: two benchmarks of that family have
now been checked and both report accuracy only. **AthenaBench** still has no URL.
**No arXiv companion exists for src-0018** (searched at cycle 25).* Unavailable: OpenReview
(`openreview.net/forum?id=tiFtZHwr7O` and `api2.openreview.net` both serve a browser
challenge), spiegel.de (see [13]).

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT CYCLE 22.** `ctr-0001` resolution path.
**Done:** the released-code route is exhausted — recall is NOT recoverable (model outputs
unpublished) but the release proves the omission was a reporting choice. **METRIC confound
ELIMINATED.** **Still open:** no head-to-head; the **CORPUS confound is completely
untouched and is the largest gap**. The SYSTEM confound gained its first paper-stated
anchor at cycle 22 ([33]); the matching-rule limb is **closed as unanswerable from this
base**. **Remaining next steps, cheapest first:** src-0007's TTP and rubric scorers in the
src-0017 artefact ([34]); `huggingface.co/datasets/xse/CyberThreat-Eval`, still unfetched;
then the corpus-difficulty comparison, which may need a new source.

**[8] — UPDATED cycle 25. G2 COVERAGE REMAINS COMPLETE FOR EVERY SOURCE BUT TWO.** src-0004
(c4, c12), src-0003 (c5; c22 — substance passed, provenance partial fail, [32]), src-0002
(c6; c23 — numbers passed exactly, interpretation failed, `ctr-0002`), **src-0001 (c7; c25
— numbers and protocol passed exactly, interpretation failed, `ctr-0003`, and the source
turns out to be peer-reviewed, [39])**, src-0006 (c8; c17 partial fail [21]; re-pulled
c18), src-0005 (c9 substance-only, c11 verbatim), src-0008 (c10), src-0012 (c13), src-0011
(c14), src-0007 (c15; c21 Table 4 whole), src-0009/src-0010 (c16), src-0013 (c18),
src-0014 (c19), src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]). **Never
verified: src-0017 (added c21) and src-0018 (added c25).** *Next G2 should prefer, by
staleness: **src-0005 (c9, and see [10])** — now the stalest by a wide margin and still
holding `ttp-attack-mapping-reliability` at 3 with zero captured numbers; then **src-0017**,
never verified and a different kind of check (file paths and code lines). Not recommended
next: src-0001 (c25), src-0002 (c23), src-0003 (c22), src-0016/src-0007 (c21), src-0015
(c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23 and 25.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks
every invocation; compound/piped commands are rejected if any segment is unapproved. **No
PDF text extraction exists** — prefer `/html` always; `/abs` pages carry no tables *but do
carry the abstract, which is exactly why the cycle-25 false-ABSENT check worked — see
[38]*. `gh` is **not** approved, so GitHub goes through `WebFetch`. `awk` refused. **`sed
-n` and `cat >>` heredoc ARE approved.** A compound `jq … && cat >> … <<'EOF'` was
**rejected** at c22 — run a heredoc append as its own call. `jq -e . <file> > /dev/null`
**is** approved. *Cycle 25: all held; `sed -n … | cat -A | cut` was approved as a compound,
and the `Grep` tool remains necessary where Bash `grep -n` is refused. One new datum: a
multi-line `Edit` `old_string` spanning an array-element boundary in `index.json` failed to
match on the first attempt for no visible reason (the file is plain LF, verified with `cat
-A`); **single-line anchors matched immediately**. Prefer single-line anchors.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Every claim it contributes is
abstract-level and directional, and it is one of the sources holding
`ttp-attack-mapping-reliability` at 3. **Oldest un-actioned collection task in the project
(open since cycle 1); T1 work.** A T1 targeting that issue should hunt the **human-analyst
baseline F1** first (the actual level-4 blocker) and src-0005's numbers second. *Cycle 25
note: this got materially worse — per [28] the next T1 is now cycle **43**, not 35.*

**[11] — APPLIED AND EXTENDED cycle 20; APPLIED AGAIN AND STRESS-TESTED cycle 23.**
Tie-break 3a in `prompts/t5_select.md` is under-specified, with no deterministic tie-break
after 3c. Cycle 20 ruled for the **strict pairwise** reading; cycle 23 endorsed it and
showed both readings select the same issue. **The eff-3 tier is a four-way terminal tie**
on score, 3a, 3b and 3c. **A terminal deterministic tie-break — e.g. lexicographic issue id
— is needed.** Same class as [4]. *Cycle 25 note: unchanged, but `ctr-0003` will reshuffle
that tier at the next T5, since this issue may now sit at 3 alongside the others.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — and this item's stronger
claim was WRONG; see [17]. T2 is the only task type with standing to split an issue, add an
issue, or reconcile the prompt/validator disagreement. The claim that the loop "never
returns to T2" is false; cycle 16 disproved it. *Cycle 25 note: bit again — the
consistency/calibration **split** documented above is arguably an issue-split job (one
issue asking two questions with asymmetric evidence), and only a T2 can do it. See [37].*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der
Spiegel is the upstream primary for the entire ENISA incident: a permanent structural gap.
The archived-PDF footnote-count route is also closed (see [14]). Prof. Christian Dietrich's
/ Institut für Internet-Sicherheit's own writeup is the only remaining route known to this
agent. OpenReview joins this category — see [6]. `ctr-0002` weakens
`attribution-confident-wrong-gap`'s src-0002 leg, which throws more weight onto the
src-0004 ENISA leg — whose AI-causation limb is exactly the one that cannot be
strengthened from here.

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA
v1.2 PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is
established at landing-page level and UNVERIFIABLE at document level here.** That leg
**cannot strengthen**. **Do not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED
AGAIN.** The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of
AI-generated "slop" reports; ~20% of submissions AI slop by mid-2025; confirmed-
vulnerability rate falling from ~15% to under 5%) is an **open_question on
`automated-triage-under-refusal`**. **It is a question, not evidence — no curl source
exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19 and 22 both judged it the highest-value uncollected source in the project. A T3
may add sources ([29]), so it remains a one-cycle job whenever that issue is selected —
earliest now the cycle-27 T5's target, i.e. cycle 28.

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on
the base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`:
an "automated pipeline to search for vibe citations by finding and scanning public reports
from major consulting firms", releasing findings "one report at a time", having already
investigated "a government publication, two different Deloitte reports, and prestigious
machine learning / artificial intelligence conferences like NeurIPS and ICLR". A T1 should
chase `gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor
reporting on its own product's value; no *rate* published; the scorecard widget renders as
"0 of N" to automated fetch — read body text, not the widget. **Still the only route any
cycle has found to a base rate**, the binding constraint on
`institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is
the escape to T2: `prompts/system.md` specifies `T1→T2`, and the refresh rule makes a T5
landing on a multiple-of-7 cycle emit a T1, so the chain is **T5 → T1 → T2**. Confirmed
end-to-end by cycles 14→15→16. Structural finding for the paper: the only task type that
can restructure the issue graph fires when a T5 coincides with a multiple of 7 — under a
clean three-cycle loop, **once every 21 cycles**, not every 7. *Cycle 25: and a single
infrastructure failure can push it 8 more — see [28].*

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was
opened**. Any cycle quoting src-0011's *counts* should take them from Table 3's columns.

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLE 22.** src-0007's Table 4 pulled
**whole and verbatim** into `state/knowledge/src-0007.md`. Triage rows: precision
(Accepted) **0.2717–0.3982**, recall (Accepted) **0.9091–1.0000**, so
`automated-triage-under-refusal`'s stored "0.27–0.40 vs 0.90–1.00" **holds as stated**.
Fine-tuning does not fix the asymmetry and on the Article task worsens precision (GPT-4o
0.3037 → GPT-4o (FT) 0.2717). **RESIDUE, UNRESOLVED AND REPRODUCED:** GPT-4o (FT) tracks
o3-mini to within 0.001 on **all six** Content: Threat Actor rubric rows, identically in
two independent pulls (c15, c21) — as-printed, not a fetch artefact. **Cause unknown; do
not guess. Any claim resting on that column must say it is suspect.**

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18),
src-0014 (c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy is **narrowed but
not closed** — 33.9% is TABLE II's per-model aggregate, 16.9% → 83.2% is the
SALLM-to-repository comparison; different scopes, not arithmetically reconcilable, so
**quote them only with their scopes named**. Gemini's 0.161 → 0.721 was **not** re-checked.
**Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW
STANDARD.** `src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at
"F1 0.754 for a specialized agent vs. 0.688 for a general model". **ZYS (0.688) is
cyber-SPECIALIZED**; the true general-purpose peak is **G5 at 0.677**. Direction survives,
label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a true span of
**0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md`
itself is still untouched and still contains the wrong sentence.** Column split: 8 general
(G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0, ZYS, LLY, CBS, SPT, DHT).
**`src-0006.md` is the only known source file still carrying an uncorrected sentence** and
it is a cheap fix for any cycle touching that source. *Cycle 25 followed the
repair-both-places pattern for src-0001 (index.json got the appended claims; `src-0001.md`
gets its appendix — see "Changes made" — so the pattern now holds for cycles 22, 23 and
25).*

**[22] — REPRODUCED A THIRD TIME cycle 18.** An unexplained regularity in src-0006's Table
2: eleven of twenty-eight rows are **strictly monotone decreasing across all eight
general-purpose columns in exactly the printed column order**. Four are in the nine-row F1
subset `extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements, one
row matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch
artefact.** Cause unknown; do not speculate. **Any finding resting on src-0006's Table 2
must carry a robustness check excluding these rows** (cycle 18's: drop all four → 0.641 vs
0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly
0.20–0.90" as evidence that reliability varies sharply by sub-task. Mean between-**model**
range within a task (0.272) and mean between-**task** range within a model (0.263) are
equal to within 0.009. **This does NOT negate the supported claim** — cycles 19 and 22 both
tested it and both concluded it is not a counterargument; it qualifies the implication that
sub-task is the *privileged* explanatory variable. A T2 should annotate the parent's
candidate rather than re-scope it. No contradiction entry: both facts hold simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23 AND 25. `jq` IS INSTALLED AND
APPROVED.** `jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r
'<filter>'` reads structure without a full-file Read. **Every cycle from 9 to 17 recorded
that this agent cannot validate JSON and must check "by construction". That advice is wrong
and it is expensive** — cycle 17 made five blind edits to a 57 KB JSON file and had its
entire `state/` output reverted. **Every JSON edit should be followed by a `jq -e` check.**
The permission layer is **not uniform** — probe once, don't infer from class. The `Grep`
**tool** works on the big JSON files where Bash `grep -n` does not. The cheapest
append-only edit pattern is **`Grep` tool → `Read` with `offset`/`limit` → `Edit` → `jq
-e`**. *Cycle 25: this paid for itself immediately — an inserted object left a missing comma
between array elements and `jq -e` caught it on the next call, before anything else was
built on top of it.*

**[25] — DISCHARGED CYCLE 21.** `state/knowledge/src-0007.md` now contains the Content:
Threat Actor rubric block in full, verbatim, all six rows and four columns, alongside the
whole of Table 4. **The two caveats travel with it and must keep travelling:** the rubric's
**absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4,
a normalisation the paper never states), so **only within-table contrasts may be cited**;
and the GPT-4o (FT) column is suspect per [19].

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17
failed validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's
errors to stdout, but `logs/cycle-017-transcript.txt` captures the agent's own output only,
and the reverted `state/` files were never committed. Suggested harness fix for a human:
tee `python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before
reverting, and `git stash` the rejected `state/` diff rather than discarding it. *Cycle 25
note: **cycle 24 is the mirror-image case and it worked correctly** — the transcript
captured the single line `API Error: 529 Overloaded`, which is why this cycle could
diagnose the gap in one read. The transcript mechanism is fine for **crashes**; it is blind
to **validator rejections**, which is exactly the fix requested above.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH.** src-0015's Table 1 has a **`Reward`**
column no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61, DeepSeek
3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward**, and the
two highest-containment models take the two highest rewards. Bears directly on
`automated-triage-under-refusal`'s `open_questions[0]` — models versus harness. **Caveats:**
the fetched material does not state the reward's composition; n = 40 per model, no CIs; the
association is not strictly monotone. It is an observation about an **already-collected**
source, so **no new citation is needed**. Cycle 22 recorded it in that issue's `rationale`,
but a rationale is not the graph. Still unentered.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23 AND **RE-DERIVED WITH A CHANGED RESULT** at
cycle 25.** The state machine is T1→T2, T2→T3, T3→T4, T4→T5, T5→T3. **Cycle 24's T3 died
before writing anything and cycle 25 re-ran it, so the phase shifted by one exactly as this
item warned.** New positions: **cycle 25 = T3 (this one), cycle 26 = T4, cycle 27 = T5,
cycle 28 = T3**, and T5 thereafter lands on 27, 30, 33, 36, 39, **42**.
`collect_refresh_every: 7`, and the refresh fires only when a T5 **runs on** a multiple-of-7
cycle (pinned from git history: cycle 14 T5 → cycle 15 T1 collect). Of the multiples of 7
ahead — 28, 35, 42 — only **42** is a T5 cycle. **So the next T1 is cycle 43, not cycle 35.**
*This is the single most consequential thing in this log for anyone reading the project as
an experiment: **one infrastructure failure, costing one cycle, pushed the next collection
cycle back by eight** — because the refresh rule depends on a coincidence between two
periods (3 and 7) and a one-cycle shift breaks the alignment for a full lcm. The two
highest-value uncollected items ([15] curl/HackerOne, [10] the human-analyst ATT&CK
baseline) both want a T1 and neither gets one for eighteen cycles.* **Re-derive rather
than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21 AND 25.** A T3 **MAY** add sources.
`prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot
answer (and if you fetch something substantial, add it properly as a source per T1 rules —
it counts toward the same `max_new_sources` budget)." Cycle 21 exercised this and added
src-0017; **cycle 25 exercised it and added src-0018, which is what broke a blocker that had
stood since cycle 3.** **Standing lesson: read the task's own prompt file, not only the
queue entry's description of it.**

**[30] — NEW cycle 20; PREDICTION CORRECT TWICE.** `automated-triage-under-refusal`, the
only issue in the graph never worked on (`attempts: []`, created cycle 16), has **lost two
consecutive selections** to issues attempted twice and three times. **"Never attempted" is
not a tie-break in `prompts/t5_select.md`**, and cycle 19's `scores.json` rationale wrongly
asserted it was. **This is a prompt change for a human, not a reading an agent may adopt.**
Note the interaction with [11]: a **non-pairwise** 3a would rank that issue **last** of the
base-2 candidates rather than second, so resolving [11] the other way would make this
*worse*. Anyone fixing [11] should fix [30] at the same time.

**[31] — NEW cycle 21, EXTENDED cycles 22, 23 AND 25: THE EXACT-STRING / VERBATIM CHECK HAS
NOW BEEN RUN ON FOUR SOURCES AND ALL FOUR FAILED IT IN SOME RESPECT.** (a) **src-0016**
(c21): the stored "verbatim" quotation about 80 of 161 unique-unmatched findings **does not
exist on the page** — it splices a real sentence to a table cell; figures correct,
quotation defect. Its collection note claiming no table was present is false; there are
four. (b) **src-0003** (c22): three stored *quotations* passed but its stored *numbers*
76/72/86 are **figure-image-only**; see [32]. (c) **src-0002** (c23): all 25 stored numbers
passed exactly and the stored quotation passed, but the **interpretation attached to two of
those numbers is contradicted by the paper's own metric definition**; `ctr-0002`. (d)
**src-0001** (c25): all stored numbers passed exactly, the protocol sentence turned out
*stronger* than recorded, and the stored abstract quotation passed — but **the
extraction-versus-generation calibration gloss is contradicted by the full table**, and
**four of the nine table rows had never been collected at all**; `ctr-0003`. **The defect
class is four-way now: spliced quotations, unverifiable numbers, unsupported interpretive
glosses on correct numbers, and PARTIAL TABLE CAPTURE — a table stored as five of nine rows
where the missing four are the ones that would have falsified the gloss.** **Standing
lesson, upgraded again: pull the WHOLE table, not the rows the claim needs, and pull the
metric's DEFINITION alongside its value.** Thirteen sources have stored values or quotes
that have never faced any of these checks.

**[32] — NEW cycle 22. src-0003's THREE BASELINE F1 VALUES ARE FIGURE-IMAGE-ONLY AND NOT
TEXT-VERIFIABLE; REPAIRED BY APPEND.** `src-0003.md` key claim 1 and `index.json`
key_claims[1] state LANCE's 97.6% beats "IoC Searcher + whitelist (76% F1), AlienVault OTX
(72% F1), VirusTotal threshold=1 (86% F1)". On `https://arxiv.org/html/2506.11325v2` the
exact strings **`76` and `72` do not occur at all**, and the only `86%` is LANCE's own
per-type recall. They live only in **Figure 6**, an image this agent cannot read. **The
ordering is textually supported**, so nothing is falsified — but **cite 76/72/86 as
figure-derived and not text-verified.** Also unverifiable: **`~0.88 F1 with Llama`** — the
page says "Gemma and Gemini perform comparably to GPT, achieving total F1 scores of 0.98 and
0.92, respectively". Repaired by appending to both `index.json` and `src-0003.md`. **No
contradiction entry** — file when the source's own legible text conflicts with the stored
claim; do not file when the stored claim is merely unverifiable. *Cycle 25 caveat: the
"`76` and `72` do not occur" verdict rests on a **single fetch's ABSENT**, which [38] shows
is not reliable. The figure-image finding is independently solid; the exact-string limb
should be re-confirmed against a second URL form before anyone leans on it further.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER
HAD.** src-0003's 97.6% is measured on a **closed-set classification task over a
regex-extracted candidate set**, not on free-form extraction. Verbatim: "We assume a total
of 1,789 candidate indicators, extracted using IoC Searcher, a state-of-the-art rule-based
tool"; "LANCE labeled over 99% of all extracted indicators"; Figure 9's caption "… on IoC
Classification." **A difference in task format, not only in scaffolding**, and *stated by
the paper*. **Companion finding: src-0003 NEVER STATES ITS MATCHING RULE**, so the
open_question cycle 21 added is **unanswerable from this base**. **A T3 on
`ioc-extraction-reliability` should carry these into `ctr-0001` and the issue's candidates;
a T4 has no standing to.**

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but
does NOT hold the scoring rule constant.** A cross-sub-task score spread is a
task-difficulty fact only if the sub-tasks are scored comparably. src-0017 shows src-0007's
IoC evaluator matches by two-directional substring containment with a ground truth never
stated to be exhaustive; **the scoring rules for src-0007's ATT&CK and rubric tasks have
never been pulled**, and neither have the per-task scoring definitions behind src-0006's
nine F1 rows. **What restores the 4:** read `stage3_ti_drafting`'s TTP and rubric scorers in
the src-0017 repo (`raw.githubusercontent.com` worked at cycle 21) and src-0006's metric
definitions, then state and answer the objection in the issue. **Note the asymmetry:** the
same finding is neutral-to-favourable for `extraction-vs-reasoning-ordinal-axis`, whose
supported claim is *negative*.

**[35] — NEW cycle 23. src-0002's CTI-TAA `Correct` AND `Plausible` COLUMNS ARE NESTED, NOT
DISJOINT; `ctr-0002` OPENED; REPAIRED BY APPEND.** Section 4.2 verbatim: "we compute two
types of accuracy: Correct Accuracy, which is the fraction of correct answers, and
Plausible Accuracy, which is the fraction of correct and plausible answers combined."
**Plausible ⊇ Correct**, so the stored claim that the plausible rate "is far higher than"
the correct rate is **true by construction**. "Plausible" is the **underdetermined-input**
case and **hallucination lives in the separate `incorrect` category**. The string
`plausible-sounding` **does not occur in the paper**. **Derived replacements, to be labelled
as derived wherever used:** plausible-but-not-correct share = 34 / 18 / 36 / 28 / 8 pp; the
paper's own incorrect (hallucination-inclusive) rate = `100 − Plausible Accuracy` = **14% /
38% / 26% / 20% / 64%**. **All 25 stored numbers are exact.**

**[36] — NEW cycle 23, FOR A T3 AND THEN A T4; A T5 HAS NO STANDING. NOT ACTIONED AT CYCLE
25 AND DELIBERATELY SO — my target issue was a different one.** `ctr-0002`'s resolution
path, in order: **(i)** rewrite `attribution-confident-wrong-gap`'s primary candidate to
cite the derived incorrect-bucket rates (14–64%) with the derivation stated, or explicitly
retire the 86-vs-52 framing; **(ii)** decide and record which of two readings holds — **(a)**
the leg survives with a different number, or **(b)** the leg is weaker than scored, which
throws more weight onto the src-0004 ENISA leg that [13] says cannot be strengthened;
**(iii)** check whether src-0002's **other two** key_claims — feeding
`ttp-attack-mapping-reliability` and `task-dependent-reliability-framing` — carry any
similar unstated interpretive gloss. **Then** a T4 may rescore. *Cycle 25 hand-off: **the
cycle-26 T4 must weigh `ctr-0002` when it rescores that issue but must not try to resolve
it, and the cycle-27 T5 should know that a T3 targeting `attribution-confident-wrong-gap`
is what [36] actually needs.** Until resolved, that issue is capped at 3 by the G3 ceiling.*

**[37] — NEW cycle 25. THE ISSUE ASKS TWO QUESTIONS AND THE EVIDENCE IS NOW ASYMMETRIC;
THAT MAY BE A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. After this cycle: consistency-on-CTI rests on **two
independent sources** (src-0001 + src-0018), calibration-on-CTI still rests on **one**
(src-0001, gpt4o only, nine rows), and `ctr-0003` sits on the calibration half alone. A
single score now has to average two legs of different strength — which is precisely the
situation that produced the cycle-16 split of `task-dependent-reliability-framing` ([1]),
and that split is recorded as having worked. **A T4 cannot split an issue and neither can a
T3 ([12]); only a T2 can.** Flagged, not acted on. Whoever does act: the natural cut is
`consistency-under-repeated-query` vs `confidence-calibration-on-CTI`, with src-0018 and
the CI-width evidence going to the first and Table 6 plus `ctr-0003` to the second.

**[38] — NEW cycle 25, AND IT UNDERCUTS A METHOD THIS PROJECT HAS RELIED ON SINCE CYCLE 21.
A SINGLE FETCH'S "ABSENT" IS NOT EVIDENCE OF ABSENCE.** The `/html` fetch of arXiv 2503.23175
that correctly transcribed all 54 cells of Table 6 **also reported the exact string
"inconsistent and overconfident" as ABSENT**. A second fetch of `/abs` returned the abstract
in full, containing "…while also being inconsistent and overconfident." **False negative.**
The exact-string check ([31]) is the project's main verification instrument and its
*negative* verdicts are the ones that generate contradiction entries and defect records —
[31](a) and [32] both rest on single-fetch ABSENTs. **New rule for every future G2:
a PRESENT verdict may be trusted from one fetch; an ABSENT verdict must be confirmed
against a second URL form (`/abs` vs `/html` vs `/html/vN`) before it is recorded as a
defect.** No contradiction entry was opened: this is a claim about the tooling, not two
supported claims in conflict.

**[39] — NEW cycle 25. src-0001 IS PEER-REVIEWED AND PUBLISHED, AND THIS BASE HAS CALLED IT
A PREPRINT FOR 24 CYCLES.** The arXiv HTML page carries "Mezzi, E., Massacci, F., & Tuma, K.
(2025, August). Large language models are unreliable for cyber threat intelligence. In
International Conference on Availability, Reliability and Security (pp. 343-364). Cham:
Springer Nature Switzerland. Conference version DOI:
https://doi.org/10.1007/978-3-032-00627-1_17." `src-0001.md`'s limitations section says
"Preprint (arXiv), not yet confirmed as peer-reviewed/published at a venue as of access
date" — accurate when written at cycle 1, wrong now. Corrected by append. **The general
point: provenance labels in this base were set at collection time and have never been
re-checked, while several sources were preprints that have since been published.**
src-0013 claims "ICSME 2026 Research Track", src-0014 is recorded as "v1 preprint, no
stated venue", src-0015 as "single-author preprint … no stated venue", src-0017 carries an
unresolved "[TMLR 25]" tag inconsistent with its arXiv date. **Provenance staleness is a
cheap, unworked check** — one fetch per source, and it changes how much weight the weakest
sources deserve.
