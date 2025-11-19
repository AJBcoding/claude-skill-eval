# Agent Specifications

## Overview

This document defines the specifications for three specialized agents designed to enhance code quality, debugging efficiency, and implementation consistency within Claude Code. These agents work together to create a robust development workflow that catches issues early, maintains pattern consistency, and ensures quality standards.

## Design Philosophy

The three-agent system is designed around the principle of **separation of concerns**:
- **Debug Agent**: Catches and resolves issues through systematic methodology
- **Consistency Agent**: Ensures pattern adherence across similar implementations
- **Quality Agent**: Validates completeness and quality before marking work complete

Each agent uses the most appropriate model for its task complexity and frequency of activation.

---

## 1. Debug Agent

### Purpose
Enforce a structured 6-step debugging methodology to systematically diagnose and resolve code issues. Prevents ad-hoc debugging approaches that lead to incomplete fixes or new bugs.

### Model Choice
**Claude Sonnet** (claude-sonnet-4-5-20250929)

**Rationale:**
- Debugging requires complex reasoning and hypothesis generation
- Need for nuanced understanding of code context and error patterns
- Benefits from Claude's stronger analytical and problem-solving capabilities
- Debugging is typically lower frequency but high stakes
- Worth the additional cost to prevent cascading bugs

### Activation Keywords
- `debug`
- `fix`
- `error`
- `failing`
- `broken`
- `not working`
- `issue`
- `problem`
- `bug`

### Activation Triggers

**Automatic Triggers:**
1. **Bash Command Errors**: Any non-zero exit code from Bash tool
2. **Test Failures**: pytest, npm test, or other test framework failures
3. **Stack Traces**: Detection of error stack traces in command output
4. **Assertion Failures**: Failed assertions in test output
5. **Build Failures**: Compilation or build process errors

**Manual Triggers:**
- User explicitly mentions debugging keywords
- User pastes error messages or stack traces
- User describes unexpected behavior

### Behavior Pattern

The Debug Agent guides users through a **6-step debugging methodology**:

#### 1. Reproduce
- Establish reliable reproduction steps
- Document the exact conditions that trigger the error
- Verify the error occurs consistently
- **Output**: Clear reproduction instructions

#### 2. Isolate
- Narrow down the scope of the problem
- Identify the specific component, function, or line causing the issue
- Remove unrelated complexity
- **Output**: Minimal reproduction case

#### 3. Hypothesis
- Formulate theories about root cause
- Consider multiple potential explanations
- Rank hypotheses by likelihood
- **Output**: Ordered list of potential causes

#### 4. Test
- Design experiments to validate/invalidate each hypothesis
- Use targeted logging, breakpoints, or unit tests
- Test one hypothesis at a time
- **Output**: Evidence supporting or refuting each hypothesis

#### 5. Fix
- Implement the solution for confirmed root cause
- Ensure fix addresses the underlying issue, not just symptoms
- Consider edge cases and side effects
- **Output**: Code changes with explanation

#### 6. Verify
- Confirm original error is resolved
- Run full test suite to prevent regressions
- Test edge cases related to the fix
- **Output**: Verification evidence (test results, manual testing)

### Success Criteria

**Primary:**
- All bugs are addressed using the 6-step methodology
- No steps are skipped in the debugging process
- Root causes are identified before fixes are implemented

**Secondary:**
- Bugs are caught before they reach production code
- Fixes include tests to prevent regression
- Debugging insights are documented for future reference

### Activation Scenarios

#### Scenario 1: Automatic Activation on Test Failure
```
User: "Run the test suite"
[Test output shows 3 failed tests]

Debug Agent Activates:
→ Detects test failures in output
→ Guides through reproduction of each failure
→ Helps isolate failing assertions
→ Facilitates hypothesis generation about causes
→ Assists in testing and fixing
→ Ensures verification with full test suite
```

#### Scenario 2: Manual Activation on User Request
```
User: "My API endpoint is returning 500 errors, can you help debug this?"

Debug Agent Activates:
→ Keyword "debug" detected
→ Step 1: Asks for exact reproduction steps
→ Step 2: Identifies specific endpoint and request conditions
→ Step 3: Generates hypotheses (DB connection, validation, auth, etc.)
→ Step 4: Suggests logging/testing to validate hypotheses
→ Step 5: Implements fix based on confirmed cause
→ Step 6: Verifies with test requests and monitoring
```

