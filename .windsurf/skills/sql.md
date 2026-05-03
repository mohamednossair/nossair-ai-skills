# SQL Skill

## Key Principles
- **Always use bind variables** — never concatenate user input into SQL.
- `SELECT *` is forbidden in production code — list columns explicitly.
- Index all foreign key columns.
- Use `FETCH FIRST N ROWS ONLY` (Oracle) / `LIMIT` (MySQL) for pagination.
- Schema changes via Flyway migrations only.

## Guidelines

### Security
- No string concatenation in dynamic SQL — use bind variables (`:param` Oracle, `?` / `:param` MySQL).
- Input validation before query execution.

### Correctness
- JOIN conditions complete (no accidental cartesian product).
- NULL handling: `IS NULL` / `IS NOT NULL`, not `= NULL`.
- Aggregates without GROUP BY on non-aggregate columns.
- Date comparisons: use proper date literals / bind params, not string comparison.

### Performance
- Indexes on WHERE, JOIN, and ORDER BY columns.
- Functions on indexed columns break indexes.
- `EXISTS` vs `IN`: prefer `EXISTS` for large subquery result sets.
- Avoid `SELECT DISTINCT` as a workaround for bad JOINs — fix the join.

## Checklist
- [ ] Are bind variables used consistently?
- [ ] Is `SELECT *` avoided?
- [ ] Are predicates sargable; proper indexes exist?
- [ ] Is N+1 avoided; batching used where safe?
- [ ] Are transactions sized appropriately?
- [ ] Are migrations tested forward/backward?
