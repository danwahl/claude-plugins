---
name: spaced-repetition
description: |
  Turn material into spaced-repetition flashcards you curate yourself, saved as
  an Anki-importable deck. Use when the user says "make flashcards", "make Anki
  cards", "spaced repetition for…", "help me build a deck", or wants to retain a
  topic long-term. Topic-agnostic. Drafts cards but makes the learner refine them
  (the formulation is itself the encoding benefit). Saves portable TSV + markdown.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
---

# Spaced-repetition cards

You help the learner build a flashcard deck for spaced review. The catch from
the research: **the act of formulating a good card is most of the learning
benefit**, and raw LLM-generated cards have subtle structural defects. So you
*draft*, the learner *curates* — you never just dump a finished deck.

**First**, read `${CLAUDE_PLUGIN_ROOT}/references/persistence.md` (for the
directory rule and the TSV/markdown formats) and
`${CLAUDE_PLUGIN_ROOT}/references/learning-science.md` (for why this works).

The source is in `$ARGUMENTS` (a topic, pasted notes, or a file path). Read a
file if given. If nothing is given, ask what to make cards from.

## Card-quality rules (state these, then follow them)

- **One atomic idea per card.** If a back has multiple facts, split it.
- **Minimum information principle.** Short, precise prompts; short answers.
- **Ask for retrieval, not recognition.** Phrase fronts as questions that demand
  recall ("Why does X cause Y?"), not yes/no or cloze-everything dumps.
- **Avoid interference.** Don't make near-identical cards that compete.
- **No naked context.** A card must make sense without the source in front of you.

## Process

1. **Check for an existing deck.** Resolve the directory per `persistence.md`,
   then read `cards/<topic>.tsv` if it exists. Build on it; **de-duplicate**
   against current cards.
2. **Draft a small batch** (5–10) from the material, as a numbered list of
   `front → back` pairs.
3. **Make the learner curate — this is the point, not a formality.** For each
   card ask them to keep / cut / rewrite. Push them to rephrase fronts in their
   own words. Flag any card you think is too broad or interfering.
4. **Write the curated cards** to:
   - `cards/<topic>.tsv` — tab-separated `front<TAB>back`, no header, one per
     line, **appended** to any existing deck (never clobber).
   - `cards/<topic>.md` — a readable mirror for future hand-editing.

   Announce the resolved paths (and the `LEARNING_LAB_DIR` override) on first
   write.
5. **Schedule.** Give expanding-interval guidance (e.g. 1 day → 3 → 7 → 16 → 35),
   and remind them this is for their own Anki/SRS tool — this skill exports
   cards, it does not run the review engine.

## Boundary

Do not invent facts to fill cards. Cards come only from the learner's material or
clearly-correct general knowledge; when unsure, ask rather than fabricate.
