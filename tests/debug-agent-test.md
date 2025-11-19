# Debug Agent Test Scenario

This document defines test scenarios for validating the debug-agent implementation.

---

## Test Overview

**Purpose**: Validate that the debug-agent properly enforces the 6-step debugging methodology

**Scope**: Test agent activation, step-by-step guidance, and methodology enforcement

**Expected Duration**: 15-20 minutes per scenario

---

## Test Scenario 1: Failing Unit Test

### Setup

Create a simple Python project with a failing test:

**File: `src/calculator.py`**
```python
def add(a, b):
    """Add two numbers"""
    return a + b

def subtract(a, b):
    """Subtract b from a"""
    return a - b

def multiply(a, b):
    """Multiply two numbers"""
    return a * b

def divide(a, b):
    """Divide a by b"""
    return a / b  # BUG: No check for division by zero

def average(numbers):
    """Calculate average of a list of numbers"""
    total = sum(numbers)
    count = len(numbers)  # BUG: No check for empty list
    return total / count
```

**File: `tests/test_calculator.py`**
```python
import pytest
from src.calculator import add, subtract, multiply, divide, average

def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0

def test_subtract():
    assert subtract(5, 3) == 2
    assert subtract(1, 1) == 0

def test_multiply():
    assert multiply(3, 4) == 12
    assert multiply(-2, 3) == -6

def test_divide():
    assert divide(10, 2) == 5
    assert divide(9, 3) == 3
    # This will cause an error
    with pytest.raises(ZeroDivisionError):
        divide(5, 0)

def test_average():
    assert average([1, 2, 3, 4, 5]) == 3.0
    assert average([10, 20]) == 15.0
    # This will cause an error
    assert average([]) == 0  # BUG: Should handle empty list
```

**File: `tests/__init__.py`**
```python
# Empty file to make tests a package
```

**File: `src/__init__.py`**
```python
# Empty file to make src a package
```

### Test Execution

1. **User Input**:
   ```
   "Run the test suite"
   ```

2. **Expected Command**:
   ```bash
   pytest tests/ -v
   ```

3. **Expected Output**:
   ```
   FAILED tests/test_calculator.py::test_divide - ZeroDivisionError
   FAILED tests/test_calculator.py::test_average - ZeroDivisionError
   ```

### Expected Agent Behavior

#### 1. Agent Activation
- [ ] Debug agent activates automatically on test failure detection
- [ ] Agent recognizes "test failure" trigger
- [ ] Agent announces it will use 6-step methodology

#### 2. Step 1: Reproduce
- [ ] Agent reads and displays complete error messages
- [ ] Agent identifies which tests failed
- [ ] Agent documents exact conditions (empty list, zero division)
- [ ] Agent verifies errors are reproducible

**Expected Output Format**:
```markdown
## STEP 1: Reproduction ✓

**Error Messages**:
1. test_divide: ZeroDivisionError on divide(5, 0)
2. test_average: ZeroDivisionError on average([])

**Trigger Conditions**:
- Test 1: Division by zero
- Test 2: Empty list causing len([]) = 0

**Consistency**: Both fail reliably (100% reproduction)
```

#### 3. Step 2: Isolate
- [ ] Agent identifies specific functions (divide, average)
- [ ] Agent reads source code for both functions
- [ ] Agent locates exact lines causing errors
- [ ] Agent checks for similar patterns in codebase

**Expected Output Format**:
```markdown
## STEP 2: Isolation ✓

**Location 1**: src/calculator.py:15 (divide function)
**Issue**: No check for b == 0 before division

**Location 2**: src/calculator.py:21 (average function)
**Issue**: No check for empty list before division by len(numbers)

**Pattern**: Both involve division without validation
```

#### 4. Step 3: Hypothesis
- [ ] Agent forms clear theory about root cause
- [ ] Agent explains why the errors occur
- [ ] Agent considers edge cases
- [ ] Agent proposes solution approach

**Expected Output Format**:
```markdown
## STEP 3: Hypothesis ✓

**Primary Theory**:
Both functions perform division without validating divisor is non-zero.
- divide(a, b): No check for b == 0
- average(numbers): No check for len(numbers) == 0

**Evidence**:
- ZeroDivisionError is Python's standard error for division by zero
- Test shows both fail on zero-related edge cases
- No validation logic present in functions

**Predicted Fix**:
Add validation before division operations in both functions
```

