# second-brain-template

> A personal knowledge vault, structured so AI assistants can read it, contribute to it, and make it more useful over time.

If you've tried to "organize your thoughts" in Obsidian or Notion and eventually given up because the structure was for you and you couldn't keep up with it — this template solves that problem by giving the structure a *second reader*: your AI.

## The thesis

Most second-brain content online is about notes for humans. Structure, tags, linking, backlinks. If you're doing it alone, you will never maintain it long enough for it to compound.

The real leverage is this: **every AI tool you use needs context to be useful**. Your personal assistant, your coding AI, your research agent — each is a blank slate every time you start a conversation. They ask you the same questions. They forget what you told them yesterday.

This vault is the answer to that problem. Not a note-taking system. A **long-lived context store** that every AI in your stack can read, contribute to, and query. The vault isn't the point — the machine-readable structure is the point. Your AI assistants become more useful the more they can read from and write to this layer.

## What you get

- **Semantic folder structure** — `daily/`, `weekly/`, `projects/`, `references/`, `inbox/`, `journal/`, `research-skill-graph/`. Every folder has a README explaining its role. Every file has YAML frontmatter with a `type:` field so AIs can filter.
- **6-lens research system** — a complete methodology (in `research-skill-graph/`) for deep research on a single question. Run `./new-project.sh <slug>` to scaffold a new research project, then point your AI agent at it to execute the 6 lenses and produce structured outputs.
- **`/braindump` workflow** — the core AI ritual. After a coding session or work block, type `/braindump` in your AI tool; it finds the right project file, adds a dated section in the file's existing style, and commits. Your project files self-maintain.
- **AI-agnostic integrations** — works with [Claude Code](integrations/claude-code/), [Cursor](integrations/cursor/), [Continue.dev](integrations/continue-dev/), [OpenCode](integrations/opencode/), or [any AI assistant](integrations/generic/). Pick yours during setup.
- **Daily narrative generator** — reference script that reads your day's git commits, calendar, and chat history, produces a dated journal entry via LLM. Dogfoodable — ships with the template.
- **One live example** — a complete 6-lens research project (`example-act-prep-market`) shows what populated output looks like.

## Quickstart

```bash
git clone git@github.com:<YOU>/second-brain-template.git
cd second-brain-template
./setup.sh ~/my-vault        # prompts for AI integration choice
cd ~/my-vault
```

That's it. You now have:

- A working vault with folder structure, templates, README files
- AI integration wired up (CLAUDE.md, .cursorrules, or equivalent based on your pick)
- A git repo with an initial commit — ready to push to your own private remote
- A scaffolding script to start research projects: `cd research-skill-graph && ./new-project.sh <slug>`

## Philosophy

### 1. The vault is your AI's long-term memory

Every AI conversation is stateless without context. The vault is the context. When your AI reads `projects/mobile-app.md` it doesn't need you to re-explain the project for the hundredth time. When it updates the file, next week's conversation starts where this one ended. The vault compounds.

### 2. Structure for machines, not for you

Human second-brain systems fail because maintaining them feels like work. This vault's structure is designed so AIs can navigate it without asking you. Semantic folders, typed frontmatter, consistent section headings. You stop thinking about where things go; your AI just knows.

### 3. Read-write, not read-only

Most PKM content treats AIs as search tools — "ask my notes anything." That's weak. The power is in the AIs *writing back*. The `/braindump` skill is the archetypal example: you dump unstructured session work, the AI structures it into your project file's existing style, you review and commit. Your vault maintains itself.

### 4. Portable and open

MIT licensed. Plain markdown. No proprietary format. Move to any editor, any AI, any host. The folder structure and the `/braindump` pattern are the IP — the rest is just files.

## Project structure

```
second-brain-template/
├── vault/                    # the template vault (what gets copied to your new vault)
│   ├── HOME.md
│   ├── _templates/           # Obsidian/Templater templates for daily, weekly, project, etc.
│   ├── daily/                # one file per day
│   ├── weekly/               # one file per week
│   ├── inbox/                # unstructured capture
│   ├── journal/              # narrative journal entries
│   ├── projects/             # one file per active project
│   ├── references/           # permanent reference material
│   └── research-skill-graph/ # 6-lens research system + scaffolding script + example
├── integrations/             # wire up your AI assistant
│   ├── claude-code/          # CLAUDE.md + /braindump skill
│   ├── cursor/               # .cursorrules
│   ├── continue-dev/         # Continue.dev config pattern
│   ├── opencode/             # OpenCode AGENTS.md pattern
│   └── generic/              # use with any AI (ChatGPT, Gemini, local Ollama)
├── scripts/
│   └── narrative_generator.py # daily journal auto-generator (reference impl)
├── docs/
│   ├── philosophy.md         # longer-form explanation of why this works
│   ├── getting-started.md    # walk-through for first-time users
│   ├── mcp-integration.md    # how to wire an MCP server for your vault
│   └── faq.md
├── setup.sh                  # scaffolds a new vault from the template
├── LICENSE                   # MIT
└── README.md                 # this file
```

