# Commit Message Validation（可执行版）

提交信息格式验证。

## 触发条件

任何提交信息生成时触发。

---

## 可执行检查流程

### Step 1: Conventional Commits 格式验证

使用正则表达式验证提交信息格式：

```
grep_search(
  query: "^(feat|fix|docs|style|refactor|perf|test|chore|ci|revert)\\(.+\\): .{1,72}$",
  isRegexp: true,
  includePattern: "{提交信息内容}"
)
```

必须匹配格式：
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

#### 有效 Type 类型

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

### Step 2: 标题长度检查

- 限制：≤ 72 字符
- 超过 → 警告并建议缩短

### Step 3: 禁止 WIP 检查

```
grep_search(
  query: "^WIP:|^wip:",
  isRegexp: true,
  includePattern: "{提交信息内容}"
)
```

- 不允许 `WIP:` 或 `wip:` 开头
- 除非 PR 为 draft 状态

---

## 不通过的处理

提示正确格式：
```
❌ 提交信息格式错误

当前: "修复了登录问题"
正确: "fix(auth): 修复登录页面重定向问题"

有效 type: feat, fix, docs, style, refactor, perf, test, chore, ci, revert
```

要求重新生成。

---

## 示例

```
feat(auth): add OAuth2 login support

- Implement Google and GitHub OAuth2 providers
- Add JWT token refresh logic

Closes #456
```

---

## 配置

```yaml
enabled: true
blocking: true
enforcement: executable  # 可执行模式
max_title_length: 72
allowed_types:
  - feat
  - fix
  - docs
  - style
  - refactor
  - perf
  - test
  - chore
  - ci
  - revert
forbidden_prefixes:
  - "WIP:"
  - "wip:"
