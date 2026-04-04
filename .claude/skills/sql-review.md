---
description: Review or write SQL queries for Oracle or MySQL — correctness, performance, and security
---
Review or write the SQL query for the described need. Detect or use the specified database (Oracle / MySQL).

## Security (check first)
- No string concatenation in dynamic SQL — use bind variables (`:param` Oracle, `?` / `:param` MySQL)
- No `SELECT *` in production queries — list columns explicitly
- Input validation before query execution

## Correctness
- JOIN conditions complete (no accidental cartesian product)
- NULL handling: `IS NULL` / `IS NOT NULL`, not `= NULL`
- Aggregates without GROUP BY on non-aggregate columns
- OUTER JOIN direction (LEFT vs RIGHT vs FULL)
- Date comparisons: use proper date literals / bind params, not string comparison

## Performance
- Indexes on WHERE, JOIN, and ORDER BY columns
- Functions on indexed columns break indexes: `WHERE UPPER(email) = ...` → use function-based index or redesign
- `EXISTS` vs `IN`: prefer `EXISTS` for large subquery result sets
- Avoid `SELECT DISTINCT` as a workaround for bad JOINs — fix the join
- Pagination: use `FETCH FIRST N ROWS ONLY` (Oracle 12c+) or `LIMIT/OFFSET` (MySQL)

## Oracle-Specific
- Bind variables are critical for plan reuse: `:param` syntax
- `ROWNUM` for pagination (legacy) vs `FETCH FIRST` (modern)
- Use `MERGE` for upsert operations
- Sequences + `NEXTVAL` for ID generation (or IDENTITY columns)

## MySQL-Specific
- `EXPLAIN` output — identify full table scans
- `utf8mb4` charset for all text columns
- `DATETIME` vs `TIMESTAMP`: TIMESTAMP stores UTC, converts on retrieval

Output: the reviewed/rewritten query + explanation of each change made.
