---
name: sql
description: Query design, indexing, safety, and migrations
---

# SQL Skill

## Guidelines
- Always parameterize queries; avoid string concatenation.
- Design indexes for predicates and join columns; measure with EXPLAIN.
- Limit SELECT lists; avoid SELECT * in production code.
- Use migrations and idempotent DDL patterns.

## Checklist
- [ ] Predicates sargable; proper indexes exist
- [ ] N+1 avoided; batching used where safe
- [ ] Transactions sized appropriately
- [ ] Migrations tested forward/backward
