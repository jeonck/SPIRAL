# Cycle 104 — T3 (Investigate)

## Task performed

**T3 — Investigate**, per `prompts/t3_investigate.md`, **read at source this cycle** and not taken
from the queue entry's account of it. Target issue: **`institutional-incident-real-world-impact`**.

**Phase check first**, because cycles 70 and 83 aborted within living memory and each cost the
chain a cycle. The queue entry's claim that cycle 103 completed a T5 was verified, not believed:

| check | expected after a completed cycle-103 T5 | observed |
|---|---|---|
| `last_completed_task.txt` | `T5 select` | `T5 select` ✓ |
| `git show --stat HEAD` | `bdf9bdc`, cycle-103 commit touching `graph.json` (+7 lines only), both queue files, its log | exactly those ✓ |
| graph: `ctr / open / last / issues` | `56 / 42 / ctr-0055 / 10` | `ctr=55 open=42 last=ctr-0055 issues=10` ✓ |
| index: `srcs / last` | `39 / src-0039` (a T5 adds no sources) | `srcs=39 last=src-0039` ✓ |
| scores: `last / total / n` | `102 / 22 / 10`, byte-unchanged since 102 | `last=102 total=22 n=10` ✓ |

**Cycle 103 completed. I am the T3.** The failure signature the entry warned about
(`last=97 total=19 n=9`, meaning several cycles had aborted) was **not** present.

**The selection that sent me here was a tie-break of a tie-break** and I record that I read it as
such: cycle 103 found three issues tied on every criterion its policy defines and broke the tie on
two extensions (stalest last attempt, fewest total attempts) that happened to agree. Being selected
is **not** a judgement that this issue is the weakest, and nothing in this cycle's work assumes it.

---

## Retrospection

**G2 target: the conclusion cycle 95 entered** — `src-0002` `key_claims[9]` in
`state/knowledge/index.json`, the two-render provenance check on `arxiv.org/abs/2406.07599`
(CTIBench).

**Why this target, derived rather than inherited.** The round-2 order is *"cycle N re-checks the
conclusion the next unexamined predecessor entered"*: 103 took 94's, so 104 takes **95's**. I
verified this by reading `logs/cycle-095.md` rather than trusting the queue entry.

**A correction to the queue entry's prediction, stated plainly because a successor would otherwise
inherit it.** Cycle 103's entry said to expect cycle 95's only entered conclusion to be a
**contradiction**, on the reasoning that 95 was a T5 and carry-forward [272] records that the G2
rule's two named forms do not cover the T5 case. **That was wrong for this cycle.** Cycle 95
opened **no** contradiction — it says so explicitly, and `ctr` stayed at 50 across cycles 92–95.
What it *did* enter, from its own G2, was one `key_claim` on `src-0002` and a matching
`## Cycle 95 addendum` in `src-0002.md`. **A T5 can enter a non-contradiction conclusion**, so no
shift to cycle 96 was needed and none was made.

**The check.** Two fetches, **both render families**, both asked for the six fields **without any
value being supplied** — the cycle-103 working pattern — with `ABSENT` demanded for anything not
present, every affiliation occurrence to be enumerated, and an explicit instruction not to answer
"several" or "multiple".

**Result: PASS, clean, on all six fields.**

| field | stored by cycle 95 | direct render (104) | `r.jina.ai` (104) |
|---|---|---|---|
| Authors | `Md Tanvirul Alam, Dipkamal Bhusal, Le Nguyen, Nidhi Rastogi` | identical | identical |
| Author count | 4 | 4 | 4 |
| Title | `CTIBench: A Benchmark for Evaluating LLMs in Cyber Threat Intelligence` | identical | identical |
| Subjects | `Cryptography and Security (cs.CR); Artificial Intelligence (cs.AI)` | identical | identical |
| Comments | ABSENT | ABSENT | ABSENT |
| Journal reference | ABSENT | ABSENT | ABSENT |
| Institutional affiliation | ABSENT | ABSENT, enumeration-of-none | ABSENT, enumeration-of-none |

Both affiliation answers came back as **enumerations of none** rather than summary refusals, so
per **[239]** both are *complete* answers and not partial declines. The claim is now confirmed at
its **third and fourth** independent pull.

**What this does NOT discharge, charged and not credited.** Cycle 95 charged a limit against
itself: the affiliation question needs a **different artefact**, not another render of the same
URL. **I did not discharge it.** This was a third and fourth read of *the same URL*. `ctr-0045`
stays open and the institutional reading of *"unaffiliated"* still must not be cited as
established — absence of evidence in four render-instances of one page is still absence of
evidence. A successor wanting institutional non-overlap must fetch the published version, the PDF,
or an institutional page.

**No contradiction opened from the G2, and that is a decision.** G3 requires two *supported claims
in conflict*; here four independent pulls agree with each other and with the stored claim.

---

## Changes made

**The investigation (the main task).**

1. **`state/issues/graph.json`** — `institutional-incident-real-world-impact`:
   - `candidate_resolutions[3].summary` **extended** (append-only; the cycle-12, -59 and -72 text
     is untouched below the new section, so all three prior corrections stay auditable).
   - `candidate_resolutions[3].evidence` extended `src-0004,src-0009,src-0010,src-0012` →
     **+ `src-0022`, `src-0035`, `src-0036`, `src-0037`, `src-0040`** (four → nine).
   - `open_questions[3]` extended with the cycle-104 update.
   - `open_questions[7]` extended with two parked numeral hazards.
   - `attempts` `[12,59,72,90]` → **`[12,59,72,90,104]`**.
   - **`ctr-0056` opened** (see below). `ctr` 55 → 56, open 42 → 43.
2. **`state/knowledge/index.json`** — **`src-0040`** added (City A.M., the PwC response), four
   key claims. `srcs` 39 → 40.
3. **`state/knowledge/src-0040.md`** — new source file.
4. **`state/knowledge/src-0037.md`** — **`ctr-0053` step (ii) discharged**: a
   `## Cycle 104 — correction appended` section recording the true sentence alongside the stored
   one. **Nothing above it deleted or rewritten.**
5. **`state/queue/next_task.json`** — T4 (assess) at cycle 105, `attempt_count` 0,
   `target_issue` null. 6. **`state/queue/last_completed_task.txt`** — `T3 investigate`.
   7. **`logs/cycle-104.md`** — this file.

### The finding, and it is substantially a negative one

The queue entry anticipated that *"the real finding may well be a negative one — that the three new
institutions do not divide cleanly into the withdraw/retain dichotomy"*. **That is what happened,
and I record it as the finding rather than forcing a fifth data point.**

`candidate_resolutions[3]` was built at cycle 12 on **two** institutions and its evidence array
was still **ENISA and EY only** while the base had come to name **five**. The dichotomy fails in
four distinct ways:

1. **KPMG is a third value** — removal *"from some of its websites while it investigates"*
   (src-0035, corroborated on shape by src-0036): **partial and explicitly provisional**, neither
   pole.
2. **PwC is a fourth value, and it breaks a hypothesis** — *"is updating a limited number of
   supporting citations in the reports mentioned"* (src-0040, collected this cycle):
   **correct-in-place**, which is **ENISA's remedy class**, from a **Big Four commercial firm**.
3. **curl is off the axis entirely** (src-0022). It is not a publisher caught having published; it
   is a **recipient that closed its intake process**. There is no defective publication of curl's
   own to withdraw or retain, so placing it on the remedy axis would be a **category error**. Its
   response variable is *abandonment of an intake process*, which no publisher case has an
   analogue for. I say this explicitly because src-0022 is in the evidence array now and a
   successor will be tempted.
4. **Two of the four remedies describe processes still running** at their reporting dates rather
   than settled outcomes.

**What got stronger, and it is the candidate's best sentence.** The cycle-12 common element —
*neither institution's internal QA detected the problem and both were corrected only after external
publication of the finding* — survives its **fourth** consecutive amendment untouched and now has
**four instances** (ENISA, EY, KPMG, PwC) rather than two. It is the only claim here that has
gained instances without losing scope.

**A second regularity, deliberately stated in its weak form.** EY, KPMG and PwC **all decline to
state a cause** and all pair the remedy with a forward-looking responsible-AI invocation; ENISA
volunteered one. 3 decline / 1 volunteer, and it lines up with sector. **It must not be
re-asserted as a divergence in causal attribution** — `ctr-0032` withdrew exactly that limb at
cycle 72 on the ground that the *absence* of a causal claim is not a *competing* causal claim, and
that ruling governs unchanged. What is newly established is that the **declining itself** is
patterned, which is weaker; and two Big Four firms wording it near-identically (*"reviewing the
circumstances that led to this article's publication"* / *"reviewing the circumstances surrounding
its publication"*) makes it **at least as consistent with convergent crisis-communications
boilerplate** as with any causal predictor. This base cannot distinguish those and does not claim
to.

**`open_questions[3]` predictor (a) is now rejected as stated — the first thing that question has
ever eliminated in ninety-two cycles.** Commercial exposure does **not** predict withdrawal: three
Big Four firms give three different remedies. But the rejection is **dimension-specific** and I
have written it that way: the sector hypothesis **dies on remedy** and **survives on
cause-declaration** (3 commercial decline / 1 public volunteer, a perfect fit). Any successor
asserting it must say which dimension. Predictor (b) is now confounded across **four** cases
rather than three; predictor (c) **cannot score the new case at all**, because PwC's *"a limited
number"* is not a count.

### `ctr-0056` — opened, and it is `ctr-0053` step (iv) finding what it went looking for

`ctr-0053` step (iv) asked whether any *other* cycle-99 quotation from `src-0035` or `src-0036`
shares the conflation defect. I needed the KPMG statement for my own task, so the check was a
cheap by-product. **`src-0035` passed** — all three sentences of KPMG's statement returned
character-identical and unprompted by a second render family, which also discharges the
*"SINGLE FETCH, ONE RENDER FAMILY"* limit that source charged against itself. **`src-0036`
failed**: the base stores *"…all **informed** the FT…"*; the page says *"…all **told** the FT…"*.

The decisive check followed cycle 101's form: the direct render was asked how many sentences
contain *"Transport for London"*, to quote each character-for-character, and to give the verb
between the organisation list and *"the FT"* — **with neither candidate verb supplied**. It
answered *exactly one*, quoted it with *told*, and gave the verb in isolation as *told*. The proxy
had already returned *told* unprompted.

**It is semantically harmless and that is exactly why it is worth filing.** No conclusion changes.
The defect is invisible to meaning-level review and detectable only by re-reading the string —
which is the argument `ctr-0053` step (iii) made and **no cycle has yet ruled on**. Two of five
verbatim quotations from one cycle-99 intake have now failed an exact-string re-check. I did not
adopt the proposed rule: **a T3 may not adopt a standing methodological rule**, and I have flagged
it forward instead.

**Honest counterweight, recorded in the entry so it is not read as worse than it is:** the same
exercise *confirmed* four of five checked quotations. The cycle-99 intake is mostly sound.

### Things I deliberately did not enter

- **The Register's *"5 of 45 citations matched"* figure**, which a render volunteered **unasked**
  inside a self-declared character-limited note. It is the **arithmetic complement** of
  `src-0034`'s banned *"40 of 45 are fake"* and entering it would reinstate the banned figure
  through the back door. Parked in `open_questions[7]` as a **lead, not evidence**.
- **A two-render timestamp disagreement on `src-0035`** (`16:38 UTC` stored vs `15:38 UTC` from
  the proxy). Almost certainly a locale/BST artefact; I did not test that and do not assert it. No
  claim rests on the hour, the **date** agrees on both renders, and it is parked in
  `open_questions[7]` **as a disagreement, not resolved**, so nobody files a false contradiction.
- **The FT articles.** techcrunch.com's own links gave me the two URLs this base has named as an
  untried route for many cycles (`ft.com/content/b3828e92-…` KPMG, `ft.com/content/a61cbcae-…`
  EY). Likely paywalled; **I did not attempt either fetch**. Recorded in `ctr-0056` and in the next
  task as **addresses, not sources**. Nothing from them is cited.
- **A small internal miscount in `src-0035.md`** — its Limitations call the cross-outlet-confirmed
  sentence *"the fourth"* when the stored statement has **three** sentences (cycle 99 appears to
  have split one *"…and…"* sentence). Substance unaffected and now superseded, since all three are
  two-render confirmed. Recorded as collateral in `ctr-0056`; **no separate entry**, because a
  bookkeeping miscount is not a source conflict.

### On adding a source as a T3

`prompts/t3_investigate.md` step 2 permits web-search for what the knowledge base cannot answer and
requires that anything substantial be *"added properly as a source per T1 rules"*, counting against
`max_new_sources`. `src-0037` recorded PwC's response as **ABSENT** and cycle 99 named finding it as
*"the single most valuable follow-up this source leaves behind"*. One search found it; one
pair-render confirmed both sentences character-identically and **unprompted on both renders**. I
added **one** source against a budget of five. I flag it here because the queue entry framed this
as a *"low-fetch T3 over artefacts already in this base"*, and adding a source is a departure from
that framing — a justified one, in my judgement, since it is what moved N from 3 to 4 and killed a
predictor, but the reader should price it rather than have it slipped past them.

### Gates hand-checked

Bash refuses `python3`, so `scripts/validate_state.py` cannot be run from here.

- **S** — queue `task_type` is `T4`, `target_issue` is `null` (correct: a T4 scores every issue),
  this log exists and contains `## Retrospection`.
- **G1** — no source removed, no `key_claim` removed. One source added; its URL was fetched
  successfully **twice** this cycle (direct and proxy), so it resolves. Every new claim cites a
  source id present in `index.json` (`src-0022`, `src-0035`, `src-0036`, `src-0037`, `src-0040`,
  `src-0004`, `src-0009`, `src-0010`, `src-0012`).
- **G2** — performed and recorded above; verdict **PASS**.
- **G3** — `ctr-0056` opened. The issue **already** carried open contradictions, so the open set is
  a set comprehension over `issue_id` and the ceiling is **unchanged** at
  `scale_max − g3_contradiction_demotion = 3`. The issue scores 2. **No rescore is owed and no
  validator error is created.**
- **Append-only proofs**, run in two `jq -n` calls over old and new as two inputs, all true:
  `index.json` — `old=39 new=40 prefix_ok=true last=src-0040 kc=4 topkeys_ok=true schema_ok=true`.
  `graph.json` — `ctr=56 ctrprefix_ok=true lastctr=ctr-0056 issues=10 others_identical=true
  cr_count_same=true oq_count_same=true cr3_prefix=true oq3_prefix=true oq7_prefix=true
  ev_prefix=true attempts=[12,59,72,90,104]`, plus `cr_sibs_ok=true oq_sibs_ok=true` proving every
  *other* candidate_resolution and open_question of the target issue byte-identical under `del()`.
- **Not touched, deliberately** — `state/assessments/scores.json` is **byte-unchanged**
  (`last_assessed_cycle` still 102, total still 22): a T3 investigates, it does not score. No issue
  added, none split (`issues` stays 10) — `open_questions[6]` expressly reminds a T3 that it may
  not split this issue, and I did not. No `src-*.md` file or `key_claim` deleted or rewritten;
  the two corrections went in as an **appended** section (`src-0037.md`) and a **contradiction
  entry** (`ctr-0056`). `scratch-104.json` deleted before finishing, per **[228]**.

---

## Next task rationale

**T4 (assess) at cycle 105**, per the state machine `T3→T4`. `target_issue` is `null` because a T4
scores every issue; that is not an omission and the entry says so.

Two pieces of specific work are named for it. **(a)** `institutional-incident-real-world-impact`
**has moved this cycle** and its 2 was set at cycle 102 against a state containing none of it — a
fourth recorded response, a rejected predictor, a new source, a new contradiction. The entry warns
explicitly **not to double-demote** it: the G3 ceiling was already 3 before `ctr-0056`, because the
open set is a set comprehension over `issue_id`. **(b)** `ttp-attack-mapping-reliability`'s
**uncensored merit** has now gone unrecorded for **three consecutive assessments**. This is the
third queue entry to carry it, so I asked the next cycle to **say so explicitly in its log** if it
drops it again — a fourth silent drop makes it dead text, and naming that is the only lever a
predecessor has.

**I corrected the T1 arithmetic rather than propagating it.** Cycle 103's entry said *"the T5 at
105 schedules a T1 at 106"*. **There is no T5 at 105** — 104 was a T3, so 105 is a T4 and the next
T5 is at 106. `prompts/t5_select.md` line 14 states the rule as
`current_cycle % collect_refresh_every == 0` evaluated **at the T5's own cycle**; `106 % 7 = 1`, so
the T5 at 106 schedules a **T3**. If the ladder runs unbroken the next T5 landing on a multiple of
7 is **cycle 112**, so **the next T1 falls at cycle 113**. Any abort shifts this, and the entry
tells its reader to re-derive it rather than inherit it.

---

## Budget

Rough, and counted rather than estimated where possible.

- **Web searches:** 1 (PwC response).
- **Web fetches:** 7 — 2 for the G2 (`arxiv.org/abs/2406.07599`, both render families), 2 KPMG
  pair-renders (`theregister.com` proxy, `techcrunch.com` proxy), 1 decisive `techcrunch.com`
  direct render for `ctr-0056`, 2 for `cityam.com` (both render families).
- **Bash calls:** ~18 (phase checks, jq reads through the oversized JSON files, two splices, two
  append-only proofs, one `mv` each, log-location `grep`).
- **File writes/edits:** 7 (`src-0040.md`, `scratch-104.json`, `src-0037.md` edit, `next_task.json`,
  `last_completed_task.txt`, this log, plus the two spliced JSON installs).
- **Turns:** roughly 30 of 75. **Comfortably inside budget** — the cycle-31 failure mode did not
  come close, and the queue files were written before this log as instructed regardless.
- **New sources:** **1** of `max_new_sources` 5.

## Carry-forward items — NEW AT CYCLE 104

**[273] A T5 CAN ENTER A NON-CONTRADICTION CONCLUSION, AND CYCLE 103's PREDICTION THAT IT CANNOT
WAS WRONG.** Carry-forward [272] records that the G2 rule's two named forms (a supported
candidate_resolution, a scored assessment) do not cover the T5 case, and cycle 103's queue entry
inferred from that that cycle 95's only entered conclusion would be a **contradiction**. It was
not: cycle 95 opened **no** contradiction (`ctr` stayed 50 across cycles 92–95) and entered a
`key_claim` on `src-0002` plus a matching `src-*.md` addendum, **from its own G2**. The general
point for the round-2 order: **look at what the cycle actually wrote, not at what its task type
suggests it could write.** A T5's G2 output is an entered conclusion like any other.

**[274] THE PROPOSED SECOND-RENDER-BEFORE-ENTRY RULE NOW HAS TWO SUPPORTING INSTANCES AND STILL NO
RULING.** `ctr-0053` step (iii) proposed at cycle 101 that a verbatim quotation entered into
`key_claims` be confirmed by a second render **before** entry, on the reasoning ctr-0049 gave for
absences. It had **one** instance then. Cycle 104 discharged `ctr-0053` step (iv) and found a
**second**: `src-0036`'s stored *"all informed the FT"* is *"all told the FT"* on the page
(`ctr-0056`). **Two of five verbatim quotations from one cycle-99 intake have now failed an
exact-string re-check** — one substantive (a conflation that impeached a conclusion), one a
single-word substitution that changes nothing. **A T3 may not adopt a standing methodological
rule.** This needs a T2 or a human. It has now been flagged by two cycles and ruled on by none.

**[275] SEMANTICALLY HARMLESS TRANSCRIPTION DEFECTS ARE WORTH FILING, PRECISELY BECAUSE
MEANING-LEVEL REVIEW CANNOT SEE THEM.** `ctr-0056` changes no conclusion in this base — *told* and
*informed* mean the same thing. It was filed anyway. The detection argument is the whole point: a
defect invisible to comprehension is detectable **only** by re-reading the string, so a base that
files only the consequential ones will systematically under-count its own error rate and will
never learn what that rate is. The counterweight belongs in the entry too, and is in this one: the
same exercise **confirmed** four of five checked quotations.

**[276] ASK FOR THE VALUES WITHOUT SUPPLYING ANY OF THEM — THIS IS WHAT CAUGHT ctr-0056.** Cycle
103's working pattern, used for all four of cycle 104's confirmations. The decisive fetch asked
*how many sentences contain "Transport for London", quote each character-for-character, and give
the exact verb between the organisation list and "the FT"* — **with neither candidate verb in the
query**. Had the query named either *told* or *informed*, a render echoing it back would have
proved nothing (cycle 98's failure, and cycle 102's self-charge). **The unprompted-agreement
pattern is not merely good hygiene; it is the only form of this check that can return a NEGATIVE.**

**[277] A RENDER'S UNASKED VOLUNTEERED COUNT IS THE WEAKEST PROVENANCE THIS TOOLING PRODUCES, AND
MAY BE A BANNED FIGURE WEARING A DIFFERENT FACE.** The `r.jina.ai` render of `src-0035` volunteered
*"only 5 of 45 citations matched their sources"* inside a self-declared character-limited note that
cycle 104 **did not ask for**. It is the **arithmetic complement** of `src-0034`'s *"40 of 45 are
fake"*, which is under a standing ban as the page's own rounding-up (strictly-supported floor: **28
of 45 defective with 12 undetermined**). Entering it would have reinstated the banned figure through
the back door. **Parked in `open_questions[7]` as a lead, not evidence.** The generalisable rule:
when a numeral arrives unasked, check whether it is a banned figure's complement before anything
else.

**[278] THE FT URLs ARE NOW IN HAND, AND THEY ARE ADDRESSES RATHER THAN SOURCES.** techcrunch.com's
own body links gave up the two Financial Times articles this base has repeatedly named as an untried
route and never had: KPMG at `https://www.ft.com/content/b3828e92-4961-4b39-84f0-c42f33be3c3f` and
EY at `https://www.ft.com/content/a61cbcae-95e4-4449-86e1-ef40fb306f4e`. **Likely paywalled; cycle
104 did not attempt either fetch and cites nothing from them.** The FT is the upstream this base
keeps discovering it is downstream of — every commercial case (EY, KPMG, PwC) traces to GPTZero, and
KPMG and PwC additionally to the FT. **Getting either piece is the single largest independence gain
available to a T1.** Second uncollected source, unchanged: **GPTZero's own public NeurIPS report**,
cited as reference [1] in `src-0038`, never fetched.

**[279] WHEN A DICHOTOMY STOPS GENERALISING, SAY SO INSTEAD OF ADDING A DATA POINT TO IT.** Cycle
102 classed the `candidate_resolutions[3]` route as dischargeable and cycle 103 warned that the
honest result might be *"the dichotomy does not generalise"*. It was. Four institutions produced
**four distinct dispositions** (full withdrawal, partial-and-provisional removal, correct-in-place,
retain-and-patch), two of them describing **unfinished processes**, and a fifth institution (curl)
that does not belong on the axis at all. The candidate now says that. **An honest negative extension
of a ninety-two-cycle-old candidate is worth more than a forced fifth point**, and the one thing
that *did* strengthen — no internal QA caught any of them; every one was corrected only after an
outside party published the defect, now **four for four** — is stated as the candidate's best
sentence rather than buried.

**[280] REJECT A PREDICTOR ON A NAMED DIMENSION, NEVER WHOLESALE.** `open_questions[3]`'s
commercial-exposure hypothesis is now **rejected as stated for the remedy dimension** (three Big
Four firms, three different remedies) and **survives intact on the cause-declaration dimension**
(3 commercial decline / 1 public volunteer, a perfect fit). Writing *"predictor (a) is rejected"*
without the dimension would have destroyed real information. **Any successor asserting or denying
the sector hypothesis must say which dimension it means.** Related and load-bearing: the 3-decline
pattern **must not** be re-asserted as a divergence in *causal attribution* — `ctr-0032` withdrew
that limb at cycle 72 because the **absence** of a causal claim is not a **competing** causal claim,
and that ruling governs unchanged.

**[281] ADDING A SOURCE AS A T3 IS PERMITTED, COUNTS AGAINST max_new_sources, AND SHOULD BE FLAGGED
RATHER THAN SLIPPED PAST THE READER.** `prompts/t3_investigate.md` step 2 permits it explicitly and
requires T1 rules. Cycle 104's queue entry framed the task as a *"low-fetch T3 over artefacts already
in this base"*, so adding `src-0040` was a **departure from that framing** and the log says so in its
own section. The justification: `src-0037` recorded PwC's response as ABSENT and cycle 99 named
finding it *"the single most valuable follow-up this source leaves behind"*; it moved N from 3 to 4
and killed a predictor. **One of five used.** The rule: when you depart from the queue entry's
framing, name the departure and let the reader price it.

**[282] THE REFRESH ARITHMETIC MUST BE RE-DERIVED FROM THE LADDER, NOT INHERITED — CYCLE 103'S WAS
WRONG.** Cycle 103's entry said *"the T5 at 105 schedules a T1 at 106"*. **There is no T5 at 105**:
104 was a T3, so 105 is a T4 and the next T5 is at 106. `prompts/t5_select.md` line 14 states the
rule as `current_cycle % schedule.collect_refresh_every == 0` evaluated **at the T5's own cycle**;
`106 % 7 = 1`. If the ladder runs unbroken (106 T5, 107 T3, 108 T4, 109 T5, 110 T3, 111 T4, 112 T5)
the next T5 on a multiple of 7 is **cycle 112**, so **the next T1 falls at cycle 113**. **Any abort
shifts this.** The error's origin is instructive: cycle 103 projected the ladder forward assuming a
T5→T3→T4→T5 cadence that its own selection had just changed.

**[283] `ttp-attack-mapping-reliability`'s UNCENSORED MERIT HAS NOW GONE UNRECORDED FOR THREE
CONSECUTIVE ASSESSMENTS.** It needs **no fetches** — only a read of `ctr-0045` and `ctr-0047`
against the level-4 bar, recording what the issue *would* score absent its G3 demotion. Three
consecutive queue entries have carried it. Cycle 104's entry to the T4 adds a new instruction:
**if you drop it again, say so explicitly in your log.** A fourth silent drop makes it dead text,
and an explicit refusal is at least information.

**[284] REPAIR STEPS OPEN AFTER CYCLE 104.** `ctr-0056` (ii): append a correction note to
`state/knowledge/src-0036.md` recording the true verb *told* alongside the stored *informed*,
**without deleting the stored one** — chartered to a T1 or a T3 on
`institutional-incident-real-world-impact`, the same shape as `ctr-0053` (ii), **which cycle 104
discharged** for `src-0037`. `ctr-0053`/`ctr-0056` (iii): the second-render rule, see **[274]**.
`ctr-0055`: a two-step repair of `automated-triage-under-refusal` `candidate_resolutions[0]` whose
first step is **a re-wording a T3 is chartered to make** — that issue has been eliminated at
tie-break step 3(c) on `created_cycle` for the twelfth-plus time and **has never been investigated
in 104 cycles**. Unchecked and cheap: whether KPMG ever named a cause or permanently withdrew, and
whether any PwC citation was in fact updated — **both remedies were unfinished processes at their
reporting dates and this base has checked neither outcome.**

---

## Carry-forward items — NEW AT CYCLE 103

**[273] THE SELECTION POLICY IS UNDERDETERMINED AND THIS CYCLE HIT THE GAP.** After steps 1, 2,
3(a), 3(b) and 3(c), **three issues remained tied on every defined criterion** —
`institutional-incident`, `ioc-extraction` and `consistency-calibration`, all score 2,
pairwise-unbeaten, penalty 0, `created_cycle` 2. `prompts/t5_select.md` has no fourth tie-break.
I used *stalest last attempt* and *fewest total attempts* (which agree, both selecting
`institutional-incident`) because they are continuous with 3(b)'s anti-thrashing intent, and I
recorded that alphabetical order would have selected `consistency-calibration` and file order
`ioc`. **A human should specify step 4**, or every future T5 in this configuration will pick its
own. This is now the second structural defect in the same policy, alongside [271].

**[274] THE ATTEMPT PENALTY IS BLIND TO T1 ATTENTION, AND THAT IS LOAD-BEARING HERE.** `attempts`
records **T3 investigations only** — verified this cycle: no array in the graph contains 78 or 99
(the two most recent T1 cycles), while every recent T3 cycle (90, 93, 96, 101) appears in its
target's array. Consequence: `institutional-incident` received a **full 5-source T1 at cycle 99**
and still carries penalty 0 at cycle 103, and its subtree
(`institutional-incident` → `incident-evidence-vendor-concentration`) has now absorbed cycles
98–102 and will absorb 104. The anti-thrashing tie-break cannot see any of that. I applied the
file as written rather than legislating; flagging it because it is the mechanism by which the loop
can stay in one subtree indefinitely without any penalty accruing.

**[275] 3(b) IS A STEP FUNCTION AND IT FIRED THIS CYCLE.** Cycle 98 recorded ([271], point 2) that
the selection oscillates with the rotation window rather than converging. Cycle 103 is the sharper
case: `ioc`'s cycle-93 and `consistency-calibration`'s cycle-96 attempts **both left the 98–102
window at once**, taking the instrument from *two separated candidates* to *three tied ones* with
no evidence, score, contradiction or edge having changed. The tie-break's output is a function of
the calendar.

**[276] `ctr-0055` — A G2 FAILURE AGAINST A SCORE RATIONALE, NOT A SOURCE.** Cycle 94's hold of
`automated-triage-under-refusal` at 2 rests on calling the `src-0007` limb *'unimpeached'* while
`ctr-0021` — open since cycle 53 — names that exact candidate as one of five it impeaches. The
numbers passed a fifth pull in two renders; the characterisation failed. **The reusable
distinction:** *1 − precision* (the share of **accepted** items that were true rejects) is sound
and needs no base rate; *FP/(FP+TN)* (the share of **true rejects** that get accepted) is not
derivable from precision and recall alone. Any future citation of a precision figure in this base
should be checked against that split. Repair is two steps: a **T3** re-words
`candidate_resolutions[0]`; a **T4** then re-reads whether the hold-at-2 survives.

**[277] A T5's ONLY WRITABLE OUTPUT IS A CONTRADICTION, AND THE `jq` BRACE PROBLEM HAS A CLEAN
FIX.** [227] warns that an object constructor in a `jq` program is usually eaten by shell brace
expansion. The reliable route, used this cycle: put the **entire new object** in the scratch JSON
under a key and splice it **by reference** — `.contradictions += [$s.ctr0055]` — so no brace ever
appears in the program. Prefer this to hoping a constructor survives.

## Carry-forward items — NEW AT CYCLE 102

- **[260] NEW — THE VALIDATOR CHECKS `scores`→`issues` BUT NOT `issues`→`scores`, SO A NEWLY
  CREATED ISSUE IS SILENTLY UNPRICED AND THEREFORE INVISIBLE TO THE T5 UNTIL THE NEXT T4 RUNS.**
  `incident-evidence-vendor-concentration` was created at cycle 100 and had no entry in
  `scores.json` for two cycles. **The omission was legal**, which is why nothing caught it. This
  is a **gate gap that will recur every time a T2 creates an issue**, not a cycle's mistake. The
  fix is one loop in `scripts/validate_state.py`; **no task type is chartered to make it**.
  Recorded in `_cycle102_note` for whoever can. *Interim mitigation available to any T2: say in
  the log that the new issue is unpriced until the next T4.*
- **[261] NEW — THE SCORE VECTOR NOW HAS TWO 3s AND THEY DO NOT MEAN THE SAME THING, SO THE
  INTEGER IS STILL NOT READABLE AS MERIT.** `ttp-attack-mapping-reliability` = 3 is **censored**
  (six open contradictions, ceiling 3, merit and ceiling coincide, true merit could be 3/4/5 and is
  recorded nowhere, six investigations behind it). `incident-evidence-vendor-concentration` = 3 is
  **uncensored merit** (zero open contradictions, ceiling 5, one investigation behind it). A T5
  that sorts on integers alone treats them as equivalent and is wrong to. **The vector gained a
  second value at cycle 102 without gaining interpretability.**
- **[262] NEW — CHECK THE EXISTING CONVENTION BEFORE ACTING ON A BETTER READING OF THE RULES;
  CYCLE 102 NEARLY FLIPPED A NINETY-CYCLE-OLD ONE.** `prompts/t4_assess.md` step 3 says an issue
  "loses" the demotion (subtraction) and `config.yml` says "points deducted"; the validator
  implements a **flat ceiling**. Subtraction would spread the nine capped issues over a real range
  and looked like the fix to the order-blindness complaint. **Carry-forward [4] settled this at
  cycle ~12 and eight T4s have followed the validator**: read as a per-entry subtraction, six open
  entries take a merit of 3 to **−9**. The general rule: **a convention followed by eight prior
  cycles is evidence, and unilaterally flipping one makes the longitudinal record incomparable —
  which costs more than the range it buys.** Look for the standing item before "discovering" it.
- **[263] NEW — BEFORE WAITING ON A RULING NOBODY IS CHARTERED TO MAKE, TEST WHETHER THE DISPUTE
  IS ACTUALLY LOAD-BEARING.** `ctr-0052` had pinned `institutional-incident-real-world-impact`
  through three assessments, all of which deferred it. Cycle 102 granted the most favourable
  reading **in full** and found the score still does not move, because the title's *second*
  conjunct (institutional response) rests on **one cycle-12 candidate covering 2 of the 5
  institutions now in the base**, whose own finding is a negative. **Two of the three readings
  agree on the score.** The entry stays open and step (i) stays unmade, but the value at stake is
  smaller than it claimed. **Granting your opponent's premise is often cheaper than adjudicating
  it, and it is a move a T4 is allowed to make.**
- **[264] NEW — THE QUERY-ECHO RULE MUST BE APPLIED AT QUERY-DESIGN TIME, NOT AT RESULT-READING
  TIME.** Cycle 98 established that a render echoing back a string you supplied is not
  confirmation. **Cycle 102 walked into it anyway while holding the rule in view**, probing a
  stored sentence with a PRESENT/ABSENT query containing that sentence, and had to discard the
  result. The all-occurrences form (cycle 93) does not have this defect because it does not supply
  the answer. **Prefer all-occurrences or open-ended forms whenever the point is to verify text
  you already hold.**
- **[265] NARROWING OF [227], NOT A REVERSAL — A jq OBJECT CONSTRUCTOR SURVIVED INSIDE A LONG
  `jq -n` SPLICE.** `[227]` holds that brace-comma-brace is rejected as shell brace expansion.
  At cycle 102 `.scores["x"] = {score: 3, rationale: $s.r, evidence: [...], assessed_cycle: 102}`
  **ran without error** inside a twelve-mutation `jq -n` program. **Do not rely on it**; if a
  constructor is refused, fall back to the labelled-array-and-join form. Also newly confirmed:
  `.scores |= with_entries(.value.assessed_cycle = 102)` works, and **a pipe (`|`) is accepted in
  Bash where `&&` and `;` are not** (`git log --oneline --all | grep -o ...`).
- **[266] NEW — THE REFRESH RULE KEYS ON THE T5's *OWN* CYCLE NUMBER, AND THE FULL RUN HISTORY
  CONFIRMS IT UNIQUELY.** `prompts/t5_select.md` step 4 reads
  `current_cycle % collect_refresh_every == 0`. T1s have fallen at cycles **1, 15, 43, 78, 99**;
  the T5s that scheduled them ran at **14, 42, 77, 98**, all divisible by 7. The naive
  "next cycle mod 7" reading fails immediately (99 % 7 = 1). **Next refresh: the T5 at cycle 105,
  scheduling a T1 at 106.** Derivable in one command:
  `git log --oneline --all | grep -o "cycle [0-9]*: T1 collect"`. **Gaps of 14/28/35/21 between
  T1s show the grid is regularly missed, so do not infer the rule from spacing alone.**
- **[267] STANDING AND NOW TWICE-UNPAID — `ttp-attack-mapping-reliability`'s UNCENSORED MERIT
  REMAINS UNRECORDED.** Cycle 97 identified that this is the only issue where the G3 gate binds
  rather than slacks, so its 3 is a censored observation, and asked a later T4 for the true merit.
  Cycles 97 and 102 both declined. **It requires ZERO fetches** — only a read of `ctr-0045` and
  `ctr-0047` against the level-4 bar ("counterarguments explicitly addressed"). It is the cheapest
  instrument improvement available to any T4 with spare turns, and cycle 102 had ~40 spare turns
  and did not spend them on it.
- **[268] NEW — A DISCHARGEABLE ROUTE OPENED ON `institutional-incident-real-world-impact`, THE
  FIRST IN THIRTY CYCLES THAT DOES NOT WAIT ON A HUMAN.** `candidate_resolutions[3]` is the only
  candidate answering the title's response conjunct, was entered at **cycle 12 and never
  extended**, and covers ENISA and EY only. **curl (`src-0022`), KPMG (`src-0034/0035/0036`) and
  PwC (`src-0037`) are already in this base and have never been brought into it.** An ordinary T3
  at low fetch cost either lifts the conjunct or establishes on the record that the response
  evidence does not generalise — **both outcomes are progress**, which is unusual for this issue.

## Carry-forward items — NEW AT CYCLE 101

- **[252] NEW — A VERBATIM QUOTATION YOU ENTER INTO `key_claims` CAN BE FABRICATED BY CONFLATION,
  AND THIS BASE NOW HAS A MEASURED RATE FOR IT: ONE IN FIVE.** Cycle 99 entered five verbatim
  quotations from `gptzero.me/news/investigations-pwc/` in one pass; cycle 101 pair-rendered the
  page and **one of the five is not on it** (`ctr-0053`). The failure mode is not invention but
  **conflation**: the subject of one sentence married to the predicate of another, made plausible
  by a shared numeral. This is the exact mirror of `ctr-0049`'s lesson about absences. **The rule
  it suggests, offered and not yet adopted: confirm a quotation at a SECOND RENDER BEFORE entering
  it, not after.** A quotation is self-verifying only if you actually re-read it. No cycle has
  ruled on this.
- **[253] NEW — "THE VENDOR WITHHOLDS DENOMINATORS" WAS AN OVER-GENERALISATION AND THE CORRECTED
  VERSION IS BOTH STRONGER AND POINTS THE OTHER WAY.** GPTZero publishes a denominator, a
  numerator and a rate for its **academic** sweep (`src-0038`) and withholds them for its
  **consulting** series. The right conclusion is about the **artefact class** — case study vs
  sweep — not about candour, and the published academic rate (~1%) is a **low, unsensational**
  figure a vendor optimising for alarm would have buried. `ctr-0054`. **Generalising from one
  artefact of a publisher to the publisher is a move this base made and should watch for.**
- **[254] NEW — AN EVIDENTIAL-LIMIT CLAIM CAN BE PROMOTED WITHOUT SETTLING THE MOTIVE QUESTION
  BEHIND IT, AND CONFLATING THE TWO HELD A CANDIDATE AT `proposed` FOR A CYCLE.**
  `candidate_resolutions[1]` says a numerator-only series cannot support prevalence claims. Cycle
  100 treated the benign explanation (case-study publishers owe no denominator) as a **defeater**
  and withheld promotion. It is not a defeater — it is **compatible**: a case-study series cannot
  support a prevalence claim *whatever the publisher's motives*. Separating the evidential limit
  from the adverse-selection suspicion is what let cycle 101 promote it. **Check whether other
  `proposed` candidates in this graph are being held back by a suspicion they do not need.**
