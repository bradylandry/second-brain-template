# Onboarding Prompt

Use this prompt with any LLM to interview you and produce the markdown for `vault/persona/*.md` and `vault/projects/*.md`.

**Two ways to use it, depending on what your LLM can do:**

- **If your LLM has file-edit tools** (Claude Code, Cursor, Aider, Cline, any local agent with filesystem access): the LLM writes the files into your vault directly. **No copy-paste required.** Just paste this prompt as the system message and tell it where your vault is — it'll edit the files in place. Claude Code users should prefer the dedicated [`/onboard-vault` skill](../integrations/claude-code/skills/onboard-vault.md), which is this same prompt with Claude-Code-specific guidance.
- **If your LLM is text-only** (ChatGPT web, Gemini web, Claude.ai web without code tools): the LLM outputs each file as a markdown code block. **You copy-paste each block into the matching path in your vault by hand.** This works fine; it's just one extra step per file.

## How to use

1. Open a fresh chat with your LLM of choice.
2. Paste the **System Prompt** block below as your first message. (For Claude/ChatGPT this works as a regular message; for tools that have a "system prompt" field, paste it there.)
3. Then paste the **Trigger** block. The LLM will start interviewing you.
4. Answer the questions in your own voice. Be specific, not aspirational.
5. When the LLM outputs a markdown file, copy-paste it into the matching path in your vault.

Total time: 15-25 minutes if you do it all in one session. You can pause anytime and resume by saying "let's continue from project 3" or wherever you left off.

---

## System Prompt

```text
You are helping me fill out a "second-brain" personal vault — a structured Obsidian-compatible markdown vault that captures who I am, what I work on, and what matters to me. The output of this conversation gets pasted into specific files in the vault.

Your job is to interview me with structured questions, then output complete markdown files I can paste into the vault. Process the interview in batches of 3-5 questions per round — don't dump 30 questions on me at once.

Vault structure (paths are relative to the vault root):

- vault/persona/self.md — who I am, current role, expertise, side projects, focus, learning style, non-goals, constraints
- vault/persona/career.md — career trajectory, where I'm going, what I don't want
- vault/persona/collaboration.md — how I work with people and AI tools
- vault/persona/values.md — what I actually care about (not aspirational)
- vault/projects/<kebab-case-name>.md — one file per active or recently-shipped project, with sections: Problem, Solution, Metrics & Impact, Technical Highlights, Lessons Learned

Process:

1. Persona section first (4 rounds of 3-5 questions each, ~5-10 min total).
   After each round, write a complete markdown file with my answers slotted in.
   Match the format and section headers I'll show below.

2. Projects section second (1 file per project, ~3-5 min each).
   For each project, ask: name, one-sentence pitch, then walk through Problem → Solution → Metrics → Technical Highlights → Lessons. Then ask "what would you write in this file in 2 weeks?" to prime me for ongoing updates.
   If I have 8+ projects, ask which 3-5 are highest-signal and do those first — the rest can fill in later.

3. Wrap up by listing what files I should paste where, and suggest I commit the result to git.

Rules:

- Use my literal phrasing, not corporate-speak. The vault is mine; my voice should be in it.
- If I don't answer a section, leave it as italic placeholder text — don't fabricate.
- Don't paraphrase or "improve" my answers unless I explicitly ask.
- Be terse. No marketing language, no "great answer!" filler.
- Show me each completed file in a clearly-labeled markdown block (```markdown ... ```) so I can copy-paste.

Tagging rules for project files (the persona files have no `tags:` field — leave it that way; persona is one-of-a-kind, doesn't need cross-cutting tags):

- Derive 3-7 tags per project file from my answers — do NOT ask me to list tags
- Lowercase, singular, kebab-case (`#machine-learning` not `#MachineLearning` not `#machine-learnings`)
- Don't duplicate folder or frontmatter (no `#project` tag; no `#active` tag if `status: active`)
- Always include `#project/<kebab-slug-of-project-name>` for cross-references from daily/inbox notes
- 1-3 topic tags from what I described (`#ai`, `#infrastructure`, `#trading`, etc.)
- 0-1 lifecycle tag if relevant (`#draft`, `#in-review`, `#published`, `#blocked`)
- Hard cap: 7 tags. Drop the weakest ones if you have more.

Show me the derived tags with one line of reasoning each before writing the file, so I can adjust.

When you're ready, ask me whether I want to start with persona or skip ahead to projects.
```

## Trigger

```text
Let's begin. Start with the persona section.
```

## File templates the LLM will follow

If the LLM asks for the file shapes (or seems to be making them up), paste these into the conversation:

### `vault/persona/self.md`

```markdown
---
type: persona-self
updated: YYYY-MM-DD
---

# Who I Am

## One-line summary
*(One sentence)*

## Current role
- **Title:** ...
- **Employer:** ...
- **What I actually do day-to-day:** ...
- **Tenure:** ...

## Expertise
- ...
- ...

## Side projects / other hats
- ...

## Current focus (this quarter)
- ...

## How I learn
- ...

## Non-goals
- ...

## Constraints
- ...
```

### `vault/persona/career.md`

```markdown
---
type: persona-career
updated: YYYY-MM-DD
---

# Career

## Trajectory
- **Last role:** ...
- **Role before that:** ...
- (and so on, 3-4 roles)

## Where I'm going
*(2-3 year direction)*

## What I'm NOT looking for
- ...
```

### `vault/persona/collaboration.md`

```markdown
---
type: persona-collaboration
updated: YYYY-MM-DD
---

# How I Collaborate

## Communication style
- Async vs sync: ...
- Written vs verbal: ...
- What kills my productivity: ...

## Feedback
- What works for me: ...
- What doesn't: ...

## Working with AI
- What's gone well: ...
- What's frustrated me: ...
```

### `vault/persona/values.md`

```markdown
---
type: persona-values
updated: YYYY-MM-DD
---

# What I Actually Care About

(Not aspirational — values that show up in my decisions.)

- ...
- ...

## A decision that surprised people
*(One example. What made it right for me.)*
```

### `vault/projects/<kebab-case-name>.md`

```markdown
---
project: "Project Title"
status: active | paused | shipped | dead
started: YYYY-MM-DD
role: "Solo Developer" | "Tech Lead" | etc.
team_size: 1
stack: [language, framework, key-services]
tags: [project/<kebab-slug>, <topic-tag>, <topic-tag>]   # follow tagging rules above — 3-7 tags max, lowercase, singular, kebab-case
---

# Project Title

## Problem
*(Why does this project exist? What was broken or missing?)*

## Solution
*(What I built. Specific, not abstract.)*

## Metrics & Impact
- ...

## Technical Highlights
- ...

## Lessons Learned
- ...
```

---

## What to do with the output

After the LLM writes each file:

1. Copy the contents inside the ```markdown ... ``` block
2. Paste into the matching vault path
3. Save
4. (Optional) `git add . && git commit -m "Onboarding: initial persona + projects"`

You can re-run this prompt any time. Past content won't be overwritten unless you tell the LLM to redo a specific section.
