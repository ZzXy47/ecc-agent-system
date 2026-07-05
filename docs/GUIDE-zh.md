# ECC Agent System 使用指南

[English](GUIDE-en.md) | 中文

---

## 一、系统概述

ECC Agent System 是一个基于 VS Code Copilot 的 AI 编程 Agent 编排系统。它由 **70 个专项 Agent**（分 9 层架构）、**114+ 编码规则**（覆盖 22 种语言）、**150+ 领域 Skill**、**6 个质量 Hook** 组成，通过 **Conductor（总指挥）** 统一调度。

### 架构总览

```
用户请求
  ↓
Conductor（总指挥）
  ├→ 任务分析 → 语言/框架检测
  ├→ 任务拆解 → 子任务列表
  ├→ Agent 选择（从 70 个中匹配，9 层架构）
  │   ├→ 审查层（22 Agent）
  │   ├→ 构建修复层（10 Agent）
  │   ├→ 质量层（5 Agent）
  │   ├→ 架构层（6 Agent）
  │   ├→ 测试层（3 Agent）
  │   ├→ 安全层（2 Agent）
  │   ├→ GAN 层（3 Agent）
  │   └→ 运维层（9 Agent）
  ├→ Rule 注入（114+ 规则，按语言自动匹配）
  ├→ Skill 注入（150+ Skill，按任务类型加载）
  ├→ 执行（agent 调度）
  ├→ 质量门禁（6 个 Hook）
  │   ├→ gateguard — 编辑/写入前事实收集
  │   ├→ safety-guard — 危险命令拦截
  │   ├→ delivery-gate — 7 项交付质量门禁
  │   ├→ pre-commit — 代码质量检查
  │   ├→ commit-msg — 提交信息格式验证
  │   └→ pre-push — 推送前验证
  └→ 交付
```

## 二、Agent 分层架构

### 9 层分类总览

70 个 Agent 按职责分为 9 层，Conductor 根据任务类型自动选择合适的 Agent 组合：

| 层级 | 职责 | 数量 | 代表 Agent |
|------|------|------|-----------|
| 编排层 | 中央任务调度 | 1 | `conductor` |
| 审查层 | 代码审查（按语言/框架细分） | 22 | `code-reviewer`、`typescript-reviewer`、`python-reviewer`、`react-reviewer`、`vue-reviewer`、`go-reviewer`、`rust-reviewer`、`java-reviewer`、`cpp-reviewer`、`flutter-reviewer`、`database-reviewer`、`fastapi-reviewer`、`django-reviewer`、`mle-reviewer`、`healthcare-reviewer` |
| 构建修复层 | 编译/构建错误修复 | 10 | `build-error-resolver`、`go-build-resolver`、`cpp-build-resolver`、`rust-build-resolver`、`java-build-resolver`、`kotlin-build-resolver`、`swift-build-resolver`、`dart-build-resolver`、`react-build-resolver`、`django-build-resolver`、`pytorch-build-resolver`、`harmonyos-app-resolver` |
| 质量层 | 代码质量检查与优化 | 5 | `code-simplifier`、`silent-failure-hunter`、`comment-analyzer`、`refactor-cleaner`、`type-design-analyzer` |
| 架构层 | 系统架构设计与分析 | 6 | `architect`、`code-architect`、`code-explorer`、`network-architect`、`a11y-architect`、`homelab-architect` |
| 测试层 | 测试策略与执行 | 3 | `tdd-guide`、`e2e-runner`、`pr-test-analyzer` |
| 安全层 | 安全评估与漏洞检测 | 2 | `security-reviewer`、`RedTeam-Expert` |
| GAN 层 | GAN 工作流（需求→产品） | 3 | `gan-planner`、`gan-generator`、`gan-evaluator` |
| 运维层 | 专项运维 | 9 | `doc-updater`、`performance-optimizer`、`seo-specialist`、`marketing-agent`、`pr-manager`、`loop-operator`、`harness-optimizer`、`conversation-analyzer`、`spec-miner` |