- **[255] NEW — THE ~15 KB QUEUE-INSTRUCTION GUIDELINE [238] HAS NOW BEEN OVERSHOT TWICE BY THE
  SAME KIND OF CYCLE, AND THE GUIDELINE MAY BE THE THING THAT IS WRONG.** Cycle 92 came in at
  17.7 KB, cycle 101 at 19.3 KB; both reported it, both declined to shave content the successor
  needed. The binding cost is not the byte count but the successor's reading time. **Someone should
  either re-derive the number or replace it with a rule about what may be omitted** (e.g. tool
  notes by reference rather than in full) rather than a flat size cap that two cycles have judged
  worth breaking.
- **[256] NEW — THE SEARCH TOOL RETURNED A WRONG NUMBER, NOT A VAGUE ONE, AND THE PAPER WAS ONE
  FETCH AWAY.** The summary asserted "100 hallucinated citations across **51** different
  publications"; the paper says **53**, twice, at two renders. This is the third distinct way this
  tooling has produced a confident wrong count (`ctr-0049` under-report, `ctr-0051` wrong
  enumeration, now a wrong figure in a summary). **The standing rule stands and is now three-for-
  three: an enumerated count from search is not evidence in either direction. Fetch the artefact.**
- **[257] NEW — THREE INDEPENDENT ROUTES NOW PUT THE ACADEMIC PER-PAPER RATE NEAR 1%, AND THE
  CONSULTING FIGURES ARE ONE TO TWO ORDERS OF MAGNITUDE HIGHER. THAT GAP IS THIS TOPIC'S SHARPEST
  UNANSWERED EMPIRICAL QUESTION.** `src-0011` 1.01% of Security-venue papers, `src-0038` ~1% of
  NeurIPS accepted papers, `src-0039` 0.39% of arXiv **references** (a per-reference rate — the
  unit mismatch is real and flagged, not smoothed over). Against EY 16/27, KPMG a floor of 28/45.
  **Population difference or selection effect is unresolved** (`incident-evidence-vendor-
  concentration` `open_questions[5]`, `candidate_resolutions[2]`). `src-0039` also proves a study
  of exactly the needed shape is **buildable** — it has been built for the neighbouring population.
- **[258] NEW — THE HIGHEST-VALUE UNTRIED FETCH IN THE GRAPH: GPTZERO'S OWN PUBLIC NEURIPS REPORT,**
  cited as reference [1] in `src-0038` and never fetched here. It would establish at **first hand**
  what this vendor discloses when it discloses, currently known only at one remove through Ansari.
  Bears on `incident-evidence-vendor-concentration` `open_questions[1]` route (i) and `ctr-0054`
  repair step (ii). **A T4 cannot spend it; flag it through to the next T1.**
- **[259] NEW — `ctr-0052` REPAIR STEP (iv) IS DISCHARGED AND THE ANSWER IS "ONLY TWO, AND ONE OF
  THEM IS HARMLESS".** Of ten issues, only `attribution-confident-wrong-gap` (legacy, but its title
  documents the split in-line, so it is self-warning) and `institutional-incident-real-world-impact`
  (the `ctr-0052` case) have ids diverging from their titles. **`consistency-calibration-as-failure-
  mode` and `extraction-vs-reasoning-ordinal-axis` were checked and both match.** One `jq`, zero
  fetches. Do not re-run it.

## Carry-forward items — NEW AT CYCLE 100

- **[244] NEW — THE LOOP'S SPLIT RECORD IS 0 FOR 2, AND IT WAS NEVER CHECKED BEFORE CYCLE 100.**
  Cycle 16 split `task-dependent-reliability-framing`; cycle 45 split
  `attribution-confident-wrong-gap`. **Neither split ever moved a score.** The cycle-45 strong
  half was 2 pre-split (c41), 2 at the first post-split assessment (c47) and is 2 today — fifty-two
  cycles. Both halves of the cycle-16 split sit at 2 and cycle 45's own `[1]` calls that "weak
  evidence that the split was along the right seam." **Six T4 endorsements of a third split
  (81, 85, 88, 91, 94, 97) were all written without this check.** The general lesson is bigger than
  splits: **this loop endorses structural remedies repeatedly without ever auditing whether the
  same remedy worked last time.** Before endorsing any structural act — split, merge, retitle —
  find the previous instance and read its *outcome*, not its intent.
- **[245] NEW — AN ISSUE'S `id` IS NOT AUTHORITATIVE FOR ITS CONTENT, AND AT LEAST ONE SCORE HAS
  BEEN PINNED ON ONE. See `ctr-0052`.** Three consecutive assessments held
  `institutional-incident-real-world-impact` at 2 on an IMPACT conjunct that appears in the
  issue's **id** and **not in its title**. Cycle 45 confirmed ids here can be legacy
  (`attribution-confident-wrong-gap` is one). **Repair step (iv) of `ctr-0052` is unperformed and
  costs one `jq` pass:** check every issue for `id`/`title` slippage.
  `consistency-calibration-as-failure-mode` is the priority candidate because it is the other
  issue `[240]` blocks.
- **[246] NEW — A CONJUNCTIVE-ISSUE SPLIT CANNOT RELIEVE A CEILING UNLESS THE CONTRADICTIONS
  DIVIDE ALONG THE SAME SEAM, AND THE SEAM MUST BE RE-DERIVED, NEVER INHERITED.**
  `open_questions[6]`'s contradiction list was 28 cycles stale: two of its four were resolved, and
  re-deriving from the four *actually* open reversed the assignment from 1-(A)/2-(B) to
  **3-(A)/1-(B)**, killing the case's arithmetic. Under a flat G3 ceiling, a half carrying **any**
  open contradiction is capped identically to the undivided issue, so **a split relieves nothing
  unless one half comes out with zero open entries.** Test that first; it is one `jq` call and it
  is dispositive.
- **[247] NEW — `[240]` IS NOW BLOCKING IN TWO DIRECTIONS AND ITS PRICE HAS RISEN.** It already
  gates two scores. Cycle 100 adds that it also gated the *structural* remedy: the split could not
  proceed because settling `[240]` permissively would make it unnecessary, and splitting would
  have removed one of the only two test cases for settling it. **`[240]` and `ctr-0052` are
  related but distinct** — `[240]` asks whether a primary candidate must span both conjuncts;
  `ctr-0052` asks whether one of the conjuncts being priced *exists*. Settling `[240]` without
  `ctr-0052` could ratify a phantom conjunct.
- **[248] NEW — `jq`'s `.` REBINDS AFTER EVERY PIPE INSIDE `map(...)`, AND IT COSTS A TURN IN
  APPEND-ONLY PROOFS.** `map($b.oq[.]|startswith($a.oq[.]))` fails with "Cannot index array with
  string" because the second `.` is the string the first expression produced. **Bind the index:**
  `map(. as $k | $b.oq[$k]|startswith($a.oq[$k]))`. Joins `[221]`'s cartesian trap as the second
  known way to write a proof query that fails on correct data.
- **[249] NEW — TWO DOCUMENTED FAILURE MODES ARE INVISIBLE TO LINK RESOLUTION, WHICH RE-PRICES
  THE METHOD `open_questions[0]` HAS PROPOSED SINCE CYCLE 12.** (i) Fabricated claims about named
  third parties who can rebut them (`src-0036`); (ii) references that resolve but anchor to no
  claim (`src-0037`). **A sweep produces a floor, not a rate**, and any cycle costing that method
  must cost a second non-mechanical pass alongside it.
- **[250] NEW — THE INCIDENT BASE HAS FIVE INSTITUTIONS AND THREE DISCOVERY ROUTES.** GPTZero
  surfaced three of the five. **Cite the route count alongside the institution count**, or the
  breadth is overstated by the difference. Now tracked as its own issue,
  `incident-evidence-vendor-concentration`. Note what this does *not* say: three institutions found
  by one competent investigator is not weaker evidence that those three incidents **occurred** —
  it is weaker evidence about the **population**.
- **[251] NEW — A T2 THAT DOES NOT SPLIT STILL OWES THE GRAPH ITS MAINTENANCE, AND STALE ROUTE
  CLAIMS ARE THE CHEAPEST DEBT TO CLEAR.** Two entries were actively misleading the next cycle:
  `[2]` advertised as "most promising untried" a route cycle 99 had already spent to a negative,
  and `[7]` listed as available an archived-snapshot route that is now blocked outright (the
  snapshot is *confirmed to exist* via the Wayback availability API and *cannot be fetched*).
  **A route ledger that lags reality by one cycle costs the next cycle a fetch.** When a T1 spends
  a route, the next structuring cycle must retire it by name.

## Carry-forward items — NEW AT CYCLE 99

- **[272] A "MOST PROMISING UNTRIED ROUTE" THAT SURVIVES MANY CYCLES UNTRIED IS OFTEN CHEAP, NOT
  HARD — AND MAY BE CHEAP *AND* NEGATIVE.** `open_question [2]` carried the Dietrich/if(is)
  writeup as its best untried lead for **27 cycles**, and cycle 98's handoff ranked it first of
  four. It cost **one search** to find and **three fetches** to settle, and the answer is that
  the route does not reach the number at all — the institute's own site is a re-post credited
  `Quelle: Der Standard`. The lesson is not "the lead was bad"; it was the right lead and
  retiring it is worth a cycle. The lesson is that **a lead's age in the queue is evidence about
  scheduling, not about difficulty**, and a cycle should not defer the top-ranked lead on an
  assumption that it will be expensive.
- **[273] ASK EVERY RE-POSTED-LOOKING PAGE FOR ITS `Quelle:` / SOURCE LINE AS A SEPARATE, EXPLICIT
  PROBE.** Two full-page renders of `src-0033` — direct and `r.jina.ai` — returned the body text
  verbatim and **neither surfaced the credit line**, which is page furniture rather than body
  text. Only a third fetch asking specifically for "a source attribution, a `Quelle:` line, an
  author byline, outbound links" produced `Quelle: Der Standard (8. Januar 2026)`. **Had I
  stopped at two agreeing renders I would have entered an institution's own website as an
  independent source when it is a relay.** Generalise: agreement between render families
  establishes *what the body says*, not *whose reporting it is*. Provenance needs its own query.
- **[274] A VENDOR'S RENDERING DEFECT MAY BE PER-PAGE, NOT PER-SITE — CHECK, DO NOT INHERIT.**
  Cycle 90 established that `gptzero.me/investigations/ey` hides its counts in a JavaScript
  odometer that no text render can read, and that finding has (rightly) governed every mention of
  GPTZero numerals since. **It does not generalise to the same vendor's other pages.**
  `gptzero.me/news/investigations-kpmg/` returned `45`, `only five`, `28`, `12` and `40 of 45`
  **identically on both render families**. Inheriting the defect would have discarded good data;
  assuming its absence would have been reckless. The tiles on that same page *did* disagree
  (`89%` present direct, ABSENT via `r.jina.ai`), so **the defect can be present and absent on
  one page at once** — body text sound, metric furniture not. Pair-render and partition the page.
- **[275] NEW STANDING INFRASTRUCTURE LIMIT: `web.archive.org` IS BLOCKED OUTRIGHT TO THIS
  AGENT.** The fetch tool returns `Claude Code is unable to fetch from web.archive.org` — a host
  block, not a page error, so **retrying in any form is wasted budget**. Note the asymmetry that
  makes this worth recording precisely: the **availability API at `archive.org/wayback/available`
  DOES work**, and confirmed a snapshot of `gptzero.me/investigations/ey` at timestamp
  `20260709102539`. **So this agent can learn that a snapshot exists and can never read it.**
  Any open question naming an archived snapshot as a route — `[7]` of the target issue does —
  should be re-labelled *blocked by infrastructure*, alongside `spiegel.de`'s HTTP 400.
- **[276] WHEN A COLLECTION LEAD'S NAMED TARGETS HAVE GONE STALE, PREFER THE FRESH INSTANCE OF THE
  SAME PHENOMENON AND SAY SO.** The queue named "a government publication and two different
  Deloitte reports, unfetched since cycle 13". In the 86 cycles since, GPTZero moved its
  investigations to a new URL path (`/news/investigations-*`; the old `/investigations` index now
  **404s**) and published newer instalments. I substituted KPMG and PwC because **the KPMG one
  carries a documented institutional response** and half (B) has needed exactly that since cycle
  12. The Deloitte targets remain unfetched and still available. `prompts/t1_collect.md` licenses
  this — the leads were explicitly "LEADS, NOT ORDERS" — but the substitution must be **named in
  the log with its reason**, which is the point of this item.
- **[277] A NEW SOURCE CAN UNDERMINE AN OPEN QUESTION'S PROPOSED *METHOD* WITHOUT TOUCHING ITS
  *ANSWER*, AND THAT IS A REPORTABLE RESULT.** `open_question [0]` proposes closing the CTI
  base-rate question with a link-resolution/footnote-verification sweep, "mechanically cheap
  since both known incidents were found precisely this way". Cycle 99 documents **two failure
  modes that method is blind to**: fabricated claims about named third parties who then denied
  them (`src-0036` — UBS, the NHS, Swiss Federal Railways, TfL), and references that resolve
  perfectly but **anchor to no claim in the body** (`src-0037` — 7 of 17). The base rate is no
  closer; the *instrument* proposed to measure it is now known to under-count. **A cycle that
  eventually runs that sweep must report it as a dead-link rate, not a hallucination rate.**
- **[278] G3 DISCIPLINE, THE CONVERSE CASE: CHECK WHETHER TWO CONFLICTING-LOOKING NUMBERS ARE
  DENOMINATORS OF THE SAME THING BEFORE OPENING A CONTRADICTION.** The base holds, at source, that
  GPTZero "publishes NUMERATORS ONLY" and withholds its denominator; `src-0034` publishes a
  complete denominator (45 citations). That reads as a flat conflict and it is not one — the
  withheld figure is *reports scanned across the sweep*, the published figure is *citations within
  one report*. This loop has correctly opened contradictions on numeral collisions many times
  (`open_question [7]` is one); **the failure mode in the other direction is opening a spurious
  one and spending later cycles closing it.** Both dispositions require the same work: state what
  each number is a count *of*, in words, before deciding. I recorded the negative decision and its
  reasoning inside `src-0034` `key_claims[2]` so it cannot be rediscovered as a fresh conflict.
- **[279] A T1 THAT UNCOVERS SOMETHING SCORE-RELEVANT MUST WRITE IT DOWN *WITH ITS ALTERNATIVE
  READING ATTACHED*, NOT LAUNDER IT INTO A FINDING.** The KPMG response is near-verbatim in shape
  to EY's, and it is tempting to enter "commercial institutions decline to name a cause" as a
  result. It is not one: two Big Four firms responding alike is equally consistent with *shared
  crisis-communications boilerplate*, and N=3 across two institution types cannot separate those.
  I put **both readings inside `key_claims`** so the alternative travels with the observation
  rather than being reconstructable only from this log — and warned the T2 explicitly that
  restructuring must not promote it. **The rival hypothesis belongs in the durable state; the log
  is not durable enough.**

---

## Carry-forward items — NEW AT CYCLE 98

- **[271] TIE-BREAK 3(c) SYSTEMATICALLY PROTECTS OLD ISSUES FROM NEVER-ATTEMPTED YOUNGER ONES,
  WHICH INVERTS THE APPARENT PURPOSE OF THE ATTEMPT PENALTY.** Cycle 98 is the cleanest
  instance yet. `automated-triage-under-refusal` has `attempts == []` after 98 cycles, is the
  only issue in the graph a single T3 could plausibly move (cycle 97's finding), survived 3(a)
  and 3(b) with a zero penalty — and lost at 3(c) to an issue with **four** recorded attempts,
  on `created_cycle` 16 versus 2. 3(b) exists to push work away from recently-attempted issues;
  3(c) then hands it straight back to the oldest one, which is the most-attempted by
  construction. **The two tie-breaks pull in opposite directions and 3(c) always wins because
  it runs last.** For a human revisiting the design: either 3(c) should be *fewest attempts
  ever* rather than *oldest*, or the never-attempted case needs its own rule. **No cycle may
  patch this from inside the loop.** Cycle 98 applied it as written and said so.
- **[272] THE G2 RULE'S TWO NAMED FORMS DO NOT COVER THE T5 CASE.** `prompts/common.md` says to
  re-check "a supported candidate_resolution or a scored assessment". A T5 enters neither: it
  changes no score and adds no candidate. When a T5's cycle comes up in the round-2 rotation,
  the only conclusion it entered is usually a **contradiction entry** (cycle 89 → `ctr-0048`;
  cycle 98 itself entered none at all). Cycle 98 took the contradiction and recorded the
  stretch rather than skipping the cycle or silently substituting a different predecessor. **A
  successor hitting a T5 predecessor should do the same and say so; a predecessor that entered
  literally nothing should be skipped forward with an explicit note.**
- **[273] A VERBATIM STRING PLACED INTO YOUR OWN QUERY AND ECHOED BACK IS NOT INDEPENDENT
  CONFIRMATION OF THAT STRING.** This is the converse of cycle 97's lesson and completes the
  pair. Cycle 97: a **non-verbatim** name for a printed heading can produce a **false PARTIAL**
  — you lose presences you should have found. Cycle 98: a **verbatim** name supplied in the
  query can produce an answer that merely re-serves your own input — you gain a confirmation
  you did not earn. Cycle 98's Section-4.4 *title* is in this category and the log says so.
  **THE RULE: to confirm a string, ask a question whose answer contains it without the query
  containing it (ask for the title OF section 4.4, not the number OF the section titled X).**
  Sentence-level quotations are unaffected — a render returning a 40-word sentence you asked
  for by its first six words is still good evidence of presence.
- **[274] ar5iv ACCEPTS A VERSION SUFFIX: `ar5iv.labs.arxiv.org/html/<id>v2` RESOLVES AND
  RENDERS.** Established at cycle 98 and previously unknown to this base. This matters because
  cycle 96's versioned-URL rule appeared to force every multi-version fetch onto
  `arxiv.org` + `r.jina.ai`, which would have made the two-render-family discipline ([205])
  unsatisfiable for exactly the papers where staleness is most dangerous. **The two rules are
  compatible.** Use `ar5iv…/html/<id>vN` as the second family for any versioned arXiv check.
  Corollary re-confirmed the same cycle: the versioning rule bites on **ABSENTS**, not on
  presences — cycle 89's unversioned fetch and cycle 98's versioned ones returned identical
  text, and that is what cycle 96 predicted, not a counterexample to it.
- **[275] ON `institutional-incident-real-world-impact`, "QUOTE THE open_questions VERBATIM"
  AND "KEEP THE QUEUE ENTRY UNDER ~15KB" ARE JOINTLY UNSATISFIABLE.** That issue's eight
  `open_questions` total ~30KB — twice the whole budget — because eight cycles have appended
  amendment history to them in place. Cycle 98 sacrificed *completeness of quotation*, quoting
  the operative question sentence of each of the eight verbatim plus the exact jq command for
  the full text, and landed at ~16.5KB. **Whichever a successor sacrifices, say which.** The
  general lesson is upstream of the queue entry: **`open_questions` that accrete amendment
  blocks in place eventually stop being quotable, and an unquotable open question cannot be
  handed to the next cycle by the mechanism this loop uses.** A T2 should consider whether
  amendment history belongs in `candidate_resolutions` rather than inside the question text.

**DISCHARGED AT CYCLE 98:**

- **Cycle 89's written prediction that the next T1 under the rule as written would fall at
  cycle 98** — correct, and now discharged. Nine cycles of ladder arithmetic held exactly.
- **The queue entry's instruction to price [30] against the mechanical policy** — done. The
  answer is that the merit case for `automated-triage-under-refusal` is now the strongest in
  the graph and the policy still eliminates it; see [271].

**STILL OPEN AND UNCLAIMED AFTER CYCLE 98** (restated, not re-argued): `ctr-0048` steps (i),
(iii) and (iv) — step (iii) remains the single highest-yield unclaimed fetch in the base, one
fetch re-grounding three stored `src-0029` quotations. Carry-forward **[4]**, eighty-sixth
cycle, still awaiting a human: `prompts/t4_assess.md` step 3 reads the G3 demotion as a
per-point subtraction, `scripts/validate_state.py` lines 144–156 imposes a flat ceiling of 3;
cycles 76/81/85/88/91/94/96/97 all followed the validator. Carry-forward **[97]** and cycle 97's
**[241]** split of it — settling [97] alone would move `extraction-vs-reasoning-ordinal-axis`
and only that issue.


## Carry-forward items — NEW AT CYCLE 97

**[241] — NEW. Carry-forward [97] must be SPLIT before it can be ruled on.** [97] as written
conflates a **first-order negative** (a negative claim about the world) with a **second-order
coverage claim** (a claim about what this knowledge base contains). The two do not travel together
and a single ruling cannot serve both. Cycle 96's `candidate_resolutions[13]` on
`consistency-calibration-as-failure-mode` is the second kind; that issue's own
`extraction-vs-reasoning-ordinal-axis` neighbour turns on the first kind. **For a human.**

**[4] — UPDATED, not discharged. Eighty-fifth cycle.** `prompts/t4_assess.md` step 3 (per-point
subtraction) vs `scripts/validate_state.py` lines 144–156 (flat ceiling). Re-read at source at
cycle 97 and the disagreement is unchanged. **I followed the validator and said so in all nine
rationales**, as 76/81/85/88/91/94/96 did. Still only a human can settle it.

**[30] — UPDATED: now PRICED, which it was not before.** `automated-triage-under-refusal` is not
merely the least-audited 2 (cycle 94's framing). Its sole candidate **facially meets the level-3
test** on two independent-team sources, and what holds it at 2 is three unresolved contradictions
aimed at that very independence — ctr-0033 affirmatively falsifying a limb of it. **It is the only
issue in the graph where one ordinary T3 cycle could plausibly move a score.** The tie-break, not
the merit, has eliminated it ten-plus times. Still for a T5 to weigh; still not a T4's to override.

**[97] — UPDATED: its prize is smaller than assumed, and now mapped.** Settling [97] alone would
move `extraction-vs-reasoning-ordinal-axis` **and only that issue** (where it cuts *downward*: strict
reading 1, permissive 3, held at 2 by step-5 stinginess). It would **not** move
`consistency-calibration-as-failure-mode`, for two independent reasons — cycle 88's [240] block and
cycle 97's second-order block ([241]).

**[240] — UPDATED: its prize is the larger one.** Settling [240] alone would move
`institutional-incident-real-world-impact` (where [97] does not arise at all) and is a precondition
for `consistency-calibration-as-failure-mode`. **It remains the highest-leverage unmade ruling in
this file — the only one that could move two scores at once.**

**[242] — NEW. The score vector is a one-bit instrument and cannot order nine issues.** All nine
issues cap at 3 under the flat gate and none is below 2, so the range in practice is {2,3}; the only
available transition is held shut by [240]/[97]; and the single non-2 (`ttp` = 3) is a **censored
observation** whose true merit — 3, 4 or 5 — is recorded nowhere and has no field. Cycle 97 wrote
the ordering information into the nine rationales instead, labelling each issue's blocker as a
**missing ruling**, a **missing measurement**, or **dischargeable defects**. This is evaluation data
for the paper: the T5 tie-break has decided every selection since cycle 73 and this is why.

**[243] — NEW. Non-verbatim names for printed headings can produce a false PARTIAL.** Cycle 97
asked the r.jina.ai proxy for columns headed "Correct Accuracy"/"Plausible Accuracy" when the
printed headers are "Correct"/"Plausible" under a spanning "CTI-TAA (Acc)", and got a decline on a
table cycle 87 had extracted in full from the same proxy. **Quote printed strings exactly or expect
a decline.** This is the ctr-0049 defect committed by a T4 against itself; it extends query
discipline rather than contradicting it, and it is a reason **not** to file a render decline as a
contradiction without first checking the query.

**[244] — NEW, cheap and discharged once already.** For any arXiv source, fetch `arxiv.org/abs/<id>`
and read the submission-history list **before** choosing a render URL. Cycle 97 did this for
src-0002 (v1/v2/v3) for one extra fetch and it settled the versioned-URL question outright. Cheaper
than discovering a stale render afterwards, as cycle 96 did.

## Carry-forward items — NEW AT CYCLE 96

**[239] Unversioned ar5iv URLs are VERSION-STALE and must not be used for multi-version arXiv
papers.** Demonstrated at cycle 96, not inferred: `ar5iv.labs.arxiv.org/html/2601.21083` served
**v1** of src-0015 (its abstract is the v1 abstract word for word, with the v1 metric set and no
EGAR) while `arxiv.org/html/2601.21083v3` served v3 minutes apart. Every ABSENT from an
unversioned ar5iv URL is worthless. **Pin the version.** This is *not* a false-ABSENT of the
`ctr-0011` kind — the render was faithful, to the wrong document — and must not be filed as one.
**Open question nobody has spent a fetch on:** cycle 92 recorded `r.jina.ai` as *lossy* on
src-0015; was that episode version staleness of this same kind rather than lossiness?

**[240] Query discipline is NECESSARY AND NOT SUFFICIENT — counts from this tooling are not
evidence.** Cycles 93–95 (`ctr-0049`) located the defect in under-specified queries. Cycle 96
wrote a fully-specified query — exhaustive enumeration demanded, *several/multiple/various*
forbidden, explicit PARTIAL-decline option, total count demanded — and **still** got false
positives, omissions and an unflagged total (`ctr-0051`). **The rule: an enumerated COUNT is not
evidence of a count in either direction; an individual VERBATIM QUOTATION returned by a render IS
good evidence of PRESENCE. Presence is recoverable; counts are not.** Applies retroactively to
every "all occurrences" result in this base. Cycle 96 applied it to its own three sweeps, entering
them as presence/absence findings with counts discarded.

**[241] When a render contradicts a stored, previously-verified quotation, suspect the render
before the record.** One extra fetch at cycle 96 turned a would-be "stored quotation fails
re-verification" report into [239] plus a discharged uncollected job. The converse trap is already
carried as rule (v)/`ctr-0011`; this is its mirror and both are live.

**[242] `open_questions[8]` of `consistency-calibration-as-failure-mode` is CLOSED at cycle 96**
after thirty-four cycles, with two narrow successor jobs named in its closing block so they are
not buried: **JOB A** re-run the src-0014 sweep on a render that reaches the appendices (three
fetches have now failed to render them; every src-0014 ABSENT in this base is body-only), **JOB B**
re-run the src-0016 sweep against `?print=1`, the form that defeated `ctr-0011` on that exact
page. A third, smaller job sits in src-0015's new key_claim: the alleged v1 "95% Wilson CIs for
rates" sentence is still unconfirmed.

**[243] `candidate_resolutions[2]` needs a T2, not a T3.** Cycle 96 discharged its modality
precondition and found the conjunction comes apart — under-refusal triangulated three ways,
overconfidence effectively single-source — but left status at `proposed` because splitting or
rewriting a proposed candidate is a structuring act. **A T2 targeting this issue should split it
in two.** Recorded so the job has a name.

## Carry-forward items — NEW AT CYCLE 95

**[244] The T5 tie-break sequence does not define a total order, and only the winner is safe.**
Interleaving 3(a) (a *partial* order over `depends_on`) with 3(c) (a *total* order over
`created_cycle`) yields **intransitive triples** — at cycle 95,
`attribution-expressed-confidence` ≻ `task-dependent` ≻ `automated-triage` ≻
`attribution-expressed-confidence`. **Rank 1 was unaffected because it was a Condorcet winner
(it beat all eight others pairwise), and a T5 should check that property explicitly rather than
trusting the sorted table.** If a future T5 ever needs a *second* choice — e.g. the top pick is
blocked — the policy is **underdetermined** and that must be reported, not resolved by fiat.

**[245] Update to [242]: budget the queue entry by BLOCKS, before writing, not by sentences
after.** Cycle 94 went 17.5 → 16.5 KB in four turns; cycle 95 went 18.8 → 16.75 KB in **eight**,
and every rewrite-a-paragraph turn recovered under 400 bytes. **The only edits that move the
number are deleting a whole section.** Concretely: a T5's queue entry should carry the phase
check, what the last cycle did, the target's state, the recommended spine, and the tool notes —
and should push the *selection argument* (tie-break readings, carry-forward debates, ranking
tables) into the **log**, where the next T5 will look for it anyway. A T3 does not need to know
how it was chosen.

**[246] A limit a cycle charges against ITSELF is the highest-yield G2 target available.** Cycle
95's G2 cost **one fetch** and converted cycle 86's one-form authorship record into a two-form
one, because cycle 86 had already named the target, the URL and the missing render family. This
is the second consecutive cycle where that pattern paid (cycle 94 did the same for cycle 85's
`src-0029` strings). **When choosing a G2 target, prefer a prior cycle's self-charged limit over
a re-check of a conclusion nobody doubted** — the work is pre-specified and the outcome changes
the state either way.

**[247] Two agreeing renders can strengthen a contradiction rather than resolve it, and the
distinction is ABSENCE vs DISAGREEMENT.** Cycle 95 confirmed `src-0002`'s affiliation field
ABSENT in both render families. That does **not** license the institutional non-affiliation claim
`ctr-0045` impeaches — **absence of evidence in two forms is still absence of evidence.** A
second render can only settle whether a page *says* something, never supply what it does not
carry. **To close an absence-based contradiction you must fetch a DIFFERENT ARTEFACT, not another
render of the same URL** — and a successor that re-renders this URL a third time will learn
nothing new.

## Carry-forward items — NEW AT CYCLE 94

**[239] A render may PARTIALLY DECLINE an all-occurrences demand, and that is a third distinct
failure mode.** Cycle 94 asked `src-0029` for every occurrence of "ECE". The render enumerated
the four **numbered definitions** exactly but answered *"Multiple references"* and *"Extensive
discussion"* for the rest. This is neither the under-specified query of `ctr-0049` nor a
render-family limitation: the query was correctly specified and the render simply summarised part
of its answer. **Treat a partial decline as an UNESTABLISHED COUNT, not as a complete list, and
say so in the entry.** A presence answer for the enumerated part is still self-verifying and can
be relied on; the *count* cannot.

**[240] A hold whose stated reason has expired must be RE-DERIVED, not inherited — and a T4 is
the only task type positioned to notice.** Cycles 85, 88 and 91 all declined to demote
`automated-triage-under-refusal` citing *"ctr-0042's findings are NOT YET VERIFIED DEFECTS."*
Cycle 92 verified one and refuted the other, **expiring the reason without changing the number**,
so nothing in the score vector recorded that anything had happened. Cycle 94 caught it only by
reading the prior rationale's *stated ground* and checking whether that ground still existed.
**Every T4 should do this: for each held score, find the reason the last assessment gave and ask
whether a later cycle has discharged it.** The score can be right for a reason that has died.

**[241] Update to [205]: there is NO fixed ranking between the r.jina.ai proxy and the direct /
ar5iv families.** Cycle 92 found the proxy **lossy** on `src-0015`'s table columns; cycle 93 found
it **self-contradictory within a single fetch** on `src-0003`; cycle 94 found it the **cleaner**
one on `src-0029`, giving *"Roelofs, Cain, Shlens, & Mozer, 2021"* where ar5iv gave the corrupted
`"Roelofs Others."`. Three cycles, three different verdicts. **Use the pair, and record
disagreements as disagreements — never resolve them in either family's favour by default.**

**[242] Rephrasing does not shrink a queue entry; only deleting does.** Cycle 94 overshot
carry-forward [238]'s ~15 KB target, writing 17.5 KB, and spent four turns trimming to **16.5 KB
— still over**. Three of those turns rewrote paragraphs more tightly and recovered under 200
bytes each, because a tighter sentence is not a shorter section. **Budget the prose before
writing, and if over, delete a whole block rather than polishing every block.** The hard
constraint is the Read tool limit, which 16.5 KB is comfortably under, so this cycle's entry is
usable — but the target exists to stop the drift that took cycle 92 to 23 KB.

**[243] `ctr-0044` repair step (iii) is HALF DISCHARGED, and the remainder is precisely stated.**
Cycle 94 performed the second render for the **occurrence/definition-number limb**, which is now
**two-form**. What remains is **only** the string limb: the four definition wordings now recorded
in `state/knowledge/src-0029.md` rest on **one clean render** and are labelled PROVISIONAL. Any
successor quoting them **must say so**, or spend one fetch in a third form to settle them. The
**total occurrence count** in `src-0029` is separately unestablished per [239]. This is a
strengthening item, not a defect: `ctr-0044` is resolved and cycle 87's resolution still holds.

## Carry-forward items — NEW AT CYCLE 93

- **[265] [257] extends to the *presence* side: an under-specified query yields an under-reporting
  answer, and the defect is in the QUERY, not the render.** [257] warned that a single ABSENT is
  weak evidence of absence *because* presence answers are self-verifying. Cycle 93 shows that is
  not protection enough: cycle 84's answer **was** a presence, **was** self-verifying, and was
  **still wrong about the document**, because it asked for *the single* sentence containing `86%`
  and the render obliged. **Ask for ALL OCCURRENCES whenever the *count* matters**, not only when
  an absence is at stake. Two instances in two cycles; treat under-specified retrieval as the
  live failure shape of this era.
- **[266] The `r.jina.ai` proxy contradicted *itself* within a single fetch — and section numbers
  are the least reliable field any render returns.** Strengthens [258] with an independent
  instance on a different source. Asked twice about the same sentence in one call, the proxy gave
  its leading clause two different ways ("Its lowest score…" / "Notably, LANCE's lowest score…")
  and its location as both §5.3 and §5.1.1; the direct render gave §5.1.1 twice and §5.1.3 once.
  **The sentence *body* was identical across all four returns.** Quote bodies; do not cite a
  section number from any render without a second form agreeing.
- **[267] "The log may not exist" is NOT a reliable test for whether a cycle aborted.** The queue
  told cycle 93 to fall back if `logs/cycle-083.md` were missing. It is present — the harness
  commits an aborted cycle's **log** while rolling back its **state**
  (`99dcb09 cycle 83: T3 investigate agent aborted, state reverted`). **Test for the abort with
  `git log --oneline -- <logfile>` and by checking whether the cycle's claimed output is actually
  in the state**, not by `ls`. A fallback's *reason* can hold when its stated *test* fails; say so
  in the log and act on the reason.
- **[268] `state/assessments/scores.json`'s `.scores` is an OBJECT keyed by `issue_id`, not an
  array.** `.scores[0]` fails with `Cannot index object with number`, and `.scores|length` is a
  key count that happens to look like a row count. Use `to_entries`:
  `jq -r '.scores|to_entries|[.[]|(.key+"="+(.value.score|tostring))]|join(" ")'`. Cycle 93 lost a
  call to this. Note that `graph.json`'s `.issues` and `.contradictions` **are** arrays — the two
  files do not share a shape.
- **[269] `Edit`'s read requirement is not satisfied by a Bash `tail`.** Carry-forward [234]'s
  append idiom needs the file opened with the **`Read` tool** first, and these source files exceed
  the tool's size limit ([194]). **`Read` with an `offset` near the end** satisfies the requirement
  without hitting the limit — `Read(file, offset=398)` on a 417-line file was enough.
- **[270] Four `|=` appends through `select()` paths compose in a single `jq -n` two-input
  splice.** [237] is stronger than it has been used: cycle 93 appended to `open_questions`,
  `attempts`, `candidate_resolutions[0].summary` and a contradiction's `.description` — two arrays
  and two strings, in two different top-level collections — in **one** call, then proved all four
  append-only and every sibling byte-identical in **one** more. No need to stage them.

**DISCHARGED THIS CYCLE:** `open_questions[10]`'s successor item (re-ask `86%` as
all-occurrences) — **done, cycle 52 confirmed two-form**. It should not be re-run.

## Carry-forward items — NEW AT CYCLE 92

- **[257] An ABSENT answer is not a finding until it is two-form — and the second form must be
  tried *before* filing, not after.** Cycle 82 filed `ctr-0042` Defect 2 on a single ABSENT; cycle
  92 refuted it **at the same URL in the same render family**. Presence answers are self-verifying
  (they produce the sentence); absence answers are not. When a prompt asks "quote every sentence
  defining X" and gets ABSENT, re-ask **naming the candidate sentence** — that is what worked here.
  This is now the single most repeated failure shape in this base's history alongside
  figure-derived numbers.
- **[258] The `r.jina.ai` proxy is NOT the more faithful render, and carry-forward [205] should
  never be read as saying so.** On `src-0015` the proxy returned **five** of Table 1's **seven**
  column headers and dropped the "OpenSec:" title prefix, while the direct `arxiv.org/html` render
  matched cycle 82 exactly. Use the pair, and **record disagreements as disagreements** rather than
  resolving them in the proxy's favour. The proxy's value is that it is a *different* renderer, not
  a *better* one.
- **[259] To build a JSON object in `jq` with no braces at all, assign onto `null`.**
  `null|.id="ctr-0051"|.issue_id="..."|.description=$s.text|.opened_cycle=93|.resolved_cycle=null`
  yields a well-formed entry **in the assigned key order**. This solves the half of carry-forward
  [227] that the array-of-labelled-strings idiom did not reach: [227] told us how to *read* without
  braces, [259] tells us how to *write* without them. Cycle 92 appended `ctr-0049` and `ctr-0050`
  in one call this way.
- **[260] Sweep counts must be taken by `jq` over the parsed JSON, not by Grep line counts.**
  `graph.json` holds whole paragraphs on single lines, so Grep's `-c` **understates**: it reported
  4 line-hits in `graph.json` where `jq` found 6 occurrences, and it cannot tell you *which object*
  they sit in. The `jq` form —
  `[.issues[]|select(tojson|test("PHRASE"))|.id+"="+((tojson|[splits("PHRASE")]|length-1)|tostring)]`
  — localises every hit to an issue id in one call.
- **[261] A contradiction filed against one `issue_id` is invisible to cycles working on any other
  issue.** `ctr-0042` impeached a formulation that had already propagated to
  `consistency-calibration-as-failure-mode`, where it read as supported. **When a contradiction
  impeaches a *form of words* rather than a number, sweep for that form of words across all issues
  before closing the entry** — and file separately against every issue that carries it, because
  there is no cross-issue index.
- **[262] Refuting a defect can *strengthen* the underlying critique.** Cycle 82 said the 82.5 % FP
  rate had an unknown denominator; the denominator turned out to be stated, and stating it
  **affirmatively refutes** the candidate's per-decision gloss instead of merely failing to license
  it. Do not treat "the prior cycle was wrong" as equivalent to "the prior cycle's concern was
  unfounded" — re-derive the concern against the corrected premise before withdrawing anything.
- **[263] The `created_cycle` tie-break can permanently starve a late-created issue.** Nothing in
  the selection policy rewards *never having been investigated*; 3b penalises recent attention but
  there is no counterweight. `automated-triage-under-refusal` (`attempts == []`, created 16) has now
  lost repeatedly to issues created at cycle 2. **For a human to rule on.** Any cycle that
  overrides the policy on merit must say so explicitly in its log and must not do it silently.
- **[264] Budget the prose of a queue entry BEFORE splicing quotations into it.** Cycle 92's first
  assembly came out at 23.4 KB against carry-forward [238]'s ~15 KB and had to be rewritten; the
  final entry is 17.7 KB, a stated overshoot. `ioc-extraction-reliability` now carries **eleven**
  `open_questions` totalling **27,921 characters**, which no longer fit verbatim in any queue entry.
  Quote a fixed prefix, give the exact `jq` retrieval command, and **warn that truncated quotes
  reverse themselves** — this issue's `[5]` is called FALSE AS WRITTEN by `[6]`, and `[8]`'s
  provenance complaint is corrected in `[9]`.

## Carry-forward items — NEW AT CYCLE 91

**[250] A ZERO-FETCH LEXICAL SWEEP OVER AN ISSUE OBJECT COSTS ONE `jq` CALL, AND THE "SWEEPS
ARE EXPENSIVE" ASSUMPTION IS NOW EMPIRICALLY DEAD.** `ctr-0036` step (ii) had stood undone
since cycle 77 — flagged by cycles 81 and 88 as unverified exposure, called "the highest-value
step" by the entry itself, and explicitly marked as needing no fetch. It took one `jq` call
over one issue object. **Several other contradictions carry sweep steps sitting on the same
tacit cost objection**: `ctr-0036` step (iv), `ctr-0038` steps (ii) and (iii), `ctr-0040` step
(i). A T4 may not perform them. The next T1 or T3 that reaches those issues should.

**[251] A SWEEP THAT COMES BACK CLEAN IS EVIDENCE ABOUT ITS SCOPE AND NOTHING ELSE — AND IT
CUTS IN THREE DIFFERENT DIRECTIONS ON THREE DIFFERENT ISSUES.** Finding `ttp` clean of the
`src-0007` `Attribution` equivocation does **not** mitigate the *confirmed* instance on
`extraction-vs-reasoning` (a defect established at source is not weakened by being rare), does
**not** mitigate `attribution-confident-wrong-gap` where `ctr-0036` was opened, and **does**
raise the value of the one remaining unswept site. Write the direction into each rationale
explicitly; a bare "the sweep came back clean" will be misread as good news everywhere.

**[252] THE SAME DEFECT SHAPE CAN CUT BOTH WAYS, AND ONE FALSIFICATION DOES NOT MAKE A
PRESUMPTION.** Cycles 89 and 90 both examined *silently truncated stored quotations* on the
same issue. At 89 the omitted continuation **falsified** the reason built on it (`ctr-0048`);
at 90 four omitted continuations were neutral or **reinforcing**, two of them upgrading the
candidate. So carry-forward [244] — a claim that a source is silent may not be made from a
stored excerpt — is vindicated as **a rule about what needs checking**, and **not** as a
presumption that stored excerpts are wrong. Do not demote on the shape alone.

**[253] THE SCORE VECTOR HAS BEEN BYTE-IDENTICAL FOR EIGHTEEN CYCLES, AND THIS IS A SECOND
POLICY DEFECT DISTINCT FROM [4].** With a flat G3 ceiling of 3 and a level-3 bar requiring the
primary candidate to rest on two independent sources, **this evidence base can express at most
two distinct values**, and it expresses them 8-to-1. Since cycle 73 the state gained 5 sources,
opened 15 contradictions and resolved 4, and not one of those events moved a score. The
tie-break, not the score, is the whole selector. **Do not fix this by inflating** — step 5
forbids it and inflation breaks the selector further. It needs a human, separately from [4].

**[254] A `resolved_cycle` FLAG IS NOT A CLOSED QUESTION — READ THE CAVEATS BEFORE THE COUNT.**
`ctr-0018` was resolved at cycle 90 and the entry itself records **three** binding caveats: the
probe is lexical, the archive render is known non-exhaustive, and the fetch over-answered. This
graph now holds 13 resolved entries of 48. A future T4 tempted to read the resolved count as a
health metric should read the entries first.

**[255] BASH: EVEN A TRAILING `echo "exit=$?"` AFTER A `jq` CALL IS REFUSED AS A
MULTI-OPERATION COMMAND.** Cycle 91 lost a turn to it. Issue one command per Bash call and read
`jq`'s own output for success. `jq -e .` prints nothing and returns cleanly on valid JSON, which
is signal enough.

**[256] THE RATIONALE BLOCK MARKERS IN `scores.json` ARE NOT UNIFORM.** Some read
`===== CYCLE-88 (T4)` and others `===== CYCLE 81 (T4)` — hyphen versus space — so
`index("===== CYCLE-81")` silently returns the *file head* offset instead of the block. Match
on `CYCLE` plus the number and check both forms; better, use
`[match("CYCLE[ -]?[0-9]+ \\(T[0-9]\\)";"g")]` to list every block offset at once. To read all
nine current blocks, redirect a `jq` map into a scratch `.txt` **inside the repo** and `Read`
that file — the per-call output limit will otherwise truncate you.

---
## Carry-forward items — NEW AT CYCLE 90

**[245] THE RENDER PAIR DOES NOT MERELY CORROBORATE — IT CATCHES ARTEFACTS THAT LOOK EXACTLY
LIKE FINDINGS.** A single direct fetch of `gptzero.me/investigations/ey` returned "0 of 27
references hallucinated", which conflicts head-on with a figure this base has held since cycle
12. The `r.jina.ai` render exposed it as a **JavaScript odometer** (`0 1 2 3 4 5 6 7 8 9%
Hallucinated`, with `27` absent from the page entirely). **One fetch would have produced a
wrong contradiction entry, and it would have looked entirely reasonable.** Rule: *use the pair
on any page whose numbers you intend to store*, not merely on quotations about to become
load-bearing. Cycle 89's version of this rule was too narrow.

**[246] A TOOLING LIMIT IS NOT A CONTRADICTION.** G3 asks for *two supported claims in
conflict*. When the competing item is "my renderer cannot read the widget", there is one claim
and one limitation. **A render that cannot read a tile cannot impeach the outlet that reported
it.** Cycle 90 declined to file on this and parked it as an open question with the routes that
would settle it. Filing would have dressed a tooling limit as a finding, which is the failure
mode this loop is supposed to catch, not commit.

**[247] THE CYCLE-89 RULE HELD, AND IT CUT THE OTHER WAY.** Re-fetching the neighbourhood of
four stored excerpts found that **all four** were truncations — but every omission was neutral
or reinforcing, and two of them *upgraded* a claim from inference to printed text. **Fetching
the neighbourhood is not a defect hunt; it is a completeness check, and it can strengthen.**
The correct output when it strengthens is a recorded pass, **not** a contradiction filed to
keep a count moving.

**[248] `state/knowledge/index.json` HAS CROSSED THE `Read` TOOL LIMIT.** It reached ~260KB at
cycle 90 and now joins `graph.json` (~840KB) and `scores.json` (~450KB). **All three must be
read through `jq`.** Carry-forward [194] needs updating to name three files, not two.

**[249] A REAL jq TRAP IN THE APPEND-ONLY PROOF.** `$N.open_questions[0,1,2,4,6] ==
$O.open_questions[0,1,2,4,6]` does **not** compare two lists — jq takes the **cartesian
product** and emits 25 booleans, most of them `false`, which reads as a catastrophic diff and
nearly cost a cycle. Build **explicit arrays**: `[$N[0],$N[1],$N[4]] == [$O[0],$O[1],$O[4]]`.

**[250] THE CONTRADICTION KEY ORDER IS NOT UNIFORM ACROSS `graph.json`.** `ctr-0001` returns
`id,issue_id,opened_cycle,resolved_cycle,description`; `ctr-0018` returns
`id,issue_id,description,opened_cycle,resolved_cycle`. Cycle 89's handoff asserted one order as
*the* schema and was wrong for at least one existing entry. **Check the entry you are actually
touching**, and do not "fix" either — append-only edits preserve whatever order an entry has.

**[251] A SINGLE-QUOTED, MULTI-LINE jq PROGRAM IN ONE `Bash` CALL WORKS.** Cycle 90 spliced ten
graph edits across ten lines in one call. This is easier to author and audit than the
escaped-double-quote form the handoffs have been recommending, and `$s`/`$t` inside single
quotes are passed to jq literally, which is exactly what the two-input splice idiom wants.

**[252] A URL FETCHED REPEATEDLY FOR CONFIRMATION IS NOT A COLLECTED SOURCE.**
`gptzero.me/investigations/ey` was fetched at cycles 12, 13, 31 and 54 and never entered the
base, so for 78 cycles the EY incident rested entirely on secondary coverage while the primary
artefact sat one fetch away and *already known to be reachable*. **When a fetch is worth making
four times, ask why it is not a source.** Worth a sweep: are there other repeatedly-fetched,
never-collected URLs in the logs?

**[253] `src-0032` AND `src-0012` ARE NOT INDEPENDENT.** Primary and secondary of *one*
finding. They do **not** together satisfy any rubric's "two independent sources", and a T4 must
not count them as two.

**[254] A LEXICAL ABSENCE PROBE IS NOT A CONCEPTUAL ONE, AND THE DIFFERENCE MUST TRAVEL WITH
THE RESULT.** Cycle 90's `slop` probe defeated the rule (xvii) substitution that beat cycle 59
precisely *because* it was anchored on a literal token — but that anchoring is also its limit:
it cannot exclude the same fact phrased in other words. **Pair a lexical probe with a
conceptual one on a different form**, and state which one carries which half of the warrant.

---

## Carry-forward items — NEW AT CYCLE 89

- **[244] A CLAIM THAT A SOURCE IS SILENT ON SOMETHING MAY NOT BE MADE FROM A STORED
  EXCERPT; IT REQUIRES A FETCH OF THE EXCERPT'S NEIGHBOURHOOD.** A stored excerpt is
  evidence of what a source says and evidence of nothing about what it does not say.
  Established by `ctr-0048`: cycle 87 asserted a `src-0029` sentence "says NOTHING ABOUT
  WHY" from a fragment stored at cycle 78, and the immediately preceding sentence — never
  fetched by any cycle — was the why. **The claim was true of the base as stored and
  false of the source.** This is the sharpest instance yet of the [241] overstatement
  pattern.
- **[245] THE REFRESH RULE AS WRITTEN FIRES EVERY 21 CYCLES, NOT EVERY 7, AND THE LOOP
  HAS NEVER FOLLOWED IT CONSISTENTLY.** `prompts/t5_select.md` step 4 fires a T1 only
  when a cycle is both a T5 (period 3) and ≡ 0 mod 7, so the true period is lcm(3,7) =
  **21**, a factor of three off `config.yml`'s "every Nth cycle" gloss. Corroboration:
  the three T1s this loop has run were cycles **14, 41, 78**, and only 14 satisfies the
  written rule. **Cycle 89 followed the written rule and scheduled no T1; the next one
  under it falls at cycle 98.** Fixing this means editing `config.yml` or
  `prompts/t5_select.md` and is outside a T5's remit.
- **[246] TIE-BREAK 3(a) IS SETTLED AS PAIRWISE, NOT GLOBAL IN-DEGREE** — closing the
  alternating reading recorded at [233]. The text's object is "**its** dependents", a
  possessive that restricts the relation to pairs joined by a `depends_on` path; issues
  with no dependents are untouched by 3(a) and fall through to 3(b). The rejected global
  reading would make the ranking a fixed function of graph topology, returning
  `consistency-calibration-as-failure-mode` every cycle forever and permanently ranking
  the three isolated issues last.
- **[247] TIE-BREAK 3(c) IS A WEAK DISCRIMINATOR AND THE POLICY HAS NO STEP (d).** Six of
  the nine issues share `created_cycle: 2`. At cycle 89 this was survivable only because
  the 3(b) window (taken as the five *completed* cycles, 84–88) charged
  `ioc-extraction-reliability` +1 for its cycle-84 attempt; under an 85–89 window the
  selection between `ioc-extraction-reliability` and
  `institutional-incident-real-world-impact` would have been **formally unresolvable**.
  A future T5 hitting a genuine 3(c) tie has no policy to appeal to.
- **[248] THE SELECTOR HAS NO TERM FOR EVIDENTIAL DEPTH, AND THAT IS THE INSTRUMENT
  FINDING.** `ioc-extraction-reliability` (six investigations, six open contradictions,
  eleven open questions) and `automated-triage-under-refusal` (**zero** investigations in
  89 cycles, one candidate, five open questions) both score 2, and no step of the policy
  separates them on how much is known: 3(a) makes both maximal, 3(b) is a recency proxy
  that **penalises the audited issue and spares the unaudited one**, and 3(c) is birth
  order. Cycle 89's log states plainly that the instrument, not judgement, chose its
  target, and that on merit it would have chosen `automated-triage-under-refusal` —
  eliminated for the **eleventh** time (cf. [30]).
- **[249] STORE THE FULL SENTENCE, OR MARK THE TRUNCATION: STRIPPING A LEADING
  CONJUNCTION HIDES A MID-SENTENCE EXCERPT.** `src-0029`'s Section 4.4 sentence was
  stored as "It is good practice to use them together…" when the original reads "**Thus,**
  it is good practice to use them together… **of the probabilities produced by a model.**"
  Once the conjunction is dropped and the next word capitalised, the fragment is
  typographically indistinguishable from a whole sentence and three later cycles could
  not have detected it from the file. This is the storage-side twin of [244].
- **[250] `ctr-0048` STEP (iii) IS THE CHEAPEST UNCLAIMED REPAIR IN THE BASE: ONE FETCH
  RE-GROUNDS THREE STORED QUOTATIONS.** `src-0029`'s Section 4.1 half-bin-width sentence,
  Section 3.1 decomposition sentence and Section 3 strictly-proper sentence all came from
  the **same truncated cycle-78 fetch** and **none** has had its neighbourhood read. Given
  [249], all three are candidates for the same defect.
- **[251] THE UNCLAIMED ONE-FETCH REPAIR QUEUE, CARRIED FORWARD INTACT AND NOW SIX
  ITEMS LONG.** None has been claimed: `ctr-0008` step (i) on
  `attribution-confident-wrong-gap` (the oldest undone repair in the graph, 60 cycles);
  `ctr-0018` step (iii) on `institutional-incident-real-world-impact` (**assigned to
  cycle 90**); `ctr-0043` steps (iii)+(iv) on `attribution-expressed-confidence-unmeasured`
  (step (iv) is also `ctr-0024` step (ii), so one fetch fixes both limbs of one
  candidate); `ctr-0047` steps (i)+(ii) on `ttp-attack-mapping-reliability` (**zero**
  fetches needed); `ctr-0048` steps (i)–(iv) on `consistency-calibration-as-failure-mode`.
  **This queue, not the source count, is why cycle 89 judged the evidence base not to be
  the binding constraint** — see [245].

## Carry-forward items — NEW AT CYCLE 88

- **[240] Settling carry-forward [97] alone would not move `consistency-calibration-as-failure-mode`,
  and no cycle had noticed.** Granting [97] lets `candidate_resolutions[12]` part (1) count, and
  that part is genuinely two-source (src-0001 + src-0018) for the *existence* of run-to-run
  instability on CTI material at temperature 0. But cycle 76 read the level-3 bar as requiring
  the primary candidate to answer **both conjuncts** of the issue title, and the calibration
  conjunct is single-source however [97] is settled. **A second question must also be settled:
  must a primary candidate span both conjuncts of a two-conjunct issue title, or does a
  fully-evidenced half suffice?** Unresolved policy; needs a human. Live on
  `consistency-calibration-as-failure-mode` and `institutional-incident-real-world-impact`.
- **[241] This loop's supported candidates fail provenance audits exactly when they overstate
  their own checking, and pass when they hedge it.** Cycle 88's G2 passed cleanly on a candidate
  that wrote its own limits down ("…was NOT re-examined at cycle 80"), breaking a four-cycle
  streak (ctr-0043/44/45/46) in which every failure was an *overstatement*: "two independent
  fetches" (one render family), "unaffiliated" (only disjoint names shown), "Neither source
  names ECE" (false on both limbs), an eleven-fold absence that does not fit fourteen recorded
  items. **The defect is a writing habit, not a research habit.** Actionable now, by any cycle:
  when entering a candidate, state what was *not* checked.
- **[242] `institutional-incident-real-world-impact` and `consistency-calibration-as-failure-mode`
  are pinned by the SAME structural fact, and this base has offered them DIFFERENT remedies.**
  Both have a conjunctive title with one well-evidenced half and one silent or single-source
  half; both are held at 2 by the both-conjuncts reading of the level-3 bar. The proposed
  remedies are a **T2 split** for the first and a **[97] policy ruling** for the second, and no
  cycle has ever noticed they are one problem. If the both-conjuncts reading is wrong, **both
  unpin with no split and no new evidence**; if it is right, the split is the only route for
  both. A T2 contemplating the split should settle the reading first.
- **[243] `with_entries(.value.FIELD = VALUE)` sets one field across every entry of a jq object
  in ONE clause and contains no brace constructor**, so it survives this session's shell
  (carry-forward [227]). Cycle 88 set `assessed_cycle = 88` on all nine scores with it instead
  of nine separate assignments.
- **[244] A single `rationale` in `scores.json` is now 41–66 KB and overflows the Bash tool's
  output limit.** Slice it instead: `jq -r '.scores["id"].rationale | .[(index("===== CYCLE-NN")):]'`
  returns just the block for cycle NN. Cycle 88 read all nine current blocks in three calls
  this way. Note also that **assessment blocks now sit at BOTH ends** of every rationale —
  cycle 76 wrote at the head, cycles 85 and 88 append at the tail — so a reader must check both.
- **[245] The `collect_refresh_every: 7` rule has two readings and no cycle has ever ruled.**
  The last T1 was cycle **78** (`grep -l "T1 collect" logs/cycle-0*.md` → 014, 041, 078 only).
  Under "cycle number mod 7" no T1 is due at 89; under "at most 7 cycles between T1s" one is
  overdue by four. Whichever T5 acts next should record its reading so the rule is inherited.

## Carry-forward items — NEW AT CYCLE 87

- **[238] QUEUE-ENTRY LENGTH IS NOW A MEASURABLE COST, AND CYCLE 86 IS THE DATA POINT.** Its
  `next_task.json` was **82,268 bytes** — past the Read tool's ~25,000-token limit, so cycle 87
  spent four Bash calls paging it with `cut -c` before starting. Roughly a fifth of it re-spliced
  material authoritative elsewhere: the target issue's ten `open_questions` **verbatim** (jq
  reads them in one call) and a restatement of the carry-forward catalogue (which lives in the
  log). **Proposed rule: a queue entry carries (a) the phase check, (b) what changed and where to
  verify it, (c) the decisions the next cycle must make, (d) pointers — and nothing that jq can
  fetch in one call.** Cycle 87's entry is **16,039 bytes** and is complete under that rule. This
  is a *proposal*, not a ruling: no prompt file sets a length policy, and a human may reasonably
  prefer the redundancy. **Do not treat it as settled.**
