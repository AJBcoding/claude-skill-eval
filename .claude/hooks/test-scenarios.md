# Hook Integration Tests

## Test Execution Date
2025-11-19

## Purpose
Verify that integration hooks work correctly, don't conflict with each other, and enhance the obra superpowers workflow.

---

## Test Scenario 1: Pre-Implementation Hook

### Objective
Verify consistency-agent activates before Edit/Write operations and provides pattern suggestions.

### Test Setup
- Existing file: `src/api/users.js` (existing API endpoint)
- Action: Create new file `src/api/products.js` (new API endpoint)

### Expected Behavior
1. Pre-implementation hook detects `before:Write` event
2. Consistency-agent activates
3. Searches for similar patterns (API endpoints)
4. Finds `src/api/users.js` as reference
5. Suggests following same pattern:
   - Express route handler structure
   - Validation middleware
   - Error handling approach
   - Response format
6. User can accept/reject suggestion

### Test Conditions Met
- ✓ File type: `.js` (code file)
- ✓ Operation: `Write` (creating new file)
- ✓ Change size: > 5 lines
- ✓ Keywords: "create", "API", "endpoint"

### Expected Exit Codes
- `0`: Pattern accepted and applied
- `1`: No similar patterns found (warning)
- `130`: User cancelled

### Success Criteria
- Hook activates automatically
- Pattern search completes in < 30 seconds
- Suggested patterns are relevant
- User can proceed with or without pattern
- No blocking behavior

---

## Test Scenario 2: Post-Error Hook

### Objective
Verify debug-agent activates on errors and enforces 6-step methodology.

### Test Setup
- Action: Run `npm test` with intentionally failing tests
- Error: Test assertion failure

### Expected Behavior
1. Post-error hook detects non-zero exit code
2. Debug-agent activates automatically
3. Error context captured:
   - Command: `npm test`
   - Exit code: 1
   - Test output with failures
   - Recent file changes
4. Guides through 6 steps:
   - Reproduce: Confirm reliable reproduction
   - Isolate: Identify specific failing test
   - Hypothesis: Generate theories about cause
   - Test: Validate hypotheses
   - Fix: Implement solution
   - Verify: Confirm resolution

### Test Conditions Met
- ✓ Non-zero exit code
- ✓ Error pattern in output: "FAILED"
- ✓ Test framework detected: npm/jest/pytest

### Expected Exit Codes
- `0`: Bug resolved and verified
- `1`: Partial progress
- `3`: Needs user expertise

### Success Criteria
- Hook activates on error
- All 6 steps enforced (cannot skip)
- Error context properly captured
- Fix guided by methodology
- Verification confirms resolution

---

## Test Scenario 3: Post-Implementation Hook

### Objective
Verify quality-agent activates after code changes and reviews against checklist.

### Test Setup
- Action: Complete implementation of new feature
- User says: "Done, ready to commit"

### Expected Behavior
1. Post-implementation hook detects completion signal
2. Quality-agent activates
3. Reviews against 7 categories:
   - Test Coverage
   - Documentation
   - Error Handling
   - Performance
   - Security
   - Code Quality
   - Integration
4. Generates quality report
5. Identifies any blocking issues
6. Allows commit only if no critical issues

### Test Conditions Met
- ✓ Code file changed
- ✓ Change size: > 10 lines
- ✓ Completion keyword: "done", "ready to commit"

### Expected Exit Codes
- `0`: All quality gates passed
- `1`: Warnings (non-blocking)
- `2`: Blocking issues found
- `3`: Security issues (blocks commit)

### Success Criteria
- Hook activates on completion signal
- Comprehensive checklist executed
- Clear report generated
- Blocking issues prevent commit
- Warnings allow commit with acknowledgment

---

## Test Scenario 4: Full Workflow Integration

### Objective
Verify all three hooks work together in a complete development workflow.

### Test Setup
- Task: "Implement user authentication endpoint"
- Workflow: Pattern search → Implementation → Error → Debug → Quality review → Commit

### Expected Workflow