#### 5. Step 4: Test
- [ ] Agent validates hypothesis (confirms it's zero division)
- [ ] Agent doesn't rush to fix
- [ ] Agent checks if there are other similar patterns

**Expected Output Format**:
```markdown
## STEP 4: Testing ✓

**Validation**: Hypothesis confirmed
- divide(5, 0) → ZeroDivisionError (as expected)
- average([]) → len([]) = 0 → ZeroDivisionError (as expected)

**Similar Patterns Check**:
Searched codebase for other division operations:
- multiply: No division ✓
- add/subtract: No division ✓
- Only divide and average have this pattern
```

#### 6. Step 5: Fix
- [ ] Agent implements validation in both functions
- [ ] Agent adds appropriate error handling
- [ ] Agent considers return values for edge cases
- [ ] Agent doesn't introduce new bugs

**Expected Output Format**:
```markdown
## STEP 5: Fix ✓

**Changes**:

1. divide function - Add zero check:
```python
def divide(a, b):
    """Divide a by b"""
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
```

2. average function - Add empty list check:
```python
def average(numbers):
    """Calculate average of a list of numbers"""
    if not numbers:
        raise ValueError("Cannot calculate average of empty list")
    total = sum(numbers)
    count = len(numbers)
    return total / count
```

**Rationale**: Explicit ValueError with message is more helpful than ZeroDivisionError
```

#### 7. Step 6: Verify
- [ ] Agent runs tests again
- [ ] Agent verifies all tests pass
- [ ] Agent checks for regressions
- [ ] Agent confirms edge cases are handled

**Expected Output Format**:
```markdown
## STEP 6: Verification ✓

**Test Results**:
```bash
pytest tests/ -v

PASSED tests/test_calculator.py::test_add
PASSED tests/test_calculator.py::test_divide
PASSED tests/test_calculator.py::test_average
All tests passed ✓
```

**Regression Check**: No regressions, all original functionality preserved
```

### Success Criteria

- [x] Agent activates automatically on test failure
- [x] All 6 steps are executed in order
- [x] No steps are skipped
- [x] Agent doesn't rush to implement fix (validates hypothesis first)
- [x] Root cause is identified before fixing
- [x] Similar patterns are found and fixed
- [x] Verification is comprehensive (all tests, edge cases)
- [x] Output follows the structured format from instructions

### Failure Modes to Watch For

❌ **Skipping Steps**
- Agent jumps directly to fix without hypothesis
- Agent doesn't validate hypothesis before fixing
- Agent skips verification

❌ **Trial-and-Error**
- Agent tries random fixes
- Agent makes changes without understanding root cause
- Agent fixes one issue but misses the pattern

❌ **Incomplete Verification**
- Agent only tests the originally failing tests
- Agent doesn't check for regressions
- Agent doesn't test edge cases

---

## Test Scenario 2: Bash Command Error

### Setup

Create a situation where a bash command fails.

**File: `package.json`**
```json
{
  "name": "test-project",
  "version": "1.0.0",
  "scripts": {
    "test": "jest",
    "build": "webpack --config webpack.config.js"
  },
  "devDependencies": {
    "webpack": "^5.0.0"
  }
}
```

### Test Execution

1. **User Input**:
   ```
   "Run the build script"
   ```

2. **Expected Command**:
   ```bash
   npm run build
   ```

3. **Expected Error**:
   ```
   Error: Cannot find module 'webpack-cli'
   ```

### Expected Agent Behavior

- [ ] Auto-activates on non-zero exit code
- [ ] Reads complete error message
- [ ] Identifies missing webpack-cli dependency
- [ ] Proposes installing webpack-cli
- [ ] Verifies installation succeeds
- [ ] Confirms build works after fix

### Success Criteria

- [x] Agent follows all 6 steps
- [x] Agent identifies webpack-cli as missing dependency
- [x] Agent proposes `npm install webpack-cli --save-dev`
- [x] Agent verifies build succeeds after fix

---

## Test Scenario 3: Manual Activation with Keyword

### Setup

No setup needed - use existing code with a bug.

### Test Execution

1. **User Input**:
   ```
   "My function is broken and I can't figure out why. Can you help debug it?"
   ```

2. **Expected Behavior**:
   - Agent should activate on keyword "debug"
   - Agent should ask user to provide details for Step 1 (Reproduce)
   - Agent should guide through all 6 steps interactively

### Success Criteria

- [x] Agent activates on "debug" keyword
- [x] Agent asks clarifying questions for reproduction
- [x] Agent guides user through methodology
- [x] Agent maintains structure even without automatic error

---

## Test Scenario 4: Anti-Pattern Detection

### Setup

Create a scenario where the user tries to skip steps.

### Test Execution

1. **User Input after seeing error**:
   ```
   "Just wrap it in a try-catch and suppress the error"
   ```

2. **Expected Agent Behavior**:
   - Agent should detect symptom-fixing anti-pattern
   - Agent should gently redirect to proper methodology
   - Agent should explain why try-catch isn't the right solution
   - Agent should continue with Step 2 (Isolate)

### Success Criteria

- [x] Agent recognizes symptom-fixing anti-pattern
- [x] Agent provides educational feedback
- [x] Agent redirects to systematic approach
- [x] Agent doesn't allow skipping steps

---

## Manual Testing Instructions

### How to Run These Tests

1. **Set up the debug agent**:
   ```bash
   # Ensure agent files are in place
   ls -la .claude/agents/debug-agent/
   ```

2. **Activate Claude Code**:
   ```bash
   claude
   ```

3. **Run Scenario 1**:
   ```
   1. Create the calculator.py and test files
   2. Type: "Run the test suite"
   3. Observe agent activation and methodology
   4. Verify all 6 steps are followed
   ```

4. **Run Scenario 2**:
   ```
   1. Create package.json
   2. Type: "Run the build script"
   3. Observe agent handling of bash error
   4. Verify fix is appropriate
   ```

5. **Run Scenario 3**:
   ```
   1. Type: "My function is broken and I can't figure out why. Can you help debug it?"
   2. Observe manual activation
   3. Provide details as requested
   4. Verify guided process
   ```

6. **Run Scenario 4**:
   ```
   1. Trigger an error
   2. Suggest a bad fix (try-catch suppression)
   3. Observe agent correction
   4. Verify educational feedback
   ```

### Validation Checklist

For each scenario, verify:

- [ ] Agent activates appropriately (auto or manual)
- [ ] All 6 steps are present in output
- [ ] Steps are executed in order
- [ ] No steps are skipped
- [ ] Output matches expected format
- [ ] Root cause is identified before fixing
- [ ] Fix is minimal and targeted
- [ ] Verification is comprehensive
- [ ] Anti-patterns are avoided/corrected

### Expected Time

- Scenario 1: 15-20 minutes
- Scenario 2: 10-15 minutes
- Scenario 3: 10-15 minutes
- Scenario 4: 5-10 minutes

**Total**: 40-60 minutes for complete validation

---

## Success Metrics

### Quantitative Metrics

- **Step Completion**: 100% of 6 steps executed
- **Step Order**: 100% in correct sequence
- **Pattern Detection**: 100% of similar bugs found
- **Verification Coverage**: Tests + edge cases + regressions

### Qualitative Metrics

- **Methodology Adherence**: Strong vs weak enforcement
- **Educational Value**: Does output teach debugging?
- **Clarity**: Are steps clearly delineated?
- **Helpfulness**: Are explanations useful?

### Pass/Fail Criteria

**PASS**: All scenarios execute with:
- ✓ All 6 steps present and ordered
- ✓ Root cause identified before fixing
- ✓ Comprehensive verification
- ✓ Anti-patterns avoided

**FAIL**: Any scenario shows:
- ✗ Skipped steps
- ✗ Trial-and-error approach
- ✗ Symptom fixing
- ✗ Incomplete verification

---

## Notes for Evaluators

1. **Flexibility**: The agent should enforce methodology but not be robotic. Natural language flow is acceptable as long as all steps are present.

2. **Adaptation**: For trivial bugs (typos), the agent may note "this is trivial" but should still document the process briefly.

3. **Time Constraints**: In production emergencies, the agent should acknowledge the urgency but still follow the steps quickly.

4. **User Experience**: The agent should be helpful, not pedantic. Education over enforcement.

5. **Output Format**: Exact formatting may vary, but all 6 steps must be clearly identifiable in the output.

---

## Future Test Scenarios

Additional scenarios to consider:

1. **Multi-error debugging**: Multiple unrelated errors
2. **Intermittent bugs**: Non-deterministic failures
3. **Performance issues**: Not errors, but problems
4. **Integration failures**: Cross-system issues
5. **Security vulnerabilities**: Require special handling

These can be added as the agent matures.
