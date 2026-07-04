# ECC Hooks System

## 概述

Hooks 是 ECC 的自动化检查机制，在关键节点自动执行验证，确保代码质量和安全。

**执行模式**: 所有 Hook 均为**可执行模式**（`enforcement: executable`），使用 `grep_search`、`read_file`、`run_in_terminal`、`runSubagent` 等工具实际执行检查，而非仅描述性检查。

## Hook 列表

| Hook | 触发时机 | 阻断级别 | 说明 |
|------|---------|---------|------|
| `gateguard` | Edit/Write/Bash 前 | 硬阻断 | 事实强制门控 — grep_search + read_file |
| `safety-guard` | 危险命令检测 | 硬阻断 | 破坏性操作拦截 — grep_search 模式匹配 |
| `delivery-gate` | 任务交付前 | 硬阻断 | 质量门禁 — runSubagent + run_in_terminal |
| `pre-commit` | git commit 前 | 软阻断 | 代码质量检查 — grep_search + run_in_terminal |
| `commit-msg` | 提交信息生成后 | 软阻断 | 格式验证 — grep_search 正则匹配 |
| `pre-push` | git push 前 | 软阻断 | 推送前验证 — run_in_terminal |

## 文件结构

```
hooks/
├── README.md              # 本文件
├── gateguard.md           # GateGuard 门控配置（可执行版）
├── safety-guard.md        # Safety Guard 配置（可执行版）
├── delivery-gate.md       # Delivery Gate 配置（可执行版）
├── pre-commit.md          # Pre-Commit 检查配置（可执行版）
├── commit-msg.md          # Commit Message 验证配置（可执行版）
└── pre-push.md            # Pre-Push 验证配置（可执行版）
```

## 阻断级别

- **硬阻断 (Hard Block)**: 必须通过才能继续执行，不可跳过
- **软阻断 (Soft Block)**: 应该通过，但可标记 `[SKIP-HOOK]` 跳过

## 可执行工具

每个 Hook 使用以下工具执行实际检查：

| 工具 | 用途 | 使用场景 |
|------|------|---------|
| `grep_search` | 模式匹配搜索 | 禁止字符串检测、危险命令检测、格式验证 |
| `read_file` | 读取文件内容 | 依赖分析、API 提取、结构检查 |
| `run_in_terminal` | 执行终端命令 | 类型检查、Lint、构建、测试 |
| `runSubagent` | 调用子 Agent | 代码审查、安全检查、质量评估 |
| `file_search` | 文件路径搜索 | 文件存在性验证 |

## 与 Agent 的关系

- Hooks 定义了"何时检查"和"检查什么"
- Agent 定义了"如何执行"检查逻辑
- Conductor 负责协调 hooks 和 agents 的执行
- 所有 Hook 检查结果通过 `runSubagent` 返回给 Conductor

## 使用方式

Hooks 在以下场景自动触发：

1. **Conductor 调度时** — GateGuard、Safety Guard、Delivery Gate
2. **代码提交时** — Pre-Commit、Commit Message（通过 lefthook）
3. **代码推送时** — Pre-Push（通过 lefthook）

也可以通过以下方式手动触发：

- `/hookify` — 创建新的 hook 规则
- `/hookify-list` — 列出所有 hook
- `/hookify-configure` — 配置 hook 启用/禁用

## 与 lefthook 的关系

- `.copilot/hooks/*.md` — Agent 层的可执行 Hook 定义（Conductor 使用）
- `.copilot/lefthook.yml` — Git 层的 Shell Hook 定义（Git 使用）
- 两层互补：lefthook 在 Git 操作时执行 Shell 检查，Conductor 在调度时执行 Agent 检查
