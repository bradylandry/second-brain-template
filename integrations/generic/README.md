# Generic integration — any AI assistant

No Claude Code, no Cursor, no IDE plugin? You can still use this vault with any AI — ChatGPT, Claude.ai, Gemini, a local Ollama model, anything.

## The pattern

The key insight: **your vault is a directory of markdown files with predictable structure**. Any AI that can read markdown and understand folder conventions can participate. The integration details (CLAUDE.md, .cursorrules) are just vendor-specific ways to ship the same house rules.

## How to use this vault with a generic AI

### Option 1 — Copy-paste sessions

When you want the AI to update your vault:

1. Open `vault/HOME.md` and paste it at the top of your chat (gives the AI the overall structure)
2. Paste the relevant project file
3. Describe what you want
4. The AI returns edited markdown — paste back into the file

Works but tedious. Fine for occasional use.

### Option 2 — CLI bridge with any chat model

Most chat APIs have an SDK. Write a simple script:

```python
# braindump.py
import sys
from pathlib import Path
import anthropic  # or openai, google.generativeai, ollama, etc.

VAULT = Path.home() / "vault"
SESSION_DUMP = sys.stdin.read()

prompt = f"""You are updating a personal second-brain vault.

Structure: {list(VAULT.glob('projects/*.md'))}

Session dump to log:
{SESSION_DUMP}

Identify which project file this belongs to. Read it (I'll paste it below).
Add a dated section BEFORE ## Lessons Learned in the file's existing style.
Output ONLY the updated file contents (so I can redirect to disk)."""

client = anthropic.Anthropic()
result = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=8000,
    messages=[{"role": "user", "content": prompt}],
)
print(result.content[0].text)
```

Run: `cat session.txt | python braindump.py > projects/my-project.md`

Crude, but you can evolve it. This is what `/braindump` in Claude Code does under the hood — just with better UX.

### Option 3 — Use an MCP server

The [Model Context Protocol](https://modelcontextprotocol.io) lets you expose your vault as tools any MCP-compatible AI (Claude Desktop, many others) can call. See `../../docs/mcp-integration.md` for how to wire this up.

An MCP server for the vault would expose tools like:
- `read_project(name)` — read a project file
- `add_dated_section(project_name, title, content)` — the braindump pattern
- `search_vault(query)` — grep across files
- `list_recent_daily_notes(n)` — pull recent context

This is heavier setup but produces the tightest integration with any AI.

## The core principle

Whatever tool you use, three rules make this vault AI-friendly:

1. **Semantic folder structure** — folder name = what lives there
2. **YAML frontmatter on every file** — AI can filter by `type:`
3. **README in each folder** — AI can read the README to understand conventions

Your integration is just a translation of those conventions into whatever configuration format your AI tool expects.
