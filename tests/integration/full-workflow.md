# Phase 2 Integration Testing - Full Workflow

## Test Plan Overview

**Purpose**: Comprehensive integration testing of the entire Phase 2 system including all agents, hooks, and trigger mechanisms.

**Scope**: End-to-end validation of:
- Agent activation (keyword and tool-based triggers)
- Hook execution (pre-implementation, post-error, post-implementation)
- Trigger system (precedence, conflict resolution, bypass mechanisms)
- Metrics collection and logging
- Integration with standard workflows
- Error handling and graceful degradation
- Performance benchmarks

**Test Date**: 2025-11-19
**Test Version**: 1.0.0
**Testers**: Claude Code Team

---

## Test Environment Setup

### Prerequisites

1. **Agent Configurations**:
   - `.claude/agents/debug-agent/` - 6-step debugging methodology
   - `.claude/agents/consistency-agent/` - Pattern detection and reuse
   - `.claude/agents/quality-agent/` - 7-category quality checklist

2. **Hook Configurations**:
   - Pre-implementation hook (consistency checks before Edit/Write)
   - Post-error hook (debug methodology on errors)
   - Post-implementation hook (quality review on completion)

3. **Trigger System**:
   - `.claude/config/triggers.yml` - Comprehensive trigger rules
   - Keyword triggers for all three agents
   - Tool-based triggers (Bash errors, Edit/Write operations)
   - Precedence rules (Debug > Quality > Consistency)

4. **Test Codebase**:
   - Sample project with existing patterns
   - Test files that can fail
   - Mock API endpoints, components, models

### Environment Validation

Before running tests, verify:

```bash
# Check all agent configurations exist
ls -la .claude/agents/*/instructions.md

# Check hook configurations
ls -la .claude/hooks/

# Check trigger configuration
cat .claude/config/triggers.yml | head -20

# Verify test directory structure
tree tests/
```

**Expected**: All configuration files present and readable.

---

## Success Criteria

### Integration Test Acceptance

✅ **All Three Agents Functional**:
- Debug agent activates on errors and enforces 6-step methodology
- Consistency agent finds patterns and suggests reuse
- Quality agent reviews code against 7-category checklist

✅ **Hooks Execute Correctly**:
- Pre-implementation hook triggers before Edit/Write
- Post-error hook triggers on non-zero exit codes
- Post-implementation hook triggers on completion keywords

✅ **Trigger System Works**:
- Keyword triggers activate appropriate agents
- Tool triggers fire on Bash errors, Edit/Write operations
- Precedence rules resolve conflicts correctly
- Bypass mechanisms function as designed

✅ **End-to-End Workflows Complete**:
- Bug fix workflow: Error → Debug → Fix → Quality Review → Commit
- Feature workflow: Request → Pattern Search → Implementation → Quality Review → Commit
- No conflicts between components
- Graceful degradation on errors

✅ **Performance Acceptable**:
- Agent activation < 2 seconds
- Pattern search < 30 seconds
- Quality review < 2 minutes
- Total workflow overhead < 20% of implementation time

✅ **Metrics Collection Working**:
- Trigger events logged to `.claude/logs/trigger-events.jsonl`
- Agent activations tracked
- Performance metrics captured

---

## Test Execution Instructions

### Running the Tests

1. **Execute each scenario sequentially** (they build on each other)
2. **Document results in real-time** (copy output, note observations)
3. **Record all issues** (even minor ones) in the Issues section
4. **Measure performance** (time each operation)
5. **Verify metrics** (check log files after each test)

### Documentation Template

For each test scenario, document:

```markdown
## Test: [Scenario Name]

**Date**: YYYY-MM-DD HH:MM
**Duration**: X minutes
**Result**: PASS / FAIL / PARTIAL

### Execution Steps
1. [Step taken]
2. [Step taken]
...

### Expected Behavior
- [What should happen]

### Actual Behavior
- [What actually happened]

### Issues Found
- [Issue #1]
- [Issue #2]

### Performance Metrics
- Agent activation time: X seconds
- Total duration: X minutes
- Files analyzed: X
- Tokens used: ~X

### Verdict
✅ PASS / ❌ FAIL / ⚠️ PARTIAL

### Notes
[Additional observations]
```

---

## Test Scenario 1: Bug Fix Workflow

### Objective

Validate the complete bug fix workflow from error detection through debugging to quality review and commit.

### Test Setup

Create a failing test scenario to trigger the debug agent:

**File**: `/home/user/claude-skill-eval/test-project/src/calculator.py`

```python
def divide(a, b):
    """Divide a by b"""
    return a / b  # BUG: No check for division by zero
```

**File**: `/home/user/claude-skill-eval/test-project/tests/test_calculator.py`

```python
import pytest
from src.calculator import divide

def test_divide():
    assert divide(10, 2) == 5
    # This will fail
    with pytest.raises(ZeroDivisionError):
        divide(5, 0)
```

### Execution Steps

#### Step 1: Trigger the Error

**User Action**: "Run the test suite"

**Expected**:
1. Command executes: `pytest tests/ -v`
2. Test fails with ZeroDivisionError
3. Non-zero exit code triggers post-error hook
4. Debug agent activates automatically

**Validation**:
- [ ] Pytest runs and reports failure
- [ ] Exit code is non-zero
- [ ] Debug agent announces activation
- [ ] Debug agent identifies this as systematic debugging task

**Document**:
```
Command: pytest tests/ -v
Exit Code: [1]
Error Output: [Copy actual error]
Agent Activated: [Yes/No]
Agent Announcement: [Copy agent message]
```

