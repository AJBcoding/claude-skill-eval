# Consistency Agent Test Scenarios

## Overview

This document defines test scenarios for validating the consistency agent's ability to detect existing patterns and suggest reuse. These tests ensure the agent correctly identifies similar implementations and provides actionable recommendations.

## Test Environment Setup

### Prerequisites

1. **Mock Codebase**: Create test directory with sample implementations
2. **Pattern Templates**: Ensure pattern files exist in `patterns/` directory
3. **Agent Configuration**: Verify agent.yml is properly configured
4. **Tools Available**: Read, Grep, Glob tools must be accessible

### Test Directory Structure

```
test-codebase/
├── api/
│   ├── routes/
│   │   ├── users.js          # Existing pattern
│   │   ├── products.js       # Existing pattern
│   │   └── orders.js         # Existing pattern
│   └── middleware/
│       ├── authenticate.js
│       └── validate.js
├── models/
│   ├── User.js              # Existing pattern
│   ├── Product.js           # Existing pattern
│   └── Order.js             # Existing pattern
└── components/
    ├── UserCard.tsx         # Existing pattern
    ├── ProductCard.tsx      # Existing pattern
    └── LoadingSpinner.tsx
```

---

## Test Scenario 1: Detect API Endpoint Pattern

### Scenario Description

User requests to add a new POST endpoint for creating categories. The consistency agent should detect existing POST endpoint patterns and suggest following the same structure.

### Setup

Existing codebase has:
- `routes/users.js` with POST /users endpoint
- `routes/products.js` with POST /products endpoint
- Both follow same pattern: authenticate → validate → handler

### User Request

```
"Add a POST endpoint for creating categories at /api/categories"
```

### Expected Agent Behavior

1. **Activation**: Detect keyword "Add" and classify as API endpoint creation
2. **Search Strategy**:
   - Glob: `**/routes/**/*.js`
   - Grep: `router.post|app.post` in routes
   - Read: Top 2-3 matching files
3. **Pattern Analysis**:
   - Identify common structure in users.js and products.js
   - Extract middleware chain pattern
   - Note standard error handling approach
   - Recognize response format consistency
4. **Recommendation**:
   ```markdown
   ## Pattern Analysis Results

   **Task**: Add POST endpoint for creating categories
   **Classification**: API Endpoint

   ### Existing Patterns Found

   I found 2 similar POST endpoints:

   1. **routes/users.js** (Confidence: High)
      - Pattern: POST with authenticate + validate + async handler
      - Key characteristics:
        * Authentication middleware first
        * Joi validation middleware
        * Async handler with try/catch
        * Transaction wrapper for DB operations
        * Standard JSON response format

   2. **routes/products.js** (Confidence: High)
      - Pattern: Same structure as users endpoint
      - Validates this is the established pattern

   ### Common Pattern Identified

   All POST endpoints follow this structure:
   - Authentication middleware (authenticate)
   - Validation middleware (validate(schema))
   - Async handler with error handling
   - Database transaction wrapper
   - Standard response: { success: true, data: {...} }

   ### Recommendation

   **Option 2: Pattern Following** (RECOMMENDED)

   Follow the structure from routes/users.js:
   - Use same middleware chain
   - Create categorySchema for validation
   - Use transaction wrapper
   - Match response format

   Would you like me to proceed with this pattern?
   ```

### Success Criteria

- [ ] Agent activates on "Add" keyword
- [ ] Searches routes directory correctly
- [ ] Identifies 2+ similar endpoints
- [ ] Extracts common pattern elements
- [ ] Recommends following the pattern
- [ ] Provides concrete next steps
- [ ] Response time < 15 seconds
- [ ] Token usage < 5K tokens

---

## Test Scenario 2: Detect React Component Pattern

### Scenario Description

User requests to create a CategoryCard component. The consistency agent should detect existing Card components and suggest following the same structure.

### Setup

Existing codebase has:
- `components/UserCard.tsx` with TypeScript, styled-components, React.memo
- `components/ProductCard.tsx` with same structure
- Both use similar prop patterns and styling approach

### User Request

```
"Create a CategoryCard component to display category information"
```

