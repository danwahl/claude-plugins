---
name: learning-experiment
description: |
  Design and track an N-of-1 self-experiment to find out which learning method
  actually works best for you. Use when the user says "design a learning
  experiment", "test whether AI tutoring helps me", "run an n-of-1", "compare
  study methods on myself", or wants rigorous personal evidence rather than
  vibes. Sets up an alternating-treatments design with delayed retention and
  transfer tests, confidence calibration, and a pre-registered stopping rule.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
---

# N-of-1 learning experiment

You help the learner run a credible single-subject experiment: does an
evidence-based method (Socratic + retrieval) actually beat their default
(AI as answer engine) *for them*, on delayed and transfer tests — the outcomes
that matter, not immediate performance?

**First**, read `${CLAUDE_PLUGIN_ROOT}/references/learning-science.md` (design
rationale) and `${CLAUDE_PLUGIN_ROOT}/references/persistence.md` (where and how
to log).

`$ARGUMENTS` may name the experiment or the domains. Two modes:

- **No existing experiment file** → run **Design & pre-register** below.
- **An experiment name/file given that already exists** → run **Track & analyze**.

Resolve the directory per `persistence.md`; experiments live at
`experiments/<name>.md`.

## Design & pre-register

Walk the learner through these, then write a pre-registration block they commit
to **before** studying (write once, never edit afterward):

- **Methods (the independent variable), 3 arms:**
  - **A** — AI as answer engine (ask, read explanation, move on): their default.
  - **B** — AI as Socratic tutor + attempt-first + retrieval + spaced review.
  - **C** — no-AI self-study (textbook/primary source + own notes).
- **Design:** **alternating treatments** across comparable, *independent*
  learning units (not ABAB — learning is cumulative, so a reversal isn't clean).
  Randomly assign each unit to an arm; counterbalance order.
- **Cross interest × method (the credibility move).** Pick a domain they *are*
  interested in (e.g. jazz theory, cosmology) **and one they're not**, and run
  all three arms in each. If B beats A even in the low-interest domain,
  motivation isn't doing the work. This 2×3 structure is the heart of it.
- **Outcome measures:**
  - **Delayed retention** (free recall + short answer) at **≥1 week**, ideally
    again at 4 weeks. Immediate post-tests are misleading.
  - **Transfer task** — novel-context application.
  - **Confidence–accuracy calibration** — rate confidence before each answer.
  - Optionally time-on-task for an efficiency (gain/minute) measure.
- **Confound controls:** pre-test each unit (drop ones already known); hold study
  time per unit constant; fix or randomize time-of-day; have a *separate* step
  generate matched-difficulty test items and pre-commit the test before studying
  (no teaching-to-the-test).
- **Pre-registration & stopping rule:** write the hypothesis, the decision rule,
  and aim for **≥5–6 units per cell**; plan for ~a quarter, not a month.

Then `mkdir -p` and write `experiments/<name>.md`: the pre-registration block,
followed by an empty append-only results table (unit, domain, arm, study date,
test date, score, confidence, calibration gap). Announce the path. Use real dates
(`date +%F` or ask) — never invent them.

## Track & analyze

- **Schedule / recall tests.** Read the file, find units whose delayed-test date
  has arrived, and prompt the learner to take them (hand off to `retrieval-quiz`
  for the actual testing, against a pre-committed key they can't game).
- **Log results** by appending rows — never overwrite the pre-registration.
- **Analyze** when there's enough data: report per-arm means on delayed retention
  and transfer, the calibration gap per arm, and a simple visual/effect-size
  read. Apply the pre-registered decision rule honestly:
  - If **B beats A on delayed transfer and it holds in the low-interest
    domain** → make B the default, stop experimenting.
  - If **A and B tie on delayed tests** → for this learner the offloading risk is
    smaller than the literature suggests; keep A for speed but spot-check
    retention.

## Honesty guardrails

Name the limits out loud: single-subject results **don't generalize beyond this
learner**; self-experiments are vulnerable to expectancy (you *want* the fancy
method to win) and ordering effects — which is exactly why pre-registration,
randomized assignment, and an ungameable key matter. Don't oversell a quarter's
data as a universal truth.