#### Step 2: Reproduce (Debug Step 1)

**Expected Debug Agent Behavior**:
- Reads complete error output
- Identifies test_divide as failing test
- Documents exact error: ZeroDivisionError
- Notes test expects error to be raised but it isn't

**Validation**:
- [ ] Agent reads test file
- [ ] Agent identifies the test expectation (pytest.raises)
- [ ] Agent documents reproduction steps
- [ ] Agent confirms error is reproducible
- [ ] Output includes "STEP 1: Reproduction ✓" header

**Document**:
```
Step 1 Output: [Copy agent's Step 1 output]
Files Read: [List files agent accessed]
Time Taken: [X seconds]
```

#### Step 3: Isolate (Debug Step 2)

**Expected Debug Agent Behavior**:
- Reads `src/calculator.py`
- Identifies `divide` function at line X
- Notes: No validation before division operation
- Isolates issue to specific line: `return a / b`

**Validation**:
- [ ] Agent reads source file
- [ ] Agent identifies exact line number
- [ ] Agent explains the issue (missing validation)
- [ ] Output includes "STEP 2: Isolation ✓" header

**Document**:
```
Step 2 Output: [Copy agent's Step 2 output]
Line Identified: [Line number]
Issue Description: [Copy agent's explanation]
```

#### Step 4: Hypothesis (Debug Step 3)

**Expected Debug Agent Behavior**:
- Forms hypothesis: "Function doesn't validate b != 0 before division"
- Explains why test expects ZeroDivisionError to be raised
- Proposes solution approach: Add validation and raise explicit error

**Validation**:
- [ ] Agent forms clear hypothesis
- [ ] Agent explains root cause
- [ ] Agent proposes solution direction
- [ ] Output includes "STEP 3: Hypothesis ✓" header

**Document**:
```
Step 3 Output: [Copy agent's hypothesis]
Root Cause Identified: [Yes/No]
Solution Approach: [Copy proposed approach]
```

#### Step 5: Test Hypothesis (Debug Step 4)

**Expected Debug Agent Behavior**:
- Validates hypothesis (confirms no validation exists)
- May test with simple check
- Confirms this is the root cause
- Ready to proceed to fix

**Validation**:
- [ ] Agent validates hypothesis
- [ ] Agent confirms root cause
- [ ] No premature fixing
- [ ] Output includes "STEP 4: Testing ✓" header

**Document**:
```
Step 4 Output: [Copy agent's validation]
Hypothesis Confirmed: [Yes/No]
```

#### Step 6: Implement Fix (Debug Step 5)

**Expected Debug Agent Behavior**:
- Edits `calculator.py` to add validation
- Raises ValueError with clear message when b == 0
- Updates test to expect ValueError instead of ZeroDivisionError
- Fix is minimal and targeted

**Validation**:
- [ ] Agent uses Edit tool to modify code
- [ ] Validation added before division
- [ ] Appropriate error type raised
- [ ] Test updated if needed
- [ ] Output includes "STEP 5: Fix ✓" header

**Document**:
```
Step 5 Output: [Copy agent's fix implementation]
Files Modified: [List files]
Fix Applied: [Describe the fix]
```

#### Step 7: Verify Fix (Debug Step 6)

**Expected Debug Agent Behavior**:
- Runs pytest again
- All tests pass (exit code 0)
- Confirms no regressions
- Verification complete

**Validation**:
- [ ] Agent runs pytest
- [ ] Tests pass
- [ ] Exit code is 0
- [ ] No regressions introduced
- [ ] Output includes "STEP 6: Verification ✓" header

**Document**:
```
Step 6 Output: [Copy agent's verification]
Test Results: [PASS/FAIL]
Exit Code: [0]
Regressions: [None/List any]
```

#### Step 8: Quality Review Trigger

**User Action**: "Done fixing the bug, ready to commit"

**Expected**:
- Post-implementation hook detects completion keyword "done"
- Quality agent activates
- Reviews the changes made during debugging
- Runs 7-category quality checklist

**Validation**:
- [ ] Quality agent activates on "done" keyword
- [ ] Agent identifies files changed
- [ ] Agent runs quality checklist
- [ ] Agent generates quality report

**Document**:
```
Quality Agent Activated: [Yes/No]
Files Reviewed: [List files]
Checklist Execution: [Yes/No]
```

#### Step 9: Quality Review Results

**Expected Quality Agent Behavior**:
- Reviews `calculator.py` and `test_calculator.py`
- Checklist results:
  - ✅ Tests: PASS (test exists and passes)
  - ✅ Documentation: PASS (function has docstring)
  - ✅ Error Handling: PASS (validation added)
  - ✅ Edge Cases: PASS (zero division handled)
  - ✅ Security: PASS (no security concerns)
  - ✅ Code Quality: PASS (clean, simple fix)
  - ✅ Integration: PASS (no integration issues)
- Verdict: ✅ PASS - Ready to commit

**Validation**:
- [ ] All 7 checklist categories evaluated
- [ ] No blocking issues found
- [ ] Clear verdict provided
- [ ] Commit approval given

**Document**:
```
Quality Report: [Copy agent's report]
Verdict: [PASS/PASS WITH RECOMMENDATIONS/REQUIRES CHANGES]
Issues Found: [List any]
Commit Approved: [Yes/No]
```

#### Step 10: Metrics Verification

