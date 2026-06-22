# Learning science: the basis for these skills

Every skill in this plugin follows one rule:

> **Make the AI create the difficulty, not remove it.**

AI raises learning when it forces effortful retrieval, generation, and struggle.
It *lowers* learning when it acts as an answer engine that smooths the effort
away. The same model flips the sign of the effect depending on how it is used.

Read this before tutoring so you can explain *why* you are withholding answers,
and so the learner can inspect the evidence themselves.

## The decisive evidence

- **Tool design flips the sign.** In a ~1,000-student RCT (Bastani et al.,
  *Generative AI Can Harm Learning*, PNAS 2025), plain ChatGPT ("GPT Base")
  boosted practice performance but left students **17% worse on a later unaided
  exam** than peers who never had AI. A guardrailed "GPT Tutor" (hints not
  answers, one step at a time) erased the harm. GPT Base students also *felt*
  they had learned as much — a calibration failure.
- **Independent replication.** Barcaui (2025, n=120) found free ChatGPT study
  scored **57.5%** on a 45-day retention test vs **68.5%** for traditional study
  (d=0.68).
- **The upside of good design.** The Harvard physics RCT (Kestin et al.,
  *Scientific Reports* 2025) used "PS2 Pal" — a tutor told to give **one step at
  a time, never the full solution, and to make the student try first**. It
  produced ~0.7–1.3 SD more learning than a strong active-learning class, in
  *less* time. The paradox with the Turkey study resolves on design: PS2 Pal
  withholds answers and demands attempts.
- **MIT "Your Brain on ChatGPT" (Kosmyna 2025)** is a small, non-peer-reviewed
  EEG preprint. Treat it as a hypothesis about cognitive offloading, **not**
  proof of harm. The authors themselves ask people not to say "brain rot" or
  "damage."

## The cognitive science it rests on

- **Desirable difficulties (Bjork).** Conditions that feel hard and slow during
  study — spacing, interleaving, retrieval, generation — depress immediate
  performance but improve long-term retention and transfer. *Storage strength*
  (durable) is distinct from *retrieval strength* (easy access now). AI that
  removes effort optimizes the wrong variable.
- **Generation effect (Slamecka & Graf 1978).** You remember what you produce
  better than what you read.
- **Testing effect / retrieval practice (Roediger & Karpicke 2006).** Being
  tested beats restudying. Free recall beats recognition (multiple choice).
- **Spacing & interleaving (Rohrer & Taylor).** Distributed, mixed practice
  beats massed, blocked practice.
- **Illusion of fluency (Bjork, Dunlosky & Kornell 2013).** Clear text and
  rereading create a feeling of knowing that makes learners stop too early.
  **"That explanation was so clear" is a warning, not a success.**
- **Hypercorrection (Butterfield & Metcalfe 2001).** Errors made with *high
  confidence* are especially likely to stick once corrected — the surprise
  drives deep encoding. So commit an answer *and a confidence rating* before
  asking the AI.
- **Expertise reversal (Kalyuga, Sweller).** Worked examples and full
  explanations help **novices** but become redundant or harmful for experts, who
  learn more by generating themselves.
- **Worked-example effect (Sweller).** For novices, studying a worked example is
  efficient — *if* you then self-explain each step and attempt a fresh problem.
  Otherwise it is passive viewing.
- **Cognitive offloading / Google effect (Sparrow 2011; Fisher 2015).** When
  information stays available, we remember it less and over-estimate our own
  internal knowledge. AI is the strongest version of this.

## The nine techniques (what the skills operationalize)

1. **Attempt-first, then confront.** Write your answer *and* a 1–5 confidence
   rating before asking anything. (generation + hypercorrection)
2. **Socratic tutor mode.** One question/hint per turn, never the full answer
   unless demanded, make the learner explain in their own words.
3. **Retrieval practice.** Quiz with free-recall / short-answer, answers hidden.
4. **Feynman / explain-back.** Teach the concept to the AI; it finds the gaps.
5. **Spaced repetition.** Draft SRS cards, but the learner curates and rewrites.
6. **Interleaving.** Mix problem types and topics within a session.
7. **Productive struggle.** Attempt at the edge of ability; generate even when
   unsure; generate-then-correct beats studying correct answers.
8. **Critique & transfer.** Find flaws in the learner's explanation; pose a novel
   transfer problem — transfer is the real test, not recall of the example.
9. **Guard the fluency illusion.** The only valid evidence of learning is
   delayed, unaided retrieval and transfer.

## Calibrating by expertise

- **Novice in a domain** (e.g. a software engineer learning jazz theory): worked
  examples and explanations genuinely help — but require self-explanation and a
  fresh attempt after each one.
- **Intermediate/advanced**: shift the AI from explaining toward problem-posing
  and critique.
- **Expert domain**: AI is mostly a productivity tool, not a learning tool. When
  you *do* want to learn a new concept deeply there, apply the attempt-first
  protocol instead of reading the generated solution.

## Honest caveats to pass on to the learner

- Strongest evidence is in K-12/undergrad settings; transfer to self-directed
  adults is an inference, not a measured fact.
- Many tutoring effect sizes are *immediate* performance; durable delayed
  retention is under-tested — which is exactly why the `learning-experiment`
  skill exists.
- Vendor/first-party claims (Khanmigo "23%", Alpha School "2.3x") are marketing
  until independently replicated.
