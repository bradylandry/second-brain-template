# Tagging — the rules, and the point of view

Tags are the single biggest place second-brain systems go wrong. Either you use too many (every file has 15 tags, none of them mean anything) or too few (tags exist but nothing is findable). This doc is the template's opinionated guide.

## The core rule

**Folders tell you WHERE. Frontmatter tells you WHAT. Tags tell you CROSS-CUTTING.**

- If a file belongs in one semantic place → use a folder (`projects/`, `references/`, `people/`)
- If a file has a stable primary identity → use frontmatter (`type: project`, `status: active`)
- If a file has attributes that cross those primary categorizations → use tags (`#ai`, `#infrastructure`, `#longread`)

Don't use tags to duplicate what a folder or frontmatter field already says. Tagging every file in `projects/` with `#project` is waste. Your AI filters on `type: project` frontmatter in milliseconds.

## Syntax rules (follow these strictly)

1. **Lowercase only.** `#ai` not `#AI` not `#Ai`. Obsidian treats capitalization as different tags for autocomplete purposes — you'll end up with `#AI`, `#ai`, and `#Ai` all fragmented.

2. **Singular, not plural.** `#book` not `#books`. `#meeting` not `#meetings`. Both forms will exist if you're inconsistent, and search won't unify them.

3. **Kebab-case for multi-word tags.** `#machine-learning` not `#machinelearning` or `#machineLearning`. Hyphens are readable and Obsidian-friendly.

4. **Hierarchical with `/` when useful.** `#project/mobile-app` and `#project/quant-system` — searching `tag:#project` returns both. Don't go deeper than 2 levels (`#work/team/quarterly/q2-2026` is too deep).

5. **3-7 tags per file, hard cap.** More than 7 and you're cataloging, not tagging. Every additional tag beyond 5 adds noise faster than signal.

## The tag vocabularies I use

Not exhaustive — just the categories that have proven useful across many vaults. Adapt to your life.

### Topic tags (what is this about)
Use when a topic shows up across multiple files that aren't in the same folder.
- `#ai`, `#infrastructure`, `#trading`, `#health`, `#writing`

### Status tags (where is this in its lifecycle)
Useful on things that have a workflow beyond simple active/done.
- `#draft`, `#in-review`, `#published`, `#waiting`, `#blocked`

### Context tags (when should I see this)
For when you process things in batches by mode.
- `#deep-work`, `#quick-win`, `#home`, `#computer-required`, `#phone-only`

### Person tags (who does this involve)
Optional. Only if you don't have a `people/` folder, or you want cross-references.
- `#person/alice`, `#person/bob`

### Project tags (what does this roll up to)
Use to flag content from scattered locations (an inbox note, a reference, a daily note) that relates to an active project.
- `#project/mobile-app`, `#project/q2-migration`

## What NOT to tag

- **Primary file type** — covered by folder + frontmatter already
- **Dates** — covered by filenames (`2026-04-24.md`) and frontmatter
- **Every concept mentioned in the file** — you're not building a search engine; you're flagging your own future retrieval paths
- **Things you tag once and never use to search** — a tag used 1-2 times is a tag that should have been prose

## Why this matters for AI

Tags are the cheapest way for your AI to filter across folder boundaries. Two concrete examples:

**"What AI-related work have I done this quarter?"**
Your AI greps for `#ai` frontmatter tags across `projects/`, `daily/`, `inbox/`, `references/`. One query. Without tags, it has to read every file and decide if it's AI-related — expensive, noisy, wrong 20% of the time.

**"What decisions have I made about the mobile app?"**
Files tagged `#project/mobile-app` plus `type: decision` (via frontmatter) produce an instant answer. Files without this metadata require reading everything.

A well-tagged vault lets your AI give you 10x faster, more accurate retrieval. A poorly-tagged vault defeats the whole point of having AI integration.

## When to add tags to existing files

Retrofitting tags into an existing vault is a one-hour project with [Tag Wrangler](https://github.com/pjeby/tag-wrangler) (Obsidian plugin). It handles bulk rename, merge, and delete.

Better pattern: **tag as you create**. When your AI adds a `/braindump` section to a project file, it can also add relevant tags. When you create a new note, the template frontmatter should include a `tags:` array ready to fill.

## Anti-patterns I've learned the hard way

- **The "interesting" tag.** Starts with good intentions. Within a month, 200 files have it. Now it means nothing.
- **Camel-case creep.** One file has `#MobileApp` because you were on your phone. Now search for `#mobile-app` misses it.
- **Tag hierarchies 4 levels deep.** `#work/cox/networking/fabric/design/ospf` is just a folder path pretending to be a tag. Use folders.
- **Status tags that never update.** `#waiting` on a file from 9 months ago = useless. If you won't maintain status tags, don't use them.
- **Tag as a substitute for writing.** Tagging a file `#important` and moving on is deferring the hard work of explaining why. Write a sentence.

## Template's own tag usage

The template's frontmatter includes a `tags:` array on daily, weekly, and project files — all with a single tag matching the file type. Feel free to extend those arrays as you categorize:

```yaml
---
type: project
status: active
tags: [project, ai, infrastructure]
---
```

Your AI reads both `type:` and `tags:` automatically — they're complementary.

## Worth reading — kepano's vault

Steph Ango ([@kepano](https://github.com/kepano)), CEO of Obsidian, publishes his personal vault and writings on structure. His approach is more *bottom-up* than this template (organic note-creation, emergent structure) while this template is more *top-down* (semantic folders, typed frontmatter, AI-readable).

Neither is correct. They're for different goals:
- **Kepano's style** — excellent for a single human writing atomic notes and letting patterns emerge
- **This template** — excellent for AI integration, where machine-readable structure is the point

Read his [How I use Obsidian](https://stephango.com/vault) and his [file-over-app](https://stephango.com/file-over-app) manifesto. The philosophy — that files should be portable, format-stable, and independent of any specific app — is foundational to this template too (MIT markdown, no proprietary format, no vendor lock-in).

His public vault is at [github.com/kepano/kepano-obsidian](https://github.com/kepano/kepano-obsidian). Worth browsing for alternative patterns.

Sources:
- [How to Use Tags Effectively — Practical PKM](https://practicalpkm.com/how-to-use-tags-effectively/)
- [Obsidian Tags — Official Help](https://help.obsidian.md/tags)
- [How to Structure Notes — Categories, Tags, and Folders (Obsidian Forum)](https://forum.obsidian.md/t/how-to-structure-notes-categories-tags-and-folders/103125)
- [Tag Wrangler plugin](https://github.com/pjeby/tag-wrangler)
- [Steph Ango — How I use Obsidian](https://stephango.com/vault)
- [Steph Ango — File over app](https://stephango.com/file-over-app)
- [kepano/kepano-obsidian (public vault)](https://github.com/kepano/kepano-obsidian)
