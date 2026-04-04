---
description: Review Python code for PEP 8, type hints, error handling, and idiomatic patterns
---
Review the following Python code. Provide specific, actionable feedback with corrected snippets.

## Style (PEP 8)
- Indentation: 4 spaces, no tabs
- Naming: `snake_case` functions/vars, `PascalCase` classes, `ALL_CAPS` constants
- Line length: max 88 chars (Black standard)
- Blank lines: 2 between top-level defs, 1 between methods

## Type Hints
- Missing type hints on function signatures
- `Optional[T]` / `T | None` for nullable params (Python 3.10+)
- Return type annotations missing
- Untyped collections: `list` vs `list[str]`

## Error Handling
- Bare `except:` clauses → must specify exception type
- Silent exception swallowing (empty except block)
- `except Exception` at non-boundary locations
- Missing `finally` / context manager for resource cleanup

## Idiomatic Python
- `for i in range(len(x)): x[i]` → `for item in x:`
- Manual None checks replaceable with truthiness or `is None`
- Dict access with `get()` vs risky `[]` access
- List/dict comprehensions where appropriate (but not over-nested)
- f-strings over `.format()` or `%` formatting

## Architecture
- Functions doing too many things (> ~20 lines, multiple responsibilities)
- Mutable default arguments: `def fn(lst=[])` is a bug — use `None`
- Missing `__init__.py` for packages
- Circular imports

**Output format:** [CRITICAL] | [WARNING] | [SUGGESTION] — each with line reference and fix.
