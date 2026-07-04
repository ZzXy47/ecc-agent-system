---
name: coding-style
description: 编码风格规则 — 统一团队的代码风格、命名规范和格式化标准
version: 2.0.0
priority: high
targets:
  - all
---

# 编码风格规则

## 核心原则

1. **一致性优先** — 与现有代码风格保持一致
2. **可读性至上** — 代码是写给人看的
3. **最小惊讶** — 遵循语言社区惯例
4. **自动化优先** — 能用工具强制的不靠人记

---

## 一、通用规则

### 命名规范
- **变量/函数**：`camelCase`
- **类/接口/类型**：`PascalCase`
- **常量**：`UPPER_SNAKE_CASE`
- **文件名**：`kebab-case` 或与默认导出一致
- **禁止**：拼音命名、无意义缩写、单字母变量（循环计数器除外）

### 注释规范
- 使用中文或英文，保持项目一致
- 公共 API 必须有文档注释
- 复杂逻辑必须有解释性注释
- 禁止：注释掉的代码（使用版本控制）
- 禁止：误导性注释、过时注释

### 文件组织
- 一个文件一个主导出（组件/类/模块）
- 相关功能放在同一目录
- 导入顺序：外部库 → 内部模块 → 相对路径 → 样式

---

## 二、语言特定规则

### TypeScript/JavaScript
- 优先使用 `const`，避免 `var`
- 使用箭头函数处理回调
- 使用解构赋值
- 使用模板字符串代替拼接
- 使用 `===` 而非 `==`
- 异步操作使用 `async/await`
- 参见 `ecc/typescript/coding-style.md`

### Python
- 遵循 PEP 8
- 使用类型注解
- 使用 f-string 格式化
- 使用 `with` 语句管理资源

### Go
- 遵循 `gofmt` 标准格式
- 错误作为返回值，不使用 panic
- 使用 `context.Context` 传递上下文

---

## 三、格式化工具

| 语言 | 格式化工具 | Linter |
|------|-----------|--------|
| TypeScript/JS | Prettier | ESLint |
| Python | Black | Ruff |
| Go | gofmt | golangci-lint |
| Rust | rustfmt | Clippy |
| Java | google-java-format | Checkstyle |
| Kotlin | ktlint | Detekt |
| Dart | dart format | dart analyze |

---

## 四、禁止事项

- ❌ 提交包含 `console.log` 的调试代码
- ❌ 提交包含 `TODO` 但没有关联 issue 的代码
- ❌ 硬编码环境相关的值（URL、密钥、路径）
- ❌ 超过 200 行的函数
- ❌ 超过 500 行的文件
- ❌ 超过 3 层的嵌套回调
