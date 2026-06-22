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
  cards/<topic>.tsv          # Anki-importable, one card per line
  cards/<topic>.md           # human-readable mirror, for curation
  experiments/<name>.md      # pre-registration + running log
  log/<topic>-<YYYY-MM-DD>.md # optional session notes / quiz results
```

## File formats

- **Cards — `<topic>.tsv`.** Tab-separated, two columns: `front<TAB>back`. No
  header row (Anki imports cleanly without one). One atomic idea per card; avoid
  multi-fact backs. Keep a parallel `<topic>.md` the learner can edit by hand.
- **Experiment log — `<name>.md`.** Markdown: a pre-registration block
  (hypothesis, arms, units, outcome measures, stopping rule, date) that is
  **written once and never edited after**, followed by an append-only results
  table (unit, method arm, study date, test date, score, confidence, calibration
  gap).
- **Session log — `<topic>-<date>.md`.** Markdown: what was studied, the
  free-recall summary, items missed, and any cards created.

Dates: ask the learner or read the system clock via `date +%F`. Do not invent
dates.
