# Cycle 035 — T3 Investigate: `ioc-extraction-reliability`

**Task type:** T3 (Investigate) · **Target issue:** `ioc-extraction-reliability` · **Attempt:** 0

Phase verified three ways before acting, per [50]: `state/queue/next_task.json` says T3,
`state/queue/last_completed_task.txt` said `T5 select`, and `git show --stat HEAD` shows commit
`e71b813` "cycle 34: T5 select" touching five files consistent with a completed T5. Re-derived the
state machine from `config.yml`: cycle 35 = T3, 36 = T4, 37 = T5. All three agree.

I also read `prompts/t3_investigate.md` at source rather than trusting the queue entry's account of
it ([29]). The queue entry's summary was accurate on the prompt. **It was not accurate on two of its
own job premises — see "Job D" below.**

---

## Task performed

Five jobs were scheduled by cycle 34. **Four executed as specified; one (Job D) turned out to be
already done, and finding that out is the more useful result.** Two open contradictions had written
resolution paths whose T3 half had never been executed — `ctr-0004` step (i)/(ii) open since cycle
27, `ctr-0007` steps (i)–(iii) open since cycle 29. Both are now discharged.

### Job A — `ctr-0004` step (i): the one-directional matcher. DONE.

Appended `open_questions[6]`. The old `open_questions[5]`, which asserts that src-0017's evaluator
matches "with a SUBSTRING rule in both directions", is **retained and explicitly superseded** rather
than deleted — open_questions are not validator-protected, but the append-only spirit and G3 both
say correct by addition.

The executing code is one-directional, verbatim:
`true_positives = sum(any(pred.lower() in gt.lower() for gt in gt_set) for pred in pred_list)`.
The two-directional and exact-match variants sit inside triple-quoted string literals and never run.
The IoC sub-README states the same rule in prose: *"A prediction is considered a True Positive (TP)
if `pred.lower() in gt.lower()` for any ground truth IOC from the same source."*

The consequence recorded is the **asymmetry**: lenient toward short/fragmentary predictions, strict
against verbose ones. I added one thing `ctr-0004` did not state — **a verbose-but-correct
prediction is penalised twice**, as a false positive *and* as a false negative, because the
ground-truth entry it contains is simultaneously left unmatched by the `false_negatives` line. I
also recorded a **partial mitigation** in the other direction, which no cycle had noted: the shared
normalisation chain strips defanging (`hxxp`→`http`, bracket removal) and truncates at the first
`" - "`, so the commonest verbose-prediction artefacts in CTI text are normalised away *before*
matching. **Net sign of the bias: unknown, and it is the difference of two unmeasured quantities.**

### Job B — `ctr-0004` step (ii): does the asymmetry change cycle 18's arithmetic? DONE, AND IT FOUND A SEPARATE DEFECT.

**I did not derive the answer the question expected, because the question's premise was wrong.**

**(1) The 0.09–0.15 figure is not what the state says it is.** Every citation of it in this base —
the fourth candidate_resolution, `ctr-0001`'s cycle-21 update, `open_questions[0]`, and the
`scores.json` rationale — describes it as the IoC recall required to *reconcile src-0003's 97.6% F1
with src-0007's 0.82–0.88 precision*. I read `logs/cycle-018.md`, which produced it. It prints as a
four-row table headed **"Solving `2PR/(P+R)` for the unreported IoC recall at which each model's IoC
F1 falls to its own derived TTP F1"**:

| model | IoC precision | derived TTP F1 | crossover recall | actual TTP recall |
|---|---|---|---|---|
| GPT-4o | 0.8240 | 0.2502 | 0.1475 | 0.2270 |
| o3-mini | 0.8503 | 0.2337 | 0.1354 | 0.1759 |
| GPT-4o (FT) | 0.8846 | 0.2082 | 0.1180 | 0.1846 |
| GPT-4o-mini (FT) | 0.6944 | 0.1572 | 0.0887 | 0.1414 |

It is a **within-src-0007 IoC-versus-TTP crossover. src-0003's 97.6% is not an input to it
anywhere.** Cycle 18's own carry-forward [7] restated it as a src-0003 reconciliation, and cycles 21
onward inherited the restatement without re-reading the table. **`ctr-0010` opened.** Cycle 18's
*argument* is untouched and remains good: every crossover sits below that model's own TTP recall by
a factor of 1.3–1.6.

