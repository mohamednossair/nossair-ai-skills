---
name: performance
description: Performance review and optimization (N+1, caching, SQL tuning, bundle size, virtual threads) — apply when optimizing slow endpoints, queries, or pages
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Apply the project's performance standards when reviewing or optimizing slow endpoints, queries, pages, or components.

1. Read the detailed skill at `.junie/skills/performance/SKILL.md` and follow it.
2. Combine with the technology skill (`spring-boot`, `angular`, `oracle`/`mysql`) for the code under review.
3. Measure first — recommend `EXPLAIN`, profiling, or Lighthouse before proposing fixes; no speculative optimization.
4. When reviewing, group findings by [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix. Flag as Critical: N+1 patterns, unbounded result sets, missing pagination on list endpoints.
