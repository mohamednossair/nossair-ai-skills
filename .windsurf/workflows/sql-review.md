---
description: Review SQL queries for Oracle or MySQL — correctness, performance, and security
---

**Usage**: `/sql-review file="path/to/query.sql"`

## Security (check first)
- No string concatenation — use bind variables
- No `SELECT *` in production — list columns explicitly
- Input validation before query execution

## Correctness
- JOIN conditions complete (no accidental cartesian product)
- NULL handling: `IS NULL` / `IS NOT NULL`, not `= NULL`
- Aggregates without GROUP BY on non-aggregate columns
- Date comparisons: use proper date literals / bind params

## Performance
- Indexes on WHERE, JOIN, and ORDER BY columns
- Functions on indexed columns break indexes
- `EXISTS` vs `IN`: prefer `EXISTS` for large subquery results
- Avoid `SELECT DISTINCT` as a workaround for bad JOINs

## Oracle-Specific
- Bind variables: `:param` syntax
- `FETCH FIRST N ROWS ONLY` for pagination (modern)
- Use `MERGE` for upsert operations

## MySQL-Specific
- `EXPLAIN` output — identify full table scans
- `utf8mb4` charset for all text columns
- `LIMIT` for pagination

## Output
Reviewed/rewritten query + explanation of each change.
