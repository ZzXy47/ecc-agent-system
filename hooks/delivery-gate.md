# Delivery Gate（可执行版）

质量硬门禁 — 不通过不交付。

## 触发条件

所有任务完成，准备交付时触发。

---

## 可执行检查流程（使用 agent 和 run_in_terminal 实际执行）

### Gate 1: 测试通过

```
run_in_terminal(
  command: "{项目的测试命令}",  // npm test / pytest / go test ./...
  explanation: "运行完整测试套件",
  goal: "Test verification",
  mode: "sync"
)
```

- [ ] 0 失败

### Gate 2: 审查通过

```
agent(
  agentName: "code-reviewer",
  prompt: "审查以下变更文件的代码质量：{变更文件清单}",
  description: "Code quality review"
)
```

- [ ] 无 CRITICAL/HIGH 发现

### Gate 3: 安全通过

```
agent(
  agentName: "security-reviewer",
  prompt: "安全检查以下变更文件：{变更文件清单}",
  description: "Security review"
)
```

- [ ] 无 CRITICAL 漏洞

### Gate 4: 构建通过

```
run_in_terminal(
  command: "{项目的构建命令}",  // npm run build / python -m build / go build ./...
  explanation: "运行构建验证",
  goal: "Build verification",
  mode: "sync"
)
```

- [ ] 0 错误

### Gate 5: 类型通过

```
run_in_terminal(
  command: "npx tsc --noEmit || mypy . || go vet ./...",
  explanation: "运行类型检查",
  goal: "Type check",
  mode: "sync"
)
```

- [ ] 0 错误

### Gate 6: GateGuard 通过

- [ ] 所有 Edit/Write/Bash 调用都有门控记录
- [ ] 无绕过门控的操作

### Gate 7: Safety Guard 通过

- [ ] 无被绕过的危险操作
- [ ] 所有危险操作都有用户确认

---

## 不通过的处理

如果任一项失败：
1. 使用 `agent` 返回对应的子代理修复
2. 修复后重新运行全部检查
3. **最多重试 3 轮**
4. 3 轮后仍未通过 → 标记失败，生成详细的不通过报告

---

## 通过门槛

**全部 7 项 PASS 后才能交付。** 单项 PARTIAL 不视为 PASS。

---

## 示例交互

```
Conductor: 所有任务完成，开始 Delivery Gate 检查

[并行执行]
run_in_terminal("npm test") → ✅ 0 失败
agent("code-reviewer") → ✅ 无 CRITICAL/HIGH
agent("security-reviewer") → ✅ 无 CRITICAL 漏洞
run_in_terminal("npm run build") → ✅ 0 错误
run_in_terminal("tsc --noEmit") → ✅ 0 错误
GateGuard 记录 → ✅ 全部有记录
Safety Guard 记录 → ✅ 无绕过

Conductor: ✅ Delivery Gate: 全部 7 项 PASS，交付确认
```

---

## 配置

```yaml
enabled: true
blocking: true
max_retries: 3
enforcement: executable  # 可执行模式