**Expected**:
- Trigger events logged in `.claude/logs/trigger-events.jsonl`
- Metrics captured:
  - bash-error-trigger activation
  - debug-agent activation and completion
  - quality-keyword-trigger activation
  - quality-agent activation and completion

**Validation**:
- [ ] Log file exists
- [ ] Trigger events recorded
- [ ] Agent activations logged
- [ ] Timestamps and durations captured

**Document**:
```bash
# Check metrics
cat .claude/logs/trigger-events.jsonl | tail -10
```

```
Metrics Captured: [Yes/No]
Events Logged: [Count]
Log Sample: [Copy relevant log entries]
```

### Test Scenario 1: Expected Results

**Complete Workflow**:
```
Error → Post-Error Hook → Debug Agent (6 steps) → Fix →
Completion Keyword → Post-Implementation Hook → Quality Agent →
Quality Review → Commit Approval → Metrics Logged
```

**Success Criteria**:
- ✅ All 6 debug steps executed in order
- ✅ Bug fixed correctly
- ✅ Quality review passed
- ✅ Metrics logged
- ✅ Workflow completed without manual intervention
- ✅ Total time < 10 minutes

### Test Scenario 1: Results

**[TO BE FILLED DURING TEST EXECUTION]**

```markdown
Date: ___________
Duration: ___________
Result: PASS / FAIL / PARTIAL

Issues Found:
-

Performance:
- Agent activation: ___ seconds
- Debug process: ___ minutes
- Quality review: ___ minutes
- Total: ___ minutes

Verdict: ✅ PASS / ❌ FAIL / ⚠️ PARTIAL

Notes:
```

---

## Test Scenario 2: Feature Implementation Workflow

### Objective

Validate the complete feature implementation workflow including pattern detection, implementation, and quality review.

### Test Setup

Create a codebase with existing patterns:

**File**: `/home/user/claude-skill-eval/test-project/api/routes/users.js`

```javascript
const express = require('express');
const router = express.Router();
const { authenticate, validate } = require('../middleware');
const { createUser } = require('../controllers/users');
const { userSchema } = require('../schemas/user');

// POST /api/users - Create user
router.post('/',
  authenticate,
  validate(userSchema),
  async (req, res, next) => {
    try {
      const user = await createUser(req.body);
      res.status(201).json({
        success: true,
        data: user
      });
    } catch (error) {
      next(error);
    }
  }
);

module.exports = router;
```

**File**: `/home/user/claude-skill-eval/test-project/api/routes/products.js`

```javascript
const express = require('express');
const router = express.Router();
const { authenticate, validate } = require('../middleware');
const { createProduct } = require('../controllers/products');
const { productSchema } = require('../schemas/product');

// POST /api/products - Create product
router.post('/',
  authenticate,
  validate(productSchema),
  async (req, res, next) => {
    try {
      const product = await createProduct(req.body);
      res.status(201).json({
        success: true,
        data: product
      });
    } catch (error) {
      next(error);
    }
  }
);

module.exports = router;
```

### Execution Steps

#### Step 1: Request Feature Implementation

**User Action**: "Add a POST endpoint for creating categories at /api/categories"

**Expected**:
- Keyword "Add" triggers consistency-agent
- Pre-implementation hook activates
- Agent classifies task as API endpoint creation
- Agent searches for similar patterns

**Validation**:
- [ ] Consistency agent activates
- [ ] Agent identifies task type (API endpoint)
- [ ] Agent announces pattern search

**Document**:
```
User Request: "Add a POST endpoint for creating categories at /api/categories"
Agent Activated: [Yes/No]
Task Classification: [Copy agent's classification]
```

#### Step 2: Pattern Search

**Expected Consistency Agent Behavior**:
- Glob search: `**/routes/**/*.js`
- Grep search: `router.post` in routes
- Reads `users.js` and `products.js`
- Identifies common pattern:
  - Express router
  - Middleware chain: authenticate → validate → handler
  - Async handler with try/catch
  - Standard response format: `{ success: true, data: {...} }`
  - Error passed to next()

**Validation**:
- [ ] Agent searches routes directory
- [ ] Agent finds 2 similar endpoints
- [ ] Agent reads both files
- [ ] Agent extracts common pattern
- [ ] Search completes in < 30 seconds

**Document**:
```
Search Strategy: [Glob/Grep patterns used]
Files Found: [List files]
Pattern Identified: [Yes/No]
Search Duration: [X seconds]
Pattern Description: [Copy agent's pattern description]
```

#### Step 3: Pattern Recommendation

**Expected Consistency Agent Behavior**:
- Presents analysis results
- Shows 2 matching files (users.js, products.js)
- Extracts common elements:
  - Middleware: authenticate, validate
  - Schema-based validation
  - Async handler structure
  - Error handling pattern
  - Response format
- Recommends following this pattern
- Asks for user confirmation

**Validation**:
- [ ] Clear pattern presentation
- [ ] Specific code examples shown
- [ ] Recommendation is actionable
- [ ] User asked for confirmation

**Document**:
```
Pattern Recommendation: [Copy agent's recommendation]
Confidence Level: [High/Medium/Low]
Code Examples Provided: [Yes/No]
User Prompted for Confirmation: [Yes/No]
```

#### Step 4: Implement Following Pattern

**User Action**: "Yes, use that pattern"

**Expected**:
- Agent creates `categories.js` following the pattern
- Uses Edit or Write tool
- Maintains consistency:
  - Same middleware chain
  - Same response format
  - Same error handling
  - Creates categorySchema reference