**(2) The asymmetry does not change that arithmetic, and the insensitivity is derived, not asserted.**
The matcher enters only through `P`. Solving `2PR/(P+R) = F` for `R` gives `R = FP/(2P−F)`, whence
`dR/dP = −F²/(2P−F)²`. For GPT-4o (`F` = 0.2502, `P` = 0.8240) that is `−0.0626/1.9538 = −0.0320`. A
correction to `P` of a full 0.13 in either direction moves the crossover by about **0.004**. At the
extreme, `P` = 0.9531 moves it from 0.1475 to 0.1440. **The range is robust in both directions.**
(Second-order effect, neutral: the same rule deflates measured *recall* too, since a verbose-correct
prediction is FP and FN together — but the crossover, the authors' Section 4.3 characterisation and
`eval_ioc.py`'s printed output are all in the same matcher-measured units.)

**(3) The src-0003 reconciliation, performed properly for the first time, and it needs no recall
value at all.** `F1 = 2PR/(P+R)` is increasing in `R`, so `F1 ≤ 2P/(P+1)`. Setting
`2P/(P+1) ≥ 0.976` gives `1.024P ≥ 0.976`, i.e. **`P ≥ 0.9531`**. LANCE's published 97.6% F1
*entails* a precision of at least 0.9531. That is a **precision**, and src-0007's 0.8240–0.8846 are
**precisions**, so the two compare like with like and the F1-versus-precision mismatch that *defines*
`ctr-0001`'s METRIC confound does not arise. **The METRIC confound is eliminated deductively, and no
value of the missing recall can revive it.** Margin, as the job required: **0.069 against src-0007's
best model (fine-tuned GPT-4o, 0.8846) and 0.129 against vanilla GPT-4o (0.8240).**

**(4) What the asymmetry does instead — it creates a fourth confound rather than reviving the
second.** Call it **MATCHER**. To close the 0.069 gap it would have to be net-deflating src-0007's
precision by 6.9 points, i.e. ≥6.9% of the fine-tuned model's emitted IoCs would have to be
verbose-but-correct predictions scored FP. Not absurd — that *is* the characteristic free-form
failure mode. Three things stop me asserting it: the rule is simultaneously lenient toward fragments
so the net sign is unknown; the normalisation chain closes the commonest deflation channel; and
**src-0003 never states its own matching rule**, so LANCE's entailed 0.9531 may itself be leniently
scored and the correction could run either way on both sides.

**Verdict on the fourth candidate_resolution: it stays `supported` and its headline is NOT
over-claimed** — after (3) it is on strictly better ground than when it was written. What is
defective is its stated *leg (1)*. `ctr-0010` records that rather than the edit being made silently.
**`ctr-0001` stays open, now against three live confounds: SYSTEM (unmeasured), CORPUS (untouched),
MATCHER (new, and not settleable from any released artefact).**

### Job C — `ctr-0007` steps (i)–(iii): the false encryption boundary, and the decision cycle 29 declined. DONE.

The third candidate_resolution's sentence *"src-0008 finds an unscaffolded LLM recovers plaintext
indicators ~100% of the time but is defeated entirely by encryption it has no tooling for"* is
**false for one of src-0008's five models**. It is retained verbatim with an inline
**DO NOT CITE** correction, followed by the correct statement: four of five models hold 100% through
four syntactic phases and then fail near-completely under encryption, while **Cohere degrades
progressively under syntactic obfuscation alone** — 1%/2%/5% misses at P1–P3, then 65% misses plus
35% Don't Know at P4, over phases Table 3 defines as Base64 encoding, identifier obfuscation, dead
code injection and structural obfuscation. **No cryptography.**

Steps (ii) and (iii) executed at **both** places in the graph that use the figures — the candidate
and `open_questions[4]`: the `~0-1%` / `~95%+` percentages are relabelled **FIGURE-DERIVED AND NOT
TEXT-VERIFIED** (P0–P12 lives only in Figure 2), and the **metric ambiguity** now travels inside both
texts (body *"the proportion of samples in which the model correctly identifies the presence of an
IoC"* against Table 6's caption *"ratio of YES an answers"*).

**THE DECISION, which cycle 29 explicitly declined to make.** Does large model-side variance under
purely syntactic noise *support* or *undercut* the scaffolding hypothesis? **I decide it cuts both
ways and the candidate stays `proposed` — but that is a decision with content, not a refusal, because
the two readings are about different propositions.**

- **The undercutting reading is the stronger on this evidence.** Five models, one corpus, one task,
  no scaffolding on any arm, a spread from 100% to roughly 35% at P4. If the model were not what set
  reliability, that spread could not exist. Model identity is a large variance component under
  unscaffolded conditions, which directly qualifies a hypothesis whose whole content is that
  reliability is set "mainly by the scaffolding around the model rather than by the LLM itself".
- **The supporting reading is real but is a counterfactual.** A regex extractor would indeed be
  indifferent to dead-code injection, so scaffolding would plausibly have erased Cohere's
  degradation. But **src-0008 runs no scaffolded arm**, so this is an inference about an experiment
  nobody performed and must not be entered as evidence.
- **The decisive point: src-0008 cannot adjudicate this hypothesis at all.** Its task is recovering a
  planted indicator from **JavaScript source code**; the candidate is about **narrative threat
  reports**. src-0008's role is **demoted to illustration only**, and it is retained in the evidence
  list to preserve the trail, not because it supports the claim.

**Net: the candidate is weaker than cycle 21 left it.** Cycle 21's ground for keeping it alive was
that eliminating the metric rival left scaffolding as the live explanation. This cycle puts a second
live explanation on the board — **model identity** — that no cycle had named. I recorded
"model choice sets the floor, scaffolding sets the ceiling" as the compatible third reading a future
cycle should test, rather than treating the two as rivals.

**`ctr-0007` is RESOLVED (`resolved_cycle` 35)**, all three steps executed, with an explicit note on
what the closure does *not* repair: src-0008's `key_claims[0]` still literally contains the
over-general sentence and **cannot be deleted** (validator lines 105–107), so its correction is
`key_claims[3]` and any future cycle citing [0] must read [3] alongside it. The source's own defects
— the twice-defined metric, the image-locked Figure 2 — are properties of the paper and are not
repairable from this base at all.

### Job D — the three stale `scores.json` rationales. ALREADY DONE, AND THE INSTRUCTION WAS WRONG TWICE.

**I did not perform this job because it did not need performing.** Two premises failed at source:

1. **`grep -c -i "two-directional" state/assessments/scores.json` returns 0.** The three named
   rationales (`ttp-attack-mapping-reliability`, `task-dependent-reliability-framing`,
   `extraction-vs-reasoning-ordinal-axis`) do not carry the false characterisation.
   `ttp`, `task-dependent` and `ioc` now each state the correct rule — *"ONE-DIRECTIONAL SUBSTRING
   CONTAINMENT, `any(pred.lower() in gt.lower() for gt in gt_set)`"* — and
   `extraction-vs-reasoning-ordinal-axis`'s rationale no longer mentions the matcher at all.
   **Cycle 33's T4 discharged this and nobody updated the entry that tracked it.**
2. **`ctr-0004`'s step (iii) asserts the rationales "cannot be edited retroactively under append-only
   discipline". That is false.** `scripts/validate_state.py` lines 100–107 enforce append-only on
   `index.json` `key_claims` and on the **existence** of `src-*.md` files **only**. `scores.json` and
   `graph.json` are not protected. A T4 was always free to rewrite a rationale.

Both corrections are recorded **in the graph**, in a cycle-35 addendum to `ctr-0004`, along with the
statement that **no T4 action remains on that path**. `ctr-0004` nevertheless **stays open**, because
its subject is the commensurability of src-0007's precision with src-0003's F1, and that is now the
live MATCHER confound on `ctr-0001`.

**Standing lesson, and it generalises past this instance: a tracking entry saying work is outstanding
is evidence that someone once thought so, not evidence that it is outstanding now.** [27] has been
carried for fifteen cycles on the same assumption and has never been re-checked either.

### Job E — the HuggingFace mirror. FETCHED FOR THE FIRST TIME. IT CLOSES A ROUTE RATHER THAN OPENING ONE.

`huggingface.co/datasets/xse/CyberThreat-Eval` was named as `ctr-0001`'s cheapest remaining step at
cycle 21 and in [7], and **no cycle had ever fetched it**. Three URL forms this cycle.

**The per-model IoC predictions are not there.** Applying rule (x)/[49] up front, I used the
**HuggingFace tree API** (`/api/datasets/.../tree/main?recursive=true`), which returns a complete
52-file listing **with byte sizes** — an authoritative absence, not a truncated render. The only
prediction artefact under the IoC task is
`stage3_ti_drafting/ioc/example/prediction/manual_ioc_predictions.json` at **1,298 bytes**, the
manual worked example already known from GitHub, far too small to be four models' output over 1,310
IoCs. The only other model-named file in the repository is
`stage3_ti_drafting/score_evaluation/example/test_output/gpt-4o.json` at 8,571 bytes, which belongs
to the threat-actor/root-cause scoring task and is likewise an example.

**The mirror is the same repository, not a superset:** `stage3_ti_drafting/ttp/data/TTP_Mapping.csv`
is **1,083,078 bytes**, byte-for-byte the size cycle 31 recorded from GitHub via the contents API.

**Consequence: src-0007's unreported IoC recall is not obtainable from any released artefact.** The
only remaining route is re-running the four models, which is outside this loop's means. `ctr-0001`'s
METRIC confound stays *eliminated by argument* and can no longer be *settled by number*.

**Second question, answered in the negative:** whether the ground truth is stated to be **exhaustive
per article**. **ABSENT**, confirmed at two URL forms (the rendered dataset card and the raw README
at `/resolve/main/README.md`), consistent with the IoC sub-README read whole at cycle 27. So even if
a recall number existed it would be recall against a ground truth of unstated completeness, which is
not comparable with PRISM's regardless. **This residue of `open_questions[3]` is now confirmed open
at source rather than merely suspected — a permanent limit, not a fetch away from closing.**

Recorded as `open_questions[7]`. No new source was added: the artefact contains nothing citable that
is not already covered by src-0017, so it would have been a hollow entry of the kind [31](e) warns
about.

### Bolt-on — src-0007 version and provenance check ([39], [53]). DONE, AND IT FOUND SOMETHING.

One fetch of `arxiv.org/abs/2603.09452`. **v1 only**, submitted 10 Mar 2026 — no revision has
renumbered the tables this base cites, which was the [53] hazard. **But the same page carries
`Comments: Accepted at TMLR` and `Journal reference: Transactions on Machine Learning Research
(2025), ISSN 2835-8856`.** This base has never recorded that, and src-0007's index entry still calls
it neither reviewed nor unreviewed. **I did not append it** — my source-touching budget went to the
graph repairs, and appending a provenance key_claim is a clean, cheap, self-contained job better done
by a cycle that is re-verifying src-0007 anyway. Flagged to cycle 36 and carried as **[58]**.
This is the **third** provenance label in this base found wrong or unrecorded after src-0001
(preprint → ARES 2025) and src-0005 (assumed reviewed → unreviewed).

The other conditional bolt-on ([21], `src-0006.md`'s uncorrected ZYS sentence) was **not** done: the
instruction was to fix it only if visiting src-0006 anyway, and I did not. Passed on undone.

---

## Retrospection (G2)

**Source checked: src-0013** — *An Empirical Study of Security Calibration in Large Language Models
for Code*, `arxiv.org/abs/2606.31159`. Chosen by staleness per [8] (last checked cycle 18, the
stalest in the base) and because **its provenance label "ICSME 2026 Research Track" had never been
checked** ([39]). Two fetches: `/abs` for provenance and version, `/html/2606.31159v1` for the
numbers and the metric definitions.

**RESULT: PASSES CLEANLY, ON EVERY AXIS INCLUDING THE TWO THAT HAD NEVER BEEN TESTED.**

**Provenance — CONFIRMED, first check in 20 cycles.** Verbatim: *"Comments: Accepted at the 42nd
International Conference on Software Maintenance and Evolution (ICSME 2026) Research Track."* The
stored label is exact. Authors exact: Mohammed Latif Siddiq, Md. Nafiu Rahman, Joanna C. S. Santos.

**Version — CLEAN.** `[v1] Tue, 30 Jun 2026`, sole version. No [53] renumbering hazard.

**Numbers — every stored figure exact, in the paper's own sentences.**
- *"GPT-4o-mini and Qwen3-Coder-Next exhibit severe miscalibration (ECE∈[0.456,0.481] and
  [0.408,0.421], respectively), while Gemini-2.0-Flash shows comparatively better calibration
  (ECE∈[0.247,0.263])"* — matches `key_claims[0]` exactly.
- *"Gemini-2.0-Flash is clearly separated from both GPT-4o-mini and Qwen3-Coder-Next on False Trust
  (17.5% vs. 33.9% and 38.3%)"* — matches `key_claims[2]`.
- *"For GPT-4o-mini, average ECE rises from 0.411 on SALLM to 0.697 on repository tasks
  (ΔECE=+0.286), while False Trust increases from 16.9% to 83.2% (ΔFT=+66.3%). Gemini-2.0-Flash
  exhibits a similar pattern, with ECE increasing from 0.161 to 0.721"* — matches `key_claims[1]`,
  **including the Gemini 0.161 → 0.721 leg that [20] recorded as never re-checked. That residue is
  now discharged.**
- *"Repository-level generation has higher calibration error across all models."* — exact.
- `SALLM` **PRESENT** (*"We retrieve the prompts and unit tests from the SALLM benchmark for our
  work"*), against an ABSENT on the `/abs` page. **A textbook [38] false negative: the abstract does
  not name the benchmark. Recorded because the rule keeps earning its keep.**

**Metric definitions pulled verbatim per rule (iii) — the check that has produced six contradictions
in this base. This time it produced none.**
`ECE = Σᵢ₌₁ᴮ (|Bᵢ|/N)·|acc(Bᵢ) − conf(Bᵢ)|`; `FT(τ) = |{i : pᵢ ≥ τ ∧ yᵢ = 0}| / N`, with
*"We use τ=0.8 as the default threshold."* Both match what the base stores. **No second incompatible
definition of either metric exists** — the question rule (ix) requires asking, and here the answer is
clean. Six temperature settings confirmed as `{0.00, 0.20, 0.40, 0.60, 0.80, 1.00}`, matching the
stored "six temperature settings 0.0–1.0". Table III's caption confirms the sign convention behind
`key_claims[2]`'s negative ΔECE: *"Δm=mˢ−mᶠ (negative means security predictions are better
calibrated)."*

**The one thing that did NOT close, and it did not need to.** `key_claims[3]`'s scope limit says the
33.9% and the 16.9%→83.2% figures "use different aggregations that the fetched text does not
reconcile". **Still true.** Table I is *"Calibration metrics for all three models (SALLM, n=2,000 per
temperature)"*; Table IV is *"Calibration degradation from self-contained (SALLM) to repository-level
(AICGSecEval) context. Metrics are verbatim averages across six temperature settings."* Both are
SALLM-side GPT-4o-mini FT numbers and they differ (33.9 vs 16.9). Table III is explicitly *"using
verbalized confidence"* and Table I is not so labelled, which **suggests** a different
confidence-elicitation source — **but the paper does not say so and I am not entering an inference as
a finding.** The stored prohibition stands exactly as written: **quote the two only with their scopes
named, never as two values of one measurement.** [20]'s residue is therefore *half* discharged (the
Gemini leg closes; the FT discrepancy does not).

**No contradiction opened from G2 this cycle.** This is the **sixth consecutive clean check** — but
[31]'s caveat holds and I restate it rather than claiming a trend: cycles 31–35 all checked sources
that had already survived one pass, so the streak partly reflects *where G2 has been pointed*. What
this cycle does add is genuinely new: **src-0013 is the first of the four second-pass backlog
sources to be cleared, and the first provenance label ever checked among them.**

**The contradiction this cycle did open came from somewhere G2 cannot reach** — see `ctr-0010` and
the methodological note below.

---

## Changes made

**`state/issues/graph.json`** — eight `Edit` operations against unique single-line anchors, each
validated with `jq -e` and read back with `jq -r`. File grew from ~170 KB to ~180 KB.

1. `open_questions[6]` **appended** — the corrected one-directional matcher statement (Job A).
2. `open_questions[7]` **appended** — the HuggingFace result and the exhaustiveness ABSENT (Job E).
3. `open_questions[4]` — cycle-35 relabel appended: `~100%`/`~0-1%` marked figure-derived, metric
   ambiguity carried, Cohere exception noted (Job C step ii/iii).
4. `candidate_resolutions[2]` — false encryption-boundary sentence corrected in place with a
   retained-but-DO-NOT-CITE marker (Job C step i).
5. `candidate_resolutions[2]` — cycle-35 decision appended; stays `proposed` (Job C).
6. `candidate_resolutions[3]` — cycle-35 addendum with the full Job B derivation; stays `supported`.
7. `ctr-0004` — cycle-35 addendum: all three steps executed, both of step (iii)'s errors recorded.
8. `ctr-0007` — resolution note appended and **`resolved_cycle` set to 35**.
9. **`ctr-0010` opened** against `ioc-extraction-reliability` (`opened_cycle` 35).
10. `attempts` → `[9, 21, 35]`.

**Contradiction count on this issue is unchanged at three** (`ctr-0001`, `ctr-0004`, `ctr-0010`);
`ctr-0007` closed and `ctr-0010` opened in the same cycle. **G3 ceiling unchanged at 3; merit score
2 sits under it, so nothing binds and no validator risk was created.** All four candidate evidence
lists reference only `src-0003`, `src-0007`, `src-0008`, `src-0017`, all present in `index.json`
(validator lines 130–134).

**Not changed:** `state/knowledge/` — no source was added and no `key_claim` was appended or removed.
Job E's artefact contained nothing citable beyond src-0017. `state/assessments/scores.json` — a T3
has no standing to rescore; `ctr-0010` step (i) hands the one needed rationale edit to cycle 36.

**`state/queue/next_task.json`** — T4 assess, target `ioc-extraction-reliability`, attempt 0.
**`state/queue/last_completed_task.txt`** — `T3 investigate`.

Both queue files were written **before** this log, per [50](2), adopted voluntarily by cycle 34 and
kept here.

---

## Next task rationale

**T4 (assess) on `ioc-extraction-reliability`**, per the state machine `T3 → T4` re-derived from
`config.yml`. Same target: a T4 assesses the issue the T3 just worked.

The T4 gets **one named action item that is a T4's job and nobody else's**: `ctr-0010` step (i), the
restatement of the mis-scoped 0.09–0.15 sentence in the `scores.json` rationale — together with the
explicit correction that `scores.json` is **not** append-only-protected, since that false belief is
exactly what left the last such job undone for six cycles until cycle 33 quietly did it anyway.

I told the T4 what moved and in which direction without pre-judging the score: **the issue is better
understood and not obviously better supported.** Gained: the METRIC confound is now eliminated
deductively rather than by plausibility. Lost: candidate 3 is weaker (model identity is a rival
nobody had named), a fourth MATCHER confound is live on `ctr-0001`, and `open_questions[7]` closed
the cheapest route to src-0007's recall. The level-3 bar — primary candidate on ≥2 **independent**
sources — is untouched by any of it: candidate 1 rests on src-0003 alone, candidate 2 on src-0007
alone, and candidate 4 cites src-0017, the same team's artefact release for src-0007.

I also warned it, at length and with the receipts, that **its own handoff got two premises wrong**,
and gave it the general rule rather than just the instance.

---

## Budget

| resource | used |
|---|---|
| web fetches | **7** — src-0013 `/abs`, src-0013 `/html`, HF datasets API, HF rendered dataset page, HF tree API (recursive), HF raw README (`/resolve`), src-0007 `/abs` |
| web searches | 0 — no search was needed; every question was answerable from the knowledge base or a known URL |
| new sources added | 0 (budget `max_new_sources: 5` untouched) |
| `jq` / `grep` / `Grep` calls | ~14 |
| file edits | 10 `Edit` on `graph.json`, 2 `Write` (queue), 1 `Write` (this log) |
| turns | ~47 of `max_turns: 50` — **tight, and the reason both queue files were written first** |

**Efficiency note for successors:** the HF **tree API with `recursive=true`** answered in one fetch
what the rendered dataset page could not answer in two, and it supplies byte sizes, satisfying [49]
up front rather than after a near-miss. **Use it first for any HuggingFace repo.** Conversely, a
fetch prompt demanding a file "verbatim and in full" was **refused outright** by the fetcher on quote
limits; re-asking the same URL with **targeted verbatim questions** succeeded immediately. That is a
cheap recovery worth knowing.

**Sandbox findings, new this cycle:** shell **variables and `for` loops are refused**
(`Contains simple_expansion`); write repeated commands out in full. A bare Bash `grep -o -E` with a
context-width pattern was **refused**, but the **`Grep` tool** with `-o` and `output_mode: content`
does the same job and supports `-i`.

---

## Carry-forward items

All items from `logs/cycle-034.md` reproduced **including those I cannot act on**. Discharged items
stay marked rather than deleted. **New: [57], [58], [59]. Discharged this cycle: [7] (partly), [42]
(fully), [46] (fully). Updated: [8], [9], [20], [24], [27], [29], [31], [36], [38], [39], [49], [50],
[51].**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Cited as the precedent behind [37] and
[45]. Both halves of that split are now at 2 and fell for the same root defect — weak evidence that
the split was along the right seam.

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK metric
at all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in its
**twenty-fourth** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**. [44]
puts the 0.6388 itself in question. Now that the scorer's rule is known to be exact-ID matching with
no partial credit, a useful human baseline would have to be scored under the **same** rule — and
exact sub-technique assignment is a task on which two competent analysts would themselves disagree.

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30] and [55]. It has now lost
**six** consecutive selections and [55] upgrades the prediction to a proof: **structurally
unreachable, not merely unlucky.** *Cycle 35 note: cycle 34's selection of `ioc` was correct on
merit and this cycle bears that out — `ioc` had two named undone T3 jobs and both are now discharged.
That does not weaken [55]; it strengthens the case that the starved issue is starved by the rule
rather than by lack of merit elsewhere.*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 26 CYCLES. VERBATIM FOR A HUMAN.**
The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml`
line 35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The
enforced reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in
`logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside this
agent's output surface. **Until a human applies it, T4s must apply the ceiling.** Under subtraction
five of eight issues would read 0. The per-issue-versus-per-contradiction question stays live on
`ioc` (three open) and `consistency` (two): under subtraction, is `ioc` −2 or −6? Awaiting a human,
verbatim, with [11], [30], [41], [55].

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
`open_question[3]`, and the **only** route left to move `ttp` off 2. *Cycles 31–35 spent nothing here.*

