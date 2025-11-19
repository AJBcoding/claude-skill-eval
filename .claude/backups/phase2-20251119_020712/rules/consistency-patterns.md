# Consistency Patterns

## Core Principle
**Follow established patterns unless there's a compelling reason to diverge.** Consistency reduces cognitive load, prevents bugs, and makes codebases maintainable.

## Pattern Matching Process

### Step 1: Check Before Creating
**Strong nudge:** Before implementing any feature, search for similar existing implementations.

Use these search strategies:
- Grep for similar function names or patterns
- Look for related files in the same directory
- Search for similar imports or dependencies
- Check for existing utilities or helpers

**Example workflow:**
```
Task: "Add authentication to new API endpoint"

Before writing:
1. Grep for existing auth patterns: "authentication", "auth", "verify"
2. Find similar endpoints to see how they handle auth
3. Look for auth middleware or utilities
4. Check if there's a standard auth decorator/wrapper
```

### Step 2: Analyze the Pattern
**Strong nudge:** When you find similar code, understand why it's structured that way.

Questions to ask:
- What problem does this pattern solve?
- What are the trade-offs of this approach?
- Are there variations for different use cases?
- What are the common pitfalls?

**Good approach:**
```
"I found 3 similar implementations. They all use the same auth middleware
pattern but with slight variations for admin vs user roles. I'll follow
this pattern for consistency."
```

**Bad approach:**
```
"I found some auth code but I'll do it my way because I prefer X approach."
```

### Step 3: Reuse vs Create Decision Tree

**Strong nudge:** Follow this decision tree before creating new patterns:

```
Can I reuse existing code exactly?
├─ Yes → Reuse it
└─ No → Is there a similar pattern?
    ├─ Yes → Can I extract a common abstraction?
    │   ├─ Yes → Create shared utility/function
    │   └─ No → Follow the pattern with necessary variations
    └─ No → Is this genuinely new?
        ├─ Yes → Create new pattern (document why)
        └─ No → Re-examine; you might have missed something
```

### When to Reuse Exactly
- The existing code solves the exact same problem
- No customization needed
- The code is well-tested and stable

### When to Follow the Pattern
- Similar problem but different parameters
- Same approach but different domain
- Established convention in the codebase

### When to Create New
- Genuinely novel problem or approach
- Existing pattern has fundamental issues
- Different technical requirements or constraints
- **Document why you're diverging**

## Consistency Domains

### 1. Naming Conventions
**Strong nudge:** Match the casing, terminology, and structure of existing names.

**Check for:**
- Function naming: `camelCase`, `snake_case`, `PascalCase`
- File naming: `kebab-case`, `snake_case`, etc.
- Variable naming: `is/has` for booleans, `get/set` for accessors
- Constants: `UPPER_SNAKE_CASE` or other conventions

**Example:**
```javascript
// Existing codebase uses:
getUserById(id)
getUserByEmail(email)
createUser(data)

// Follow the pattern:
getUserByUsername(username)  ✓
findUserByUsername(username)  ✗ (breaks pattern)
```

### 2. File Organization
**Strong nudge:** New files should follow existing directory structure and naming.

**Before creating a file, check:**
- Where do similar files live?
- What's the naming convention?
- Is there a related index or barrel file?
- Are there co-located tests?

**Example:**
```
Existing structure:
/src/services/user-service.ts
/src/services/auth-service.ts
/tests/services/user-service.test.ts

Follow the pattern:
/src/services/notification-service.ts  ✓
/tests/services/notification-service.test.ts  ✓

Don't break it:
/src/notificationService.ts  ✗
/src/services/notifications.ts  ✗ (inconsistent naming)
```

### 3. Error Handling
**Strong nudge:** Match the error handling strategy used in similar contexts.

**Check how existing code handles:**
- Exceptions vs error returns
- Error types and classes
- Logging and monitoring
- User-facing error messages

**Example:**
```python
# Existing pattern in the codebase:
def get_user(user_id):
    try:
        user = db.query(User).get(user_id)
        if not user:
            raise NotFoundError(f"User {user_id} not found")
        return user
    except DBError as e:
        logger.error(f"Database error: {e}")
        raise ServiceError("Failed to fetch user")

# Follow this pattern for consistency:
def get_order(order_id):
    try:
        order = db.query(Order).get(order_id)
        if not order:
            raise NotFoundError(f"Order {order_id} not found")
        return order
    except DBError as e:
        logger.error(f"Database error: {e}")
        raise ServiceError("Failed to fetch order")
```

