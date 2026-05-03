# Python Skill

## Key Principles
- **Type Hints**: Mandatory on all function signatures (PEP 484).
- **Formatting**: 4-space indentation, 88-char line limit (Black standard).
- **Exceptions**: Catch specific exceptions only. Never use bare `except:`.
- **Resource Management**: Use the `with` statement for all file I/O and database connections.
- **Immutability/Safety**: Mutable default arguments are forbidden. Use `None` and assign inside the function.

## Guidelines

### Code Quality
- f-strings are required for string formatting. No `%` or `.format()`.
- Use `Protocol` for structural typing where appropriate.
- Guard clauses over nested `if` blocks.
- No hardcoded secrets or environment-specific values.

### Testing
- Cover happy path, edge cases, and error paths.
- One assertion focus per test.
- Descriptive test names: `test_should_<behavior>_when_<condition>`.

## Checklist
- [ ] Are all function signatures type-hinted?
- [ ] Is 4-space indentation used?
- [ ] Are bare `except:` clauses avoided?
- [ ] Are f-strings used for formatting?
- [ ] Are default arguments immutable?
- [ ] Is the `with` statement used for I/O?