**[7] — WORKED AT 21; PATH REDRAWN AT 22; STEPS AT 27, 31; SCHEDULED AT 34; **THE LAST CHEAP STEP
EXECUTED AND EXHAUSTED AT CYCLE 35**.** `ctr-0001`'s resolution path. **Done:** released-code route
exhausted; METRIC confound eliminated (and now *deductively*, see [57]); TTP scorer read; **the
HuggingFace mirror fetched at last and it does NOT contain the per-model IoC predictions** — a
complete 52-file tree listing with byte sizes confirms the only IoC prediction artefact is the
1,298-byte manual example, and `TTP_Mapping.csv` at 1,083,078 bytes proves the mirror is the same
repository as GitHub, not a superset. **src-0007's recall is now known to be unobtainable from any
released artefact.** Also settled negatively: the ground truth is **nowhere stated to be exhaustive
per article** (two URL forms), so even a recall number would not be comparable with PRISM's.
**Still open:** no head-to-head; **the CORPUS confound is completely untouched and is now
unambiguously the largest gap**; and a **new MATCHER confound** ([57]). **Every cheap step on this
path is now spent. What remains is a corpus study or a new source.**

**[8] — UPDATED cycle 35. G2 COVERAGE COMPLETE; TRACKED BY STALENESS, ALSO BY REPLICATION.**
src-0004 (c4, c12), src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 —
`ctr-0002`; c28 — `ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial fail
[21]; re-pulled c18), src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), src-0012 (c13; c31
— CLEAN), src-0011 (c14; c33 — CLEAN, version hazard found), src-0007 (c15; c21; c30 — `ctr-0008`;
**c35 `/abs` bolt-on — v1 only, and TMLR provenance found, see [58]**), src-0009/src-0010 (c16; c34 —
BOTH CLEAN), **src-0013 (c18; c35 — PASSES CLEANLY, every number verbatim, provenance label
CONFIRMED, `/html` v1 only, and [20]'s Gemini residue discharged)**, src-0014 (c19), src-0015 (c20),
src-0016 (c21 — provenance partial fail, [31]), src-0017 (c27 — `ctr-0004`; c32 — CLEAN), src-0018
(c28 — `ctr-0005`). *Next G2 by staleness: **src-0014** (c19), then src-0015 (c20), src-0016 (c21),
src-0006 (c18 — and see [21]). **src-0014/15/16 are the entire remaining backlog of
never-re-checked-twice sources, and their provenance labels have never been checked at all.*** But
see [51]: staleness is the default, not the rule.

**[9] — CORRECTED cycle 18, re-confirmed 19–23, 25–35.** `python3` present but the **permission
layer** blocks it, so **`scripts/validate_state.py` cannot be run by this agent**; compound commands
rejected if any segment is unapproved. **No PDF text extraction exists** — prefer `/html`. `gh` not
approved. `awk` refused. **`sed -n` and `cat >>` heredoc ARE approved**; a heredoc append must be its
**own** call. `jq -e . <file> > /dev/null` approved, as is a compound `jq … && jq …` chain.
**`jq --slurpfile` is REFUSED**, so cross-file `jq` is impossible. **Bash `grep -n`/`grep -c` ARE
approved on the small files**; the `Grep` **tool** is necessary on the big JSON files. Prefer
**single-line `Edit` anchors**. `scores.json` and `graph.json` are NOT protected by validator lines
105–107. **`raw.githubusercontent.com` returns whole files.** *Cycle 35 additions: **shell variables
and `for` loops are REFUSED** (`Contains simple_expansion`) — write repeated commands out in full;
**a bare Bash `grep -o -E` with a context-width pattern is REFUSED**, but the `Grep` **tool** with
`-o` + `output_mode: content` does it and supports `-i`. Single-quoting every internal quotation kept
an 18,752-character `instructions` string escape-free — **seven cycles of evidence**.*

**[10] — DISCHARGED CYCLE 26; NEVER ACHIEVABLE.** src-0005's per-model numbers do not exist in text —
every per-model score is inside Figures 8, 9, 12–16. **Do not re-attempt without a new route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27, 30, 34. VERBATIM FOR A HUMAN.** Tie-break 3a in
`prompts/t5_select.md` is under-specified and there is **no deterministic tie-break after 3c**. In
four parts: **(a)** a terminal tie **must** be written into the prompt; **(b)** the prompt lists **3a
before 3b**, but 3b is an addition *to the score*, so a literal a-then-b ordering lets them return
**opposite verdicts on the same pair**; **(c)** "within the last 5 cycles" has three defensible
readings — cycle 34 resolved (c) as harmless in practice but found the two readings of **3a** differ
on whether an issue with *no edges at all* survives it, which is the ambiguity burying
`automated-triage-under-refusal`; **(d)** the prompt has **no aging term** — see [55]. Cycle 34 hit a
terminal tie for the third time (`ioc` vs `consistency`, tied on score, 3a, 3b **and** 3c) and broke
it by documented judgement. Passed on verbatim with [4], [30], [41], [55].

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The claim
that the loop "never returns to T2" is false; cycle 16 disproved it. *The next T2 is **cycle 51**.
[37] and [45] are both T2 jobs and both wait another sixteen cycles.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is the
upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF route is
also closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own writeup is
the only remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2 PDFs
cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level and
UNVERIFIABLE at document level here. **Do not re-spend budget.** Cycle 34 re-confirmed the
landing-page half cleanly at both pages without touching the PDFs.

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, DEFERRED AN ELEVENTH TIME.**
The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop"
reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to
under 5%) is an `open_question` on `automated-triage-under-refusal`. **It is a question, not evidence
— no curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–35 all judge it the highest-value uncollected source. *The earliest T1 route is
**cycle 50**; a T3 targeting that issue could reach it sooner ([29]) — but per **[55]** no T3 will
ever target that issue under the current tie-break, so **this is blocked on a prompt change, not on
budget**.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated pipeline to
search for vibe citations by finding and scanning public reports from major consulting firms". A T1
should chase `gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor; no *rate*
published; the scorecard widget renders as "0 of N" to automated fetch. **Still the only route any
cycle has found to a base rate**, the binding constraint on `institutional-incident-real-world-impact`
reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the escape
to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural finding for
the paper: the only task type that can restructure the issue graph fires when a T5 coincides with a
multiple of 7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18] — DISCHARGED CYCLE 33 AS *CONFIRMED*.** src-0011 contradicts itself in prose vs table: body
text *"NeurIPS exhibiting the highest absolute count (**391 papers**)"* against a table row giving
**Invalid = 391, Papers = 308**. Reproduced verbatim from **both v1 and v2**, so it is durable. No
claim in our base repeats the error; **no G3 entry was opened**. **Quote src-0011's *counts* from the
table's columns, never from that sentence.** *Self-contradicting sources in this base: src-0011
(prose vs table, and a 738-vs-739 slip, [53]), src-0002 (Micro-F1 vs Macro-F1, [44]), src-0008 twice
(phase labels [5]; metric definitions [46]), src-0007 (rubric dimension defined twice, [47]),
src-0017 (docstring/README vs live code). **Five sources, eight instances.***

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4 pulled
**whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall (Accepted)
**0.9091–1.0000**. **THE ANOMALY IS UNRESOLVED AND REPRODUCED THREE TIMES:** GPT-4o (FT) tracks
o3-mini to within 0.001 on **all six** `Content: Threat Actor` rubric rows, identically at c15, c21
and c30, on two URL forms. **As-printed, cause unknown, DO NOT GUESS.**

