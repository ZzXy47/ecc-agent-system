---
name: development-workflow
description: 开发工作流规则 — 定义从需求到交付的完整开发流程
version: 2.0.0
priority: high
targets:
  - all
---

# 开发工作流规则

## 核心原则

1. **先规划后编码** — 复杂任务必须先出计划
2. **小步提交** — 每次提交只做一件事
3. **测试驱动** — 新功能先写测试
4. **持续集成** — 频繁合并，避免大爆炸集成

---

## 一、标准开发流程

```
需求分析 → 设计规划 → 编码实现 → 测试验证 → 代码审查 → 合并部署
```

### 1. 需求分析
- 理解需求，拆解为可执行任务
- 复杂需求使用 `planner` Agent 规划
- 输出：任务清单、验收标准

### 2. 设计规划
- 使用 `code-architect` 分析现有架构
- 使用 `architect` 设计系统方案
- 输出：架构图、API 设计、数据模型

### 3. 编码实现
- 使用 `tdd-guide` 以 TDD 方式开发
- 遵循 `coding-style.md` 规范
- 每个功能分支独立开发

### 4. 测试验证
- 遵循 `testing.md` 规范
- 单元测试 + 集成测试 + E2E 测试
- 使用 `e2e-runner` 进行端到端测试

### 5. 代码审查
- 遵循 `code-review.md` 规范
- 自动审查 + 安全审查
- 所有检查通过后才能合并

### 6. 合并部署
- 遵循 `git-workflow.md` 规范
- Squash merge 保持历史清晰

---

## 二、Agent 调度策略

### 新功能开发流程
1. `planner` → 制定开发计划
2. `code-architect` → 分析代码架构
3. `tdd-guide` → 指导 TDD 开发
4. 对应语言审查者 → 代码审查
5. `security-reviewer` → 安全审查
6. `e2e-runner` → 端到端验证

### Bug 修复流程
1. 使用 `silent-failure-hunter` 定位根因
2. 编写复现测试
3. 修复代码
4. `code-reviewer` 审查
5. 验证修复

### 重构流程
1. `planner` → 制定重构计划
2. `code-explorer` → 分析影响范围
3. `refactor-cleaner` → 清理死代码
4. 逐步重构，每步可测试
5. 完整回归测试

---

## 三、质量门禁

### 合并前必须满足
- [ ] 所有测试通过
- [ ] 代码审查通过
- [ ] 安全检查通过
- [ ] 无构建错误
- [ ] 无 TypeScript/ESLint 错误

### 使用 `build-error-resolver` 解决构建问题
### 使用 `performance-optimizer` 优化性能瓶颈

---

## 四、命令

- `/aside` — 将当前任务暂存，切换上下文
- `/checkpoint` — 创建检查点，保存当前进度
- `/build-fix` — 触发构建错误修复
- `/evolve` — 持续改进工作流
