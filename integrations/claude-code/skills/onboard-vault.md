---
name: onboard-vault
description: Interview the user about themselves and their projects, then fill in the persona/ and projects/ files in their second-brain vault. Run this once after cloning the template, or re-run any time to update. Skip sections that are already populated unless the user explicitly asks to redo them.
---

# Onboard Vault

The first thing a new vault owner should run. Walks through a structured interview and writes the results into the right files in `vault/persona/` and `vault/projects/`. Resume-friendly — if the user stops partway through, the next run picks up from the first unfilled file.

## Why this skill exists

A fresh second-brain vault has structure but no content. Manually staring at five empty persona files and an empty projects folder is friction. This skill replaces that with a conversation: Claude asks structured questions, the user answers, the markdown gets written for them. Same end state, no blank-page paralysis.

## Process

### 1. Detect existing content first

Before asking anything, read the current state:

- `vault/persona/self.md`, `career.md`, `collaboration.md`, `values.md`
- `vault/projects/*.md`

A "filled" persona file has its placeholder italics (text like `*(e.g. ...)*`) replaced with real content. A vault is empty if every persona file still shows the original `*Fill this in before first use*` block.

If everything is empty → start at section 2.
If some are filled → tell the user what you found, ask which sections they want to fill or update, skip the rest.

### 2. Persona interview (5-10 minutes)

Conversational, not a form. Ask **3-5 questions per round**, wait for answers, write the corresponding section, then move on. Don't dump 30 questions at once.

**Round 1 — Self (`persona/self.md`):**

1. "One sentence: who are you and what do you do?"
2. "What's your current role title and where? And what do you actually do day-to-day — not the job description, the real work?"
3. "List 3-6 things you're genuinely deep in. Not 'familiar with' — areas where someone would call you for help."
4. "Any side projects or other hats? List them with one line each."
5. "What's your current focus this quarter? What are you actually putting time into right now?"

After answers, write a complete `persona/self.md` matching the template shape (with the user's content replacing the italic placeholders). Show it for confirmation. Then ask follow-up questions about how they learn, non-goals, and constraints — write those into the same file.

**Round 2 — Career trajectory (`persona/career.md`):**

1. "Walk me through your career — last 3-4 roles, what you did, why you left or moved on."
2. "What's the trajectory you want from here? Where are you trying to go in the next 2-3 years?"
3. "What do you NOT want? (Type of role, company size, industry — be specific.)"

**Round 3 — How you collaborate (`persona/collaboration.md`):**

1. "How do you prefer to communicate at work? Async / sync / written / verbal — what works, what doesn't?"
2. "What kind of feedback works for you? Direct / framed / written / live? What kills your productivity?"
3. "When working with AI specifically: what's gone well, what's frustrated you?"

**Round 4 — Values (`persona/values.md`):**

1. "What do you actually care about — not aspirational values, but ones that show up in your decisions? List 4-6."
2. "What's a recent decision you made that surprised people? What made it the right call FOR YOU even if not for them?"

After all four rounds, write a brief summary back to the user: "Persona section done — N files updated. Want to do projects next?"

### 3. Projects walk-through (10-20 minutes)

This part is the bigger time investment. Use a tighter loop:

For each project the user mentions in this round:

1. **Quick capture:** "What's it called? In one sentence, what is it?"
2. **The four corners:** Problem (why does it exist), Solution (what you built), Metrics (concrete outcomes — even small ones), Technical Highlights (1-3 things you're proud of)
3. **Status & lessons:** Active / paused / shipped / dead. What did you learn that you'd apply to the next project?

Write each as `vault/projects/<kebab-case-name>.md` using the template shape from `vault/_templates/project.md`. Lift the user's words directly — don't paraphrase. Their voice in their vault is the point.

**Be honest about scope.** If the user has 8+ projects, ask which 3-5 are the highest-signal ones (currently active or recently shipped) and do those first. The long-tail can fill in over time. Don't try to capture everything in one session.

**For each project, ask at the end:** "What's the next thing you'd want to write in this file in 2 weeks?" — this primes the user to come back and update, instead of treating the file as done-forever.

**Tags** — read `docs/tagging.md` first if you haven't. For each project, derive 3-7 tags from the user's answers using these rules (do NOT make the user list tags by hand):

- Lowercase, singular, kebab-case (`#machine-learning` not `#MachineLearning` or `#machine-learnings`)
- Skip anything that duplicates the folder or frontmatter (don't tag `#project` — it's already in `projects/`; don't tag the same value as the `status:` frontmatter)
- Always include `#project/<kebab-slug-of-project-name>` so daily notes / inbox items can later cross-reference this project
- Pick 1-3 topic tags from what the user described — e.g. `#ai`, `#infrastructure`, `#trading`, `#health`, `#writing`
- Pick 0-1 lifecycle tag if relevant — e.g. `#draft`, `#in-review`, `#published`, `#blocked`
- Hard cap: 7 tags. If you have more, drop the weakest ones.

Show the derived tags to the user with one line of reasoning each ("`#ai` — you mentioned LLM orchestration; `#project/quant-system` — auto-generated cross-reference") and let them adjust before writing.

### 4. People (optional, skip by default)

`vault/people/` is for tracking key collaborators (manager, mentors, frequent partners). Don't push the user to fill this unless they ask — most people find it useful to add as they go, not in a batch.

If the user wants to do it: ask for 3-5 people. For each: name, relationship, communication preference, last meaningful interaction. Write to `vault/people/<name-slug>.md` matching `_templates/person.md`.

### 5. Wrap-up

Summarize what got written. Suggest:

- "Commit this to git now — even if you tweak it later, the first version is the baseline."
- "Run `/braindump` after any meaningful work session to update project files."
- "Re-run `/onboard-vault` when your role changes or you start a new project."

Don't auto-commit — that's the user's call.

## What NOT to do

- **Don't ask 30 questions at once.** 3-5 per round, write something visible, move on.
- **Don't paraphrase the user's answers into corporate-speak.** Use their literal phrasing — that's what makes the vault feel like *theirs*, not a generic template.
- **Don't fill in placeholders with examples from the template.** If the user doesn't answer a section, leave it empty (with the original italic prompt) — they'll come back to it.
- **Don't skip the "what would you write in 2 weeks" question per project.** It's small but it converts a one-shot interview into an ongoing habit.
- **Don't write to people/ unsolicited.** Ask first; default-skip otherwise.
- **Don't auto-commit changes to git.** User decides when their identity is committable.

## Sample opening

> "I'm going to interview you to fill out your second-brain vault — persona files and project history. Total time: 15-25 minutes if we do it all in one session. We can pause and resume any time. Want to start with the persona section (5-10 min) or jump straight to projects?"
