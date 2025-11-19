# Example: Debugging a Failing Test

This example demonstrates the 6-step debugging methodology applied to a failing unit test.

---

## Scenario

**User Request**: "The test suite is failing. Can you fix it?"

**Test Output**:
```
FAILED tests/test_user_service.py::test_create_user_with_email - AssertionError
Expected: {'id': 1, 'email': 'test@example.com', 'name': 'Test User'}
Got: {'id': 1, 'email': None, 'name': 'Test User'}
```

---

## Debugging Session

### STEP 1: Reproduce ✓

**Objective**: Establish reliable reproduction of the test failure

**Actions Taken**:
1. Read the complete error message
2. Run the specific failing test in isolation
3. Verify it fails consistently

**Commands**:
```bash
# Run the specific failing test
pytest tests/test_user_service.py::test_create_user_with_email -v

# Output confirms consistent failure
```

**Reproduction Documentation**:
```markdown
**Error Message**: AssertionError - email field is None instead of 'test@example.com'
**Trigger Conditions**: Running test_create_user_with_email
**Reproduction Steps**:
1. Run pytest on test_user_service.py
2. Observe test_create_user_with_email fails
3. Expected email field populated, got None

**Consistency**: Fails every time (100% reproduction rate)
```

---

### STEP 2: Isolate ✓

**Objective**: Narrow down to the specific code causing the failure

**Actions Taken**:
1. Read the failing test code
2. Read the user_service.py implementation
3. Identify the specific function being tested
4. Check for recent changes to related code

**Test Code** (tests/test_user_service.py):
```python
def test_create_user_with_email():
    """Test creating a user with email"""
    user_data = {
        'name': 'Test User',
        'email': 'test@example.com'
    }
    result = create_user(user_data)

    assert result['id'] == 1
    assert result['email'] == 'test@example.com'  # This assertion fails
    assert result['name'] == 'Test User'
```

**Implementation Code** (user_service.py):
```python
def create_user(data):
    """Create a new user"""
    user = {
        'id': generate_id(),
        'name': data.get('name'),
        'email': data.get('mail')  # BUG: Should be 'email' not 'mail'
    }
    return user
```

**Git History Check**:
```bash
git log --oneline -5 user_service.py
# Recent commit: "Refactor user creation logic"
```

**Isolation Summary**:
```markdown
**Location**: user_service.py:12 (create_user function)
**Scope**: Line reading email from data dict
**Related Code**: No other functions use similar pattern
**Recent Changes**: Refactored 2 days ago in commit abc123
```

---

### STEP 3: Hypothesis ✓

**Objective**: Form theory about root cause

**Primary Theory**:
The `create_user` function is using the wrong dictionary key to access the email.
It's using `data.get('mail')` instead of `data.get('email')`, causing it to
return None when the key doesn't exist.

**Evidence Supporting Hypothesis**:
1. Test passes in `user_data` with key 'email'
2. Function looks for key 'mail' (typo or wrong key name)
3. `.get('mail')` returns None when 'mail' key doesn't exist
4. Result shows email as None, matching what `.get()` returns for missing keys

**Alternative Theories**:
1. **Database not storing email** - Likelihood: Low
   - No database involved in this test (unit test, not integration)
   - Test shows result directly from function

2. **Email validation stripping value** - Likelihood: Low
   - No validation code visible in the function
   - Would expect empty string, not None

**Predicted Implications**:
If this theory is correct:
- Changing 'mail' to 'email' should fix the test
- Any code using 'mail' as a key would also fail
- Other fields (name, id) should work fine (they do)

---

### STEP 4: Test ✓

**Objective**: Validate the hypothesis before fixing

**Test Method**:
Add a debug print statement to confirm the hypothesis without changing behavior.

**Validation Code**:
```python
def create_user(data):
    """Create a new user"""
    # DEBUG: Check what keys we're accessing
    print(f"Data keys: {data.keys()}")
    print(f"Looking for 'mail': {data.get('mail')}")
    print(f"Looking for 'email': {data.get('email')}")

    user = {
        'id': generate_id(),
        'name': data.get('name'),
        'email': data.get('mail')  # Still using wrong key
    }
    return user
```

