# Quality Review Report

**Implementation**: [Brief description of what was implemented]
**Context**: [Production Code / Internal Tool / Prototype / Script]
**Reviewed By**: Quality Agent
**Date**: [YYYY-MM-DD]
**Verdict**: [PASS / PASS WITH RECOMMENDATIONS / REQUIRES CHANGES]

---

## Files Reviewed

```
[List all files reviewed with their paths]
- /path/to/file1.py
- /path/to/file2.ts
- /path/to/test_file.py
```

---

## Summary

[2-3 sentence overview of the implementation quality and key findings]

---

## Quality Checklist Results

### 1️⃣ Tests Written and Passing
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Specific observation about test coverage]
- [Note about test quality]
- [Any gaps or concerns]

**Evidence:**
```
[Code snippets, test output, or file references]
```

---

### 2️⃣ Documentation Updated
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Observation about documentation completeness]
- [Note about documentation quality]
- [Any missing documentation]

**Evidence:**
```
[Code snippets or file references]
```

---

### 3️⃣ Error Handling Present and Appropriate
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Observation about error handling coverage]
- [Note about error handling patterns]
- [Any missing error handling]

**Evidence:**
```
[Code snippets showing error handling or gaps]
File: /path/to/file.py:123-145
```

---

### 4️⃣ Edge Cases Considered
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Observation about edge case handling]
- [Note about boundary conditions]
- [Any missing edge case handling]

**Evidence:**
```
[Code snippets or test cases]
```

---

### 5️⃣ Performance Implications Reviewed
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Observation about performance considerations]
- [Note about algorithm efficiency]
- [Any performance concerns]

**Evidence:**
```
[Code snippets or metrics]
```

---

### 6️⃣ Security Considerations Addressed
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Observation about security measures]
- [Note about input validation/sanitization]
- [Any security concerns]

**Evidence:**
```
[Code snippets showing security measures or vulnerabilities]
```

---

### 7️⃣ Code Quality Standards Met
**Status**: ✅ PASS / ⚠️ PARTIAL / ❌ FAIL

**Findings:**
- [Observation about code readability]
- [Note about adherence to standards]
- [Any quality concerns]

**Evidence:**
```
[Code snippets or pattern references]
```

---

## Issues Found

### 🔴 CRITICAL (Must Fix Immediately)

**Total**: [N] critical issues

#### Issue 1: [Brief description]
**File**: `/path/to/file.py:123`
**Severity**: CRITICAL
**Impact**: [Description of potential impact]

**Current Code:**
```python
[Code snippet showing the issue]
```

**Recommendation:**
```python
[Suggested fix]
```

**Rationale**: [Why this is critical and must be fixed]

---

### 🟡 REQUIRED (Must Fix Before Completion)

**Total**: [N] required issues

#### Issue 1: [Brief description]
**File**: `/path/to/file.py:45`
**Severity**: REQUIRED
**Impact**: [Description of impact]

**Current Code:**
```python
[Code snippet showing the issue]
```

**Recommendation:**
```python
[Suggested fix or approach]
```

**Rationale**: [Why this should be fixed before completion]

---

### 🟢 RECOMMENDED (Should Consider)

**Total**: [N] recommended improvements

#### Improvement 1: [Brief description]
**File**: `/path/to/file.py:67`
**Severity**: RECOMMENDED
**Impact**: [Description of potential improvement]

**Current Code:**
```python
[Code snippet]
```

**Suggestion:**
```python
[Suggested improvement]
```

**Rationale**: [Why this would improve quality]

---

### ⚪ OPTIONAL (Nice to Have)

**Total**: [N] optional enhancements

#### Enhancement 1: [Brief description]
**File**: `/path/to/file.py:89`
**Severity**: OPTIONAL
**Impact**: [Minor improvement description]

**Suggestion**: [Brief suggestion for enhancement]

---

## What Was Done Well

[Acknowledge positive aspects of the implementation]

- ✅ [Positive observation 1]
- ✅ [Positive observation 2]
- ✅ [Positive observation 3]

---

## Detailed Recommendations

### For Critical Issues
1. **[Issue Title]**
   - **Action**: [Specific action to take]
   - **Priority**: Immediate
   - **Estimated Effort**: [Small/Medium/Large]

### For Required Issues
1. **[Issue Title]**
   - **Action**: [Specific action to take]
   - **Priority**: Before completion
   - **Estimated Effort**: [Small/Medium/Large]

### For Recommended Improvements
1. **[Improvement Title]**
   - **Action**: [Specific action to take]
   - **Priority**: Consider if time permits
   - **Estimated Effort**: [Small/Medium/Large]

---

## Next Steps

**Immediate Actions** (Critical issues):
1. [Action item 1]
2. [Action item 2]

**Before Completion** (Required issues):
1. [Action item 1]
2. [Action item 2]

**Future Considerations** (Recommended/Optional):
1. [Action item 1]
2. [Action item 2]

---

## Final Verdict

### ✅ PASS
[Use this section if verdict is PASS]

All critical and required quality checks have been satisfied. The implementation meets quality standards for [context]. No blocking issues found.

**Approval**: Ready for commit/deployment.

---

### ⚠️ PASS WITH RECOMMENDATIONS
[Use this section if verdict is PASS WITH RECOMMENDATIONS]

The implementation meets minimum quality standards, but there are [N] recommended improvements that would enhance quality. No blocking issues prevent proceeding, but consider addressing recommendations when possible.

**Approval**: Ready for commit/deployment with noted technical debt.

---

### ❌ REQUIRES CHANGES
[Use this section if verdict is REQUIRES CHANGES]

The implementation has [N] critical issues and [N] required issues that must be addressed before completion. These issues present risks of [describe risks].

**Approval**: NOT ready for commit/deployment. Address issues above first.

---

## Offer to Help

I can help address any of these issues if you'd like:
- Fix critical security vulnerabilities
- Add missing tests
- Improve error handling
- Update documentation
- Refactor code for better quality

Just let me know which issues you'd like help with!

---

**Review Completed**: [YYYY-MM-DD HH:MM]
**Reviewed by**: Quality Agent (Claude Sonnet)
