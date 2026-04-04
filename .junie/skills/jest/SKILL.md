---
name: jest
description: Generate or review TypeScript/Angular unit tests using Jest
---

# Jest Skill

Use this skill when generating or reviewing TypeScript and Angular tests. The project follows the AAA pattern and Jest testing standards.

## Key Principles
- **AAA Pattern**: Arrange → Act → Assert.
- **Mocks**: Use `jest.spyOn()` for mocks; `jest.fn()` for stubs.
- **Cleanup**: Call `jest.clearAllMocks()` in `beforeEach()`.
- **Nesting**: Use `describe()` to group related tests.
- **Behavior-focused**: One assertion focus per test.

## Guidelines

### Structure
- Use `it('should <behavior> when <condition>', () => { ... })`.
- Descriptive test names.
- Cover happy path, edge cases, and error paths.
- For Angular: Use `TestBed.configureTestingModule()` with mocked providers.

### Assertion Style (Jest)
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

## Example
```typescript
describe('UserService', () => {
  let service: UserService;
  let mockRepository: jest.Mocked<UserRepository>;

  beforeEach(() => {
    jest.clearAllMocks();
    mockRepository = {
      findById: jest.fn()
    } as any;
    service = new UserService(mockRepository);
  });

  it('should return user when id exists', async () => {
    // Arrange
    const user = { id: '1', name: 'Test' };
    mockRepository.findById.mockResolvedValue(user);

    // Act
    const result = await service.getUser('1');

    // Assert
    expect(result).toEqual(user);
    expect(mockRepository.findById).toHaveBeenCalledWith('1');
  });
});
```
