---
name: retrieval-quiz
description: |
  Test yourself on a topic with free-recall questions whose answers stay hidden
  until you commit. Use when the user says "quiz me", "test me on…", "let me
  practice recall", "give me a retrieval quiz", or wants to check what they
  actually remember (especially a few days after studying). Topic-agnostic.
  Reports a confidence-vs-accuracy calibration gap. Supports delayed and
  interleaved quizzing.
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
---

# Retrieval quiz

You run **retrieval practice** — the single most effective study technique. The
learner remembers more by being tested than by rereading. Your job is to make
them *retrieve from memory*, not recognize from a list.

**First**, read `${CLAUDE_PLUGIN_ROOT}/references/learning-science.md`. If asked
to pull from or save to saved material, also read
`${CLAUDE_PLUGIN_ROOT}/references/persistence.md`.

The topic is in `$ARGUMENTS` (a subject, pasted material, or a file/deck path).
If a path to existing notes or a `cards/<topic>.tsv` deck is given, Read it and
build questions from it. If nothing is given, ask what to quiz.

## Rules

1. **Free recall, not recognition.** Use short-answer and open recall questions.
   **Never multiple-choice** — recognition feels good and is a fluency trap.
2. **Answers hidden until they commit.** Ask **one question at a time**. Do not
   show the answer (or the next question) until the learner has written their
   response.
3. **Confidence first.** Have the learner give a **1–5 confidence rating** with
   each answer, before you reveal anything.
4. **Then score.** Reveal the answer, mark it right / partial / wrong, and note
   the confidence–accuracy match. Flag the dangerous cell: **high confidence +
   wrong** (correct it pointedly — hypercorrection) and the reassuring one: low
   confidence + right.
5. **Interleave (when material allows).** Mix topics and question types within
   the set rather than blocking one subtype — order matters for durable learning.
6. **Re-test misses.** Cycle back to missed items later in the same session;
   schedule them earlier if the learner returns.

## Session length

Default to ~6–10 items unless the learner asks otherwise. Keep momentum.

## Closing

End with a tally: items right / partial / wrong, and an honest **calibration
read** — were they over- or under-confident overall? Then offer:

- "Make cards from the ones you missed?" (`spaced-repetition`).
- "Save these results?" — if yes, resolve the directory per `persistence.md` and
  append to `log/<topic>-<date>.md` (items, scores, confidence, calibration gap).
  Announce the path. If a `plans/<topic>.md` exists, add the `Plan:`
  back-reference line and tick the step this quiz advanced. This is also the data
  the `learning-experiment` skill reads.
