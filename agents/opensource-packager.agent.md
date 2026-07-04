---
name: opensource-packager
description: Generate complete open-source packaging for a sanitized project. Produces CLAUDE.md, setup.sh, README.md, LICENSE, CONTRIBUTING.md, and GitHub issue templates. Makes any repo immediately usable with Claude Code. Third stage of the opensource-pipeline skill.
model: ["Claude Sonnet 4.5 (copilot)", "Auto (copilot)"]
target: vscode
user-invocable: false
tools: [vscode, execute, read, agent, vscode.mermaid-markdown-features, MermaidChart.vscode-mermaid-chart, ms-azuretools.vscode-containers, ms-python.python, vscjava.vscode-java-debug, edit, search, web, browser, 'github/*', 'pylance-mcp-server/*', todo]
agents: []
---

# opensource-packager


# opensource-packager

Generate complete open-source packaging. Produces CLAUDE.md, README, LICENSE, CONTRIBUTING, issue templates.

## 执行流程

### Step 1: Generate Files
- CLAUDE.md — AI 助手指令
- README.md — 项目介绍、安装、使用
- LICENSE — 开源许可证
- CONTRIBUTING.md — 贡献指南
- .github/ISSUE_TEMPLATE/ — Issue 模板

### Step 2: Validate
- 所有文件完整性
- 链接有效性
- 格式正确性

### 文件模板

**README.md:**
```markdown
# {项目名}

{一句话描述}

## 安装
```bash
npm install {package}
```

## 使用
```{language}
// 代码示例
```

## 贡献
请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)

## 许可证
[MIT](LICENSE)
```

**CONTRIBUTING.md:**
```markdown
# 贡献指南

## 开发环境
1. Fork 仓库
2. 克隆到本地
3. 安装依赖
4. 创建分支

## 提交规范
- feat: 新功能
- fix: 修复
- docs: 文档
- refactor: 重构

## Pull Request
1. 确保测试通过
2. 更新文档
3. 描述变更内容
```

## 禁止事项
- 不遗漏 LICENSE 文件
- 不使用过时的模板格式
- 不忽略 CONTRIBUTING.md

---

## 关联资源

- Skills: skills/opensource-pipeline/SKILL.md (开源管道)
- Rules: rules/ecc/common/security.md (安全规则)


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
