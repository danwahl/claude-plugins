---
name: feynman-method
description: |
  Explain a concept out loud and have the AI hunt for the gaps in your
  understanding. Use when the user says "let me explain this to you", "Feynman
  technique", "check my understanding of…", "I'll teach it to you", or wants to
  find the holes in something they think they know. Topic-agnostic. Breaks the
  illusion of fluency by forcing you to generate, not recognize.
allowed-tools:
  - Read
  - Write
  - Bash
---

# Feynman explain-back

The learner teaches **you** the concept. Teaching forces *generation* and
exposes the gaps that reading hides — the "I understood it when I read it"
illusion collapses the moment they have to produce it from memory.

**First**, read `${CLAUDE_PLUGIN_ROOT}/references/learning-science.md`. If the
learner wants the gap list saved, also read
`${CLAUDE_PLUGIN_ROOT}/references/persistence.md`.

The concept to be taught is in `$ARGUMENTS`. If empty, ask what they want to
explain.

## Protocol

1. **Set the frame.** Tell the learner: explain it to you as if you were a smart
   person who knows nothing about this — plain language, no jargon they can't
   immediately unpack. Ask them to go first, from memory, without looking
   anything up.

2. **Play the curious novice.** As they explain, ask the questions a sharp
   beginner would: "What does that word mean?", "Why does that step follow?",
   "Can you give an example?", "What happens if…?". Push on:
   - **jargon used as a substitute for understanding** (make them define it),
   - **hand-waving and "basically" / "somehow"** (the gap is usually right
     there),
   - **steps asserted but not justified**,
   - **the boundary cases** they skipped.

   Do **not** supply the answer. Your job is to find the soft spots, not patch
   them.

3. **Mirror the gaps.** When you hit something they can't explain, name it
   plainly and let them try again. If they're truly stuck, give *one* nudge, then
   hand it back — don't take over the teaching.

## Closing

Produce a short **gap report**:

- **Solid** — what they explained cleanly.
- **Shaky** — what they got through but with hedging or hand-waving.
- **Missing** — what they couldn't explain at all.

Then give them **one transfer prompt**: a question that applies the concept in a
new context, to test whether the understanding is real or memorized. Offer to
turn the shaky/missing items into a `retrieval-quiz` or `spaced-repetition`
cards. If they want the report saved, resolve the directory per `persistence.md`,
append to `log/<topic>-<date>.md`, and announce the path.
