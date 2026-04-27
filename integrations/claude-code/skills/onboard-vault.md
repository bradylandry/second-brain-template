---
name: onboard-vault
description: Draft the user's persona/ and projects/ files in their second-brain vault from context already in this session — prior chat, files/repos shared, system prompt, memory. No interview. Run once after cloning the template, or re-run any time. Skip already-filled sections unless the user explicitly asks to redo them.
---

# Onboard Vault

The first thing a new vault owner should run. Drafts persona and project files in `vault/persona/` and `vault/projects/` from whatever context is already in the session, surfaces any unfillable fields as a single "fill me in" list, and lets the user patch them in one reply. Resume-friendly — if the user stops partway through, the next run picks up from the first unfilled file.

## Why this skill exists

A fresh second-brain vault has structure but no content. The friction is the blank page, not the questions. This skill replaces a 15-25 min interview with a draft-and-patch loop: read context, write the files, surface gaps, accept a single reply patching them. Same end state, ~5 min instead of 25.

## Process

### 1. Detect existing content first

Before drafting anything, read the current state:

- `vault/persona/self.md`, `career.md`, `collaboration.md`, `values.md`
- `vault/projects/*.md`

A "filled" persona file has its placeholder italics (text like `*(e.g. ...)*`) replaced with real content. A vault is empty if every persona file still shows the original `*Fill this in before first use*` block.

If everything is empty → start at section 2.
If some are filled → tell the user what you found, ask which sections they want to refresh or extend, skip the rest.

### 2. Draft persona files (~2 min — no interview)

Read every available context source before writing:

- Prior conversation in this session
- Open files / repos in the working directory
- Anything the user has shared earlier
- Memory entries about this user (if you have a memory system)
- The system prompt and any user-supplied bio

Draft all four persona files: `self.md`, `career.md`, `collaboration.md`, `values.md`. Match the template shape from `vault/_templates/`; lift the user's literal phrasing where you have it.

For any field you genuinely cannot infer, leave it as italic placeholder text. **Surface every uninferable field as a single bulleted "fill me in" list at the top of your response** so the user can patch them in one reply — not over four rounds of questions.

If you have **zero context** on the user, make exactly one ask: *"paste a bio, resume excerpt, LinkedIn URL, or five sentences about yourself"* — then draft from that. One ask, not five.

### 3. Draft project files (~1 min per project — same no-interview rule)

Same approach as persona: draft each project file from context already shared (open repos, prior conversation, files referenced). Fill Problem → Solution → Metrics → Technical Highlights → Lessons Learned by inference; mark uninferable fields as italic placeholder. Surface a one-line "fill me in" list per project at the top of your response.

If the user hasn't surfaced any specific projects, list 3–5 plausible candidates inferred from their role/expertise and ask them to confirm or replace those titles in one message — then draft. Still one ask, not many.

If you have signal on 8+ projects, draft the 3–5 with the strongest evidence and list the rest as title-only stubs. The user can ask you to expand specific ones later.

**For each project, end the file with a `*Next planned update:*` italic placeholder line** (e.g. `*Next planned update: ship migration; revisit metrics*`). This primes the user to come back and update — replaces the old "what would you write in 2 weeks" interview question with a built-in field.

**Tags** — read `docs/tagging.md` first if you haven't. For each project, derive 3-7 tags from the drafted content using these rules (never ask the user to list tags):

- Lowercase, singular, kebab-case (`#machine-learning` not `#MachineLearning` or `#machine-learnings`)
- Skip anything that duplicates the folder or frontmatter (don't tag `#project` — it's already in `projects/`; don't tag the same value as `status:`)
- Always include `#project/<kebab-slug-of-project-name>` so daily notes / inbox items can later cross-reference this project
- Pick 1-3 topic tags from the project content — e.g. `#ai`, `#infrastructure`, `#trading`, `#health`, `#writing`
- Pick 0-1 lifecycle tag if relevant — e.g. `#draft`, `#in-review`, `#published`, `#blocked`
- Hard cap: 7 tags. If you have more, drop the weakest ones.

Show the derived tags with one line of reasoning each before writing the file ("`#ai` — Solution mentions LLM orchestration; `#project/quant-system` — auto-generated cross-reference") and let the user adjust.

### 4. Linking pass — wikilinks across files

Project files may freely insert `[[wikilinks]]` to persona files (already drafted in section 2). Use **relative paths** so links work regardless of vault root:

- `[[../persona/values]]` from a project's Lessons Learned entry that ties to a stated value
- `[[../persona/self]]` from a Solution that reflects stated expertise
- `[[../projects/<other-slug>]]` when one project clearly extends, depends on, or contradicts another in the same draft batch — cite the relationship in the surrounding sentence, don't drop bare links

After all project files exist, do a **second pass over the persona files**: insert `[[../projects/<slug>]]` wherever a project is mentioned by name in `self.md`, `career.md`, etc.

Rules:

- Never link to a file you have not drafted in this session and have not been told exists. If unsure, omit the link.
- Cap: max 5 wikilinks per file. Drop the weakest if you have more.

### 5. People (optional, skip by default)

`vault/people/` is for tracking key collaborators (manager, mentors, frequent partners). Don't push the user to fill this unless they ask — most people find it useful to add as they go, not in a batch.

If the user wants to do it: draft 3-5 from context (manager mentioned in prior chat, collaborators referenced in repos, etc.) and surface a "fill me in" list only for unfillable fields. Write to `vault/people/<name-slug>.md` matching `_templates/person.md`.

### 6. Wrap-up

Summarize what got written. Suggest:

- "Commit this to git now — even if you tweak it later, the first version is the baseline."
- "Run `/braindump` after any meaningful work session to update project files."
- "Re-run `/onboard-vault` when your role changes or you start a new project."

Don't auto-commit — that's the user's call.

## What NOT to do

- **Don't run an interview.** Draft from context, surface gaps as a single "fill me in" list, accept one reply to patch them.
- **Don't ask multiple rounds of questions.** The new flow is one ask, only when context is genuinely empty.
- **Don't paraphrase the user's literal phrasing into corporate-speak.** Use their words wherever you have them — that's what makes the vault feel like *theirs*, not a generic template.
- **Don't fabricate** for fields you can't infer. Leave the original italic placeholder and surface it for the user to fill.
- **Don't write to people/ unsolicited.** Default-skip otherwise.
- **Don't auto-commit changes to git.** User decides when their identity is committable.
- **Don't link to a file you haven't drafted in this session.** No dangling references.

## Sample opening

> "I'll draft your persona and project files from what I already know about you in this session — prior chat, repos open, anything you've shared. Should take ~5 minutes. After each draft I'll surface a short list of fields I couldn't fill; you patch them in one reply. Starting with persona."
