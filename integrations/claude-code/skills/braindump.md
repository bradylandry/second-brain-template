---
name: braindump
description: Parse a freeform session dump, identify the correct project file in the vault, add a dated section matching the file's house style, and commit the change.
---

# /braindump — Update your second brain with session work

You are updating the user's second-brain project documentation. The vault is the current working directory (or a nested path — find it by looking for `vault/HOME.md` or a folder structure matching `projects/`, `daily/`, etc.).

## Instructions

### 1. Identify the project

Look at the current working directory and conversation context to detect which project this is about. Map it to a file in `projects/` (or `work/Projects/` in some layouts).

If unclear, ask the user which project to update. Never guess silently.

### 2. Collect the update

The user's input after `/braindump` is a freeform dump of what they accomplished. Parse it into structured content. If they typed `/braindump` with no following content, infer from recent conversation context — the last significant work episode.

### 3. Read the existing project file

Understand the current state and avoid duplicating information. Match the file's existing tone, section style, and bullet/prose ratio.

### 4. Format the update

Insert a dated section BEFORE `## Lessons Learned` (or at the end if no Lessons Learned section exists). Format:

```markdown
## <Section Title> (YYYY-MM-DD)

One-line summary of what was accomplished.

- **Key detail**: explanation
- **Key detail**: explanation
- **Blocker / Next step**: what's pending (if any)
```

Use today's date (convert from relative dates in the user's message if needed).

### 5. Update frontmatter if needed

- Change `status:` if the project completed or paused
- Add items to `stack:` if new technologies were introduced
- Update `tags:` if scope changed

### 6. Commit

If the vault is a git repo:

```bash
git add "projects/<filename>.md"
git commit -m "<project>: <one-line summary>"
```

**Do not push without explicit user approval.** The user may want to review before publishing.

## Rules

- **Terse over verbose** — bullet points, not paragraphs
- **Specific over general** — model names, URLs, config values, not vague descriptions
- **What over why** as the lead; include why only when non-obvious
- **Don't repeat** what's already in the file — check for existing mentions
- **Don't modify** the Problem, Solution, Metrics, or Technical Highlights sections unless the user explicitly asks
- **Use `**bold**`** for key terms in bullet points
- **Always read the file first** — no updates without reading current state
- **Insert `[[wikilinks]]` for cross-references** — when a bullet ties to a stated value link `[[../persona/values]]`; when it references another project link `[[../projects/<slug>]]`; when it references a tracked person link `[[../people/<slug>]]`. **Only link to files that already exist in the vault** — check `vault/persona/`, `vault/projects/`, and `vault/people/` first. Use relative paths. Never create dangling references. Cap: ~3 wikilinks per dated section; drop the weakest.

## Example

**User input:** `/braindump` (after session working on mobile app)

**You:**
1. Detect: working directory is `~/vault`, recent conversation was about `mobile-app-launch.md`
2. Read `projects/mobile-app-launch.md`
3. Add a new section:

```markdown
## Auth Migration Complete (2026-04-23)

Migrated auth provider from X to Y over one weekend.

- **Root cause**: custom domain blocked third-party JWKS fetch
- **New stack**: provider Y (email + Google), local state in Firestore
- **Bonus fix**: font loading on web deploy (path issue in `.vercelignore`)
- **Blocker**: Apple Sign-In still needed before iOS submission
```

4. Commit: `git commit -m "mobile-app-launch: auth migration + font fix"`
5. Report to user: "Added a new section to projects/mobile-app-launch.md and committed locally. Push when ready."
