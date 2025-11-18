# Skill Activation Tests

**Date:** 2025-11-18
**Purpose:** Document expected skill activation patterns for quality assurance

---

## Overview

This document defines test scenarios to verify that skills activate correctly based on user requests. These tests ensure no activation conflicts exist and that the right skill is triggered for each type of request.

**Status:** Expected behavior documented. Actual activation testing pending deployment.

---

## Test Scenarios

### Scenario 1: Debugging Request (obra control test)

**User Request:**
```
How should I debug this failing test?
```

**Expected Activation:** `systematic-debugging` (obra superpowers)

**Rationale:**
- Tests that obra foundation skills still activate correctly
- Verifies no conflicts with moai-essentials-debug (which was excluded)
- Control test to ensure existing workflow unchanged

**Expected Behavior:**
- Skill activates obra's 4-phase debugging framework
- Provides: OBSERVE → HYPOTHESIZE → TEST → VERIFY methodology
- No conflicts with moai skills

**Test Status:** ✓ Expected to activate correctly

---

### Scenario 2: FastAPI/Pydantic Development (moai language skill)

**User Request:**
```
I need to create a FastAPI endpoint with Pydantic validation
```

**Expected Activation:** `moai-lang-python`

**Rationale:**
- Tests moai language skill activation
- Verifies Python 3.13/FastAPI 0.115 patterns activate
- Ensures Pydantic v2 guidance provided

**Expected Behavior:**
- Skill provides FastAPI router patterns
- Pydantic BaseModel validation examples
- Async/await best practices
- SQLAlchemy 2.0 integration if database mentioned

**Test Status:** ✓ Expected to activate correctly

---

### Scenario 3: Database Schema Design (moai domain skill)

**User Request:**
```
How should I design this database schema with foreign keys?
```

**Expected Activation:** `moai-domain-database`

**Rationale:**
- Tests moai domain skill activation
- Verifies schema design patterns activate
- Ensures PostgreSQL best practices provided

**Expected Behavior:**
- Skill provides schema design guidance
- Foreign key relationship patterns
- Migration strategy recommendations
- Indexing and query optimization considerations

**Test Status:** ✓ Expected to activate correctly

---

### Scenario 4: Word Document Creation (document skill)

**User Request:**
```
Create a Word document with tracked changes
```

**Expected Activation:** `docx`

**Rationale:**
- Tests document processing skill activation
- Verifies OOXML manipulation capabilities
- Ensures no conflicts with other skills

**Expected Behavior:**
- Skill provides python-docx usage patterns
- Tracked changes API guidance
- Formatting preservation techniques
- OOXML structure understanding

**Test Status:** ✓ Expected to activate correctly

---

### Scenario 5: SwiftUI Development (Swift language skill)

**User Request:**
```
Build a SwiftUI view with state management
```

**Expected Activation:** `developing-with-swift`

**Rationale:**
- Tests carlo's Swift skill activation
- Verifies SwiftUI patterns provided
- Ensures native macOS development guidance

**Expected Behavior:**
- Skill provides SwiftUI view composition patterns
- @State, @Binding, @ObservedObject usage
- Async/await patterns in Swift
- Xcode build tool integration

**Test Status:** ✓ Expected to activate correctly

---

## Activation Conflict Analysis

### No Conflicts Expected

**obra vs moai-essentials:**
- moai-essentials-debug excluded → No conflict with systematic-debugging
- moai-essentials-review excluded → No conflict with requesting-code-review
- moai-foundation-specs excluded → No conflict with test-driven-development
- moai-foundation-git excluded → No conflict with using-git-worktrees

**moai language skills:**
- Each targets specific language (Python, TypeScript, Swift)
- No overlap between language domains
- Clear activation triggers (FastAPI → Python, React → TypeScript, SwiftUI → Swift)

**moai domain skills:**
- Each targets specific domain (database, backend, frontend, security)
- Some complementary overlap (backend + database, frontend + security)
- Should activate together when relevant, not conflict

**Document skills:**
- Each targets specific format (docx, pdf, xlsx, pptx)
- Clear activation triggers based on file type
- No overlap with coding skills

---

## Multi-Skill Activation Scenarios

Some requests should activate multiple complementary skills:

### Example 1: Full-Stack Feature

**User Request:**
```
I need to add user authentication to my FastAPI backend with PostgreSQL storage
```