#### Scenario 3: Bash Error Trigger
```
User: "Install the dependencies"
[Bash returns exit code 1: npm ERR! peer dependency conflict]

Debug Agent Activates:
→ Non-zero exit code detected
→ Analyzes error message for context
→ Guides through dependency conflict resolution
→ Suggests testing different package versions
→ Verifies successful installation
```

### Design Decisions

**Why 6 Steps?**
- Comprehensive enough to handle complex bugs
- Structured enough to prevent shortcuts
- Flexible enough for various bug types
- Based on proven debugging methodologies (scientific method)

**Why Auto-Activate on Errors?**
- Prevents users from attempting quick fixes without analysis
- Catches issues immediately when they occur
- Builds good debugging habits through consistent practice

**Why Claude vs Haiku?**
- Debugging requires hypothesis generation and complex reasoning
- Cost justified by preventing cascading bugs and reducing debugging time
- Higher quality analysis leads to faster resolution

---

## 2. Consistency Agent

### Purpose
Enforce pattern consistency across similar implementations by matching against previously completed tasks. Prevents code duplication and ensures architectural coherence.

### Model Choice
**Claude Haiku** (claude-haiku-4-5-20250929)

**Rationale:**
- Pattern matching is primarily a search and comparison task
- High frequency of activation (triggers on most implementations)
- Haiku provides excellent performance at lower cost
- Pattern detection doesn't require deep reasoning
- Fast response time maintains development velocity
- Cost efficiency important for frequent activations

### Activation Keywords
- `implement`
- `add`
- `create`
- `build`
- `write`
- `develop`
- `make`
- `generate`
- `new feature`

### Activation Triggers

**Automatic Triggers:**
1. **Before Edit Operations**: Triggered before Edit tool is called
2. **Before Write Operations**: Triggered before Write tool creates new files
3. **Feature Implementation**: When creating new components, functions, or modules

**Manual Triggers:**
- User explicitly asks to follow existing patterns
- User mentions "like the other one" or similar references
- User requests consistency check

### Behavior Pattern

The Consistency Agent follows a **pattern matching workflow**:

#### 1. Identify Task Type
- Classify the implementation task (e.g., "add API endpoint", "create React component")
- Extract key characteristics and requirements
- Determine scope and complexity

#### 2. Search for Similar Patterns
- Use Grep/Glob to find similar implementations in codebase
- Search for matching file patterns, function names, class structures
- Identify relevant code sections

#### 3. Analyze Existing Patterns
- Extract common patterns from similar implementations:
  - File structure and naming conventions
  - Code organization and architecture
  - Error handling approaches
  - Testing patterns
  - Documentation style
  - Configuration patterns

#### 4. Suggest Pattern Reuse
- Present matched patterns to user
- Highlight which elements should be reused
- Explain consistency benefits
- Offer to apply pattern automatically

#### 5. Validate Consistency
- After implementation, verify pattern adherence
- Check for deviations from established patterns
- Flag intentional vs unintentional inconsistencies

### Success Criteria

**Primary:**
- Similar tasks follow identical patterns 90%+ of the time
- Pattern suggestions provided before implementation begins
- No duplicate pattern implementations (copy-paste consistency)

**Secondary:**
- Reduced code review time due to predictable patterns
- New developers can follow established patterns easily
- Codebase maintains architectural coherence

### Activation Scenarios

#### Scenario 1: Before Creating New API Endpoint
```
User: "Add a new POST endpoint for user registration"

Consistency Agent Activates:
→ Detects "add" and "endpoint" keywords
→ Searches codebase for existing POST endpoints
→ Finds pattern: /api/auth/login, /api/users/create
→ Analyzes common structure:
  - Express route handler pattern
  - Joi validation middleware
  - Database transaction wrapper
  - Standard error responses
  - Unit test structure
→ Suggests: "I found 5 similar POST endpoints. They all use this pattern:
  [shows pattern]. Should I follow the same structure?"
```

#### Scenario 2: Creating React Component
```
User: "Create a UserProfile component"

Consistency Agent Activates:
→ Detects "create" and "component" keywords
→ Searches for existing React components
→ Finds patterns:
  - TypeScript + functional components
  - Props interface definition
  - Styled-components for styling
  - React.memo for optimization
  - Prop validation with PropTypes
→ Suggests matching structure
→ Offers to generate boilerplate following pattern
```

