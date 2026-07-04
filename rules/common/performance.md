---
name: performance
description: 性能规则 — 定义性能标准、优化策略和监控指标
version: 2.0.0
priority: high
targets:
  - all
---

# 性能规则

## 核心原则

1. **测量优先** — 优化前必须先测量，找到真正的瓶颈
2. **用户感知优先** — 优先优化用户能感知到的性能
3. **渐进优化** — 在保证正确性的前提下优化
4. **避免过早优化** — 先让它工作，再让它快

---

## 一、性能指标

### Web 前端

| 指标 | 目标 | 说明 |
|------|------|------|
| FCP (First Contentful Paint) | < 1.8s | 首次内容绘制 |
| LCP (Largest Contentful Paint) | < 2.5s | 最大内容绘制 |
| TBT (Total Blocking Time) | < 200ms | 总阻塞时间 |
| CLS (Cumulative Layout Shift) | < 0.1 | 累积布局偏移 |
| TTI (Time to Interactive) | < 3.8s | 可交互时间 |

### API/后端

| 指标 | 目标 | 说明 |
|------|------|------|
| P50 延迟 | < 100ms | 50% 请求延迟 |
| P95 延迟 | < 500ms | 95% 请求延迟 |
| P99 延迟 | < 1s | 99% 请求延迟 |
| 吞吐量 | 按需定义 | 每秒请求数 |
| 错误率 | < 0.1% | 错误请求占比 |

### 数据库

| 指标 | 目标 |
|------|------|
| 查询时间 | < 50ms（简单查询）/ < 200ms（复杂查询）|
| 连接数 | < 80% 最大连接池 |
| 慢查询比例 | < 1% |

---

## 二、优化策略

### 前端优化
- **代码分割**：按路由/组件懒加载
- **资源优化**：图片压缩、WebP 格式、CDN 加速
- **缓存策略**：Service Worker、HTTP 缓存、Memoization
- **渲染优化**：虚拟列表、防抖/节流、requestAnimationFrame
- **Bundle 优化**：Tree shaking、Dead code elimination

### 后端优化
- **数据库**：索引优化、查询优化、连接池配置
- **缓存**：Redis、内存缓存、CDN 缓存
- **并发**：异步 I/O、连接池、Worker 线程
- **序列化**：高效序列化格式（Protobuf/MessagePack）

### 使用 Agent 优化
- `performance-optimizer` — 性能分析和优化
- `database-reviewer` — 数据库查询优化

---

## 三、性能测试

### 负载测试
- 使用 `k6`、`Artillery` 或 `JMeter`
- 模拟真实流量模式
- 测试到系统极限

### 基准测试 (Benchmark)
- 关键路径必须有 benchmark
- 在 CI 中运行 benchmark 检测性能回退

---

## 四、监控与告警

### 关键监控
- 应用性能监控 (APM)：Datadog/NewRelic/OpenTelemetry
- 前端监控：Web Vitals、自定义指标
- 错误追踪：Sentry/同类工具
- 基础设施监控：CPU、内存、磁盘、网络

### 告警规则
- P95 延迟超过阈值 → 告警
- 错误率超过 1% → 告警
- 资源使用超过 80% → 警告

---

## 五、禁止事项

- ❌ 没有测量就优化
- ❌ N+1 查询
- ❌ 在循环中进行数据库查询
- ❌ 同步阻塞 I/O（在异步上下文中）
- ❌ 加载整个表到内存
- ❌ 不设置缓存过期时间
- ❌ 未压缩的大资源
