---
description: Generate or review Java unit tests using JUnit 5, Mockito, and AssertJ
---

**Usage**: `/junit file="path/to/Test.java"`

## Key Principles
- **AAA Pattern**: Arrange → Act → Assert.
- **JUnit 5**: Use Jupiter API, not JUnit 4.
- **Mockito**: Use `@ExtendWith(MockitoExtension.class)` and `@Mock`/`@InjectMocks`.
- **AssertJ**: Use fluent assertions: `assertThat(result).isEqualTo(expected)`.
- **Nesting**: Use `@Nested` to group related tests.

## Structure
- One assertion focus per test.
- Descriptive names: `should<Behavior>_when<Condition>()`.
- Cover: happy path, edge cases (empty, null, max), and error paths.
- Test public behavior, not private methods.

## Assertion Style (AssertJ)
- **Equality**: `assertThat(actual).isEqualTo(expected);`
- **Exceptions**: `assertThatThrownBy(() -> action()).isInstanceOf(XxxException.class);`
- **Collections**: `assertThat(list).hasSize(3).contains(item);`

## Checklist
- [ ] Does it follow the AAA pattern?
- [ ] Are AssertJ assertions used?
- [ ] Is Mockito extension used correctly?
- [ ] Are test names descriptive and behavior-focused?
- [ ] Are edge cases (null, empty) covered?
- [ ] Are exceptions tested with `assertThatThrownBy`?

## Output
Review findings or generated complete test class.