### 审查层细分（22 个审查 Agent）

审查层按语言/框架细分，确保每个领域都有专业审查者：

**语言审查**：`typescript-reviewer`、`python-reviewer`、`go-reviewer`、`rust-reviewer`、`java-reviewer`、`kotlin-reviewer`、`cpp-reviewer`、`csharp-reviewer`、`swift-reviewer`、`php-reviewer`、`fsharp-reviewer`

**框架审查**：`react-reviewer`、`vue-reviewer`、`flutter-reviewer`、`django-reviewer`、`fastapi-reviewer`

**通用审查**：`code-reviewer`（通用）、`database-reviewer`（数据库）、`mle-reviewer`（机器学习）、`healthcare-reviewer`（医疗）

### 构建修复层细分（10 个构建 Agent）

每个构建修复 Agent 专注于特定语言/框架的编译错误：

`build-error-resolver`（TS/JS 通用）、`go-build-resolver`、`cpp-build-resolver`、`rust-build-resolver`、`java-build-resolver`、`kotlin-build-resolver`、`swift-build-resolver`、`dart-build-resolver`、`react-build-resolver`、`django-build-resolver`、`pytorch-build-resolver`、`harmonyos-app-resolver`

---

## 三、Conductor 使用

### 2.1 触发 Conductor

在 VS Code Copilot Chat 中输入：

```
请使用 conductor 来完成这个任务：[你的任务描述]
```

或简写：

```
/conductor 帮我重构 UserService
```

### 2.2 Conductor 自动做什么

1. **任务分析** — 解析任务类型、语言、框架
2. **任务拆解** — 分解为可执行的子任务
3. **Agent 选择** — 从 70 个 Agent 中选择最匹配的
4. **规则注入** — 自动加载对应语言的编码规范
5. **Skill 注入** — 按需加载领域知识
6. **并行执行** — 独立子任务同时启动多个 Agent
7. **质量检查** — 交付前通过 6 个 Hook 门禁
8. **交付** — 完成任务并报告结果

### 2.3 直接使用 Agent

也可以不通过 Conductor，直接调用特定 Agent：

| 场景 | Agent 名称 | 使用方式 |
|------|-----------|---------|
| 代码审查 | `code-reviewer` | "请用 code-reviewer 审查这些代码" |
| 安全检查 | `security-reviewer` | "请用 security-reviewer 检查安全" |
| 性能优化 | `performance-optimizer` | "请用 performance-optimizer 优化性能" |
| Bug 修复 | `silent-failure-hunter` | "请用 silent-failure-hunter 找出静默失败" |
| 测试编写 | `tdd-guide` | "请用 tdd-guide 用 TDD 方式开发" |

## 四、Hook 系统

### 3.1 Hook 说明

| Hook | 触发时机 | 功能 |
|------|---------|------|
| `gateguard` | 编辑/写入/执行命令前 | 强制事实收集 |
| `safety-guard` | 检测到危险命令时 | 拦截破坏性操作 |
| `delivery-gate` | 任务交付前 | 7 项质量门禁 |
| `pre-commit` | git commit 前 | 代码质量检查 |
| `commit-msg` | 提交信息生成后 | 格式验证 |
| `pre-push` | git push 前 | 推送前验证 |

### 3.2 Hook 执行方式

Hook 有两种执行层：

1. **VS Code Copilot 层**（`.copilot/hooks/*.md`）— 使用 `grep_search`/`read_file`/`run_in_terminal` 工具
2. **Git Hooks 层**（`lefthook.yml`）— 实际 Shell 命令执行

两者互补，VS Code 层在编辑时检查，Git 层在提交时检查。

### 3.3 临时跳过 Hook

```bash
# 跳过 pre-commit
git commit --no-verify -m "fix: 紧急修复"

# 跳过所有 hooks
HUSKY=0 git commit -m "..."
```

## 五、编码规则系统

### 4.1 规则位置

