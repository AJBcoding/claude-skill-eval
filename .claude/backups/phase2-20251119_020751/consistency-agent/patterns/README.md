# Consistency Agent Patterns

This directory contains reference patterns for common implementation tasks. These patterns serve as templates to ensure consistency across similar implementations in the codebase.

## Purpose

Pattern templates help the consistency agent:

1. **Detect Similar Tasks**: Quickly identify what type of implementation is being requested
2. **Suggest Reuse**: Recommend following established patterns
3. **Maintain Consistency**: Ensure similar code follows the same structure
4. **Onboard Developers**: Provide clear examples of project conventions
5. **Document Decisions**: Capture architectural decisions and best practices

## How to Use These Patterns

### For the Consistency Agent

When activated, the consistency agent should:

1. **Classify the task** using these pattern categories
2. **Search for existing implementations** in the codebase
3. **Compare found code** against the pattern template
4. **Suggest the pattern** if matches are found
5. **Reference this documentation** when explaining the pattern

### For Developers

When implementing new features:

1. **Check for similar implementations** first
2. **Reference the appropriate pattern** for structure guidance
3. **Follow the established conventions** unless there's a compelling reason to diverge
4. **Document deviations** when they occur
5. **Update patterns** when new best practices emerge

## Available Patterns

### Backend Patterns

#### 1. API Endpoint Pattern
**File**: `api-endpoint-pattern.md`

**Use When**:
- Creating REST API endpoints
- Adding routes to Express/Fastify
- Implementing CRUD operations

**Key Elements**:
- Middleware chain (auth, validation, handler)
- Standard response format
- Error handling
- Request validation
- Testing structure

**Example Use Cases**:
- `POST /api/users` - Create user
- `GET /api/orders/:id` - Get order
- `PATCH /api/products/:id` - Update product

---

#### 2. Error Handling Pattern
**File**: `error-handling-pattern.md`

**Use When**:
- Throwing and catching exceptions
- Validating input
- Handling external API failures
- Database errors

**Key Elements**:
- Error class hierarchy
- Error codes and status codes
- Logging strategy
- User-friendly messages
- Error middleware

**Example Use Cases**:
- Validation errors (400)
- Not found errors (404)
- Conflict errors (409)
- Internal errors (500)

---

#### 3. Database Model Pattern
**File**: `database-model-pattern.md`

**Use When**:
- Creating database tables
- Defining ORM models
- Setting up relationships
- Writing migrations

**Key Elements**:
- Field definitions and types
- Validations and constraints
- Relationships (one-to-many, many-to-many)
- Indexes for performance
- Timestamps and soft delete
- Instance and class methods

**Example Use Cases**:
- User model with authentication
- Order model with relationships
- Product model with categories
- Invoice model with line items

---

### Frontend Patterns

#### 4. React Component Pattern
**File**: `react-component-pattern.md`

**Use When**:
- Creating React functional components
- Building reusable UI elements
- Implementing feature components
- Developing page components

**Key Elements**:
- TypeScript props interface
- React.memo for optimization
- Hook organization
- Styled components
- Error states and loading
- Testing structure

**Example Use Cases**:
- `UserCard` - Display component
- `UserForm` - Form component
- `UserList` - Data fetching component
- `UserProfile` - Page component

---

## Pattern Categories

### By Technology

- **Node.js/TypeScript**: API Endpoint, Error Handling, Database Model (Sequelize)
- **Python**: Error Handling, Database Model (SQLAlchemy)
- **React**: React Component
- **GraphQL**: (TODO: Add graphql-resolver-pattern.md)
- **Testing**: (TODO: Add test-pattern.md)

### By Layer

- **Presentation Layer**: React Component
- **Application Layer**: API Endpoint
- **Domain Layer**: Error Handling
- **Data Layer**: Database Model

### By Concern

- **Data Management**: Database Model
- **Error Management**: Error Handling
- **User Interface**: React Component
- **API Design**: API Endpoint

## Adding New Patterns

When you discover a new pattern worth documenting:

### Step 1: Identify the Pattern

Ask yourself:
- Is this pattern used 3+ times in the codebase?
- Does it solve a common problem?
- Would new developers benefit from this template?
- Does it represent a project convention?

