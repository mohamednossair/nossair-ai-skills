---
name: junit
description: Generate or review Java unit tests using JUnit 5, Mockito, and AssertJ
---

# JUnit Skill

Use this skill when generating or reviewing Java unit and integration tests. The project follows the AAA pattern and uses modern AssertJ assertions.

## Key Principles
- **AAA Pattern**: Arrange → Act → Assert.
- **JUnit 5**: Use Jupiter API, not JUnit 4.
- **Mockito**: Use `@ExtendWith(MockitoExtension.class)` and `@Mock`/`@InjectMocks`.
- **AssertJ**: Use fluent assertions: `assertThat(result).isEqualTo(expected)`.
- **Nesting**: Use `@Nested` to group related tests.

## Guidelines

### Structure
- One assertion focus per test.
- Descriptive names: `should<Behavior>_when<Condition>()`.
- Cover: happy path, edge cases (empty, null, max), and error paths.
- Test public behavior, not private methods.

### Assertion Style (AssertJ)
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

## Example
```java
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {
    @Mock
    private OrderRepository repository;

    @InjectMocks
    private OrderService service;

    @Test
    void shouldReturnOrder_whenIdExists() {
        // Arrange
        Order order = new Order(1L, "TEST");
        when(repository.findById(1L)).thenReturn(Optional.of(order));

        // Act
        Optional<OrderResponse> result = service.getOrder(1L);

        // Assert
        assertThat(result).isPresent();
        assertThat(result.get().name()).isEqualTo("TEST");
    }
}
```