**Expected Activations:**
- `moai-lang-python` (FastAPI patterns)
- `moai-domain-backend` (API architecture)
- `moai-domain-database` (schema design)
- `moai-domain-security` (authentication patterns)

**Rationale:** Complementary skills providing integrated guidance

---

### Example 2: Frontend with Backend Integration

**User Request:**
```
Create a React component that calls my FastAPI endpoint
```

**Expected Activations:**
- `moai-lang-typescript` (React patterns)
- `moai-domain-frontend` (component architecture)
- `moai-lang-python` (FastAPI endpoint patterns)
- `moai-domain-backend` (API design)

**Rationale:** Cross-stack skills working together

---

### Example 3: Process + Expertise

**User Request:**
```
I need to debug why my FastAPI endpoint is slow
```

**Expected Activations:**
- `systematic-debugging` (obra process)
- `moai-lang-python` (FastAPI expertise)
- `python-performance-optimization` (profiling tools)
- `moai-domain-backend` (API performance patterns)

**Rationale:** Process methodology enhanced by domain expertise

---

## Quality Assurance Checks

### Pre-Deployment Verification

- [x] No duplicate activation triggers found
- [x] Obra skills unchanged and functional
- [x] moai- prefix consistent across all moai skills
- [x] No excluded languages present (Go, Rust, Java, PHP, etc.)
- [x] No excluded moai skills present (essentials-debug, essentials-review, foundation-specs, foundation-git)
- [x] Document skills verified (docx, pdf, xlsx, pptx)
- [x] Optimization skills verified (sql-optimization-patterns, python-performance-optimization)

### Post-Deployment Testing

**Manual Testing Required:**
1. Submit each test scenario to Claude Code
2. Verify expected skill(s) activate
3. Confirm no unexpected skills activate
4. Check for activation errors or conflicts
5. Document any issues found

**Automated Testing (Future):**
- Create skill activation test suite
- Mock user requests and verify skill selection
- Regression testing after skill updates

---

## Known Limitations

### Cannot Test Activation Until Deployed

This document defines *expected* behavior. Actual activation testing requires:
1. Deploying skills to Claude Code environment
2. Submitting real user requests
3. Observing which skills activate
4. Verifying behavior matches expectations

### Activation Logic is Opaque

Claude Code's skill activation mechanism:
- Analyzes user request semantically
- Matches against skill descriptions and patterns
- Selects most relevant skill(s)
- Logic not exposed to skill authors

Therefore:
- We document *expected* activation based on skill descriptions
- Actual activation may differ
- Testing required to validate assumptions

---

## Success Criteria

### Phase 1 Success

All 5 test scenarios activate expected skills:
- ✓ Debugging → systematic-debugging
- ✓ FastAPI → moai-lang-python
- ✓ Database schema → moai-domain-database
- ✓ Word document → docx
- ✓ SwiftUI → developing-with-swift

### No Conflicts Observed

- No obra skills replaced unintentionally
- No moai skills activating when obra should
- No language skill conflicts (Python vs TypeScript vs Swift)
- No document format conflicts

### Complementary Activation Works

- Multi-skill activation works for full-stack requests
- Process + expertise skills activate together
- Domain skills layer appropriately

---

## Future Testing

### Phase 2 Testing Needs

After configuration systems added:
1. Test agent activation (Haiku vs Sonnet routing)
2. Test hook execution (pre-commit, pre-push)
3. Test global rules application
4. Test workflow command systems
5. Test cost optimization effectiveness

### Custom Skill Testing

When custom skills created:
1. NLP/ML skill activation for topic modeling
2. pytest-patterns skill for fixture/mocking requests
3. plotly-recharts-dashboards for visualization requests

---

## Maintenance

### When Skills Updated

1. Re-run all 5 test scenarios
2. Verify activation still correct
3. Check for new conflicts
4. Update this document with any changes

### When Skills Added

1. Define new test scenario
2. Verify no conflicts with existing skills
3. Test activation behavior
4. Document expected activation

### When Skills Removed

1. Remove associated test scenarios
2. Verify no broken references
3. Update activation expectations

---

## References

**Skills Inventory:** `SKILLS_INVENTORY.md`

**Configuration Decisions:** `CONFIGURATION_DECISIONS.md`

**Design Document:** `docs/plans/2025-11-18-claude-code-configuration-curation-design.md`

**Implementation Plan:** `docs/plans/2025-11-18-curated-skills-phase1.md` (Task 14)
