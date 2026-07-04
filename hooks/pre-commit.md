# Pre-Commit Code Quality（可执行版）

代码提交前质量检查。

## 触发条件

任何 `git commit` 操作或等效的代码提交动作。

---

## 可执行检查流程

### Step 1: 禁止提交的字符串扫描

对所有变更文件执行：

```
grep_search(
  query: "console\\.log|debugger|alert\\(|password=|secret=|api_key=|token=|@ts-ignore|@ts-expect-error|TODO|FIXME",
  isRegexp: true,
  includePattern: "{变更文件}"
)
```

| 模式 | 类型 | 处理 |
|------|------|------|
| `console.log` | 调试代码 | 删除或替换为 logger |
| `debugger` | 调试代码 | 删除 |
| `alert(` | 调试代码 | 删除或替换 |
| `print(` (Python 调试用) | 调试代码 | 删除或替换为 logging |
| `password=` / `secret=` | 硬编码密码 | 移到环境变量 |
| `api_key=` / `token=` | 硬编码密钥 | 移到环境变量 |
| `@ts-ignore` (无注释) | 类型绕过 | 添加注释或修复类型 |
| `@ts-expect-error` (无注释) | 类型绕过 | 添加注释或修复类型 |
| `TODO` / `FIXME` (无 issue) | 待办事项 | 关联 issue 编号 |

### Step 2: 大文件检测

```
run_in_terminal(
  command: "find {变更文件} -size +1M",
  explanation: "检测大于1MB的文件",
  goal: "Large file detection",
  mode: "sync"
)
```

- 如果有 > 1MB 的文件 → 警告（不阻断）
- 建议使用 Git LFS

### Step 3: 代码格式化

```
run_in_terminal(
  command: "npx prettier --check {变更文件} || npx black --check {变更文件}",
  explanation: "运行代码格式化检查",
  goal: "Format check",
  mode: "sync"
)
```

如果有格式化配置 → 运行格式化工具

---

## 不通过的处理

报告具体文件和行号：
```
❌ Pre-Commit 检查失败

src/utils.ts:42 - 包含 console.log
src/config.ts:15 - 包含硬编码密码 (api_key=...)
```

要求修复后重新提交。

---

## 配置

```yaml
enabled: true
blocking: true
enforcement: executable  # 可执行模式
scan_patterns:
  - "console\\.log"
  - "debugger"
  - "alert\\("
  - "password="
  - "secret="
  - "api_key="
  - "token="
  - "@ts-ignore"
  - "@ts-expect-error"
  - "TODO"
  - "FIXME"
max_file_size: 1048576  # 1MB
