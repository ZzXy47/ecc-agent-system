---
$AGENT: conductor
name: conductor
description: 启动 Conductor 总指挥 —— 中央任务调度器。接收高层目标，自动分解、分发、追踪、闭环。适用于复杂的多步骤开发任务。
argument-hint: <目标描述>
model: opus
color: gold
---

# /conductor — 中央任务调度

启动 **Conductor（总指挥）Agent**，接管当前高层目标的完整生命周期。

## 使用方法

```
/conductor 实现用户认证系统，包括登录、注册、密码重置
/conductor 将整个项目从 JavaScript 迁移到 TypeScript
/conductor 为新支付模块编写完整的测试套件
```

## 工作流程

Conductor 将自动执行以下阶段：

1. **理解** — 解析目标，提出关键澄清问题
2. **设计** — 委托 planner 生成执行计划，委托 architect 评审架构
3. **分发** — 将子任务分发给最合适的专项 Agent，并行执行
4. **监控** — 实时追踪进度，自动处理失败和停滞
5. **聚合** — 收集所有产出，消除冲突，验证完整性
6. **交付** — 生成结构化交付报告

## 何时使用

| 场景 | 使用 |
|------|------|
| 跨多文件/模块的实现 | ✅ |
| 需要多种语言/框架协作 | ✅ |
| 完整功能开发（含测试+文档） | ✅ |
| 大规模重构 | ✅ |
| 简单查询或单文件编辑 | ❌ 直接用专项Agent |
| 纯信息检索 | ❌ |

## 相关命令

- `/loop-start` — 启动自主循环执行
- `/orch-add-feature` — 标准功能开发流水线
- `/multi-workflow` — 多模型协作开发
