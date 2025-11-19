# Debugging Methodology

## Core Principle
**Catch bugs before code execution.** Think through edge cases, validate assumptions, and verify logic before running code.

## The 6-Step Process

### 1. Reproduce
**Strong nudge:** Before diving into fixes, ensure you can reliably reproduce the issue.

- Read error messages completely and carefully
- Identify the exact conditions that trigger the problem
- Document the steps to reproduce
- Note what works vs what doesn't

**Good approach:**
```
"I see the error occurs when X happens. Let me verify I can reproduce it
by checking the current state, then trace the exact execution path."
```

**Bad approach:**
```
"There's an error somewhere. Let me start changing things and see what happens."
```

### 2. Isolate
**Strong nudge:** Narrow down the problem space before proposing solutions.

- Identify the specific component, function, or line causing the issue
- Eliminate variables by testing smaller pieces
- Use grep/search to find all related code
- Check recent changes that might have introduced the bug

**Good approach:**
```
"The error traces to function X in file Y. Let me read that function
and its dependencies to understand the failure point."
```

**Bad approach:**
```
"The whole system is broken. Let me rewrite large sections."
```

### 3. Hypothesis
**Strong nudge:** Form a clear theory about the root cause before making changes.

- State what you believe is wrong and why
- Identify the evidence supporting your hypothesis
- Consider alternative explanations
- Think through the implications of your theory

**Good approach:**
```
"Based on the error message and code review, I believe the issue is a
null pointer when the optional parameter is undefined. This would explain
why it fails in scenario A but not B."
```

**Bad approach:**
```
"Something's wrong with the data. Let me try adding some validation."
```

### 4. Test
**Strong nudge:** Validate your hypothesis before implementing a fix.

- Add logging or debugging output if needed
- Test your theory with minimal code changes
- Verify the hypothesis explains all symptoms
- Check if there are edge cases you missed

**Good approach:**
```
"Let me add a log statement to confirm the variable is undefined at this point,
then verify this matches the error behavior."
```

**Bad approach:**
```
"I'll implement the fix and see if it works."
```

### 5. Fix
**Strong nudge:** Implement the minimal change that addresses the root cause.

- Fix the cause, not just the symptom
- Consider how this fix affects other parts of the system
- Look for similar patterns that might have the same bug
- Ensure the fix handles all edge cases

**Good approach:**
```
"The root cause is missing null check. I'll add proper validation and also
check if this pattern exists elsewhere in the codebase."
```

**Bad approach:**
```
"I'll wrap everything in try-catch to suppress the error."
```

### 6. Verify
**Strong nudge:** Confirm the fix works and doesn't introduce new problems.

- Test the original failing scenario
- Test related scenarios and edge cases
- Run existing tests to ensure nothing broke
- Verify the fix aligns with the codebase patterns

**Good approach:**
```
"Let me test the fix with: 1) the original failing case, 2) the edge case
where the parameter is null vs undefined, 3) the happy path, and 4) run
the test suite."
```

**Bad approach:**
```
"The error is gone, so it's fixed."
```

## Pre-Execution Mental Checklist

**Before running any code, ask yourself:**

1. **Error Handling:** What could go wrong? How will I handle it?
2. **Edge Cases:** What are the boundary conditions?
   - Empty inputs, null/undefined values
   - Very large or very small numbers
   - Special characters or encoding issues
   - Concurrent access or race conditions
3. **Assumptions:** What am I assuming that might not be true?
4. **Dependencies:** What does this code rely on? Is it available?
5. **Side Effects:** What else might this change affect?

## Common Anti-Patterns to Avoid

### Trial-and-Error Debugging
**Don't:** Make random changes hoping something works
**Do:** Form hypotheses and test them systematically

### Symptom Fixing
**Don't:** Just make the error message go away
**Do:** Find and fix the root cause

### Scope Creep
**Don't:** Refactor unrelated code while debugging
**Do:** Stay focused on the specific issue

### Assumption Skipping
**Don't:** Assume you know what's wrong without verification
**Do:** Validate your understanding with evidence

## Examples of Strong Debugging

### Example 1: API Error
```
Bad: "The API is failing. Let me add more error handling."

Good: "The API returns 500. Let me:
1. Check the exact request being sent (reproduce)
2. Look at the API endpoint code (isolate)
3. My hypothesis is the request body format is wrong based on the error
4. Let me log the request body to confirm (test)
5. Fix the body format to match the API schema (fix)
6. Test with various input scenarios (verify)"
```

### Example 2: Null Reference
```
Bad: "Adding optional chaining everywhere to fix undefined errors."

Good: "Getting 'cannot read property of undefined':
1. The error occurs when processing user data (reproduce)
2. Traced to user.profile.email access (isolate)
3. Hypothesis: profile can be null for new users (hypothesis)
4. Checked database - confirmed new users have null profiles (test)
5. Added null check with proper default handling (fix)
6. Tested with new user, existing user, and edge cases (verify)"
```

## When to Deviate

These are strong nudges, not absolute rules. You may skip steps when:
- The issue is trivial and obvious (typo, copy-paste error)
- You're applying a known fix to a recognized pattern
- Time constraints require faster iteration (document this decision)

But even in these cases, **think before you act.**