#### Scenario 3: Adding Database Model
```
User: "Implement Product model with inventory tracking"

Consistency Agent Activates:
→ Searches for existing models (User, Order, etc.)
→ Identifies patterns:
  - Sequelize ORM configuration
  - Timestamp fields (createdAt, updatedAt)
  - Soft delete with deletedAt
  - Model validations
  - Association definitions
  - Migration file structure
→ Ensures new Product model follows same conventions
```

### Design Decisions

**Why Before Edit/Write?**
- Catches inconsistencies before code is written
- More efficient than post-implementation refactoring
- Helps maintain clean git history with correct patterns from start

**Why Haiku vs Claude?**
- Pattern matching is primarily search + compare (less complex reasoning)
- High frequency of activation makes cost efficiency critical
- Haiku's speed improves development velocity
- Pattern detection doesn't require deep analytical reasoning

**Why Auto-Activate?**
- Developers may not remember to check for patterns manually
- Proactive pattern enforcement prevents gradual codebase drift
- Builds muscle memory for pattern-aware development

---

## 3. Quality Agent

### Purpose
Perform comprehensive post-implementation review against quality checklist. Ensures all quality gates are passed before marking work as complete.

### Model Choice
**Claude Sonnet** (claude-sonnet-4-5-20250929)

**Rationale:**
- Quality review requires thorough analysis and judgment
- Need for nuanced understanding of code quality principles
- Must evaluate trade-offs and architectural decisions
- Benefits from Claude's deeper reasoning capabilities
- Lower frequency than consistency checks (end of tasks)
- Quality issues caught late are expensive; worth the investment

### Activation Keywords
- `done`
- `complete`
- `finished`
- `ready`
- `commit`
- `ship`
- `deploy`
- `merge`

### Activation Triggers

**Automatic Triggers:**
1. **After Edit/Write Operations**: Triggered after code changes are completed
2. **Before Git Commit**: When user prepares to commit changes
3. **Task Completion Signals**: When user indicates work is finished

**Manual Triggers:**
- User explicitly requests code review
- User asks "is this ready?"
- User mentions quality or review keywords

### Behavior Pattern

The Quality Agent performs a **comprehensive review checklist**:

#### 1. Test Coverage
- **Unit Tests**: All new functions/methods have unit tests
- **Integration Tests**: API endpoints and workflows tested
- **Edge Cases**: Boundary conditions and error paths covered
- **Test Quality**: Tests are meaningful, not just for coverage metrics
- **Passing Status**: All tests pass before completion

**Questions Asked:**
- "Are there unit tests for the new functionality?"
- "Have you tested error conditions and edge cases?"
- "Do all tests pass?"

#### 2. Documentation
- **Code Comments**: Complex logic is explained
- **Function Documentation**: Parameters, return values, exceptions documented
- **README Updates**: User-facing changes reflected in docs
- **API Documentation**: Endpoints, schemas, examples documented
- **Inline Comments**: Non-obvious decisions explained

**Questions Asked:**
- "Is the public API documented?"
- "Are complex algorithms explained with comments?"
- "Does the README reflect new features?"

#### 3. Error Handling
- **Input Validation**: All inputs validated before use
- **Error Catching**: Exceptions caught and handled appropriately
- **Error Messages**: Clear, actionable error messages
- **Graceful Degradation**: Failures don't crash the system
- **Logging**: Errors logged with sufficient context

**Questions Asked:**
- "What happens if inputs are invalid?"
- "Are errors caught and handled gracefully?"
- "Will error messages help users understand what went wrong?"

#### 4. Performance
- **Algorithm Efficiency**: No obvious performance bottlenecks
- **Database Queries**: Efficient queries, proper indexing
- **Memory Management**: No memory leaks or excessive allocations
- **Network Calls**: Batched where possible, timeouts set
- **Caching**: Appropriate use of caching for expensive operations

**Questions Asked:**
- "Will this scale with increased load?"
- "Are there N+1 query problems?"
- "Are expensive operations cached?"

#### 5. Security
- **Input Sanitization**: Protection against injection attacks
- **Authentication/Authorization**: Proper access controls
- **Sensitive Data**: No hardcoded secrets or credentials
- **Dependency Security**: No known vulnerabilities in dependencies
- **HTTPS/TLS**: Secure communications where required