### 4. Import Organization
**Strong nudge:** Follow the import ordering and grouping used in similar files.

**Common patterns:**
- Standard library first, then third-party, then local
- Alphabetical within groups
- Absolute vs relative imports
- Grouped by functionality

### 5. Testing Patterns
**Strong nudge:** Match the testing style, structure, and coverage of similar tests.

**Check existing tests for:**
- Test framework and assertion style
- Mocking and fixture patterns
- Test organization (describe/it, test classes, etc.)
- Naming conventions for test cases

## Recognizing Patterns

### Code Smells That Indicate Pattern Deviation

1. **Unique snowflake:** "This is the only file that does X this way"
2. **Inconsistent naming:** Similar functions with different naming styles
3. **Duplicate logic:** Same thing implemented multiple ways
4. **Import chaos:** Different import styles across similar files
5. **Test gaps:** New code without tests when everything else has them

### Questions to Ask

**Before implementing:**
- "Have I searched for similar implementations?"
- "Do I understand why the existing pattern works this way?"
- "Am I creating unnecessary variation?"

**During implementation:**
- "Am I following the same structure as similar code?"
- "Would another developer expect to find this here?"
- "Am I using the same terminology and naming?"

**After implementation:**
- "Does this fit naturally with the rest of the codebase?"
- "Could someone find and understand this easily?"
- "Have I documented any intentional deviations?"

## Examples of Consistent Implementation

### Example 1: API Endpoints

```typescript
// Existing patterns in codebase:
router.get('/users/:id', authenticate, userController.getById);
router.post('/users', authenticate, validate(userSchema), userController.create);
router.put('/users/:id', authenticate, validate(userSchema), userController.update);

// Consistent new endpoint:
router.get('/orders/:id', authenticate, orderController.getById);  ✓

// Inconsistent approaches:
router.get('/order/:id', orderController.getById);  ✗ (missing auth)
router.get('/orders/:id', async (req, res) => { ... });  ✗ (inline handler)
```

### Example 2: Configuration

```python
# Existing config pattern:
DATABASE_URL = os.getenv('DATABASE_URL', 'postgresql://localhost/db')
REDIS_URL = os.getenv('REDIS_URL', 'redis://localhost:6379')
API_KEY = os.getenv('API_KEY') or raise_config_error('API_KEY required')

# Consistent new config:
SMTP_HOST = os.getenv('SMTP_HOST', 'localhost')  ✓
SMTP_PORT = int(os.getenv('SMTP_PORT', '587'))  ✓

# Inconsistent:
smtp_config = {
    'host': os.environ.get('SMTP_HOST', 'localhost')  ✗ (different style)
}
```

### Example 3: React Components

```jsx
// Existing component pattern:
import React from 'react';
import { useQuery } from '@tanstack/react-query';
import { LoadingSpinner } from './LoadingSpinner';
import { ErrorMessage } from './ErrorMessage';

export function UserList() {
  const { data, isLoading, error } = useQuery(['users'], fetchUsers);

  if (isLoading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;

  return <div>{/* render data */}</div>;
}

// Consistent new component:
export function OrderList() {
  const { data, isLoading, error } = useQuery(['orders'], fetchOrders);

  if (isLoading) return <LoadingSpinner />;
  if (error) return <ErrorMessage error={error} />;

  return <div>{/* render data */}</div>;
}  ✓
```

## When Patterns Conflict

**Strong nudge:** If you find inconsistent patterns in the codebase:

1. **Identify which is more common** - Follow the majority pattern
2. **Check recency** - Newer patterns might reflect evolution
3. **Ask about context** - Different patterns for different contexts is valid
4. **Document your choice** - Explain why you chose one over the other

## Pattern Evolution

**Acceptable reasons to evolve a pattern:**
- Security improvement
- Performance optimization
- Bug fix in the pattern itself
- New best practice or framework update
- Accessibility or UX improvement

**When evolving:**
- Document why the old pattern is insufficient
- Consider updating existing uses
- Make the new pattern obvious and discoverable
- Update any pattern documentation or examples

## Quick Reference Checklist

Before implementing, ask:
- [ ] Did I search for similar implementations?
- [ ] Do I understand the existing pattern?
- [ ] Am I following naming conventions?
- [ ] Does my file organization match?
- [ ] Is my error handling consistent?
- [ ] Are my imports organized like similar files?
- [ ] Do my tests match the existing style?
- [ ] If I'm diverging, have I documented why?

**Remember:** Consistency is a feature, not a constraint. It makes codebases learnable, predictable, and maintainable.
