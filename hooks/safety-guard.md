# Safety Guard（可执行版）

硬性拦截 — 检测到危险操作时**必须**阻止。

## 触发条件

子 Agent 的任务信封中包含 bash 命令时触发。

---

## 可执行检测流程

### Step 1: 危险模式检测

在分发包含 bash 命令的任务前，使用 grep 检测危险模式：

```
grep_search(
  query: "rm -rf|git push --force|git reset --hard|DROP TABLE|DROP DATABASE|docker system prune|chmod 777|npm publish|terraform destroy|--no-verify",
  isRegexp: true,
  includePattern: "{任务信封内容}"
)
```

### Step 2: 判定

#### 如果检测到危险模式

1. **立即拒绝分发**，输出：
   > 🚨 Safety Guard: 操作已拦截

2. **解释影响范围**：
   - 影响什么文件/服务/数据
   - 潜在的不可逆后果

3. **提供替代方案**：

   | 危险命令 | 安全替代 |
   |----------|---------|
   | `git push --force` | `git push --force-with-lease` |
   | `rm -rf /` | 先 `ls` 确认，再 `rm -ri` |
   | `DROP TABLE` | 先备份，再删除 |
   | `chmod 777` | `chmod 755` 或更精确的权限 |
   | `terraform destroy` | 先 `terraform plan -destroy` |

4. **要求用户显式输入 "CONFIRM"** 后才能放行

#### 如果未检测到危险模式

正常分发任务，无需拦截。

---

## 危险命令清单

| 命令模式 | 风险等级 | 说明 |
|----------|---------|------|
| `rm -rf` (含 /、~ 或项目根目录) | CRITICAL | 递归删除文件系统 |
| `git push --force` | CRITICAL | 强制推送覆盖历史 |
| `git reset --hard` | HIGH | 丢弃本地更改 |
| `DROP TABLE` / `DROP DATABASE` | CRITICAL | 删除数据库对象 |
| `docker system prune --force` | HIGH | 清理 Docker 资源 |
| `kubectl delete` | HIGH | 删除 K8s 资源 |
| `chmod 777` | HIGH | 开放文件权限 |
| `npm publish` | MEDIUM | 发布包到 npm |
| `git push --delete` | HIGH | 删除远程分支 |
| `terraform destroy` | CRITICAL | 销毁基础设施 |
| 包含 `--no-verify` 的 git 命令 | MEDIUM | 绕过钩子检查 |
| 包含 `--force` 的破坏性命令 | HIGH | 强制执行 |

---

## 绕过规则

仅以下情况允许绕过：
- 用户在安全拦截后显式输入 **CONFIRM**
- 操作发生在非生产环境（需要用户确认是开发环境）

---

## 示例交互

```
Conductor: 分发任务给 code-reviewer，任务包含命令: git push --force

[执行 grep_search 检测到 "git push --force"]

Conductor: 🚨 Safety Guard: 操作已拦截

影响范围: 将强制覆盖远程分支历史，可能导致其他协作者的工作丢失
替代方案: 使用 git push --force-with-lease（仅在远程分支未被他人更新时才强制推送）

请确认是否继续？输入 CONFIRM 放行。

用户: CONFIRM

Conductor: ✅ Safety Guard: 用户已确认，放行
[继续执行]
```

---

## 配置

```yaml
enabled: true
blocking: true
require_confirmation: true
enforcement: executable  # 可执行模式
