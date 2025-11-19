# Quality Review Checklist

Use this checklist to ensure comprehensive quality review before marking work complete.

---

## Pre-Review Setup

**Implementation Details:**
- [ ] What was implemented? _______________________________
- [ ] What context? (Production / Internal Tool / Prototype / Script)
- [ ] Which files were changed? _______________________________

---

## The 7-Point Quality Checklist

### 1️⃣ Tests Written and Passing

**Unit Tests:**
- [ ] Unit tests exist for new functionality
- [ ] Tests cover happy path
- [ ] Tests cover error conditions
- [ ] Tests cover edge cases
- [ ] Tests are meaningful (check behavior, not implementation)

**Integration Tests:**
- [ ] Workflows are tested end-to-end
- [ ] API endpoints tested
- [ ] Database interactions tested

**Test Execution:**
- [ ] All tests pass
- [ ] No skipped tests without good reason
- [ ] Test coverage is appropriate for context

**Notes:**
```
[Space for notes on test coverage]
```

---

### 2️⃣ Documentation Updated

**Code Documentation:**
- [ ] Complex logic has explanatory comments
- [ ] Public APIs documented (parameters, return values, exceptions)
- [ ] Non-obvious decisions explained
- [ ] Function/method docstrings present

**Project Documentation:**
- [ ] README updated if user-facing changes
- [ ] API documentation updated
- [ ] Usage examples provided where helpful
- [ ] Breaking changes documented

**Documentation Quality:**
- [ ] Comments explain "why", not "what"
- [ ] No outdated comments
- [ ] No obvious/redundant comments

**Notes:**
```
[Space for notes on documentation]
```

---

### 3️⃣ Error Handling Present and Appropriate

**Input Handling:**
- [ ] Null/undefined values handled
- [ ] Invalid inputs validated
- [ ] Type mismatches caught
- [ ] Boundary values checked

**External Dependencies:**
- [ ] API failures handled gracefully
- [ ] File operations handle missing/locked files
- [ ] Database errors caught and handled
- [ ] Network timeouts configured

**Error Messages:**
- [ ] User-facing errors are clear and actionable
- [ ] Technical errors logged with sufficient context
- [ ] No sensitive data in error messages
- [ ] Error codes/types consistent with project

**Error Handling Patterns:**
- [ ] No silent failures (empty catch blocks)
- [ ] No generic error swallowing
- [ ] Exceptions used appropriately (not for control flow)
- [ ] Graceful degradation where appropriate

**Notes:**
```
[Space for notes on error handling]
```

---

### 4️⃣ Edge Cases Considered

**Data Edge Cases:**
- [ ] Empty collections handled
- [ ] Null/undefined inputs handled
- [ ] Very large inputs considered
- [ ] Single item collections handled
- [ ] Duplicate items handled

**Numeric Edge Cases:**
- [ ] Zero handled
- [ ] Negative numbers handled
- [ ] Very large numbers (overflow)
- [ ] Floating point precision considered
- [ ] Division by zero prevented

**String Edge Cases:**
- [ ] Empty string handled
- [ ] Very long strings considered
- [ ] Special characters handled
- [ ] Unicode/emoji handled
- [ ] Whitespace-only strings handled

**System Edge Cases:**
- [ ] Concurrent access considered
- [ ] Resource exhaustion handled
- [ ] Dependencies unavailable handled
- [ ] Operation fails midway handled

**Notes:**
```
[Space for notes on edge cases]
```

---

### 5️⃣ Performance Implications Reviewed

**Database Performance:**
- [ ] No N+1 query problems
- [ ] Queries use indexes appropriately
- [ ] Queries are optimized
- [ ] Batch operations where appropriate

**Algorithm Efficiency:**
- [ ] Algorithm complexity is reasonable
- [ ] No obvious performance bottlenecks
- [ ] Large datasets handled efficiently
- [ ] Memory usage is reasonable

**Caching & Optimization:**
- [ ] Expensive operations cached where appropriate
- [ ] Network calls batched where possible
- [ ] Resources released properly (connections, files)
- [ ] No memory leaks

**Performance Context:**
- [ ] Performance requirements met for context
- [ ] Load testing considered if relevant
- [ ] Optimization justified (not premature)

**Notes:**
```
[Space for notes on performance]
```

---

### 6️⃣ Security Considerations Addressed

**Input Security:**
- [ ] User inputs validated
- [ ] User inputs sanitized
- [ ] SQL injection prevented (parameterized queries)
- [ ] XSS prevented (output escaped)
- [ ] Path traversal prevented

**Authentication & Authorization:**
- [ ] Authentication checks in place
- [ ] Authorization enforced
- [ ] Role-based access correct
- [ ] Session handling secure

**Secrets Management:**
- [ ] No hardcoded credentials
- [ ] No secrets in version control
- [ ] Secrets loaded from environment
- [ ] API keys properly secured

