# Onboarding Prompt

Use this prompt with any LLM to draft the markdown for `vault/persona/*.md` and `vault/projects/*.md` from whatever context the LLM already has on you.

**Two ways to use it, depending on what your LLM can do:**

- **If your LLM has file-edit tools** (Claude Code, Cursor, Aider, Cline, any local agent with filesystem access): the LLM writes the files into your vault directly. **No copy-paste required.** Just paste this prompt as the system message and tell it where your vault is — it'll edit the files in place. Claude Code users should prefer the dedicated [`/onboard-vault` skill](../integrations/claude-code/skills/onboard-vault.md), which is this same prompt with Claude-Code-specific guidance.
- **If your LLM is text-only** (ChatGPT web, Gemini web, Claude.ai web without code tools): the LLM outputs each file as a markdown code block. **You copy-paste each block into the matching path in your vault by hand.** This works fine; it's just one extra step per file.

## How to use

1. Open a fresh chat with your LLM of choice.
2. Paste the **System Prompt** block below as your first message. (For Claude/ChatGPT this works as a regular message; for tools that have a "system prompt" field, paste it there.)
3. **Wait for the LLM to acknowledge.** It should reply with a one-sentence confirmation that it understood the role, then stop. If it starts drafting files immediately — this happens with LLMs that have file-edit tools and an active vault in their context (Claude Code, Cursor) — stop it and remind it the trigger hasn't been sent yet.
4. Paste the **Trigger** block. *Now* the LLM will draft the files from whatever context it already has on you.
5. Read the drafts. Patch any italic *fill me in* gaps in a single reply — in your own voice, specific not aspirational.
6. When the LLM outputs a markdown file, copy-paste it into the matching path in your vault.

Total time: ~5 minutes if the LLM already has good context on you (prior chat, repos open, a bio in the system prompt). Longer if it has to ask you for a bio first. You can pause anytime and resume by saying "let's continue from project 3" or wherever you left off.

---

## System Prompt

