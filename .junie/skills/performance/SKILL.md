---
name: performance
description: Performance review and optimization for Java/Spring, Angular, and SQL — N+1, caching, SQL tuning, bundle size, virtual threads
---

# Performance Skill

Use this skill when reviewing or optimizing performance. It consolidates the project's performance standards across the backend, frontend, and database.

## When to Use
- Reviewing or optimizing slow endpoints, queries, pages, or components.
- Designing caching, pagination, batching, or parallel-loading strategies.
- Reviewing concurrency (virtual threads, thread pools, streams).
- Any `/review` where performance is a concern (combine with the technology skill).

## Key Principles
- **Measure first**: profile, `EXPLAIN`, or Lighthouse before optimizing — no speculative optimization.
- **Algorithms before micro-optimizations**: fix O-notation first, then hot paths.
- **Optimize the user-perceived path**: p95 latency and time-to-interactive, not averages.
- **Resource discipline**: close what you open; bound every queue, cache, and result set.

## Guidelines

### Java / Spring Boot
- **N+1 queries**: flag lazy associations accessed in loops; use `@EntityGraph`, `JOIN FETCH`, or DTO projections.
- **Pagination**: all list endpoints paginate; never load unbounded result sets.
- **Caching**: `@Cacheable` for stable reference data with explicit TTL and eviction; never cache user-specific data without a proper key.
- **Virtual threads**: for I/O-bound tasks only; avoid `synchronized` blocks around blocking I/O (pinning).
- **Streams**: fine for readability; avoid `parallel()` streams in web request threads.
- **Logging**: parameterized SLF4J; guard expensive debug message construction with `log.isDebugEnabled()`.

### SQL (Oracle & MySQL)
- `EXPLAIN` / `EXPLAIN PLAN` before optimizing; look for full scans on large tables.
- Index columns used in `WHERE`, `JOIN`, `ORDER BY`; composite index column order matches the predicates.
- Avoid functions on indexed columns (sargability).
- Select only needed columns; `SELECT *` on wide tables wastes I/O.
- Batch `INSERT`/`UPDATE` (JDBC batching, `saveAll`) instead of row-by-row.
- Avoid large `IN` lists; use joins or temporary tables.

### Angular / TypeScript
- `OnPush` + `track` in `@for` to minimize change detection and DOM churn.
- `@defer` for heavy below-the-fold components; lazy-load routes with `loadComponent`.
- No recomputation in templates — use `computed()` signals or pipes.
- Clean up subscriptions (`toSignal`, `takeUntilDestroyed`) to avoid leaked listeners and repeated HTTP calls.
- `shareReplay(1)` for shared HTTP observables; cache at service level where appropriate.
- Bundle budget: avoid importing entire libraries for one function; check the initial bundle size.

### Data Loading
- Parallelize independent requests (`Promise.all`, `resource()`); avoid request waterfalls.
- Debounce user-input-driven requests; cancel stale ones (`switchMap`).

## Checklist
- [ ] Measured before optimizing (EXPLAIN, profiler, Lighthouse)?
- [ ] No N+1 query patterns?
- [ ] List endpoints paginated?
- [ ] Caching explicit (what, TTL, eviction)?
- [ ] Virtual threads used for I/O only?
- [ ] Angular: OnPush, `track`, `@defer`, `computed()` where hot?
- [ ] No unbounded collections, queues, or caches?