### Expected Agent Behavior

1. **Activation**: Detect keyword "Create" and "component"
2. **Search Strategy**:
   - Glob: `**/components/**/*Card*.{tsx,jsx}`
   - Grep: `export.*Card|function.*Card` in components
   - Read: UserCard.tsx and ProductCard.tsx
3. **Pattern Analysis**:
   - TypeScript props interface
   - Functional component with React.memo
   - Styled-components for styling
   - Optional onClick handler
   - Display name for debugging
4. **Recommendation**:
   ```markdown
   ## Pattern Analysis Results

   **Task**: Create CategoryCard component
   **Classification**: React Component

   ### Existing Patterns Found

   I found 2 similar Card components:

   1. **components/UserCard.tsx** (Confidence: High)
      - Pattern: Functional component with TypeScript
      - Key characteristics:
        * Props interface with optional onClick
        * React.memo wrapper for optimization
        * Styled-components for styling
        * Display name set
        * Card layout with image and info sections

   2. **components/ProductCard.tsx** (Confidence: High)
      - Pattern: Identical structure to UserCard
      - Confirms this is the project standard

   ### Common Pattern Identified

   All Card components follow:
   - TypeScript props interface (data object + optional onClick)
   - React.FC with React.memo wrapper
   - Styled-components defined below component
   - Display name for debugging
   - Clickable card with hover effect

   ### Recommendation

   **Option 2: Pattern Following** (RECOMMENDED)

   Follow the structure from UserCard.tsx:

   ```typescript
   interface CategoryCardProps {
     category: Category;
     onClick?: (categoryId: string) => void;
   }

   export const CategoryCard: React.FC<CategoryCardProps> = React.memo(
     ({ category, onClick }) => {
       // Component implementation
     }
   );

   CategoryCard.displayName = 'CategoryCard';
   ```

   Would you like me to generate the complete component following this pattern?
   ```

### Success Criteria

- [ ] Agent activates on "Create" + "component"
- [ ] Searches components directory correctly
- [ ] Identifies 2 Card components
- [ ] Extracts React/TypeScript pattern
- [ ] Recommends following the pattern
- [ ] Provides code skeleton
- [ ] Matches existing naming conventions

---

## Test Scenario 3: Detect Database Model Pattern

### Scenario Description

User requests to create a Category model. Agent should detect existing Sequelize models and suggest following the same structure.

### Setup

Existing codebase has:
- `models/User.js` with Sequelize model
- `models/Product.js` with Sequelize model
- Both have timestamps, soft delete, validations, indexes

### User Request

```
"Implement a Category model with name and description fields"
```

### Expected Agent Behavior

1. **Activation**: Detect keyword "Implement" and "model"
2. **Search Strategy**:
   - Glob: `**/models/**/*.{js,ts}`
   - Grep: `Model.init|class.*extends Model` in models
   - Read: User.js and Product.js
3. **Pattern Analysis**:
   - Sequelize Model.init structure
   - Timestamp fields (createdAt, updatedAt)
   - Soft delete (deletedAt, paranoid: true)
   - Field validations
   - Indexes on common fields
   - toJSON method