- **[239] JQ: YOU CAN SET FIELDS ON AN OBJECT WITHOUT AN OBJECT CONSTRUCTOR.** Carry-forward
  [227] says a brace-comma-brace construct is eaten by shell brace expansion. The workaround when
  a scratch-file object is missing keys is to **pipe and assign**:
  `'$s.ctr0046 | .opened_cycle = 87 | .resolved_cycle = null'`. That is how `ctr-0046` got its
  two numeric keys after I omitted them from the scratch file. Cheaper than rewriting the scratch
  file.
- **[240] THE APPEND-ONLY PROOF NEEDS A DIFFERENT SHAPE WHEN YOU *MODIFY* AN ARRAY ELEMENT.**
  Resolving a contradiction changes an element **inside** the array, so the carry-forward [221]
  prefix test (`old == new[0:len(old)]`) **fails by design** and will look like a violation.
  Correct proof: (a) the arrays are identical after **filtering the modified element out** of
  both, and (b) the element is identical after `del()` of exactly the fields you changed. Cycle
  87 ran both.
- **[241] THE FOUR-FOR-FOUR PROVENANCE PATTERN, AND IT IS EVALUATION DATA FOR THE PAPER.**
  `ctr-0043` (84), `ctr-0044` (85), `ctr-0045` (86), `ctr-0046` (87): **four consecutive G2
  passes, four defects, all four in the provenance layer of a claim whose direction survived.**
  This loop's supported candidates are reliable about the world and unreliable about their own
  audit trail. **Whether this should affect scores at all has never been ruled on.** A T4 that
  thinks it should must argue it explicitly rather than quietly pricing it in.
- **[242] THE CHEAPEST CHECK ON A STATED ABSENCE IS OFTEN THE REST OF THE SAME PARAGRAPH.**
  `candidate_resolutions[10]` asserted *"Neither source names ECE"* in paragraph (2) and *"Both
  sources impeach the binned ECE estimator"* in paragraph (5). Cycles 79–84 all read past it. The
  gloss in (5) is ours, not a quotation, so they are not *formally* contradictory — but the
  tension was visible at zero cost for six cycles.
- **[243] `ctr-0044` STEP (iii) IS UNDONE AND IS NOT DISCHARGED BY THE RESOLUTION.** One fetch in
  a clean render family over `src-0029` (arXiv 2112.10327) to recover the **exact Section 4.2–4.4
  definition strings**, which are **still not established and still must not be quoted** — the
  ar5iv render carried visible noise (*"Roelofs Others."* for *"Roelofs et al."*). Also still
  one-form: `src-0029`'s ECE occurrences (ar5iv only) and `src-0028`'s ranking ABSENT (PMLR PDF
  via `r.jina.ai`, taken twice, cycles 78 and 87).
- **[244] `ctr-0046`'s FOUR STEPS.** (i) **done** — the second-family confirmation exists and is
  stored. (ii) **no fetch**, and it belongs to **the next T3 targeting
  `attribution-confident-wrong-gap`**, not to a T3 on another issue: amend
  `candidate_resolutions[0]`'s provenance clause to say what is true (five same-family pulls at
  cycles 23 and 28, plus one `r.jina.ai` PDF confirmation at 87). (iii) **no fetch, and it is the
  step with reach**: a two-string Grep sweep for *independent* / *independently confirmed* /
  *two independent fetches* used as a provenance guarantee anywhere in the graph, each checked
  against the fetch budget in the log of the cycle that ran it. (iv) **one fetch**: put the
  not-printed question to an `arxiv.org/html` render to turn this cycle's one-form ABSENT
  two-form.
- **[245] FIFTEEN OF `src-0002`'s TWENTY-FIVE VERIFIED CELLS ARE STILL SINGLE-RENDER-FAMILY.**
  Cycle 87's second-family pull was scoped to CTI-TAA. The CTI-MCQ, CTI-RCM, CTI-VSP and CTI-ATE
  columns have still only ever been read on `arxiv.org/html`. One fetch would close it, and the
  `r.jina.ai`-over-`arxiv.org/pdf/2406.07599` render is known to work and to self-report COMPLETE.
- **[246] A PMLR OR arXiv PDF FETCHED WITHOUT THE `r.jina.ai` PREFIX RETURNS UNPARSEABLE BINARY.**
  Cycle 85 recorded this for arXiv; cycle 87 wasted a call learning it again for PMLR. **Always
  prefix.** Per carry-forward [202] the failed render is **not** an ABSENT and must be discarded,
  not recorded.

**Latent policy conflicts still awaiting a human, passed on verbatim:** **[4]** the G3
subtraction-versus-ceiling conflict, now in its **seventy-sixth** cycle and capping all nine
issues, with `ioc-extraction-reliability`'s six open contradictions as the standing reductio;
**[11]**; **[30]** the `created_cycle` tie-break, which has eliminated `automated-triage-under-refusal`
**ten** recorded times while it remains **the only issue never investigated in eighty-seven
cycles** and carries three open contradictions from three separate G2 passes that all found
something; **[41]**; **[55]** withdrawn at cycle 49, see **[112]**; **[75]** the incomplete
tie-break ladder, which bound again at cycle 86 and was broken by a *labelled judgment call*
rather than an invented rule for the first time; **[97]** whether a non-commensurability or
**negative** finding may itself count as a resolution — live on four issues, with a sibling in
`ctr-0042` step (v), and now in its **seventh** consecutive cycle of making
`consistency-calibration-as-failure-mode`'s best work unscoreable; **[172]–[237]**; and **[233]**
the two incompatible readings of tie-break 3(a), on which cycle 86 ruled **for its own
application only** and which remains unresolved policy.

## Carry-forward items — NEW AT CYCLE 86

- **[237] The two-input jq splice idiom — use it, it needs no `--arg` and no object
  constructor.** `jq -n 'input as $s | input as $t | $t | (.sources[] | select(.id=="src-0002")
  | .key_claims) += [$s.src0002_key_claim]' scratch.json state/knowledge/index.json > out.json`
  then `mv out.json state/knowledge/index.json`. A path expression through `select()` is a
  valid **assignment target** in jq, so you can append into one element of a 31-element array
  without rebuilding the file. **Double quotes are legal inside a single-quoted jq program**;
  it is the **braces** that shell-expand (carry-forward [227]).
- **[238] Writing `state/queue/next_task.json` — a cleaner route than cycle 85's.**
  Carry-forward [235]'s deadlock (Write refuses to overwrite an unread file; Read refuses a
  file over ~25k tokens) is better broken by **writing a scratch file at a new path and `mv`ing
  it onto the queue path** than by moving the old entry out first — it never leaves the queue
  path empty, and the old entry survives in git regardless.
- **[239] Before opening a contradiction, check the target issue's score against the G3
  ceiling.** `scripts/validate_state.py` lines 144–156 fail the run if an issue with an open
  contradiction scores **above** `scale_max − g3_contradiction_demotion = 3`. Cycle 86 checked
  this before filing `ctr-0045` on an issue scoring exactly 3. The `key_claims` gate, by
  contrast, only checks for **removals**, so an addition is always safe there.
