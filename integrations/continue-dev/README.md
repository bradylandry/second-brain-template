# Continue.dev integration

[Continue](https://continue.dev) is an open-source IDE extension (VSCode + JetBrains) that lets you bring your own model — Claude, GPT, local models via Ollama, anything OpenAI-compatible.

## Setup

Continue reads configuration from `~/.continue/config.yaml` (global) or `.continue/config.yaml` (workspace).

Create a workspace config at `vault/.continue/config.yaml`:

```yaml
name: second-brain-vault
version: 0.1.0
schema: v1

models:
  - name: claude-sonnet
    provider: anthropic
    model: claude-sonnet-4-5
  - name: local-qwen
    provider: ollama
    model: qwen2.5-coder:32b

customCommands:
  - name: braindump
    prompt: |
      You are updating my personal knowledge vault.
      
      Read the vault structure (look for projects/, daily/, research-skill-graph/).
      Identify which project file my session belongs to.
      Read that file to learn its house style.
      Add a new `## <Title> (YYYY-MM-DD)` section BEFORE `## Lessons Learned`
      with terse bullet points.
      Suggest a commit with a one-line message — don't push.
      
      My session summary:
    description: Log work to the right project file in my second brain

systemMessage: |
  This is a personal second-brain vault. Every file has YAML frontmatter.
  Match existing section structure. Convert relative dates to YYYY-MM-DD.
  Never push to git without explicit approval.
```

## Why Continue is worth considering

- **Local model option:** run against Ollama for full privacy / zero API cost
- **BYO key:** use your own Anthropic, OpenAI, or other provider keys
- **Open source:** no vendor lock-in

Trade-off: less polished than Cursor or Claude Code; configuration more manual.
