---
description: Review Oracle database schemas and queries for performance, sequences, and execution plans
---

**Usage**: `/oracle-review file="path/to/query.sql"` or for schema review.

## Key Principles
- **Bind Variables**: Always use bind variables (`:param`). Never concatenate.
- **Explicit Columns**: `SELECT *` is forbidden. List columns explicitly.
- **Indexing**: Index all foreign key columns and frequently filtered columns.
- **Pagination**: Use `FETCH FIRST N ROWS ONLY`.

## Schema Design
- Use `VARCHAR2` (not `VARCHAR`) for character strings.
- Follow consistent naming conventions (uppercase by default).
- Use `MERGE` for upsert operations.
- Define primary keys for all tables.
- Use sequences + `NEXTVAL` for ID generation (or `IDENTITY` columns).

## Query Best Practices
- Avoid large `IN` clauses; consider temporary tables or joins.
- Use `EXPLAIN PLAN` or `DBMS_XPLAN` to analyze performance.
- Avoid using functions on indexed columns in `WHERE` clauses.

## Checklist
- [ ] Are all foreign keys indexed?
- [ ] Is `SELECT *` avoided?
- [ ] Are bind variables used consistently?
- [ ] Is `FETCH FIRST N ROWS ONLY` used for pagination?
- [ ] Are primary keys defined?
- [ ] Is `VARCHAR2` used instead of `VARCHAR`?

## Output
[CRITICAL] | [WARNING] | [SUGGESTION] — with corrected query/schema.
