---
name: git-workflow
description: Git 工作流规则 — 定义分支策略、提交规范和版本管理
version: 2.0.0
priority: high
targets:
  - all
---

# Git 工作流规则

## 核心原则

1. **主分支受保护** — `main`/`master` 禁止直接推送
2. **功能分支开发** — 所有变更在独立分支进行
3. **提交信息规范** — 统一的提交格式
4. **Squash 合并** — 保持主分支历史清晰

---

## 一、分支策略

### 分支类型

| 分支 | 用途 | 命名格式 | 示例 |
|------|------|---------|------|
| `main` | 生产就绪代码 | `main` | `main` |
| `develop` | 开发集成分支 | `develop` | `develop` |
| `feature/*` | 新功能 | `feature/<描述>` | `feature/user-auth` |
| `fix/*` | Bug 修复 | `fix/<issue-id>-<描述>` | `fix/123-login-redirect` |
| `hotfix/*` | 紧急修复 | `hotfix/<描述>` | `hotfix/security-patch` |
| `release/*` | 发布准备 | `release/<版本号>` | `release/v2.1.0` |
| `chore/*` | 杂项维护 | `chore/<描述>` | `chore/update-deps` |
| `refactor/*` | 重构 | `refactor/<描述>` | `refactor/extract-service` |
| `docs/*` | 文档 | `docs/<描述>` | `docs/api-reference` |

### 分支生命周期
1. 从 `main` 或 `develop` 创建
2. 本地开发和测试
3. 推送并创建 PR
4. 通过审查和 CI
5. Squash 合并到目标分支
6. 删除源分支

---

## 二、提交规范

### 提交格式（Conventional Commits）

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Type 类型

| Type | 说明 |
|------|------|
| `feat` | 新功能 |
| `fix` | Bug 修复 |
| `docs` | 文档更新 |
| `style` | 代码格式（不影响功能） |
| `refactor` | 重构（不新增功能也不修复 bug） |
| `perf` | 性能优化 |
| `test` | 测试相关 |
| `chore` | 构建/工具/依赖 |
| `ci` | CI/CD 变更 |
| `revert` | 回滚 |

### 示例
```
feat(auth): add OAuth2 login support

- Implement Google and GitHub OAuth2 providers
- Add JWT token refresh logic

Closes #456
```

---

## 三、PR 规范

### PR 标题
- 使用与提交相同的格式
- 简洁描述变更内容

### PR 描述模板
```markdown
## 变更说明
<!-- 简要描述变更内容 -->

## 相关 Issue
Closes #

## 测试
- [ ] 单元测试通过
- [ ] 集成测试通过
- [ ] 手动测试通过

## 截图（如适用）
<!-- UI 变更请附截图 -->

## 检查清单
- [ ] 代码遵循风格规范
- [ ] 添加了必要的测试
- [ ] 更新了相关文档
```

---

## 四、禁止事项

- ❌ 直接推送到 `main` 或 `master`
- ❌ 强制推送（`--force`）到共享分支
- ❌ 提交包含密钥或敏感信息
- ❌ 提交大型二进制文件
- ❌ 修改已发布的历史记录（rebase 已推送的提交）
- ❌ 合并前未通过 CI 检查