**Questions Asked:**
- "Is user input sanitized?"
- "Are authentication checks in place?"
- "Are there any hardcoded secrets?"

#### 6. Code Quality
- **Readability**: Clear variable names, logical structure
- **DRY Principle**: No unnecessary code duplication
- **SOLID Principles**: Well-designed, maintainable code
- **Naming Conventions**: Follows project conventions
- **Code Smells**: No obvious anti-patterns

**Questions Asked:**
- "Is the code readable and maintainable?"
- "Are there opportunities to reduce duplication?"
- "Does it follow project conventions?"

#### 7. Integration
- **Breaking Changes**: API compatibility maintained
- **Database Migrations**: Backward compatible where possible
- **Configuration**: Environment-specific configs handled
- **Dependencies**: Version conflicts resolved
- **Build Process**: Successfully builds without warnings

**Questions Asked:**
- "Will this break existing functionality?"
- "Are database migrations backward compatible?"
- "Does it build cleanly?"

### Success Criteria

**Primary:**
- All quality gates passed before work marked complete
- No critical issues (security, data loss, crashes) shipped
- Code review checklist completed for every implementation

**Secondary:**
- Technical debt minimized through proactive quality checks
- Consistent quality standards across codebase
- Reduced bug reports in production

### Activation Scenarios

#### Scenario 1: Before Committing New Feature
```
User: "I'm done implementing the payment processing feature. Let's commit it."

Quality Agent Activates:
→ Detects "done" and "commit" keywords
→ Reviews implementation against checklist:

  ✓ Tests: Unit tests present, integration tests pass
  ✗ Documentation: API documentation missing
  ✓ Error Handling: Proper error catching
  ✗ Security: API key hardcoded (CRITICAL)
  ✓ Performance: Efficient queries
  ✓ Code Quality: Clean, readable code
  ✓ Integration: No breaking changes

→ Blocks commit with findings:
  "CRITICAL: Found hardcoded API key on line 45. Please move to environment variable.
   MISSING: API documentation for /api/payments endpoint.

   2 issues must be resolved before committing."
```

#### Scenario 2: After Implementing Data Migration
```
User: "Finished the user data migration script. Ready to deploy."

Quality Agent Activates:
→ Detects "finished" and "deploy" keywords
→ Reviews migration script:

  ✓ Tests: Migration tested on staging data
  ✗ Rollback Plan: No rollback mechanism
  ✓ Error Handling: Transaction-based with rollback on error
  ✗ Performance: Loads all users into memory at once (will fail on large datasets)
  ✓ Logging: Comprehensive logging
  ✗ Documentation: Migration steps not documented

→ Provides feedback:
  "BLOCKER: Memory issue will cause failure on production data (500K+ users).
   Suggest batch processing.

   REQUIRED: Add rollback script for safety.

   RECOMMENDED: Document migration steps for ops team."
```

#### Scenario 3: Post-Implementation Auto-Review
```
[User completes Edit operation adding new database model]

Quality Agent Activates:
→ Automatically triggered after Edit tool
→ Performs quick review:

  ✓ Tests: Model unit tests included
  ✓ Documentation: Model fields documented
  ✓ Error Handling: Validation rules defined
  ✓ Migrations: Migration file included
  ✗ Indexes: Missing index on frequently queried field 'email'

→ Suggests improvement:
  "Looks good! Consider adding an index on the 'email' field
   since it's used in user lookup queries. This will improve
   query performance."
```

### Design Decisions

**Why After Edit/Write?**
- Immediate feedback prevents quality issues from compounding
- Easier to fix issues while context is fresh
- Prevents "I'll add tests later" technical debt

**Why Claude vs Haiku?**
- Quality review requires nuanced judgment about trade-offs
- Need to understand complex interactions and implications
- Lower frequency (end of tasks) makes cost reasonable
- Quality issues caught late are expensive to fix; investment pays off

**Why Comprehensive Checklist?**
- Prevents "forgot to add tests" scenarios
- Ensures consistent quality bar across all implementations
- Provides learning opportunity for developers
- Reduces code review burden on team

---

## Inter-Agent Coordination

### Workflow Integration

The three agents work together in a coordinated workflow:

```
User Request
    ↓
Consistency Agent (Pre-Implementation)
    → Searches for similar patterns
    → Suggests pattern reuse
    ↓
Implementation
    ↓
[If Error Occurs] → Debug Agent
    → Systematic debugging
    → Fix and verify
    ↓
Quality Agent (Post-Implementation)
    → Comprehensive review
    → Quality gates
    ↓
Complete / Commit
```

### Handoff Points

**Consistency → Debug Agent:**
- If pattern search fails with errors, Debug Agent takes over
- If pattern application causes test failures, Debug Agent intervenes

**Debug → Quality Agent:**
- After bug fix is implemented, Quality Agent verifies the fix
- Ensures tests and documentation are updated with the fix

**Quality → Debug Agent:**
- If quality review reveals bugs, hands off to Debug Agent
- If tests fail during quality check, Debug Agent investigates

### Conflict Resolution

**Priority Order:**
1. **Debug Agent** (highest): Security and correctness issues
2. **Quality Agent**: Quality gates and standards
3. **Consistency Agent** (lowest): Pattern preferences

**Example:**
If Consistency Agent suggests a pattern that Quality Agent identifies as having security issues, Quality Agent overrides the pattern suggestion.

---

## Configuration and Customization

### Model Configuration

Each agent can be configured with different models based on organization needs:

```yaml
agents:
  debug:
    model: claude-sonnet-4-5-20250929
    temperature: 0.2  # Lower for more deterministic debugging

  consistency:
    model: claude-haiku-4-5-20250929
    temperature: 0.1  # Lowest for pattern matching

  quality:
    model: claude-sonnet-4-5-20250929
    temperature: 0.3  # Slightly higher for creative quality insights
```

### Customizable Thresholds

Organizations can tune agent sensitivity:

```yaml
thresholds:
  debug_agent:
    auto_activate_on_test_failure: true
    auto_activate_on_bash_error: true
    min_error_severity: warning  # Options: info, warning, error, critical

  consistency_agent:
    similarity_threshold: 0.75  # How similar tasks must be to trigger
    min_pattern_matches: 2      # Minimum similar implementations to establish pattern

  quality_agent:
    required_test_coverage: 80  # Percentage
    block_on_security_issues: true
    block_on_missing_tests: true
    warn_on_missing_docs: true
```

---

## Success Metrics

### Debug Agent Metrics
- **Mean Time to Resolution (MTTR)**: Time from error to fix
- **First-Time Fix Rate**: Percentage of bugs fixed without regression
- **Methodology Adherence**: Percentage of debugging sessions using all 6 steps
- **Prevention Rate**: Bugs caught before code execution

### Consistency Agent Metrics
- **Pattern Adherence Rate**: Percentage of similar tasks following same pattern
- **Pattern Suggestions Used**: How often developers accept pattern suggestions
- **Code Duplication Reduction**: Decrease in duplicate code patterns
- **Architectural Coherence Score**: Measure of codebase consistency

### Quality Agent Metrics
- **Quality Gate Pass Rate**: First-time pass rate for quality checklist
- **Issue Detection Rate**: Number of issues caught before commit
- **Test Coverage**: Average test coverage of reviewed code
- **Production Bug Rate**: Bugs that escape to production (inverse metric)

---

## Future Enhancements

### Planned Improvements

1. **Learning from History**
   - Agents learn from past debugging sessions
   - Pattern library grows with each implementation
   - Quality standards evolve based on team feedback

2. **Custom Checklists**
   - Project-specific quality criteria
   - Domain-specific debugging steps
   - Organization-specific patterns

3. **Agent Analytics Dashboard**
   - Real-time metrics on agent effectiveness
   - Identification of common issues
   - Team performance insights

4. **Context Sharing**
   - Agents share context and findings
   - Persistent memory across sessions
   - Cross-project pattern matching

---

## Conclusion

The three-agent system provides comprehensive development workflow support:

- **Debug Agent** ensures systematic problem resolution
- **Consistency Agent** maintains architectural coherence
- **Quality Agent** enforces quality standards

Together, they create a robust safety net that catches issues early, maintains code quality, and ensures consistency across implementations.

Each agent is optimized for its specific role with appropriate model selection, activation triggers, and behavior patterns. The system is designed to be flexible, customizable, and measurable, ensuring continuous improvement over time.

---

**Document Version**: 1.0
**Last Updated**: 2025-11-19
**Authors**: Claude Code Team
**Status**: Specification Draft