```
~/.claude/rules/ecc/
├── angular/coding-style.md
├── csharp/coding-style.md
├── golang/coding-style.md
├── java/coding-style.md
├── kotlin/coding-style.md
├── python/coding-style.md
├── react/coding-style.md
├── typescript/coding-style.md
└── ...（22+ 语言目录）
```

### 4.2 规则自动加载

Conductor 会根据任务涉及的语言/框架自动注入对应规则：

- TypeScript 项目 → `typescript/coding-style.md` + `typescript/hooks.md` + ...
- Python 项目 → `python/coding-style.md` + `python/patterns.md` + ...
- React 项目 → `react/coding-style.md` + `react/hooks.md` + ...

### 4.3 自定义规则

在 `~/.claude/rules/` 下创建新目录和文件即可添加自定义规则。

## 六、添加新 Agent

### 5.1 Agent 文件格式

创建 `~/.copilot/agents/your-agent.agent.md`：

```markdown
---
name: your-agent
description: 一句话描述 Agent 的功能和使用场景
---

# Your Agent

## 角色定义
你是...

## 能力范围
- ...

## 执行流程
1. ...
2. ...

## 输出格式
- ...
```

### 5.2 Agent 最佳实践

- **单一职责** — 一个 Agent 只做一件事
- **明确触发条件** — description 中说明何时使用
- **可执行指令** — 使用具体工具调用，不要只写描述
- **输出格式** — 明确输出格式，便于 Conductor 解析

## 七、GAN 工作流

### 6.1 概述

GAN 工作流用于从一行需求展开为完整产品：

```
gan-planner（规划）→ gan-generator（实现）→ gan-evaluator（评估）
     ↑                                              |
     └──────────── 迭代反馈 ←────────────────────────┘
```

### 6.2 使用方式

```
请用 conductor 的 GAN 工作流实现：用户登录功能
```

### 6.3 状态文件

```
~/.copilot/state/conductor/
├── gan-spec.md          # gan-planner 输出的产品规格
├── gan-feedback.md      # gan-evaluator 的反馈
└── gan-features/        # gan-generator 的功能实现
```

## 八、迁移指南

### 7.1 从一台电脑迁移到另一台

```bash
# 在原电脑
cd ~
tar czf ecc-agent-system.tar.gz .copilot/ .claude/rules/ecc/

# 传输到新电脑
scp ecc-agent-system.tar.gz user@new-machine:~/

# 在新电脑
cd ~
tar xzf ecc-agent-system.tar.gz

# 安装 lefthook
npm install -g lefthook

# 重启 VS Code 即可生效
```

### 7.2 注意事项

- `.copilot/state/` 目录包含运行时状态，建议不要迁移
- `.copilot/.backup/` 包含修复前的备份，可选择性迁移
- lefthook 需要在新电脑单独安装

## 九、故障排除

### 8.1 Agent 不响应

1. 确认文件位于 `~/.copilot/agents/` 目录
2. 确认文件扩展名为 `.agent.md`
3. 确认 YAML frontmatter 格式正确
4. 重启 VS Code

### 8.2 Hook 不执行

1. 确认文件位于 `~/.copilot/hooks/` 目录
2. 检查 lefthook 是否安装：`lefthook version`
3. 检查 git hooks 是否配置：`ls .git/hooks/`

### 8.3 Conductor 调度失败

1. 确认 `conductor.agent.md` 存在且完整
2. 检查目标 Agent 文件是否存在
3. 查看 VS Code 输出面板的错误信息

## 十、架构审计报告

本项目经过十余轮架构审计，以下为关键轮次：

| 轮次 | 文件 | 评分 |
|------|------|------|
| 深度审计 | `deep-architecture-audit-2026-07-04.md` | 92% |
| 第三轮 | `third-round-audit-2026-07-04.md` | 95% |

审计覆盖：Hook 可执行性、规则注入链、Skill 注入链、幻觉防范、重试机制、工具可用性、管道门禁、GAN 工作流。
