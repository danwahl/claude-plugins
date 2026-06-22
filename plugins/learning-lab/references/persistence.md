# Persistence convention

Learning artifacts (cards, experiment logs, session notes) are the learner's
data, not the plugin's. **Never write inside `${CLAUDE_PLUGIN_ROOT}`** — that
directory is read-only and is overwritten when the plugin updates.

## Resolving the working directory

Resolve the learning-lab data directory in this order and stop at the first hit:

1. **An explicit path the learner gives you** this session ("my deck is at …",
   "save it under ~/study"). Use it verbatim.
2. **`$LEARNING_LAB_DIR`** if that environment variable is set.
3. **`./.claude/learning-lab/`** if a `.claude/` directory already exists in the
   current working directory (project-scoped study).
4. Otherwise **`~/.claude/learning-lab/`** (stable, launch-directory-independent
   default).

Determine it once per session with a single shell check, e.g.:

```bash
if [ -n "$LEARNING_LAB_DIR" ]; then dir="$LEARNING_LAB_DIR"
elif [ -d "./.claude" ]; then dir="./.claude/learning-lab"
else dir="$HOME/.claude/learning-lab"; fi
echo "$dir"
```

## Rules

- **Announce the resolved path the first time you write** in a session
  ("Saving to `~/.claude/learning-lab/cards/jazz-theory.tsv`"), so there is no
  surprise. Mention the `LEARNING_LAB_DIR` override if it wasn't used.
- **Create directories idempotently** (`mkdir -p`). Never error if they exist.
- **Never clobber.** Read an existing file before writing; append or merge rather
  than overwrite. For cards, de-duplicate against what's already there.
- **Writing is opt-in for stateless skills.** `socratic-method`, `retrieval-quiz`,
  and `feynman-method` deliver their value in conversation; only write a log if the
  learner wants one. `spaced-repetition` and `learning-experiment` are inherently
  file-backed.

## Layout

```
<dir>/
  plans/<topic>.md           # the standing learning plan: context + step checklist
  cards/<topic>.tsv          # Anki-importable, one card per line
  cards/<topic>.md           # human-readable mirror, for curation
  experiments/<name>.md      # pre-registration + running log
  log/<topic>-<YYYY-MM-DD>.md # optional session notes / quiz results
```

## File formats

- **Plan — `plans/<topic>.md`.** The one file that *lives across sessions* — it's
  read on re-entry and updated in place (read-modify-write), so `tutor` resumes
  instead of re-deriving. Two parts:
  - A **header, written once and never clobbered**: topic, created date, and the
    calibration context — `Goal`, `Level`, `Time` (budget), `Interest`, and a
    short prose **Context** line capturing *why* they're learning it, constraints,
    and what they've already tried. This is the context that's otherwise lost
    between sessions.
  - A **step checklist that is updated** as work happens. One checkbox per step,
    each carrying its technique + sub-topic, an optional `when:` target date, and
    a log back-reference once done. For example:

    ```
    # Learning plan: jazz theory
    Created: 2026-06-22
    Goal: understand it deeply   Level: novice   Time: ~3 h/week   Interest: high
    Context: plays guitar by ear, wants to read lead sheets; tried a YouTube
    course but it didn't stick.

    ## Arc
    - [x] 1. socratic-method — intervals & the major scale  (done 2026-06-22 → log/jazz-theory-2026-06-22.md)
    - [ ] 2. socratic-method — triads & seventh chords
    - [ ] 3. retrieval-quiz — chords so far    when: 2026-06-29
    - [ ] 4. delayed transfer test             when: 2026-07-20
    ```

  Tick a step (`[ ]` → `[x]`) when it's completed; never rewrite the header.
- **Cards — `<topic>.tsv`.** Tab-separated, two columns: `front<TAB>back`. No
  header row (Anki imports cleanly without one). One atomic idea per card; avoid
  multi-fact backs. Keep a parallel `<topic>.md` the learner can edit by hand.
- **Experiment log — `<name>.md`.** Markdown: a pre-registration block
  (hypothesis, arms, units, outcome measures, stopping rule, date) that is
  **written once and never edited after**, followed by an append-only results
  table (unit, method arm, study date, test date, score, confidence, calibration
  gap).
- **Session log — `<topic>-<date>.md`.** Markdown: what was studied, the
  free-recall summary, items missed, and any cards created. If a
  `plans/<topic>.md` exists, add a `Plan: <topic> — step N (<technique>:
  <sub-topic>)` line at the top so the session is traceable to the plan, and tick
  that step in the plan.

Dates: ask the learner or read the system clock via `date +%F`. Do not invent
dates.

## Scheduling (optional)

The plan's later steps are inherently date-driven — spaced reviews at expanding
intervals, delayed retrieval and transfer tests at ≥1 week and 4 weeks. Those
dates live in the plan (the `when:` field per step); the plan is the single
source of truth.

If a **calendar tool is available this session** (e.g. a connected Google
Calendar MCP that can create events), `tutor` may *offer* to add the dated steps
to the learner's calendar — each event a reminder to come back and run the next
skill. Create these as **events on the learner's own calendar (reminders to
self), with no attendees** — that's the whole feature, and it's always allowed.
Do **not** invite other people: the harness blocks the agent from emailing an
invitation to any address it inferred, and rightly so. Only add an attendee if
the learner explicitly gives you the email and asks you to invite them. This is
strictly opt-in and capability-gated: never assume the tool exists, and if it
doesn't, just leave the dates in the plan and tell the learner to set their own
reminders. The plugin never hard-depends on any MCP server.

(Claude Code's own cron / `schedule` triggers *Claude* runs rather than human
reminders, so it's deliberately not used here — these are sessions a person
attends.)
