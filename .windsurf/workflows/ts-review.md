---
description: Review TypeScript code for type safety, strict mode, and best practices
---

**Usage**: `/ts-review file="path/to/file.ts"`

## Type Safety
- `any` usage → replace with proper types or `unknown`
- Missing return types on public functions
- Unsafe type assertions (`as Type`) without guards
- `null` / `undefined` not handled (optional chaining, nullish coalescing)

## Strict Mode
- `strict: true` in `tsconfig.json` — no exceptions
- No implicit `any`; generics where needed
- Exhaustive switch on unions

## Code Quality
- `interface` for shapes, `type` for unions/intersections
- `const enum` or `as const` objects instead of mutable enums
- Async functions that never `await` anything
- Missing `readonly` on properties that don't change
- Named exports preferred over default exports

## Output
[CRITICAL] | [WARNING] | [SUGGESTION] — with file/line refs and corrected code.
