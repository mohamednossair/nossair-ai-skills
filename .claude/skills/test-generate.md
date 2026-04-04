---
description: Generate JUnit (Java) or Jest (TypeScript/Angular) tests for the provided code
---
Generate comprehensive tests for the provided code. Detect the language/framework and use:
- **Java / Spring Boot** → JUnit 5 + Mockito + AssertJ
- **TypeScript / Angular** → Jest + Testing Library or Angular TestBed

## Test Requirements

**Coverage:**
- Happy path (normal expected behavior)
- Edge cases (empty input, zero, max value, boundary conditions)
- Error paths (exceptions thrown, invalid input, not-found cases)
- Each branch of conditional logic

**Structure:**
- AAA pattern: Arrange → Act → Assert
- One assertion focus per test
- Descriptive names: `should<ExpectedBehavior>_when<Condition>()`
- Group related tests with `@Nested` (JUnit) or `describe()` (Jest)

**For Java (JUnit 5 + Mockito):**
```java
@ExtendWith(MockitoExtension.class)
class XxxTest {
    @Mock DependencyClass dependency;
    @InjectMocks ServiceClass service;
    // ...
}
```
- Use `@WebMvcTest` for controllers, `@DataJpaTest` for repos
- AssertJ: `assertThat(result).isEqualTo(...)`, `assertThatThrownBy(...)`

**For TypeScript (Jest):**
```typescript
describe('ClassName', () => {
  beforeEach(() => jest.clearAllMocks());
  it('should ...', () => { /* AAA */ });
});
```
- Spy with `jest.spyOn()`, mock with `jest.fn()`
- For Angular: `TestBed.configureTestingModule(...)` with mocked providers

Generate complete, runnable test code — not pseudocode or stubs.
