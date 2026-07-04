# ECC Agent System — VS Code Copilot Edition

> **Production-ready AI Agent Orchestration for VS Code Copilot**
>
> 基于 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) 改造的 VS Code Copilot Agent 编排系统

[English](#english) | [中文](#中文) | [日本語](#日本語) | [한국어](#한국어)

---

## 中文

### 简介

本项目是 ECC（Everything Claude Code）的 VS Code Copilot 适配版本。经过**十余轮架构审计**和修复，将原本的描述性 Agent 系统改造为**可执行的自动化 Agent 编排系统**。

**架构评分**: 15% → 95%（十余轮累计 +80%）

### 系统组成

| 层级 | 组件 | 数量 |
|------|------|------|
| 编排层 | Conductor 总指挥 | 1 |
| Agent 层 | 9 层分类专项 Agent | 70 |
| Rule 层 | 编码规范规则 | 114+ |
| Skill 层 | 领域知识 Skill | 150+ |
| Hook 层 | 质量门禁 Hook | 6 |
| Command 层 | 用户入口命令 | 94 |
| Git Hooks | lefthook 配置 | 6 |

### Agent 分层架构

```
                        ┌─────────────────┐
                        │   Conductor     │  ← 总指挥（中央调度器）
                        │   (1 Agent)     │
                        └────────┬────────┘
                                 │
        ┌────────┬────────┬──────┴──────┬────────┬────────┬────────┐
        ▼        ▼        ▼            ▼        ▼        ▼        ▼
   ┌────────┐┌────────┐┌────────┐┌────────┐┌────────┐┌────────┐┌────────┐
   │ 审查层 ││ 构建   ││ 质量层 ││ 架构层 ││ 测试层 ││ 安全层 ││ GAN层  │
   │22 Agent││ 修复层 ││ 5 Agent││ 6 Agent││ 3 Agent││ 2 Agent││ 3 Agent│
   │        ││10 Agent││        ││        ││        ││        ││        │
   └────────┘└────────┘└────────┘└────────┘└────────┘└────────┘└────────┘
                                                      ┌────────┐
                                                      │ 运维层 │
                                                      │ 9 Agent│
                                                      └────────┘
```

| 层级 | 职责 | 数量 | 包含 |
|------|------|------|------|
| 编排层 | 中央任务调度 | 1 | `conductor` |
| 审查层 | 代码审查 | 22 | `code-reviewer`、`typescript-reviewer`、`python-reviewer`、`react-reviewer` 等 |
| 构建修复层 | 构建错误修复 | 10 | `build-error-resolver`、`go-build-resolver`、`cpp-build-resolver` 等 |
| 质量层 | 代码质量检查 | 5 | `code-simplifier`、`silent-failure-hunter`、`comment-analyzer` 等 |
| 架构层 | 架构设计分析 | 6 | `architect`、`code-architect`、`network-architect`、`a11y-architect` 等 |
| 测试层 | 测试策略与执行 | 3 | `tdd-guide`、`e2e-runner`、`pr-test-analyzer` |
| 安全层 | 安全评估 | 2 | `security-reviewer`、`RedTeam-Expert` |
| GAN 层 | GAN 工作流 | 3 | `gan-planner`、`gan-generator`、`gan-evaluator` |
| 运维层 | 专项运维 | 9 | `doc-updater`、`performance-optimizer`、`seo-specialist` 等 |

### 核心特性

- ✅ **可执行调度** — Conductor 使用 `runSubagent` 实际调度 70 个子 Agent
- ✅ **可执行 Hook** — 6 个质量门禁使用 `grep_search`/`read_file`/`run_in_terminal` 实际执行
- ✅ **规则注入** — 根据语言/框架自动注入 114+ 编码规则（覆盖 22 种语言）
- ✅ **Skill 注入** — 根据任务类型自动加载 150+ 领域知识
- ✅ **幻觉防范** — 可执行的事实验证流程，防止 AI 编造不存在的文件/函数
- ✅ **重试机制** — 3 次重试 + fallback 降级链
- ✅ **GAN 工作流** — gan-planner → gan-generator → gan-evaluator 状态传递
- ✅ **双层 Hook** — VS Code Copilot 层（编辑时）+ Git Hooks 层（提交时）
- ✅ **跨平台** — macOS / Linux / Windows 全平台支持

### 快速开始

```bash
# 1. 克隆仓库
git clone https://github.com/ZzXy47/ecc-agent-system.git

# 2. 复制到用户目录
cp -r ecc-agent-system/* ~/.copilot/
cp -r ecc-agent-system/rules ~/.claude/rules/ecc

# 3. 安装 lefthook（Git Hooks）
npm install -g lefthook
cd your-project && lefthook install

# 4. 在 VS Code 中使用 Copilot 即可生效
```

### 目录结构

```
~/.copilot/
├── agents/          # 70 个 Agent 定义（.agent.md）
├── hooks/           # 6 个可执行质量门禁 Hook
├── skills/          # 150+ Skill 定义
├── prompts/         # 94 个用户命令入口（.prompt）
├── lefthook.yml     # Git Hooks 配置（pre-commit/commit-msg/pre-push）
└── state/           # 运行时状态（自动创建）

~/.claude/rules/ecc/ # 114+ 编码规范规则
├── angular/         # Angular 规则
├── arkts/           # HarmonyOS ArkTS 规则
├── common/          # 通用规则（agents/code-review/coding-style 等）
├── cpp/             # C++ 规则
├── csharp/          # C# / .NET 规则
├── dart/            # Dart / Flutter 规则
├── golang/          # Go 规则
├── java/            # Java / Spring Boot 规则
├── kotlin/          # Kotlin / Android 规则
├── python/          # Python / Django / FastAPI 规则
├── react/           # React / JSX 规则
├── typescript/      # TypeScript / JavaScript 规则
├── vue/             # Vue.js 规则
└── ...（22 种语言/框架）
```

### 致谢

本项目基于 **ECC（Everything Claude Code）** 改造，原作者为 **@affaan-m**。

- 原始仓库: [https://github.com/affaan-m/ECC](https://github.com/affaan-m/ECC)
- 本项目在 ECC 基础上进行了 VS Code Copilot 适配、十余轮架构审计、可执行化改造

感谢 ECC 项目提供的优秀 Agent 架构设计。

---

## English

### Introduction

This is a VS Code Copilot adaptation of ECC (Everything Claude Code). After **10+ rounds of architecture audit** and repair, the original descriptive agent system has been transformed into an **executable automated agent orchestration system**.

**Architecture Score**: 15% → 95% (+80% over 10+ rounds)

### System Components

| Layer | Component | Count |
|-------|-----------|-------|
| Orchestration | Conductor (Central Dispatcher) | 1 |
| Agent Layer | 9-layer Specialized Agents | 70 |
| Rule Layer | Coding Standard Rules | 114+ |
| Skill Layer | Domain Knowledge Skills | 150+ |
| Hook Layer | Quality Gate Hooks | 6 |
| Command Layer | User Entry Commands | 94 |
| Git Hooks | lefthook Configuration | 6 |

### Agent Layer Architecture

| Layer | Responsibility | Count | Includes |
|-------|---------------|-------|----------|
| Orchestration | Central task dispatch | 1 | `conductor` |
| Review | Code review | 22 | `code-reviewer`, `typescript-reviewer`, `python-reviewer`, `react-reviewer`, etc. |
| Build Resolution | Fix build errors | 10 | `build-error-resolver`, `go-build-resolver`, `cpp-build-resolver`, etc. |
| Quality | Code quality checks | 5 | `code-simplifier`, `silent-failure-hunter`, `comment-analyzer`, etc. |
| Architecture | System design | 6 | `architect`, `code-architect`, `network-architect`, `a11y-architect`, etc. |
| Testing | Test strategy | 3 | `tdd-guide`, `e2e-runner`, `pr-test-analyzer` |
| Security | Security assessment | 2 | `security-reviewer`, `RedTeam-Expert` |
| GAN | GAN workflow | 3 | `gan-planner`, `gan-generator`, `gan-evaluator` |
| Operations | Specialized ops | 9 | `doc-updater`, `performance-optimizer`, `seo-specialist`, etc. |

### Core Features

- ✅ **Executable Dispatch** — Conductor uses `runSubagent` to actually dispatch 70 sub-agents
- ✅ **Executable Hooks** — 6 quality gates use `grep_search`/`read_file`/`run_in_terminal` for actual execution
- ✅ **Rule Injection** — Auto-injects 114+ coding rules based on language/framework (22 languages covered)
- ✅ **Skill Injection** — Auto-loads 150+ domain knowledge skills based on task type
- ✅ **Hallucination Prevention** — Executable fact-verification workflow prevents AI from fabricating files/functions
- ✅ **Retry Mechanism** — 3 retries + fallback degradation chain
- ✅ **GAN Workflow** — gan-planner → gan-generator → gan-evaluator state passing
- ✅ **Dual-layer Hooks** — VS Code Copilot layer (edit-time) + Git Hooks layer (commit-time)
- ✅ **Cross-platform** — macOS / Linux / Windows support

### Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/ZzXy47/ecc-agent-system.git

# 2. Copy to user directory
cp -r ecc-agent-system/* ~/.copilot/
cp -r ecc-agent-system/rules ~/.claude/rules/ecc

# 3. Install lefthook (Git Hooks)
npm install -g lefthook
cd your-project && lefthook install

# 4. Use Copilot in VS Code — it just works!
```

### Directory Structure

```
~/.copilot/
├── agents/          # 70 Agent definitions (.agent.md)
├── hooks/           # 6 executable quality gate hooks
├── skills/          # 150+ skill definitions
├── prompts/         # 94 user command entries (.prompt)
├── lefthook.yml     # Git Hooks config (pre-commit/commit-msg/pre-push)
└── state/           # Runtime state (auto-created)

~/.claude/rules/ecc/ # 114+ coding standard rules
├── angular/         # Angular rules
├── arkts/           # HarmonyOS ArkTS rules
├── common/          # Common rules (agents/code-review/coding-style etc.)
├── cpp/             # C++ rules
├── csharp/          # C# / .NET rules
├── dart/            # Dart / Flutter rules
├── golang/          # Go rules
├── java/            # Java / Spring Boot rules
├── kotlin/          # Kotlin / Android rules
├── python/          # Python / Django / FastAPI rules
├── react/           # React / JSX rules
├── typescript/      # TypeScript / JavaScript rules
├── vue/             # Vue.js rules
└── ... (22 languages/frameworks)
```

### Credits

This project is based on **ECC (Everything Claude Code)** by **@affaan-m**.

- Original repository: [https://github.com/affaan-m/ECC](https://github.com/affaan-m/ECC)
- This project adapts ECC for VS Code Copilot with 10+ rounds of architecture audit and executable transformation

Thanks to the ECC project for the excellent agent architecture design.

---

## 日本語

### 概要

これは ECC（Everything Claude Code）の VS Code Copilot 適用版です。**10回以上のアーキテクチャ監査**と修復を経て、元の記述的なエージェントシステムは**実行可能な自動エージェントオーケストレーションシステム**に変換されました。

**アーキテクチャスコア**: 15% → 95%（10回以上のラウンドで +80%）

### システム構成

| レイヤー | コンポーネント | 数 |
|---------|---------------|-----|
| オーケストレーション | Conductor（中央ディスパッチャー） | 1 |
| エージェント層 | 9層分類専門エージェント | 70 |
| ルール層 | コーディング標準ルール | 114+ |
| スキル層 | ドメイン知識スキル | 150+ |
| フック層 | 品質ゲートフック | 6 |
| コマンド層 | ユーザーエントリコマンド | 94 |
| Git Hooks | lefthook 設定 | 6 |

### エージェント層アーキテクチャ

| レイヤー | 職責 | 数 | 含むエージェント |
|---------|------|-----|-----------------|
| オーケストレーション | 中央タスクディスパッチ | 1 | `conductor` |
| レビュー層 | コードレビュー | 22 | `code-reviewer`、`typescript-reviewer`、`python-reviewer`、`react-reviewer` 等 |
| ビルド修復層 | ビルドエラー修正 | 10 | `build-error-resolver`、`go-build-resolver`、`cpp-build-resolver` 等 |
| 品質層 | コード品質チェック | 5 | `code-simplifier`、`silent-failure-hunter`、`comment-analyzer` 等 |
| アーキテクチャ層 | システム設計 | 6 | `architect`、`code-architect`、`network-architect`、`a11y-architect` 等 |
| テスト層 | テスト戦略 | 3 | `tdd-guide`、`e2e-runner`、`pr-test-analyzer` |
| セキュリティ層 | セキュリティ評価 | 2 | `security-reviewer`、`RedTeam-Expert` |
| GAN層 | GANワークフロー | 3 | `gan-planner`、`gan-generator`、`gan-evaluator` |
| 運用層 | 専門運用 | 9 | `doc-updater`、`performance-optimizer`、`seo-specialist` 等 |

### コア機能

- ✅ **実行可能ディスパッチ** — Conductor は `runSubagent` を使用して70個のサブエージェントを実際にディスパッチ
- ✅ **実行可能フック** — 6個の品質ゲートが `grep_search`/`read_file`/`run_in_terminal` で実際に実行
- ✅ **ルール注入** — 言語/フレームワークに基づいて114+のコーディングルールを自動注入（22言語対応）
- ✅ **スキル注入** — タスクタイプに基づいて150+のドメイン知識スキルを自動ロード
- ✅ **ハルシネーション防止** — AIが存在しないファイル/関数を捏造するのを防ぐ実行可能な事実検証フロー
- ✅ **リトライ機構** — 3回リトライ + フォールバック降格チェーン
- ✅ **GANワークフロー** — gan-planner → gan-generator → gan-evaluator の状態受け渡し
- ✅ **デュアルレイヤーフック** — VS Code Copilot層（編集時）+ Git Hooks層（コミット時）
- ✅ **クロスプラットフォーム** — macOS / Linux / Windows 全プラットフォーム対応

### クイックスタート

```bash
# 1. リポジトリをクローン
git clone https://github.com/ZzXy47/ecc-agent-system.git

# 2. ユーザーディレクトリにコピー
cp -r ecc-agent-system/* ~/.copilot/
cp -r ecc-agent-system/rules ~/.claude/rules/ecc

# 3. lefthook をインストール（Git Hooks）
npm install -g lefthook
cd your-project && lefthook install

# 4. VS Code で Copilot を使用すると自動的に有効化
```

### ディレクトリ構成

```
~/.copilot/
├── agents/          # 70個のエージェント定義（.agent.md）
├── hooks/           # 6個の実行可能品質ゲートフック
├── skills/          # 150+スキル定義
├── prompts/         # 94個のユーザーコマンドエントリ（.prompt）
├── lefthook.yml     # Git Hooks設定（pre-commit/commit-msg/pre-push）
└── state/           # 実行時状態（自動作成）

~/.claude/rules/ecc/ # 114+のコーディング標準ルール
├── angular/         # Angularルール
├── arkts/           # HarmonyOS ArkTSルール
├── common/          #共通ルール（agents/code-review/coding-style等）
├── cpp/             # C++ルール
├── csharp/          # C#/.NETルール
├── dart/            # Dart/Flutterルール
├── golang/          # Goルール
├── java/            # Java/Spring Bootルール
├── kotlin/          # Kotlin/Androidルール
├── python/          # Python/Django/FastAPIルール
├── react/           # React/JSXルール
├── typescript/      # TypeScript/JavaScriptルール
├── vue/             # Vue.jsルール
└── ...（22言語/フレームワーク）
```

### クレジット

本プロジェクトは **@affaan-m** による **ECC（Everything Claude Code）** をベースとしています。

- 原始リポジトリ: [https://github.com/affaan-m/ECC](https://github.com/affaan-m/ECC)
- 本プロジェクトは ECC を VS Code Copilot に適用し、10回以上のアーキテクチャ監査と実行可能化改造を行いました

ECCプロジェクトの優れたエージェントアーキテクチャ設計に感謝いたします。

---

## 한국어

### 개요

이 프로젝트는 ECC(Everything Claude Code)의 VS Code Copilot 적용 버전입니다. **10회 이상의 아키텍처 감사**와 수정을 통해 원래의 기술적 에이전트 시스템이 **실행 가능한 자동 에이전트 오케스트레이션 시스템**으로 변환되었습니다.

**아키텍처 점수**: 15% → 95% (10회 이상의 라운드에 걸쳐 +80%)

### 시스템 구성

| 레이어 | 컴포넌트 | 수 |
|--------|----------|-----|
| 오케스트레이션 | Conductor (중앙 디스패처) | 1 |
| 에이전트 레이어 | 9계층 분류 전문 에이전트 | 70 |
| 규칙 레이어 | 코딩 표준 규칙 | 114+ |
| 스킬 레이어 | 도메인 지식 스킬 | 150+ |
| 훅 레이어 | 품질 게이트 훅 | 6 |
| 커맨드 레이어 | 사용자 진입 커맨드 | 94 |
| Git Hooks | lefthook 설정 | 6 |

### 에이전트 계층 아키텍처

| 계층 | 역할 | 수 | 포함 에이전트 |
|------|------|-----|--------------|
| 오케스트레이션 | 중앙 태스크 디스패치 | 1 | `conductor` |
| 리뷰 레이어 | 코드 리뷰 | 22 | `code-reviewer`、`typescript-reviewer`、`python-reviewer`、`react-reviewer` 등 |
| 빌드 수정 레이어 | 빌드 오류 수정 | 10 | `build-error-resolver`、`go-build-resolver`、`cpp-build-resolver` 등 |
| 품질 레이어 | 코드 품질 검사 | 5 | `code-simplifier`、`silent-failure-hunter`、`comment-analyzer` 등 |
| 아키텍처 레이어 | 시스템 설계 | 6 | `architect`、`code-architect`、`network-architect`、`a11y-architect` 등 |
| 테스트 레이어 | 테스트 전략 | 3 | `tdd-guide`、`e2e-runner`、`pr-test-analyzer` |
| 보안 레이어 | 보안 평가 | 2 | `security-reviewer`、`RedTeam-Expert` |
| GAN 레이어 | GAN 워크플로우 | 3 | `gan-planner`、`gan-generator`、`gan-evaluator` |
| 운영 레이어 | 전문 운영 | 9 | `doc-updater`、`performance-optimizer`、`seo-specialist` 등 |

### 핵심 기능

- ✅ **실행 가능한 디스패치** — Conductor는 `runSubagent`를 사용하여 70개의 서브 에이전트를 실제로 디스패치
- ✅ **실행 가능한 훅** — 6개의 품질 게이트가 `grep_search`/`read_file`/`run_in_terminal`로 실제로 실행
- ✅ **규칙 주입** — 언어/프레임워크에 따라 114+ 코딩 규칙을 자동 주입 (22개 언어 지원)
- ✅ **스킬 주입** — 태스크 유형에 따라 150+ 도메인 지식 스킬을 자동 로드
- ✅ **할루시네이션 방지** — AI가 존재하지 않는 파일/함수를 조작하는 것을 방지하는 실행 가능한 사실 검증 워크플로우
- ✅ **재시도 메커니즘** — 3회 재시도 + 폴백 폴백 체인
- ✅ **GAN 워크플로우** — gan-planner → gan-generator → gan-evaluator 상태 전달
- ✅ **이중 계층 훅** — VS Code Copilot 레이어 (편집 시) + Git Hooks 레이어 (커밋 시)
- ✅ **크로스 플랫폼** — macOS / Linux / Windows 전 플랫폼 지원

### 빠른 시작

```bash
# 1. 저장소 클론
git clone https://github.com/ZzXy47/ecc-agent-system.git

# 2. 사용자 디렉토리에 복사
cp -r ecc-agent-system/* ~/.copilot/
cp -r ecc-agent-system/rules ~/.claude/rules/ecc

# 3. lefthook 설치 (Git Hooks)
npm install -g lefthook
cd your-project && lefthook install

# 4. VS Code에서 Copilot을 사용하면 자동으로 활성화
```

### 디렉토리 구조

```
~/.copilot/
├── agents/          # 70개 에이전트 정의 (.agent.md)
├── hooks/           # 6개 실행 가능 품질 게이트 훅
├── skills/          # 150+ 스킬 정의
├── prompts/         # 94개 사용자 커맨드 엔트리 (.prompt)
├── lefthook.yml     # Git Hooks 설정 (pre-commit/commit-msg/pre-push)
└── state/           # 런타임 상태 (자동 생성)

~/.claude/rules/ecc/ # 114+ 코딩 표준 규칙
├── angular/         # Angular 규칙
├── arkts/           # HarmonyOS ArkTS 규칙
├── common/          # 공통 규칙 (agents/code-review/coding-style 등)
├── cpp/             # C++ 규칙
├── csharp/          # C# / .NET 규칙
├── dart/            # Dart / Flutter 규칙
├── golang/          # Go 규칙
├── java/            # Java / Spring Boot 규칙
├── kotlin/          # Kotlin / Android 규칙
├── python/          # Python / Django / FastAPI 규칙
├── react/           # React / JSX 규칙
├── typescript/      # TypeScript / JavaScript 규칙
├── vue/             # Vue.js 규칙
└── ... (22개 언어/프레임워크)
```

### 크레딧

이 프로젝트는 **@affaan-m** 의 **ECC(Everything Claude Code)**를 기반으로 합니다.

- 원본 저장소: [https://github.com/affaan-m/ECC](https://github.com/affaan-m/ECC)
- 이 프로젝트는 ECC를 VS Code Copilot에 적용하고 10회 이상의 아키텍처 감사와 실행 가능한 변환을 수행했습니다

ECC 프로젝트의 우수한 에이전트 아키텍처 설계에 감사드립니다.

---

## License

MIT License — See [LICENSE](LICENSE) for details.

Based on [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) by @affaan-m.
