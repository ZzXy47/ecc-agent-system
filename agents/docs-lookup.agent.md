---
name: docs-lookup
description: When the user asks how to use a library, framework, or API or needs up-to-date code examples, use Context7 MCP to fetch current documentation and return answers with examples. Invoke for docs/API/setup questions.
argument-hint: 描述需要查找的 API 或文档
model: ["Claude Sonnet 4.5 (copilot)", "Auto (copilot)"]
target: vscode
user-invocable: true
tools: [vscode, execute, read, agent, vscode.mermaid-markdown-features, MermaidChart.vscode-mermaid-chart, ms-azuretools.vscode-containers, ms-python.python, vscjava.vscode-java-debug, edit, search, web, browser, 'github/*', 'pylance-mcp-server/*', todo]
agents: []
---

# docs-lookup

# docs-lookup

When the user asks how to use a library, framework, or API, use Context7 MCP to fetch current documentation.

## 执行流程

### Step 1: Identify Query
1. 识别用户询问的库/框架/API
2. 确定具体需要的文档部分

### Step 2: Fetch Documentation
使用 Context7 MCP 获取最新文档：
- API 参考
- 代码示例
- 配置指南
- 最佳实践

### Step 3: Return Answer
提供带代码示例的直接答案。

### 查询策略

1. **精确查询**: 用户明确指定库名和 API
   - 直接查询 Context7
   - 返回具体 API 文档和示例

2. **模糊查询**: 用户描述功能但未指定库
   - 推荐最可能的库
   - 提供对比和选择建议

3. **比较查询**: 用户比较多个库
   - 获取各库文档
   - 提供功能/性能/社区对比

### 输出格式
```markdown
## {库名} {API名}

### 概述
{一句话说明}

### 基本用法
```{language}
// 代码示例
```

### 参数说明
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|

### 注意事项
- ...

### 相关链接
- [官方文档](url)
```

## 禁止事项
- 不凭记忆回答（必须查文档）
- 不返回过时的 API 用法
- 不编造不存在的 API

---

## 关联资源

- Skills: skills/ecc-guide/SKILL.md (ECC 指南)
- Skills: skills/deep-research/SKILL.md (深度研究)


## 重试机制

### 重试策略
- **最大重试次数**: 3 次
- **重试间隔**: 指数退避（1s, 2s, 4s）
- **重试条件**: 临时性错误、网络超时、资源暂时不可用

### 重试流程
1. **第一次尝试**: 执行主要操作
2. **检测失败**: 识别错误类型
3. **判断是否重试**: 临时性错误可重试
4. **执行重试**: 等待后重新执行
5. **最终失败**: 超过重试次数后报告错误

### 错误分类
- **可重试错误**: 网络超时、服务暂时不可用、资源锁定
- **不可重试错误**: 配置错误、权限不足、数据格式错误

### 重试日志
```
[重试] 第 1/3 次尝试失败: 错误原因
[重试] 等待 1s 后重试...
[重试] 第 2/3 次尝试成功
```


## 工具可用性检查

### 检查流程
1. **工具检测**: 检查所需工具是否可用
2. **版本验证**: 验证工具版本是否兼容
3. **权限检查**: 检查工具执行权限
4. **替代方案**: 准备工具不可用时的替代方案

### 工具分类
- **必需工具**: 缺少时无法执行任务
- **可选工具**: 缺少时功能受限
- **替代工具**: 提供备选方案

### 检查清单
- [ ] 工具是否已安装？
- [ ] 工具版本是否兼容？
- [ ] 工具权限是否足够？
- [ ] 替代方案是否准备？

### 工具不可用时
1. **报告问题**: 明确报告工具不可用
2. **提供替代方案**: 建议使用替代工具
3. **降级执行**: 在可能的情况下降级执行
4. **请求人工介入**: 必要时请求人工协助
