# Claude Projects integration (claude.ai web)

[Claude Projects](https://www.anthropic.com/news/projects) is the project-workspace feature on **claude.ai** — separate from Claude Code (CLI/IDE). Each Project has:

- **Project knowledge** — files you upload that persist across conversations in that Project
- **Custom instructions** — behavior rules scoped to the Project
- **Conversation history** — long-lived threads in that Project

The question: how do you keep your Claude Project knowledge in sync with your vault, and how does work in a Claude Project feed *back* into the vault?

## The two-way sync pattern

**Vault → Project knowledge (inbound):** upload key vault files to your Claude Project's knowledge section so Claude has context when you chat. Candidates:

- `persona/self.md` and `persona/career.md`
- Current active project files (`projects/my-thing.md`)
- Relevant `references/*.md`
- Methodology files from `research-skill-graph/` if the Project is research-focused

Re-upload after significant vault changes. (Yes, this is manual — Claude Projects doesn't yet have live file sync. The template includes a helper script below.)

**Project conversation → Vault (outbound):** when a Claude Project chat produces valuable output, use the `/braindump` pattern to feed it back. In the claude.ai chat:

```
Please write this up as a dated section for my projects/mobile-app.md,
matching my vault house style (YYYY-MM-DD heading, bullets with **bold**
key terms, before any ## Lessons Learned section). Output the markdown
I should paste into the file.
```

Claude produces the structured markdown, you paste it into the right file in your vault, commit. Not as seamless as Claude Code's `/braindump` but works for any Claude Project.

## Custom instructions for your Project

In Claude Projects → Project settings → Custom instructions, paste this:

```
This project's knowledge section contains files from my personal second-brain
vault. Files under persona/ describe me (role, expertise, values, preferences).
Files under projects/ are living project docs. references/ contains permanent
reference material.

When I ask for work:
- Ground your response in my actual context (persona files) not generic advice
- When producing outputs meant for the vault (project updates, research, notes),
  format them as ready-to-paste markdown matching my vault's house style:
  - YAML frontmatter with a type: field
  - Section headers (## ...) not big wall-of-text
  - Dated sections for ongoing project updates use: ## <Title> (YYYY-MM-DD)
  - Bullets with **bold** key terms; concrete over abstract
- Never include "here's the markdown" preambles around outputs — just emit it

If I ask something where persona/ doesn't give you the answer, ask me; don't guess.
```

## Helper script (optional)

There's no public API to upload files to a Claude Project programmatically as of now. But Anthropic's MCP protocol is evolving fast. For now, two workflows exist:

**Workflow A — manual periodic refresh (what most people do):**
1. Weekly on Friday: zip relevant vault subfolders, drag into Project knowledge
2. Overwrite old versions

**Workflow B — vault-aware MCP server (advanced):**
Run a local MCP server that exposes vault reads/writes. Point Claude Desktop at it. When you chat, Claude can read current vault state without re-uploading. See `../../docs/mcp-integration.md` for the pattern.

The MCP approach is heavier setup but produces a real bidirectional sync. Manual upload is fine for the first few months.

## What to include in your Claude Project knowledge

Minimum viable:
- `persona/self.md`
- `persona/career.md`
- `persona/values.md`
- `persona/collaboration.md`
- 1-3 active project files from `projects/`

Optional:
- `research-skill-graph/methodology/` (if the Project does research)
- `research-skill-graph/lenses/` (same reason)
- `references/` files relevant to the Project's domain

**Don't include the whole vault.** Claude's context window is finite; 10-15 high-signal files beat 100 low-signal ones.

## Claude Code vs Claude Projects — which to use

- **Claude Code** (CLI/IDE): best for edit-in-place work on the vault itself. Use for `/braindump`, scaffolding, refactoring.
- **Claude Projects** (claude.ai): best for long-lived thinking conversations about a domain (your career, a specific project, research). Produces markdown you paste back into the vault.

Use both. The vault is the shared substrate.
