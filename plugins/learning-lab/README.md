# learning-lab

A set of topic-agnostic skills for **learning with AI instead of offloading to
it**. Each skill operationalizes a technique from the learning-science evidence
on AI tutoring, all enforcing one rule:

> **Make the AI create the difficulty, not remove it.**

The same model raises learning when it forces retrieval, generation, and
struggle — and *lowers* it when it acts as an answer engine. These skills are the
"force the effort" mode, usable on any subject: jazz theory, cosmology, geology,
a language, math, whatever you're learning.

## Install

```
/plugin marketplace add danwahl/claude-plugins
/plugin install learning-lab@danwahl-claude-plugins
```

## Skills

Start with **`tutor`** — it plans how to learn your topic and routes you to the
rest. The other five are the techniques it draws on; invoke any of them directly.

| Skill | What it does |
|-------|--------------|
| `/learning-lab:tutor` | **Entry point.** Assesses your goal, level, and time, then builds an evidence-based study plan and hands off to the technique below. |
| `/learning-lab:socratic-method` | Withholds answers, makes you commit an attempt + confidence before explaining, gives one hint per turn, makes you explain back. |
| `/learning-lab:feynman-method` | You teach a concept to the AI, which plays a curious novice and hunts for the gaps your reading hid. |
| `/learning-lab:retrieval-quiz` | Free-recall (not multiple-choice) quizzing with answers hidden until you commit; reports a confidence-vs-accuracy calibration gap. |
| `/learning-lab:spaced-repetition` | Drafts flashcards but makes you curate them, then saves an Anki-importable deck (TSV + markdown). |
| `/learning-lab:learning-experiment` | Designs and tracks an N-of-1 self-experiment (interest × method) with delayed retention and transfer tests. |

Each takes the subject as an argument, pasted text, or a file path, e.g.
`/learning-lab:tutor the circle of fifths`.

## Design choices

**Evidence-driven.** Built from the RCT and cognitive-science literature on AI
tutoring (Bastani et al. PNAS 2025; Kestin et al. *Scientific Reports* 2025;
Bjork's desirable difficulties; the generation, testing, spacing, and
hypercorrection effects). The basis is in
[`references/learning-science.md`](references/learning-science.md), loaded on
demand so the skill prompts stay lean.

**Attempt-first, always.** The biggest, best-identified finding is that
unguarded AI *cuts* later unaided performance while answer-withholding tutors
roughly double learning. So every skill makes you produce before it reveals.

**Calibration over fluency.** "That explanation was so clear" is treated as a
warning, not a success. The only valid evidence of learning is delayed, unaided
retrieval and transfer — which is what `retrieval-quiz` and `learning-experiment`
measure.

**Your data, your machine.** Logic ships in the plugin (read-only); your cards
and experiment logs are written to **your** space under `.claude/learning-lab/`,
resolved as: an explicit path you give → `LEARNING_LAB_DIR` → `./.claude/...` if
a `.claude/` dir exists in your working directory → `~/.claude/...` by default.
Files are plain TSV/markdown — portable, diff-able, never locked in. See
[`references/persistence.md`](references/persistence.md).

## License

MIT
