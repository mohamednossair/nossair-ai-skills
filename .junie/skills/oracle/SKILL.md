---
name: oracle
description: Review or develop Oracle database schemas and queries
---

# Oracle Skill

Use this skill when designing Oracle schemas or writing/optimizing SQL queries for Oracle Database.

## Key Principles
- **Bind Variables**: Always use bind variables. Never concatenate user input.
- **Explicit Columns**: `SELECT *` is forbidden. List columns explicitly.
- **Indexing**: Index all foreign key columns and frequently filtered columns.
- **Pagination**: Use `FETCH FIRST N ROWS ONLY`.

## Guidelines

### Schema Design
- Use `VARCHAR2` (not `VARCHAR`) for character strings.
- Follow consistent naming conventions (Oracle identifiers are uppercase by default).
- Use `MERGE` for upsert operations.
- Define primary keys for all tables.
- Use sequences + `NEXTVAL` for ID generation (or `IDENTITY` columns).

### Query Best Practices
- Avoid large `IN` clauses; consider temporary tables or joins.
- Use `EXPLAIN PLAN` or `DBMS_XPLAN` to analyze query performance.
- Avoid using functions on indexed columns in `WHERE` clauses (prevents index usage).

## Checklist
- [ ] Are all foreign keys indexed?
- [ ] Is `SELECT *` avoided?
- [ ] Are bind variables used consistently?
- [ ] Is `FETCH FIRST N ROWS ONLY` used for pagination?
- [ ] Are primary keys defined?

## Example
```sql
/** Good: Explicit columns, bind variables, and FETCH pagination */
SELECT id, username, email 
FROM users 
WHERE status = :status 
ORDER BY created_at DESC 
FETCH FIRST 10 ROWS ONLY;
```
