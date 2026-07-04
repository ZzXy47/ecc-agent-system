# ECC for VS Code Copilot

This is a **production-ready AI coding configuration** providing 70 specialized agents, 
277+ skills, 93+ commands, and automated workflows for software development.

**Version:** 2.0.0 (VS Code Adapted)

## Core Principles

1. **Delegate early, delegate often** — use the right agent for the right task
2. **Review before commit** — always run code-reviewer and security-reviewer
3. **Test first** — use tdd-guide for new features
4. **Document as you go** — use doc-updater proactively

## Available Agents

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| **planner** | Expert planning specialist for complex features and refactoring. Use... | When applicable |
| **tdd-guide** | Test-Driven Development specialist enforcing write-tests-first methodology. Use... | When applicable |
| **e2e-runner** | End-to-end testing specialist using Vercel Agent Browser (preferred) with... | When applicable |
| **go-reviewer** | Expert Go code reviewer specializing in idiomatic Go, concurrency patterns,... | When applicable |
| **cpp-reviewer** | Expert C++ code reviewer specializing in memory safety, modern C++ idioms,... | When applicable |
| **code-simplifier** | Simplifies and refines code for clarity, consistency, and maintainability while... | When applicable |
| **loop-operator** | Operate autonomous agent loops, monitor progress, and intervene safely when... | When applicable |
| **agent-evaluator** | Evaluates agent output against 5-axis quality rubric (accuracy, completeness,... | When applicable |
| **swift-reviewer** | Expert Swift code reviewer specializing in protocol-oriented design, value... | When applicable |
| **php-reviewer** | Expert PHP code reviewer specializing in PSR-12 compliance, PHP type system,... | When applicable |
| **fastapi-reviewer** | Reviews FastAPI applications for async correctness, dependency injection,... | When applicable |
| **go-build-resolver** | Go build, vet, and compilation error resolution specialist. Fixes build errors,... | When applicable |
| **django-build-resolver** | Django/Python build, migration, and dependency error resolution specialist.... | When applicable |
| **conversation-analyzer** | Use this agent when analyzing conversation transcripts to find behaviors worth... | When applicable |
| **doc-updater** | Documentation and codemap specialist. Use PROACTIVELY for updating codemaps and... | When applicable |
| **django-reviewer** | Expert Django code reviewer specializing in ORM correctness, DRF patterns,... | When applicable |
| **fsharp-reviewer** | Expert F# code reviewer specializing in functional idioms, type safety, pattern... | When applicable |
| **java-reviewer** | Expert Java code reviewer for Spring Boot and Quarkus projects. Automatically... | When applicable |
| **comment-analyzer** | Analyze code comments for accuracy, completeness, maintainability, and comment... | When applicable |
| **flutter-reviewer** | Flutter and Dart code reviewer. Reviews Flutter code for widget best practices,... | When applicable |
| **cpp-build-resolver** | C++ build, CMake, and compilation error resolution specialist. Fixes build... | When applicable |
| **network-config-reviewer** | Reviews router and switch configurations for security, correctness, stale... | When applicable |
| **vue-reviewer** | Expert Vue.js code reviewer specializing in Composition API correctness,... | When applicable |
| **code-architect** | Designs feature architectures by analyzing existing codebase patterns and... | When applicable |
| **opensource-forker** | Fork any project for open-sourcing. Copies files, strips secrets and... | When applicable |
| **swift-build-resolver** | Swift/Xcode build, compilation, and dependency error resolution specialist.... | When applicable |
| **rust-reviewer** | Expert Rust code reviewer specializing in ownership, lifetimes, error handling,... | When applicable |
| **csharp-reviewer** | Expert C# code reviewer specializing in .NET conventions, async patterns,... | When applicable |
| **refactor-cleaner** | Dead code cleanup and consolidation specialist. Use PROACTIVELY for removing... | When applicable |
| **security-reviewer** | Security vulnerability detection and remediation specialist. Use PROACTIVELY... | When applicable |
| **network-architect** | Designs enterprise or multi-site network architecture from requirements, using... | When applicable |
| **database-reviewer** | PostgreSQL database specialist for query optimization, schema design, security,... | When applicable |
| **healthcare-reviewer** | Reviews healthcare application code for clinical safety, CDSS accuracy, PHI... | When applicable |
| **typescript-reviewer** | Expert TypeScript/JavaScript code reviewer specializing in type safety, async... | When applicable |
| **java-build-resolver** | Java/Maven/Gradle build, compilation, and dependency error resolution... | When applicable |
| **type-design-analyzer** | Analyze type design for encapsulation, invariant expression, usefulness, and... | When applicable |
| **opensource-sanitizer** | Verify an open-source fork is fully sanitized before release. Scans for leaked... | When applicable |
| **react-build-resolver** | Diagnose and fix React build failures across Vite, webpack, Next.js, CRA,... | When applicable |
| **harmonyos-app-resolver** | HarmonyOS application development expert specializing in ArkTS and ArkUI.... | When applicable |
| **network-troubleshooter** | Diagnoses network connectivity, routing, DNS, interface, and policy symptoms... | When applicable |
| **architect** | Software architecture specialist for system design, scalability, and technical... | When applicable |
| **code-explorer** | Deeply analyzes existing codebase features by tracing execution paths, mapping... | When applicable |
| **react-reviewer** | Expert React/JSX code reviewer specializing in hook correctness, render... | When applicable |
| **chief-of-staff** | Personal communication chief of staff that triages email, Slack, LINE, and... | When applicable |
| **homelab-architect** | Designs home and small-lab network plans from hardware inventory, goals, and... | When applicable |
| **dart-build-resolver** | Dart/Flutter build, analysis, and dependency error resolution specialist. Fixes... | When applicable |
| **silent-failure-hunter** | Review code for silent failures, swallowed errors, bad fallbacks, and missing... | When applicable |
| **kotlin-build-resolver** | Kotlin/Gradle build, compilation, and dependency error resolution specialist.... | When applicable |
| **pytorch-build-resolver** | PyTorch runtime, CUDA, and training error resolution specialist. Fixes tensor... | When applicable |
| **rust-build-resolver** | Rust build, compilation, and dependency error resolution specialist. Fixes... | When applicable |
| **seo-specialist** | SEO specialist for technical SEO audits, on-page optimization, structured data,... | When applicable |
| **spec-miner** | Extracts behavioral specs from existing codebases for OpenSpec. Produces flat... | When applicable |
| **gan-planner** | "GAN Harness — Planner agent. Expands a one-line prompt into a full product... | When applicable |
| **docs-lookup** | When the user asks how to use a library, framework, or API or needs up-to-date... | When applicable |
| **mle-reviewer** | Production machine-learning engineering reviewer for data contracts, feature... | When applicable |
| **gan-evaluator** | "GAN Harness — Evaluator agent. Tests the live running application via... | When applicable |
| **code-reviewer** | Expert code review specialist. Proactively reviews code for quality, security,... | When applicable |
| **gan-generator** | "GAN Harness — Generator agent. Implements features according to the spec,... | When applicable |
| **a11y-architect** | Accessibility Architect specializing in WCAG 2.2 compliance for Web and Native... | When applicable |
| **kotlin-reviewer** | Kotlin and Android/KMP code reviewer. Reviews Kotlin code for idiomatic... | When applicable |
| **python-reviewer** | Expert Python code reviewer specializing in PEP 8 compliance, Pythonic idioms,... | When applicable |
| **marketing-agent** | Marketing strategist and copywriter for campaign planning, audience research,... | When applicable |
| **harness-optimizer** | Analyze and improve the local agent harness configuration for reliability,... | When applicable |
| **opensource-packager** | Generate complete open-source packaging for a sanitized project. Produces... | When applicable |
| **build-error-resolver** | Build and TypeScript error resolution specialist. Use PROACTIVELY when build... | When applicable |
| **performance-optimizer** | Performance analysis and optimization specialist. Use PROACTIVELY for... | When applicable |
| **pr-manager** | Pull Request creation and management. Security checks, template discovery, change analysis, CI verification. Use when creating or managing PRs. | When applicable |
| **pr-test-analyzer** | Review pull request test coverage quality and completeness, with emphasis on... | When applicable |
| **RedTeam-Expert** | Security assessment, vulnerability discovery, attack chain analysis, defense bypass detection, APT simulation. Use for penetration testing, CVE analysis, CTF, exploit development. | When applicable |
| **conductor** | Central task dispatcher — receives high-level goals, auto-decomposes, dispatches, tracks, and closes the loop. Use for complex multi-step development tasks. | When applicable |

## Agent Orchestration

For simple tasks, invoke agents directly by name. For complex multi-step goals 
requiring autonomous task distribution, delegation, and closed-loop execution, 
start with **conductor** as the central dispatcher.

Use parallel execution for independent operations — launch multiple agents simultaneously.

## Hooks System

ECC includes an automated hooks system for quality gates:

| Hook | Trigger | Purpose |
|------|---------|---------|
| `gateguard` | Edit/Write/Bash | Fact-gathering before any code change |
| `safety-guard` | Dangerous commands | Block destructive operations |
| `delivery-gate` | Task completion | Quality gate before delivery |
| `pre-commit` | git commit | Code quality checks |
| `commit-msg` | Commit message | Conventional Commits format |
| `pre-push` | git push | Pre-push verification |

Hooks are defined in `.copilot/hooks/` and automatically executed by Conductor.

## Using Commands

Commands are available as prompts — use `/prompt-name` to invoke them.

## Security Guidelines

- Never commit secrets, API keys, or credentials
- Run security-reviewer before merging sensitive code
- Validate all user inputs and sanitize outputs

## Model Selection

- **Claude Opus 4.5** — Complex planning, architecture, security audits
- **Claude Sonnet 4.5** — Code review, testing, general development (default)
- **Claude Haiku 4.5** — Documentation, simple refactoring, quick fixes

> **当前运行模型**: mimo-v2.5-pro (Xiaomi MiMo)。Agent 的 `model` 字段配置为 Claude 系列，但实际执行由当前激活的模型驱动。
