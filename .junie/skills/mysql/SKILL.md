---
name: mysql
description: Review or develop MySQL database schemas and queries
---

# MySQL Skill

Use this skill when designing MySQL schemas or writing/optimizing SQL queries for MySQL.

## Key Principles
- **Bind Variables**: Always use bind variables. Never concatenate user input.
- **Explicit Columns**: `SELECT *` is forbidden. List columns explicitly.
- **Indexing**: Index all foreign key columns and frequently filtered columns.
- **Pagination**: Use `LIMIT` for pagination.

## Guidelines

### Schema Design
- Use `InnoDB` as the storage engine.
- Use `utf8mb4` charset for all text columns.
- `DATETIME` vs `TIMESTAMP`: TIMESTAMP stores UTC, converts on retrieval.
- Follow consistent naming conventions (e.g., snake_case for tables and columns).
- Define primary keys for all tables.

### Query Best Practices
- Avoid large `IN` clauses; consider temporary tables or joins.
- Use `EXPLAIN` to analyze query performance.
- Avoid using functions on indexed columns in `WHERE` clauses (prevents index usage).

## Checklist
- [ ] Are all foreign keys indexed?
- [ ] Is `SELECT *` avoided?
- [ ] Are bind variables used consistently?
- [ ] Is the schema using `InnoDB` and `UTF8MB4`?
- [ ] Are primary keys defined?

## Example
```sql
/** Good: Explicit columns and bind variables */
SELECT id, username, email 
FROM users 
WHERE status = ? 
ORDER BY created_at DESC 
LIMIT 10;
```