**[20] — DISCHARGED cycle 21; **HALF OF THE RESIDUE DISCHARGED AT CYCLE 35**.** All four cycle-15
sources verified: src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21). *Cycle 35's G2 on
src-0013: **the Gemini 0.161 → 0.721 leg, recorded since cycle 18 as "not re-checked", is now
verified verbatim** in the same sentence as the GPT-4o-mini figures. **The FT discrepancy does NOT
close and the prohibition stands unchanged** — Table I is "SALLM, n=2,000 per temperature" and Table
IV is "verbatim averages across six temperature settings", both SALLM-side GPT-4o-mini, and 33.9% is
not recoverable from 16.9%→83.2% by any aggregation the paper states. **Quote them only with their
scopes named, never as two values of one measurement.** Table III is explicitly "using verbalized
confidence" and Table I is not so labelled, which hints at a different elicitation source — **the
paper does not say so and this is NOT entered as a finding.*** **Residue still live: src-0014's F1
figures (0.398/0.103/0.465/0.427) are body-sentence-only, and src-0014/15/16 provenance is unchecked.**

**[21] — CONFIRMED AND PARTIALLY REPAIRED cycle 18; STILL THE ONLY KNOWN UNCORRECTED SOURCE FILE.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688 for
a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5 at
0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a
true span of **0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md`
is still untouched and still carries the wrong sentence.** *`ctr-0009` step (iii) sends a T3 to
src-0006 anyway. **Cycle 35 was offered this as a conditional bolt-on and correctly did not detour** —
it did not visit src-0006. Still undone.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are
**strictly monotone decreasing across all eight general-purpose columns in exactly the printed column
order**; four are in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends on. One row
matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.**
**Any finding resting on that table must carry a robustness check excluding those rows** (cycle 18's:
drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2.** Mean between-**model** range within a task (0.272) and mean
between-**task** range within a model (0.263) are equal to within 0.009. This does **NOT** negate
`task-dependent-reliability-framing`'s supported claim — it qualifies the implication that sub-task is
the *privileged* explanatory variable. A T2 should annotate rather than re-scope. No contradiction:
both facts hold.

**[24] — NEW cycle 18, USED THROUGHOUT 19–23 AND 25–35. `jq` IS INSTALLED AND APPROVED.** Every cycle
from 9 to 17 recorded that this agent cannot validate JSON and must check "by construction". **That
advice is wrong and expensive** — cycle 17 lost its entire `state/` output. **Every JSON edit should be
followed by `jq -e`** *and* a `jq -r` read-back of the fields added. The permission layer is **not
uniform** — probe once. The `Grep` **tool** works on the big JSON files where Bash `grep -n` does not.
Cheapest append-only pattern: **`grep`/`Grep` → `Read` with `offset`/`limit` → `Edit` → `jq -e` →
`jq -r` read-back.** *Cycle 35 ran ten `Edit`s on `graph.json` through this pattern with zero
failures, and confirms one economy: **a single small `Read` (one line, `offset`/`limit`) unlocks the
whole file for editing**, so a 180 KB file never needs to be read in full.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the `Content:
Threat Actor` rubric block in full, and the caveats keep travelling: the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, **re-confirmed ABSENT at
c30**), so **only within-table contrasts may be cited**; the GPT-4o (FT) column is suspect per [19];
and **`Attribution` means SOURCE LINKING in the Threat Actor block and ACTOR IDENTIFICATION in the
Root Cause block**, so cross-block contrasts are not automatically safe either. See [47]. *Standing
lesson: "the table is captured verbatim" and "the metric is understood" are different claims.*

**[26] — NEW cycle 18, PARTLY ACTED ON BY A HUMAN AT CYCLE 33.** **Why cycle 17 failed validation is
unknown and unrecoverable.** Suggested fix: tee `python scripts/validate_state.py` output into
`logs/cycle-NNN-validation.txt` before reverting, and `git stash` the rejected `state/` diff. *Commit
`956a36c` (a human) fixed the **agent-death** half. **The logging half is still undone**: a rejected
diff is still discarded without its validator output being preserved.* *Cycle 35 note: [9] confirms
the agent cannot run the validator itself, so a cycle has **no way to see why it failed** — which is
what makes the logging half matter.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER FIFTEEN CYCLES.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3
2.61, DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward.**
Bears on `automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward composition
unstated; n=40 per model, no CIs; association not strictly monotone. **A rationale is not the graph.**
*Cycle 35 was explicitly told not to enter it (not its target issue) and did not. **But cycle 35's
Job D finding applies here directly: this item has been carried for fifteen cycles without anyone
re-checking whether it is still undone. It should be verified against the graph before the next cycle
spends a turn on it.***

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–35.** The state machine is T1→T2, T2→T3, T3→T4,
T4→T5, T5→T3. **Positions: cycle 35 = T3 (this one), 36 = T4, 37 = T5**, T5 thereafter on 40, 43, 46,
**49**. The refresh fires only when a T5 **runs on** a multiple of 7; 49 is both, so **the next T1 is
cycle 50 and the next T2 is cycle 51.** *Cycle 35 re-derived this from `config.yml` independently and
it matches cycles 32–34.* **THE HEADLINE: cycle 24's crash pushed collection back eight cycles and
cycle 31's max-turns death another seven. Two partial failures have cost fifteen cycles of collection
and restructuring capacity** — no new source via T1 until cycle 50, no issue split until cycle 51.
**Re-derive rather than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25, 30–35.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018. **Standing
lesson: read the task's own prompt file, not only the queue entry's description of it.** *Cycle 35
read the prompt at source and found the handoff accurate **on the prompt** — eight clean handoffs in a
row — **but wrong on two of its own job premises** (see [59]). The check must extend past the prompt
to the premises. **Cycle 35 exercised the affordance's cheapest form and declined to add a source**:
the HuggingFace artefact contained nothing citable beyond src-0017, and a hollow entry is a known
defect class ([31](e)). Declining is a legitimate use of the affordance, not a failure to use it.*