## The `/braindump` ritual (why this works)

The one thing that made my vault sustainable: a slash-command ritual that maintains project files without conscious effort.

After a work session, I type `/braindump` followed by a 3-sentence summary of what happened. The AI:

1. Identifies which project file the work belongs to (from context or by asking)
2. Reads the existing file to learn its house style — section structure, tone, bullet/prose ratio
3. Adds a new `## <Title> (YYYY-MM-DD)` section before `## Lessons Learned`, matching the style
4. Suggests a git commit (never pushes without approval)

My project files self-maintain. They're never stale. Years of context accumulate at zero ongoing effort.

The skill is ~50 lines of prompt. It works because the vault's structure makes the AI's job obvious. Most of the value isn't in the skill — it's in the folder structure and frontmatter conventions that tell the AI where things go.

## Device sync

See [`docs/sync.md`](docs/sync.md). Short version: for Apple-heavy users, the recommended pattern is **iCloud + git hybrid** — Obsidian vault lives in the iCloud directory (free instant sync to iPhone/iPad), with git pointing at a private GitHub remote (durable backup + work-machine access). Other patterns (Obsidian Sync, Syncthing, git-only) are documented with tradeoffs.

## Mobile workflow

See [`docs/mobile.md`](docs/mobile.md). The short version: use Obsidian's **core Daily Notes plugin** for daily entries (one-tap creation on iPhone) and the **Periodic Notes** community plugin for weekly notes. Skip Templater for daily/weekly files — its mobile support is clunky and Daily Notes' native `{{date}}` tokens are enough.

Mobile is for capture. Desktop is for synthesis. Don't try to do the weekly review from your phone.

## Tagging

See [`docs/tagging.md`](docs/tagging.md). The template treats folders + frontmatter as primary, tags as cross-cutting. Short version: lowercase, singular, kebab-case, hierarchical with `/` when useful, 3-7 tags per file hard cap. Tags let your AI filter across folder boundaries in milliseconds; over-tagging defeats the whole point.

## The 6-lens research system

Inside `vault/research-skill-graph/` is a complete methodology for deep research:

- **Technical** — what do the numbers say?
- **Economic** — follow the money
- **Historical** — what patterns repeat?
- **Geopolitical** — which power dynamics shape this?
- **Contrarian** — what if the consensus is wrong?
- **First-principles** — rebuild from fundamental truths

Point any AI agent at the `index.md` of a new project, instruct it to execute all 6 lenses and produce the 4 output files, and you get deeper research than any single ChatGPT conversation can produce.

See `vault/research-skill-graph/projects/example-act-prep-market/` for a completed example — research question, scope, full 6-lens deep dive, key players, open questions, and executive summary.

Scaffolding a new project:

```bash
cd vault/research-skill-graph
./new-project.sh my-new-question
# prompts for question, scope, time horizon, output goal
# creates a populated project folder with stubs for outputs
```

## Customization

Everything is markdown. Edit anything. A few common customizations:

- **Add new folders** — create a new `projects/work-only/` or `people/` — just drop a README in the folder explaining what goes there. Your AI will read the README.
- **Change templates** — edit files in `_templates/` to match your preferred heading structure
- **Add your own skills** — in `integrations/claude-code/skills/` add `my-skill.md`. Each skill is just a markdown file with YAML frontmatter.
- **Wire in your data sources** — edit `scripts/narrative_generator.py` to pull from whatever APIs matter to you (Linear, Notion, Google Calendar, etc.)

## License

MIT. Use it, fork it, sell it, rebrand it. Attribution appreciated but not required.

## Credits

Built by Brady Landry, with extensive use of Claude Code as a thinking partner. The architectural insights came from dogfooding — this vault template is the distilled version of my own working vault after ~6 months of iteration.

If you're using this and improving it, I'd love to see the fork. Drop a PR or a link.
