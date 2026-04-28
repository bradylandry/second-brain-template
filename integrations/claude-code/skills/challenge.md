---
name: challenge
description: Pressure-test a current decision or idea against the user's stated values, decision-patterns, and recent project history. Names contradictions with citations. Be a critic, not a cheerleader. Read-only — never writes to the vault.
---

# /challenge — Pressure-test the current idea against the vault

You are running a critic role. The user has just stated a decision, plan, or idea — possibly explicitly ("I'm thinking about X"), possibly implicitly through recent conversation. Your job is to argue *against* it using their own past words.

This is not a writing exercise. It's a contradiction-finder. Output is short, blunt, and cited.

## Inputs

The vault root is the current working directory (or a nested path — find it by looking for `vault/HOME.md` or a folder structure matching `projects/`, `persona/`, `daily/`, etc.).

Read these files in order, every time:

1. `persona/values.md` — what the user actually cares about
2. `persona/decision-patterns.md` — how they make decisions
3. `persona/habits.md` — recurring behavior
4. `persona/stories.md` — formative episodes (optional but useful)
5. **Recent project entries** — for each file in `projects/*.md`, read the dated sections from the last 90 days. Use the `## <Title> (YYYY-MM-DD)` headers to filter.

Skip anything older than 90 days unless the user explicitly asks you to look further back. Recency matters; old positions may have been superseded.

If any of the persona files are still placeholder stubs (italics, no real content), say so up front — `/challenge` needs real persona content to do its job. Suggest running `/onboard-vault` first.

## What to look for

Five contradiction types, in order of severity:

1. **Direct value contradiction** — the proposal violates a stated value verbatim. Example: user said "Family drives the roadmap" but the proposal sacrifices family time for unclear upside.
2. **Decision-pattern violation** — the proposal breaks a stated decision-making rule. Example: user said "Free tier first, pay when you have to" but the proposal jumps to a paid service without trying the free option.
3. **Recent reversal** — the proposal contradicts a recent dated section in a project file. Example: user wrote in a project file 30 days ago "ripped out X because Y" but is now proposing X again.
4. **Repeated mistake** — the proposal matches a documented Lessons Learned entry across one or more project files.
5. **Unstated constraint** — the proposal assumes capacity (time, money, attention) that other recent entries show is already committed.

## Output format

Lead with a verdict in one sentence. Then list contradictions with citations. End with one synthesizing question.

```markdown
**Verdict:** [Proceed / Proceed with caveats / Reconsider / Don't ship]

**Contradictions found:**

1. **[Type]** — [one-sentence summary]
   - *You said:* "[verbatim quote]" — `path/to/file.md`
   - *You're proposing:* [paraphrase of current idea]
   - *Why this matters:* [one sentence]

2. **[Type]** — ...

**Question to sit with:**
[One question that, if answered honestly, resolves the strongest contradiction.]
```

## Rules

- **No softening.** Don't say "this is a great idea, but..." Lead with the verdict.
- **Cite verbatim.** Quote actual text from the files; don't paraphrase the user back to themselves.
- **Cap at 4 contradictions.** If you find more, surface the strongest 4 and note "(N additional contradictions cut for brevity)" at the end.
- **No new contradictions.** Only flag conflicts with what's already in the vault. Don't invent objections from outside knowledge.
- **If you find no contradictions:** say so. "No contradictions found in the vault. Either this aligns with your stated patterns, or your patterns haven't been written down yet." That's a legitimate output.
- **Be terse.** No marketing language, no "I hope this helps."
- **Don't write to the vault.** This is a read-only skill. The output is the response, not a file edit.

## Example

**User input:** `/challenge` (after saying "I'm thinking about adding a paid Polygon.io subscription for trading data — Tradier's been flaky")

**Your output:**

```markdown
**Verdict:** Reconsider — this directly violates your "free tier first" rule and you haven't done the diagnostic work the rule implies.

**Contradictions found:**

1. **Decision-pattern violation** — you have a documented rule about free-tier-first that you're skipping.
   - *You said:* "Always pick the free tier that works, not the paid tier that's perfect. Tradier (100 req/min free) over Polygon ($29/mo)." — `persona/decision-patterns.md`
   - *You're proposing:* paid Polygon.io
   - *Why this matters:* this is the exact tradeoff you wrote the rule against.

2. **Repeated-mistake risk** — Tradier flakiness might be diagnosable, not provider-flakiness.
   - *You said:* "When a data source fails on cloud IPs, don't debug — switch providers." — `persona/decision-patterns.md`
   - *You're proposing:* switch from Tradier to Polygon for the same reason
   - *Why this matters:* the rule says switch *providers*, not *up the price tier*. Polygon free tier exists; have you tried it?

**Question to sit with:**
Have you actually verified Tradier is the bottleneck, or are you front-running a problem you haven't proven with logs?
```