4. **Recommendation**:
   ```markdown
   ## Pattern Analysis Results

   **Task**: Implement Category model
   **Classification**: Database Model (Sequelize)

   ### Existing Patterns Found

   I found 2 similar models:

   1. **models/User.js** (Confidence: High)
      - Pattern: Sequelize model with full setup
      - Key characteristics:
        * Primary key (id, auto-increment)
        * Timestamp fields (createdAt, updatedAt)
        * Soft delete (deletedAt, paranoid: true)
        * Field validations
        * Indexes on searchable fields
        * toJSON method to exclude sensitive data
        * snake_case database columns

   2. **models/Product.js** (Confidence: High)
      - Pattern: Same structure as User model
      - Confirms project standard

   ### Common Pattern Identified

   All models include:
   - Auto-increment ID primary key
   - createdAt, updatedAt, deletedAt timestamps
   - Paranoid delete enabled
   - Validation rules on fields
   - Indexes for performance
   - underscored: true (snake_case columns)

   ### Recommendation

   **Option 2: Pattern Following** (RECOMMENDED)

   Follow the structure from User.js:

   ```javascript
   Category.init(
     {
       id: {
         type: DataTypes.INTEGER,
         autoIncrement: true,
         primaryKey: true
       },
       name: {
         type: DataTypes.STRING(100),
         allowNull: false,
         unique: true,
         validate: {
           len: {
             args: [2, 100],
             msg: 'Name must be between 2 and 100 characters'
           }
         }
       },
       description: {
         type: DataTypes.TEXT,
         allowNull: true
       },
       createdAt: { type: DataTypes.DATE, allowNull: false, field: 'created_at' },
       updatedAt: { type: DataTypes.DATE, allowNull: false, field: 'updated_at' },
       deletedAt: { type: DataTypes.DATE, allowNull: true, field: 'deleted_at' }
     },
     {
       sequelize,
       tableName: 'categories',
       timestamps: true,
       paranoid: true,
       underscored: true,
       indexes: [
         { unique: true, fields: ['name'] },
         { fields: ['created_at'] }
       ]
     }
   );
   ```

   Should I also create the migration file following the same pattern?
   ```

### Success Criteria

- [ ] Agent activates on "Implement" + "model"
- [ ] Searches models directory correctly
- [ ] Identifies 2+ models
- [ ] Extracts Sequelize pattern
- [ ] Includes all standard fields (timestamps, soft delete)
- [ ] Recommends validations and indexes
- [ ] Offers to create migration file

---

## Test Scenario 4: No Pattern Found - Create New

### Scenario Description

User requests to implement a feature that has no similar patterns in the codebase. Agent should recognize this and suggest creating a new pattern.

### Setup

Existing codebase has no WebSocket handlers.

### User Request

```
"Add a WebSocket handler for real-time notifications"
```

### Expected Agent Behavior

1. **Activation**: Detect keyword "Add" and "handler"
2. **Search Strategy**:
   - Glob: `**/*websocket*`, `**/*socket*`, `**/handlers/**/*`
   - Grep: `websocket|socket.io|ws` in codebase
   - Read: Check for any socket-related files
3. **Pattern Analysis**:
   - No matches found
   - This is a new pattern for the project
4. **Recommendation**:
   ```markdown
   ## No Existing Patterns Found

   **Task**: Add WebSocket handler for notifications
   **Classification**: WebSocket Handler

   I searched for similar implementations but found no matches.

   **Search Performed:**
   - Glob: `**/*websocket*`, `**/*socket*`
   - Grep: `websocket|socket.io` in codebase
   - Result: No WebSocket handlers found

   ### Recommendation

   This appears to be a genuinely new pattern. I'll suggest a structure
   based on best practices for WebSocket handlers:

   **Proposed Pattern:**
   ```javascript
   // handlers/notification-websocket.js

   const WebSocket = require('ws');

   class NotificationHandler {
     constructor(server) {
       this.wss = new WebSocket.Server({ server });
       this.clients = new Map();
       this.setupHandlers();
     }

     setupHandlers() {
       this.wss.on('connection', (ws, req) => {
         // Connection handling
       });
     }

     broadcast(message) {
       // Broadcasting logic
     }
   }
   ```

   **Important:** Since this is a new pattern:
   1. Please review and approve this structure
   2. Once implemented, it will become the reference for future WebSocket handlers
   3. Consider documenting this pattern in `patterns/websocket-handler-pattern.md`

   Would you like me to proceed with this structure?
   ```

### Success Criteria

- [ ] Agent searches thoroughly
- [ ] Recognizes no pattern exists
- [ ] Proposes reasonable structure
- [ ] Explains it's a new pattern
- [ ] Asks for user approval
- [ ] Suggests documenting the new pattern

---

## Test Scenario 5: Conflicting Patterns Detected

### Scenario Description

User requests to add error handling, but the codebase has two different error handling approaches. Agent should detect the conflict and recommend standardization.

### Setup

Existing codebase has:
- `services/user-service.js` - Throws custom error classes
- `services/old-service.js` - Returns error objects `{ error: 'message' }`

### User Request

```
"Add error handling to the payment service"
```

