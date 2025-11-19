# Quality Standards

## Core Principle
**Ship code that works correctly, handles errors gracefully, and can be maintained by others.** Quality is not perfection; it's appropriate rigor for the context.

## Code Quality Checks

### 1. Error Handling
**Strong nudge:** Every code path should handle errors appropriately for its context.

#### What to Check:
- **Null/undefined values:** Can any variable be null? Handle it.
- **API failures:** Network calls can fail. What happens then?
- **File operations:** Files might not exist, be locked, or have wrong permissions
- **Parse errors:** JSON, XML, CSV parsing can fail on malformed data
- **Type mismatches:** Especially in dynamically typed languages

#### Error Handling Levels:

**Critical path (user-facing features):**
```python
# Strong error handling required
try:
    result = process_payment(amount, card)
    if not result.success:
        logger.error(f"Payment failed: {result.error}")
        return {"error": "Payment processing failed", "code": "PAYMENT_ERROR"}
except PaymentGatewayError as e:
    logger.error(f"Gateway error: {e}", exc_info=True)
    return {"error": "Service temporarily unavailable", "code": "SERVICE_ERROR"}
except Exception as e:
    logger.critical(f"Unexpected error: {e}", exc_info=True)
    return {"error": "An unexpected error occurred", "code": "INTERNAL_ERROR"}
```

**Internal utilities:**
```python
# Appropriate error handling
def calculate_tax(amount, rate):
    if amount < 0:
        raise ValueError("Amount cannot be negative")
    if not 0 <= rate <= 1:
        raise ValueError("Rate must be between 0 and 1")
    return amount * rate
```

**Scripts and tools:**
```python
# Fail fast is often appropriate
data = json.loads(file_content)  # Let it raise if invalid
process(data)  # Script will exit on error
```

#### Anti-Patterns to Avoid:

**Silent failures:**
```python
try:
    result = important_operation()
except:
    pass  # ✗ Error disappeared, no one knows
```

**Generic error swallowing:**
```python
try:
    everything()
except Exception:
    return None  # ✗ What failed? Why?
```

**Exception as control flow:**
```python
try:
    user = get_user(id)
except NotFound:
    user = create_user(id)  # ✗ Use explicit checks instead
```

### 2. Edge Cases
**Strong nudge:** Think through boundary conditions before running code.

#### Common Edge Cases by Type:

**Collections (arrays, lists, sets):**
- Empty collection
- Single item
- Very large collection (performance)
- Duplicate items
- Null/undefined items within collection

**Numbers:**
- Zero
- Negative numbers
- Very large numbers (overflow)
- Very small numbers (underflow)
- Infinity, NaN
- Floating point precision

**Strings:**
- Empty string
- Very long string
- Special characters
- Unicode/emoji
- Null vs empty string
- Whitespace-only strings

**Dates/Times:**
- Timezone differences
- Daylight saving time transitions
- Leap years/seconds
- Far past or future dates
- Invalid date formats

**User Input:**
- Missing required fields
- Unexpected types
- Malicious input (SQL injection, XSS)
- Very long input
- International characters

#### Edge Case Checklist:

Before implementing, ask:
- [ ] What if the input is empty?
- [ ] What if the input is null/undefined?
- [ ] What if the input is very large?
- [ ] What if the input has special characters?
- [ ] What if the operation fails midway?
- [ ] What if this is called concurrently?
- [ ] What if dependencies are unavailable?

### 3. Input Validation
**Strong nudge:** Validate inputs at boundaries (API endpoints, public functions).

**Good validation:**
```typescript
function updateUser(userId: string, data: UpdateUserData) {
  // Validate inputs
  if (!userId || typeof userId !== 'string') {
    throw new ValidationError('Valid userId required');
  }

  if (!data || typeof data !== 'object') {
    throw new ValidationError('Valid data object required');
  }

  // Validate specific fields
  if (data.email && !isValidEmail(data.email)) {
    throw new ValidationError('Invalid email format');
  }

  if (data.age !== undefined && (data.age < 0 || data.age > 150)) {
    throw new ValidationError('Age must be between 0 and 150');
  }

  // Proceed with validated data
  return repository.update(userId, data);
}
```

