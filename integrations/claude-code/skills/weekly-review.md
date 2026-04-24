---
name: weekly-review
description: Draft this week's weekly review by reading the last 7 daily notes and any project file sections added this week. User reviews and commits.
---

# /weekly-review — Draft a weekly summary from the week's activity

You are drafting the user's weekly review. The vault is the current working directory.

## Instructions

### 1. Determine which week

Default: the week that just ended (Monday-Sunday or Sunday-Saturday — ask the user's preference if unclear, then remember it).

If the user specified a date ("last week", "week of April 14"), convert to ISO week.

Filename: `weekly/YYYY-WNN.md` (e.g. `weekly/2026-W17.md`). ISO week numbering.

### 2. Gather the week's activity

Read these, in this order:

1. **Daily notes from the week:** `daily/YYYY-MM-DD.md` for each of the 7 days. Expect some to be missing — that's fine.
2. **Project file updates from the week:** for each file in `projects/`, find any dated sections with dates in the target week. These are the AI-added sections from `/braindump` usage.
3. **Inbox items added this week:** anything in `inbox/` with a modification date in the week, for context on things that came up but weren't yet processed.
4. **Git log (optional):** if the vault is a git repo, `git log --since="<Mon>" --until="<Sun>" --oneline` tells you what was explicitly committed.

### 3. Draft the weekly note

Use `_templates/weekly.md` as structural starting point. Produce a draft covering:

- **Highlights** — 3-5 things that mattered this week, each with a one-sentence "why it mattered"
- **Decisions** — any decisions made this week, each with a one-line reason
- **Blockers / Setbacks** — what didn't work, with honest attribution
- **Next week's priorities** — inferred from what's left open, validated with the user
- **Reflection** — what surprised you, what you'd repeat, what you'd change

Tone: first-person, reflective, concise. Not a bullet-dump of every daily note. **Synthesis is the value.**

### 4. Save and show

1. Write the draft to `weekly/YYYY-WNN.md`
2. Show it to the user
3. Ask: "Anything to edit before I commit?"
4. After user approval (or user-edited version): suggest the commit

## Rules

- **Synthesis over compilation** — a weekly review that just copies daily notes is useless. The AI's job is to identify patterns across days that the user didn't see while living them.
- **Honest not cheerleading** — if the user didn't accomplish their intentions, say so. Don't pad losses. Growth needs truth.
- **Questions, not conclusions, when uncertain** — if the data is ambiguous, ask the user rather than guess.
- **Length cap** — 400-600 words total. A weekly review is not a dissertation.
- **Don't invent** — only reference things actually in the week's data. If a daily note says "TODO: call X" and there's no later note about the call happening, the review shouldn't claim the call happened.

## Example output structure

```markdown
---
type: weekly
week: 2026-W17
dates: 2026-04-20 to 2026-04-26
---

# Week of April 20-26, 2026

## Highlights

- **Shipped the mobile app share feature.** Biggest user-facing change in 3 months; gym-bro referral loop validated at small N.
- **Triage framework v1 deployed.** Mac mini + GCP VM both monitoring known failure modes. End-to-end loop working.
- **Career positioning research completed.** Thesis: MCP scaffolding is highest-leverage asset IF externalized in 90 days.

## Decisions

- Swapped jarvis-trading from Groq → NVIDIA NIM. Reason: Groq model deprecations were killing AI-trader cycles.
- Paused Apple App Store submission for peptide-app. Reason: gray-area category review risk; web-first acquisition working.

## Blockers

- Cox IP boundary on MCP scaffolding still unclear. Blocks public OSS framework until legal review.

## Next week

- Interview the peptide-app recurring user (Monday).
- First public LinkedIn post draft (this Tuesday — the MCP/agents post).
- Begin tracemalloc profiling on jarvis-trading (non-urgent).

## Reflection

Surprised how much the triage framework changed daily anxiety. Knowing failures will auto-remediate removed a background load I didn't realize I was carrying. Pattern to notice: the highest-leverage work this week was infrastructure that makes future weeks easier, not feature work. Worth remembering when allocating next week's hours.
```
