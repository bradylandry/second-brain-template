---
type: research-command-center
---

# Research Skill Graph — Command Center

## 1. Mission

Deep research system that takes ONE question and produces a multi-angle analysis no single Google search or ChatGPT prompt could ever match.

Instead of 50 open tabs and scattered notes, this system forces structured thinking through 6 research lenses, each one rethinking the question from a fundamentally different angle.

**Current Research Question:** [PASTE YOUR QUESTION HERE]
**Scope:** [DEFINE BOUNDARIES — what's in, what's out]
**Time Horizon:** [how far back and forward are we looking?]
**Output Goal:** [what decision does this research inform?]

## Prior Research
Check [[research-log]] for previous research that may connect to this question.
Relevant prior projects: [link any related projects, or leave empty for clean slate]

---

## 2. Node Map

### Methodology
- [[methodology/research-frameworks]] — how to approach different types of questions. start here to pick the right structure
- [[methodology/source-evaluation]] — tier system for judging source credibility
- [[methodology/synthesis-rules]] — how to combine findings across lenses without losing nuance
- [[methodology/contradiction-protocol]] — what to do when sources disagree. this is where real insights hide

### Lenses (the core engine)
- [[lenses/technical]] — what do the numbers actually say? strip away narrative, look at data only
- [[lenses/economic]] — follow the money. who pays, who profits, what incentives drive behavior
- [[lenses/historical]] — what patterns repeat? what's been tried before? what context does everyone forget?
- [[lenses/geopolitical]] — which countries, which power dynamics, which forces shape this?
- [[lenses/contrarian]] — what if the consensus is wrong? who benefits from the current narrative?
- [[lenses/first-principles]] — forget everything. rebuild from fundamental truths only

### Outputs (generated per project)
- `executive-summary.md` — 500 words max. what did we learn, what does it mean, what's still unknown
- `deep-dive.md` — full analysis by lens with cross-references and contradictions highlighted
- `key-players.md` — people, organizations, products that matter most
- `open-questions.md` — what we still don't know. often more valuable than what we found

### Knowledge Base (accumulates across all projects)
- [[knowledge/concepts]] — key terms, definitions, mental models
- [[knowledge/data-points]] — hard numbers and statistics with source attribution

### Sources
- [[sources/source-template]] — template for processing raw sources

---

## 3. Execution Instructions

When given a research question:

1. Read this file completely — understand scope and goal
2. Read [[methodology/research-frameworks]] to pick the right approach
3. Read [[methodology/source-evaluation]] so you know what counts as good evidence
4. For EACH lens in order (technical → economic → historical → geopolitical → contrarian → first-principles):
   a. Read the lens file for its specific angle and questions
   b. Research the topic THROUGH that lens only
   c. Record findings, sources, and confidence level
   d. Note any contradictions with previous lenses
5. Read [[methodology/contradiction-protocol]] — resolve or document disagreements
6. Read [[methodology/synthesis-rules]] — combine everything
7. Produce all 4 output files in the project subfolder
8. Update [[knowledge/concepts]] and [[knowledge/data-points]] with everything learned

**CRITICAL RULE:** Each lens must RETHINK the question, not just add more information. The technical lens and contrarian lens should feel like they were written by two different researchers who disagree. That tension is where insight lives.

---

## 4. Active Projects

- [[projects/example-act-prep-market/index]] — Example: ACT prep market research (reference project showing a completed run)

## 5. Research Log
[[research-log]]

---

## How to start a new project

```bash
./new-project.sh my-new-research-slug
```

The script prompts for the research question, scope, time horizon, and output goal, then scaffolds a complete project folder with populated index.md and empty output stubs.