**Use validation libraries:**
```typescript
import { z } from 'zod';

const userSchema = z.object({
  email: z.string().email(),
  age: z.number().min(0).max(150),
  name: z.string().min(1).max(100)
});

function updateUser(userId: string, data: unknown) {
  const validated = userSchema.parse(data); // Throws on invalid
  return repository.update(userId, validated);
}
```

### 4. Type Safety
**Strong nudge:** Use types to catch errors at compile time, not runtime.

**TypeScript/Python:**
```typescript
// Good: Types prevent errors
interface User {
  id: string;
  email: string;
  age: number;
}

function getUser(id: string): User | null {
  // Return type is clear
}

// Bad: Any defeats the purpose
function getUser(id: any): any {
  // No type safety
}
```

**Use narrow types:**
```typescript
// Better than string
type UserId = string & { readonly __brand: 'UserId' };
type OrderId = string & { readonly __brand: 'OrderId' };

// Now userId and orderId are not interchangeable
```

## Documentation Requirements

### When to Document

**Strong nudge:** Document when code isn't self-explanatory.

**Always document:**
- Public APIs and interfaces
- Complex algorithms or business logic
- Non-obvious workarounds or hacks
- Security considerations
- Performance trade-offs
- Configuration and setup

**Often document:**
- Function parameters and return values
- Expected errors and edge cases
- Usage examples for complex functions
- Dependencies and prerequisites

**Rarely document:**
- Obvious code that matches naming
- Simple getters/setters
- Standard patterns

### What to Document

**Good documentation:**
```python
def calculate_shipping_cost(weight_kg: float, distance_km: float, priority: str) -> float:
    """
    Calculate shipping cost based on weight, distance, and priority level.

    Uses tiered pricing: base rate + weight charge + distance charge + priority fee.
    Base rate is $5, weight is $0.50/kg, distance is $0.10/km.

    Args:
        weight_kg: Package weight in kilograms (must be positive)
        distance_km: Shipping distance in kilometers (must be positive)
        priority: Priority level ('standard', 'express', 'overnight')

    Returns:
        Total shipping cost in dollars

    Raises:
        ValueError: If weight or distance is negative, or priority is invalid

    Example:
        >>> calculate_shipping_cost(2.5, 100, 'express')
        25.50
    """
```

**What makes it good:**
- Explains the "why" and "how", not just "what"
- Documents parameters, return value, and exceptions
- Includes example usage
- Notes important constraints

### Documentation Anti-Patterns

**Obvious comments:**
```python
# Increment counter by 1
counter += 1  # ✗ Comment adds no value
```

**Outdated comments:**
```python
# Returns user email
def get_user_profile(id):  # ✗ Comment doesn't match function
    return {"name": ..., "avatar": ...}
```

**Code that needs comments to understand:**
```python
# Get all active users who logged in within the last 30 days
# and have verified emails but exclude admins
users = [u for u in db.users if u.active and u.last_login >
         datetime.now() - timedelta(days=30) and u.verified and
         not u.is_admin]  # ✗ Extract to well-named function instead
```

## Test Coverage Expectations

### When to Write Tests

**Strong nudge:** Write tests for code that will be maintained or reused.

**High priority for testing:**
- Business logic and core functionality
- Public APIs and interfaces
- Data transformations
- Security-critical code
- Bug fixes (regression tests)

**Medium priority:**
- Utilities and helpers
- Data validation
- Error handling paths

**Lower priority:**
- Simple getters/setters
- Configuration files
- One-off scripts
- Prototype code

### Test Coverage Guidelines

**Strong nudge:** Aim for meaningful coverage, not just high percentages.

**What to test:**
```python
def divide(a: float, b: float) -> float:
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b

# Tests should cover:
# 1. Happy path: normal division
# 2. Edge case: division by zero
# 3. Edge case: negative numbers
# 4. Edge case: very small divisor (precision)

def test_divide():
    assert divide(10, 2) == 5  # Happy path
    assert divide(10, 3) == pytest.approx(3.333, rel=1e-3)  # Precision
    assert divide(-10, 2) == -5  # Negative

    with pytest.raises(ValueError):
        divide(10, 0)  # Error case
```

**Test organization:**
- One test file per source file (or logical grouping)
- Clear test names that describe what's being tested
- Arrange-Act-Assert pattern
- Independent tests (no shared state)

### Testing Anti-Patterns

**Tests that don't test:**
```python
def test_user_creation():
    create_user("test@example.com")
    # ✗ No assertions, doesn't verify anything
```