**[30] — NEW cycle 20; PREDICTION CORRECT SIX TIMES; UPGRADED TO A PROOF AT CYCLE 34, SEE [55].
VERBATIM FOR A HUMAN.** `automated-triage-under-refusal`, the only issue never worked on
(`attempts: []`, created cycle 16), has **lost six consecutive selections**. **"Never attempted" is
not a tie-break in `prompts/t5_select.md`**, and cycle 19's rationale wrongly asserted it was. **This
is a prompt change for a human.** Note the interaction with [11]: under one reading of 3a it is
eliminated outright for having no dependents; under the literal pairwise reading it survives 3a and
dies at `created_cycle`, so **the newest issues in a graph are structurally disadvantaged forever,
with no expiry**. With seven issues tied at 2 ([54]), `created_cycle` is doing almost all the
selecting in this project.

**[31] — NEW cycle 21, EXTENDED 22–35. THE VERBATIM CHECK HAS NOW RUN ON **FIFTEEN** SOURCE-CHECKS;
NINE PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation **does not exist on
the page**. (b) **src-0003** (c22): quotations passed, stored *numbers* 76/72/86 are
**figure-image-only**. (c) **src-0002** (c23): all 25 numbers exact, **interpretation contradicted by
the paper's own metric definition**; `ctr-0002`. (d) **src-0001** (c25): numbers exact, **calibration
gloss contradicted by the full table**; `ctr-0003`. (e) **src-0005** (c26): all claims **PASS** — but
stored with no task format, metric definition, sample counts, limitations or numbers. (f) **src-0017**
(c27): every stored string **PASSES**, the **DOWNSTREAM PARAPHRASE** dropped the hedges; `ctr-0004`.
(g) **src-0018** (c28): every quotation **PASSES** — the stored **SCOPE** is wrong by being **TOO
RESTRICTIVE**; `ctr-0005`. (h) **src-0002 again** (c28): two more glosses, one **FALSE against the
printed table**; `ctr-0006`. (i) **src-0008** (c29): quotations and numbers **PASS**, one claim
**OVER-GENERAL**; `ctr-0007`. (j) **src-0007** (c30): all 34 rows PASS, **THE METRIC IS DEFINED TWICE
UNDER ONE NAME**; `ctr-0008`. (k) **src-0012** (c31): CLEAN. (l) **src-0017's TTP scorer** (c32):
CLEAN. (m) **src-0011** (c33): CLEAN. (n) **src-0009 + src-0010** (c34): CLEAN. **(o) src-0013 (c35):
CLEAN — every ECE/Brier/FT figure verbatim, both metric formulas pulled and singly-defined, the
never-checked ICSME 2026 provenance label CONFIRMED, v1 only, and [20]'s Gemini residue discharged.**
**The defect class is nine-way** — spliced quotations, unverifiable numbers, unsupported interpretive
glosses, partial table capture, correct-but-hollow entries, correct-source-corrupted-downstream,
over-restriction, over-generalisation, metric-identity. *Standing lesson: **verifying a value does not
verify what the value measures.*** **SIX consecutive clean checks. Cycle 34's caveat still holds and
cycle 35 restates rather than drops it: cycles 31–35 all checked sources that had already survived one
pass, so the streak partly reflects WHERE G2 has been pointed. What cycle 35 genuinely adds is that
src-0013 is the FIRST of the four second-pass backlog sources cleared, and the FIRST provenance label
checked among them. src-0014/15/16 remain untested on both axes.**

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1
values are figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction when
the source's own legible text conflicts with the stored claim; do not file when the stored claim is
merely unverifiable.** *Cycle 34's use correctly said DO NOT FILE ([56]). **Cycle 35 found the test's
edge: `ctr-0010` is neither of those cases — the conflict is between the state and a PRIOR CYCLE'S OWN
DERIVATION, with no source involved on either side.** The test as written does not cover derived
quantities; see [57]. **Five uses, correct every time, but its scope needs widening when a human writes
it into `prompts/system.md`.***

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted candidate
set**, not free-form extraction — *"We assume a total of 1,789 candidate indicators, extracted using
IoC Searcher"*; Figure 9's caption "… on IoC Classification." **A difference in task format, stated by
the paper.** **Companion finding: src-0003 NEVER STATES ITS MATCHING RULE** (`src-0003.md` line 141).
*Cycle 35 confirms this is now load-bearing in a new way: the MATCHER confound ([57]) cannot be signed
on src-0003's side either, precisely because of this gap. **Do not re-buy it** — it is probably
unresolvable from this base.*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3. HALF DISCHARGED AT
CYCLE 31; PRICING DISCHARGED AT CYCLE 33.** **A within-study design holds team, corpus, models and
harness constant but does NOT hold the scoring rule constant.** Cycle 31's fetch gave the **worst case
for the objection's target**: src-0007's IoC and ATT&CK sub-tasks are scored by **different kinds of
rule**, so the within-study comparison is **refuted, not rescued**. *The sharpest form: **the sign of
the confound is known and it points the same way as the finding — the leniently scored sub-task is the
one that scores high.*** Known non-commensurable instances: src-0017/`ctr-0004`, src-0003, src-0005,
src-0002/`ctr-0006`, src-0007's rubric against itself ([47]), src-0007's IoC rule against its own
ATT&CK rule, src-0008's body against its Table 6 caption ([46]). **Seven.** **STILL OPEN AND THE
PROJECT'S LARGEST UNTESTED LOAD-BEARING ASSUMPTION: src-0006's per-task metric definitions have never
been pulled** — `ctr-0009` step (iii). *That fetch belongs to `task-dependent-reliability-framing` and
is blocked by the tie-break, not by budget (the other such block is [15]).* *Cycle 35 nuance: **the IoC
rule is lenient on one axis and STRICT on another**, so "the leniently scored sub-task scores high" is
right about the ATT&CK contrast but must not be read as a clean one-way sign on the IoC side alone.*

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible` columns are
**nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements (incorrect = 100 −
Plausible = **14 / 38 / 26 / 20 / 64%**) are in the graph **with their derivation stated**; `ctr-0002`
CLOSED.

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all executed.
**The consequences did not stay inside the issue: see `ctr-0006` and [44].** *The G2 staleness
heuristic and the scoring rationales work as a pipeline. **Closing a contradiction should itself
schedule a replication** (cycle 32). **A finding's effect on the scores can lag its discovery by
several cycles, and nothing in the loop tracks that debt except carry-forward.*** *Cycle 35 closes the
extreme case cycle 34 flagged: `ctr-0004`'s T3 half waited **eight** cycles and `ctr-0007`'s **six**,
both for want of a selection — **and both were discharged in a single cycle once the selection
finally came.** The lag is bounded by the selector, not by attention, and the backlog clears fast when
it is reached. That is an argument for [55]'s aging term, not against it.*

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28–30, 33, 34. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent sources**
(src-0001 + src-0018, **both at temperature 0**), calibration-on-CTI on **one** (src-0001, gpt4o
only), and `ctr-0003` sits on the calibration half alone. Natural cut:
`consistency-under-repeated-query` vs `confidence-calibration-on-CTI`. **Only a T2 can split an
issue** ([12]); **next T2 is cycle 51.** *One of **three** issues in that position. This issue was the
runner-up in cycle 34's terminal tie and is the likeliest cycle-37 target.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AT 30, 31, 33 AND **35**. A SINGLE FETCH'S
"ABSENT" IS NOT EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT
verdict must be confirmed against a second URL form.** Before recording an absence check **(1)** the
abstract, **(2)** a different URL rendering, **(3)** that you fetched the file the claim actually
cites, **(4)** that the **VERSION** you fetched contains the material at all. **The rule also applies
to a PARAPHRASED verdict: a summarised PRESENT is as untrustworthy as a bare ABSENT.** *Cycle 31 found
the rule's limit — both URL forms of `TTP_Mapping.csv` failed the same way ([49]). Cycle 32 added that
a verdict about which of two competing texts EXECUTES is not a PRESENT verdict at all. Cycle 33 added:
when two fetched numbers conflict by one digit, ask whether EACH SIDE IS INTERNALLY CONSISTENT before
suspecting the fetch.* **Cycle 35 paid off twice: `SALLM` was ABSENT on src-0013's `/abs` and PRESENT
in its `/html` (the abstract simply does not name the benchmark), and Job E's two absence verdicts —
no per-model predictions, no exhaustiveness statement — were each confirmed at a second URL form
before being recorded.**

**[39] — NEW cycle 25, EXTENDED 26–29; THE VERSION AXIS PAID OFF AT 33; **THE PROVENANCE AXIS PAID OFF
AGAIN AT 35**.** Provenance labels in this base were set at collection time and are mostly still
unchecked. src-0001 **is peer-reviewed** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` —
and this base called it a preprint for 24 cycles. src-0005 goes the other way: **an unreviewed
preprint**. src-0017's `[TMLR '25]` badge against a March 2026 arXiv submission is **unresolved**.
*Cycle 35: **src-0013's "ICSME 2026 Research Track" CONFIRMED exactly** — the first of the three
unchecked labels to be cleared. **Still unchecked: src-0014 ("v1 preprint, no stated venue"),
src-0015 ("single-author preprint").** **And src-0007 turns out to be published — see [58].** Version
checks run: src-0008 (c29), src-0011 (c33), src-0009/src-0010 (c34), **src-0013 and src-0007 (c35,
both v1 only)**. **Run the `/abs` check on every arXiv source you touch: it costs one fetch and has now
produced a finding on three of six sources checked.***

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND THIS
BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of questions for which
the system selects all correct options and only the correct options." Questions **generated by Llama
3.2 90B and Llama 4 Maverick**; the paper concedes "performance bias … where the model under test is
the same, or has similarities with the set of models that were used in synthetic data generation
pipelines". **(a)** Its percentages are not commensurable with src-0002's F1 or src-0007's
precision/recall. **(b)** It reports **no ATT&CK metric at all**. **(c)** 23–34% (MA) against 43–53%
(TIR) is **NOT a controlled contrast**. **Anyone using it must state those three confounds.**

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30, 32, 33, 34. THE G3
CEILING BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS. VERBATIM FOR A HUMAN.** An
honest, stingy T4 demotes issues carrying open contradictions, which moves them *away* from the
ceiling. **So the validator's G3 check is very nearly dead code, while the prompt's subtraction rule —
which every T4 has correctly refused to apply — would fire on five of eight issues today and drive
them toward 0 without tripping anything.** Shapes documented: **(1) undermining** (`ctr-0001`);
**(2) strengthening** (`ctr-0005`); **(3) two-directional** (`ctr-0007`); **(4) support-relocating**
(`ctr-0008`); **(5) closes without the underlying source defect being repaired** (`ctr-0006`);
**(6) damages issues OTHER than the one it is filed against** ([52]). **Six shapes, one binary gate.**
*The dead-code observation holds for a seventh cycle: today the ceiling binds on **zero** of the four
contradicted issues.* **Cycle 34's generalisation, restated: this is the THIRD instance of a mechanism
that degrades as the rest of the loop improves — the G3 ceiling ([41]), the weakest-link selector under
compressive scoring ([54]), and the starvation proof ([55]). Whoever designs the successor system
should treat "does this mechanism get worse when the agent gets better?" as a standing design
question, not three separate bugs.** *Cycle 35 adds a **seventh shape**: `ctr-0007` is the first entry
in this project to be **CLOSED by the cycle that was sent to act on it**, and closing it while opening
`ctr-0010` left the issue's count unchanged at three — so the gate saw **no change at all** from a
cycle that materially repaired the issue. **A binary per-issue gate cannot represent repair.*** Passed
on verbatim with [4], [11], [30], [55].

**[42] — NEW cycle 27; `ctr-0004` OPENED; **T3 HALF FULLY DISCHARGED AT CYCLE 35 AFTER EIGHT CYCLES**.**
src-0007's released IoC matcher is **one-directional, not two**: `any(pred.lower() in gt.lower() for gt
in gt_set)` — **a prediction must be a SUBSTRING OF a ground-truth entry**. The two-directional and
exact-match variants are **inside triple-quoted string literals and never run**. **The bias is
ASYMMETRIC:** lenient toward short/fragmentary predictions, **strict against verbose predictions**.
**"Substring-permissive, inflates true positives" is half right and must not be repeated unqualified.**
*Cycle 35 executed step (i) — `open_questions[6]` appended, the false `[5]` retained and superseded —
and added two things `ctr-0004` did not state: **a verbose-but-correct prediction is penalised TWICE
(FP and FN)**, and **the shared normalisation chain partly mitigates the deflation** by stripping
defanging and truncating at `" - "`. **Net sign remains UNKNOWN.** Step (ii) executed, see [57]. Step
(iii) turned out already done, see [59]. **`ctr-0004` STAYS OPEN** because its subject is now the live
MATCHER confound on `ctr-0001`.*

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005` OPENED;
REPAIRED BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images — **confirmed a
third time**. But the page states in plain text: a **41 min/report human-analyst baseline** against
~**3.3 min**; **17 metrics each a ratio 0–1**; and **"the LLM temperature parameter was set to 0"**.
**The temperature-0 fact strengthens `consistency-calibration-as-failure-mode`** and was fenced off for
three cycles by an over-broad hedge. **Standing lesson: a hedge is a claim and must be scoped as
precisely as an assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED AGAINST
`ttp-attack-mapping-reliability`; CLOSED AT CYCLE 31.** **(a)** Section 4.2 says *"We adopt the
**Micro-F1** score…"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's metric is ambiguous
by the paper's own text.** **(b)** The cross-task difficulty comparison was **ours** and subtracts
multi-class **accuracy** from multi-label **F1**. **(c)** key_claims[2] is **FALSE against Table 1**.
**(d)** The **ATT&CK correctness rule is never stated**. **(e) arXiv v2 has NO CTI-ATE task at all** —
always fetch v3. *Cycle 31 closed the entry; **(a) and (d) are NOT repaired and cannot be from this
paper** — they travel as permanent qualifiers. Cycle 33 priced it: `ttp` HELD at 2, because closing the
contradiction repaired only ONE of the two comparands.*

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29 AND AGAIN BY 33.**
`attribution-confident-wrong-gap` **bundles a well-evidenced question with an unevidenced one, and only
a T2 can fix it.** The **error-rate** half is well grounded (src-0002's derived 14–64% incorrect bucket
on 50 alias-tolerant real reports). The **confidence** half has **no evidence at all**. Natural cut:
`attribution-error-rate` vs `attribution-confidence-calibration`. **Next T2 is cycle 51.** *Successors
must not quote the corroborating parenthesis unqualified: **the "within-table rubric contrast" as
stated differences two different metric definitions** ([47]). The direction survives at **block** level
only.*