### Expected Agent Behavior

1. **Activation**: Detect keyword "Add" and "error"
2. **Search Strategy**:
   - Grep: `throw.*Error|catch.*error` in services
   - Read: Multiple service files
3. **Pattern Analysis**:
   - Identifies two different approaches
   - Pattern A: Custom error classes (newer, 3 instances)
   - Pattern B: Error objects (older, 2 instances)
4. **Recommendation**:
   ```markdown
   ## Conflicting Patterns Detected

   **Task**: Add error handling to payment service
   **Classification**: Error Handling

   I found multiple approaches for error handling:

   ### Pattern A: Custom Error Classes (3 instances - NEWER)

   Files: services/user-service.js, services/order-service.js, services/product-service.js

   **Structure:**
   ```javascript
   throw new ValidationError('Invalid data', { field: 'email' });
   throw new NotFoundError('User', userId);
   ```

   **Pros:**
   - Type-safe error handling
   - Consistent error codes
   - Better error categorization
   - Easier to test

   **Cons:**
   - Requires error class definitions

   ### Pattern B: Error Objects (2 instances - OLDER)

   Files: services/old-service.js, services/legacy-service.js

   **Structure:**
   ```javascript
   return { error: 'Invalid data' };
   ```

   **Pros:**
   - Simple implementation

   **Cons:**
   - No error types
   - Inconsistent error handling
   - Harder to test

   ### Recommendation

   **Follow Pattern A (Custom Error Classes)** because:
   1. More prevalent in recent code (3 vs 2)
   2. Better type safety and error categorization
   3. Aligns with Node.js best practices
   4. Easier to maintain and test

   **Suggested Action:**
   1. Use Pattern A for new payment service
   2. Consider migrating Pattern B files to Pattern A
   3. Document Pattern A as the project standard

   Would you like me to proceed with Pattern A for the payment service?
   ```

### Success Criteria

- [ ] Agent detects both patterns
- [ ] Counts instances of each pattern
- [ ] Analyzes pros/cons of each
- [ ] Recommends the better/newer pattern
- [ ] Suggests standardization
- [ ] Provides clear reasoning

---

## Test Scenario 6: Pattern Variation Needed

### Scenario Description

User requests to create a paginated list endpoint. Agent should detect the standard endpoint pattern but recognize the need for pagination variation.

### Setup

Existing codebase has:
- Standard GET endpoints without pagination
- One GET endpoint with pagination (reference)

### User Request

```
"Add a GET endpoint to list all products with pagination"
```

### Expected Agent Behavior

1. **Activation**: Detect keyword "Add" and "endpoint"
2. **Search Strategy**:
   - Grep: `router.get.*pagination|limit.*offset` in routes
   - Find standard GET endpoints and paginated variant
3. **Pattern Analysis**:
   - Identifies standard endpoint pattern
   - Finds one paginated endpoint as variation
4. **Recommendation**:
   ```markdown
   ## Pattern Variation Detected

   **Task**: Add GET endpoint for listing products with pagination
   **Classification**: API Endpoint (Paginated List)

   ### Standard Pattern

   I found 5 standard GET endpoints, but you need pagination.

   ### Pagination Variation

   I found 1 endpoint with pagination:

   **routes/users.js - GET /users** (Confidence: High)
   - Uses query params: page, limit, sortBy, order
   - Returns data array + pagination meta
   - Standard format for paginated responses

   ### Recommended Pattern

   Follow the pagination variation from routes/users.js:

   ```javascript
   router.get('/products', authenticate, async (req, res) => {
     const {
       page = 1,
       limit = 10,
       sortBy = 'createdAt',
       order = 'DESC'
     } = req.query;

     const offset = (page - 1) * limit;

     const { rows, count } = await Product.findAndCountAll({
       limit: parseInt(limit),
       offset: parseInt(offset),
       order: [[sortBy, order]]
     });

     res.json({
       success: true,
       data: rows,
       meta: {
         pagination: {
           page: parseInt(page),
           limit: parseInt(limit),
           total: count,
           pages: Math.ceil(count / limit)
         }
       }
     });
   });
   ```

   This follows the standard endpoint pattern with pagination extension.

   Shall I proceed with this approach?
   ```