**Data Security:**
- [ ] Sensitive data encrypted at rest
- [ ] Sensitive data encrypted in transit
- [ ] No sensitive data in logs
- [ ] No sensitive data in error messages

**Additional Security:**
- [ ] Rate limiting where needed
- [ ] CSRF protection if applicable
- [ ] Dependency vulnerabilities checked
- [ ] Security headers configured

**Notes:**
```
[Space for notes on security]
```

---

### 7️⃣ Code Quality Standards Met

**Readability:**
- [ ] Clear, descriptive variable names
- [ ] Clear, descriptive function names
- [ ] Logical code structure
- [ ] Appropriate use of comments
- [ ] Code is self-documenting where possible

**Best Practices:**
- [ ] No unnecessary code duplication (DRY)
- [ ] Single Responsibility Principle followed
- [ ] Functions/methods are focused and small
- [ ] Follows project conventions
- [ ] Consistent code style

**Type Safety:**
- [ ] Type hints used (Python) or types defined (TypeScript)
- [ ] No 'any' types without justification
- [ ] Type mismatches prevented
- [ ] Interfaces/contracts clear

**Code Smells Avoided:**
- [ ] No very long functions (>50 lines without good reason)
- [ ] No deeply nested conditionals (>3 levels)
- [ ] No magic numbers (use constants)
- [ ] No commented-out code
- [ ] No TODO comments without tickets

**Integration:**
- [ ] No breaking changes to public APIs
- [ ] Database migrations backward compatible
- [ ] Configuration handled properly
- [ ] Dependencies updated appropriately
- [ ] Build succeeds without warnings

**Notes:**
```
[Space for notes on code quality]
```

---

## Issue Summary

### 🔴 CRITICAL Issues (Must Fix Immediately)
```
[List critical issues with file:line references]
1.
2.
3.
```

### 🟡 REQUIRED Issues (Must Fix Before Completion)
```
[List required issues with file:line references]
1.
2.
3.
```

### 🟢 RECOMMENDED Improvements (Should Consider)
```
[List recommended improvements with file:line references]
1.
2.
3.
```

### ⚪ OPTIONAL Enhancements (Nice to Have)
```
[List optional enhancements with file:line references]
1.
2.
3.
```

---

## Final Verdict

**Overall Assessment:**
- [ ] ✅ **PASS** - All critical and required checks passed
- [ ] ⚠️ **PASS WITH RECOMMENDATIONS** - Passes but has optional improvements
- [ ] ❌ **REQUIRES CHANGES** - Must address critical/required issues

**Summary:**
```
[Brief summary of overall code quality and key findings]
```

**Next Steps:**
```
[Clear action items for the developer]
1.
2.
3.
```

---

## Context-Specific Adjustments

**If Production Code:**
- All checklist items apply
- Higher standards for all categories
- Security review is critical
- Test coverage ≥80% expected

**If Internal Tool:**
- Essential error handling required
- Basic validation required
- Key functionality tested
- Minimal documentation acceptable

**If Prototype/Experiment:**
- Fail-fast error handling acceptable
- Tests optional but edge cases should be noted
- Document limitations and assumptions
- Security TODOs noted for future

**If Script:**
- Clear error messages required
- Validate critical inputs
- Document usage and assumptions
- Note if not production-ready

---

## Quick Copy-Paste Templates

### For Comments in Code

```python
# TODO: [Issue description] - Tracked in [ticket/issue number]
# FIXME: [What's broken] - Priority: [High/Medium/Low]
# NOTE: [Important context that's not obvious from code]
# HACK: [Why this workaround exists] - Should be refactored when [condition]
```

### For Documentation

```python
"""
[Brief description of what this does]

Args:
    param1: [Description, constraints]
    param2: [Description, constraints]

Returns:
    [Description of return value]

Raises:
    ExceptionType: [When this exception is raised]

Example:
    >>> function_name(arg1, arg2)
    expected_output
"""
```

### For Test Cases

```python
def test_function_name():
    """Test [specific behavior being tested]."""
    # Arrange
    [setup test data and conditions]

    # Act
    result = function_under_test(test_data)

    # Assert
    assert result == expected_value
    # or
    with pytest.raises(ExpectedException):
        function_under_test(invalid_data)
```

---

## Review Checklist Completion

**Final Check Before Submitting Review:**
- [ ] Have I checked all 7 quality points?
- [ ] Have I identified the correct context?
- [ ] Have I categorized all issues by priority?
- [ ] Have I provided specific file paths and line numbers?
- [ ] Have I given actionable recommendations?
- [ ] Have I acknowledged what was done well?
- [ ] Have I provided clear next steps?
- [ ] Have I offered to help if needed?

---

**Remember**: Quality is context-dependent. Adjust your standards appropriately while ensuring code is safe, maintainable, and fit for purpose.
