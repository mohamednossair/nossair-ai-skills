# Database, Git & Maven Standards

## SQL (General)
- Always parameterize queries; avoid string concatenation (prevent SQL injection)
- Design indexes for predicates and join columns; validate with EXPLAIN
- Limit SELECT lists; avoid `SELECT *` in production code
- Use migrations and idempotent DDL patterns
- Transactions sized appropriately; avoid long-running locks
- N+1 avoided; batching used where safe

## Oracle
- Use sequences/identity correctly; return generated keys safely
- Analyze execution plans; monitor cardinality and joins
- Be mindful of row-level locking and isolation behavior
- Bind variables always; avoid hard parsing
- Index usage confirmed with EXPLAIN PLAN
- Lock contention assessed for hot paths

## MySQL
- Default to InnoDB engine; utf8mb4 charset for full Unicode
- Composite indexes ordered by selectivity and usage
- Understand transaction isolation and gap locks
- Proper collations; no implicit truncations
- Slow queries profiled with EXPLAIN/ANALYZE
- Safe autoincrement usage and batching; HikariCP for connection pooling

## Git Workflow
- Branch types: `feature/`, `bugfix/`, `docs/`, `chore/`
- Conventional Commits: `type(scope): description` — imperative mood, max 72 chars
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`
- Small, logical, atomic changesets
- Rebase for clean history unless policy dictates merge
- PR checklist: clear description, scoped changes, CI green, reviewers assigned
- Include Jira/Bitbucket issue ID in branch name when clearly available

## Maven
- Use BOMs to align versions; prefer `dependencyManagement`
- Correct scopes: compile, provided, runtime, test
- Reproducible builds: plugin versions pinned; enforcer rules
- No version drift; dependency convergence checked
- Profiles documented and minimal
