# ECC Agent System — Usage Guide

[中文](GUIDE-zh.md) | English

---

## 1. System Overview

ECC Agent System is an AI programming agent orchestration system for VS Code Copilot. It consists of **70 specialized agents** (organized in 9 architectural layers), **114+ coding rules** (covering 22 languages), **150+ domain skills**, and **6 quality hooks**, orchestrated by the **Conductor (central dispatcher)**.

### Architecture Overview

```
User Request
  ↓
Conductor (Central Dispatcher)
  ├→ Task Analysis → Language/Framework Detection
  ├→ Task Decomposition → Subtask List
  ├→ Agent Selection (from 70 agents, 9-layer architecture)
  │   ├→ Review Layer (22 Agents)
  │   ├→ Build Resolution Layer (10 Agents)
  │   ├→ Quality Layer (5 Agents)
  │   ├→ Architecture Layer (6 Agents)
  │   ├→ Testing Layer (3 Agents)
  │   ├→ Security Layer (2 Agents)
  │   ├→ GAN Layer (3 Agents)
  │   └→ Operations Layer (9 Agents)
  ├→ Rule Injection (114+ rules, auto-matched by language)
  ├→ Skill Injection (150+ skills, loaded by task type)
  ├→ Execution (agent dispatch)
  ├→ Quality Gates (6 hooks)
  │   ├→ gateguard — Fact-gathering before edit/write
  │   ├→ safety-guard — Destructive command interception
  │   ├→ delivery-gate — 7-item delivery quality gate
  │   ├→ pre-commit — Code quality check
  │   ├→ commit-msg — Commit message format validation
  │   └→ pre-push — Pre-push verification
  └→ Delivery
```

## 2. Agent Layer Architecture

### 9-Layer Overview

70 agents are organized into 9 layers by responsibility. The Conductor automatically selects the right agent combination based on task type:

| Layer | Responsibility | Count | Representative Agents |
|-------|---------------|-------|----------------------|
| Orchestration | Central task dispatch | 1 | `conductor` |
| Review | Code review (by language/framework) | 22 | `code-reviewer`, `typescript-reviewer`, `python-reviewer`, `react-reviewer`, `vue-reviewer`, `go-reviewer`, `rust-reviewer`, `java-reviewer`, `cpp-reviewer`, `flutter-reviewer`, `database-reviewer`, `fastapi-reviewer`, `django-reviewer`, `mle-reviewer`, `healthcare-reviewer` |
| Build Resolution | Compilation/build error fix | 10 | `build-error-resolver`, `go-build-resolver`, `cpp-build-resolver`, `rust-build-resolver`, `java-build-resolver`, `kotlin-build-resolver`, `swift-build-resolver`, `dart-build-resolver`, `react-build-resolver`, `django-build-resolver`, `pytorch-build-resolver`, `harmonyos-app-resolver` |
| Quality | Code quality check & optimization | 5 | `code-simplifier`, `silent-failure-hunter`, `comment-analyzer`, `refactor-cleaner`, `type-design-analyzer` |
| Architecture | System architecture design & analysis | 6 | `architect`, `code-architect`, `code-explorer`, `network-architect`, `a11y-architect`, `homelab-architect` |
| Testing | Test strategy & execution | 3 | `tdd-guide`, `e2e-runner`, `pr-test-analyzer` |
| Security | Security assessment & vulnerability detection | 2 | `security-reviewer`, `RedTeam-Expert` |
| GAN | GAN workflow (requirement → product) | 3 | `gan-planner`, `gan-generator`, `gan-evaluator` |
| Operations | Specialized operations | 9 | `doc-updater`, `performance-optimizer`, `seo-specialist`, `marketing-agent`, `pr-manager`, `loop-operator`, `harness-optimizer`, `conversation-analyzer`, `spec-miner` |

### Review Layer Detail (22 Review Agents)

The review layer is specialized by language/framework:

**Language Review**: `typescript-reviewer`, `python-reviewer`, `go-reviewer`, `rust-reviewer`, `java-reviewer`, `kotlin-reviewer`, `cpp-reviewer`, `csharp-reviewer`, `swift-reviewer`, `php-reviewer`, `fsharp-reviewer`

**Framework Review**: `react-reviewer`, `vue-reviewer`, `flutter-reviewer`, `django-reviewer`, `fastapi-reviewer`

**General Review**: `code-reviewer` (general), `database-reviewer` (database), `mle-reviewer` (machine learning), `healthcare-reviewer` (healthcare)

### Build Resolution Layer Detail (10 Build Agents)

Each build agent specializes in specific language/framework compilation errors:

`build-error-resolver` (TS/JS general), `go-build-resolver`, `cpp-build-resolver`, `rust-build-resolver`, `java-build-resolver`, `kotlin-build-resolver`, `swift-build-resolver`, `dart-build-resolver`, `react-build-resolver`, `django-build-resolver`, `pytorch-build-resolver`, `harmonyos-app-resolver`

---

## 3. Using Conductor

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

## 4. Hook System

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

## 5. Coding Rules System

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

## 6. Adding New Agents

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

## 7. GAN Workflow

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

## 8. Migration Guide

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

## 9. Troubleshooting

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

## 10. Architecture Audit Reports

This project underwent 10+ rounds of architecture audit. Key rounds:

| Round | File | Score |
|-------|------|-------|
| Deep Audit | `deep-architecture-audit-2026-07-04.md` | 92% |
| Round 3 | `third-round-audit-2026-07-04.md` | 95% |

Audit coverage: Hook executability, rule injection chain, skill injection chain, hallucination prevention, retry mechanism, tool availability, pipeline gates, GAN workflow.
