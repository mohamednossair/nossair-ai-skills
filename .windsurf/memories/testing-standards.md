# Testing Standards

## Pattern: AAA
Every test: **Arrange** (setup) → **Act** (call the unit) → **Assert** (verify result)

## Test Naming
- `should<ExpectedBehavior>_when<Condition>()`
- Descriptive enough to understand failure without reading the body

## JUnit 5 (Java 21+)
```java
@ExtendWith(MockitoExtension.class)
class ServiceTest {
    @Mock DependencyClass dep;
    @InjectMocks ServiceClass service;
}
```
- AssertJ assertions: `assertThat(result).isEqualTo(...)`, `assertThatThrownBy(...)`
- `@WebMvcTest` for controllers (mocked service layer)
- `@DataJpaTest` for repositories (in-memory H2 or Testcontainers)
- `@SpringBootTest` for full integration tests only
- **Testcontainers** for real Oracle/MySQL testing in Docker
- `@Sql("/test-data.sql")` for consistent test data setup

## Jest (TypeScript / Angular 20+)
```typescript
beforeEach(() => jest.clearAllMocks());
jest.spyOn(service, 'method').mockReturnValue(value);
```
- Angular: `TestBed.configureTestingModule()` with stub providers
- Type mocked services: `jest.Mocked<ServiceClass>`
- For signal-based components: set input signals, verify computed outputs

## Testing Boundaries
- Test **public behavior** — not private methods directly
- If a private method needs its own test, it's a sign to extract it to its own class
- Test through the public API; verify observable behavior and side effects

## Coverage Targets
- 80%+ line coverage overall
- 100% on critical business logic and edge cases
- Cover: happy path + edge cases + error/exception paths

## Anti-Patterns (avoid)
- Tests that only cover the happy path
- Mocking so much that the test doesn't test real logic
- `expect(true).toBe(true)` / `assertEquals(1, 1)` placeholder assertions
- Tests that need their own tests to understand
