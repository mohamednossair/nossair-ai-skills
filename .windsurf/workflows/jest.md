---
description: Generate or review TypeScript/Angular unit tests using Jest
---

**Usage**: `/jest file="path/to/file.spec.ts"`

## Key Principles
- **AAA Pattern**: Arrange → Act → Assert.
- **Mocks**: Use `jest.spyOn()` for mocks; `jest.fn()` for stubs.
- **Cleanup**: Call `jest.clearAllMocks()` in `beforeEach()`.
- **Nesting**: Use `describe()` to group related tests.
- **Behavior-focused**: One assertion focus per test.

## Structure
- Use `it('should <behavior> when <condition>', () => { ... })`.
- Descriptive test names.
- Cover happy path, edge cases, and error paths.
- For Angular: Use `TestBed.configureTestingModule()` with mocked providers.

## Assertion Style (Jest)
- **Equality**: `expect(actual).toBe(expected);` or `toEqual(expected);` for objects.
- **Calls**: `expect(spy).toHaveBeenCalledWith(...);`
- **Exceptions**: `expect(() => action()).toThrow(...);`

## Checklist
- [ ] Does it follow the AAA pattern?
- [ ] Is `jest.clearAllMocks()` used in `beforeEach()`?
- [ ] Are test names descriptive?
- [ ] Are spy/mock implementations cleared/reset?
- [ ] Are edge cases covered?
- [ ] Is there one clear focus per test?

## Output
Review findings or generated complete test file.