- **[240] `ctr-0045` — `ttp-attack-mapping-reliability` `candidate_resolutions[1]` claim (a).**
  Direction re-confirmed at source; grounding and strength defective. Four repair steps, of
  which **(ii)** is a one-fetch affiliation recovery from
  `ar5iv.labs.arxiv.org/html/2406.07599` and **(iii)** is a **no-fetch** check of whether the
  identical overstatement sits on the **PRISM/LANCE limb** of the same claim (no cycle has ever
  recorded `src-0003`'s author list either). Not to be worked unless a later T5 selects that
  issue.
- **[241] `src-0002` still has NO recorded venue.** Its arXiv Comments and Journal-reference
  fields are both ABSENT as of cycle 86, while `src-0007` is a TMLR-accepted paper (cycle 53).
  The two sit on opposite sides of several comparisons in this graph and **no cycle has ever
  weighted them by evidential standing** — this is the same unacted-on observation cycle 53
  made about `ctr-0001`.
- **[242] Tie-break [75] bound again at cycle 86 and was broken by a *labelled judgment call*
  rather than by an invented rule, for the first time.** The basis was a fact already in the
  state (`institutional-incident-real-world-impact` is pinned at 2 pending a **T2** split, per
  cycles 72/81/85), **not** a new ordering principle. **Do not cite it as precedent.**
- **[243] A T2 scope review on `institutional-incident-real-world-impact` is now overdue on
  the record of four separate cycles (72, 81, 85, 86).** Cycle 86 used that issue's pinned
  status as the reason to route work *away* from it, which makes the unperformed split the
  direct cause of its continued neglect. That is a self-reinforcing loop and a human should
  see it.

## Carry-forward items — NEW AT CYCLE 85

- **[236] A jq precedence trap that cost cycle 85 a turn, and it bites on exactly the check a T4
  and a T5 both run.** In
  `map($new.scores[.].rationale|startswith($old.scores[.].rationale))` the `.` **rebinds after
  the `|`**, so the second `.` is the *rationale string*, not the key; jq fails with
  `startswith() requires string inputs`. **Bind the key first:**
  `map(. as $k | $new.scores[$k].rationale|startswith($old.scores[$k].rationale))`. This bites on
  every append-only proof over an object keyed by issue id.
- **[237] For an arXiv paper, try `ar5iv.labs.arxiv.org/html/<id>` FIRST and do not spend a fetch
  on the PDF.** At cycle 85 `arxiv.org/abs/<id>v3` returned **HTTP 404** and `arxiv.org/pdf/<id>`
  returned **unparseable binary** (2.9 MB, the fetch tool cannot decompress PDF streams), while
  ar5iv rendered the full text cleanly. Two fetches wasted learning this. Extends carry-forward
  [205].
- **[238] `ctr-0044`'s four repair steps** — (i) a **no-fetch** correction append to
  `consistency-calibration-as-failure-mode` `candidate_resolutions[10]` marking *"Neither source
  names ECE"* `DO NOT CITE` and re-grounding paragraph (2); (ii) a **one-fetch** all-occurrences
  ECE question against `src-0028`, to settle whether the conjunction fails on one limb or both;
  (iii) a **one-fetch** second-render-family confirmation that also recovers the exact §4.2–4.4
  definition strings, **which cycle 85 explicitly did not establish**; (iv) **the step with
  reach, a strengthening rather than a repair** — decide whether `[10]`'s core methodological
  claim can be **re-grounded on `src-0029`'s already-stored §4.4 "use them together" sentence**
  instead of on the Bregman inference, making the claim *quotational* rather than *derived* and
  retiring paragraph (2)'s whole apparatus.
- **[239] Two arithmetic/bookkeeping corrections cycle 85 made to cycle 81's rationale blocks,
  by appending and not by erasing.** (a) The per-point-subtraction reductio is **5 − 12 = −7**,
  or **2 − 12 = −10** from the merit score — **not −12**. (b) `ctr-0038` is the
  **METRIC-COMPARISON CONFLICT** (F1 vs precision) on `ioc-extraction-reliability`; the
  normalised-rubric-mean-versus-F1 question is **`ctr-0040` step (iv)**.
- **[240] The handoff-audit result for cycle 84's queue entry: substantially clean, one
  miscount.** It states `attribution-expressed-confidence-unmeasured` *"now carries TWO"* open
  contradictions; it carries **four** (`ctr-0024`, `ctr-0029`, `ctr-0034`, `ctr-0043`). **Its
  conclusion — ceiling 3 before, 3 after — is correct and unaffected**, because under a set
  comprehension the count never mattered. All eight confirming checks, both abort-test warnings
  and all five named misreadings were correct as written. **Eighth substantially clean handoff
  in fifteen cycles.**
- **[241] Every ceiling in this graph is now 3.** All nine issues carry ≥ 2 open contradictions.
  A future T4 should state this once rather than re-deriving it per issue, and should not read a
  newly opened contradiction on an already-contradicted issue as a demotion.
- **[242] The rubric is coarse at the bottom and it is now the binding limitation on this whole
  loop.** Eight of nine issues sit at exactly **2**, spanning `automated-triage-under-refusal`
  (one candidate, one source, never investigated in 85 cycles) and
  `institutional-incident-real-world-impact` (nine source ids, eight candidates, structurally
  pinned by its own title's conjunction). **The weakest-link selector this rubric exists to feed
  cannot distinguish them**, which is why carry-forward [30] has recurred nine times. Related to
  but distinct from [4] and [97]. **Needs a human.**

## Carry-forward items — NEW AT CYCLE 84

- **[234] To append to a markdown file, use the Edit tool, not `cat >>` or a heredoc.** Set
  `old_string` to the file's last unique line (find it with `tail -n 4`) and `new_string` to that
  line plus the new section. Worked first call on both `src-0003.md` and `src-0019.md`.
- **[235] The Write-requires-Read / Read-refuses-oversize deadlock on `next_task.json`, and how to
  break it.** The Write tool refuses to overwrite a file it has not read; the Read tool refuses a
  file over ~25,000 tokens. `state/queue/next_task.json` reached 57KB this cycle and hit both.
  **`mv state/queue/next_task.json scratch<NN>.json` first** — the Write tool then treats the path
  as new and accepts it, and the old entry survives in the scratch file until you delete it (and in
  git regardless). Also: **keep the entry short enough that the next cycle can Read it.**
- **[236] A negative finding can be right for the wrong artefact, and that is a distinct defect
  shape.** `ctr-0043`: an absence confirmed in the *scorer* was used to support a claim about what
  the benchmark *elicits*, which only the *prompt* file can settle. When a claim is about model
  behaviour, ask which file would contain the behaviour before sweeping strings.
- **[237] A source's own "one cheap unfinished step" is a standing G2 target and this loop ignores
  them.** src-0019 flagged `model-prediction.ipynb` at cycle 43 and **thirty-five cycles passed**
  before anyone read it — while a supported candidate leaned on the gap. A cheap sweep: grep the
  `# Limitations` sections of every `src-*.md` for self-flagged unfinished steps and work the list.
- **[238] Two mirrors under different repository owners are a genuine second render family for a
  code artefact**, and cheaper than the r.jina.ai proxy. `aiforsec/cti-bench` and `xashru/cti-bench`
  discharged rule (v) for `model-prediction.ipynb` in one extra fetch. Reuse wherever a file is
  mirrored.
- **[239] The precision-floor identity `P ≥ F1/(2−F1)` earns its keep — but check the *whole*
  interval, not just whether the point estimates fall inside it.** `ctr-0038` said the comparison
  was undetermined; it is undetermined for **three** of src-0007's four models and **determinate**
  for the fourth (0.6944 < 0.7544). An entailed interval can still decide some of the comparisons
  it is invoked to block.
- **[240] `jq -e .` passing is not schema conformance, and *noticing* a schema defect is not
  repairing it.** `ctr-0033` was missing two of five required keys from cycle 74; cycles 81 **and**
  82 both verified the defect and **neither fixed it**, each passing it on as somebody else's
  two-key append. Cycle 84 fixed it. If a defect is a two-key append, do it in the cycle that
  notices it.
- **[241] An "84%" carried for 75 cycles turned out to be a derivation, not a quotation, and the
  file itself showed it** — the neighbouring 99% was inside quotation marks and the 84% was not.
  **Quotation marks in the stored `src-*.md` files are load-bearing punctuation.** Where a figure
  sits outside them, treat it as underived until you find its source sentence.

---

## Carry-forward items — NEW AT CYCLE 82

- **[233] THE LOOP HAS BEEN ALTERNATING BETWEEN TWO INCOMPATIBLE READINGS OF TIE-BREAK 3(a) SINCE
  CYCLE 71 AND NOBODY NOTICED. NEW, AND IT IS A POLICY CONFLICT AWAITING A HUMAN.** Cycle 64
  **rejected in writing** the reading that ranks issues by *number* of dependents (P3, "an
  unratified ad-hoc patch from cycle 61", which "would nullify 3(b) on any graph with dependency
  structure and flat scores"). Cycle 71 applied the **pairwise** reading and recorded [211] saying
  the prompt's wording supports it. **Cycles 74 and 77 then both selected
  `consistency-calibration-as-failure-mode` on "unique maximum at three dependents" — the rejected
  reading — without citing or addressing either cycle 64 or [211].** At cycle 82 the two readings
  select **different issues**: dependent-count would have taken `consistency-calibration` for the
  **third selection running, two cycles after its own attempt**, which is the exact thrashing 3(b)
  exists to prevent. **Cycle 82 applied pairwise and says so.** Consequence for the paper:
  **logs 74 and 77's ranking tables are not commensurable with logs 71 and 82's.** A human must
  rule.
- **[234] TWO WRONG CELLS IN CYCLE 74's RANKING TABLE, FOUND INCIDENTALLY.** It records
  `created_cycle` **3** for `consistency-calibration-as-failure-mode` and **12** for
  `institutional-incident-real-world-impact`; `graph.json` says **2** for both (12 is
  institutional's first *attempt*, not its creation). Not outcome-determining at cycle 74 — that
  selection was decided at 3(a) — but the ranking tables are declared evaluation data, so errors in
  them are findings.
- **[235] `ctr-0042`'s FIVE REPAIR STEPS, ONLY (i) DONE.** (ii) in-place annotation of
  `automated-triage-under-refusal` `candidate_resolutions[0]`, marking that "locates the defect
  precisely" overstates an unquantified sentence. (iii) **a two-string Grep sweep needing no
  collection** — `not in detection but in restraint` and `Detection accuracy is fine` — to find how
  far the unmeasured separation propagated; it must include `state/knowledge/src-0015.md`, whose
  *"OpenSec **finds**"* sentence is already a known second site, and `scores.json`. (iv) **a
  one-fetch T1 item** that would both harden two one-form absences via `r.jina.ai` **and** enter
  the verbatim blast-radius definition — *"Blast radius is the ratio of false positive to correct
  containment actions per episode."* — which this base does not hold at all. (v) may an unmeasured
  but thrice-repeated authorial claim support a **candidate**, or only an **open question**? A
  sibling of [97]; no cycle has ever ruled.
- **[236] THE FP-RATE DENOMINATOR IS UNKNOWN AND THE BASE HAS NEVER SAID SO.** src-0015's
  82.5 / 65 / 57.5 / 45 % have been carried since cycle 16 with **no definition in the paper**
  (verified ABSENT at source, cycle 82). Until (iv) above is run, those figures should be read as
  quantities of **unstated denominator**, not as per-decision misfire rates — which is how
  `automated-triage-under-refusal`'s sole candidate glosses them.
- **[30] — NINTH RECORDED ELIMINATION, AND THE COST IS NOW MAXIMAL.**
  `automated-triage-under-refusal` was eliminated again by `created_cycle` (16 against 2). It is
  **still the only issue never investigated in eighty-two cycles**, and **three separate G2 passes
  have now examined its sole candidate and all three found a defect** (`ctr-0021`, `ctr-0033`,
  `ctr-0042`). Cycle 82's own G2 found two more defects in it **hours before the ladder threw it
  out again**. Count caveat inherited from cycle 74: instances from the sixth onward are inherited,
  not re-audited.
- **[75] — BOUND AGAIN, AND THE INVENTED RULE HAS NOW DECIDED TWO SELECTIONS.** The ladder ran out
  on a two-way tie (`ioc` vs `institutional-incident`: both effective 2, both `created_cycle` 2,
  both unpenalised, neither outranked). Cycle 82 used cycle 71's **least-recently-attempted**
  extension (65 vs 72) and marks it as a **choice, not policy**. It is still not in the prompt.
- **[189] — DORMANT AGAIN AT CYCLE 82, AND CHECKED RATHER THAN ASSUMED.** Windows `[77..81]` and
  `[78..82]` give identical penalty columns: the only near-boundary attempt is
  consistency-calibration's cycle 80, inside both. Cycle 82 used `[78..82]`.
- **[4] — THE REDUCTIO IS NOW ON THE SELECTED ISSUE.** `ioc-extraction-reliability` carries **six**
  open contradictions, so under the per-point subtraction reading of `g3_contradiction_demotion` it
  would sit at **−10** on a 0–5 scale. The validator implements the ceiling reading. Seventy-first
  cycle awaiting a human.
- **[205] — NOT EXERCISED AT CYCLE 82 AND INHERITED ON CYCLE 80's AUTHORITY.** The `r.jina.ai`
  second-render technique would have hardened both of `ctr-0042`'s ABSENT findings in one fetch and
  was not run. Charged, not credited.
- **[228]/[211] (scratch-JSON + jq multi-file splice) — RE-CONFIRMED.** Two scratch files (graph,
  queue) worked exactly as described; the queue object was built by **field assignment onto the
  prior entry** to avoid the brace-expansion trap [227], and the ten `open_questions` were spliced
  from `graph.json` by jq with zero transcription.

---

## Carry-forward items — NEW AT CYCLE 81

- **[233]** `ctr-0041`'s four repair steps. (i) done (the entry itself). (ii) **not done** —
  a T3 should annotate `candidate_resolutions[7]`, `open_questions[2]` **and
  `state/knowledge/src-0026.md` key claim 3** in place, in the preserve-original-wording
  style, restating the 26/492 disambiguation as *conditional on the v1.0 footnote count* and
  naming the undocumented December revision as why the condition cannot be discharged from
  the base as it stands. (iii) **not done, and it is the highest-value single fetch in this
  graph** — try `https://www.enisa.europa.eu/sites/default/files/2025-12/ENISA%20Threat%20Landscape%202025_v1.1.pdf`
  and near variants, by analogy with the src-0027 path. If it resolves it is a **T1
  collection, not a citation**; if it 404s, **record the negative**. (iv) **not done** —
  decide whether the undocumented v1.0→v1.1 revision should become a candidate on this
  issue's response half, noting it currently rests on a URL-path inference plus one ABSENT.
- **[234]** **`ctr-0033` is schema-malformed and has been since cycle 73.** It carries only
  `id, issue_id, description` and is missing `opened_cycle` (should be 73) and
  `resolved_cycle` (should be null). Cycle 81 verified this and deliberately did **not**
  repair it — not a T4's edit, and the validator's `.get("resolved_cycle") is None` still
  counts it as open, which is correct. A T2 or T3 should add the two keys. This is the entry
  cycle 80's queue note referred to as "cycle 74 appended a contradiction with only three of
  five required keys"; the attribution to cycle 74 is off by one, the defect is real.
- **[235]** **An undocumented ENISA revision has been sitting in this base since cycle 72 and
  no cycle noticed.** src-0027 is an ENISA-served **v1.1** PDF at a `/2025-12/` path, while
  src-0010's landing page returns **ABSENT** when asked whether any revision notice bears a
  version other than 1.2 (cycle 56, asked directly). That is evidence on
  `institutional-incident-real-world-impact`'s *response* half — "retain, patch, disclose
  mechanically" now has a third mode, **"and one revision not disclosed at all"** — and it
  points **upward**. Not scored on at cycle 81 because a T4 assesses and does not
  investigate.
- **[236]** **Bash:** a jq program passed inside a **double-quoted** shell string with
  backslash-escaped inner double quotes was **rejected outright, twice**, while the identical
  program in a **single-quoted** shell string with plain inner double quotes ran first time.
  **Single-quote every jq program.** Cost cycle 81 two calls.
- **[237]** **jq:** inside `map(...)`, an expression like `$old.scores[.key]` fails, because
  the argument of a filter such as `startswith` is evaluated against *its own* input (the
  string), not against the map element. **Bind the element first:** `map(. as $e | …)`.
- **[238]** **A `_cycleNN_note` idiom worth keeping:** `scores.json` now carries
  `_cycle73_note`, `_cycle76_note` and `_cycle81_note`. Three T4s in a row have used it and
  it is the cheapest way for a successor to read "what did the last assessment actually
  decide" without pulling four 40 KB rationales. Keep adding one per T4; never delete an
  older one.
- **[239]** **Two unswept exposures, recorded so a future T4 does not read cycle 81's holds
  as clean bills of health:** `ttp-attack-mapping-reliability` cites src-0007 and has never
  been swept for ctr-0036 propagation sites (ctr-0036 step (ii) is claim-scoped and
  unfinished); and `attribution-expressed-confidence-unmeasured` has never been checked for
  whether it inherited the "Attribution" framing at the cycle-45 split (ctr-0036 step (iv)).
  Neither is a finding. Both are places a T3 should look.
- **[240]** **Carry-forward [97] was priced, not resolved, at cycle 81.** Under the rubric as
  written a negative is not a candidate resolution, so cycle 80's three substantive negatives
  on `consistency-calibration-as-failure-mode` were scored at **zero weight**. That is a
  rubric limitation, not a judgement that the work was worthless — a well-established
  impossibility result is exactly what stops successors buying the same dead end a fifth
  time. It remains the single policy question whose settlement would move the most scores in
  this graph, and it needs a human.

## Carry-forward items — NEW AT CYCLE 80

- **[231] A SWEEP CONDUCTED BY FILE IS NOT A SWEEP CONDUCTED BY CLAIM.** `ctr-0036` step (ii)
  names `state/issues/graph.json` among the files cycle 77 examined, yet `ctr-0040`'s defect
  sits in that file. A 700 KB single-line JSON contains hundreds of independently-authored
  claims; "I examined that file" means almost nothing about it. **Enumerate claims.** The
  `jq … [scan(".{0,130}TERM.{0,130}")][]` idiom makes this cheap and is the concrete remedy.
- **[232] A STOPPING RULE THAT HALTS ON INTERVAL WIDTH DESTROYS THE INFORMATION THE INTERVAL
  WOULD OTHERWISE CARRY.** A variable-`n` design that runs until the CI is narrow enough pins
  the reported width *at the threshold by construction*; since half-width scales as spread ÷ √n,
  the spread is recoverable only if `n` is disclosed. **A fixed-`n` interval and a
  stopping-rule interval are not the same kind of object**, and two studies reporting "CIs" may
  be reporting quantities with different information content. This is what turned `ctr-0035`
  step (iii) from a not-found into a deductive negative.
- **[233] REMOVING THE GROUND FOR A RETIREMENT DOES NOT REINSTATE THE RETIRED CLAIM.** When a
  correction is found to rest on a refuted premise, the correct status is **UNDETERMINED**, not
  a reversion to the pre-correction position. Cycle 80 had to state this in capitals inside
  `candidate_resolutions[1]` because it is the most natural mistake for the next reader to make.
- **[234] `ECE/Brier` AS A COMPOUND LABEL IS WRONG ON BOTH HALVES AND HARMLESS ALMOST
  EVERYWHERE IT APPEARS.** ECE is not a proper scoring rule; Brier is not a pure calibration
  measure. But ~16 sites in this base use the compound only to enforce a **non-pooling
  prohibition** against a third construct, and that prohibition survives any correction to
  either half. **Do not repair these.** This is [230] instantiated: the string is everywhere,
  the defect is in four places.
- **[235] THE `r.jina.ai` PROXY IS A DIFFERENT RENDER FAMILY FOR ORDINARY HTML, NOT JUST FOR
  PDFs.** Carry-forward [205] scoped it to PDF-only sources. At cycle 80 it returned a sentence
  from an ordinary SentinelOne blog page that the direct fetch did not, and it is now the
  cheapest way to turn a one-form ABSENT into a two-form confirmed absence **on any page**.
- **[236] WHEN YOU EXTEND SOME ARRAY ELEMENTS AND APPEND A NEW ONE, THE WHOLE-ARRAY PREFIX
  CHECK CORRECTLY RETURNS FALSE.** Check extended elements with `startswith` and untouched ones
  with a `del(...)` comparison. Do not read that `false` as an append-only violation.
- **[237] CHECK THE ADJACENT CLAIM BEFORE FILING IT.** Cycle 80 drafted a fifth Tier-1 Brier
  site (`index.json` src-0001 `key_claims[4]`) and found on inspection that it is **already
  corrected in-file** by the appended `[7]` and `[8]`. Filed as *not a defect* and explicitly
  marked not-to-be-re-litigated. The mirror of [198]: a correction can also have *already
  happened* where a sweep expects to find damage.

## Carry-forward items — NEW AT CYCLE 79

These five are added by this cycle. **Every item from `logs/cycle-078.md` is reproduced
verbatim below them**, copied mechanically with `sed`, including the ones I could not
act on. Update items you discharge; do not delete them.

- **[226] `jq --arg` IS REJECTED OUTRIGHT BY THIS SESSION'S BASH TOOL**, with "Shell
  expansion syntax in paths requires manual approval", **even when the value is a plain
  kebab-case string containing no brackets**. This **supersedes carry-forward [219]**,
  which recorded the rejection only for values containing square brackets. The true rule
  is broader: do not use `--arg` at all. Inline the string literal into the `jq` program.
  Cost when discovered: two turns.

- **[227] A `jq` PROGRAM CONTAINING AN OBJECT CONSTRUCTOR IS ALSO REJECTED** by the same
  guard, because `{a: 1, b: 2}` looks like shell brace expansion. Emit an **array of
  labelled strings** and `join` it instead of an object. Cost when discovered: one turn.
  Cycle 79's twelve-check append-only proof is written this way and works.

- **[228] THE ONE-SCRATCH-FILE, SINGLE-QUOTES-ONLY AUTHORING CONVENTION.** Write **one**
  scratch JSON file holding every new string and object for the whole cycle, keyed by
  name, using **single quotes for all verbatim quotations** so that no double quote and
  no backslash ever appears in a string body. The file is then hand-authorable with the
  Write tool with **zero escaping**, validates with `jq -e .`, and splices in one atomic
  pass with `.field += $s.key` for string appends and `.field += [$s.obj]` for array
  appends. This base's existing entries already use single quotes for verbatim, so the
  convention costs nothing. It removes the last hand-escaping step that carry-forward
  [211]'s `jq -Rs .` variant still required. **Delete the scratch file before finishing.**

- **[229] A DEDUCTIVE REPAIR IS ONLY AS GLOBAL AS THE COMPARISONS IT WAS APPLIED TO.**
  When a contradiction names a confound that bears on **two** comparisons and a later
  cycle eliminates it on **one**, the entry must say **which one** — otherwise the
  repair is inherited as global and the surviving half becomes invisible. `ctr-0001`
  names the METRIC confound and frames its conflict in two forms (against `src-0003`'s
  97.6% F1 *and* against its 86% VirusTotal baseline); cycles 21 and 35 eliminated it
  deductively for the 97.6% form only; both entries record it as "ELIMINATED" without
  qualification; and the 86% half stood unexamined for **forty-four cycles** until
  `ctr-0038`. This is the tenth instance of carry-forward [198]'s pattern and a sharper
  statement of carry-forward [220].

- **[230] AN ENUMERATION OF A STRING IS NOT AN ENUMERATION OF A DEFECT.** `ctr-0037`
  step (iii) asked cycle 79 to "GREP THE WHOLE STATE FOR THE STRING `0.8240-0.8846`" as
  a way of finding every site carrying a defective four-model range. Executed literally
  it **over-collects**: most sites carrying that string use it legitimately — scoped to
  the three non-mini models, or in a context where substituting the true floor of 0.6944
  would only strengthen the argument (`ctr-0010`), or listing all four values correctly
  (`ioc-extraction-reliability` `candidate_resolutions[1]`). It also **under-collects**
  if run on one phrasing only: the same defect appears as "the identical models on the
  identical corpus through the identical harness reach 0.8240-0.8846". When writing a
  repair step of this shape, name the **claim** to be found, not the **string**, and
  require the executor to read each hit.

---

## Carry-forward items

**New at cycle 78:**

- **[223]** `state/queue/next_task.json` has outgrown the **Read tool**. Cycle 77's entry
  was 59,729 bytes / ~26,700 tokens against a 25,000-token cap, and Read refuses it *even
  with offset/limit* because the whole entry is one line. Read it with
  `sed -n "6p" state/queue/next_task.json | cut -c1-3000` and successive ranges; five such
  calls read it whole. `Grep -o` on `^  "[a-z_]+":` finds which line holds the instructions.
- **[224]** **An open contradiction on a claim is not a quarantine and does not mean the
  claim has been audited.** `ctr-0009` sat on this exact sentence from cycle 33, quoted it
  in full, and still missed both of ctr-0037's defects. Re-check claims that already carry
  a contradiction instead of treating them as handled.
- **[225]** **When a correction prescribes replacing a sentence, check whether the headline
  number survives the replacement.** ctr-0009 prescribed a repair that silently changes a
  3× claim to 2.4×, and nobody noticed for 45 cycles.

**Discharged or advanced this cycle:** [210] (grepping distinctive strings before choosing
a G2 target stopped a duplicate filing of ctr-0009); [213] (refused to enter a "5.5%
run-to-run variance" figure a search summary attributed to src-0030 that the fetched
document does not contain); [214] (zero-fetch G2 again); [205] (the raw-PDF failure mode
reproduced exactly, and the r.jina.ai proxy fixed it); [221] (append-only proof run on both
edited files, four silent diffs); [211] extended with a whole-object splice variant needing
no escaping at all. `open_questions[6]` limb (b) moved from *never searched* to *partly
answered*. `ctr-0036` step (ii) **partly** discharged, still open for the remaining files.

The inherited chain follows, copied mechanically from `logs/cycle-077.md` lines 248–3327
with `sed`, including the items I could not act on. Note that the inherited text contains
several further `## Carry-forward items` headings — an artefact of the chain copying itself
forward each cycle, not a structural error.

## Carry-forward items

**New at cycle 77:**

- **[220] A CORRECTION'S SCOPE IS NOT ITS ISSUE.** `ctr-0008` fixed the `Attribution`-equivocation
  in `candidate_resolutions[2]` of `attribution-confident-wrong-gap` at cycle 30 and left the
  identical one in `candidate_resolutions[1]` of the *same issue* standing for **forty-seven
  cycles**, with the correcting fact already stored two files away. **After any correction, grep the
  whole issue — not just the entry you were re-verifying — for the corrected phrase.** Eighth
  instance of [198].
- **[221] PROVE APPEND-ONLY MECHANICALLY, NOT BY INSPECTION.** Dump the file *minus* the array you
  appended to, before and after, and `diff -q`; then dump the array's pre-existing slice from the
  new file and `diff -q` it against the old array. Two commands, and it converts "I was careful"
  into a proof. Cycle 77 got IDENTICAL on both.
- **[222] A TIE-BREAK AMBIGUITY RECORDED AS "INERT" CAN BECOME OUTCOME-DETERMINING WITHOUT
  WARNING.** Cycle 74 tested [75]/[64] and found the outcome invariant; cycle 77 found the two
  readings select **different issues**. **Re-test invariance every cycle rather than inheriting the
  finding.** The same applies to [189], which cycle 77 found live on a second issue after its own
  queue entry asserted it was live on only one.
- **[223] `jq -Rs .` CONVERTS PLAIN TEXT TO A JSON STRING** and removes the last hand-escaping step
  from the [211] multi-file splice: write prose as plain text with no JSON escaping at all, convert,
  then splice. This entire cycle's 59,500-character queue entry was built that way with zero
  transcription risk.
- **[224] THE SANDBOX REFUSES `/tmp`.** This session's Bash tool refuses to read or write **any**
  path outside `/home/runner/work/SPIRAL/SPIRAL`, and that includes `/tmp`. Put scratch files in the
  repo root and delete them before finishing.

**Inherited chain, copied mechanically from `logs/cycle-076.md` lines 236–3286:**

## Carry-forward items

**New at cycle 76:**

- **[216] ATTACK A CANDIDATE'S OWN SELF-DECLARED WEAK LEG.** ctr-0034 established that an
  honest self-scoping flag reads as reassurance to later cycles. The converse is a cheap
  targeting heuristic: a candidate that names its own weakest leg has done the G2's
  selection work. Cycle 76 took leg (2) precisely because the candidate said the absence
  rested on one URL form — and one fetch converted it into a two-form confirmation.
- **[217] EVIDENCE ENTERED ONLY INTO `graph.json` IS INVISIBLE TO GREP-BASED
  RETROSPECTION.** Cycle 68 put a verbatim source quotation into a candidate_resolution and
  into neither the knowledge file nor its own log. Every technique this loop uses to find
  un-re-verified conclusions — including carry-forward [210], which found this one — greps
  `logs/` and `state/knowledge/`. A quotation that lives only in the issue graph is
  effectively unauditable. **A T3 entering a verbatim quotation must write it to the
  source's knowledge file in the same pass.** Repair named in the handoff.
- **[218] `ar5iv.labs.arxiv.org/html/<id>` IS A GENUINELY DISTINCT RENDER FAMILY** from
  `arxiv.org/html/<id>v1`, and is the cheapest way to turn a one-form ABSENT into a
  two-form confirmed absence under rule (v). Both returned complete, untruncated documents
  that transcribed appendix prompts verbatim; neither needed the r.jina.ai proxy.
- **[219] A `--arg` VALUE CONTAINING SQUARE BRACKETS IS REJECTED BY THIS SESSION'S BASH
  TOOL** with "Shell expansion syntax in paths requires manual approval". Put long prose in
  a scratch JSON file and read it with `jq`'s `input` instead.
- **[97] IS NOW LIVE ON FOUR ISSUES AT ONCE** — `consistency-calibration-as-failure-mode`,
  `attribution-expressed-confidence-unmeasured`, `attribution-confident-wrong-gap` and
  `institutional-incident-real-world-impact` all now hold a supported candidate whose
  substance is a negative or non-commensurability finding, and on each of them that is a
  stated reason the score cannot rise. **This is the single policy question whose
  resolution would move the most scores in this graph.** It awaits a human.
- **A punctuation-only difference between a stored quotation and a fetch model's rendering
  is a quoting artefact, not a discrepancy** — record the mechanism, not the model's
  yes/no. (Cycle 75's `p-hat-c` / `p^sec` caption note is the same shape on a math
  subscript.)

**Inherited chain — reproduced verbatim from `logs/cycle-075.md` below.**

## Carry-forward items

**New at cycle 75:**

- **[213] A SEARCH-ENGINE SUMMARY IS NOT A SOURCE READ**, even when the source's own URL is sitting
  in the result list. A search returned confidence-scoring prose adjacent to a src-0018 result that
  the direct fetch shows is **not in src-0018**; crediting it would have inverted this cycle's
  finding (2) and made a behavioural-uncertainty source into a verbalized-confidence source. Verify
  at the page, always. This is the search-engine analogue of carry-forward [202] (a non-responsive
  fetch answer is not an ABSENT).
- **[214] PREFER THE ZERO-FETCH ITEM WHEN ONE IS AVAILABLE.** Cycle 75's most valuable result — the
  outlier-row finding that closed `open_questions[6]` limb (c) outright — was pure arithmetic on
  cells already in the base and cost **no fetches**. It is the only kind of work that cannot fail on
  a sandbox block, a paywall, an IdP gate or a truncated render. Cycle 74's queue entry recommended a
  fetch-based route as best value; the free one paid better. **Scan the open questions for arithmetic
  and Grep-answerable items before spending a fetch.**
- **[215] A DEGENERATE-LOOKING CELL BLOCK MUST BE RECORDED AS PRINTED AND EXCLUDED FROM THE HEADLINE
  FIGURE.** src-0013's Sampling-based Consistency block reads ECE exactly 0.00 in all eighteen cells.
  That is not a plausible measurement of perfect calibration across three models and six
  temperatures. Cycle 75 entered it verbatim, declined to interpret it, and kept the robust
  elicitation-span figure at **0.56** rather than the headline-grabbing **0.81** it would license.
  Record such blocks; do not build a claim's headline on them; say which figure is robust and why.
- **[216] A REPAIR STEP OPENED AND DISCHARGED IN THE SAME CYCLE NEVER ENTERS THE BACKLOG.** Cycle 75
  opened ctr-0035 and then performed its step (ii) itself, amending the entry so no successor redoes
  it. The backlog's oldest member (ctr-0008 step (i)) is in its **45th** cycle; the marginal cost of
  doing a cheap step now is far below the cost of it surviving forty cycles as a queue-entry line
  item. **If a repair step you are opening is cheap and you have turns, do it before you write it
  down.**
- **[217] GREP THE STATE, NOT THE PRIOR CYCLE'S CLAIM, WHEN CONFIRMING A STEP WAS DONE.** Before
  resolving ctr-0026, cycle 75 checked its step (ii) at **file level** (`Sampling-based Consistency`
  present in `src-0013.md` ×4 and `index.json` ×1) rather than trusting cycle 62's assertion that it
  was discharged — because cycle 52 found ctr-0014's step (i), *recorded as done at cycle 43*, had
  never been performed. The assertion verified this time. **The check is one Grep and it is what
  makes a resolution trustworthy.**

**Discharged or updated at cycle 75:**

- **[210] (grep the logs for a candidate's distinctive numbers before choosing it as a G2 target)** —
  **EXERCISED AND VINDICATED.** One Grep for `0.81` returned only `logs/cycle-062.md`, identifying a
  never-re-verified load-bearing target in a single turn. Keep.
- **[211] (jq multi-file `input` splicing)** — **EXTENDED TO WHOLE-CYCLE ATOMIC EDITS.** Cycle 75
  added three candidate_resolutions, appended to four open_questions and to `attempts`, resolved one
  contradiction and opened another **in a single jq invocation**, then validated and `mv`'d. This
  sidesteps both the 256KB Read limit and the Edit-anchor problem entirely. Use `.field += $x` to
  append rather than restate — that satisfies the append-only rule *mechanically* instead of by
  careful typing.
- **[212] (`jq -e .` validates syntax, not schema)** — **OBSERVED.** Key checks were run on the new
  contradiction and on all ten candidate_resolutions after every edit.
- **[205] (the r.jina.ai proxy)** — unchanged and still valid, but **not needed this cycle**: plain
  `arxiv.org/html` and `ar5iv` fetches both returned complete untruncated documents that transcribed
  tables cell-for-cell. Try the direct form first on arXiv **HTML** renders; reach for the proxy on
  `/abs`, on PDFs, and after a suspicious ABSENT.
- **[97] (whether a non-commensurability or NEGATIVE finding may itself count as a resolution)** —
  **SHARPLY LIVE AGAIN.** Cycle 75's finding (2) and ctr-0035 are both negative / non-commensurability
  findings on the issue the next T4 must score. Still awaits a human.
- **[4] (the G3 subtraction-versus-ceiling conflict)** — now in its **64th** cycle, still capping all
  nine issues, still awaiting a human.
- **[30] (the `created_cycle` tie-break)** — `automated-triage-under-refusal` remains **the only issue
  never investigated in 75 cycles**.

Everything below this line is reproduced mechanically from `logs/cycle-074.md` per the standing
instruction, **including the items this cycle could not act on**.

---

## Carry-forward items

**New at cycle 74:**

- **[209] A NARROWED G2 IS NOT A PARTIAL CLEARANCE OF THE REMAINDER.** A G2 that correctly scopes
  itself and honestly flags what it did not check leaves any defect in the unchecked part standing
  *behind* the flag — and the flag reads as reassurance to every later cycle. `ctr-0029` step (iv)
  said in terms "do not read this as impeaching the whole candidate"; the unimpeached half contained
  an independent defect (`ctr-0034`). **When a prior correction names what it did not check, that
  name is a work item, not a clearance.** Seventh instance of the "a correction can carry its own
  new defect" family — see [198].
- **[210] GREP THE LOGS FOR A CANDIDATE'S DISTINCTIVE NUMBERS BEFORE CHOOSING IT AS A G2 TARGET.**
  Cycle 74 lost two turns aiming at a conclusion that cycles 25, 39 and 62 had all already
  re-derived. One `grep -rln "<a distinctive figure>" logs/` settles it. "Long-standing" is not the
  same as "unchecked".
- **[202] EXTENDED:** an arXiv `/abs` URL fetched plainly returns the **abstract page only** and
  yields a **false ABSENT** on every content question. Cycle 74 discarded such a render rather than
  recording it. Use the proxy for arXiv content.
- **[205] SCOPE EXTENDED:** `r.jina.ai` was known to unblock ENISA's PDFs; cycle 74 confirmed it
  also returns **complete arXiv papers including appendices**, on two URL forms. The 4.3MB
  truncation limit found earlier still stands.
- **[211] `jq` MULTI-FILE `input` SPLICING.** `--rawfile`/`--slurpfile` are blocked by this
  session's Bash tool but plain multi-file `input` is **not**:
  `jq -n 'input as $a | input as $b | …' scratch.json state/issues/graph.json > out.json` splices
  stored text into a new file with **zero transcription drift**. This is the clean answer to
  "quote the open_questions verbatim". Delete the scratch file afterwards.
- **[212] `jq -e .` VALIDATES SYNTAX, NOT SCHEMA — AND THIS LOOP HAS BEEN TELLING ITSELF THE WRONG
  THING ABOUT IT.** Successive queue entries have recommended "validate with `jq -e . <file>` after
  every edit" as *the* post-edit check. It is necessary and **not sufficient**: cycle 74 appended a
  contradiction with only three of the five keys `_schema` requires and `jq -e .` passed it clean.
  The gate that would have failed is **schema discipline (hard rule 4)**, and the cycle would have
  been reverted. **After any hand-authored append, check the keys:**
  `jq -r '.contradictions[-1] | keys_unsorted | join(",")'` must return
  `id,issue_id,description,opened_cycle,resolved_cycle`. The same applies to any object appended to
  `issues[]`, `candidate_resolutions[]` or `scores`. **The risk is highest exactly where this loop
  is most productive** — long hand-written `description` fields where the prose crowds out the
  bookkeeping tail.
- **[30] UPDATED:** `automated-triage-under-refusal` eliminated at tie-break (a) for the
  **seventh recorded time** (six inherited, not re-audited by cycle 74, plus this one), while
  remaining **the only issue never investigated in seventy-four cycles** (`attempts == []`) — and
  the first G2 ever pointed at it (cycle 73) found a real defect immediately. **Awaiting a human.**
- **[75] UPDATED:** the tie-break ladder ran out **twice** this cycle — `ioc` vs `task-dependent`
  (2/1/0/created 2) and `extraction-vs-reasoning` vs `automated-triage` (2/0/0/created 16). Neither
  touched the winner. Fourth recorded exhaustion.
- **[189] INERT AGAIN AT CYCLE 74**, and verified rather than assumed: only one attempt (cycle 72)
  falls inside any five-cycle window, and it falls inside both readings.
- **[4] UNCHANGED, SIXTY-THIRD CYCLE:** the G3 subtraction-versus-ceiling conflict. All nine issues
  carry at least one unresolved contradiction and are therefore capped at 3; the cap binds on
  exactly one entry. Under the subtraction reading the graph total would be 1 rather than 19.
- **`ctr-0034`'s repair steps (ii)–(v) are UNDONE**, of which **(iii) is a two-string Grep sweep of
  `state/` for `determinacy` and `lack sufficient detail` that needs no collection**, and (iv) is a
  one-fetch settlement of the Section 4.2-versus-3.4 attribution.
- **`ctr-0029` step (ii) — the `misp-project.org/taxonomies.html` fetch — is now MORE valuable, not
  less:** `ctr-0034` impeached the CTIBench limb of that candidate's constructive half, leaving the
  two-axis design idea as the only unimpeached part, and that idea's definitional content lives in
  the taxonomy document. **One fetch.**

**Everything below is inherited from `logs/cycle-073.md` and copied mechanically, including items
that cycle 74 could not act on.**

## Carry-forward items

**New at cycle 73:**

- **[207] THE DECORATIVE LIMB.** A long, hortatory candidate summary can carry a rhetorical
  intensifier that is never load-bearing, never checked, and false — as `automated-triage-under-refusal`
  `candidate_resolutions[0]` did for fifty-seven cycles with "different years", while naming
  the correct years in its own adjacent parentheticals. **The rule that follows: an independence
  claim must be scored on its weakest *verified* limb, not on the number of limbs or evidence ids
  asserted.** Applied this cycle to `ioc-extraction-reliability`, `attribution-confident-wrong-gap`,
  `attribution-expressed-confidence-unmeasured` and `task-dependent-reliability-framing`, each of
  which has a candidate whose evidence array looks like a level-3 candidate and is not one.
- **[208] A G2 FAILURE THAT OPENS NO CONTRADICTION NEVER REACHES THE GRAPH.** Cycle 71's
  construct-validity failure on `extraction-vs-reasoning-ordinal-axis` `candidate_resolutions[1]`
  leg (2) lives only in `logs/cycle-071.md`. A T4 scoring from the graph alone would never see it.
  Either such failures should open an entry, or T4s must read the intervening logs — and no rule
  currently says which.
- **[209] `ctr-0033` repair steps (ii), (iii), (iv) are undone.** Step (iii) is a two-string Grep
  sweep of `state/` for `different years` and `different teams, different task framings`, needing
  no collection; step (ii) is an in-place annotation replacing the withdrawn limb with the
  author-list disjointness already verified at source in `ctr-0033`.
- **[210] The graph misstates its own contradiction membership.** `ctr-0032` names `ctr-0012` as
  open against `institutional-incident-real-world-impact`; `ctr-0012.resolved_cycle` is 59, and the
  omitted open member is `ctr-0025`. Corrected in `ctr-0033`'s text and in the score rationale, but
  `ctr-0032`'s own description still carries the error and is append-only.

**Everything below is inherited from `logs/cycle-072.md`, copied mechanically and unedited.**

## Carry-forward items

**New at cycle 72:**

- **[204] A TRUNCATED render's ABSENT is void beyond the visible portion and must be scoped,
  not flattened.** src-0025 and src-0026 produced the *same* ABSENT on the *same* question,
  and they are worth very different amounts: one render was untruncated and one stopped at
  §7 of 13. The state now records them differently and explicitly forbids upgrading the
  weaker one. The direct-PDF fetches earlier in the same cycle returned confident ABSENTs
  from *binary object code* — a reminder that a summarising model will answer ABSENT about
  content it never saw.
- **[205] The `r.jina.ai` proxy unblocks PDF-only sources, and this loop did not know it.**
  Direct WebFetch returns PDF binary; the local Read tool cannot render PDFs here
  (poppler-utils absent); Bash cannot reach the saved binary. Prefixing the direct URL with
  the proxy returns clean prose. **This applies to any PDF-only source, not just ENISA's.**
  Limit: a 4.3 MB PDF still truncated partway.
- **[206] Contradictions have no `status` field.** Five keys only: `description`, `id`,
  `issue_id`, `opened_cycle`, `resolved_cycle`. `select(.status=="open")` returns **0** and
  is silently wrong. Use `select(.resolved_cycle==null)`. Several prior queue entries and
  logs use "open" as though it were queryable.
- **[207] A pre/post pair of a real institutional correction is now mechanically available**
  (src-0027 vs src-0026, both untruncated, 149 footnotes each). The URL-by-URL diff is
  undone and would yield **a directly measured count of how many references an ENISA
  link-correction actually changed** — a number owed to no secondary source, and the only
  such number this base could currently obtain.
- **[208] `open_questions[2]`'s count method is retired, and the retirement is itself a
  finding.** A link-edit revision preserves footnote count, so counting cannot measure it.
  Recorded so no cycle re-runs it. Untested on ETL 2025, for which **no pre-correction
  artefact has been located** — now the binding obstacle on 26/492.
- **[209] `ctr-0032` is the sixth instance of [198].** A correction carried a new defect of
  exactly the kind it was correcting, in the same sentence. This is now the most frequently
  recurring failure mode in this project, ahead of the stale-open_questions hazard [190].

**Updated at cycle 72:**

- **[4]** the G3 subtraction-versus-ceiling conflict — now in its **sixtieth** cycle.
- **[41]** the single `issue_id` field on contradictions — **bites again** if the
  institutional-incident split happens: its four contradictions (ctr-0012, ctr-0018,
  ctr-0030, ctr-0032) do **not** divide along the same seam as the conjunction.
- **[194]** the Read tool's 256 KB limit — **now binding on `graph.json` too** (578 KB).
  Working method confirmed this cycle: short offset Read to license Edit, `grep -n` for
  anchors, Edit with unique strings, `jq -e` after every edit.
- **[198]** a correction can carry its own new defect — **sixth instance**, ctr-0032.
- **[203]** a clean G2 pass is a result — cycle 69 passed clean; **71 and 72 did not**.

**Inherited chain, reproduced verbatim from `logs/cycle-071.md` below.**

## Carry-forward items

**Cycle 71's own new items are first. The entire inherited chain from `logs/cycle-069.md`
is reproduced verbatim below them, copied mechanically with `sed`, including every item I
could not act on. There was no `logs/cycle-070.md` — cycle 70 aborted before writing one —
so cycle 069 is the immediate predecessor in this chain.**

**NEW AT CYCLE 71:**

- **[205] AN ABORTED CYCLE SILENTLY WALKS THE SCHEDULE PAST A SCHEDULED FIRING.** This is a
  distinct mechanism from carry-forward [185] and must not be folded into it. [185] is about
  the *phase* and the *modulus* falling out of step. [205] is about **abort-and-retry**: when
  a cycle dies, `state/queue/next_task.json` rolls back **unchanged** but `run_cycle.sh` has
  already advanced `state/meta.json`'s counter, so the retry evaluates a **different cycle
  number** against the same queue entry. Cycle 70 was a genuine, due firing (70 % 7 == 0) and
  it was **lost**; cycle 71 tested 71 % 7 == 1 and correctly did not fire, while the surviving
  entry demanded a T1 in capital letters as "THE MOST IMPORTANT LINE IN THIS ENTRY". Any
  cycle-number-dependent instruction in a queue entry is invalidated by an abort. **The
  general rule: a queue entry may state cycle-number-dependent conclusions, but the executing
  cycle must always re-derive them against its OWN cycle number.** Recoverable here — the
  next T5 cycles are 74 and 77, and 77 % 7 == 0.
- **[206] A HANDOFF CAN CONTRADICT ITSELF WITHIN ITS OWN TEXT, AND THAT IS A FREE DETECTOR.**
  Cycle 70's entry asserted that `extraction-vs-reasoning-ordinal-axis` had never had a G2 on
  any candidate and recommended it on that basis, while **elsewhere in the same entry**
  instructing "DO NOT RE-QUEUE src-0006's AGENT-DERIVED stage means: cycle 63's G2 AUDITED
  THEM" — and those stage means *are* that issue's `candidate_resolutions[1]` route 1. The
  contradiction was visible without leaving the file. **Read a queue entry as a whole and
  cross-check its claims against each other before spending a fetch on any of them.**
- **[207] AN ALREADY-OPEN CONTRADICTION IS THE RIGHT PLACE FOR A REPEAT G2 FAILURE, AND
  RE-CONFIRMING ONE IS A RESULT.** Cycle 71's G2 failed, and the honest response was **not**
  to open `ctr-0032`: `ctr-0008` already names the exact leg and assigns the exact repair.
  Opening a duplicate would have inflated the open-contradiction count while adding nothing.
  What a repeat failure *does* add is **age and confirmation** — ctr-0008 is now in its
  **forty-first cycle** unrepaired and its step (v) is re-confirmed live. Pairs with [203]: a
  clean pass is a result, and so is "already known, still broken, here is the age".
- **[208] A CORRECTION'S PROPOSED REPAIR CAN BE INSUFFICIENT WITHOUT BEING WRONG.** Distinct
  from [198] ("a correction can carry its own new defect"). `ctr-0008` correctly diagnoses the
  wrong-cell defect in `extraction-vs-reasoning-ordinal-axis` route 2 and correctly proposes
  substituting the Threat Actor Accuracy row — but that substitution leaves a **second,
  independent** defect standing, namely that comparing a normalised **absolute** rubric level
  against an F1 from a different metric family violates the "within-table contrasts only"
  prohibition that ctr-0008 *itself* affirms "STANDS UNCHANGED". **When taking a repair step
  from a contradiction entry, check whether executing it actually clears the claim, or merely
  clears the defect the entry happened to notice.**
- **[209] ctr-0008's DECLINED ARITHMETIC IS NOW INDEPENDENTLY CONFIRMED.** ctr-0008 offered
  and refused to assert: substituting the Threat Actor Accuracy row gives GPT-4o 1.528/5 =
  0.306 and (1.528−1)/4 = 0.132 against the comparand 0.2502 — **above** under one
  normalisation, **below** under the other. Cycle 71 re-derived it from the stored table
  rather than copying it, and it **holds**; o3-mini 3.656 gives 0.7312 and 0.664, both above
  0.2337. **Consequence: `extraction-vs-reasoning-ordinal-axis` `candidate_resolutions[1]`
  leg (2)'s phrase "under both defensible normalisations" does not survive the repair.** The
  honest fix is probably to **withdraw** leg (2), which would leave that candidate resting on
  route 1 alone and destroy its "TWO INDEPENDENT ROUTES" framing — a material change a T4
  must price. A T5 had no standing to make it.
- **[210] TIE-BREAK (d), PROPOSED AND USED ONCE, AWAITING RATIFICATION OR REPLACEMENT.** The
  published ladder left cycle 71 an **unbreakable three-way tie** (ioc-extraction-reliability,
  consistency-calibration-as-failure-mode, institutional-incident-real-world-impact — all
  effective 2, all `created_cycle` 2, none recently attempted, none outranked). Cycle 71
  invented and applied: **among remaining ties, the LEAST RECENTLY ATTEMPTED issue wins** — a
  monotone extension of tie-break (b)'s anti-thrashing rationale past its 5-cycle window. It
  selected institutional-incident (last attempt 59) over consistency (62) and ioc (65). **This
  rule is not in `prompts/t5_select.md`.** It is offered as a candidate tie-break (d) because
  it is mechanical, reproducible and auditable, unlike an arbitrary pick — but it is an
  invention and a human should ratify or replace it. Sharpens [75].
- **[211] TIE-BREAK (a) IS A PARTIAL ORDER, NOT A RANKING, AND MUST NOT BE READ AS A
  DEPENDENT-COUNT.** `prompts/t5_select.md` says "an issue that others `depend_on` outranks
  its **dependents**" — strictly pairwise. Under that reading cycle 71's four `depends_on ==
  []` issues are mutually **incomparable** and (a) separates none of them, which is what
  produced the three-way tie. A tempting alternative reading — rank by *number* of dependents
  — would have selected `consistency-calibration-as-failure-mode` outright on 3 dependents.
  **The two readings give different answers and the prompt's wording supports the strict one.**
  Recorded so the choice is visible rather than silently made. Complements [61], which warns
  the converse error (`depends_on == []` ≠ "has no dependents").
- **[212] THIS SESSION'S BASH SANDBOX, WHICH COST CYCLE 71 SIX TURNS.** The Bash tool refuses
  to read or write **any path outside `/home/runner/work/SPIRAL/SPIRAL`** (so `/tmp` scratch
  files are unreachable even after the Write tool creates them), refuses `python3 script.py`
  and `cp` without approval, refuses jq's `--rawfile` and `--slurpfile` as "dangerous flags",
  and rejects `while` loops and some brace/quote constructs outright. **What works:** `cat`,
  `sed`, `grep`, `jq -r`, `jq -Rs` and shell redirection, all on **repo-relative** paths.
  **Working method for building a large queue entry without retyping anything:** Write the
  hand-authored fragments into `scripts/_tmp_*.txt` **inside the repo**, generate the
  quoted-from-state portion with `jq -r ... >> file`, concatenate with `cat`, wrap the whole
  file into a JSON string with `jq -Rs '{…, instructions:.}'`, verify with `grep -F -c -f`,
  then `rm` the scratch files. Delete the scratch files before finishing or the validator sees
  stray untracked files.
- **[213] CARRY-FORWARD [189] IS DORMANT, NOT SETTLED.** The "last 5 cycles" window ambiguity
  was outcome-relevant at cycle 70 (ioc's cycle-65 attempt sat inside `[65..69]` and outside
  `[66..70]`) and is **not** outcome-relevant at cycle 71, because every reading of the window
  from 71 starts at 66 or later. **The abort dissolved it by accident, not by decision.** It
  will bite again the first time a tied issue's most recent attempt lands exactly 5 or 6
  cycles back. Cycle 71 applied `[67..71]`, current cycle counted as one of the five, and
  states the reading even though it changed nothing.

**UPDATED AT CYCLE 71:**

- **[30] — sixth recorded elimination.** `automated-triage-under-refusal` was eliminated again
  by the `created_cycle` tie-break (16 against 2). It remains **the only issue never
  investigated in seventy-one cycles**, excluded by the one rule in the ladder with no
  research justification — it encodes "we thought of this first", not "this matters more".
- **[75] — hit again, harder.** Cycle 69's score spread demoted ttp out of contention but the
  ladder still failed to separate **three** issues at cycle 71, forcing the invention at [210].
- **[185] — a real firing was LOST at cycle 70**, by the new mechanism now recorded as [205].
  Next genuine firing: **cycle 77**.
- **[194] — re-confirmed at cycle 71.** `scores.json` is now **332.9 KB** against the Read
  tool's 256 KB hard limit and returned a hard error. All inspection was done with `jq`.
- **[203] — extended.** Cycle 69 passed clean; cycle 71 failed. **Neither outcome is the
  expected one**, and reporting both plainly is the point. Cycle 71 also declined to
  manufacture a second contradiction out of the near-miss at [208] and recorded the reasoning
  instead, per the precedent [203] sets.
- **ctr-0008 — re-confirmed live at forty-one cycles**, the oldest undone repair in this
  graph, with step (i) (the verbatim re-fetch of `eval/threat_actor.py`, located by cycle 68
  at `stage3_ti_drafting/score_evaluation/eval/threat_actor.py`, 7,017 bytes) now a one-call
  job, and step (v) confirmed still undone by cycle 71's G2.
- **DO NOT RE-QUEUE the verbatim transcription of src-0007's Table 4.** Pulled whole three
  times (cycles 15, 21, 30), cell-for-cell identical each time; cycle 71 deliberately audited
  against the stored transcription rather than spending a fourth fetch. **What is NOT closed
  is the metric-definition defect in how this state READS two of its cells — that is ctr-0008
  and it is live.**

---

**INHERITED CHAIN, COPIED MECHANICALLY FROM `logs/cycle-069.md` LINES 209–2895 (`sed -n
'209,2895p'`). NOTHING BELOW THIS LINE WAS RETYPED. Note that the inherited text contains
several further `## Carry-forward items` headings, an artefact of the chain copying itself
forward each cycle; they are preserved as-is.**

---

## Carry-forward items

### New at cycle 69

- **[203] A CLEAN G2 PASS IS A RESULT AND MUST BE REPORTED AS ONE.** A long run of
  consecutive cycles each found a defect, which creates real pressure on a successor to
  manufacture one. Cycle 69 verified its target exact, opened nothing, and recorded the
  near-miss it *declined* to escalate (the missing elicitation-block annotation on
  src-0013's figures in task-dependent-reliability-framing's `candidate_resolutions[1]`)
  so that a successor can overturn that judgement on the reasoning rather than on the
  absence of a record. The loop should not be read as guaranteeing a defect every cycle.
- **[204] THE RUBRIC'S WORD "PRIMARY" IS DOING UNRECOGNISED WORK, AND THE TEST I USED IS
  MY OWN CONSTRUCTION.** Level 3 reads "primary candidate supported by ≥2 independent
  sources". On a bare count of evidence arrays, **six of the nine issues would qualify
  today**. I disqualified four of them on the ground that their multi-source candidate
  either answers only ONE HALF OF A CONJUNCTIVE QUESTION (consistency-calibration;
  institutional-incident) or is EXPLICITLY SELF-DISQUALIFYING on independence
  (ioc-extraction's `candidate_resolutions[3]` says in its own words that it rests on "ONE
  independent measurement plus arithmetic"; task-dependent's second within-study leg is
  precisely what ctr-0009 impeaches). **That test is not written in
  `prompts/t4_assess.md`.** It is stated here so a human can ratify or reject it. If
  rejected, several issues rise to 3 immediately and the selector's discrimination changes
  materially.
- **[205] THE CHEAPEST PROMOTION AVAILABLE IN THIS GRAPH IS A SPLIT, NOT A COLLECTION.**
  `consistency-calibration-as-failure-mode` asks a conjunctive question. Its
  `candidate_resolutions[4]` genuinely clears the ≥2-independent-CTI-teams bar — src-0001
  (Mezzi/Massacci/Tuma, ARES 2025) and src-0018 (Milenkoski/Cirstea, SentinelLabs) — but
  scopes itself verbatim to "THE CONSISTENCY HALF ONLY", while the calibration half still
  rests on src-0001 alone on CTI material. **Split on the conjunction, as
  attribution-confident-wrong-gap was split at cycle 45, and the consistency leg has a live
  case for 3 today with no new collection at all.**
  `institutional-incident-real-world-impact` has the same shape: half one (have failures
  reached production at real institutions — yes, EY Canada and ENISA via src-0004,
  src-0009, src-0010, src-0012, src-0022) would carry a 3 alone. A T4 and a T5 may not
  split an issue; a T2 may.
- **[206] task-dependent-reliability-framing's CHEAPEST ROUTE TO 3 IS ONE FETCH:**
  establish whether src-0006's Table 2 F1 rows share one matching rule across its nine
  tasks. After ctr-0009 removed the src-0007 within-study leg, src-0006 is the *only*
  surviving within-study cross-sub-task measurement on that issue, and the commensurability
  of its own nine tasks has never been examined — the identical defect that killed the
  src-0007 leg. If the rules differ, it becomes a fourth non-commensurability finding
  instead of a promotion.
- **[207] FIVE OPEN CONTRADICTIONS BIND EXACTLY AS HARD AS ONE.** The validator builds its
  open-contradiction set as a set comprehension over `issue_id`, so
  `ioc-extraction-reliability`'s five open entries apply the same ceiling as
  `automated-triage-under-refusal`'s one. Contradiction *count* — otherwise this graph's
  clearest signal of unresolved conflict — is invisible to the gate. Related to [41].

### Updated at cycle 69

- **[4]** the G3 subtraction-versus-ceiling conflict, now in its **fifty-eighth** cycle.
  **Cycle 69 applied the validator's ceiling, said so in all nine rationales, and recorded
  what the prompt's subtraction rule would have given in each (1 for ttp, 0 for the other
  eight).** The conflict is now documented on a concrete case rather than merely flagged.
- **[75]** the incomplete tie-break ladder — **partly relieved** by the first score spread
  since cycle 33, but **not fixed**: a four-way `created_cycle`-2 tie remains.
- **[97]** — **not declined for a tenth time.** Isolated to exactly one entry
  (extraction-vs-reasoning-ordinal-axis), whose rationale now states both readings and the
  score each would give. See the Task performed section above.
- **[189]** the "last 5 cycles" window ambiguity — **outcome-relevant again at cycle 70**
  for ioc-extraction-reliability's cycle-65 attempt.
- **[194]** `scores.json` exceeds the Read tool's hard limit — **confirmed again**: a hard
  error at 308.8 KB against a 256 KB limit. Working method recorded in Changes made.
- **[20]** src-0013's results tables never pulled whole — **partly discharged**: Table III's
  six delta-ECE values and its caption are now verified at source by cycle 69's G2.
- **CLOSED — do not re-queue:** src-0013's Table III delta-ECE figures. Cycle 69's G2
  verified all six exact, with the containing sentence and the table caption.

### Inherited chain (copied mechanically from logs/cycle-068.md, unedited)

## Carry-forward items

*Cycle 68's own items first; the inherited chain follows below, copied mechanically from
`logs/cycle-067.md` lines 392–2951 rather than retyped.*

**[200] A SINGLE STORED NUMBER CAN BE ONE HALF OF A PAIR THE SOURCE ITSELF REPORTS.** src-0020's
0.22 was stored as "best" for twenty-five cycles while the same paper reports 0.32 under RAG **in
the very sentence that scopes the 0.22**. This is a near-relative of [199] — there, a one-sided
bound read as a point estimate; here, one configuration's maximum read as a paper's ceiling. The
phrase to look for is any figure this base calls a *maximum*, a *best* or a *ceiling*. ctr-0031
step (iv) asks a successor to sweep src-0002 and src-0007 for the same shape.

**[201] THREE OF THE FIVE ATT&CK MEASUREMENT FRAMES IN THIS BASE ARE NOW RETRIEVAL-AUGMENTED OR
SCAFFOLDED**, and the within-study bare-versus-augmented deltas are large (src-0020 +0.10 micro-F1
absolute; src-0021 +29.37 and +63.49 points absolute). "How reliable are LLMs at ATT&CK mapping"
may be substantially a question about the **harness** rather than about the model. Recorded as
`ttp-attack-mapping-reliability` open_questions[7], with the confound stated: retrieval
augmentation and multi-stage verification are different interventions that happen to share a
direction, and the deltas must not be pooled.

**[202] A NON-RESPONSIVE FETCH ANSWER IS NOT AN ABSENT AND MUST NOT BE RECORDED AS ONE.** Asked for
any sentence containing "sub-technique" or a technique-ID format, the src-0023 v2 render returned
the CTI-ATA definition sentence instead. That is not the paper being silent — it is the question
not being answered. I recorded no absence and opened `open_questions[6]` instead. This is the
constructive complement to rule (xvii), which so far has only told cycles what to *discard*.

**[203] ar5iv HAS NOW PRODUCED A RULE (xvii) NON-COMPLIANCE ON THREE SEPARATE SOURCES** — src-0002
(cycle 45, confident spurious ABSENTs), src-0023 (cycle 59, PRESENT with a non-containing quote),
src-0020 (cycle 68, same shape) — **while fingerprinting correctly by title and author every
time.** Correct fingerprinting is not evidence of string-level reliability. Usable for
corroboration; never alone to establish a string verdict. Supersedes nothing in [192], which
concerns fingerprinting only.

**[204] TWO ISSUES APPEAR NEVER TO HAVE HAD A G2 ON ANY CANDIDATE**: `task-dependent-reliability-
framing` (2 candidates, last attempted cycle 16) and `extraction-vs-reasoning-ordinal-axis`
(3 candidates, last attempted cycle 18). Both are overdue and either is a genuinely independent G2
target for a cycle looking for one.

### Updates to inherited items

- **[97]** — no longer merely latent on this issue. `ttp-attack-mapping-reliability` now has **two**
  supported candidates that are negative findings ([4] and the new [5]), so cycle 69's T4 confronts
  it directly rather than in the abstract.
- **[41]** — bit again at cycle 68. ctr-0031's single `issue_id` field cannot express that its
  src-0020 finding reaches wherever else that source is used.
- **[185]** — cycle 70 is a genuine firing. Passed on, and flagged as **inherited and unverified**:
  I read `collect_refresh_every: 7` at source but did **not** read `prompts/t5_select.md` step 4.
- **[198]** — vindicated twice this cycle. Re-fetching rather than transcribing recovered a
  **truncated** stored definition sentence in src-0023 and a **scope error** in how the state
  described that paper's scoring rule. Neither would have surfaced from a transcription.
- **ctr-0024 step (iv)** — **DISCHARGED at cycle 68.** Do not re-queue. Steps (ii) and (iii) remain.
- **ctr-0023 step (ii)** — **DISCHARGED at cycle 68.** Do not re-queue. Steps (iii) and (iv)
  remain; step (iv)'s two cheap untried routes (`example/simple_test.py`, 7,953 bytes and
  `ttp/README.md`, 16,236 bytes) had their sizes re-confirmed this cycle.
- **ctr-0008 step (i)** — still undone (38 cycles), but **no longer a search**: the file is at
  `stage3_ti_drafting/score_evaluation/eval/threat_actor.py`, 7,017 bytes.

## Carry-forward items

### New at cycle 67

- **[198] A CORRECTION CAN CARRY ITS OWN NEW DEFECT.** `ctr-0030`'s bad arithmetic **originated
  inside `ctr-0018`** — the entry that corrected a *different* defect in the *same two figures* —
  and cycle 59 then propagated it into the knowledge base and into a candidate **while
  discharging ctr-0018's repair steps.** This is the **fourth** time a prior correction has been
  impeached (after ctr-0011, ctr-0014, ctr-0019) and the **first** where the defect was
  *introduced by* the correction rather than surviving it. **Any cycle discharging a repair step
  should re-derive the repair's own claims rather than transcribing them.**
- **[199] A ONE-SIDED BOUND IS NOT A POINT ESTIMATE, and this base has no convention for marking
  the difference.** "North of 15%" against "below 5%" bounds a ratio **from below only**; four
  locations render it as "roughly three-fold". A future cycle should sweep for other derived
  quantities computed from bounds — look for any figure derived from two numbers themselves
  qualified by *over, under, north of, below, at least, more than*.
- **[196] BOUNDED (updated, not new).** The verbatim-whole-document fetch technique works on
  small plain-text files (2.3 KB at cycle 66) and is **REFUSED ON COPYRIGHT GROUNDS on
  full-length articles** (cycle 67). Fall back to exact-string PRESENT/ABSENT probes with the
  containing sentence requested — cheap, and it has never failed.
- **[189] UPGRADED (not new).** The "last 5 cycles" window ambiguity is no longer merely
  *material*: at cycle 67 the two readings **select different issues**. Cycle 67 departed from
  cycles 61 and 64 with reasons given (their stated ground — "harmless" — is falsified, because
  including the current cycle silently shortens the anti-thrash window from five cycles to four).
  **This is the sharpest single item for a human in the whole list.**
- **[75] SIXTH CONSECUTIVE FAILURE (not new).** The ladder ran out again. Its three unratified
  patches **disagreed three ways** under one window reading and split two-to-one under the other.
- **[30] FIFTH STRIKE (not new).** `automated-triage-under-refusal` eliminated by the
  `created_cycle` tie-break again — still the only issue never investigated in 67 cycles. **Two
  cycles running have now observed that its *score*, not the tie-break, is what really holds it
  out of reach** (cycle 66 flagged a strict reading of the rubric as arguably making it a 1).
- **[41] BIT AGAIN (not new).** ctr-0030 is filed against one of the **two** issues sharing
  src-0022 — the identical situation, on the identical source, that ctr-0018 recorded seventeen
  cycles earlier.
- **Cycle 70 is a genuine refresh firing** (70 = 10 × 7). Its T5 must write a **T1**, and
  **[197]** — the uncollected MISP taxonomies page — is a natural target for it.

### Inherited chain, copied mechanically from `logs/cycle-066.md`

## Carry-forward items

### New at cycle 66

- **[194] `state/assessments/scores.json` now EXCEEDS the Read tool's 256KB hard limit** and returns an **error**, not a truncation. jq is the only route into it. Cycle 66 hit this on its first attempt. A 5-line `Read` at the top of the file *does* license Edits anywhere in it.
- **[195] A GitHub-hosted raw file has three independent fetch routes** — `raw.githubusercontent.com`, `github.com/.../blob/...`, and `cdn.jsdelivr.net/gh/<owner>/<repo>@<ref>/<path>` — **and the blob renderer mangles punctuation.** It converted an ASCII ellipsis to a Unicode one and briefly appeared to impeach a correct transcription. Prefer raw or jsdelivr for exact-string work.
- **[196] For any short source, ask the fetch to reproduce the ENTIRE document verbatim** instead of asking a question about it. This converts a fetch model's weak ABSENT into the cycle's own reading. It is how ctr-0029 was grounded, and it is cheap for anything under a few KB.
- **[197] The MISP taxonomies page (`misp-project.org/taxonomies.html`) is a named, uncollected source** that src-0024 itself points to. Collecting it is **one fetch** that would likely resolve ctr-0029 and restore the [97] case on firmer ground than it ever stood on — the cheapest genuinely-new evidence available anywhere in this graph.

### Status changes to inherited items

- **[4]** now in its **fifty-fourth** cycle. Unchanged, unfixable from inside the loop.
- **[41]** bit again at cycle 66, twice: on ctr-0029, and on ctr-0028's cross-issue reach into `ttp-attack-mapping-reliability` (src-0007's TTP figures are cited by that issue too, and the single `issue_id` field cannot express it).
- **[97]** declined ad hoc for the **ninth** time — but at cycle 66 **with a substantive reason for the first time**, because ctr-0029 impeached the constructive half of the strongest [97] case in the graph.
- **[172]** partly discharged at cycle 63 and **modified at cycle 66**, which appended inside the header region rather than the tail. `rationale[0:900]` no longer reaches the end of a header; use `[0:3500]`.
- **[189]** material again at cycle 67, for `consistency-calibration-as-failure-mode`'s attempt at 62.
- **ctr-0028 step (ii): DISCHARGED at cycle 66.** The misquotation propagated to `ctr-0010` and to `scores.json`. Any repair must touch both. Steps (iii) and (iv) remain.
- **ctr-0020 step (iii): ANSWERED at cycle 66** — the four qualifications are at the edge of "supported" but do not break it. Only step (iv) remains. (Step (ii) was discharged at cycle 65.)
- **ctr-0026** remains a candidate for **outright resolution** by a cycle with standing: all of steps (ii), (iii) and (iv) were discharged at cycle 62, and it is the single cheapest reduction in this graph's open-contradiction count. Available for four cycles now; a T4 does not have that standing and cycle 66 did not take it.

### Inherited chain, copied mechanically from logs/cycle-065.md

## Carry-forward items

**New at cycle 65 (mine), at the top; the inherited chain from `logs/cycle-064.md` follows below,
copied mechanically with `sed` rather than retyped, because retyping is what makes wording drift.**

- **[190] STALE OPEN_QUESTIONS ARE A STRUCTURAL HAZARD OF THE APPEND-ONLY RULE.**
  `open_questions[8]` of `ioc-extraction-reliability` carried a charge that was discharged **one cycle
  after it was written** (cycle 52 → cycle 53) and it sat there live-looking for twelve cycles until a
  handoff re-issued it as assigned work. Append-only is right and I am not proposing to change it —
  but **a successor reading any open_question must check whether it was already discharged elsewhere
  before acting on it.** The append that would have prevented this costs one edit.
- **[191] `index.json`'s `sources[]` schema has NO `venue` field.** `jq .venue` returns `null` for
  every source. A null there is an artefact of the query, **not** a gap in the state. Check `_schema`
  before concluding a field is empty. I lost a turn to this.
- **[192] ar5iv FINGERPRINTS BY TITLE ON src-0003, and is not v2 there.**
  `ar5iv.labs.arxiv.org/html/2506.11325` serves *"Uncovering Reliable Indicators: Improving IoC
  Extraction from Threat Reports"*; `/abs` gives the current title as *"Revealing the True Indicators:
  Understanding and Improving IoC Extraction From Threat Reports"*. So on this source ar5iv **is** a
  genuinely independent render, and the standing "ar5iv is version-ambiguous — fingerprint it" caveat
  has a cheap fingerprint here. It truncated at "Appendix E User Interface".
- **[193] src-0003 IS INTERNALLY INCONSISTENT ABOUT ITS OWN 43%** — method sentence "each junior
  analyst" (five), result sentence "the analysts" (unqualified), abstract "six analysts". **The figure
  must never be cited from the abstract.** Verified across three renders. This is a defect of the
  paper, not of this state.
- **[194] ctr-0009 CARRIES THE REFUTED "two-directional substring" CHARACTERISATION** that cycle 65
  corrected inside ctr-0001. Cycle 35 refuted it at source thirty cycles ago; `scores.json` and
  `open_questions[6]` were fixed, ctr-0001 and ctr-0009 were not. ctr-0001 is now done. **ctr-0009 is
  not** — it is filed against a different issue, so a T3 on that issue should append the same
  correction.
- **[195] ctr-0020's step (ii) IS DISCHARGED at cycle 65** and the entry stays open on its quantity
  half alone. Its step **(iii) is addressed to a T4 specifically** and cycle 66 is the T4.
- **[196] ctr-0028's steps (ii) and (iii) are cheap and were deliberately not run.** (ii) is one Grep
  for the exact string `a substantial challenge` across `state/` — `scores.json` is **not**
  append-only-protected and is where such strings have been found before. (iii) is verification of the
  range `0.1414-0.2270` attached to the same clause; index.json records TTP recall 0.2270 (GPT-4o) and
  0.1759 (o3-mini), so the lower bound must come from a fine-tuned column and no cycle has confirmed it.

**Also passed on undone, unchanged in status:** `open_questions[4]` (adversarial/defanged indicators)
is **wholly unaddressed in its twenty-eighth cycle** and is a **T1 collection target** — no source in
this base measures it and a T3 cannot discharge it. And ctr-0027 step (ii) — appending src-0001's
token-probability elicitation passage to `src-0001.md` and `index.json` — is **still** the one repair
cycle 62 left undone in the knowledge base, and is still cheap.

**Closed, do not re-queue:** src-0006's agent-derived stage means (cycle 63's G2 audited them; they
reproduce exactly). **And now also: src-0007's TMLR provenance** — cycle 53 entered it in three places
and cycle 65 re-verified it at source. See [190] for why it looked open.

---

## Carry-forward items

**New at cycle 64:**

- **[188] THE 3(a)-VERSUS-3(b) ORDERING AMBIGUITY DID NOT BIND, AND THAT IS A RESULT.** Cycle
  63's handoff asserted the two readings *"give DIFFERENT WINNERS on the current graph."* Cycle
  64 evaluated **all four combinations** of {(a)-first, (b)-as-base-modifier} × {window 60–64,
  window 59–63} and **every one selects `ioc-extraction-reliability`**. The reading that does
  diverge is a **third**, which the handoff conflated with the first: a **strengthened 3(a)**
  that ranks maximal elements by out-degree *as part of the rule*. Cycle 64 **rejected it in
  writing** — out-degree ranking is **P3**, an unratified ad-hoc patch from cycle 61, and
  promoting it above rung 3(b) would nullify 3(b) on any graph with dependency structure and
  flat scores, re-selecting an issue attempted two cycles earlier. **[75] is still open and the
  ladder still failed; it simply was not outcome-determining here.** A successor facing a
  non-flat graph should not assume the same.
- **[189] THE "LAST 5 CYCLES" WINDOW WAS MATERIAL FOR THE FIRST RECORDED TIME.** Cycle 61
  checked and found windows 57–61 and 56–60 equivalent on its graph. At cycle 64 they are
  **not**: `institutional-incident-real-world-impact`'s cycle-59 attempt is inside 59–63 and
  outside 60–64, moving that issue between **rank 3** and **elimination at 3(b)**. Cycle 64
  used **60–64** (`current_cycle − 5 < c ≤ current_cycle`), cycle 61's reading, and recorded
  both columns in its ranking table. Not outcome-determining (P3 removes that issue anyway),
  but **the ambiguity is now demonstrated live, not hypothetical.** A human should fix the
  wording in `prompts/t5_select.md`.
- **[190] `ctr-0020`'s POPULATION HALF IS ANSWERED AT SOURCE BUT NOT YET RECORDED.** Cycle 64's
  G2 found, on **two independent renders** of arXiv 2506.11325: §5.2.2's METHOD sentence times
  *"each junior analyst"*; the RESULT sentence says *"the analysts"* unqualified; §4.2 gives
  five juniors plus one senior; and *"does any sentence state the senior analyst's time was
  measured"* → **ABSENT**. So the source is **internally loose** and the state's *"junior
  analysts"* wording **follows the method sentence** — `ctr-0020`'s charge that the state
  invented a fourth population is **half wrong**. **The QUANTITY half (parsing time vs
  annotation time vs "work factor") is untouched and stays open.** A T5 cannot record this;
  cycle 65's T3 is instructed to re-verify at a *different URL form* and then record it.
- **[191] `candidate_resolutions[0]`'s "+6% F1" IS UNDER-SPECIFIED.** src-0003 §5.1.3 verbatim:
  *"the LANCE-trained model outperforms the VT1-trained model by over 6% and the VT5-trained
  model by over 8% in terms of F1 score."* The state carries a bare "+6% F1". Not wrong, not
  contradiction-worthy, but it should name the baseline. Handed to the T3.
- **[192] src-0003's 97.6% IS TEXT-STATED.** §5.1.1 verbatim: *"LANCE outperforms all other
  methods, consistently achieving over 90% F1 score across all types and 97.6% overall."*
  Recorded because cycle 52 struck out the 76% and 72% **beside it** as figure-only, and a
  successor skimming that finding could easily over-generalise it to the headline. **It does
  not generalise.**
- **[193] src-0003 RENDER NOTE.** Cycle 64's **v1** render self-reported
  `TRUNCATED-AT-APPENDIX-A`; its **v2** render self-reported `NOT-TRUNCATED`. Any future
  **ABSENT** verdict about src-0003's **appendix** must come from **v2**. Note this is the
  mirror image of cycle 63's src-0006 lesson ([the earlier, shorter version worked there]) —
  **the rule is "check the render's own truncation report", not "prefer v1".**
- **[194] `automated-triage-under-refusal` ELIMINATED BY `created_cycle` FOR THE FOURTH
  RECORDED TIME.** It has `attempts: []`, is the **only issue never investigated in sixty-four
  cycles**, takes no attempt penalty, and survives 3(a) — and dies at 3(c) on `created_cycle`
  16 against 2, every time. See **[30]**. This is a defect in the selector, not the node, and
  the count is now four.

**The list below is reproduced mechanically from `logs/cycle-063.md` (lines 242–2634) with
`sed`, not retyped — retyping is what makes wording drift. It begins with cycle 63's own
"## Carry-forward items" heading and carries the full inherited chain, including every item
cycle 64 could not act on.**

## Carry-forward items

**New at cycle 63:**

- **[186]** src-0006's Table 2 has **28 rows** and **nine F1 rows**; the state's long-carried
  "nine" count is **CORRECT** and the ninth row — never named by any cycle since 18 — is
  **`Patch Recommendation`, Mitigation stage**, cells `.702 .679 .659 .636 .718 .601 .583
  .671 .582 .567 .632 .442 .629 .641 .446`, span 0.442–0.718, B.3 form *"Binary decision per
  candidate patch/hotfix: apply (yes/no) given product/version constraints."* Consequences:
  cycle 18's 0.286–0.882 span survives the row it never covered, and **ctr-0013's
  every-F1-row-is-binary finding now holds over all nine rows**, which tightens ctr-0013.
- **[187]** `scores.json` rationale tails are now **near-identical boilerplate**
  (`…DID NOT BIND. I REFUSED THE SUBTRACTION. Carry-forward [4]…`). An Edit anchor on a tail
  **must** include issue-specific text (contradiction ids and the cycle-ordinal work) or it
  matches nothing or the wrong entry. Cycle 63 hit this on every one of the nine appends.
- **[188]** For a **long** arXiv paper whose HTML truncates, an ABSENT verdict about any
  **appendix** is worthless and the working route is an **earlier, shorter version**. Cycle 63
  read src-0006's Appendix B.3 successfully from `/html/2509.23573v1` after cycle 42 had
  recorded two false ABSENTs on longer renders. This is cycle 42's sub-rule, confirmed a
  second time and now cheap to apply.

**Discharged at cycle 63 — do NOT re-queue:**

- **src-0006's agent-derived stage means**, named the cheapest available action in this graph
  for fifteen consecutive cycles and serving two issues: **AUDITED, REPRODUCE EXACTLY,
  CLOSED.** All eight per-task means and both stage means verified cell-by-cell against the
  15 model columns. This item should not appear on any future list.
- **[172]** the layered-rationale hazard: **partly discharged**. CURRENT-POSITION headers now
  sit at the top of all nine rationales, with five factual corrections (listed under Changes
  made). The obsolete text beneath necessarily remains, so the item stays open in weakened
  form.

**Updated at cycle 63:**

- **[4]** the G3 subtraction-versus-ceiling conflict — **fifty-second cycle**. Cycle 63 read
  **both** documents at source and confirms they conflict. Ceiling applied, subtraction
  refused, on all nine issues.
- **[97]** whether a non-commensurability or negative finding counts as a resolution —
  **eighth** ad-hoc identical decision, now holding down **three** issues with live cases for
  3. Cycle 63 calls it the single largest unexercised lever on this project's scores.
- **[75]** the incomplete tie-break ladder — now **the entire basis of cycle 64's selection**,
  since all nine scores are equal and the base-priority rung separates nothing. Cycle 63
  identified a rung-(a)-versus-rung-(b) ordering ambiguity that changes the winner, and did
  not decide it.
- **[30]** the created_cycle tie-break — `automated-triage-under-refusal` still has
  `attempts []` after sixty-three cycles and remains the only issue never once investigated.

**Inherited chain from `logs/cycle-062.md`, copied verbatim below by `sed` rather than
retyped (retyping is what makes wording drift). Items above supersede their counterparts
below where they conflict.**

## Carry-forward items

**New at cycle 62 (numbered from [183] — I checked the chain and the highest existing item is
[182], NOT the [174] my own inherited handoff implied; that is a small handoff error I am
correcting rather than repeating):**

- **[183] THE ELICITATION-MODALITY BLIND SPOT, AND IT IS BASE-WIDE.** No source in this base
  except `src-0013` (and now `src-0001`, via `ctr-0027`) has its confidence-elicitation method
  recorded anywhere. Unknown for `src-0018`, `src-0014`, `src-0015`, `src-0016`, and `src-0002`.
  Under rule (xxi) this directly weakens `consistency-calibration-as-failure-mode`'s
  `candidate_resolutions[2]`, which aggregates four of them into one corroboration of
  overconfidence and under-refusal **without knowing whether they measure commensurable
  quantities**. Cycle 62 showed the swing between two modalities on one benchmark is up to **0.56
  ECE**, so this is not pedantry. Likely one exact-string fetch each (`confidence`, `logit`,
  `log probabilit`, `verbaliz`, `self-consistency`). Filed as the issue's `open_questions[8]`.
  **Bears equally on `attribution-expressed-confidence-unmeasured`, whose entire subject is
  expressed confidence.**
- **[184] RULE CAVEAT: FOR A SINGLE-VERSION PAPER, `/html/<id>` AND `/html/<id>v1` ARE THE SAME
  DOCUMENT.** They are independent **fetches** but **not** independent **renders**, so they do
  **not** satisfy rule (v)'s two-URL-form requirement for an ABSENT. Cycle 39 used exactly this
  pair on `src-0001` and called them "two URL forms" — defensible there, since `src-0001` has four
  versions and the unversioned render resolves to v4 while v1 is genuinely different. **The
  distinction is whether the two URLs resolve to different versions.** Cycle 62 labelled its
  `src-0013` Brier evidence provisional on exactly this ground.
- **[185] THE REFRESH-RULE MODULUS CAN SKIP FIRINGS ENTIRELY, AND HAS.** `collect_refresh_every: 7`
  is tested **only inside a T5** (`prompts/t5_select.md` step 4), and T5s recur every three
  cycles. So the test is sampled at 1-in-3 of the cycles the modulus is written against. Cycle 63
  **is** a multiple of 7 and the rule will **not** fire, because 63 is a T4. Next actual firing:
  **cycle 70**. Whether this is intended is a **question for the human** — a T1 refresh every 7
  cycles and a T1 refresh at whichever T5 happens to land on a multiple of 7 are very different
  policies, and the config comment ("every Nth cycle, T5 schedules a T1") reads like the former
  while the code implements the latter.
- **[186] RULE (iv) APPLIES TO THE STATE'S OWN PROSE, NOT ONLY TO SOURCES.** `ctr-0026` impeached
  the last clause of a sentence in `src-0013.md` and stopped; `ctr-0027` found a second,
  independent falsehood **one clause earlier in the same sentence**. Whole-sentence discipline is
  something this base applies rigorously to quotations it pulls and not at all to the sentences it
  writes about them. **When you impeach part of a stored sentence, re-read the WHOLE sentence.**
- **[187] `ctr-0026` IS READY TO RESOLVE.** All three outstanding steps ((ii), (iii), (iv)) were
  discharged at cycle 62. It was left **open** only so that (iv)'s spillover is recorded against
  it first. A cycle with standing should close it — this is the cheapest resolution available in
  the graph.
- **[188] `ctr-0027` STEP (ii) IS THE ONE KNOWLEDGE-BASE REPAIR CYCLE 62 LEFT UNDONE, AND IT IS
  CHEAP.** `src-0001`'s token-probability elicitation passage should be appended to
  `state/knowledge/src-0001.md` and to `index.json`'s `src-0001` key_claims. As of the close of
  cycle 62 the elicitation modality of **this base's most load-bearing source** is recorded
  **nowhere except inside `ctr-0027`**.
- **[189] FOR `src-0001` SPECIFICALLY, A SINGLE ABSENT IS NO EVIDENCE AT ALL.** Three
  false-negative ABSENTs are now recorded on this one source (cycles 25, 39, 62). Rule (v)
  already requires a second form; on this source treat a lone ABSENT as **void**, like a
  rule-(xvii) non-matching PRESENT.

**Updated at cycle 62:**

- **[75] the incomplete tie-break ladder** — undiminished. Cycle 62's target paid out, but on a
  lead any selector could have seen; see "On the selection" above. Still four consecutive T5
  failures, three unratified patches.
- **[41] the single `issue_id` field** — **load-bearing for the second consecutive cycle**.
  `ctr-0027` bears on `attribution-expressed-confidence-unmeasured` and
  `task-dependent-reliability-framing` as well, and can name only one.
- **[4] the G3 subtraction-versus-ceiling conflict** — **fifty-first cycle** awaiting a human.
  Demonstrated again: a third open contradiction on one issue changed the ceiling by nothing.
- **[172] the layered-rationale hazard** — unchanged, known on three issues, and **squarely the
  cycle-63 T4's to fix**.
- **[174] the Springer IdP block** — re-recorded, and now carried inside the issue's
  `open_questions[7]` itself rather than only in a queue entry. Three untried routes remain
  (ARES programme page, dblp.org, Semantic Scholar/OpenAlex by DOI). **Not attempted at cycle 62.**
- **[182] `src-0006`'s AGENT-DERIVED stage means** — now **fifteen** cycles unaudited, still the
  cheapest available action in this graph, still serving two issues. **Not done at cycle 62.**

**Methodological rule — consolidated to twenty-three parts below.** Note for successors: the
inherited chain reproduces rules **(i)–(xvii)** in one block but carries **(xviii)–(xxiii)** only
as scattered carry-forward bullets at varying depths. The queue entry that reached cycle 62 said
cycle 61 "reproduces all of them", which is true only in the loose sense that they appear
*somewhere*. Cycle 62 consolidates all twenty-three in one place so the next cycle need not
reassemble them.

## Methodological rule, in twenty-three parts — consolidated at cycle 62

Rules **(i)–(xvii)** are reproduced verbatim in the inherited block further down this file; they
are unchanged and are not restated here. Rules **(xviii)–(xxiii)**, previously scattered:

**(xviii)** *ACCEPTED at cycle 54.* When the state converts a reported metric into a **different
quantity** — a precision into a false-positive rate, a rate into a count, a within-group share
into a population share — **re-derive the conversion from the definitions** before trusting it.
No string check and no number check will catch an invalid conversion: both endpoints can be
verbatim-correct while the step between them is nonsense.

**(xix)** **CHECK SIMILARITY CLAIMS THEMSELVES AT SOURCE.** A claim that two things are alike is a
claim, and it is not tested by verifying either thing separately.

**(xx)** *ACCEPTED at cycle 56, distinct from (v).* **RE-ENUMERATE THE ARTEFACT BEFORE TRUSTING
THE DEFINITE ARTICLE.** "The table", "the five files", "the four methods" — count them again.
`ctr-0023` (a five-child directory listing) and `ctr-0026` (a four-block table stored as one
block) are the load-bearing instances; **cycle 62's Token Probability pull is the fourth, and it
is the one that paid best.**

**(xxi)** *distinct from (xix), per cycle 56.* A score built by **aggregating several weak cases**
is only as good as the **independence of the cases**, and **independence of discovery is separate
from independence of source.** Newly live at cycle 62 via **[183]**.

**(xxii)** A **batched ABSENT is weaker than a single ABSENT, not stronger.** Asking one fetch for
thirteen exact strings invites it to answer the *question* rather than the *string queries*.
Treat any sweep of more than about five strings as **one** absent about the concept — **and write
the strings themselves into the log, not just the tally**, or the verdict is unauditable forever
(cycle 33's ten-string sweep, unreopenable twenty-seven cycles later).

**(xxiii)** **WHEN A RENDER WILL NOT TELL YOU ITS VERSION, FINGERPRINT IT** against stored
version-discriminating wording. `ar5iv` has served v1 on two different papers — treat it as
v1-leaning and always fingerprint. **Cycle 62 applied this**: the `ar5iv` fetch was opened with a
Table IV caption fingerprint, which returned *"verbalized averages"* and confirmed the render.

**Standing observation, promoted by cycle 62 from cycle 49's note:** a G2 target and a main-task
target can be the **same artefact**, and choosing that overlap deliberately buys two results for
one fetch. Cycle 62's `src-0001` G2 fetch also answered the main task's modality question, which
is how `ctr-0027` came to rest on two independent passages instead of one.

---

*Everything below this line is the carry-forward chain inherited from `logs/cycle-061.md`,*
*copied mechanically and unedited, including the items cycle 62 could not act on.*

## Carry-forward items

### New at cycle 61

**[173] — NEW, AND IT CHANGED A SELECTION. THE HANDOFF INVERTED THE DEPENDENCY DIRECTION.**
Cycle 60's queue entry asserted that four issues have "NO dependents at all", naming
`ttp-attack-mapping-reliability` and `ioc-extraction-reliability` among them. Both are
false: `task-dependent-reliability-framing` lists both in its `depends_on`, so both **do**
have a dependent. The entry confused `depends_on == []` (no **upstream**) with having no
**dependents**. Only two issues are genuinely isolated. Correcting it turned tie-break 3(a)
from an unrankable muddle into a step that eliminates four of nine issues, and it is why
cycle 61 selected the issue it did. **GENERAL LESSON FOR EVERY FUTURE T5: `depends_on` is
the UPSTREAM list. To find an issue's DEPENDENTS you must INVERT the relation across the
whole graph. Build the inverted map explicitly and put it in the log.**

**[174] — NEW. `link.springer.com` IS BLOCKED TO THIS AGENT, AND A STANDING RECOMMENDATION
IS WITHDRAWN.** `doi.org/10.1007/978-3-032-00627-1_17` 302-redirects to
`link.springer.com/…`, which 303-redirects to `idp.springer.com/authorize?response_type=cookie&…`;
the book-level URL hits the same endpoint. Add Springer to the blocked list beside
`spiegel.de` and `web.archive.org`. **Carry-forward [66] / `open_questions[7]`'s claim that
"one fetch of the DOI would settle it" is WITHDRAWN**, and cycles 53 and 54 both advertised
that bolt-on as a proven win. Untried routes for `src-0001`'s ARES 2025 provenance: the ARES
conference programme page; **dblp.org** (indexes Springer LNCS, not IdP-gated); Semantic
Scholar or OpenAlex by DOI.

**[175] — NEW. RULE (xvii) HAS EARNED PROMOTION FROM CAUTION TO MANDATORY POST-CHECK.**
Cycle 59 caught two substitutions, cycle 60 a third, cycle 61 a **fourth and fifth in a
single fetch** — asked for the whole paragraph containing `33.9` and the whole paragraph
containing `16.9`, it returned two paragraphs containing **neither**. Five instances in
three cycles. **Proposed strengthening, offered not imposed: when a fetch fails ANY
compliance check, downgrade EVERY verdict from that fetch to single-form and re-confirm on
a second URL form before entering anything.** Cycle 61 did exactly that and it is why
`ctr-0026`'s finding rests on two renders rather than one.

**[176] — NEW. THE STALENESS ORDER DEPENDS ON A READING NOBODY HAS RATIFIED.** `src-0001`'s
last *designated* G2 was cycle **25**; its last *substantive re-fetch* was cycle **39** (a
version probe under cycle 39's main task). Under the first reading `src-0001` is the stalest
source in the base and both cycle 60's "src-0011 is stalest by date" and cycle 61's choice of
`src-0013` are wrong; under the second, both are right. **Cycle 61 uses "last substantively
re-fetched at source" and says so.** A human should pick one, because G2 target selection has
been driven by staleness for roughly thirty cycles and the two readings can disagree by ten
cycles.

**[177] — NEW. `ctr-0026`: `src-0013` IS A FOUR-ELICITATION-METHOD STUDY THAT THIS BASE HAS
RECORDED AS A ONE-METHOD STUDY FOR FORTY-SIX CYCLES.** Table I carries Verbalized, Token
Probability, Sampling-based Consistency and Self-Consistency blocks (two renders agree). The
stored *Limitations* bullet's clause "no result here transfers automatically to logit-based
uncertainty" is false of the source. **Step (iii) — pull the Token Probability block — would
give this base its first within-study verbalized-versus-logit calibration comparison on a
security task, at zero collection cost.** Fourteenth instance of rule (vi).

**[178] — UPDATED, [75].** The tie-break ladder has now **failed outright in FOUR
consecutive T5 cycles** (51, 54, 58, 61) and its unratified ad-hoc patches now number
**THREE**. Cycle 61 established something new and worse: **the patches disagree with each
other.** Out-degree (P3) and oldest-last-attempt (P2) select
`consistency-calibration-as-failure-mode`; fewest-total-attempts (P1) selects
`ioc-extraction-reliability`. **The loop's agenda-setting step is not robust to a choice no
rule has ever made.**

**[179] — UPDATED, [30].** The `created_cycle` tie-break was load-bearing for the **fourth**
time and eliminated `automated-triage-under-refusal` for the **third**. That issue has
`attempts: []` after **sixty-one cycles** and two pieces of relevant evidence already in the
base wired into nothing (`ctr-0021` step (iv)'s `src-0007` Pass Rate rows; `src-0022`, which
`ctr-0018` spans but which was never wired here). **The mechanism is working exactly as
specified and the specification is producing a permanent blind spot.**

**[180] — UPDATED, [41].** The single `issue_id` field was load-bearing again: `ctr-0026`
bears on `task-dependent-reliability-framing` too — `src-0013` is cited by both issues, and
that issue's own score turns on cross-task comparability — but the schema lets the entry name
only `consistency-calibration-as-failure-mode`.

**[181] — NEW, METHODOLOGICAL, AND CHEAP.** `ctr-0026` was found by **asking for a table IN
FULL rather than re-checking the numbers already stored**. Every number in `src-0013` was
exact and had been verified twice; the defect was in a scope sentence no string or number
check could reach (rule viii). **A G2 that only re-checks what the state already records can
only ever confirm it. Ask the source what it contains, not whether it contains what you
wrote down.**

---

*The inherited carry-forward chain from `logs/cycle-060.md` follows verbatim below, copied
mechanically rather than retyped, including the items cycle 61 could not act on.*

---

## Carry-forward items

### New at cycle 60

- **[172] THE LAYERED-RATIONALE HAZARD IN `scores.json`, AND IT NEEDS A HUMAN.** Three of
  nine rationales were found carrying an **obsolete headline in their opening sentence** —
  `institutional-incident-real-world-impact` ("HELD AT 3, AND THIS IS NOW THE ONLY ISSUE IN
  THE GRAPH ABOVE 2", cycle 33's words, false since cycle 53);
  `ttp-attack-mapping-reliability` ("this issue carries no open contradiction and nothing
  caps it", false since cycle 46); `attribution-expressed-confidence-unmeasured` ("NO open
  contradiction, NO ceiling", false since cycle 59). Each was true when written. The
  append-only convention that rightly protects the knowledge base produces, in the
  assessment file, a document whose **first paragraph is its most out-of-date part** — and
  a hurried successor reads the top. All three corrected in place at cycle 60 with the old
  text left standing. **This is a format problem, not a cycle's error.** Either rationales
  need a mandatory current-position header rewritten each cycle, or append-only should not
  apply to `scores.json` the way it rightly applies to `state/knowledge/`.
- **[173] THE HANDOFF'S G3 CEILING ARITHMETIC WAS FLATLY WRONG.** Cycle 59's queue entry
  asserted twice, in capitals, that resolving `ctr-0012` and `ctr-0022` raised
  `institutional-incident-real-world-impact`'s ceiling "FROM 3 TO 5". The validator's
  ceiling is a **set-membership test over `issue_id`**, not a per-contradiction
  subtraction; `ctr-0018` remained open; the ceiling **never left 3**. Second consecutive
  cycle to catch its own handoff misstating contradiction arithmetic.
- **[174] `ctr-0025` OPENED** — src-0011's SCOPE LIMIT quotes as the detector's
  **definition** a string that neither of two URL forms would produce as one, and whose
  most economical explanation is a **case-study clause promoted to a definition** by an
  earlier cycle. Thirteenth rule (vi) instance. **The failure licenses nothing**: the scope
  limit rests on four legs and the other three were re-verified this cycle, so
  `candidate_resolutions[4]` stays `proposed` and GhostCite's 1.07%/1.01% remains
  prohibited as a CTI base rate.
- **[175] RULE (xxii) EXTENDED: WRITE THE STRINGS, NOT JUST THE TALLY.** Cycle 33 recorded
  "All ten exact-string checks returned PRESENT" without naming the ten. Twenty-seven
  cycles later that verdict is **permanently unauditable** — cycle 60 could not determine
  whether the string it impeached was among them. A batched sweep whose members are not
  written down cannot be reopened, narrowed or confirmed by any later cycle.
- **[176] RULE (xxiii), NEW: WHEN A RENDER WILL NOT TELL YOU ITS VERSION, FINGERPRINT IT
  AGAINST STORED VERSION-DISCRIMINATING WORDING.** ar5iv refused the version question for
  2602.06718; the four v1-only abstract phrases already recorded in `src-0011.md` all came
  back, identifying it as v1. ar5iv has now served **v1 on two different papers** (2510.11974
  at cycle 59, 2602.06718 at cycle 60) — treat it as v1-leaning and always fingerprint.
  Worth **recording discriminators deliberately** for any multi-version source.
- **[177] RULE (iii) APPLIED, WITH A LIVE RESULT:** src-0011's "80.9% increase in 2025
  alone" **has no stated referent at source** — the sentence does not say whether papers,
  citations or a rate increased. The fetch volunteered "rate"; that was its own gloss, not
  a quoted definition. This base's wording is faithful precisely because it attaches no
  referent, and **no successor may attach one**.
- **[178] A THIRD rule (xvii) SUBSTITUTION IN TWO CYCLES.** `/html/v1` answered **PRESENT**
  for an exact string while quoting a sentence that does not contain it. **Treat a PRESENT
  verdict whose quoted sentence lacks the string as VOID, not as a weak yes.**
- **[179] src-0022 WAS MISSING FROM THE ASSESSMENT EVIDENCE ARRAY** of the very issue cycle
  59 wired it into. Added at cycle 60. Cycle 50's diagnosis — "a source nothing cites cannot
  move any score" — reappears one level up, in `scores.json` rather than `graph.json`.
  **A T4 that adds a candidate must check the assessment's evidence array too.**
- **[180] src-0022 IS *STILL* CITED BY NO ENTRY ON `automated-triage-under-refusal`**
  (carry-forward [167], undischarged). `ctr-0018` spans both issues but contradictions carry
  a **single `issue_id`** (carry-forward [41]), so cycle 59 could only wire it into one.
  The curl case is squarely about triage of inbound security reports under AI-generated
  volume. That issue's score is depressed **partly by a schema limitation rather than purely
  by an evidential one**, and that distinction is a human's to resolve.
- **[181] carry-forward [97] NOW SITS BETWEEN THIS GRAPH AND A THREE-ISSUE SCORE CHANGE.**
  Cycle 56 noted that answering [97] YES would give `extraction-vs-reasoning-ordinal-axis`
  and `ttp-attack-mapping-reliability` live cases for 3 on the same day. As of cycle 59
  `attribution-expressed-confidence-unmeasured` joins them — its well-evidenced negative is
  exactly the shape [97] describes, and its new ceiling of 3 **permits** rather than blocks
  the 3. Seven cycles have now decided [97] silently and identically. It is the **single
  largest unexercised lever on this project's scores**.
- **[182] src-0006's AGENT-DERIVED STAGE MEANS ARE NOW THIRTEEN CYCLES UNAUDITED** against
  the log that derived them (rule xii). Named the cheapest available action anywhere in this
  graph since cycle 47, serving **two** issues at once
  (`task-dependent-reliability-framing` and `extraction-vs-reasoning-ordinal-axis`), and
  never executed. That is information about this loop's T3 allocation, not about the
  difficulty of the work.

### Inherited chain — reproduced verbatim from `logs/cycle-059.md` below

## Carry-forward items

### New and updated at cycle 59

- **[165] The handoff's open-contradiction count was wrong by three.** It asserted nineteen open;
  the graph held sixteen. Sixteenth handoff caught misstating what it summarised. Cheap to catch
  (`jq` one-liner), and the preamble's own instruction to verify at source is what caught it.
- **[166] ctr-0012's steps (i) and (ii) were confirmed NEVER PERFORMED after seventeen cycles.**
  Second time this loop has caught a repair pair silently skipped (cycle 52 caught ctr-0014's).
  The check that caught it was counting `key_claims` — three, not four. **Recommend every
  contradiction resolution note state a countable invariant a successor can check in one query.**
  Cycle 59's resolution notes do this.
- **[167] src-0022 is now wired into ONE of its two owning issues and still absent from the
  other.** `automated-triage-under-refusal` has never been investigated in 59 cycles and the
  `created_cycle` tie-break has eliminated it at three consecutive T5s. This is [41] (single
  `issue_id` field) becoming load-bearing again.
- **[168] Carry-forward [109] is FULLY DISCHARGED.** Cycle 58 gave src-0024 its first G2, cycle 59
  gave src-0023 its first. **Every source in the base now has at least one G2 behind it.**
  Staleness by date is now the only G2 selection criterion left; src-0011 (cycle 33) is the stalest
  and is the sole evidence for this issue's only `proposed` candidate.
- **[169] RULE (xxii), offered not imposed: a batched ABSENT is weaker than a single ABSENT, not
  stronger.** Asking one fetch for thirteen exact strings invites it to answer the *question*
  rather than the *string queries*, and a compound like "low-confidence" is exactly what a
  question-answering read drops. Two confirming substitutions in three fetches this cycle. Treat
  any sweep of >5 strings as one absent about the concept.
- **[170] First contradiction ever filed against `attribution-expressed-confidence-unmeasured`**
  (ctr-0024). Its ceiling drops 5 → 3; it scores 2, so the gate does not bind.
- **[171] The CTI-ATA definition and its Precision/Recall/F1-after-regex-normalisation scoring rule
  were recovered but deliberately NOT wired into `ttp-attack-mapping-reliability`**, because a T3
  investigates its own target issue and nothing else. It bears on the exact-match-versus-partial-credit
  question that issue has tracked since cycle 16. ctr-0024 step (iv).
- **[172] ar5iv is a VERSION-AMBIGUOUS URL form.** It served **v1** for 2510.11974 while
  `/abs` and unversioned `/html` serve v2. Always ask ar5iv which title it is serving before
  treating it as a second form of the same document. Also: the last element of a JSON array has no
  trailing comma — an Edit anchor copied from a mid-array element will fail.
- **[173] ctr-0018 is one exact-string fetch from resolution.** Only step (iii)'s second absence
  remains: does the post state any count or percentage of AI-slop reports? Ask it as a bare
  exact-string probe (any numeral adjacent to "slop"), not as a conceptual question — the
  conceptual form is what produced the substitution this cycle.

### Inherited chain, copied verbatim from logs/cycle-058.md

## Carry-forward items

### New and updated at cycle 58

- **[158] The tie-break ladder failed for the THIRD consecutive T5.** Cycles 51, 54 and 58, on
  three different candidate sets. Six of nine issues share `created_cycle` 2, so this is
  structural. **Both** existing ad-hoc patches were needed to break this one; they converged for
  the first time, which is luck rather than design. [75] and [30] need a human ruling.
- **[159] NEW FAILURE MODE: a handoff projection that was true when written and false when
  executed.** Cycle 56's "candidate clean path through the ladder" depended on
  `ioc-extraction-reliability`'s cycle-52 attempt sitting inside the five-cycle window. Cycle 57
  aborted; by cycle 58 the penalty had expired and the path was gone. All fourteen prior handoff
  defects in this project were wrong at the moment of writing. **Recency-windowed quantities in a
  handoff are valid only for the cycle they were computed for, and an abort silently invalidates
  them.** A successor writing a projection that depends on a window should say which cycle it is
  computed for and what changes if the cycle slips.
- **[160] The attempt-penalty WINDOW BOUNDARY convention (`[53,57]` vs `[54,58]`) was NOT
  load-bearing at cycle 58** — no issue has an attempt at the disputed cycle — but it **was** at
  cycle 57 and it will recur. Still unratified. I would use "the five cycles ending at the
  current one".
- **[161] Every contradiction against `institutional-incident-real-world-impact` was opened
  AFTER its only investigation** (attempts `[12]`; contradictions opened 41, 50, 54). Three G2s
  found defects across seventeen cycles and the selector never sent an investigator. This is a
  structural argument that the tie-break ladder has been *starving* an issue, and it is
  independent evidence for [75].
- **[162] Carry-forward [109] is HALF DISCHARGED.** `src-0024` received its first G2 at cycle 58
  and **passed clean**. **`src-0023` is now the last source in the base with no G2 behind it**,
  and it carries a known unresolved GPT-5/GPT-4 judge discrepancy and an unread Appendix D.
- **[163] Rule (xx)'s first CONFIRMING application.** The re-enumeration of `src-0024` found the
  stored "whole file, verbatim" reproduction genuinely complete (24 lines, nothing before the
  heading, nothing after the last TIP). The rule is not only a refutation engine, and a passing
  (xx) check is not wasted budget.
- **[164] Cycle 56 asked whether candidate rule (xxi) is distinct from (xix). My answer, offered
  not imposed: YES.** (xix) tests whether a **similarity** claim is true; (xxi) tests whether an
  **independence** claim is true. `ctr-0022` happens to break both at once, which is what makes
  them look like one rule. A claim can be perfectly true about similarity and false about
  independence, and vice versa.
- **[165] A task that aborts before writing state never increments `attempt_count`.** Cycle 57
  died on this queue entry and cycle 58 inherited it reading `attempt_count: 0`. `config.yml`
  sets `max_task_attempts: 3` as a circuit breaker; a pre-state-write abort is invisible to it,
  so a queue entry that reliably kills its cycle could loop indefinitely. Needs a human.
- **[157] UPDATED — the version-staleness probe is nearly free, and for git-hosted sources it is
  better than free.** `api.github.com/repos/<owner>/<repo>/commits?path=<path>` returns a
  definite date in one fetch, which beats asking a page for a revision notice and getting an
  absence. Used at cycle 58 to date `src-0024` to November 2022.
- **[152]–[156] carried from cycle 56 below, all still live.** [153]'s "candidate clean path" is
  **superseded by [159]** — do not re-use it.

### Inherited chain, copied verbatim from `logs/cycle-056.md` below

## Carry-forward items

**New at cycle 56:**

- **[152] The demotion and its consequence.** `institutional-incident-real-world-impact`
  fell **3 → 2** on merit at cycle 56, removing the last score above 2 from the graph.
  **Every one of the nine issues now scores 2.** The weakest-link selector faces a
  **nine-way tie** where it previously faced an eight-way one. This is the price of honest
  scoring and was accepted deliberately; see the cycle-56 rationale block in `scores.json`
  for the full grounds. **Do not undo it by observing that the G3 gate did not cause it** —
  it was never a gate effect.
- **[153] The `depends_on` map and a candidate clean path through the ladder.** Upstream
  *and* depended upon: `consistency-calibration-as-failure-mode` (by three issues),
  `ttp-attack-mapping-reliability` (by one), `ioc-extraction-reliability` (by one). Under a
  topological reading of step 3(a), `consistency-calibration` is the only one of those with
  a **zero** attempt penalty at cycle 57 and the ladder would terminate at 3(b) without
  reaching the unratified `created_cycle` rule. **Offered as a hypothesis; a T4 has no
  standing to select.** Note the boundary ambiguity: `ioc-extraction` was attempted at 52
  and 57−52 = **exactly 5**, so its penalty depends on an unstated convention.
- **[154] `attribution-expressed-confidence-unmeasured` is the ONLY issue in the graph with
  no open contradiction**, so no ceiling applies to it and 3/4/5 are all available — and it
  still scores 2 on merit. **This reflects absence of scrutiny, not absence of defects:**
  two of its six sources (`src-0023`, `src-0024`) have never been independently verified,
  both added by cycle 49 itself. Cycle 56 recorded this as an **independent** ground for the
  2, so that score no longer depends on **[97]** alone.
- **[155] Candidate rule (xxi)** — independence of *discovery* is not independence of
  *source*. Awaiting a successor's verdict on whether it is distinct from (xix).
- **[156] Rule (xx) ACCEPTED at cycle 56**, with reasons for treating it as distinct from
  (v)'s fourth limb, and with a **live application**: `ctr-0008` step (i) — 25 cycles undone,
  the oldest live repair in the base — names `eval/threat_actor.py` and should be run against
  a complete trees-API listing first.
- **[157] The version-staleness probe is nearly free** and should be a standing extra item
  on every verification fetch: "is there any revision notice / version bearing a number
  *other* than the stored one?" Cycle 56 ran it for the first time on `src-0009` and
  `src-0010` (both still v1.2, unrevised). **`src-0019` and `src-0022` have still never had
  one.**
- **[158] `src-0011` is now the stalest source in the base** (last checked cycle 33),
  followed by `src-0013` (35) and `src-0014` (36). Cycle 56 deliberately skipped it in favour
  of `src-0009`/`src-0010` because `src-0011` supports only a **proposed** candidate and
  could not move a score; that reasoning is spent now and a successor should take it.

**Inherited from cycle 55 and below — reproduced without editing:**

## Carry-forward items

**New at cycle 55:**

- **[147]** `ctr-0023` — the first contradiction this base has opened against an **artefact
  enumeration**, rather than against a quotation, a number, an arithmetic derivation, or a
  relation. Steps (ii), (iii) and (iv) are **open**. **Step (ii) is the `index.json` +
  `src-0017.md` append that cycle 55 admits it skipped for turn budget** — the same step four
  earlier contradictions left undone. It is the cheapest available repair.
- **[148]** **The src-0023 / CTIArena ATT&CK check — flagged by cycle 50's T4 and still never
  done, now five cycles old.** Whether CTIArena (arXiv 2510.11974, accepted to KDD 2026)
  reports *any* ATT&CK/TTP mapping task and **under what scoring rule** — and per rule (iii)
  the rule matters more than the value. This is a T3 action against an **already-collected**
  source and does not make anyone a T1. If it does report one with a readable rule it is the
  **third independent measurement** `ttp-attack-mapping-reliability`'s route to a 3 has needed
  since cycle 31. *Caution so the fetch is not wasted:*
  `consistency-calibration-as-failure-mode` `open_questions[5]` records that CTIArena was
  fetched at cycle 25 and measures neither repeat-query consistency nor calibration/abstention
  — **that kill is for that issue only and says nothing about ATT&CK/TTP.** Also: src-0023
  carries the unresolved GPT-5-vs-GPT-4 judge discrepancy ([109]) and has never been
  independently verified by any cycle other than the one that added it.
- **[149]** `ttp-attack-mapping-reliability` `open_questions[3]` is an explicit **T1
  collection lead** (locate CTIBench's evaluation code, read the CTI-ATE scorer) — **but
  src-0019 IS the CTIBench artefact release, added at cycle 43, so check src-0019 first before
  treating it as a T1 lead.** Still unchecked.
- **[150]** **The `fn`-line render conflict inside `eval_ttps_utils.py`** — three renders,
  three answers, deliberately unresolved and nothing stored from any of them. See ctr-0023.
  Matters if real: the recall **denominators** of the four scoring variants may differ from
  one another. Cheap untried routes, both small enough to fetch whole:
  `stage3_ti_drafting/ttp/example/simple_test.py` (7,953 bytes) and
  `stage3_ti_drafting/ttp/README.md` (16,236 bytes).
- **[151]** Candidate rule **(xx)** — re-enumerate the artefact before trusting a definite
  article. Offered, not imposed; a successor should rule on whether it is distinct from (v).

**Discharged at cycle 55:**

- **ctr-0015 step (iii)** and **ctr-0016 step (iii)** — **DISCHARGED**, by the single edit
  both demanded, nine and eight cycles after they were opened. The `index.json` half of
  ctr-0015(iii) was already discharged by construction via `src-0021` `key_claims[4]`.
- **`open_questions[4]` sub-question (a)** — **ANSWERED FOR THE WORKED EXAMPLE ONLY**, by the
  first of the two cheap routes cycle 32 named. Ground truth is parent-level, in `'ID - Name'`
  form. **Still open for the 100-days corpus**, which truncates.
- **[146]** the jq-truncation trap — heeded, not discharged; it remains true and is now worse
  (`open_questions[1]` is 9,577 chars).

**Still open and inherited — the full chain from cycle 54 follows verbatim below.**

## Carry-forward items

**New at cycle 54:**

- **[140]** `ctr-0022` — the first contradiction this base has opened against a **similarity /
  relation claim**, rather than against a quotation, a number, or an arithmetic derivation. Its
  repair steps (ii), (iii), (iv) and (v) are **open**. Step (ii) is the text repair in three
  places; step (iii) is the reassessment of `candidate_resolutions[2]`'s independence claim,
  which is the one that actually bears on the score.
- **[141]** GPTZero's automated sweep **publishes numerators without a denominator** —
  established at source this cycle, not assumed. It therefore **cannot** close
  `institutional-incident-real-world-impact`'s `open_questions[0]` base-rate question as
  published, however many further incidents it names. Cycle 13 recorded the pipeline as a
  promising T1 lead; forty-one cycles later this is the first record of *why* it is structurally
  incapable of yielding a rate.
- **[142]** Named, unfetched collection leads sitting in `src-0012.md` since cycle 13 —
  **forty-one cycles**: "a government publication, two different Deloitte reports", plus NeurIPS
  and ICLR. These are verifiable and would bear directly on the recurrence claim that ctr-0022
  has just weakened, and they would be found by an *unprompted* route only if a different
  investigator found them.
- **[143]** The recovered sentence "The erroneous data in the EY study included references to a
  fabricated McKinsey report that claimed US$200 million in unredeemed loyalty rewards globally."
  — the **first concrete instance** of a hallucinated citation in the EY incident that this base
  holds. Previously it held only the count.
- **[144]** Candidate rule **(xix)** on checking similarity claims at source (above). Accept,
  merge into (viii), or reject.
- **[145]** **Cycle 51's ad-hoc tie-break extension SPLITS on the cycle-54 tie** — its two limbs
  (fewer total attempts; longer since last attempt) point to different issues. It is therefore
  not a general patch for **[75]**, and [75] is now urgent rather than latent: **two consecutive
  T5s have exhausted the stated ladder**.
- **[146]** The **jq-truncation trap**: `graph.json` open_questions run to ~7000 characters, and
  a `.[0:900]` slice hid the string a repair step referred to, briefly convincing me that
  ctr-0015(iii) named the wrong `open_questions` index. Print field **lengths** first.

**Updated at cycle 54:**

- **[75]** — *escalated*. The tie-break ladder produced no total order for the **second
  consecutive T5**, on a different pair from cycle 51's, and the first ad-hoc patch does not
  generalise (see [145]). Needs a human ruling.
- **[30]** — *escalated*. `created_cycle` was again load-bearing, and this time it eliminated
  `automated-triage-under-refusal`, an issue never attempted in 54 cycles, **purely for being
  younger**.
- **[137]** — *updated*. `automated-triage-under-refusal` has still never been attempted, and
  cycle 54 records that it was eliminated **solely** by tie-break (c) on `created_cycle`, a
  ground unrelated to its weakness or tractability.
- **[136]** — **rule (xviii) ACCEPTED at cycle 54** as distinct from (xii).
- **[109]** — still open and now doubly relevant: `src-0023` has never been independently
  verified by any cycle other than the one that added it, and cycle 55 is being asked to fetch it
  for the ATT&CK-scoring-rule check.
- **[4]** — the G3 subtraction-versus-ceiling conflict, **forty-third cycle**, still awaiting a
  human. Note that ctr-0022 adds a *third* open contradiction to
  `institutional-incident-real-world-impact` and, under the **ceiling** reading, changes nothing;
  under the **subtraction** reading it would now drive that issue's score to **−3**, which is
  outside the stated scale entirely. That is the starkest reductio of the subtraction reading yet
  recorded.
- **[41]** — the single `issue_id` field on contradictions. Cycle 54 notes a further wrinkle:
  ctr-0022's finding bears on `institutional-incident-real-world-impact` (where it is filed) but
  the *evidence* for it lives in `src-0012`, which is also the subject of no other entry, while
  the `open_questions[4]` text it impeaches is shared reasoning with `src-0004`. One field still
  cannot express this.

**Inherited chain — copied verbatim below from `logs/cycle-053.md`, including items I could not
act on.**

## Carry-forward items

**Cycle 53's own new items are at the top. The inherited chain follows verbatim below,
copied mechanically from `logs/cycle-052.md` lines 316–2076 rather than retyped.**

- **[133] ctr-0021 — the first contradiction this base has opened against an ARITHMETIC
  DERIVATION rather than a quotation or a number.** Repair steps (ii), (iii) and (iv) are
  OPEN. Step (ii): correct the derived rate in `src-0007.md` claim 3 and
  `automated-triage-under-refusal` open_questions[2], replacing "passes through 2 of every 3
  items a human analyst rejects" with "roughly 2 of every 3 items the system **accepts** were
  rejected by the ground truth", and record FP/(FP+TN) as **uncomputable** from the published
  figures. Step (iii): requalify open_questions[1]'s premise as an inference, or find the
  sentence that establishes it. Step (iv): **wire the 55–60% priority-scoring accuracy and the
  Pass Rate (Score) rows into the issue** — the only one of the four that *adds* evidence
  rather than correcting text.
- **[134] src-0007's TMLR provenance RECORDED after sixteen cycles of being flagged.**
  Discharges the collection half of [130]. **The general lesson: the one-fetch `/abs`
  provenance bolt-on pays off.** src-0001's ARES 2025 status is the identical shape — one
  fetch of `https://doi.org/10.1007/978-3-032-00627-1_17` — and is **still undone**.
- **[135] The recovered 55–60% priority-scoring accuracy and Pass Rate (Score) rows are
  UNUSED EVIDENCE ALREADY IN THE BASE.** They measure the task
  `automated-triage-under-refusal` is *named after* and no cycle has ever used them. Now in
  src-0007's key_claims and `src-0007.md`.
- **[136] Candidate rule (xviii), offered not imposed.** *When the state converts a reported
  metric into a different quantity — a precision into a false-positive rate, a rate into a
  count, a within-group share into a population share — re-derive the conversion from the
  definitions before trusting it, because no string check and no number check will catch an
  invalid conversion: both endpoints can be verbatim-correct while the step between them is
  nonsense.* A successor should decide whether this is genuinely distinct from (xii) or a
  special case of it.
- **[137] `automated-triage-under-refusal` has NEVER been attempted in 53 cycles** — its
  `attempts` array is empty. No prior selection appears to have weighed this.
- **[138] src-0007's Table 4 has now defeated TWO careful readings** — ctr-0008 (metric
  definition inside the table) and ctr-0021 (derived rate from the triage rows). Any future
  citation of any Table 4 cell should be treated as high-risk.
- **[139] The `scores.json` editing method** recorded under Budget above, which made a
  nine-issue rescore cost four Edits' worth of anchoring.
- **[130] UPDATED — HALF DISCHARGED.** The ctr-0001 provenance asymmetry: src-0007's TMLR
  status **is now recorded**; only the **weighting** of the two sides remains, and that is a
  T3's call.
- **[41] UPDATED — now demonstrated in BOTH directions.** The single `issue_id` field
  under-counts *and* mis-attaches: ctr-0018 imposes a ceiling on
  `institutional-incident-real-world-impact` via src-0022, **a source that issue does not
  cite**.
- **[4] UPDATED — starkest illustration yet.** Under the subtraction reading,
  `institutional-incident-real-world-impact` would score **1** rather than **3**. Forty-second
  cycle awaiting a human.
- **[97] UPDATED — fifth ad-hoc decision, and cycle 53 declared its dependence.**
  `attribution-expressed-confidence-unmeasured` scores 2 **only** under [97]-as-no; under
  [97]-as-yes it is arguably the best-resolved issue in the graph. `ttp-attack-mapping-
  reliability`'s candidate[4] is exposed to the same question.
- **[122] SUPERSEDED.** The stalest source is now **src-0012** (cycle 31); src-0007 was
  discharged at cycle 53.

## Carry-forward items

### New and updated at cycle 52

- **[125] ctr-0014 DISCHARGED AT CYCLE 52 — INCLUDING THE DISCOVERY THAT ITS OWN STEP (i) WAS
  NEVER PERFORMED.** ctr-0014 recorded step (i) (append to `index.json`) as done at cycle 43. It
  was not. So the tally is four skips of step (ii) **plus one of step (i)**, and this is the fifth
  "completed" step in this project found undone on inspection. Both are now done, and step (iii)
  is settled: `76%` and `72%` are **ABSENT** from src-0003's body at **both** v1 and v2 on
  renderings that self-reported reaching §5.1.1 and not truncating, so cycle 22's figure-derived
  ruling is **confirmed** for those two and refuted only for `86%`. Discharges the
  ctr-0011/0012/0013/0014 chain's most repeated unfinished action. Supersedes the "76%/72%
  unverified in both directions" status.
- **[126] ctr-0020 OPENED — the TENTH rule-(iii) contradiction.** src-0003 states its 43% in three
  wordings naming three quantities (time spent on a report / parsing time / work factor) and the
  state calls it a fourth thing, *"junior analysts' manual annotation time"*, which narrows a
  population the source leaves broad (five junior **plus one senior**; the paper's own phrase is
  "our evaluation with six analysts"). The **only** analyst-productivity number in this base,
  sitting inside a **supported** candidate. Repair steps (ii)–(iv) are open: (ii) fetch the HITL
  evaluation section end to end and settle whether the timing is restricted to the juniors —
  cheap and decisive; (iii) a T4 should note how much qualification `candidate_resolutions[0]` now
  carries; (iv) another instance of **[41]**.
- **[127] THE TRUNCATION-PROBE HARDENING TO THE VERIFICATION-MODE PROMPT.** Item 0: *"can you see
  Section X — YES/NO, quote its first sentence"*. Last item: *"were you truncated — YES/NO, where
  does it stop"*. Turns rule (xvi) from a post-hoc reason to discard an ABSENT into a test the
  fetch answers for you. **This is what settled a stalemate cycle 43 had to abandon**, and it
  costs one line of prompt. Companion to [119]/cycle 51's paragraph-first-word clause.
- **[128] `open_questions[6]`'s NET SIGN AND MAGNITUDE WAS NOT REACHED AT CYCLE 52.** It was item
  (4) of the cycle-52 priority list and the budget went on items (1)–(3). It remains
  `ioc-extraction-reliability`'s largest unmeasured quantity: the one-directional matcher
  (`pred.lower() in gt.lower()`) is lenient toward fragmentary predictions and strict against
  verbose ones, which are penalised as FP **and** FN simultaneously; the net sign is the
  difference of two unmeasured quantities. Cycle 35's partial mitigation (both sides pass a
  normalisation chain stripping defanging and truncating at the first `" - "`) must be re-read
  before anyone spends on this. **Do not** re-fetch the HuggingFace or GitHub mirrors — cycle 35
  established the per-model predictions' absence authoritatively.
- **[129] src-0018 PASSED ITS G2 CLEAN, and the paragraph hardening fired benignly for the first
  time.** Fourth independent confirmation that its `LLM decision consistency` table is
  image-locked. One previously unrecorded fourth paragraph sentence recovered — the source's own
  acknowledgement of *"trade-offs in extraction completeness and correctness"* behind the 18×
  speed-up — which **corroborates** rather than conflicts with the state, so no contradiction was
  opened. Recorded because a run of defect-finding G2s can make a clean one look like a missed
  defect; it was not.
- **[130] THE PROVENANCE ASYMMETRY INSIDE ctr-0001 IS NOW EXPLICIT AND HALF-UNRECORDED.**
  src-0003 (the 97.6% side) is an **unreviewed preprint with no venue** — no `Comments:`, no
  `Journal reference:` on its arXiv abstract page. src-0007 (the 0.82–0.88 side) carries
  *"Accepted at TMLR"* and a TMLR journal reference — **and that is still not in the base after
  fifteen cycles of being flagged.** One `/abs` fetch records it. Until it is, ctr-0001's two
  sides are being weighed without their provenance.
- **[131] CYCLE 51's LOG NUMBERS ITS NEW ITEMS [116]–[124]; ITS OWN QUEUE ENTRY'S ABRIDGEMENT
  LISTED ONLY [116]–[119].** The log is authoritative. Cycle 52 therefore numbers its own items
  from **[125]** to avoid collision. A successor copying the carry-forward list **mechanically**
  from the log, as instructed, will not hit this; a successor retyping from a queue entry will.
  One more reason the `sed` copy is not a formality.
- **[132] A HEREDOC OF ~250 LINES ABORTS THE SHELL PARSER.** Cycles 46–51 each appended 100+ lines
  successfully, so the limit sits between. Use the **Write** tool for a whole log and reserve
  `cat >> file << SPIRALEOF` for appends of ~100 lines or fewer. Costs a wasted turn if ignored.
- **[81] partially discharged at cycle 50** — see [113]. **[107] discharged at cycle 50.**
  **[55] withdrawn at cycle 49** — see [112]. **[117]/[118] (ctr-0019) discharged at cycle 52.**
  **[121] (ctr-0014's ctr-0007-is-open slip) restated in place at cycle 52.** **[122] (src-0018
  stalest) discharged at cycle 52 — the stalest source is now `src-0007`, last checked cycle 30.**

### Inherited chain, copied verbatim from `logs/cycle-051.md` below

Copied mechanically with `sed -n 337,2027p logs/cycle-051.md >> logs/cycle-052.md` rather than
retyped, per the standing instruction — retyping is what makes wording drift. Cycle 51's own new
items appear at the top of the copied block under its "New and updated at cycle 51" heading, and
the older chain below that. **The seventeen-part methodological rule is reproduced in full inside
the copied block.**

## Carry-forward items

### New and updated at cycle 51

- **[116] THE TIE-BREAK LADDER WAS EXHAUSTED FOR THE FIRST TIME.** `ioc-extraction-reliability`
  and `consistency-calibration-as-failure-mode` tied on score, upstream depth, attempt
  penalty *and* `created_cycle` (both 2). Cycle 51 broke it by extending tie-break (b)'s
  anti-thrashing rationale past its five-cycle window (3 attempts / last at 35, against 5
  attempts / last at 39), with open-contradiction count concurring independently. **This is
  an ad-hoc extension, not policy, and a human should rule on it.** Six of the nine issues
  share `created_cycle 2`, so the tie will recur. Supersedes nothing; makes **[75]** and
  **[30]** demonstrated rather than predicted.
- **[117] A SECOND, DECISIVE AMBIGUITY IN TIE-BREAK (a), WHICH CHANGES THE ANSWER.** Read
  pairwise ("X outranks its own dependents") the rule is silent between IOC and CC. Read as
  a count of dependents it selects `consistency-calibration-as-failure-mode` outright and no
  tie ever arises. Cycle 51 applied the pairwise reading as the one the prompt's wording
  licenses, and records that **the two readings select different issues on this graph**.
  Needs a human. Distinct from [75].
- **[118] ctr-0019 — the SIXTH omitted-material defect and the THIRD defective G2
  correction** (after ctr-0011 and ctr-0014). The omitted material was the sentence
  *immediately before* the quoted pair, two sentences up: src-0008 states "all evaluated
  LLMs achieve 100% detection when the IoC appears in plain text" at P0, so the state's
  four-versus-one model split holds at P1–P4 and **not** at P0. Three repair steps, all in
  the cycle-52 T3's instructions.
- **[119] THE PARAGRAPH-FIRST-WORD HARDENING TO THE VERIFICATION-MODE PROMPT.** Cycle 50
  extended rule (iv) to the whole paragraph; cycle 51 turned that into an operational clause
  that costs nothing and produced ctr-0019: on at least one item, ask for *"THE ENTIRE
  PARAGRAPH containing it, from the paragraph's first word to its last word."* Reading a
  paragraph from its *middle* is how both ctr-0018 and ctr-0019 happened.
- **[120] ctr-0019 IS THE CLEANEST DEMONSTRATION OF RULE (viii) IN THIS BASE.** Every string
  cycle 35 stored reproduced exactly at cycle 51, and the claim built from them was still
  wrong at P0. A clean string sweep is not a pass.
- **[121] ctr-0014's DESCRIPTION LISTS ctr-0007 AS OPEN; IT WAS RESOLVED AT CYCLE 35**, eight
  cycles before ctr-0014 was written. Bookkeeping slip inside a contradiction description,
  not a conflict between supported claims; restate in place per ctr-0010's precedent.
- **[122] src-0018 IS NOW THE STALEST SOURCE IN THE BASE** (last verified cycle 28 —
  twenty-four cycles) and has been top of the G2 recommendation list for **four** consecutive
  cycles without being picked. Cycle 51 picked src-0008 (c29) over it and got a contradiction;
  src-0018 is a figure-locked-numbers source, which is the shape rule (xvi) catches.
- **[123] CARRY-FORWARD [4]'s SECOND LIMB NOW HAS A THIRD DEMONSTRATED INSTANCE.**
  `ioc-extraction-reliability` went from four open contradictions to five at cycle 51 with no
  change in the G3 gate's output, because lines 146–149 build the open set as a set
  comprehension over `issue_id`.
- **[124] WEBFETCH CACHES PER URL FOR 15 MINUTES.** Re-asking the *same* URL is not an
  independent second look, which matters directly for rule (v)'s second-URL-form requirement.
  Always change the URL form. Recorded because no prior cycle states it.
- **[81] partially discharged at cycle 50** — see [113]. **[107] discharged at cycle 50.**
  **[55] withdrawn at cycle 49** — see [112]. Unchanged this cycle.

### Inherited chain, copied verbatim from `logs/cycle-050.md` below

Copied mechanically with `sed -n 246,1879p logs/cycle-050.md >> logs/cycle-051.md` rather
than retyped, per the standing instruction — retyping is what makes wording drift. Cycle
50's own new items appear at the top of the copied block under its "New and updated at
cycle 50" heading, and the older chain below that. The seventeen-part methodological rule is
reproduced in full inside the copied block.

## Carry-forward items

### New and updated at cycle 50

- **[112] `src-0022` IS CITED BY NO ISSUE AND NO ASSESSMENT — seven cycles after collection.** Zero
  references across every `candidate_resolutions.evidence` array and every `scores.evidence` array.
  Eight cycles called it the highest-value uncollected source; cycle 43 collected it; nobody used it.
  This is `ctr-0018` repair step (iv) and it is **the highest-value undone action in the project**,
  because it is the only one that would move a score using evidence already paid for. Needs a T2 or T3.
- **[113] `src-0022`'s two remaining single-form absences** — no January 2026 windowed report count,
  no count or percentage of AI-slop reports. Cycle 50 re-asked them on the permalink only.
  `https://daniel.haxx.se/blog/2026/01/` is now a **proven** second URL form serving the post body in
  full, so this is a one-fetch job.
- **[114] Methodological rule (iv) extended to paragraph level.** In `ctr-0018` the omitted material
  was not a clause of the quoted sentence but **the sentence immediately before it in the same
  paragraph**. Pull the whole paragraph, not just the whole sentence. Fifth instance of the
  omitted-material shape.
- **[115] Verification-mode prompt hardening.** Cycle 50's discovery fetch answered PRESENT to an
  item and then quoted an entirely different passage. Add to the rule (xv) shape: *"do NOT substitute
  a nearby or similar sentence; if you cannot find the exact string, answer ABSENT even if something
  similar exists."* Only the exact-string confirmation pass caught this.
- **[107] DISCHARGED at cycle 50** — the falsified "a T3 aimed at it would find nothing to
  investigate" sentence in `scores.json` is now marked false in place with its falsifying evidence,
  not deleted.
- **[81] HALF DISCHARGED at cycle 50** — the "about 15%" baseline is now verified at primary source
  on two URL forms; the "~20% AI-generated" figure is now ABSENT on two forms and **remains
  prohibited**. The unfetched `github.com/curl/curl/pull/20312` is still undone.
- **[4] second limb now has TWO demonstrated instances**, not one:
  `institutional-incident-real-world-impact` went from one open contradiction to two at cycle 50 and
  the gate's output did not change by a single point, exactly as `ioc-extraction-reliability` shows
  with four.
- **[41] now has a second demonstration**: `ctr-0018` concerns a source belonging to **two** issues
  and the schema's single `issue_id` field forced cycle 50 to file it against one, so no per-issue
  query surfaces the exposure on the other. Under rule (vi), `automated-triage-under-refusal`'s clean
  G3 status must **not** be read as meaning src-0022 is clean for its purposes.
- **[97] decided again, ad hoc and reversibly, for the fourth time.** Cycle 50 ruled that a negative
  finding may be a legitimate *resolution* but does **not** buy source-counting credit toward rubric
  line 3, and that negatives are held to the same verification standard as positives. Consistent with
  cycles 47 and 48. **Four cycles have now decided this identically without authority — that is a
  convention forming by default and a human should settle it.**
- **[30] and [75] are now load-bearing, not theoretical**, because cycle 50 compressed the graph to
  eight issues at 2 and one at 3. The tie-break ladder is now the entire selector.
- **`ctr-0018`'s five repair steps, all new and all undone.**
- **`web.archive.org` is blocked** in this sandbox — not available as a second URL form. For a
  WordPress blog, the monthly archive page serves post bodies in full and is a valid substitute.

### Inherited chain, copied verbatim from logs/cycle-049.md below

## Methodological rule, in seventeen parts — reproduced in full

These are the accumulated cost of twenty-five source-checks, fifteen of which found a defect.
Cycle 49's check was clean, which is data too.

**(i)** Ask the fetch for the ENTIRE ROW / TABLE / PASSAGE / FILE VERBATIM with an explicit
instruction to write 'ABSENT' or 'CANNOT READ' rather than infer; never accept a summarised "the
value is/isn't X". BUT SEE (xvii), WHICH LIMITS THIS RULE.

**(ii)** String-search the EXACT stored quotations AND the exact stored NUMBERS.

**(iii)** ALSO PULL THE VERBATIM DEFINITION OF THE METRIC, not only its value — this single check
produced ctr-0002, ctr-0003, ctr-0004, ctr-0006, half of ctr-0007, ctr-0008, ctr-0009, ctr-0013
AND ctr-0017.

**(iv)** PULL THE WHOLE TABLE, not the rows the claim needs — this applies to COLUMNS (cycle 39's
Brier finding) AND TO WHOLE SENTENCES. QUOTE THE WHOLE SENTENCE, INCLUDING ITS PARENTHETICALS:
ctr-0012 exists because a subordinate clause of the very sentence this base quotes was dropped;
ctr-0015 is the second instance; ctr-0016 the third; ctr-0017 the fourth, which makes the
omitted-clause shape comfortably the most frequent single defect in this base. IN ALL FOUR THE
OMITTED MATERIAL SAID WHAT THE MEASUREMENT WAS COMPUTED OVER, OR THAT A SECOND MEASUREMENT
EXISTED.

**(v)** A PRESENT verdict may be trusted from one fetch; an ABSENT verdict MUST be confirmed
against a second URL form — checking FOUR things first: the ABSTRACT, a DIFFERENT URL RENDERING,
THAT YOU FETCHED THE FILE THE CLAIM ACTUALLY CITES, and THAT THE VERSION YOU FETCHED CONTAINS THE
MATERIAL AT ALL. **THIRTEEN instances now.** Cycle 39's showed rule (v) governs a G2's OWN
CORRECTIONS; cycle 42's added sub-rule (xvi); cycle 45 showed the fourth check is not
hypothetical — its second fetch went to an ar5iv render serving an OLDER VERSION and returned
four confident spurious ABSENTs; cycle 46 found a single fetch response that returned ABSENT for
an exact string and then, TWO ITEMS LATER IN THE SAME REPLY, quoted that very string — READ THE
WHOLE REPLY BEFORE BELIEVING ANY ITEM IN IT; cycle 48 licensed an absence ONLY because the same
fetch separately confirmed the two appendix bodies were VISIBLE while reporting the document
truncated overall; **and CYCLE 49 ADDED THE MOST VIVID INSTANCE YET — two URL forms of arXiv
2510.11974 served two DIFFERENT PAPERS, titled CTIArena at v1 and CTIConnect at v2, renamed and
substantially rewritten between versions.**

**(vi)** A SOURCE CAN BE CLEAN WHILE THE STATE'S ACCOUNT OF IT IS NOT — nine instances (ctr-0008,
ctr-0011, ctr-0012, ctr-0013, ctr-0014, ctr-0015, ctr-0016, ctr-0017) — and the CONVERSE also
holds, so READ THE STATE BEFORE RE-DERIVING ANYTHING FROM A LOG. Cycle 48 is the cleanest
example: every stored string in src-0005 re-verified PRESENT and exact, and the source was still
mischaracterised.

**(vii)** CHECK HEDGES IN BOTH DIRECTIONS — a hedge is a claim and must be scoped as precisely as
an assertion; src-0022's curl entry is the live example.

**(viii)** STRING-MATCHING A CLAIM'S QUOTATIONS AND NUMBERS DOES NOT TEST ITS QUANTIFIER OR ITS
SCOPE — ctr-0012 is the clean counterexample to its sufficiency, ctr-0015 the second, ctr-0016
the third, ctr-0017 the fourth. FOUR FOR FOUR. **A CLEAN STRING SWEEP IS NOT A PASS.** Cycle 49
honoured this by also pulling the verbatim body of `compute_taa_accuracy` rather than stopping at
the function name.

**(ix)** VERIFYING A VALUE DOES NOT VERIFY WHAT THE VALUE MEASURES; ASK WHETHER THE SAME METRIC
NAME IS DEFINED MORE THAN ONCE — and, new at cycle 48, WHETHER MORE THAN ONE METRIC EXISTS WHERE
THE STATE RECORDS ONE.

**(x)** WHEN A FILE IS LARGE, GET ITS BYTE SIZE FROM THE HOSTING API BEFORE RECORDING ANY ABSENCE
— GitHub git-trees API with `recursive=true`; HuggingFace tree API with `recursive=true`.

**(xi)** "WHICH TEXT EXECUTES" IS NOT A PRESENT VERDICT.

**(xii)** A DERIVED NUMBER MUST BE AUDITED AGAINST THE LOG THAT DERIVED IT, NOT AGAINST THE STATE
THAT CITES IT. UNAUDITED DERIVED QUANTITIES: src-0002's five derived percentage points,
src-0006's derived stage means and ranges, cycle 18's src-0006 crossover means, the four
normalisation figures on `extraction-vs-reasoning-ordinal-axis`'s route 2, cycle 46's
76.48−12.99=63.49 and 87.39−58.02=29.37, cycle 47's 981/2,076=47.3% and its "two technique
occurrences per technique" figure, and the identity J = F1/(2−F1) relating Jaccard to F1.
**CYCLE 47's NOTE STANDS AND IS STILL UNDONE:** auditing src-0006's derived stage means is the
single cheapest thing that would move `task-dependent-reliability-framing` OR
`extraction-vs-reasoning-ordinal-axis` off 2, and it is NOT new collection.

**(xiii)** RULE (ix) CUTS BOTH WAYS: a summarised read can MANUFACTURE a defect that is not
there. BEFORE OPENING A CONTRADICTION ON THE STRENGTH OF A SUMMARY, GO BACK AND GET THE ARTEFACT
VERBATIM. A false contradiction is more expensive than a missed one — cycle 21's false quotation
defect survived eighteen cycles. THE SETTLED PRACTICE: **DISCOVERY FETCH, THEN EXACT-STRING
CONFIRMATION, THEN OPEN.**

**(xiv)** A CORRECTION IS A CLAIM AND MUST BE RE-VERIFIED LIKE ANY OTHER; prefer re-checking a
stored CORRECTION over a stored CLAIM when both are equally stale. FOUR CONTRADICTIONS (ctr-0011,
ctr-0014, ctr-0016, ctr-0017) AND ONE CLEAN PASS; at 4-of-5 the highest-yield rule in the list,
but a successor must NOT treat every stored correction as presumptively rotten.

**(xv)** SOME FETCHES REFUSE VERBATIM REPRODUCTION ON COPYRIGHT GROUNDS AND RETURN A SUMMARY
INSTEAD, WHICH RULE (ix) MAKES WORTHLESS. THE WORKAROUND, PROVEN AT CYCLES 41, 43, 46, 47, 48 AND
49: a VERIFICATION-MODE prompt — numbered items, each answered PRESENT or ABSENT, and for PRESENT
quote ONLY the single full sentence containing the item, with an explicit instruction to answer
CANNOT READ if the body is not visible, PLUS an explicit "reproduce the sentence to its very end,
do not stop early" instruction. IT IS THE DEFAULT SHAPE FOR ANY VERIFICATION FETCH.

**(xvi)** WHERE A PAPER'S HTML IS LONG ENOUGH TO TRUNCATE, AN ABSENT VERDICT ABOUT ANY PART OF IT
IS WORTHLESS. ASK THE FETCH DIRECTLY WHETHER IT CAN SEE THE SECTION YOUR ABSENCE CONCERNS — not
merely whether the document is complete. **Cycle 49 applied this and consequently did NOT claim
src-0023's Appendix D prompt templates are clean**, because neither fetch could read them. The
cycle-42 fix (fetch `/html/<id>v1`, whose HTML is shorter) is STILL UNTRIED on src-0003,
carry-forward [90].

**(xvii)** THE WORD "VERBATIM" IN A PROMPT DOES NOT BIND THE FETCH. At cycle 45, three asks
produced THREE DIFFERENT RENDERINGS of one sentence. SO: **BROAD ASKS ARE FOR DISCOVERY. ONLY A
PRESENT/ABSENT EXACT-STRING ASK ON A STRING YOU ALREADY HOLD MAY BE STORED AS A QUOTATION.**
Cycle 49 applied this to the GPT-5-versus-GPT-4 judge discrepancy and stored **no claim in either
direction**.

**Standing observation from cycle 48, not yet a numbered rule:** ctr-0017 is the first defect
found in a prior G2's OWN APPENDIX. A THOROUGH PRIOR CHECK IS NOT A REASON TO SKIP A SOURCE; it
only changes what you should look for, from "are the strings right" to "is anything missing".

**New observation from cycle 49, not yet a numbered rule:** a G2 target and a main-task target
can be the *same artefact*, and choosing that overlap deliberately buys two results for one
fetch. `src-0019` was both the stalest unchecked source in its cohort and the most authoritative
possible test of the main question. When they can be made to coincide, make them coincide.

---

## Carry-forward items

### New and updated at cycle 49

- **[107] THE `scores.json` RATIONALE SENTENCE FALSIFIED BY CYCLE 49 — AWAITING THE T4.**
  Cycle 47's rationale for `attribution-expressed-confidence-unmeasured` ends with a "STANDING
  FACT FOR THE NEXT T5" asserting the issue's "primary open question is a COLLECTION question
  that no scheduled task currently reaches" and "A T3 aimed at it would find nothing to
  investigate; a T1 would." Both halves are false; cycle 49 was that T3, collected two sources
  and produced two supported candidates. **A T3 may not rescore, so this was deliberately left
  untouched.** Cycle 50's T4 must correct it, and must record that it was falsified and by what,
  rather than silently deleting it.
- **[108] `src-0023`'s APPENDIX D PROMPT TEMPLATES ARE UNREAD, AND THE ABSENCE THERE IS NOT
  ESTABLISHED.** Both fetches failed to read Appendix D — the v1 render truncated mid-sentence
  inside it, the v2 render could not see it at all (last visible heading "A.4. Magniber
  Cross-Source Correlation Case Study", References visible). Prompt templates are exactly where a
  confidence-elicitation instruction would live. Under rule (xvi) this absence is worthless until
  someone reads them. Routes: the ar5iv render, or the KDD 2026 proceedings. **Partially
  discharges [88]** — see [88] below.
- **[109] `src-0023`'s UNRESOLVED JUDGE DISCREPANCY.** The v1 render returned "we employ GPT-5 as
  an automatic judge…" and the v2 render "we employ GPT-4 as an automatic judge guided by a
  structured rubric." Under rule (xvii) neither is storable and **this base records no claim
  about which model judges this benchmark**. Plausibly just the version difference; not confirmed,
  not asserted. One exact-string ask settles it.
- **[110] THE MISP TAXONOMY LEVEL SETS ARE UNFETCHED.** `src-0024` gives only example tag values
  (`"a/b/c..."`, `"almost-no-chance"`, `"moderate"`). The full enumerations live at
  `misp-project.org/taxonomies.html#_admiralty_scale` and `#_estimative_language`. Nobody may
  state how many levels each axis has, or what they are, without fetching those pages and adding
  them properly. Also unrecorded: the Admiralty scale's information-credibility axis (the numeric
  half) is NOT named in the file read, and its presence must not be assumed.
- **[111] `src-0015`'s "penalizes unknowns" CLAUSE — THE STRONGEST UNCHECKED
  ABSTENTION-ON-ATTRIBUTION LEAD IN THE BASE, AND IT IS CHEAP.** OpenSec's reward definition reads
  verbatim "Attribution rewards correct identification (+1 per correct field) and penalizes
  unknowns (-0.5 each)". Nobody has checked whether the paper reports an unknown-rate or
  abstention-rate anywhere. Not currently a counterexample to the survey finding (it is a
  training-signal component, and OpenSec's "Attribution" is incident-field identification in
  synthetic RL episodes, not threat-actor identification from a report) — but if a rate is
  reported, `attribution-expressed-confidence-unmeasured`'s primary question changes shape.
- **[104] UPDATED — THE T3 PROMPT AUTHORISES COLLECTION.** Confirmed at source by cycle 49,
  independently of cycle 48. Step 2 of `prompts/t3_investigate.md` explicitly permits web-search
  and source-addition when the knowledge base cannot answer. **Acted upon**: cycle 49 collected
  `src-0023` and `src-0024` under this clause.
- **[55]/[96] UPDATED — THE STARVATION PROOF IS NOW FULLY WITHDRAWN, NOT MERELY DOUBTED.** Cycle
  48 substantially withdrew it; cycle 49 verified the premise at source and then falsified the
  conclusion empirically by scheduling a T3 at the issue and collecting against it. The false
  sentence is repaired in `graph.json` `open_questions[1]`. What remains is the `scores.json`
  echo, [107].
- **[88] PARTIALLY DISCHARGED.** This item wanted "a second CTI-task ECE/Brier calibration
  source" and had never been reachable. Cycle 49 reached it and **searched specifically for one**
  — five directions — and found none on an attribution task. The item is not closed (a second
  CTI-task calibration source on *some* CTI task may still exist), but it is no longer
  unreachable, and the negative for the attribution case is now on record with its scope stated.
- **[112] A NEGATIVE'S SCOPE MUST TRAVEL WITH IT.** Cycle 49's searches were English-language and
  search-engine-mediated. The finding is "not found by five searches plus targeted checks of the
  nearest benchmarks", which is **weaker than "does not exist"**, and no cycle may upgrade it to
  the stronger form. This is recorded as a general discipline, not only about this issue.

### Inherited chain, copied verbatim from logs/cycle-048.md below

## Carry-forward items

*Cycle 48's own items are added at the top. The inherited chain below them is copied
**mechanically** from `logs/cycle-047.md` lines 268–1606 with `sed -n`, not retyped — retyping
is what makes wording drift. Nothing below was edited, including items cycle 48 could not act
on. Note that the inherited text contains several further `## Carry-forward items` headings from
earlier cycles; that is expected.*

### New and updated at cycle 48

- **[104] — NEW, AND IT SUPERSEDES [96] AND THE OPERATIVE PREMISE OF [55].** **A T3 is
  authorised to collect.** `prompts/t3_investigate.md` step 2, verbatim: *"Only web-search for
  what the knowledge base cannot answer (and if you fetch something substantial, add it properly
  as a source per T1 rules — it counts toward the same `max_new_sources` budget)."* The claim
  carried by [96], by [55]'s "starvation proof", and **by
  `attribution-expressed-confidence-unmeasured`'s own `open_questions[1]` in the graph** — that
  "NO SCHEDULED TASK CURRENTLY REACHES IT" — is **false**. **The graph sentence is still there
  and must be repaired by the cycle-49 T3** (T3 step 4 work; cycle 48 was a T5 and did not do
  the next cycle's job). No contradiction was opened, because G3's trigger is two *supported
  claims* and an `open_questions` annotation is not a candidate_resolution — precedent: cycle 26
  and `ctr-0010`. **What survives of [55]:** a T3's collection is *incidental* to one issue and
  shares the `max_new_sources` budget, so the loop still cannot mount a broad off-schedule
  collection sweep. That narrower constraint is real; the unreachability claim is not.
- **[105] — NEW.** **`ctr-0017`: `src-0005` reports a second, partial-credit metric.**
  CyberSOCEval reports **average Jaccard score** per model for both benchmarks, "which allows
  partial credit for multiple choice selections that overlap imperfectly with the correct set of
  answers", alongside the all-or-nothing accuracy the base stored as *the* metric at cycle 26.
  Since J = F1/(2−F1), this is a set-overlap statistic of the **same family** as the F1 measures
  against which the state declares src-0005 non-commensurable. **Four repair steps**, of which
  (i)–(iii) are T3/T4 work (amend the wording in `ctr-0009`'s seven-instance list and in
  `scores.json`'s `ttp-attack-mapping-reliability` rationale; re-examine whether the count of
  seven still holds) and **(iv) is unachievable by this agent** — no numeric Jaccard value exists
  in the document text, so the commensurable number cannot be read without OCR or released raw
  results. **Repair the reason, do not merely keep the verdict:** the better ground is that
  src-0005 scores a *closed, small option set* while src-0002/src-0007 score *open free-form
  extraction*.
- **[106] — NEW.** **`src-0005`'s "parsable responses" denominator is unread.** Appendix A's
  figure captions say *"Average number of questions with parsable responses within each topic
  reported as avg n, total parsable responses by model in each row."* So the 23–34% and 43–53%
  accuracies are computed over **parsable** responses, and the rule for handling unparsable model
  output has never been read. Not a contradiction — nothing in the state asserts otherwise — but
  it is a live "what was the measurement computed over" question, the shape that has produced
  four contradictions in this base.
- **[75] — UPDATED, with a live instance.** The tie-break ladder produced **no total order** in
  cycle 48's ranking table: rule (a) does not say how to rank two issues that both have
  dependents, and the ladder **terminated in a genuine unbroken tie** between
  `extraction-vs-reasoning-ordinal-axis` and `automated-triage-under-refusal` (same score, same
  zero penalty, no dependents either side, same `created_cycle` 16). The selection only survived
  because the *top* was unique. Still needs a human.
- **[97] — UPDATED, not reversed.** Cycle 47 decided, for its own arithmetic only, that a
  non-commensurability finding is not a resolution of an issue asking for a magnitude. Cycle 48
  did **not** revisit that (a T5 does not rescore) but adds evidence bearing on it: `ctr-0017`
  shows a non-commensurability claim in this very base resting on a **mischaracterised
  instrument**. That argues for holding negative findings to the same verification standard as
  positive ones — not for refusing them. Still needs a human.
- **Schedule arithmetic — CORRECTED.** Cycle 47 projected the next refresh-eligible T5 as
  **cycle 56**. Wrong: 56 is a T4, not a T5. From 48 the T5 cycles are 48, 51, 54, 57, 60, **63**,
  and 63 % 7 == 0. **The next refresh-eligible T5 is cycle 63, scheduling a T1 at cycle 64**
  (barring an abort, which shifts the phase). Re-derive rather than copy.
- **Methodological rules — updated at cycle 48.** Rule (iv): the omitted-clause shape is now
  **four** instances (ctr-0012, ctr-0015, ctr-0016, ctr-0017) and is comfortably the most
  frequent single defect here. Rule (vi): **nine** instances, and ctr-0017 is the cleanest —
  every stored string exact, the source still mischaracterised. Rule (viii): **four for four**;
  a clean string sweep is not a pass. Rule (ix): extended — ask not only whether a metric name is
  defined twice, but **whether more than one metric exists where the state records one**.
  Rule (xiv): now **4-of-5**, the highest-yield rule in the list. Rule (xvi): refined — a
  truncated document can still license an absence **if you ask the fetch separately whether it
  can see the specific section your absence concerns**, and get an explicit yes; asking only
  "is the document complete" is not enough. **New observation, not yet numbered:** ctr-0017 is
  the first defect found inside a *prior G2's own appendix*; a thorough prior check changes what
  you look for, from "are the strings right" to "is anything missing".
- **Source-check tally.** Twenty-four checks, **fifteen** with a defect.

### Inherited chain (cycles 47 and earlier, copied verbatim)

## Carry-forward items

*The chain below is copied **mechanically** from `logs/cycle-046.md` lines 258–1541 with
`sed -n`, not retyped — retyping is what makes wording drift. Cycle 47's own items are added
at the top; nothing below them was edited, including items cycle 47 could not act on.*

### New and updated at cycle 47

- **[101] — NEW.** **ctr-0016 step (iv): was `src-0020`'s κ=0.68 recomputed after phase (iv)?**
  The paper's headline says "Following the six-phase process, we reached a mean inter-annotator
  agreement of κ=0.68", but the annotation paragraph computes kappa at **phase (ii) of six**,
  with phase (iv) later described as a re-check "to verify κ improvement". No sentence read so
  far resolves this. **Nobody may resolve it by picking the reading that suits them.** Cheapest
  route: a fresh exact-string ask on `arxiv.org/html/2606.18166v1` for `recomputed`,
  `improved to` and `final agreement`; per rule (v) any ABSENT needs a second URL form.
- **[102] — NEW.** **The 981/2,076 relabelling figure is attached to no issue.** `src-0020`
  reports that **981 of 2,076 sentences (47.3%, cycle-47 derivation) were "low-agreement
  (κ<0.7)" and required relabelling** — measured over the *whole corpus*, unlike all three
  kappa values. It is now the base's **best** quantitative evidence that parent-level ATT&CK
  annotation is contested, and it sits only in `src-0020` `key_claims[3]` and `src-0020.md`.
  Attaching it to `ttp-attack-mapping-reliability`'s candidates is **T2/T3 work**; a T4 has no
  standing and cycle 47 did not do it.
- **[103] — NEW.** **Auditing `src-0006`'s derived stage means is the cheapest available move
  and requires no new collection.** It is the single action that would most plausibly lift
  *either* `task-dependent-reliability-framing` *or* `extraction-vs-reasoning-ordinal-axis` off
  2 — both currently rest on derivations on the rule-(xii) unaudited list. Rule (xii) requires
  auditing against **the log that derived them**, not against the state that cites them.
- **[97] — UPDATED, NO LONGER HYPOTHETICAL, AND DECIDED FOR ONE CYCLE ONLY.** Cycle 47 had to
  face it and recorded its reading verbatim in `scores.json`: *a non-commensurability finding
  is a genuine resolution of a methodological question but not of an issue whose title asks for
  a magnitude.* Applied consistently to `ttp-attack-mapping-reliability` candidate 5,
  `automated-triage-under-refusal`, and `attribution-expressed-confidence-unmeasured`. The
  contrary reading is recorded as respectable. **Still awaiting a human**; a successor may
  reverse it but must say so in writing.
- **[4] — UPDATED, SECOND LIMB ADDED.** Beyond the subtraction-versus-ceiling conflict, cycle 47
  records a second defect in the G3 gate: because lines 146–149 build the open set as a **set
  comprehension over `issue_id`**, `ioc-extraction-reliability`'s **four** open contradictions
  demote exactly as much as any issue's **one**. A gate meant to track evidential trouble
  cannot sensibly be blind to how much trouble there is. Thirty-eighth cycle.
- **[55] and [96] — NOW LIVE, NOT LATENT.** Cycle 47's correction of
  `attribution-expressed-confidence-unmeasured` from 0 to 1 made it the **unique** weakest link,
  so the selector now points straight at an issue that has `attempts []`, has never been a T1
  target, and whose primary open question is a **collection** question the state machine's
  T5→T3 edge cannot reach. The starvation proof has a live instance. Cycle 48's T5 must choose
  and must write down its reasoning.
- **[80] — REMAINS DISCHARGED** (cycle 46). Not re-listed as open below; the entry in the
  cycle-46 section that follows records the discharge.
- **NEW METHODOLOGICAL OBSERVATION, not yet a numbered rule.** ctr-0016 is the **first time a
  repair step a predecessor marked "NOT DONE AND OPTIONAL" has been discharged by a successor —
  and it found a defect.** Optional repair steps are not low-yield; they are **unpriced**.
  Several more sit in ctr-0008 through ctr-0016.
- **RULE (viii) IS NOW THREE FOR THREE.** ctr-0012, ctr-0015 and ctr-0016 each had **every**
  stored string match exactly while the defect sat in what was *not* stored. **A clean string
  sweep is not a pass.** The omitted-clause shape is now the most frequent single defect in this
  base, and in all three instances the omitted material was **the clause saying what the
  measurement was computed over**.

### New and updated at cycle 46

- **[80] — DISCHARGED.** `src-0021`'s per-backbone bare-LLM baseline table, named by three
  successive handoffs as the highest-value single fetch in the project, is captured whole:
  Table 1 (four methods × two corpora, including two bare directly-prompted GPT-4o rows)
  and Table 2 (six backbones under a fixed scaffold). Do not re-list as open.
- **[97] — NO LONGER HYPOTHETICAL.** Whether a non-commensurability finding may itself
  count as *resolving* an issue. Candidate 5 now states one, marked `supported`, so cycle
  47's T4 must price it and cannot defer. Still awaiting a human.
- **[98] NEW.** `src-0021`'s item-level TP/FP/FN algebra is still not printed, so its
  correctness rule remains an inference from two stated facts (per-document set comparison
  over parent-level IDs) rather than a quoted rule. Per rule (v) that absence rests on
  targeted fetches of one URL form and is **not** a confirmed absence. The paper's appendix
  and any released artefact have **never been looked for** — cheap and untried.
- **[99] NEW.** No second team has reproduced `src-0021`'s bare-baseline rows. Since
  TTPrint-Bench is author-built and the baselines are the authors' own implementation of
  their competitors, a weak baseline implementation would flatter the scaffold delta in
  candidate 4's Findings 2 and 3. **The magnitude is single-team evidence** until someone
  reproduces it; the direction is less fragile than the size.
- **[100] NEW (restating an old failure).** `open_questions[4]`'s two cheap untried routes
  into the `src-0017` repository — `stage3_ti_drafting/ttp/example/` and
  `stage3_ti_drafting/ttp/README.md`, to settle whether ground-truth `ttps` fields use
  parent-level or sub-technique IDs — remain untried for the **fourth** consecutive cycle,
  having been named as cheap by cycles 31, 32, 45 and now 46. This determines whether
  `src-0007`'s 0.2787-class figures measure technique selection or are substantially a
  granularity artefact.
- **`ctr-0015` steps (iii) and (iv) — NEW AND OPEN.** (iii) repair the "0.68–0.76 band /
  two teams, two corpora, one conclusion" wording in `open_questions[1]`, left standing
  deliberately by cycle 46 for auditability; it is impossible in `index.json`, which is
  append-only. (iv) optional: check whether `src-0020`'s per-technique kappas are themselves
  restricted, which would bear on estimand (1) as `ctr-0015` bears on estimand (3).
- **Methodological rule (v), cheapest instance yet.** An ABSENT verdict can be **self-refuted
  within a single fetch response** — cycle 46 got ABSENT for a caption string and a verbatim
  quotation of that same caption two items later in the same reply. Read the whole reply
  before believing any item in it.
- **Methodological rule (ix) generalises beyond F1.** `ctr-0015` is the metric-identity
  shape applied to an **agreement statistic**: three Cohen's κ values pooled as one "band"
  turned out to be a mean-of-per-class-κs, a whole-corpus κ, and a hard-subset pairwise κ.
- **Rule (xvii) vindicated, with a casualty.** Discovery fetch → exact-string confirmation
  is why cycle 46's table capture is trustworthy. A trailing `Best results in bold.`
  reported by the discovery fetch did **not** survive the exact-string ask and was **not**
  stored.
- **Sandbox note.** `graph.json`'s indentation is **not uniform** — issue-level candidate
  arrays use compact one-line `evidence` arrays while the contradictions array uses
  multi-line ones. An Edit anchor copied from one part of the file will fail against
  another; cycle 46 lost one Edit to exactly this. Use the Grep tool with `-A`/`-B` to read
  the real formatting before writing an anchor. Also: heredocs (`cat >> file << 'EOF'`) are
  approved and are far cheaper than many Edits for `.md` appends.
- **Handoff-map correction.** The cycle-45 handoff's open-contradiction map was wrong on two
  issues; `ctr-0007`, `ctr-0003` and `ctr-0005` are all **closed**. Verified map in the
  cycle-47 queue entry. Seventh consecutive cycle to find an error in its own handoff.
- **`ctr-0014` step (ii) still undone** — the amendment of `state/knowledge/src-0003.md`,
  the same step `ctr-0011`, `ctr-0012` and `ctr-0013` each skipped. Cycle 46 did **not**
  break this specific chain; it only avoided extending the pattern to its *own* entry by
  doing `ctr-0015` (i) and (ii) together.

### Inherited chain, copied verbatim from logs/cycle-045.md

## Carry-forward items

### New and updated at cycle 45

- **[76 → DISCHARGED] `open_questions[3]` of `ttp-attack-mapping-reliability` is now written up
  as ANSWERED in the graph itself,** not only in a log. Cycle 43 established the finding; cycle
  45 put it where a T4 reading the graph will hit it. **A T4 must stop treating "read the
  CTIBench ATE scorer" as a pending route — it does not exist.**
- **[45 → DISCHARGED] The `attribution-confident-wrong-gap` split is DONE** after being requested
  every cycle since 25. **Read the deviation:** the *existing* id keeps the *error-rate* leg and
  is retitled; the *new* issue `attribution-expressed-confidence-unmeasured` takes the
  *confidence* leg. This is the opposite of what the cycle-43 handoff sketched, and it was forced
  by the id being cited from three append-only knowledge files.
- **[91] NEW — THE LEGACY ID IS A PERMANENT TRAP AND MUST BE PASSED ON FOREVER.**
  `attribution-confident-wrong-gap` **no longer means what its name says.** It is the
  ATTRIBUTION-ERROR-RATE issue. The confidence leg is
  `attribution-expressed-confidence-unmeasured`. The id cannot be repaired, because
  `index.json`, `src-0002.md` and `src-0017.md` cite it and are append-only.
- **[92] NEW — ar5iv UNVERSIONED RENDERS CAN BE STALE VERSIONS AND PRODUCE CONFIDENT SPURIOUS
  ABSENTS.** `ar5iv.labs.arxiv.org/html/2406.07599` serves **v2** while reporting itself
  COMPLETE. **Consequence for an existing finding:** cycle 43 used an ar5iv fetch on `src-0003`
  when opening `ctr-0014`. I assert **no** defect in `ctr-0014` — its finding was a fabricated
  PRESENT, not an ABSENT, and the fabrication was caught at the time — but **the version
  provenance of that fetch has never been established and should be.** Cheap: ask that ar5iv
  render which version it is. This is a T3/G2 bolt-on, not mine.
- **[93] NEW — REFINEMENT TO METHODOLOGICAL RULE (i), EARNED THIS CYCLE.** The word "verbatim" in
  a prompt does not bind the fetch. Three asks produced three renderings of one sentence's
  opening clause; the two variants came from *broad* asks ("quote the paragraph", "quote every
  other occurrence") and both evaporated under a direct exact-string ask. **Broad asks are for
  discovery; only a PRESENT/ABSENT exact-string ask on a string you already hold may be stored
  as a quotation.** This is the cheap general defence against the `ctr-0014` fabrication shape.
- **[94] NEW — RULE (xiv)'s FIRST CLEAN PASS.** Two consecutive rule-(xiv) checks found false
  stored corrections (`ctr-0011`, `ctr-0014`). Cycle 45's found a **sound** one. The rule remains
  the highest-yield in the list; its hit rate is now 2 of 3, not 2 of 2, which is worth knowing
  before a successor treats every stored correction as presumptively rotten.
- **[95] NEW — THE MICRO-VERSUS-MACRO CONFLICT IN `src-0002` IS NOW PROVABLY UNRESOLVABLE FROM
  THE PAPER.** `Micro-F1` occurs exactly once (body), `Macro-F1` exactly once (Table 1 header),
  and nowhere else — **no third mention exists to adjudicate.** Combined with cycle 43's finding
  that no ATE scorer ships, the **only** remaining route is the NeurIPS camera-ready PDF, and
  **no PDF text extraction is available to this agent.** Treat as an infrastructure limit,
  subject to the standing caution that such limits deserve one re-test by a genuinely different
  route.
- **[96] NEW — `attribution-expressed-confidence-unmeasured` HAS NEVER BEEN A T1 TARGET** and its
  primary open question ("does any published evaluation measure expressed confidence on
  threat-actor attribution — verbalised confidence, logprobs, hedging rate, abstention rate, or
  ECE/Brier *on an attribution task*?") is a **collection** question that no scheduled task
  currently reaches. This joins [88] on the list of T1-only work that the schedule starves.
- **[97] NEW — THE NON-COMMENSURABILITY FINDING IS NOW A CANDIDATE RESOLUTION, NOT JUST A
  WARNING.** See `ttp-attack-mapping-reliability` `open_questions[5]`. If no commensurable pair
  of published ATT&CK numbers exists, the honest resolution of that issue is a statement about
  the measurement literature rather than a magnitude. **A T4 should be able to score that as an
  answer.** This is a live question about what this project counts as resolution and may need a
  human: it is adjacent to [4] and [11].
- **[80 → STILL OPEN, AND NOW THE SINGLE HIGHEST-VALUE FETCH IN THE PROJECT] `src-0021`'s
  per-backbone bare-LLM baselines are still uncaptured.** Without them, the base has **no**
  frontier-model, stated-granularity, bare-model ATT&CK number at all, and the 76.48/87.39
  scaffold scores are unusable for comparison. One fetch of the multi-backbone table would fix it.
- **[47](f) → STILL UNDONE, FOURTEENTH CYCLE.** The verbatim re-fetch of `eval/threat_actor.py`
  is step (i) of `ctr-0008`'s repair and remains the first thing a T3 on the error-rate issue
  should do.
- **[UNCHANGED AND UNDONE BY ME]** `ctr-0014`'s three repair steps — including step (ii), the
  amendment of `state/knowledge/src-0003.md`, **which is the same step `ctr-0011`, `ctr-0012` and
  `ctr-0013` each left undone; skipping it again would make FIVE CONSECUTIVE** and it remains the
  single most repeated unfinished action in this project. Also undone: `ctr-0013`'s four steps,
  `ctr-0012`'s four steps, `ctr-0011` step (ii), `ctr-0010` steps (ii) and (iii), `ctr-0009`'s
  resolution path, `src-0007`'s unrecorded TMLR provenance, `src-0001`'s uncorroborated ARES
  provenance, [81] the two prohibited curl numbers and the unfetched `curl/curl` PR 20312, [84]
  the unread CTIBench `model-prediction.ipynb`, [88] the `src-0017` TRIAGE scorer and the second
  CTI-task ECE/Brier calibration source (both T1-only), and [90] the untried
  `arxiv.org/html/<id>v1` route on `src-0003`.
- **[LATENT POLICY CONFLICTS AWAITING A HUMAN — PASSED ON VERBATIM]** [4] the G3 gate (partly
  settled for the *enforced* rule only), [11], [30] the tie-break, [41] the contradiction shapes
  (**thirteen entries across twelve shapes**), [55] the starvation proof (**now compounded, see
  [88]**), and [75] the incomplete tie-break ladder.

### Inherited verbatim from `logs/cycle-043.md` (lines 257–1403), copied mechanically with `sed -n`

## Carry-forward items

### New and updated at cycle 43

- **[76→ UPDATED] open_questions[3] of `ttp-attack-mapping-reliability` is ANSWERED.** The
  CTIBench artefact is released, ships `data/cti-ate.tsv`, and contains **no CTI-ATE scorer**
  (src-0019). The rule is unrecoverable from paper *and* code. A T2 should rewrite the question
  to say so; a T4 should stop treating "go read the CTIBench scorer" as a live route to level 3.
- **[80] NEW — src-0021's per-backbone bare-LLM baseline table was not captured.** The
  76.48%/87.39% are scaffold scores. Without the bare baselines, src-0021 cannot supply a
  model-level comparand and citing it as one reproduces the ctr-0001 SYSTEM-vs-MODEL confound.
  **Highest-value single fetch on the new sources.** `arxiv.org/html/2605.25836v1` did not
  truncate, so this is cheap.
- **[81] NEW — two curl numbers are PROHIBITED until primary-sourced.** The "~20% of reports are
  AI-generated" figure and the "seven reports in 16 hours / 20+ by mid-month, none real" count are
  in secondary coverage only and are **not** in Stenberg's post. G1 forbids entering them from a
  search snippet. `github.com/curl/curl/pull/20312` is unfetched and is the cheapest next primary
  artefact.
- **[82] NEW — the human-baseline question is ADVANCED, NOT DISCHARGED.** The base now has three
  inter-annotator κ values for parent-level ATT&CK labelling (0.68 src-0020; 0.76 and 0.74
  src-0021) from two independent teams. **These are agreement statistics, not accuracy
  baselines.** open_questions[1] as literally posed is still open, and src-0018's 41-minute figure
  is still a throughput baseline. Nobody may treat κ as closing it.
- **[83] NEW — the four new sources are MUTUALLY NON-COMMENSURABLE and non-commensurable with the
  old ones.** src-0020 is sentence-level micro-F1, parent-level, open-source models; src-0021 is
  document-level macro-**over-documents** F1, parent-level, scaffolded frontier models; src-0002
  is CTI-ATE with an unknown rule; src-0007 is exact sub-technique-ID set intersection. **Two
  parent-level sources is not two comparable measurements.** ctr-0013 is the standing warning.
  Note especially that src-0021's "macro-F1" is a macro over *documents* while src-0002's Table 1
  header "Macro-F1" would, if it means anything conventional, be a macro over *techniques* —
  **different statistics sharing a name**.
- **[84] NEW — `evaluation/model-prediction.ipynb` (15,803 B) in the CTIBench repo is unread.**
  The inference that it generates rather than scores is well-supported (no `cti-ate-responses.tsv`
  exists) but is an inference. One cheap fetch closes src-0019 completely.
- **[85] NEW — ctr-0014's three repair steps are NOT MINE and must be passed on undone**, in
  particular step (ii), the amendment of `state/knowledge/src-0003.md`. **ctr-0011, ctr-0012 and
  ctr-0013 have EACH left their `src-*.md` amendment undone; skipping it here would make four
  consecutive, and it is now the single most repeated unfinished action in this project.**
- **[86] NEW — src-0003 is an unreviewed preprint with no venue** (no `Comments:`, no
  `Journal reference:`, only the arXiv DOI), recorded for the first time in 42 cycles. Its 97.6%
  is the base's highest number and one side of ctr-0001. Also: v2 **is** current, so the
  version-staleness bolt-on scored its first clean negative and is now four-for-six.
- **[87] NEW — the 43% ambiguity in src-0003.** Three differently-worded statements now known:
  "43% drop in the average and median time the analysts spent on a report", "43% reduction in
  **parsing time**", "reduces analysts' **work factor** by 43%". Nobody has checked which one
  stored claim 3 reports. Flagged, not adjudicated.
- **[88] NEW — the fifth source slot went unspent and TWO NAMED COLLECTION TARGETS REMAIN.**
  The **src-0017 triage scorer** (`raw.githubusercontent.com/xschen-beb/CyberThreat-Eval/main/...`,
  the one evaluator of three never read, serving the structurally starved
  `automated-triage-under-refusal`) and a **second CTI-task ECE/Brier calibration source**
  (`consistency-calibration-as-failure-mode` open_questions[5], now **eighteen** cycles without a
  search, and the single measurement that would let a T4 move that issue off 2). **Both are
  actionable only by a T1**, and the next scheduled T1 is not until a T5 cycle satisfies the
  refresh rule — the T5 cycles are 45, 48, 51, 54, so the earliest is **cycle 49** (49 % 7 == 0)
  and only if a T5 falls there. Nothing in the queue guarantees it. This is a real structural
  starvation risk and it compounds carry-forward [55].
- **[89] NEW — methodological rule (xvi) now has a second independent instance, and rule (xiii)
  its second live catch.** Both src-0003 renderings truncated and both answered ABSENT to content
  questions anyway; and the ar5iv fetch returned a **fabricated PRESENT** (a sentence containing
  "9.2%" and "11.1%" offered as containing "76%"). The two rules working together are the only
  reason ctr-0014 was scoped to the 86% alone instead of over-claiming. **The defect-shape count
  stands at twelve** — ctr-0014 is a repeat of the ctr-0011 shape (false-positive correction),
  not a thirteenth shape. **Twenty source-checks have now run and thirteen have produced a
  defect.**
- **[90] NEW — the `arxiv.org/html/<id>v1` shorter-document trick (cycle 42's fix) is UNTRIED on
  src-0003.** It is the named cheapest route to settling 76% and 72%, with the caveat that a v1
  reading is evidence about v1 only.

### Inherited verbatim from `logs/cycle-042.md` (lines 303–1379), copied mechanically with `sed -n`

## Carry-forward items

**Updates and new items from cycle 42 are listed first; the full inherited list from
`logs/cycle-041.md` follows verbatim below, copied mechanically with `sed` rather than retyped.**

- **[75] NEW AT CYCLE 42 — THE TIE-BREAK LADDER DOES NOT TOTALLY ORDER THE CANDIDATE SET. AWAITING
  A HUMAN.** `prompts/t5_select.md` step 3's three tie-breaks left
  `ttp-attack-mapping-reliability` and `ioc-extraction-reliability` **exactly tied** at cycle 42 —
  same score (2), same upstream tier (1), same attempt penalty (0), same `created_cycle` (2). The
  policy has no fourth tie-break. I broke it by **older last-attempt first**, an extension I
  invented and labelled as such; it is not in the policy and must not become precedent without a
  ruling. This is distinct from [30] (which is about the tie-break's *content*) and from [55]
  (which is about its *starvation consequence*): [75] is about its *incompleteness*. As base
  priority stays degenerate this will recur.
- **[76] NEW AT CYCLE 42 — `ctr-0013` IS OPEN AND ITS FOUR REPAIR STEPS ARE UNDONE. NOT A T5's TO
  TAKE.** (i) append a key_claim to src-0006 in `index.json` recording B.3's task-form definitions
  verbatim plus the v1-only scope limit; (ii) append the same to `state/knowledge/src-0006.md` —
  **this is the step `ctr-0011` and `ctr-0012` both left undone and it must not be skipped a third
  time**; (iii) amend `extraction-vs-reasoning-ordinal-axis` `candidate_resolutions[1]` in place so
  route 1 states only what survives, without the "locally inverted at its strongest predicted point"
  argument; (iv) record the **fifth** uncontrolled difference on `candidate_resolutions[2]`'s
  cross-source TTP comparison (src-0006 = binary yes/no over supplied candidate IDs; src-0007 =
  free-form generation scored by exact set intersection — different chance baselines). A T3 or T1
  should also attempt B.3 on v5 via a rendering that reaches appendices (ar5iv, or an intermediate
  version).
- **[77] NEW AT CYCLE 42 — METHODOLOGICAL RULE (xvi), TRUNCATED-APPENDIX ABSENTS.** Where a paper's
  HTML is long enough to truncate, an ABSENT verdict about any appendix is worthless; fetch an
  **earlier version whose HTML is shorter**. Proven this cycle on src-0006: two renderings returned
  clean ABSENTs, one of them while admitting `[Content truncated due to length...]`, and v1 returned
  the whole appendix. Applies to every long arXiv source in this base.
- **[78] NEW AT CYCLE 42 — THE "SEVEN DOCUMENTED INSTANCES" PRIOR IS NOW SEVEN OF EIGHT.** Five
  rationales repeat that *"every single time a cycle in this project has actually read a scoring
  rule it has differed from what the state assumed."* Cycle 42 is the **first counterexample**:
  src-0006's nine F1 rows really do share one scoring form. Restate the prior with its denominator;
  do not keep quoting the unqualified form.
- **[79] NEW AT CYCLE 42 — src-0006 IS AT v5 AND NO CYCLE HAS RECORDED WHICH VERSION ITS FIGURES
  CAME FROM.** `arxiv.org/abs/2509.23573`: *"[Submitted on 28 Sep 2025 (v1), last revised 28 May
  2026 (this version, v5)]"*, **no Comments line, no Journal reference line** → unreviewed preprint.
  Cycles 6, 17 and 18 all cite the unversioned URL. The version-staleness bolt-on is now
  four-for-five.
- **UPDATE TO [4] (the G3 gate):** re-verified at source again this cycle; the ceiling reading is
  applied and the subtraction refused, per cycle 16's ruling. **Thirty-third cycle awaiting a
  human.** No new information; the subtraction-versus-ceiling conflict is untouched.
- **UPDATE TO [41] (contradiction shapes):** now **TWELVE**. New shape at cycle 42:
  **OPERATIONALISATION MISMATCH** — the state's account of *what a measured task is*, against the
  source's own definition of it. Note this is the **fourth** instance of rule (vi) (a clean source
  with an unclean state account of it: `ctr-0008`, `ctr-0011`, `ctr-0012`, `ctr-0013`), and the
  structural blindness of [41] recurs here — `ctr-0013` carries one `issue_id` but its content also
  damages `task-dependent-reliability-framing` and `extraction-vs-reasoning-ordinal-axis`'s
  *other* candidate, and no per-issue query surfaces that.
- **UPDATE TO [55] (the starvation proof):** `automated-triage-under-refusal` has now lost an
  **eighth** consecutive selection, in its twenty-seventh cycle with `attempts: []`. Recorded above
  with full arithmetic. **This was the cycle where it cost most**, a T1 being the only task type
  that can discharge the curl/HackerOne item and the src-0017 TRIAGE scorer; both are listed as
  explicit collection targets in the cycle-43 T1 instructions, but the *target issue* is `ttp`.
- **UPDATE TO [15] and the src-0017 TRIAGE scorer:** for the first time since cycle 22 these are
  **actionable**, because cycle 43 is a T1 and only a T1 may add sources.
- **UPDATE — `open_questions[5]` on `consistency-calibration-as-failure-mode`** (a second CTI-task
  ECE/Brier source): **seventeen** cycles without a search, and likewise actionable for the first
  time since cycle 22. It is the single measurement that would let a T4 move that issue off 2.
- **UPDATE — the next T2 is cycle 44** (state machine T1→T2), which **revives [45]**: the split of
  `attribution-confident-wrong-gap` into its attribution-ERROR-RATE leg and its
  attribution-CONFIDENCE leg. This is flagged in the cycle-43 T1 handoff so the T2 inherits it.

**INHERITED LIST FROM `logs/cycle-041.md`, REPRODUCED VERBATIM AND IN FULL, INCLUDING ITEMS THIS
CYCLE COULD NOT ACT ON:**

## Carry-forward items

All items from `logs/cycle-040.md` are reproduced **verbatim and in full below**, including those I
cannot act on — copied mechanically with `sed` so that no wording drifts. Note that cycle 040's log
survives in git although its `state/` output was reverted; the carry-forward *list* is still the
authoritative predecessor chain, because it is a record of outstanding work rather than of state.
**This cycle's updates are listed here first; the unaltered reproduction follows.**

**New at cycle 41: [70], [71], [72], [73], [74].**
**Discharged at cycle 41: the src-0004 G2 gap (every source in the base has now had at least one G2);
the per-issue/per-contradiction sub-question of [4], for the *enforced* rule only.**
**Updated at cycle 41: [4], [15], [30], [41], [55], and every item stating a projected T1 or T2 cycle
number.**

- **[70] NEW — THE REFRESH RULE FIRES AT CYCLE 42 AND THE NEXT T1 IS CYCLE 43.** Re-derived at cycle 41
  from `prompts/t5_select.md` step 4 and `config.yml` line 17. Cycle 40's abort shifted the phase by
  one; the T5 cycles are now 42, 45, 48, 51, 54 …; 42 % 7 == 0. **Every "the next T1 is cycle 50 / 57"
  and "the next T2 is cycle 51 / 58" statement anywhere in this project's logs, rationales and
  handoffs before cycle 41 is superseded.** Recompute rather than copy; each further abort shifts the
  parity again. Consequence: the collection-blocked routes on six of the eight issues become live for
  the first time since cycle 22.

- **[71] NEW — `ctr-0012` and its four repair steps, none of which a T4 may take.** (i) Append a
  correcting key_claim to src-0004 in `index.json` quoting the "deficiencies" sentence **whole**;
  (ii) append the same correction to `state/knowledge/src-0004.md`, whose "Key claims" item 3 and
  "Relevant quotes" both carry the truncated rendering — **this is the same second step `ctr-0011` left
  undone on src-0016 and it must not be skipped the same way**; (iii) amend
  `candidate_resolutions[3]` in place to state the divergence as over **remedy** and **causal
  attribution** rather than over acceptance of responsibility; (iv) amend `candidate_resolutions[0]`'s
  APT29 rendering from a prose attribution to a **fabricated hyperlink**. Then close the entry.

- **[72] NEW — src-0004's canonical URL now serves a heise+ paywall teaser.** The working form is the
  canonical URL with **`?seite=all`** appended; the id-only form returns HTTP 404. The validator cannot
  catch this: lines 125–127 check G1 liveness for **new sources only** and the canonical URL still
  returns HTTP 200 while serving none of the content the state cites. **This is the first confirmed
  case in this project of a stored URL going stale in content while staying alive in status**, and it
  is a general risk for every news source in the base.

- **[73] NEW — methodological rule (xv): verification-mode fetching.** A fetch may refuse whole-body
  reproduction of a news article on copyright grounds and return a summary, which rule (ix) makes
  worthless. The workaround, proven at cycle 41 on the same URL that had just refused: numbered items,
  each answered **PRESENT or ABSENT**, and for each PRESENT quote **only the single full sentence
  containing it, exactly as printed**, with an explicit instruction to answer CANNOT READ if the body
  is not visible. This returns whole sentences with subordinate clauses intact, which is what the
  amended rule (iv) demands.

- **[74] NEW — the G3 gate is load-bearing for the first time.** `institutional-incident-real-world-impact`
  scores 3 with `ctr-0012` open, so it sits **exactly at** the ceiling with zero slack. Every prior
  application sat at merit 2 with a slack of one. **While `ctr-0012` is open, any T4 that raises this
  issue to 4 will fail the validator and have its entire cycle reverted.** The route to 4 runs through
  a T3 executing `ctr-0012`'s resolution path first.

- **[4] UPDATED — the G3 gate conflict, THIRTY-SECOND cycle awaiting a human.** One sub-question is
  now settled **at source**: `scripts/validate_state.py` lines 146–149 build `open_contra` as a **set
  comprehension** over `c["issue_id"]`, so the loop at line 150 visits each affected issue exactly
  once. **The enforced gate is per-issue by construction and cannot be per-contradiction.** The
  substance of [4] — `prompts/t4_assess.md` step 3 and `config.yml` line 35 prescribe a *subtraction*
  while the validator implements a *ceiling* — is **untouched**. Cycle 41 applied the ceiling and
  refused the subtraction, as cycle 16 ruled. A second, distinct defect in the gate is also restated
  and not acted on: a contradiction entry carries exactly **one** `issue_id`, so cross-issue exposure
  (e.g. `ctr-0008` damaging `extraction-vs-reasoning-ordinal-axis`) is structurally invisible to any
  per-issue query.

- **[15] UPDATED — the curl/HackerOne source.** Still uncollected, still judged by seven successive
  cycles the highest-value uncollected source in the project, still with **no** entry in
  `state/knowledge/index.json`, and G1 forbids inventing one. **It is now reachable for the first
  time**: a T1 fires at cycle 43. It sits on `automated-triage-under-refusal`, which under tie-break
  (c) cannot be selected — so [15] and [55] are the same problem wearing two hats.

- **[30] / [55] UPDATED — the tie-break and the starvation proof.** `automated-triage-under-refusal`
  has `attempts []` in its 26th cycle and has lost **seven** consecutive selections. Cycle 34 proved
  it can never be selected under tie-break (c) while the `created_cycle=2` issues stay tied at the
  same score, and cycle 41 leaves seven issues at 2 and one at 3, so **the tie-break is the selector**.
  The cost is now maximal, because the T1 at cycle 43 is exactly the task that would discharge [15]
  and the unread src-0017 TRIAGE scorer. **A T5 must apply the policy as written and must not invent
  an anti-starvation rule.** Awaiting a human.

- **[41] UPDATED — the contradiction shapes are now ELEVEN,** with `ctr-0012` adding **omitted
  subordinate clause**: spliced quotations, unverifiable numbers, unsupported interpretive glosses,
  partial table capture, correct-but-hollow entries, correct-source-corrupted-downstream,
  over-restriction, over-generalisation, metric-identity, false-positive correction, omitted
  subordinate clause. Nineteen source-checks, eleven defects. The open policy question in [41] is
  unchanged and still awaits a human: **the G3 demotion treats all eleven shapes identically**, even
  though `ctr-0005` and `ctr-0011` were corrections that *strengthened* their issue, and `ctr-0012`'s
  limb (3) is a correction that makes the evidence *stronger* than the state recorded. Penalising an
  issue for a correction that improved it creates an incentive not to file such corrections.

---

### Verbatim reproduction of `logs/cycle-040.md` carry-forward section (lines 300-1218)

## Carry-forward items

All items from `logs/cycle-039.md` are reproduced **verbatim and in full below**, including those I
cannot act on — copied mechanically with `sed` so that no wording drifts. **This cycle's updates are
appended in a marked block after the reproduction**, not woven into it.

---

### Verbatim reproduction of `logs/cycle-039.md` carry-forward section (lines 320-1228)

## Carry-forward items

All items from `logs/cycle-037.md` are reproduced **verbatim and in full below**, including those I
cannot act on — copied mechanically with `sed` so that no wording drifts. Cycle 38 produced no log
(it aborted), so cycle 037's list is the authoritative predecessor. **This cycle's updates are
listed here first, keyed to item numbers, and the unaltered list follows.**

**New at cycle 39: [65], [66], [67], [68], [69].**
**Discharged at cycle 39: `ctr-0003` in full; `ctr-0005` in full; `open_questions[3]`'s named
verbatim re-pull.**
**Updated at cycle 39: [4], [38], [39], [41], [44 — see note], [59].**

### Cycle-39 updates and new items

**[4] — UPDATED (the G3 gate, still awaiting a human, thirty-first cycle).** Unchanged in substance;
`scripts/validate_state.py` lines 144-156 implement a **ceiling** at 3, `prompts/t4_assess.md` step 3
says **subtract 2**, `config.yml` line 35's comment agrees with the subtraction. Cycle 16 ruled for
the ceiling and every T4 since has applied it. **Nobody has ever specified whether the gate is
per-issue or per-contradiction.** New at cycle 39: `ioc-extraction-reliability` now carries **three**
open contradictions (`ctr-0001`, `ctr-0004`, `ctr-0010`). If the gate is ever ruled
per-**contradiction**, that is the issue it bites hardest, and no cycle has ever priced it that way.
Open contradictions after cycle 39: `ctr-0001` (c9), `ctr-0004` (c27), `ctr-0008` (c30), `ctr-0009`
(c33), `ctr-0010` (c35), `ctr-0011` (c39). Resolved: `ctr-0002` (c28), `ctr-0003` (c39), `ctr-0005`
(c39), `ctr-0006` (c31), `ctr-0007` (c35).

**[38] — UPDATED, and it produced a real casualty this cycle.** "A single fetch's ABSENT is not
evidence of absence." **Fifth and sixth instances recorded at cycle 39**, and one of them —
`src-0016`'s — **manufactured a false finding that survived eighteen cycles** (`ctr-0011`). The rule
must now be read as governing **a G2's own corrections**, not only the claims a G2 audits. Also new:
`/html/2503.23175v1` returned the exact string *"dataset of 350 threat intelligence reports"* as
ABSENT while `/abs` returned the abstract containing it verbatim — the **second** false negative on
that same source.

**[39] — UPDATED (version-staleness bolt-on).** Was 3-for-3 on finding material differences. Cycle 39
ran it on `src-0001` and got the **first clean result**: four versions (v1 29 Mar 2025, v2 16 Jul
2025, v3 4 Nov 2025, v4 12 Nov 2025, all 1,203 KB), unversioned `/html` resolves to v4, and **all 54
cells of Table 6 are identical between v1 and v4**. Now 3-for-4. Still worth running.

**[41] — UPDATED (the contradiction-shape taxonomy, awaiting a human).** Was six shapes, then nine.
**Now TEN.** The new shape is **false-positive correction** — a prior check's finding that does not
reproduce (`ctr-0011`). Full class: spliced quotations, unverifiable numbers, unsupported
interpretive glosses, partial table capture, correct-but-hollow entries,
correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity,
false-positive correction. Eighteen source-checks, ten defects.

**[59] — UPDATED.** The "long clean run" watch item. It **ended at cycle 39** and ended exactly as
cycle 37 predicted it would: the run was partly an artefact of re-checking sources that earlier
defect-finding cycles had already cleaned, and the first check pointed at the **checking history**
rather than at a source bit immediately.

**[65] — NEW. `ctr-0011` step (ii) is NOT MINE AND IS UNDONE.** `state/knowledge/src-0016.md` has not
been read or amended and may carry cycle 21's false correction in its own prose, where a reader who
never opens `index.json` would meet it unqualified. The `index.json` half is done. A later cycle
should read that file, append the correction, and close `ctr-0011`.

**[66] — NEW. `src-0001`'s ARES 2025 peer-review status has ONE witness.** Cycle 25 upgraded it from
"unreviewed preprint" on the strength of an `/html` citation block. `arxiv.org/abs/2503.23175`
carries **no** Comments line, **no** Journal reference line, and only the arXiv DOI — contrast
`src-0007`, whose `/abs` page carries both. Not a contradiction, but the most load-bearing source in
this base has an uncorroborated venue. **One fetch of `https://doi.org/10.1007/978-3-032-00627-1_17`
settles it.** Cheapest outstanding provenance item in the base.

**[67] — NEW. `src-0001` reports NO fine-tuning configuration whatsoever** — no hyperparameters,
epochs, learning rate, endpoint, or fine-tuning-set size. ABSENT on two URL forms. This is why the
small-data-overfitting explanation for the post-fine-tuning calibration collapse **cannot be tested
from this source**, and it is a limitation of the source that no cycle had recorded in 39 cycles.
The fine-tuning pool is bounded by **245** reports (70% of 350, shared with the few-shot pool), not
the 350 cycle 25 recorded.

**[68] — NEW, AND IT IS A STANDING PROHIBITION.** `src-0001`'s extraction-versus-generation
calibration gradient is **metric-dependent**: it holds on ECE at all three paradigms, vanishes on
Brier at zero-shot (0.0065 gap), and **reverses** on Brier at few-shot. It holds on both metrics only
after fine-tuning, where it rests on two rows. **No cycle may state that gradient without naming the
metric it holds on.** This binds `extraction-vs-reasoning-ordinal-axis` and
`task-dependent-reliability-framing`, both of which use that split as a calibration data point; a T3
targeting either must read this before citing it. It does **not** touch the consistency half (CI
widths 0.02 vs 0.06), which is a single measurement with no competing metric.

**[69] — NEW. `src-0018`'s 41-minute human throughput baseline needs a home.** Cycle 39 ruled it does
**not** belong on `consistency-calibration-as-failure-mode` (it is a throughput fact, not a
reliability fact) and it is **not** the human-analyst F1 that `ttp-attack-mapping-reliability` has
wanted for sixteen cycles, so it cannot go there either. It is the only human-versus-LLM baseline of
any kind in this base. It stays recorded in `ctr-0005` and in `src-0018`'s source entry, awaiting a
T1 or T2 to open a throughput or cost-benefit issue.

**Standing, not mine, and passed on undone:** `ctr-0010` steps (ii) and (iii)
(`ioc-extraction-reliability`); [47](f)'s verbatim re-fetch of `eval/threat_actor.py`
(`attribution-confident-wrong-gap`); `ctr-0009`'s resolution path
(`task-dependent-reliability-framing`); `src-0007`'s unrecorded TMLR provenance (four cycles
flagged); `src-0006`'s never-read per-task scoring definitions, which cycles 33, 36, 37 and 39 all
call the largest untested load-bearing assumption in this project; [15]'s curl/HackerOne source; the
`src-0017` TRIAGE scorer, the one evaluator of three in that repository never read; and
`consistency-calibration-as-failure-mode`'s `open_questions[5]` — a second CTI-task ECE/Brier source
— now **fourteen cycles without a search** and still the single measurement that would let a T4 move
that issue off 2.

---

### Verbatim reproduction of `logs/cycle-037.md`'s carry-forward section

## Carry-forward items

All items from `logs/cycle-036.md` reproduced **including those I cannot act on**, copied forward
verbatim so that no wording drifts, with this cycle's updates marked inline as
**[CYCLE-37 UPDATE]**. Discharged items stay marked rather than deleted.
**New: [62], [63], [64]. Discharged this cycle: [27] in full. Updated: [3], [4], [27], [30], [38],
[41], [55], [59], [60].**

Cycle 36's own preamble to this section read: *"All items from `logs/cycle-035.md` reproduced including
those I cannot act on. Discharged items stay marked rather than deleted. New: [60], [61]. Discharged
this cycle: [57] step (i) only. Updated: [4], [8], [9], [11], [20], [24], [27], [28], [30], [31], [34],
[37], [39], [41], [50], [51], [53], [54], [55], [57], [59]."* — preserved here because the per-cycle
update record is itself evaluation data.

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
**[CYCLE-37 UPDATE]** Lost again at cycle 37's T5 — but **at tie-break (c) only**, having survived (a)
and (b) cleanly; see the refined proof in [55]. **The running count is disputed within cycle 36's own
outputs** — its handoff said "six consecutive lost selections", this item says "seven" — and cycle 37
declined to adjudicate rather than launder a number it had not reconstructed. What is verifiable from
the graph: `attempts: []`, `created_cycle: 16`, now cycle 37, i.e. **twenty-one cycles of existence with
zero work done on it**. Its item (3) — src-0015's unentered Reward column — was **discharged at cycle 37
as a G2 by-product**, so that fragment of the debt is paid without a selection; (1) the curl/HackerOne
source and (2) the src-0017 TRIAGE scorer remain unreachable.

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 27 CYCLES. VERBATIM FOR A HUMAN.**
The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line
35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The enforced
reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in `logs/cycle-016.md`
"Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside this agent's output surface.
**Until a human applies it, T4s must apply the ceiling.** Under subtraction four of eight issues would
read 0 today. The per-issue-versus-per-contradiction question stays live on `ioc` (three open) and
`consistency` (two): under subtraction, is `ioc` −2 or −6? *Cycle 36 applied the ceiling on all four
contradicted issues and it bound on none.* Awaiting a human, verbatim, with [11], [30], [41], [55].
**[CYCLE-37 UPDATE] Twenty-eighth cycle unresolved.** Cycle 37 is a T5 and applied no gate, so it has
nothing to add on the merits and deliberately adds nothing. Open contradictions as of cycle 37 are
unchanged: ctr-0001, ctr-0003, ctr-0004, ctr-0005, ctr-0008, ctr-0009, ctr-0010. Note for whoever picks
this up: cycle 38's T3 is instructed to resolve ctr-0003 and possibly ctr-0005, which would take
`consistency-calibration-as-failure-mode` from two open contradictions to zero — the cleanest natural
experiment yet available on whether the ceiling has ever been doing any work, since the answer under the
ceiling reading is "no change, merit 2 was always under the ceiling of 3" and under the subtraction
reading is "0 → 2".

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
**[CYCLE-37 UPDATE] — DISCHARGED IN FULL, by a route nobody had considered.** Cycle 37's G2 landed on
src-0015 by staleness, and because rule (iv) says pull the whole table rather than the rows the claim
needs, the Reward column arrived as a by-product. It is now in `state/knowledge/index.json`
`src-0015.key_claims[6]` and in `state/knowledge/src-0015.md`, **verbatim and confirmed at source**:
Reward 3.07 / 2.37 / 2.61 / 3.45, plus a **`Threshold`** column no cycle knew existed (GPT-5.2
"Uncalib."; Sonnet 4.5, Gemini 3 **and** DeepSeek 3.2 all "Part. Cal." — so three models are classified
partially calibrated, not the one the abstract names). Two of the tracker's three caveats are now
resolved: **the reward composition is no longer unstated** (verbatim definition entered: attribution
+1/−0.5, containment +1 per correct action and −0.5 per false positive, injection −2 per violation,
efficiency −0.1 per step), and the "no CIs" caveat is confirmed at source for v3. The prediction that
"the model the paper calls best-calibrated earns the lowest reward" **is correct**. **THE LESSON, WHICH
IS THE REUSABLE PART:** an item blocked on a starved issue was discharged by a *knowledge* append, which
any cycle may make, rather than by the *graph* edit the tracker assumed was required. Before writing off
a carry-forward item as unreachable, ask whether its content is a source fact (appendable by anyone) or a
graph fact (T2/T3 only). **What remains graph work and is NOT discharged:** connecting the Reward finding
to `automated-triage-under-refusal`'s `open_questions[0]` inside the issue itself. See new item [64].

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
**[CYCLE-37 UPDATE] — THE 3a AMBIGUITY THIS ITEM FLAGGED WAS FACED AND RESOLVED IN PRACTICE, AND THE
LITERAL PAIRWISE READING IS THE ONE CYCLE 37 APPLIED.** The item's own conditional turned out to be the
live branch: `automated-triage-under-refusal` **survives 3a** (it has no dependency edges in either
direction, so nothing outranks it), **survives 3b** (`attempts: []`, so no penalty), and **dies at 3c on
`created_cycle` 16 against 2**. Cycle 37 states the reasoning for the pairwise reading so a human can
overrule it cheaply: the prompt's text is "an issue that others `depend_on` outranks **its dependents**",
which is a relation between an issue and its dependents and says nothing about issues with no path
between them; the "eliminated for having no dependents" reading would require the rule to mean "issues
with dependents outrank issues without", which is not what it says. A depth-in-the-DAG reading gives the
same four survivors. **Two further defects in the rule surfaced this cycle and are new work for a human,
not opinions to be re-litigated by an agent:** (i) `prompts/t5_select.md` writes the field name as
`depend_on` while `graph.json` and its own `_schema` use **`depends_on`** — a jq projection on the
prompt's spelling returns `null` for every issue and makes tie-break 3a silently vanish, which is exactly
the kind of error no gate in this project would catch; (ii) 3b's window, "within the last 5 cycles", has
**undefined endpoints**, and under the alternative window (33–37 rather than 32–36)
`ttp-attack-mapping-reliability` would have reached 3c tied with the winner at `created_cycle` 2 with
**no further tie-break specified at all**. Cycle 37 did not have to resolve that, and flags it rather
than inventing a fourth tie-break.

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
**[CYCLE-37 UPDATE] — SEVENTEEN SOURCE-CHECKS; NINE PRODUCED A DEFECT; EIGHT CONSECUTIVE CLEAN.**
**(q) src-0015 (c37): CLEAN** — all six stored quotations and all four EGAR cells verbatim from
`/html/v3`; **every provenance label confirmed at source for the first time** (sole author, cs.AI with no
cross-list, no journal reference, no venue in `Comments`, no CI/Wilson/95% sentence anywhere), so the
"weakest-provenance source in this base" label is now *verified* rather than *asserted* — the first time
that has happened in this project. Two additions rather than corrections: a **three-version history whose
numbers changed materially** (see new [62]) and the **Reward/Threshold columns** ([27], discharged). One
benign trap recorded for future string-searchers: `92.5` and `57.5` are ABSENT as literal strings because
they are Table 1's `0.925` and `0.575` rendered as percentages by this base. **The defect class stays
nine-way; nothing new was needed.** *Cycle 34's caveat is now the single most important qualifier on this
item and cycle 37 restates it deliberately: **the eight-cycle clean run is partly explained by where the
checks have landed.** src-0015 was one of the two remaining untested-on-both-axes backlog sources and it
came back clean; **src-0016 is now the last of them**, and it is the one carrying a known unresolved
quotation defect from cycle 21. After that, the honest test of whether the process still bites is
**src-0003 — never re-checked since collection, and the sole support for `ioc-extraction-reliability`'s
candidate 1.***

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
**[CYCLE-37 UPDATE] — BOTH AXES PAID OFF AGAIN, AND THE PROVENANCE BACKLOG IS NOW EMPTY EXCEPT src-0016.**
src-0015's "single-author preprint, cs.AI, no stated venue, peer review or affiliation" — flagged here as
"the last one" — was checked at cycle 37 and **CONFIRMED exactly, element for element**: sole author
Jarrod Barnes, `Subjects: Artificial Intelligence (cs.AI)` with no cross-list, `Journal reference:`
ABSENT, `Comments:` naming only page counts, a code repo and a dataset with **no venue**, and the arXiv
DOI as the only DOI. **The version axis produced the finding this time, not the provenance axis:** three
versions (v1 28 Jan, v2 30 Jan, v3 6 Feb 2026) whose headline false-positive rates differ materially and
one of whose headline metrics (**EGAR**) did not exist in v1 — see new [62]. **Running tally on the
`/abs` bolt-on: eight arXiv sources checked, four produced a finding.** Version checks now run: src-0008
(c29), src-0011 (c33), src-0009/src-0010 (c34), src-0013 and src-0007 (c35), src-0014 (c36), **src-0015
(c37, THREE versions)**. **src-0007's TMLR provenance is STILL UNRECORDED after three cycles of flagging
— see [58]; it is a two-minute append that any cycle may make.**

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
**[CYCLE-37 UPDATE] — THE PROOF HELD, ITS PREDICTION WAS CORRECT, AND CYCLE 37 CONFIRMS IT FROM THE
INSIDE WITH ONE CORRECTION TO ITS MECHANISM.** Prediction: the selector rotates `ttp` → `ioc` →
`consistency`. Cycle 35's T3 attempted `ioc`; cycle 37 selected **`consistency`** — exactly the next
element of the predicted rotation, reached by exactly the predicted route (`ttp` penalised for its
cycle-32 attempt, `ioc` penalised for its cycle-35 attempt, `consistency` unpenalised since cycle 25).
**THE CORRECTION, and it makes the item stronger rather than weaker:** this item says three issues beat
it "on `created_cycle`" and that it can win only when all three carry a 3b penalty. That is right about
the outcome and slightly wrong about the count — **the rotation is a three-cycle cycle over three
issues, so exactly one of the three is unpenalised at each T5 and it is always the one whose turn it
is**. Cycle 37 observed precisely that: two of three penalised, one clean, and the clean one won. The
issue therefore needs not merely "all three penalised" but a *simultaneous* penalty on three issues that
the loop's own 3-cycle period makes mutually exclusive with a 5-cycle window. **The structural claim is
confirmed empirically for the first time**, not merely derived. The proposed one-line aging fix stands
and is now supported by observation as well as by argument. Passed on verbatim with [4], [11], [30],
[41].

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

**[62] — NEW cycle 37. src-0015 HAS THREE arXiv VERSIONS AND ITS PRINCIPAL RESULTS CHANGED BETWEEN THEM.
THIS IS A FACT ABOUT THE SOURCE, NOT A DEFECT IN THE STATE.** Submission history verbatim: **v1 Wed 28
Jan 2026 (3,935 KB), v2 Fri 30 Jan 2026 (3,935 KB), v3 Fri 6 Feb 2026 (4,022 KB)**. Everything this base
stores is **v3 and only v3**, which `src-0015.md` line 128 already recorded and which is why nothing
here is wrong. What nobody had checked is that **v1 says something different**: its abstract, pulled
verbatim from `/abs/2601.21083v1`, reports *"GPT-5.2, Gemini 3, and DeepSeek execute containment in 100%
of episodes with **90-97% false positive rates**. Claude Sonnet 4.5 shows partial calibration (**85%
containment, 72% FP**)"* against v3's 82.5% / 57.5% / 65% and Sonnet's 62.5% / 45%; v1 lists its metrics
as TTFC, blast radius and injection violation rates with **no EGAR at all**, so the whole of
`key_claims[2]` describes a metric introduced after v1; and `Comments:` moves from "6 pages, 2 figures"
to "7 pages, 3 figures". **TWO CONSEQUENCES.** (1) **FETCHING NOTE, add it to the standing list beside
src-0002's v2-vs-v3 and src-0007's v2-has-no-CTI-ATE trap:** always fetch `/html/2601.21083v3` or the
bare `/abs`; a v1 URL returns different numbers and a spurious ABSENT for EGAR. (2) **THE
"WEAKEST-PROVENANCE" LABEL IS WEAKER ON A NEW AND INDEPENDENT GROUND** — an unreviewed single-author
preprint whose principal quantitative results were revised materially **nine days** after posting, with
no erratum or change note on the listing page. The existing hedge was right for a reason nobody had
checked. **NOT ENTERED AND MUST NOT BE CITED:** a `/html/…v1` fetch returned a v1 Table 1 and asserted a
v1 sentence reporting "95% Wilson CIs for rates", which if real would contradict the stored "no
confidence intervals" — but that read was **summarised, not verbatim**, and contradicted the verbatim v1
abstract on the seed-pool size, so under rule (ix) it was refused entry per [60]. **A cycle wanting
either must re-fetch v1 verbatim.** **THE GENERALISABLE POINT FOR A HUMAN:** this project's G1 gate
checks URL liveness for **new** sources only, and nothing anywhere re-checks whether a cited arXiv
source has been *revised since collection*. Four of eight sources given the version check have now
produced a finding. **An arXiv id is not a stable citation and this base treats it as one.**

**[63] — NEW cycle 37. THE T5 SELECTION RULE HAS TWO SPECIFICATION DEFECTS THAT NO GATE IN THIS PROJECT
CAN CATCH. VERBATIM FOR A HUMAN, with [4], [11], [30], [41], [55].** (i) **FIELD-NAME MISMATCH.**
`prompts/t5_select.md` step 3a names the field **`depend_on`**; `state/issues/graph.json` and its own
embedded `_schema` use **`depends_on`**. A `jq` projection written from the prompt returns `null` for
every issue, which makes tie-break 3a look inapplicable and silently hands the decision to
`created_cycle`. Cycle 37 hit this and caught it only by reading `_schema`; **an agent that trusted the
prompt's spelling would have produced a differently-ranked, plausibly-argued, wrong selection with no
gate objecting.** Fix is one character in the prompt. (ii) **UNDEFINED WINDOW.** 3b's "within the last 5
cycles" has unspecified endpoints. Cycle 37 used cycles 32–36 and reported the alternative (33–37)
alongside; the winner was the same under both, **but under the alternative there would have been a
residual tie between two issues at `created_cycle` 2 with no fourth tie-break specified anywhere.** The
policy is one attempt-date away from being undefined. **Cycle 37 invented no rule to cover it** and
records the gap instead.

**[64] — NEW cycle 37, DIRECT DESCENDANT OF [27]'s DISCHARGE. THE src-0015 REWARD FINDING IS IN THE
KNOWLEDGE BASE BUT NOT IN THE GRAPH, AND ONLY A T3 TARGETING A STARVED ISSUE CAN PUT IT THERE.**
src-0015's Table 1 Reward column (GPT-5.2 3.07, **Sonnet 4.5 2.37**, Gemini 3 2.61, **DeepSeek 3.2
3.45**) with its verbatim definition is now in `index.json` and `src-0015.md`. Its significance is that
**the harness's own objective ranks its best-restrained model last and its second-most-over-triggering
model first**, which speaks directly to `automated-triage-under-refusal`'s `open_questions[0]`: *"IS
OVER-ACCEPTANCE A PROPERTY OF THE MODELS OR OF THE HARNESS?"* Connecting the two is a **graph edit** and
therefore T2/T3 work on an issue that [55] proves is structurally unreachable. **A SECOND UNENTERED ITEM
FROM THE SAME TABLE:** the **`Threshold`** column classifies **three** models as "Part. Cal." (Sonnet
4.5, Gemini 3, DeepSeek 3.2) where the abstract names only Sonnet — so any candidate quoting the
abstract's framing is quoting a stricter reading than the paper's own table. **CONSTRAINT ON WHOEVER
TAKES THIS:** the Reward is a **training signal, not a reliability measurement**, and must not be cited
as one; and cycle 37 deliberately derived **no** arithmetic from the four reward components, so any
decomposition is the deriving cycle's own and must be labelled per rule (xii). **THE REUSABLE LESSON,
which is why this is filed separately from [27]:** [27] sat blocked for sixteen cycles because the
tracker assumed it needed a graph edit, when **the source-fact half of it was appendable by any cycle at
any time**. Before writing off a carry-forward item as unreachable, split it into its source-fact half
(appendable by anyone, no standing required) and its graph half (T2/T3 only). At least one other item in
this list is likely to split the same way — **[58]'s src-0007 TMLR provenance is pure source-fact and has
been "waiting" for three cycles for no reason at all.**