**Validation**:
- [ ] New file created or existing file edited
- [ ] Pattern followed correctly
- [ ] Middleware chain matches
- [ ] Response format consistent
- [ ] Error handling included

**Document**:
```
Implementation: [Copy created code or diff]
Pattern Followed: [Yes/No]
Deviations: [List any differences from pattern]
Tool Used: [Edit/Write]
```

#### Step 5: Quality Review Trigger

**User Action**: "Implementation complete, ready to commit"

**Expected**:
- Keywords "complete" and "commit" trigger post-implementation hook
- Quality agent activates
- Agent identifies new/changed files
- Agent runs 7-category quality checklist

**Validation**:
- [ ] Quality agent activates
- [ ] Changed files identified
- [ ] Checklist execution begins

**Document**:
```
Quality Agent Activated: [Yes/No]
Files to Review: [List files]
Trigger Keywords Detected: [complete, commit]
```

#### Step 6: Quality Checklist Execution

**Expected Quality Agent Behavior**:

Reviews `categories.js` against 7 categories:

1. **Test Coverage**:
   - ⚠️ WARNING: No tests found for categories endpoint
   - Recommendation: Add tests following users.test.js pattern

2. **Documentation**:
   - ✅ PASS: Route documented with comments
   - ⚠️ SUGGESTION: Could add JSDoc comments

3. **Error Handling**:
   - ✅ PASS: Try/catch implemented
   - ✅ PASS: Errors passed to next()

4. **Performance**:
   - ✅ PASS: Async/await used correctly
   - ✅ PASS: No blocking operations

5. **Security**:
   - ✅ PASS: Authentication middleware present
   - ✅ PASS: Validation middleware present
   - ⚠️ NOTE: Ensure categorySchema validates all inputs

6. **Code Quality**:
   - ✅ PASS: Follows project patterns
   - ✅ PASS: Consistent with existing code
   - ✅ PASS: Readable and maintainable

7. **Integration**:
   - ⚠️ WARNING: categorySchema not found
   - ⚠️ WARNING: createCategory controller not found
   - Recommendation: Implement missing dependencies

**Validation**:
- [ ] All 7 categories evaluated
- [ ] Specific issues identified
- [ ] Recommendations provided
- [ ] Verdict appropriate

**Document**:
```
Quality Report: [Copy full report]
Categories Evaluated: [7]
Issues Found: [Count and list]
Verdict: [PASS/PASS WITH RECOMMENDATIONS/REQUIRES CHANGES]
```

#### Step 7: Quality Verdict

**Expected**:
- Verdict: ⚠️ PASS WITH RECOMMENDATIONS
- Required actions:
  - Create categorySchema
  - Create createCategory controller
  - Add tests
- Optional suggestions:
  - Add JSDoc comments
- Allows commit but recommends addressing required items

**Validation**:
- [ ] Clear verdict provided
- [ ] Issues categorized (required vs optional)
- [ ] Next steps outlined
- [ ] Commit decision clear

**Document**:
```
Final Verdict: [Copy verdict]
Required Actions: [List]
Optional Suggestions: [List]
Commit Allowed: [Yes/No]
```

#### Step 8: Pattern Consistency Verification

**Verification**:
Compare `categories.js` with `users.js` and `products.js`:

- [ ] Middleware chain identical
- [ ] Response format identical
- [ ] Error handling identical
- [ ] Code structure similar
- [ ] Naming conventions followed

**Document**:
```
Consistency Check:
- Middleware: [Matches/Differs]
- Response format: [Matches/Differs]
- Error handling: [Matches/Differs]
- Overall consistency: [High/Medium/Low]
```

#### Step 9: Metrics Verification

**Expected**:
- Trigger events logged:
  - consistency-keyword-trigger ("Add")
  - pre-write-trigger or pre-edit-trigger
  - consistency-agent activation
  - quality-keyword-trigger ("complete", "commit")
  - quality-agent activation

**Validation**:
- [ ] All trigger events logged
- [ ] Agent activations recorded
- [ ] Pattern search metrics captured
- [ ] Quality review metrics captured

**Document**:
```bash
# Check metrics
cat .claude/logs/trigger-events.jsonl | grep -E "consistency|quality" | tail -20
```

```
Metrics Captured: [Yes/No]
Trigger Events: [List logged events]
```

### Test Scenario 2: Expected Results

**Complete Workflow**:
```
Feature Request → Pre-Implementation Hook → Consistency Agent →
Pattern Search → Pattern Found → Recommendation →
User Approval → Implementation → Completion Keyword →
Post-Implementation Hook → Quality Agent → Quality Review →
Recommendations → Metrics Logged
```

**Success Criteria**:
- ✅ Pattern search successful
- ✅ Pattern correctly identified
- ✅ Implementation follows pattern
- ✅ Quality review thorough
- ✅ Metrics logged
- ✅ Total time < 15 minutes

### Test Scenario 2: Results

**[TO BE FILLED DURING TEST EXECUTION]**

```markdown
Date: ___________
Duration: ___________
Result: PASS / FAIL / PARTIAL

Issues Found:
-

Performance:
- Pattern search: ___ seconds
- Implementation: ___ minutes
- Quality review: ___ minutes
- Total: ___ minutes

Verdict: ✅ PASS / ❌ FAIL / ⚠️ PARTIAL

Notes:
```

---

## Test Scenario 3: Obra Integration and Bypass Testing

### Objective

Validate compatibility with standard workflows and test bypass mechanisms to ensure the system enhances rather than blocks work.