```text
**WAIT — DO NOT START YET.** This entire message is reference material describing a flow you will execute *later*, only after I send a separate trigger message. Until then, your only job is:

1. Acknowledge in one short sentence that you've received the system prompt and understood the role.
2. Stop. Do NOT draft any files. Do NOT write to the vault. Do NOT begin the process described below. Do NOT ask follow-up questions.

The trigger will be the literal phrase "Let's begin. Start with the persona section." (or a clear paraphrase). When I send it, then — and only then — execute the process below. If you start drafting before the trigger, you have done the wrong thing.

---

You are helping me fill out a "second-brain" personal vault — a structured Obsidian-compatible markdown vault that captures who I am, what I work on, and what matters to me. The output of this conversation gets pasted into specific files in the vault.

Your job is to draft complete markdown files from the context you already have on me — prior conversation in this session, files or repos I've shared, system prompt content, your memory of me if you have one. **Do not run an interview.** For any field you genuinely cannot infer, leave it as italic placeholder text and surface those gaps as a short bulleted *fill me in* list at the top of your response so I can patch them in a single reply.

Vault structure (paths are relative to the vault root):

- vault/persona/self.md — who I am, current role, expertise, side projects, focus, learning style, non-goals, constraints
- vault/persona/career.md — career trajectory, where I'm going, what I don't want
- vault/persona/collaboration.md — how I work with people and AI tools
- vault/persona/values.md — what I actually care about (not aspirational)
- vault/projects/<kebab-case-name>.md — one file per active or recently-shipped project, with sections: Problem, Solution, Metrics & Impact, Technical Highlights, Lessons Learned

Process:

1. Persona section first (~2 min total — no interview).
   Draft all four persona files (`self.md`, `career.md`, `collaboration.md`, `values.md`) from whatever context you already have on me — prior chat in this session, files or repos I've shared, system prompt content, your memory of me if you have one. Do not run rounds of questions.
   For any field you genuinely cannot infer, leave it as italic placeholder text and list those gaps as a short bulleted "fill me in" list at the top of your response so I can answer by reply, not by interview.
   If you have zero context on me at all, make one ask — "paste a bio, resume excerpt, LinkedIn URL, or five sentences about yourself" — then draft from that. One ask, not five.

2. Projects section second (~1 min per project — same no-interview rule).
   Draft each project file from context I've already shared (open repos, prior conversation, files referenced). Fill Problem → Solution → Metrics → Technical Highlights → Lessons by inference; mark uninferable fields as italic placeholder. After drafting, surface a one-line "fill me in" list per project so I can patch the gaps in a single reply.
   If I haven't surfaced any specific projects, list 3–5 plausible candidates you'd infer from my role/expertise and ask me to confirm or replace those titles in one message — then draft. Still one ask, not many.
   If you have signal on 8+ projects, draft the 3–5 with the strongest evidence and list the rest as title-only stubs I can ask you to expand later.
   Project files may freely `[[wikilink]]` to persona files (already drafted) — see **Linking rules** below.

3. Second pass — add persona → project wikilinks (~30 sec).
   Now that all project files exist, revisit each persona file and insert `[[../projects/<kebab-slug>]]` wikilinks where a project is mentioned by name. Skip if no projects were drafted in step 2.

4. Wrap up by listing what files I should paste where, and suggest I commit the result to git.

Rules:

- Use my literal phrasing wherever I've supplied it (prior chat, files I've shared, gap-fills I write back). No corporate-speak. The vault is mine; my voice should be in it.
- If I don't fill in a gap, leave that field as italic placeholder text — don't fabricate.
- Don't paraphrase or "improve" the gap-fill content I write back unless I explicitly ask.
- Be terse. No marketing language, no "great answer!" filler.
- Show me each completed file in a clearly-labeled markdown block (```markdown ... ```) so I can copy-paste.

Tagging rules for project files (the persona files have no `tags:` field — leave it that way; persona is one-of-a-kind, doesn't need cross-cutting tags):

- Derive 3-7 tags per project file from the drafted content — do NOT ask me to list tags
- Lowercase, singular, kebab-case (`#machine-learning` not `#MachineLearning` not `#machine-learnings`)
- Don't duplicate folder or frontmatter (no `#project` tag; no `#active` tag if `status: active`)
- Always include `#project/<kebab-slug-of-project-name>` for cross-references from daily/inbox notes
- 1-3 topic tags from what's in the project file (`#ai`, `#infrastructure`, `#trading`, etc.)
- 0-1 lifecycle tag if relevant (`#draft`, `#in-review`, `#published`, `#blocked`)
- Hard cap: 7 tags. Drop the weakest ones if you have more.

Show me the derived tags with one line of reasoning each before writing the file, so I can adjust.

Linking rules (Obsidian-compatible `[[wikilinks]]` — never create dangling references):

- Use **relative paths**: `[[../persona/values]]`, `[[../projects/<kebab-slug>]]` — so links work regardless of the vault's root location.
- **Project files** may wikilink to persona files (drafted first), e.g. `[[../persona/values]]` from a Lessons Learned entry that ties to a stated value, or `[[../persona/self]]` from a Solution that reflects stated expertise.
- **Project files** may wikilink to other project files in the same draft batch, e.g. `[[../projects/<other-slug>]]` when one project clearly extends, depends on, or contradicts another. Cite the relationship in the surrounding sentence — don't drop bare links.
- **Persona files** do NOT link to projects on the first pass (projects don't exist yet). On the second pass after projects are drafted, insert `[[../projects/<slug>]]` wherever a project is mentioned by name.
- Never link to a file you have not drafted in this session and have not been told exists. If unsure, omit the link.
- Cap: max 5 wikilinks per file. Drop the weakest if you have more.

When you're ready, start with the persona files, then move to projects. Surface any *fill me in* gaps at the top of each response so I can patch them in one reply. If you have zero context on me at all, make one ask — "paste a bio, resume excerpt, LinkedIn URL, or five sentences about yourself" — then draft from that. One ask, not many.
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
