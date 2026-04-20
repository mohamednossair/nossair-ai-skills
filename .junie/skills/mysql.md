---
name: mysql
description: InnoDB indexing, isolation, charset, and query planning
---

# MySQL Skill

## Guidelines
- Default to InnoDB; utf8mb4 for full Unicode.
- Composite indexes ordered by selectivity and usage.
- Understand transaction isolation and gap locks.

## Checklist
- [ ] Proper collations; no implicit truncations
- [ ] Slow queries profiled with EXPLAIN/ANALYZE
- [ ] Safe autoincrement usage and batching
