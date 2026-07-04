# ECC Agent System — Usage Guide

[中文](GUIDE-zh.md) | English

---

## 1. System Overview

ECC Agent System is an AI programming agent orchestration system for VS Code Copilot. It consists of 70 specialized agents, 106+ coding rules, 150+ domain skills, and 6 quality hooks, orchestrated by the Conductor (central dispatcher).

```
User Request
  ↓
Conductor (Central Dispatcher)
  ├→ Task Decomposition
  ├→ Agent Selection (from 70 agents)
  ├→ Rule Injection (106+ rules auto-matched)
  ├→ Skill Injection (150+ skills loaded on demand)
  ├→ Execution (runSubagent dispatch)
  ├→ Quality Gates (6 hooks)
  └→ Delivery
```

## 2. Using Conductor

### 2.1 Triggering Conductor

In VS Code Copilot Chat:

```
Use conductor to complete this task: [your task description]
```

### 2.2 What Conductor Does Automatically

1. **Task Analysis** — Parses task type, language, framework
2. **Task Decomposition** — Breaks down into executable subtasks
3. **Agent Selection** — Selects best-matching agents from 70 available
4. **Rule Injection** — Auto-loads coding standards for detected languages
5. **Skill Injection** — Loads domain knowledge on demand
6. **Parallel Execution** — Launches multiple agents simultaneously for independent subtasks
7. **Quality Check** — Passes through 6 hook gates before delivery
8. **Delivery** — Completes task and reports results

### 2.3 Direct Agent Usage

You can also invoke specific agents directly:

| Scenario | Agent Name | Usage |
|----------|-----------|-------|
| Code Review | `code-reviewer` | "Use code-reviewer to review this code" |
| Security Check | `security-reviewer` | "Use security-reviewer to check security" |
| Performance | `performance-optimizer` | "Use performance-optimizer to optimize" |
| Bug Finding | `silent-failure-hunter` | "Use silent-failure-hunter to find silent failures" |
| TDD | `tdd-guide` | "Use tdd-guide to develop with TDD" |

## 3. Hook System

### 3.1 Hook Overview

| Hook | Trigger | Purpose |
|------|---------|---------|
| `gateguard` | Before edit/write/bash | Force fact-gathering |
| `safety-guard` | Dangerous command detected | Block destructive operations |
| `delivery-gate` | Before task delivery | 7-item quality gate |
| `pre-commit` | Before git commit | Code quality check |
| `commit-msg` | After commit message | Format validation |
| `pre-push` | Before git push | Pre-push verification |

### 3.2 Hook Execution Layers

Hooks operate at two complementary layers:

1. **VS Code Copilot Layer** (`.copilot/hooks/*.md`) — Uses `grep_search`/`read_file`/`run_in_terminal`
2. **Git Hooks Layer** (`lefthook.yml`) — Actual shell command execution

### 3.3 Temporarily Skipping Hooks

```bash
# Skip pre-commit
git commit --no-verify -m "fix: emergency fix"

# Skip all hooks
HUSKY=0 git commit -m "..."
```

## 4. Coding Rules System

### 4.1 Rules Location

```
~/.claude/rules/ecc/
├── angular/coding-style.md
├── csharp/coding-style.md
├── golang/coding-style.md
├── python/coding-style.md
├── react/coding-style.md
├── typescript/coding-style.md
└── ... (22+ language directories)
```

### 4.2 Automatic Rule Loading

Conductor automatically injects rules based on detected languages/frameworks in the task.

## 5. Adding New Agents

Create `~/.copilot/agents/your-agent.agent.md`:

```markdown
---
name: your-agent
description: One-line description of agent function and when to use it
---

# Your Agent

## Role Definition
You are...

## Capabilities
- ...

## Execution Flow
1. ...
2. ...

## Output Format
- ...
```

### Best Practices

- **Single Responsibility** — One agent does one thing
- **Clear Trigger Conditions** — Describe when to use in description
- **Executable Instructions** — Use concrete tool calls, not just descriptions
- **Output Format** — Define clear output format for Conductor to parse

## 6. GAN Workflow

### 6.1 Overview

GAN workflow expands a one-line requirement into a complete product:

```
gan-planner (Plan) → gan-generator (Implement) → gan-evaluator (Evaluate)
     ↑                                                |
     └──────────── Iterative Feedback ←────────────────┘
```

### 6.2 Usage

```
Use conductor's GAN workflow to implement: user login feature
```

## 7. Migration Guide

### 7.1 Moving to Another Computer

```bash
# On source computer
cd ~
tar czf ecc-agent-system.tar.gz .copilot/ .claude/rules/ecc/

# Transfer to target computer
scp ecc-agent-system.tar.gz user@new-machine:~/

# On target computer
cd ~
tar xzf ecc-agent-system.tar.gz

# Install lefthook
npm install -g lefthook

# Restart VS Code to take effect
```

### 7.2 Notes

- `.copilot/state/` contains runtime state — not recommended to migrate
- `.copilot/.backup/` contains pre-repair backups — optional to migrate
- lefthook needs to be installed separately on new computer

## 8. Troubleshooting

### 8.1 Agent Not Responding

1. Confirm file is in `~/.copilot/agents/` directory
2. Confirm file extension is `.agent.md`
3. Confirm YAML frontmatter format is correct
4. Restart VS Code

### 8.2 Hook Not Executing

1. Confirm file is in `~/.copilot/hooks/` directory
2. Check lefthook installation: `lefthook version`
3. Check git hooks configuration: `ls .git/hooks/`

### 8.3 Conductor Dispatch Failure

1. Confirm `conductor.agent.md` exists and is complete
2. Check target agent file exists
3. Check VS Code Output panel for error messages

## 9. Architecture Audit Reports

This project underwent 10+ rounds of architecture audit. Key rounds:

| Round | File | Score |
|-------|------|-------|
| Deep Audit | `deep-architecture-audit-2026-07-04.md` | 92% |
| Round 3 | `third-round-audit-2026-07-04.md` | 95% |

Audit coverage: Hook executability, rule injection chain, skill injection chain, hallucination prevention, retry mechanism, tool availability, pipeline gates, GAN workflow.