**[46] — NEW cycle 29; `ctr-0007` OPENED; **FULLY DISCHARGED AND `ctr-0007` RESOLVED AT CYCLE 35 AFTER
SIX CYCLES**.** src-0008 contains two self-contradictions and its per-phase numbers are image-locked.
**(a) THE STORED CLAIM IS OVER-GENERAL.** *"Cohere, however, shows progressive degradation: 1% missed
detections in P1, 2% in P2, 5% in P3, and in P4, 65% misses plus 35% explicit 'Don't Know' responses"*
— and **P1–P4 contain no cryptography**. **(b) IT DEFINES ITS METRICS TWICE, INCOMPATIBLY.**
**(c) PHASE LABELS** — see [5]. **(d) PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so the stored
percentages are **figure-derived**. **(e) TABLE 6 IS READABLE AND WAS NEVER CAPTURED** — DR 38.5 /
38.6 / 38.5 / 35 / 22.8%, **aggregates over all thirteen phases, never per-phase**. **(f) PASSED:**
Table 7 and the abstract. *Cycle 35 executed all three steps and **DECIDED the question cycle 29
declined**: the model-side variance **cuts both ways**, the candidate stays `proposed`, the undercutting
reading is the stronger, the supporting reading is a counterfactual about an arm src-0008 never ran,
and **src-0008 cannot adjudicate the hypothesis at all** because its task is JavaScript source code
while the candidate is about narrative threat reports. src-0008 is **demoted to illustration only**,
retained in the evidence list to preserve the trail. **What the closure does NOT repair:
`key_claims[0]` still literally contains the over-general sentence and cannot be deleted; its
correction is `key_claims[3]`; anyone citing [0] must read [3].***

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME; THE
JUDGE IS A MODEL UNDER TEST; `ctr-0008` OPENED. (d) DISCHARGED AT CYCLE 33.** **(a)** Appendix C.2
prints separate criteria blocks. **Threat Actor**: *"…5: Fully attributable; all details are clearly
linked to the original article."* — **source linking**. **Root Cause**: *"…5: Perfect attribution;
clearly identifies the threat actor."* — **actor identification.** **The labels run OPPOSITE to how the
state read them.** **(b) WHAT SURVIVES:** the **block-level** contrast — GPT-4o lower on **all six**
dimensions (1.547 / 1.528 / 1.145 / 2.019 / 1.734 / 1.140 vs 3.686 / 3.458 / 3.362 / 3.932 / 3.753 /
3.612). **(c) THE JUDGE IS GPT-4o**, one of the four scored models; in the source's favour, *"an
agreement rate … exceeding 95%"*; self-preference would inflate GPT-4o's own scores and GPT-4o scores
**lowest**. **Any citation of the GPT-4o-vs-o3-mini gap must state that GPT-4o was the judge.**
**(d) — DISCHARGED CYCLE 33**: `task-dependent-reliability-framing` **3 → 2**,
`extraction-vs-reasoning-ordinal-axis` **3 → 2**, `attribution-confident-wrong-gap` held at 2.
**(e)** The third candidate's stated reason for being `proposed` is discharged ([19]).
**(f) ACTION, STILL OPEN AND NOT MINE:** `eval/threat_actor.py` **was NOT obtained verbatim** — the
fetch returned a summary, untrustworthy under rule (ix). **Re-fetching it verbatim is step 1 of
`ctr-0008`'s repair and remains a job for a T3 targeting `attribution-confident-wrong-gap`.** *Cycle 35
note: that issue lost at 3a as a dependent; passed on undone for the second time. **Cycle 35 did
confirm the file exists and its size — `stage3_ti_drafting/score_evaluation/eval/threat_actor.py`,
7,017 bytes — from the HuggingFace tree API, so the fetch is known to be cheap and the file is small
enough to return whole.***