```
1. USER: "Add POST /api/auth/login endpoint"

2. PRE-IMPLEMENTATION HOOK
   ✓ Consistency-agent activated
   → Searches for similar auth endpoints
   → Finds /api/auth/register pattern
   → Suggests: Express + JWT + bcrypt pattern
   → User accepts pattern

3. IMPLEMENTATION
   → User implements following pattern
   → Creates login endpoint

4. TESTING
   → User runs: npm test
   → Tests fail (intentional error: missing JWT_SECRET)

5. POST-ERROR HOOK
   ✓ Debug-agent activated
   → Captures error context
   → Guides through 6 steps:
     1. Reproduce: Tests fail consistently
     2. Isolate: JWT verification failing
     3. Hypothesis: Missing env variable
     4. Test: Check .env file
     5. Fix: Add JWT_SECRET to .env
     6. Verify: Tests now pass
   → Exit code 0: Resolved

6. COMPLETION
   → User: "Done, ready to commit"

7. POST-IMPLEMENTATION HOOK
   ✓ Quality-agent activated
   → Reviews implementation:
     • Test Coverage: ✓ PASSED
     • Documentation: ✓ PASSED
     • Error Handling: ✓ PASSED
     • Security: ✓ PASSED
     • Code Quality: ✓ PASSED
     • Integration: ✓ PASSED
   → Exit code 0: All gates passed

8. COMMIT
   ✓ All hooks passed
   → Ready to commit
```

### Success Criteria
- All three hooks activate at appropriate times
- No conflicts between hooks
- Smooth workflow progression
- Each hook adds value
- No unnecessary blocking

---

## Test Scenario 5: Hook Bypass Mechanisms

### Objective
Verify bypass mechanisms work correctly and don't interfere with normal operation.

### Test Cases

#### 5A: Skip Consistency Check
```bash
# Action: Create file with --skip-consistency-check flag
# Expected: Pre-implementation hook bypassed
# Result: File created without pattern search
```

#### 5B: Global Hook Disable
```bash
# Action: Set CLAUDE_SKIP_HOOKS=true
# Expected: All hooks bypassed
# Result: Normal workflow without hook activation
```

#### 5C: Test File Bypass
```bash
# Action: Edit file in tests/ directory
# Expected: Relaxed quality standards
# Result: Quality checks pass with lower bar
```

#### 5D: Minor Change Bypass
```bash
# Action: Edit with --minor-change flag
# Expected: Quality hook skipped
# Result: Documentation-only change allowed
```

### Success Criteria
- Bypass flags work as documented
- Environment variable disables all hooks
- File patterns trigger appropriate bypass
- Bypasses don't break normal operation

---

## Test Scenario 6: Conflict Resolution

### Objective
Verify hooks resolve conflicts according to priority: Debug > Quality > Consistency

### Test Case: Security Issue in Suggested Pattern

```
1. PRE-IMPLEMENTATION
   → Consistency-agent suggests Pattern A
   → Pattern A has known security issue

2. POST-IMPLEMENTATION
   → Quality-agent detects security issue
   → Blocks commit
   → Priority: Quality overrides Consistency

Expected Result: Quality-agent blocks despite consistency suggestion
Actual Result: [To be tested]
```

### Test Case: Debug Overrides Quality

```
1. QUALITY CHECK
   → Quality-agent finds missing tests
   → Would normally block

2. DEBUG SESSION
   → Debug-agent investigating critical bug
   → Needs emergency fix

Expected Result: Debug-agent priority allows temporary bypass
Actual Result: [To be tested]
```

### Success Criteria
- Priority order respected
- No circular dependencies
- Clear feedback about conflicts
- Resolution follows documented priority

---

## Test Scenario 7: Performance Benchmarks

### Objective
Verify hooks execute within expected time limits.

### Benchmarks

| Hook | Expected | Measured | Status |
|------|----------|----------|--------|
| Pre-Implementation | < 30s | [TBD] | - |
| Post-Error (simple) | < 2min | [TBD] | - |
| Post-Error (complex) | < 10min | [TBD] | - |
| Post-Implementation | < 2min | [TBD] | - |

### Test Conditions
- Codebase size: ~100 files
- Pattern search: 5 similar files
- Quality checks: All 7 categories
- Network: Local (no external API calls)

### Success Criteria
- All hooks within time limits
- No performance degradation
- Caching works correctly
- Parallel checks complete faster

---

## Test Scenario 8: Integration with obra superpowers

### Objective
Verify hooks enhance rather than conflict with obra superpowers workflow.

### Test Setup
- Use obra superpowers skill: "systematic-implementation"
- Enable all three hooks
- Complete full feature implementation