### Part A: Standard Workflow Compatibility

#### Test 1: Simple File Edit (Should Not Trigger Agents)

**User Action**: Edit a markdown file to fix a typo

```
"Fix typo in README.md - change 'installtion' to 'installation'"
```

**Expected**:
- File edited successfully
- NO agent activation (markdown file excluded)
- Fast completion (< 5 seconds)

**Validation**:
- [ ] Edit completes successfully
- [ ] No agent interruption
- [ ] Workflow not blocked
- [ ] Performance not impacted

**Document**:
```
Action: [Edit README.md]
Agent Activated: [Yes/No - Should be No]
Duration: [X seconds]
Workflow Blocked: [Yes/No - Should be No]
```

#### Test 2: Minor Code Change (Should Trigger But Not Block)

**User Action**: Fix minor typo in a function

```
"Fix typo in function name: change 'getUserByEmial' to 'getUserByEmail'"
```

**Expected**:
- Edit completes
- Quality agent MAY activate (< 5 lines changed)
- Agent provides quick feedback but doesn't block
- Total time < 30 seconds

**Validation**:
- [ ] Edit completes
- [ ] Agent activation appropriate (may or may not trigger)
- [ ] If agent activates, feedback is quick
- [ ] Workflow not significantly slowed

**Document**:
```
Action: [Rename function]
Agent Activated: [Yes/No]
If Yes, Agent: [Which agent]
Feedback Provided: [Summary]
Duration: [X seconds]
Workflow Impact: [None/Minimal/Significant]
```

#### Test 3: Multi-Step Implementation (Should Trigger Coordination)

**User Action**: Complex feature with multiple steps

```
1. Create model
2. Create controller
3. Create route
4. Add tests
5. "Ready to review"
```

**Expected**:
- Consistency agent activates on create operations
- Quality agent activates on "ready to review"
- Agents coordinate (no conflicts)
- Clear workflow progression

**Validation**:
- [ ] Multiple agent activations
- [ ] No conflicts between agents
- [ ] Clear sequencing
- [ ] Smooth workflow

**Document**:
```
Steps Completed: [List]
Agents Activated: [List in order]
Conflicts: [None/List any]
Coordination Quality: [Excellent/Good/Poor]
```

### Part B: Bypass Mechanism Testing

#### Bypass Test 1: Environment Variable Bypass

**Setup**:
```bash
export CLAUDE_SKIP_AGENTS=true
```

**User Action**: Make a code change that would normally trigger agents

```
"Add a new API endpoint" (would normally trigger consistency agent)
```

**Expected**:
- NO agent activation
- Change completes normally
- Bypass respected

**Validation**:
- [ ] Environment variable recognized
- [ ] Agents bypassed
- [ ] Change completes successfully
- [ ] No warnings or errors

**Document**:
```
Bypass Method: Environment variable
Variable: CLAUDE_SKIP_AGENTS=true
Agent Activated: [Yes/No - Should be No]
Bypass Effective: [Yes/No]
```

**Cleanup**:
```bash
unset CLAUDE_SKIP_AGENTS
```

#### Bypass Test 2: File Pattern Bypass

**User Action**: Edit a test file

```
"Add test case to tests/test_user.py"
```

**Expected**:
- Quality standards relaxed for test files
- Some checks may still run but with lower thresholds
- No blocking for test-specific patterns

**Validation**:
- [ ] Test file pattern recognized
- [ ] Quality standards adjusted
- [ ] No inappropriate blocking

**Document**:
```
File Pattern: tests/**/*.py
Standards Applied: [Relaxed/Normal/Strict]
Bypass Working: [Yes/No]
```

#### Bypass Test 3: Explicit Skip Flag (Simulated)

**User Action**: Request to skip quality check

```
"Add feature --skip-quality-check"
```

**Expected**:
- Agent recognizes skip request
- Quality check bypassed
- User intent respected

**Validation**:
- [ ] Skip flag recognized
- [ ] Quality check bypassed
- [ ] Implementation completes

**Document**:
```
Skip Method: Explicit flag
Flag: --skip-quality-check
Agent Bypassed: [Yes/No]
Bypass Effective: [Yes/No]
```

### Part C: Error Handling and Graceful Degradation

#### Error Test 1: Agent Configuration Missing

**Setup**: Temporarily rename an agent directory

```bash
mv .claude/agents/quality-agent .claude/agents/quality-agent.bak
```

**User Action**: Trigger quality review

```
"Done with implementation, ready to commit"
```

**Expected**:
- System detects missing agent
- Warning message displayed
- Workflow continues (degrades gracefully)
- User can still commit

**Validation**:
- [ ] Missing agent detected
- [ ] Clear warning message
- [ ] Workflow not blocked
- [ ] Graceful degradation

**Document**:
```
Error: Missing agent configuration
Warning Displayed: [Yes/No]
Workflow Blocked: [Yes/No - Should be No]
User Experience: [Acceptable/Poor]
```

**Cleanup**:
```bash
mv .claude/agents/quality-agent.bak .claude/agents/quality-agent
```

#### Error Test 2: Trigger System Misconfiguration

**Setup**: Introduce YAML syntax error in triggers.yml

```bash
# Backup
cp .claude/config/triggers.yml .claude/config/triggers.yml.bak

# Introduce error (remove a closing bracket)
sed -i 's/activation_mode: immediate/activation_mode: immediate\n  invalid_yaml_here: [/' .claude/config/triggers.yml
```

**User Action**: Attempt to trigger agents

```
"Debug this failing test"
```