**[48] — FORMALISED AT CYCLE 32. A PROVENANCE GRANULARITY SPLIT IN src-0012.** `src-0012.md` carries
the corroborating Going Concern URL in full, but `index.json`'s `key_claims[3]` names the outlet
**without its URL** and `key_claims[0]` attributes the study's **2025** date **with no outlet at all**.
The `consulting.ca` headline URL states **no year**; the year **is** supported verbatim by Going
Concern. **A granularity weakness, not a fabrication.** No contradiction warranted. **Cheap fix for any
future cycle touching src-0012: append the outlet and URL to the two `index.json` key_claims.**

**[49] — FORMALISED AT CYCLE 32 FROM CYCLE 31's NEAR-MISS; **APPLIED PRE-EMPTIVELY AND SUCCESSFULLY AT
CYCLE 35**.** A byte-size check from the hosting API must precede any ABSENT verdict over a large file.
Cycle 31 fetched `data/TTP_Mapping.csv` twice and got 57 lines / 59 TechniqueIDs with four ABSENT
verdicts. **Taken at face value that is a devastating finding. It is false.** The GitHub contents API
reports the file at **1,083,078 bytes**; both readings were **truncation artefacts** and the ABSENT
verdicts are **void**. **This is the limit of [38]: both URL forms can fail the same way for the same
reason.** *Cycle 35's Job E applied this **before** fetching anything: the **HuggingFace tree API with
`recursive=true`** returned a complete 52-file listing with byte sizes in one call, which is strictly
better than the rendered page and made the "no per-model predictions" verdict authoritative rather than
inferential. It also **independently re-confirmed the 1,083,078-byte figure**, cross-validating cycle
31's correction from a different host. **For any HuggingFace repo, hit the tree API first.***

**[50] — NEW cycle 32; HARNESS HALF FIXED BY A HUMAN AT CYCLE 33.** A cycle can land its research, fail
its bookkeeping, and be committed as "run failed, no state change". Cycle 31 exhausted `max_turns: 50`
after committing four state files but before writing its last three log sections, **any carry-forward
section**, or either queue file, and `git log` describes it as **"run failed, no state change"** —
**wrong on both counts**. **THREE THINGS FOR A HUMAN. (1)** The commit message should be derived from
`git diff --stat` on `state/`, not from the CLI's exit status. **(2)** Writing the queue and
`last_completed_task.txt` **before** the log would fail safe. **(3)** A cycle that hits `max_turns`
should be retried as the SAME task. *(3) is fixed by commit `956a36c`. **(1) and (2) remain undone**,
and (1) is the one that misleads successors.* **FOR SUCCESSORS: verify the phase from
`next_task.json` AND `last_completed_task.txt` AND `git show --stat`, and disbelieve the commit
message.** *Cycle 35 did this (all three agreed) and **again voluntarily adopted (2)**, writing both
queue files before the log — which mattered this cycle, since it finished at ~47 of 50 turns.*

**[51] — NEW cycle 32. THREE REFINEMENTS TO THE G2 MECHANISM.** **(a) SELECT BY REPLICATION COUNT, NOT
ONLY BY STALENESS, WHEN SOMETHING LOAD-BEARING IS ONE FETCH OLD.** Closing a contradiction should itself
schedule a replication — extends [36]. **(b) "WHICH TEXT EXECUTES" IS NOT A PRESENT VERDICT AND CANNOT
BE TRUSTED FROM A STRING MATCH.** Where a docstring and a live branch describe **different** rules, both
are PRESENT and exact-string checks settle nothing. **`ctr-0004` and the cycle-31 finding are the two
known instances of documentation-vs-execution divergence; assume more.** **(c) READ THE STATE BEFORE
RE-DERIVING ANYTHING FROM A LOG** — `index.json`'s `src-0017` entry records five findings cycle 31's own
log never mentions. *Cycle 34 added a third selection criterion: **SELECT BY WHAT THE SCORE DISTRIBUTION
DEPENDS ON** — when one issue stands alone at the top of the graph, its evidence is the least-checked
load-bearing thing in the project by definition.* **Cycle 35 adds (d), which inverts (c): READ THE LOG
WHEN THE STATE CITES A DERIVED NUMBER. `ctr-0010` exists because the state's description of a derived
quantity was checked against `logs/cycle-018.md`, which produced it. (c) and (d) are not in tension —
(c) says do not re-derive a fact from a log when the state holds it; (d) says a DERIVATION's provenance
lives only in the log and nowhere else.**

**[52] — NEW cycle 33. A CONTRADICTION ENTRY CARRIES EXACTLY ONE `issue_id`, BUT ITS CONTENT CAN DAMAGE
SEVERAL ISSUES — AND THE GATE SEES ONLY ONE OF THEM. A SIXTH SHAPE FOR [41]; FOR A HUMAN.** `ctr-0008`
is filed against `attribution-confident-wrong-gap`. Its content materially damaged **three** issues, and
by its own text the largest exposure was **elsewhere**. But `jq` over
`.contradictions[] | select(.resolved_cycle==null)` groups by `issue_id`, so the G3 gate, the T5
selector and every per-issue query saw the exposure on **exactly one** of the three. **Three options for
a human, in ascending cost: (i) allow `issue_id` to be an array; (ii) require the opening cycle to file
a stub entry against each affected issue, cross-referenced; (iii) accept the limitation and require
every T4 to grep contradiction *bodies* for issue ids rather than trusting the `issue_id` field.**
*Cycle 33 chose (iii) plus `ctr-0009`. Cycle 34 confirmed the selector half empirically: `ioc`'s "three
open contradictions" tie-break credit is a count of FILINGS, not of exposure.* *Cycle 35 note: `ioc`'s
count is still three after a close and an open, which happens to keep the selector's input stable — but
by coincidence, not by design.*

**[53] — NEW cycle 33. THE ARXIV VERSION CHECK IS CHEAP, IT HAS PAID OFF, AND A REVISION CAN RENUMBER
THE TABLES A STORED CLAIM CITES.** One fetch of `arxiv.org/abs/2602.06718` revealed a **v2 (14 May
2026)** of src-0011 that no cycle had noticed in twenty-one cycles. **Every headline quantity survives
unchanged.** **But the per-venue table is `Table 3` in v1 and `Table V` in v2, and v2's `Table 3` is an
entirely different per-model table.** A future cycle fetching the current version and asking for "Table
3" would receive unrelated content **and could open a spurious contradiction against a clean source**.
**Two standing rules: (a) run the `/abs` version check on every arXiv source you touch; (b) when a
stored claim cites a table BY NUMBER, either pin the version in the URL or ask for the table BY
DESCRIPTION.** *Known version traps: src-0002 (v2 has no CTI-ATE task — fetch v3), src-0011 (v2
renumbers). **Cycle 35 cleared src-0007 and src-0013 — both v1 only, so neither carries the hazard.
Six of eighteen sources now checked on this axis.***