**Test Results**:
```
Data keys: dict_keys(['name', 'email'])
Looking for 'mail': None
Looking for 'email': test@example.com
```

**Hypothesis Status**: **✓ CONFIRMED**

The data dictionary contains 'email' key, but the code is looking for 'mail',
which returns None.

**Edge Cases Checked**:
- Missing email entirely: Would still return None (correct behavior for .get())
- Empty email string: Not applicable (we have the value, just wrong key)
- None as email value: Not the issue (we have a real value)

---

### STEP 5: Fix ✓

**Objective**: Implement minimal fix for root cause

**Root Cause**: Dictionary key mismatch - using 'mail' instead of 'email'

**Fix Description**: Change `data.get('mail')` to `data.get('email')` on line 12

**Code Changes**:
```python
def create_user(data):
    """Create a new user"""
    user = {
        'id': generate_id(),
        'name': data.get('name'),
        'email': data.get('email')  # FIXED: Changed 'mail' to 'email'
    }
    return user
```

**Similar Patterns Check**:
```bash
# Search for other uses of .get('mail')
grep -r "\.get\('mail'\)" .

# Result: No other occurrences found
```

**Similar Patterns Fixed**: None found - this was the only instance

**Edge Cases Handled**:
- Missing email in data: `.get('email')` returns None (appropriate default)
- None as email value: Preserved (`.get()` will return explicit None)
- Empty string email: Preserved (valid to have empty string)

---

### STEP 6: Verify ✓

**Objective**: Confirm fix works and no regressions

**Original Error**: ✓ **FIXED**

**Test Results**:

1. **Original failing test**:
```bash
pytest tests/test_user_service.py::test_create_user_with_email -v

# PASSED ✓
```

2. **Edge case: Missing email**:
```python
def test_create_user_without_email():
    """Test creating user without email (optional field)"""
    user_data = {'name': 'Test User'}
    result = create_user(user_data)
    assert result['email'] is None  # Correct default behavior
```
Result: ✓ **PASSED**

3. **Edge case: Explicit None email**:
```python
def test_create_user_explicit_none_email():
    """Test creating user with explicit None email"""
    user_data = {'name': 'Test User', 'email': None}
    result = create_user(user_data)
    assert result['email'] is None
```
Result: ✓ **PASSED**

4. **Happy path: All fields**:
```python
def test_create_user_complete():
    """Test creating user with all fields"""
    user_data = {
        'name': 'Test User',
        'email': 'test@example.com'
    }
    result = create_user(user_data)
    assert result['name'] == 'Test User'
    assert result['email'] == 'test@example.com'
    assert 'id' in result
```
Result: ✓ **PASSED**

**Test Suite**: ✓ **PASS**
```bash
pytest tests/test_user_service.py -v

# All 8 tests passed
# Coverage: 95%
```

**Regression Check**: ✓ **No regressions**
- All existing tests still pass
- No changes to test code needed
- Behavior matches expected for all scenarios

---

## Summary

**Issue**: Test failure due to dictionary key mismatch
**Root Cause**: Using `data.get('mail')` instead of `data.get('email')`
**Fix**: Changed 'mail' to 'email' in user_service.py line 12
**Verification**: All tests pass, including edge cases
**Time**: ~10 minutes (systematic approach prevented trial-and-error)

---

## Lessons Learned

### What Worked Well
✓ Reading the complete error message immediately identified the symptom
✓ Isolating to the specific function quickly narrowed the search
✓ Clear hypothesis prevented random changes
✓ Validation confirmed theory before making changes
✓ Edge case testing ensured comprehensive verification

### What to Watch For
- Dictionary key mismatches are common when refactoring
- `.get()` silently returns None for missing keys (can hide bugs)
- Always verify test data matches function expectations
- Search for similar patterns when fixing (avoided duplicate bugs)

### Prevention
- Consider using TypedDict or dataclasses for structured data
- Add type hints: `data: dict[str, Any]` → `data: UserData`
- Linting rules to catch common key name mismatches
- Code review checklist item: "Do dict keys match between test and impl?"
