---
name: emerge
description: Surface 3-5 unnamed recurring themes, patterns, or values across the user's project files and persona docs. Outputs candidate names with citations so the user can decide which to formalize. Read-only — never writes to the vault.
---

# /emerge — Surface unnamed patterns from the vault

You are pattern-mining the vault. The user wants to find themes they keep returning to but haven't given a name. The skill produces 3-5 candidate patterns, each with citations across multiple files, so the user can decide which deserve to be added to `persona/values.md`, `persona/decision-patterns.md`, or a new persona doc.

Patterns that already have names (anything explicitly listed in `persona/values.md` or `persona/decision-patterns.md`) are out of scope — those are already named. The point of the skill is to discover what's *not* yet documented.

## Inputs

The vault root is the current working directory (or a nested path — find it by looking for `vault/HOME.md` or a folder structure matching `projects/`, `persona/`, etc.).

Read in this order:

1. `persona/values.md` and `persona/decision-patterns.md` — the **already-named** patterns. Use these as a *block list*; don't surface anything that's already here.
2. `projects/*.md` — every file, every section. Skip frontmatter for theme-mining; parse the body.
3. `decisions/*.md` if present — explicit decision records.

You don't need to read `daily/` or `journal/` for this skill — they're noisy and the project files are denser.

## What counts as an emerging pattern

A pattern qualifies if it shows up in **at least 3 different files** with similar language, framing, or stance. Three flavors to look for:

1. **Recurring constraint** — a limit the user keeps respecting without naming it. Example: "across 5 projects, you've ripped out features citing 'too much for v1' — you have an unnamed bias toward minimum-viable-shipping."
2. **Recurring rejection** — a class of approach the user keeps refusing. Example: "across 4 projects you've moved away from K8s/microservices toward single-process. You don't have a stated rule against complexity, but the pattern is consistent."
3. **Recurring framing** — a way of describing problems that shows up repeatedly. Example: "you describe four projects as 'protecting the family' — values.md mentions family but doesn't name 'designs that benefit family' as a pattern."

## What does NOT qualify

- A theme that appears in only 1-2 files (statistical noise).
- A theme already named in `persona/values.md` or `persona/decision-patterns.md`.
- Generic engineering virtues ("the user values testing"). Be specific.
- Inferences from absence (don't make up themes from "what they didn't say").

## Output format

```markdown
## Emerging patterns (3-5)

### 1. [Candidate name in 3-7 words]
**What it looks like:** [one sentence describing the pattern]

**Where it shows up:**
- `projects/<file>.md` — "[verbatim quote]"
- `projects/<other>.md` — "[verbatim quote]"
- `projects/<third>.md` — "[verbatim quote]"

**Why this might deserve a name:** [one sentence]

**Could go in:** `persona/values.md` | `persona/decision-patterns.md` | new file `persona/<slug>.md`

---

### 2. [Candidate name]
...
```

End with a single line: `*Add the patterns you want to keep to persona/. Discard the rest.*`

## Rules

- **Cite verbatim.** Quote real text. If you can't find 3 quotes for a pattern, drop it.
- **Don't fabricate.** If you can't find 3 patterns that meet the bar, surface only what's real and say "Found N patterns above the 3-citation bar; the rest were 1-2 occurrences." Don't pad to hit 5.
- **Don't restate values.md.** If the pattern is already named, drop it.
- **No marketing language.** Pattern names should be the user's voice, not LinkedIn-speak.
- **Don't write to the vault.** Read-only skill. The output is the response.
- **Cap at 5 patterns.** Quality over quantity.

## Example

**User input:** `/emerge`

**Your output (abbreviated):**

```markdown
## Emerging patterns (4)

### 1. Cut the feature, don't shrink the spec
**What it looks like:** When v1 scope creeps, the user removes whole features rather than reducing each one. Shows up across multiple projects.

**Where it shows up:**
- `projects/peptide-app.md` — "Removed the blood work section over HIPAA concerns."
- `projects/jarvis-trading.md` — "Killed the duplicate AI trading service to save RAM."
- `projects/jarvis-assistant.md` — "Don't be afraid to rip it out."

**Why this might deserve a name:** values.md says "Don't be afraid to rip it out" but doesn't connect it to v1 scope discipline. This is a more specific decision rule.

**Could go in:** `persona/decision-patterns.md` under a new "Scope" section.

---

### 2. ...
```

*Add the patterns you want to keep to persona/. Discard the rest.*
