---
description: Review Python code for type hints, PEP 8, and best practices
---

**Usage**: `/python-review file="path/to/file.py"`

## Type Safety
- Type hints on all function signatures (PEP 484)
- 4-space indentation, 88-char line limit (Black standard)
- Specific exceptions in `except` clauses — never bare `except:`

## Resource Management
- Use `with` statement for all file I/O and database connections
- Mutable default arguments are bugs: use `None` and assign inside function

## Code Quality
- f-strings for string formatting (not `%` or `.format()`)
- Use `Protocol` for structural typing
- Guard clauses over nested `if` blocks
- No hardcoded secrets or environment-specific values

## Testing
- Test names: `test_should_<behavior>_when_<condition>`
- Cover happy path, edge cases, and error paths

## Checklist
- [ ] Are all function signatures type-hinted?
- [ ] Is 4-space indentation used?
- [ ] Are bare `except:` clauses avoided?
- [ ] Are f-strings used for formatting?
- [ ] Are default arguments immutable?
- [ ] Is the `with` statement used for I/O?

## Output
[CRITICAL] | [WARNING] | [SUGGESTION] — with file/line refs and corrected code.