**Expected**:
- System detects YAML parsing error
- Error message with file and location
- Falls back to manual agent activation
- Workflow continues with degraded functionality

**Validation**:
- [ ] YAML error detected
- [ ] Clear error message
- [ ] Fallback mechanism works
- [ ] Critical functionality preserved

**Document**:
```
Error: YAML syntax error
Error Message: [Copy message]
Fallback Used: [Yes/No]
Workflow Continues: [Yes/No]
```

**Cleanup**:
```bash
mv .claude/config/triggers.yml.bak .claude/config/triggers.yml
```

#### Error Test 3: Agent Timeout Simulation

**Concept**: If an agent takes too long, workflow should continue

**Note**: This may be difficult to test without actual timeout configuration. Document expected behavior.

**Expected Behavior**:
- Agent has max execution time (configured in hooks)
- If exceeded, timeout warning displayed
- Workflow continues
- User notified of incomplete agent execution

**Document**:
```
Timeout Handling: [Describe expected behavior]
Configuration Location: [Where timeout is set]
Tested: [Yes/No]
If No, Why: [Reason]
```

### Part D: Performance Benchmarks

#### Benchmark 1: Agent Activation Overhead

**Test**: Measure time from trigger to agent activation

**Method**:
1. Record timestamp before trigger
2. Trigger agent (e.g., "debug this error")
3. Record timestamp when agent announces activation
4. Calculate delta

**Target**: < 2 seconds

**Document**:
```
Trigger: [Type of trigger]
Activation Time: [X.XX seconds]
Target: < 2 seconds
Result: [PASS/FAIL]
```

#### Benchmark 2: Pattern Search Performance

**Test**: Measure pattern search duration

**Method**:
1. Request pattern-based implementation
2. Time from search start to recommendation
3. Note number of files searched

**Target**: < 30 seconds for codebase with ~100 files

**Document**:
```
Files in Codebase: [Count]
Files Searched: [Count]
Search Duration: [X.XX seconds]
Target: < 30 seconds
Result: [PASS/FAIL]
```

#### Benchmark 3: Quality Review Performance

**Test**: Measure quality review duration

**Method**:
1. Trigger quality review
2. Time from activation to verdict
3. Note number of files and lines reviewed

**Target**: < 2 minutes for typical change (100-200 lines)

**Document**:
```
Files Reviewed: [Count]
Lines of Code: [Count]
Review Duration: [X.XX seconds]
Target: < 2 minutes
Result: [PASS/FAIL]
```

#### Benchmark 4: End-to-End Workflow Overhead

**Test**: Compare with and without agents

**Method**:
1. Implement feature manually (no agents): Record time
2. Implement similar feature with agents: Record time
3. Calculate overhead percentage

**Target**: < 20% overhead

**Document**:
```
Manual Implementation: [X minutes]
With Agents: [Y minutes]
Overhead: [Z%]
Target: < 20%
Result: [PASS/FAIL]
Value Added: [Describe benefits that justify overhead]
```

### Test Scenario 3: Expected Results

**Complete Test Coverage**:
- ✅ Standard workflow compatibility verified
- ✅ Bypass mechanisms functional
- ✅ Error handling graceful
- ✅ Performance acceptable
- ✅ No blocking issues
- ✅ Enhanced workflow (not degraded)

### Test Scenario 3: Results

**[TO BE FILLED DURING TEST EXECUTION]**

```markdown
Date: ___________
Duration: ___________
Result: PASS / FAIL / PARTIAL

Part A - Workflow Compatibility:
- Simple edits: [PASS/FAIL]
- Minor changes: [PASS/FAIL]
- Complex features: [PASS/FAIL]

Part B - Bypass Mechanisms:
- Environment variable: [PASS/FAIL]
- File patterns: [PASS/FAIL]
- Explicit flags: [PASS/FAIL]

Part C - Error Handling:
- Missing agent: [PASS/FAIL]
- YAML error: [PASS/FAIL]
- Timeout handling: [TESTED/NOT TESTED]

Part D - Performance:
- Activation overhead: [X.XX s] [PASS/FAIL]
- Pattern search: [X.XX s] [PASS/FAIL]
- Quality review: [X.XX s] [PASS/FAIL]
- E2E overhead: [X%] [PASS/FAIL]

Overall Verdict: ✅ PASS / ❌ FAIL / ⚠️ PARTIAL

Notes:
```

---

## Issues Tracking Document

### Issues Found During Testing

**Format**: Document all issues discovered during integration testing.

#### Issue Template

```markdown
### Issue #X: [Title]

**Severity**: Critical / High / Medium / Low
**Category**: [Agent / Hook / Trigger / Performance / UX]
**Test Scenario**: [Which scenario revealed this]
**Discovered**: [Date and time]

**Description**:
[Clear description of the issue]

**Steps to Reproduce**:
1. [Step 1]
2. [Step 2]
...

**Expected Behavior**:
[What should happen]

**Actual Behavior**:
[What actually happened]

**Impact**:
[How this affects users/workflow]

**Proposed Fix**:
[Suggested solution or workaround]

**Status**: Open / In Progress / Fixed / Won't Fix
**Priority**: P0 / P1 / P2 / P3

**Notes**:
[Additional context]
```

### Critical Issues (P0)

**[TO BE FILLED IF FOUND]**

### High Priority Issues (P1)

**[TO BE FILLED IF FOUND]**

### Medium Priority Issues (P2)

**[TO BE FILLED IF FOUND]**

### Low Priority Issues (P3)