**Brittle tests:**
```python
def test_get_users():
    users = get_all_users()
    assert len(users) == 5  # ✗ Breaks when data changes
```

**Testing implementation details:**
```python
def test_process():
    processor = Processor()
    processor.process(data)
    assert processor._internal_state == "processed"  # ✗ Tests internals
```

## Performance Considerations

### When to Optimize

**Strong nudge:** Optimize when there's a real problem, not a hypothetical one.

**Optimize when:**
- Profiling shows actual bottleneck
- User-facing operations are noticeably slow
- Resource usage is excessive (memory, CPU, bandwidth)
- Scale testing reveals issues

**Don't optimize when:**
- It's a micro-optimization with no measurable impact
- It sacrifices readability for minimal gain
- It's premature (no evidence of problem)

### Performance Checklist

**Before optimizing:**
- [ ] Have I measured the current performance?
- [ ] Do I know what's actually slow?
- [ ] Is this performance issue user-facing?
- [ ] Have I considered simpler solutions first?

**Common performance issues:**
- N+1 queries (database)
- Loading too much data
- Inefficient algorithms (O(n²) when O(n log n) exists)
- Unnecessary re-rendering (UI)
- Blocking operations on main thread
- Memory leaks

**Good performance practice:**
```python
# Bad: N+1 queries
users = User.query.all()
for user in users:
    user.orders  # Separate query for each user

# Good: Eager loading
users = User.query.options(joinedload(User.orders)).all()
for user in users:
    user.orders  # Already loaded
```

## Security Considerations

### Security Checklist

**Strong nudge:** Think about security for user-facing and data-handling code.

**Before deploying code, check:**
- [ ] Are user inputs validated and sanitized?
- [ ] Is sensitive data encrypted at rest and in transit?
- [ ] Are secrets kept out of code/version control?
- [ ] Is authentication/authorization properly enforced?
- [ ] Are SQL queries parameterized (no string concatenation)?
- [ ] Is output properly escaped (prevent XSS)?
- [ ] Are rate limits implemented where needed?
- [ ] Is error handling secure (no sensitive data in errors)?

### Common Security Issues

**SQL Injection:**
```python
# Bad:
query = f"SELECT * FROM users WHERE email = '{email}'"  # ✗

# Good:
query = "SELECT * FROM users WHERE email = ?"
cursor.execute(query, (email,))  # ✓
```

**XSS:**
```javascript
// Bad:
element.innerHTML = userInput;  // ✗

// Good:
element.textContent = userInput;  // ✓
// Or use proper escaping/sanitization
```

**Secrets in code:**
```python
# Bad:
API_KEY = "sk_live_abc123..."  # ✗

# Good:
API_KEY = os.getenv('API_KEY')  # ✓
if not API_KEY:
    raise ConfigError("API_KEY not set")
```

## Context-Appropriate Quality

**Strong nudge:** Match quality level to context.

### Production Code
- Comprehensive error handling
- Full input validation
- Test coverage
- Documentation
- Security review
- Performance consideration

### Internal Tools
- Essential error handling
- Basic validation
- Key functionality tested
- Minimal documentation
- Standard security

### Prototypes/Experiments
- Fail-fast error handling
- Minimal validation
- Optional tests
- Comments for clarity
- Note security TODOs

### Scripts
- Print errors clearly
- Validate critical inputs
- Document usage
- Note if not production-ready

## Quality Checklist

Before considering code complete:

**Functionality:**
- [ ] Does it solve the intended problem?
- [ ] Have I tested the happy path?
- [ ] Have I tested error cases?
- [ ] Have I considered edge cases?

**Code Quality:**
- [ ] Is error handling appropriate for context?
- [ ] Are inputs validated at boundaries?
- [ ] Is the code reasonably efficient?
- [ ] Does it follow codebase patterns?

**Documentation:**
- [ ] Are complex parts documented?
- [ ] Are public APIs documented?
- [ ] Are there usage examples if needed?

**Testing:**
- [ ] Are there tests for core functionality?
- [ ] Are there tests for edge cases?
- [ ] Do tests actually verify behavior?

**Security:**
- [ ] Are user inputs sanitized?
- [ ] Are secrets properly managed?
- [ ] Is authentication/authorization correct?

**Remember:** Perfect is the enemy of good. Aim for appropriate quality, not absolute perfection.