### Step 2: Create Pattern File

Use this template structure:

```markdown
# [Pattern Name]

## Purpose
[What problem does this pattern solve?]

## When to Use
- [Use case 1]
- [Use case 2]

## When NOT to Use
- [Anti-pattern 1]
- [Anti-pattern 2]

## Structure
[Code template with comments]

## Key Elements
1. **[Element 1]**: [Description]
2. **[Element 2]**: [Description]

## Example Implementation
[Complete working example]

## Testing Pattern
[How to test this pattern]

## Common Variations
### Variation 1: [Name]
[When and how]

## Related Patterns
- [Pattern 1]: [Relationship]

## Common Pitfalls
1. [Pitfall 1]
2. [Pitfall 2]

## References
- [Link 1]
- [Link 2]

## Version History
- v1.0.0 (YYYY-MM-DD): Initial pattern
```

### Step 3: Update This README

Add the new pattern to the appropriate section above.

### Step 4: Reference in Codebase

Consider adding comments in the codebase pointing to the pattern:

```typescript
// Follows API Endpoint Pattern
// See: .claude/agents/consistency-agent/patterns/api-endpoint-pattern.md
router.post('/users', authenticate, validate(userSchema), async (req, res) => {
  // ...
});
```

## Pattern Evolution

Patterns should evolve as the codebase and best practices evolve:

### When to Update a Pattern

- **Bug Fix**: Pattern has a known issue or security vulnerability
- **Performance**: Better performing approach discovered
- **Framework Update**: New framework version with better patterns
- **Team Decision**: Architectural decision to change approach

### How to Update a Pattern

1. **Document the change** in the pattern's Version History section
2. **Explain why** the pattern changed
3. **Update examples** to reflect new pattern
4. **Consider migration** of existing code to new pattern
5. **Announce to team** so everyone is aware

### Deprecating a Pattern

If a pattern is no longer recommended:

1. Add **[DEPRECATED]** to the pattern title
2. Explain **why** it's deprecated
3. Link to the **replacement pattern**
4. Keep the file for historical reference

Example:
```markdown
# [DEPRECATED] Old Authentication Pattern

**This pattern is deprecated as of 2025-11-20.**

**Reason**: Security vulnerability in token validation

**Use instead**: [New Authentication Pattern](./new-auth-pattern.md)
```

## Pattern Metrics

Track pattern usage to understand their effectiveness:

### Usage Tracking

- How many times is this pattern referenced?
- How many implementations follow this pattern?
- How often does the consistency agent suggest this pattern?
- How often do developers accept the suggestion?

### Quality Indicators

- **High Quality Pattern**:
  - Used 10+ times in codebase
  - High developer acceptance rate (>80%)
  - No reported issues or confusion
  - Clear and actionable documentation

- **Needs Improvement**:
  - Low acceptance rate (<50%)
  - Frequent questions or confusion
  - Multiple deviations from pattern
  - Unclear documentation

## Quick Reference

| Pattern | Primary Use | Language/Framework | File |
|---------|-------------|-------------------|------|
| API Endpoint | REST endpoints | Node.js/Express | [api-endpoint-pattern.md](./api-endpoint-pattern.md) |
| Error Handling | Exception management | Node.js/Python | [error-handling-pattern.md](./error-handling-pattern.md) |
| Database Model | ORM models | Sequelize/SQLAlchemy | [database-model-pattern.md](./database-model-pattern.md) |
| React Component | UI components | React/TypeScript | [react-component-pattern.md](./react-component-pattern.md) |

## Contributing

To contribute new patterns or improvements:

1. Create the pattern file following the template
2. Add it to this README
3. Test it with the consistency agent
4. Submit for team review
5. Get approval before merging

## Support

If you have questions about patterns:

1. Check the pattern documentation first
2. Look for similar implementations in the codebase
3. Ask the consistency agent for guidance
4. Consult with the team

## Version History

- v1.0.0 (2025-11-19): Initial pattern library with 4 core patterns
  - API Endpoint Pattern
  - Error Handling Pattern
  - Database Model Pattern
  - React Component Pattern
