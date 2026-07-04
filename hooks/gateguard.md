# GateGuard 门控（可执行版）

硬性前置条件 — 任何 Edit、Write 或 Bash 调用前**必须**执行。

## 触发条件

- 任何 `Edit` / `replace_string_in_file` 工具调用
- 任何 `Write` / `create_file` 工具调用
- 任何 `Bash` / `run_in_terminal` 工具调用

---

## 可执行检查流程

### Step 1: 拦截

在工具调用前，**拒绝首次操作请求**，输出：

> 🚫 GateGuard: 拒绝操作，要求收集事实

### Step 2: 收集事实（必须使用工具完成）

以下三项事实**缺一不可**，且**必须实际执行工具调用**，不凭记忆：

#### 事实 1: 依赖分析

```
grep_search(
  query: "import.*{目标文件名}|require.*{目标文件名}|from.*{目标文件名}",
  isRegexp: true,
  includePattern: "**/*.{ts,tsx,js,jsx,py,go,rs,java,kt,swift,cs,cpp,hpp,rb,php}"
)
```

输出：列出所有引用目标文件的文件清单。

#### 事实 2: 影响范围

```
read_file(
  filePath: "{目标文件路径}",
  startLine: 1,
  endLine: 100
)
```

输出：列出受影响的公共函数/类/接口签名。

#### 事实 3: 数据结构（如涉及配置/数据文件）

```
read_file(
  filePath: "{配置文件路径}",
  startLine: 1,
  endLine: 50
)
```

输出：展示字段名和结构。

### Step 3: 验证放行

确认三项事实全部提供后，输出：

> ✅ GateGuard: 放行

允许操作继续。

---

## 验证要求

- **不允许**在事实收集完成前执行任何 Edit/Write/Bash
- 如果调用者跳过 GateGuard，Conductor **必须**中断执行并报告安全违规
- 如果搜索结果为空（无引用），仍需记录"无引用"并继续

---

## 示例交互

```
用户: 修改 src/utils/format.ts

Conductor: 🚫 GateGuard: 拒绝操作，要求收集事实

[执行 grep_search 搜索 format.ts 的引用]
[执行 read_file 读取 format.ts 的公共 API]

Conductor: 事实收集完成:
  - 依赖分析: 3 个文件引用了 format.ts (api.ts, helpers.ts, index.ts)
  - 影响范围: formatDate(), formatCurrency() 两个公共函数
  - 数据结构: 不涉及配置文件

✅ GateGuard: 放行

[继续执行修改]
```

---

## 配置

```yaml
enabled: true
blocking: true
bypass: false
enforcement: executable  # 可执行模式