### Expected Behavior
1. Superpowers skill guides implementation planning
2. Pre-implementation hook finds patterns
3. Both work together (no conflict)
4. Superpowers TDD workflow continues
5. Post-error hook assists debugging
6. Post-implementation hook validates quality
7. Superpowers commit process enhanced by quality gates

### Success Criteria
- No conflicts with superpowers
- Hooks add value to superpowers workflow
- Combined workflow smoother than either alone
- Clear separation of concerns

---

## Test Scenario 9: Error Recovery

### Objective
Verify hooks fail gracefully and don't break workflow.

### Test Cases

#### 9A: Hook Crashes
```
Action: Hook encounters unexpected error
Expected: Warning message, workflow continues
Result: [TBD]
```

#### 9B: Agent Not Found
```
Action: Hook references non-existent agent
Expected: Error message, graceful fallback
Result: [TBD]
```

#### 9C: Timeout
```
Action: Hook exceeds max_execution_time
Expected: Timeout warning, workflow continues
Result: [TBD]
```

#### 9D: Invalid Configuration
```
Action: Hook YAML has syntax error
Expected: Configuration error, hook disabled
Result: [TBD]
```

### Success Criteria
- Graceful error handling
- Clear error messages
- Workflow not blocked by hook failures
- Errors logged for debugging

---

## Test Scenario 10: Custom Checklist

### Objective
Verify quality checklist can be customized for project-specific needs.

### Test Setup
Add custom check to `post-implementation.yml`:
```yaml
checklist:
  categories:
    - name: accessibility
      weight: high
      checks:
        - id: wcag_compliance
          description: "WCAG 2.1 AA compliance verified"
          required: true
          blocking: true
```

### Expected Behavior
1. Post-implementation hook runs custom check
2. Validates WCAG compliance
3. Blocks if non-compliant
4. Included in quality report

### Success Criteria
- Custom checks execute
- Included in report
- Blocking behavior works
- Easy to add/modify checks

---

## Overall Integration Test Results

### Test Summary

| Scenario | Status | Notes |
|----------|--------|-------|
| 1. Pre-Implementation | [PENDING] | To be tested |
| 2. Post-Error | [PENDING] | To be tested |
| 3. Post-Implementation | [PENDING] | To be tested |
| 4. Full Workflow | [PENDING] | To be tested |
| 5. Bypass Mechanisms | [PENDING] | To be tested |
| 6. Conflict Resolution | [PENDING] | To be tested |
| 7. Performance | [PENDING] | To be tested |
| 8. obra superpowers | [PENDING] | To be tested |
| 9. Error Recovery | [PENDING] | To be tested |
| 10. Custom Checklist | [PENDING] | To be tested |

### Integration Verification

#### Hook Compatibility
- [ ] Pre-implementation + Post-implementation: No conflicts
- [ ] Post-error + Post-implementation: Proper sequencing
- [ ] All three hooks: Coordinated workflow

#### obra superpowers Compatibility
- [ ] Works with superpowers skills
- [ ] Enhances TDD workflow
- [ ] No blocking issues
- [ ] Transparent feedback

#### Performance
- [ ] All hooks within time limits
- [ ] No workflow degradation
- [ ] Caching effective
- [ ] Parallel processing works

#### Quality
- [ ] Hooks catch real issues
- [ ] False positive rate acceptable
- [ ] Feedback clear and actionable
- [ ] Documentation comprehensive

---

## Recommendations

Based on testing, the following adjustments may be needed:

1. **Threshold Tuning**: Adjust min_lines, timeouts based on actual usage
2. **Pattern Database**: Build initial pattern database for common scenarios
3. **Checklist Refinement**: Add/remove checks based on project needs
4. **Performance Optimization**: Enable caching, parallel processing as needed
5. **Documentation Updates**: Add real-world examples from testing

---

## Next Steps

1. Execute all test scenarios
2. Document actual results
3. Adjust configurations based on findings
4. Create sample error patterns database
5. Build initial quality metrics baseline
6. Update README with real-world examples
7. Deploy to development environment
8. Gather user feedback
9. Iterate on configurations

---

**Test Version**: 1.0.0
**Test Date**: 2025-11-19
**Tester**: Claude Code Team
**Status**: Scenarios defined, execution pending