**[TO BE FILLED IF FOUND]**

### Enhancement Suggestions

**[TO BE FILLED]**

---

## Refinement Recommendations

### Agent Interaction Refinements

**[TO BE FILLED BASED ON TEST RESULTS]**

Example format:
```markdown
### Refinement #1: [Title]

**Component**: [Agent/Hook/Trigger]
**Rationale**: [Why this refinement is needed]
**Proposed Change**:
[Specific change to make]

**Implementation**:
- [ ] Update configuration
- [ ] Test change
- [ ] Verify no regressions
- [ ] Update documentation

**Testing**:
[How to verify this refinement works]
```

---

## Test Coverage Matrix

### Agent Activation Coverage

| Trigger Type | Trigger Name | Agent | Test Scenario | Tested | Result |
|--------------|-------------|-------|---------------|--------|--------|
| Keyword | debug-keyword-trigger | debug-agent | Scenario 1 | [ ] | - |
| Keyword | consistency-keyword-trigger | consistency-agent | Scenario 2 | [ ] | - |
| Keyword | quality-keyword-trigger | quality-agent | Scenario 1, 2 | [ ] | - |
| Tool | bash-error-trigger | debug-agent | Scenario 1 | [ ] | - |
| Tool | test-failure-trigger | debug-agent | Scenario 1 | [ ] | - |
| Tool | pre-write-trigger | consistency-agent | Scenario 2 | [ ] | - |
| Tool | pre-edit-trigger | consistency-agent | Scenario 2 | [ ] | - |
| Tool | post-write-trigger | quality-agent | Scenario 2 | [ ] | - |
| Tool | multiple-edit-trigger | quality-agent | Scenario 2 | [ ] | - |
| Tool | pre-commit-trigger | quality-agent | Scenario 1, 2 | [ ] | - |

### Hook Execution Coverage

| Hook | Trigger Condition | Test Scenario | Tested | Result |
|------|------------------|---------------|--------|--------|
| Pre-Implementation | before:Write/Edit | Scenario 2 | [ ] | - |
| Post-Error | non-zero exit code | Scenario 1 | [ ] | - |
| Post-Implementation | completion keywords | Scenario 1, 2 | [ ] | - |

### Bypass Mechanism Coverage

