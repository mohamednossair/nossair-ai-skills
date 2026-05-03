---
description: Review MySQL database schemas and queries for InnoDB, indexing, and utf8mb4
---

**Usage**: `/mysql-review file="path/to/query.sql"` or for schema review.

## Key Principles
- **Bind Variables**: Always use bind variables. Never concatenate user input.
- **Explicit Columns**: `SELECT *` is forbidden. List columns explicitly.
- **Indexing**: Index all foreign key columns and frequently filtered columns.
- **Pagination**: Use `LIMIT` for pagination.

## Schema Design
- Use `InnoDB` as the storage engine.
- Use `utf8mb4` charset for all text columns.
- `DATETIME` vs `TIMESTAMP`: TIMESTAMP stores UTC, converts on retrieval.
- Follow consistent naming conventions (snake_case).
- Define primary keys for all tables.

## Query Best Practices
- Avoid large `IN` clauses; consider temporary tables or joins.
- Use `EXPLAIN` to analyze query performance.
- Avoid using functions on indexed columns in `WHERE` clauses.

## Checklist
- [ ] Are all foreign keys indexed?
- [ ] Is `SELECT *` avoided?
- [ ] Are bind variables used consistently?
- [ ] Is the schema using `InnoDB` and `UTF8MB4`?
- [ ] Are primary keys defined?
- [ ] Is `LIMIT` used for pagination?

## Output
[CRITICAL] | [WARNING] | [SUGGESTION] — with corrected query/schema.