### Success Criteria

- [ ] Agent recognizes need for variation
- [ ] Finds the pagination variation
- [ ] Recommends the variation over standard
- [ ] Explains why variation is needed
- [ ] Maintains consistency with base pattern

---

## Manual Testing Procedure

### Step 1: Setup Test Environment

1. Create test codebase directory
2. Add sample files with patterns
3. Activate consistency agent
4. Prepare test requests

### Step 2: Execute Test Scenarios

For each scenario:

1. **Present user request** to the agent
2. **Observe agent behavior**:
   - Does it activate correctly?
   - What search strategy does it use?
   - What files does it read?
3. **Evaluate recommendation**:
   - Is the pattern correctly identified?
   - Is the recommendation clear and actionable?
   - Does it match expected output?
4. **Check performance**:
   - Response time < 15 seconds
   - Token usage < 5K tokens
   - File reads < 10 files

### Step 3: Document Results

For each test:

```markdown
## Test Results: [Scenario Name]

**Date**: YYYY-MM-DD
**Tester**: [Name]

### Execution
- Agent activated: ✓/✗
- Search strategy correct: ✓/✗
- Pattern identified: ✓/✗
- Recommendation provided: ✓/✗

### Performance
- Response time: X seconds
- Token usage: X tokens
- Files read: X files

### Quality
- Accuracy: High/Medium/Low
- Clarity: High/Medium/Low
- Actionability: High/Medium/Low

### Issues Found
- [Issue 1]
- [Issue 2]

### Notes
[Additional observations]
```

---

## Automated Testing (Future)

### Test Harness Structure

```javascript
// tests/consistency-agent.test.js

describe('Consistency Agent', () => {
  describe('Pattern Detection', () => {
    it('should detect API endpoint pattern', async () => {
      const request = 'Add a POST endpoint for creating categories';
      const result = await consistencyAgent.analyze(request);

      expect(result.patternFound).toBe(true);
      expect(result.patternType).toBe('API Endpoint');
      expect(result.confidence).toBeGreaterThan(0.8);
      expect(result.recommendation).toBeDefined();
    });

    it('should detect React component pattern', async () => {
      const request = 'Create a CategoryCard component';
      const result = await consistencyAgent.analyze(request);

      expect(result.patternFound).toBe(true);
      expect(result.patternType).toBe('React Component');
      expect(result.matchedFiles.length).toBeGreaterThan(0);
    });

    it('should handle no pattern found', async () => {
      const request = 'Add WebSocket handler for notifications';
      const result = await consistencyAgent.analyze(request);

      expect(result.patternFound).toBe(false);
      expect(result.recommendation).toContain('new pattern');
    });
  });

  describe('Performance', () => {
    it('should respond within time budget', async () => {
      const start = Date.now();
      await consistencyAgent.analyze('Add POST endpoint');
      const duration = Date.now() - start;

      expect(duration).toBeLessThan(15000); // 15 seconds
    });

    it('should stay within token budget', async () => {
      const result = await consistencyAgent.analyze('Create component');

      expect(result.tokensUsed).toBeLessThan(5000);
    });
  });
});
```

---

## Success Metrics

### Acceptance Criteria

All test scenarios must pass with:

- [ ] **Activation Rate**: 100% (agent activates on all relevant keywords)
- [ ] **Pattern Detection Rate**: >90% (correctly identifies patterns when they exist)
- [ ] **Recommendation Quality**: High (clear, actionable, specific)
- [ ] **Performance**: <15s response time, <5K tokens, <10 file reads
- [ ] **False Positive Rate**: <10% (doesn't suggest patterns when inappropriate)

### Quality Indicators

- **High Quality**:
  - All scenarios pass
  - Recommendations are actionable
  - Performance within budget
  - Clear explanations

- **Needs Improvement**:
  - Any scenario fails
  - Recommendations unclear
  - Performance issues
  - Missing critical information

---

## Version History

- v1.0.0 (2025-11-19): Initial test scenarios
  - 6 core test scenarios
  - Manual testing procedure
  - Success metrics defined