| Bypass Type | Method | Test Scenario | Tested | Result |
|-------------|--------|---------------|--------|--------|
| Environment Variable | CLAUDE_SKIP_AGENTS | Scenario 3B | [ ] | - |
| Environment Variable | CLAUDE_SKIP_TRIGGERS | Scenario 3B | [ ] | - |
| File Pattern | tests/** | Scenario 3B | [ ] | - |
| File Pattern | docs/** | - | [ ] | - |
| Explicit Flag | --skip-triggers | Scenario 3B | [ ] | - |
| Explicit Flag | --skip-agent={name} | Scenario 3B | [ ] | - |

### Error Handling Coverage

| Error Condition | Expected Behavior | Test Scenario | Tested | Result |
|----------------|------------------|---------------|--------|--------|
| Missing agent config | Graceful degradation | Scenario 3C | [ ] | - |
| YAML syntax error | Error message + fallback | Scenario 3C | [ ] | - |
| Agent timeout | Timeout warning + continue | Scenario 3C | [ ] | - |
| File not found | Clear error message | - | [ ] | - |
| Permission denied | Clear error message | - | [ ] | - |

### Performance Coverage

| Metric | Target | Test Scenario | Measured | Result |
|--------|--------|---------------|----------|--------|
| Agent activation | < 2s | Scenario 3D | [ ] | - |
| Pattern search | < 30s | Scenario 3D | [ ] | - |
| Quality review | < 2min | Scenario 3D | [ ] | - |
| E2E overhead | < 20% | Scenario 3D | [ ] | - |

---

## Final Integration Test Report

### Executive Summary

**[TO BE COMPLETED AFTER ALL TESTS]**

```markdown
Test Date: [Date]
Test Duration: [Total time]
Scenarios Executed: [X of Y]
Overall Result: [PASS/FAIL/PARTIAL]

Key Findings:
-
-
-

Critical Issues: [Count]
High Priority Issues: [Count]
Medium Priority Issues: [Count]
Low Priority Issues: [Count]

Recommendation: [Deploy/Fix issues first/Major revision needed]
```

### Detailed Results

#### Test Scenario Results Summary

| Scenario | Result | Duration | Issues Found | Notes |
|----------|--------|----------|--------------|-------|
| 1. Bug Fix Workflow | [ ] | - | - | - |
| 2. Feature Implementation | [ ] | - | - | - |
| 3. Obra Integration | [ ] | - | - | - |

#### Component Health

| Component | Status | Confidence | Issues |
|-----------|--------|------------|--------|
| Debug Agent | [ ] | - | - |
| Consistency Agent | [ ] | - | - |
| Quality Agent | [ ] | - | - |
| Pre-Implementation Hook | [ ] | - | - |
| Post-Error Hook | [ ] | - | - |
| Post-Implementation Hook | [ ] | - | - |
| Trigger System | [ ] | - | - |
| Bypass Mechanisms | [ ] | - | - |
| Error Handling | [ ] | - | - |
| Performance | [ ] | - | - |

Legend:
- ✅ Fully Functional
- ⚠️ Functional with Issues
- ❌ Not Functional
- 🚧 Not Tested

### Test Coverage Achievement

**[TO BE CALCULATED]**

```
Total Test Cases: [X]
Executed: [Y]
Passed: [Z]
Failed: [A]
Coverage: [Z/X * 100]%
```

### Performance Summary

**[TO BE FILLED]**

```markdown
Agent Activation: [X.XX s] (Target: < 2s) [PASS/FAIL]
Pattern Search: [X.XX s] (Target: < 30s) [PASS/FAIL]
Quality Review: [X.XX s] (Target: < 2min) [PASS/FAIL]
E2E Overhead: [X%] (Target: < 20%) [PASS/FAIL]
```

### Issues Summary

**[TO BE FILLED]**

```markdown
Critical (P0): [Count]
- [List critical issues]

High (P1): [Count]
- [List high priority issues]

Medium (P2): [Count]
- [List medium priority issues]

Low (P3): [Count]
- [List low priority issues]
```

### Refinements Applied

**[TO BE FILLED IF ANY]**

```markdown
1. [Refinement 1]
2. [Refinement 2]
...
```

### Recommendations

**[TO BE FILLED]**

#### Immediate Actions (Before Deployment)

1. [Action 1]
2. [Action 2]

#### Short-term Improvements (Next Sprint)

1. [Improvement 1]
2. [Improvement 2]

#### Long-term Enhancements (Future)

1. [Enhancement 1]
2. [Enhancement 2]

### Sign-off

**[TO BE COMPLETED]**

```markdown
Tested By: ___________
Reviewed By: ___________
Approved By: ___________

Date: ___________

Recommendation: ✅ APPROVED FOR DEPLOYMENT / ⚠️ CONDITIONAL APPROVAL / ❌ NOT APPROVED

Conditions (if any):
-
-
```

---

## Appendix

### A. Test Environment Details

```bash
# System Information
uname -a

# Claude Code Version
claude --version

# Git Status
git status
git log --oneline -5

# Configuration Files
ls -la .claude/agents/
ls -la .claude/hooks/
ls -la .claude/config/
```

### B. Log File Locations

- Trigger events: `.claude/logs/trigger-events.jsonl`
- Agent executions: `.claude/logs/agent-executions.jsonl`
- Performance metrics: `.claude/metrics/trigger-analytics.json`
- Test execution logs: `tests/integration/logs/`

### C. Metrics Collection

**Trigger Events Log Format**:
```json
{
  "timestamp": "2025-11-19T10:30:45Z",
  "event": "trigger_activated",
  "trigger_name": "bash-error-trigger",
  "agent": "debug-agent",
  "context": {
    "command": "pytest tests/",
    "exit_code": 1
  }
}
```

**Agent Execution Log Format**:
```json
{
  "timestamp": "2025-11-19T10:30:46Z",
  "event": "agent_activated",
  "agent": "debug-agent",
  "duration_ms": 1234,
  "result": "success",
  "files_analyzed": 3
}
```

### D. Reference Documentation

- Agent Instructions:
  - `/home/user/claude-skill-eval/.claude/agents/debug-agent/instructions.md`
  - `/home/user/claude-skill-eval/.claude/agents/consistency-agent/instructions.md`
  - `/home/user/claude-skill-eval/.claude/agents/quality-agent/instructions.md`

- Hook Documentation:
  - `/home/user/claude-skill-eval/.claude/hooks/README.md`
  - `/home/user/claude-skill-eval/.claude/hooks/QUICKREF.md`

- Trigger System:
  - `/home/user/claude-skill-eval/.claude/config/triggers.yml`
  - `/home/user/claude-skill-eval/.claude/config/trigger-rules.md`

- Individual Agent Tests:
  - `/home/user/claude-skill-eval/tests/debug-agent-test.md`
  - `/home/user/claude-skill-eval/tests/consistency-agent-test.md`
  - `/home/user/claude-skill-eval/tests/quality-agent-test.md`

### E. Testing Best Practices

1. **Document Everything**: Record all observations, even if they seem minor
2. **Test Incrementally**: Run scenarios in order, don't skip ahead
3. **Verify Assumptions**: Check that preconditions are met before each test
4. **Measure Performance**: Time all operations, note any slowness
5. **Check Logs**: Always verify metrics are being collected
6. **Test Edge Cases**: Try variations beyond the happy path
7. **Note User Experience**: Consider how this feels from a developer's perspective
8. **Compare Against Baseline**: How does this compare to working without agents?

### F. Troubleshooting Guide

**Agent doesn't activate**:
- Check trigger configuration syntax
- Verify keyword matches trigger definition
- Check file type filters
- Review precedence rules

**Pattern search finds nothing**:
- Verify codebase has similar patterns
- Check glob/grep patterns in agent config
- Review file type filters
- Check search scope (working directory)

**Quality review incomplete**:
- Check file size limits
- Verify all checklist categories loaded
- Review timeout settings
- Check agent instructions file

**Performance slow**:
- Note file count and sizes
- Check for network calls (shouldn't be any)
- Review caching configuration
- Monitor resource usage

**Metrics not logged**:
- Check log directory exists and is writable
- Verify monitoring enabled in configuration
- Review log file format
- Check permissions

---

## Version History

**Version 1.0.0** - 2025-11-19
- Initial comprehensive integration test plan
- Three main test scenarios defined
- Complete test coverage matrix
- Performance benchmarks established
- Issue tracking framework created
- Refinement recommendation structure
- Final report template

---

**Document Status**: Ready for Test Execution
**Next Action**: Execute Test Scenario 1 (Bug Fix Workflow)
**Owner**: Claude Code Team
**Review Date**: After test execution completion
