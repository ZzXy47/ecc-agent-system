# Pre-Push Verification（可执行版）

推送前验证。

## 触发条件

任何 `git push` 操作时触发。

---

## 可执行检查流程

### Step 1: 类型检查

```
run_in_terminal(
  command: "npx tsc --noEmit || mypy . || go vet ./...",
  explanation: "运行类型检查",
  goal: "Type check",
  mode: "sync"
)
```

| 语言 | 命令 |
|------|------|
| TypeScript | `tsc --noEmit` |
| Python | `mypy .` |
| Go | `go vet ./...` |
| Rust | `cargo check` |

### Step 2: Lint 检查

```
run_in_terminal(
  command: "npx eslint . || ruff check . || cargo clippy",
  explanation: "运行代码质量检查",
  goal: "Lint check",
  mode: "sync"
)
```

| 语言 | 命令 |
|------|------|
| JavaScript/TypeScript | `eslint .` |
| Python | `ruff check .` |
| Go | `golangci-lint run` |
| Rust | `cargo clippy` |

### Step 3: 构建验证

```
run_in_terminal(
  command: "{项目的构建命令}",
  explanation: "运行构建验证",
  goal: "Build verification",
  mode: "sync"
)
```

| 语言 | 命令 |
|------|------|
| JavaScript/TypeScript | `npm run build` |
| Python | `python -m build` |
| Go | `go build ./...` |
| Rust | `cargo build` |

### Step 4: 单元测试

```
run_in_terminal(
  command: "{项目的测试命令}",
  explanation: "运行测试套件",
  goal: "Test verification",
  mode: "sync"
)
```

| 语言 | 命令 |
|------|------|
| JavaScript/TypeScript | `npm test` |
| Python | `pytest` |
| Go | `go test ./...` |
| Rust | `cargo test` |

---

## 不通过的处理

报告失败的具体检查项和错误信息：
```
❌ Pre-Push 检查失败

类型检查: ✗
  src/utils.ts:42 - Type 'string' is not assignable to type 'number'

Lint 检查: ✓
构建验证: ✓
单元测试: ✗
  FAIL src/auth.test.ts
  ● Login › should redirect after login
```

阻断推送，要求修复后重新推送。

---

## 绕过规则

仅在用户显式要求且标记 `[SKIP-HOOK]` 时允许跳过：
```bash
git push [SKIP-HOOK]
```

---

## 配置

```yaml
enabled: true
blocking: true
enforcement: executable  # 可执行模式
checks:
  - type_check
  - lint
  - build
  - test