**[54] — NEW cycle 33, CONFIRMED AND SHARPENED AT CYCLE 34. THE SCORE DISTRIBUTION HAS COLLAPSED TO A
SEVEN-WAY TIE AND THE WEAKEST-LINK SELECTOR IS NOW EFFECTIVELY THE TIE-BREAK. FOR A HUMAN, AND FOR THE
PAPER.** The graph reads `institutional-incident-real-world-impact` 3, all seven other issues 2. A
selector that picks the weakest issue cannot discriminate among seven equals, so the under-specified
tie-break of [11] and the never-expiring `created_cycle` fallback of [30] are doing **almost all of the
selecting**. *Cycle 33 considered whether this justifies scoring less harshly and concluded it does not:
`prompts/t4_assess.md` step 5 is explicit that optimistic scoring breaks the selector. **The right
response is to flag the mechanism, not to distort its input.*** **(a)** A stingy rubric applied honestly
is **compressive** — issues fall toward the level their weakest leg supports and pile up there — so a
weakest-link selector degrades exactly as assessment discipline improves. **(b)** The scoring scale does
two jobs at once — *reporting* evidential state and *ranking* work — and they need different
resolutions. **CYCLE 34's EMPIRICAL TEST: actionability DID NOT DISCRIMINATE — five of seven tied issues
have named undone jobs, and both terminal-tie finalists did. Actionability is a good *filter* and a poor
*ranker*.** What decided cycle 34 was **staleness of last attempt** (13 cycles vs 9). **Recommendation:
replace the `created_cycle` fallback with a staleness/aging term.** *Cycle 35 supplies a data point for
(b): `ioc` was selected on staleness and **discharged two eight- and six-cycle-old jobs in one cycle**.
Staleness of last attempt selected well.*

**[55] — NEW cycle 34. `automated-triage-under-refusal` IS PERMANENTLY STARVED BY THE TIE-BREAK, AND
THIS IS PROVABLE IN ADVANCE RATHER THAN OBSERVED AFTER THE FACT. VERBATIM FOR A HUMAN. THE STRONGEST
FORM OF [30].** Three issues beat it on `created_cycle`: `ttp`, `ioc` and `consistency` (all created 2,
all upstream-maximal under 3a, all scored 2). It can only win when **all three simultaneously** carry a
3b recent-attempt penalty. Under the T5→T3→T4→T5 loop a T5 fires every 3 cycles and each produces
exactly one T3 attempt one cycle later, so attempts land on cycles 35, 38, 41, 44, 47 … spaced 3 apart,
and **a 5-cycle lookback window contains at most two of them**. At most two of the three can ever be
penalised at one T5; **at least one always has penalty 0 and beats `created_cycle` 16.** The selector
rotates `ttp` → `ioc` → `consistency` indefinitely and this issue is **structurally unreachable**.
**Caveats:** the proof holds only while those three stay tied at 2, while no T1/T2 alters the graph
(cycles 50 and 51 could), and while the loop does not fail a cycle. None of those is scheduled to help.
**CONSEQUENCES ALREADY VISIBLE:** [15]'s curl/HackerOne case (eleven cycles as the top uncollected
source) and [27]'s src-0015 Reward column (fifteen cycles unentered) are **blocked on a prompt change,
not on budget**. **PROPOSED FIX, one line in `prompts/t5_select.md`:** add an **aging term** before the
`created_cycle` fallback — subtract 1 from the effective score per N cycles since `last_attempt` (using
`created_cycle` for never-attempted issues). **Cycle 34 did NOT override the mechanism to fix this**:
overriding hides the defect behind a one-off correction. *Cycle 35 supplies the predicted data point:
this cycle was the cycle-35 attempt on `ioc` the proof anticipates, landing exactly where forecast.*
Passed on verbatim with [4], [11], [30], [41].

**[56] — NEW cycle 34, from the G2 bolt-on. A LOOSE THREAD ON THE ONLY ISSUE SCORED ABOVE 2. NOT A
CONTRADICTION.** src-0010's page serves its PDF as `ENISA Public Administration TL **2024** - v1.2.pdf`
while the same page states a publication date of **November 6 2025**, and src-0004 places that report in
the "published last October and November" pair. **No stored claim records that filename, so nothing
conflicts and [32]'s test says DO NOT FILE.** But a filename is weaker evidence than a page's own date
field and no defect is asserted. **For whichever cycle next touches
`institutional-incident-real-world-impact`:** ask whether ENISA's Public Administration Threat Landscape
is a **2024-titled report republished in November 2025** or whether the filename is a legacy artefact.
*Related: [14] says the v1.2 PDFs cannot be opened, so try the page's own metadata or the EU
publications catalogue instead.*

**[57] — NEW cycle 35. `ctr-0010`: A DERIVED QUANTITY HAS BEEN CARRIED WITH THE WRONG SCOPE FOR
SEVENTEEN CYCLES, AND NO CHECK THIS PROJECT RUNS COULD HAVE CAUGHT IT.** The state says the 0.09–0.15
range is the IoC recall needed to reconcile src-0003's 97.6% F1 with src-0007's 0.82–0.88 precision.
`logs/cycle-018.md` shows it is the recall at which **src-0007's IoC F1 falls to src-0007's own TTP F1**
— a within-src-0007 crossover in which **src-0003's number is not an input at all**. Cycle 18's
carry-forward restated its own result and cycles 21+ inherited the restatement. **THE UNDERLYING
ARGUMENT AND EVERY NUMBER ARE CORRECT; ONLY THE SCOPE IS WRONG.** *Three things follow.* **(a) THE
CONCLUSION IS TRUE AND HAS A CHEAPER PROOF, NOW RECORDED:** `F1 ≤ 2P/(P+1)`, so an F1 of 0.976 entails
`P ≥ 0.9531`; that is a **precision**, comparable directly with src-0007's precisions, so **the METRIC
confound is eliminated deductively with a margin of 0.069 (vs fine-tuned GPT-4o) to 0.129 (vs vanilla
GPT-4o)**, and no recall value can revive it. **(b) A FOURTH CONFOUND IS NOW LIVE ON `ctr-0001` —
MATCHER.** To close 0.069 the one-directional rule would have to net-deflate src-0007's precision by 6.9
points; that is not absurd, but the rule is lenient in the other direction too, the normalisation chain
closes the commonest deflation channel, and **src-0003 never states its own rule** ([33]) so the
correction is unsigned on both sides. **Not settleable from any released artefact** ([7]).
**(c) THE METHODOLOGICAL POINT, WHICH IS THE REASON THIS ITEM EXISTS:** this defect is invisible to
every check the loop runs — it is not a quotation, so string-matching cannot reach it; not a source
claim, so no G2 re-fetch can reach it; and the number is correct, so recomputation confirms it. **It was
found only by reading the log that PRODUCED the number rather than the state that cites it.** **DERIVED
QUANTITIES IN THIS BASE HAVE NEVER BEEN AUDITED AGAINST THEIR OWN DERIVATIONS. Known unaudited ones:
src-0001's four derived ECE means, src-0002's five derived plausible-but-not-correct percentage points,
src-0006's derived F1 ranges, and cycle 18's src-0006 crossover means (0.272 / 0.263, which [23] and
[54] both lean on).** This should become a standing check, and a human should consider whether
`prompts/system.md`'s G2 rule — which says "re-check it against its cited sources" — needs a second limb
for conclusions whose provenance is a computation rather than a source.

**[58] — NEW cycle 35. src-0007 IS PEER-REVIEWED AND PUBLISHED, AND THIS BASE HAS NEVER RECORDED IT.**
One `/abs` fetch of `arxiv.org/abs/2603.09452` returns, verbatim, **`Comments: Accepted at TMLR`** and
**`Journal reference: Transactions on Machine Learning Research (2025), ISSN 2835-8856`**. Also: **v1
only**, submitted 10 Mar 2026, so no [53] renumbering hazard on the Table 4 claims. **src-0007's
`index.json` entry records neither fact.** *Cycle 35 did not append it — appending a provenance
key_claim is clean, cheap and self-contained, and is better done by a cycle re-verifying src-0007
anyway (appending to an existing source entry is permitted and safe). **This is the third provenance
label found wrong or unrecorded, after src-0001 (called a preprint for 24 cycles, actually ARES 2025)
and src-0005 (assumed reviewed, actually an unreviewed preprint).** Note the interaction with [39]:
src-0017's `[TMLR '25]` badge — long recorded as "unresolved and probably permanently so" — **is now
partly explained**, since src-0017 is src-0007's artefact release and src-0007 is a TMLR paper. The
year discrepancy (a TMLR 2025 journal reference against a March 2026 arXiv submission) remains
unexplained and should not be guessed at.*

**[59] — NEW cycle 35. A TRACKING ENTRY THAT SAYS WORK IS OUTSTANDING IS EVIDENCE THAT SOMEONE ONCE
THOUGHT SO, NOT EVIDENCE THAT IT IS OUTSTANDING NOW.** Cycle 34's handoff gave cycle 35 five jobs and
**two premises of Job D were false**. (1) It asserted that three `scores.json` rationales still repeat a
"two-directional SUBSTRING CONTAINMENT" characterisation; `grep -c -i "two-directional"` over
`scores.json` returns **0**, and the three rationales already state the correct one-directional rule.
**Cycle 33's T4 discharged it and nobody updated the entry tracking it.** (2) `ctr-0004`'s own step
(iii) asserted the rationales "cannot be edited retroactively under append-only discipline". **False:**
`scripts/validate_state.py` lines 100–107 protect `index.json` `key_claims` and the **existence** of
`src-*.md` files **only**; `scores.json` and `graph.json` are unprotected. Both corrections are recorded
in `ctr-0004`'s cycle-35 addendum. **THE GENERAL LESSON, which is larger than this instance:** this loop
has no mechanism that marks a carry-forward item or a resolution step as done when some *other* cycle
does the work incidentally. [27] has been carried for fifteen cycles on exactly this assumption and
**has never been re-checked against the graph**. **Before spending a turn on any item described as
undone, verify it against the artefact, not the tracker** — it costs one `grep` and it saved this cycle
a wasted job. *Related to [51](c): read the state, not the log — and now also, read the state, not the
carry-forward.*
