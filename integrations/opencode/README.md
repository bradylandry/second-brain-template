# OpenCode integration

[OpenCode](https://opencode.ai) is an open-source, terminal-based coding agent — think Claude Code but vendor-neutral (supports Anthropic, OpenAI, xAI, local models via Ollama, NVIDIA NIM, etc.).

## Setup

OpenCode reads `AGENTS.md` from your project root (similar to Claude Code's `CLAUDE.md`).

```bash
# Copy the Claude Code example and rename — the structure is nearly identical
cp integrations/claude-code/CLAUDE.md.example vault/AGENTS.md
```

Edit `AGENTS.md` if needed — the content works for OpenCode with minimal changes.

## Skills / custom commands

OpenCode supports custom commands in its config. Check OpenCode's docs for the current syntax — the `braindump` pattern translates directly:

- Goal: parse a session dump, find the right project file, add a dated section, commit
- The `skills/braindump.md` spec in the Claude Code integration is agent-agnostic — adapt the invocation syntax for OpenCode

## Why consider OpenCode

- Works with any model provider (including NVIDIA NIM's free tier)
- Terminal-first — fits well with existing shell workflows
- No vendor lock-in

OpenCode evolves rapidly. If this README is out of date by the time you read it, the project's own docs are authoritative.
