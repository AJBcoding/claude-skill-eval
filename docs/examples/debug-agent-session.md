# Debug Agent Example Session

**Scenario**: Test failure during feature development
**Agent**: debug-agent
**Trigger**: Automatic (test failure detected)
**Duration**: ~8 minutes
**Outcome**: Bug fixed, tests passing

---

## Context

Developer is implementing a user authentication feature. After writing the code, they run the test suite and encounter a failure.

---

## Session Transcript

### Initial Command

```bash
User: "Run the test suite to verify my changes"

$ npm test
```

### Test Output

```
> jest

PASS  src/utils/validation.test.ts
PASS  src/services/email.test.ts
FAIL  src/auth/authentication.test.ts
  ● Authentication Service › login › should authenticate valid user credentials

    Expected: 200
    Received: 401

      22 |     const response = await request(app)
      23 |       .post('/api/auth/login')
      24 |       .send({ email: 'test@example.com', password: 'password123' });
    > 25 |     expect(response.status).toBe(200);
         |                             ^
      26 |     expect(response.body).toHaveProperty('token');
      27 |   });
      28 |

      at Object.<anonymous> (src/auth/authentication.test.ts:25:29)

PASS  src/models/user.test.ts
PASS  src/middleware/validate.test.ts

Test Suites: 1 failed, 5 passed, 6 total
Tests:       1 failed, 15 passed, 16 total
Snapshots:   0 total
Time:        3.482 s
```

---

## Debug Agent Activation

```
────────────────────────────────────────────────────────
🔴 DEBUG AGENT ACTIVATED
────────────────────────────────────────────────────────

TRIGGER: test-failure-trigger (CRITICAL priority)
DETECTION: Test output contains "FAIL" pattern
CONFIDENCE: 1.0 (definitive test failure)

I detected a test failure in the authentication module.
Let's systematically debug this using the 6-step methodology.

═══════════════════════════════════════════════════════
```

---

### STEP 1: REPRODUCE (Target: 60s)

```
═══════════════════════════════════════════════════════
STEP 1: REPRODUCE
═══════════════════════════════════════════════════════

I'll establish reliable reproduction of the failure.

ACTION: Run failing test in isolation

$ npm test -- authentication.test.ts --verbose

RESULT:
  Authentication Service
    login
      ✓ should return 400 for missing credentials (42ms)
      ✓ should return 400 for invalid email format (28ms)
      ✗ should authenticate valid user credentials (156ms)
      ✓ should return 401 for incorrect password (89ms)
      ✓ should return 404 for non-existent user (67ms)

  1 failing

REPRODUCTION STATUS: ✓ RELIABLE

The failure reproduces consistently. Details:
- Test: "should authenticate valid user credentials"
- Expected: HTTP 200 (OK)
- Received: HTTP 401 (Unauthorized)
- Location: src/auth/authentication.test.ts:25
- Test creates user, attempts login, expects success

STEP 1 COMPLETE (48 seconds)
Next: Isolate the specific component causing the issue

═══════════════════════════════════════════════════════
```

---

### STEP 2: ISOLATE (Target: 120s)

```
═══════════════════════════════════════════════════════
STEP 2: ISOLATE
═══════════════════════════════════════════════════════

I'll narrow down the scope to find exactly where the failure occurs.

CHECKING TEST SETUP:
  ✓ Database connection established
  ✓ Test user created successfully
    - Email: test@example.com
    - Password: password123 (plaintext in test)
    - User ID: 1

CHECKING REQUEST HANDLING:
  → POST /api/auth/login
  → Body: { email: 'test@example.com', password: 'password123' }
  → Headers: { Content-Type: 'application/json' }

CHECKING RESPONSE:
  ✗ Status: 401 (Unauthorized)
  ✗ Body: { error: 'Invalid credentials' }

ISOLATION ANALYSIS:

Reading authentication route handler:
File: src/auth/authentication.ts
Lines: 45-78

```typescript
router.post('/login', async (req: Request, res: Response) => {
  const { email, password } = req.body;

  // Find user
  const user = await User.findOne({ where: { email } });
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  }

  // Verify password
  const isValid = user.password === password;  // ← LINE 56: SUSPICIOUS
  if (!isValid) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }

  // Generate token
  const token = jwt.sign(
    { userId: user.id, email: user.email },
    process.env.JWT_SECRET!
  );

  res.json({ token });
});
```

ISOLATED TO: Password comparison logic (line 56)

OBSERVATION:
- User found successfully (no 404)
- Password comparison fails (returns 401)
- Line 56 uses === comparison
- But user.password should be hashed (bcrypt)

READING USER MODEL:
File: src/models/user.ts

```typescript
@BeforeCreate
static async hashPassword(user: User) {
  user.password = await bcrypt.hash(user.password, 10);
}
```

FOUND THE ISSUE:
- User model hashes passwords before saving (bcrypt)
- Test creates user with "password123"
- User model saves it as bcrypt hash: "$2b$10$..."
- Login compares plaintext "password123" === "$2b$10$..." → false
- Line 56 uses === instead of bcrypt.compare()

STEP 2 COMPLETE (94 seconds)
Next: Generate hypotheses about root cause

═══════════════════════════════════════════════════════
```

---

### STEP 3: HYPOTHESIS (Target: 60s)

```
═══════════════════════════════════════════════════════
STEP 3: HYPOTHESIS
═══════════════════════════════════════════════════════

Based on isolated issue, I'll generate potential root causes.

HYPOTHESIS 1: Password comparison using === instead of bcrypt.compare()
  Likelihood: ★★★ HIGH (95%)
  Evidence:
    - Line 56 uses: user.password === password
    - user.password is bcrypt hash
    - password is plaintext
    - === comparison will always fail
  Impact: CRITICAL (authentication broken)

HYPOTHESIS 2: Test password not matching database password
  Likelihood: ★☆☆ LOW (10%)
  Evidence:
    - Test uses "password123"
    - User created with same password
    - Password gets hashed via BeforeCreate hook
  Contradiction: Hash is working (user created), comparison is wrong

HYPOTHESIS 3: User not found in database
  Likelihood: ☆☆☆ NEGLIGIBLE (<1%)
  Evidence:
    - No 404 error (user found)
    - Execution reaches password comparison
  Contradicts: Observation

HYPOTHESIS 4: JWT_SECRET missing or invalid
  Likelihood: ☆☆☆ NEGLIGIBLE (<1%)
  Evidence:
    - Error occurs before token generation
    - 401 from password check, not token creation
  Contradicts: Flow

RANKED HYPOTHESES:
1. ★★★ Password comparison wrong (Line 56: === vs bcrypt.compare)
2. ★☆☆ Test setup issue
3. Others: negligible

PRIMARY HYPOTHESIS: Line 56 should use bcrypt.compare() not ===

STEP 3 COMPLETE (42 seconds)
Next: Test the primary hypothesis

═══════════════════════════════════════════════════════
```

---

### STEP 4: TEST (Target: 120s)

```
═══════════════════════════════════════════════════════
STEP 4: TEST
═══════════════════════════════════════════════════════

I'll test Hypothesis 1 by adding logging and verifying the comparison.

ACTION 1: Add debug logging

File: src/auth/authentication.ts
After line 52:

```typescript
// DEBUG: Log password comparison details
console.log('DEBUG Password Check:');
console.log('  Input password:', password);
console.log('  Stored password (hash):', user.password);
console.log('  Direct comparison (===):', user.password === password);
```

ACTION 2: Run test with debug output

$ npm test -- authentication.test.ts 2>&1 | grep -A 5 "DEBUG"

OUTPUT:
```
DEBUG Password Check:
  Input password: password123
  Stored password (hash): $2b$10$8K1p3q5r7s9t1u3v5w7x9yABCDEFGHIJKLMNOPQRSTUVWXYZ012
  Direct comparison (===): false
```

HYPOTHESIS 1 CONFIRMED: ✓

The password is indeed hashed ($2b$ is bcrypt prefix), but line 56
compares it with plaintext using ===, which always returns false.

ACTION 3: Verify bcrypt.compare would work

Adding temporary test:

```typescript
// TEST: Would bcrypt.compare work?
const testValid = await bcrypt.compare(password, user.password);
console.log('  bcrypt.compare result:', testValid);
```

OUTPUT:
```
  bcrypt.compare result: true
```

HYPOTHESIS VALIDATION: ✓ CONFIRMED

bcrypt.compare() correctly validates the password, proving:
1. Hash is stored correctly
2. === comparison is the wrong approach
3. bcrypt.compare() is the correct solution

STEP 4 COMPLETE (78 seconds)
Next: Implement the fix

═══════════════════════════════════════════════════════
```

---

### STEP 5: FIX (Target: 180s)

```
═══════════════════════════════════════════════════════
STEP 5: FIX
═══════════════════════════════════════════════════════

I'll implement the confirmed solution.

FIX 1: Update password comparison

File: src/auth/authentication.ts
Line: 56

BEFORE:
```typescript
const isValid = user.password === password;
```

AFTER:
```typescript
const isValid = await bcrypt.compare(password, user.password);
```

FIX 2: Ensure bcrypt is imported

File: src/auth/authentication.ts
Line: 3

VERIFY:
```typescript
import bcrypt from 'bcrypt';  // ✓ Already imported
```

FIX 3: Remove debug logging

Removed temporary console.log statements (lines 53-57)

CHANGES SUMMARY:
  Modified: src/auth/authentication.ts
  Lines changed: 1
  Additions: 0
  Deletions: 0
  Net change: Use bcrypt.compare instead of ===

EDGE CASES CONSIDERED:
  ✓ null/undefined password: Handled by request validation middleware
  ✓ Empty password: Validation rejects before reaching this code
  ✓ Password not a string: TypeScript + validation ensure string type
  ✓ User without password: Model requires password field
  ✓ bcrypt.compare errors: async/await with try/catch in router

SIDE EFFECTS:
  None identified. bcrypt.compare is the standard approach.

STEP 5 COMPLETE (52 seconds)
Next: Verify the fix resolves the issue

═══════════════════════════════════════════════════════
```

---

### STEP 6: VERIFY (Target: 60s)

```
═══════════════════════════════════════════════════════
STEP 6: VERIFY
═══════════════════════════════════════════════════════

I'll confirm the fix resolves the original failure.

VERIFICATION 1: Run failing test

$ npm test -- authentication.test.ts

RESULT:
```
PASS  src/auth/authentication.test.ts
  Authentication Service
    login
      ✓ should return 400 for missing credentials (38ms)
      ✓ should return 400 for invalid email format (24ms)
      ✓ should authenticate valid user credentials (142ms)  ← FIXED!
      ✓ should return 401 for incorrect password (91ms)
      ✓ should return 404 for non-existent user (63ms)

Test Suites: 1 passed, 1 total
Tests:       5 passed, 5 total
```

✓ Original test now passes

VERIFICATION 2: Run full test suite

$ npm test

RESULT:
```
PASS  src/utils/validation.test.ts
PASS  src/services/email.test.ts
PASS  src/auth/authentication.test.ts
PASS  src/models/user.test.ts
PASS  src/middleware/validate.test.ts

Test Suites: 6 passed, 6 total
Tests:       16 passed, 16 total
Snapshots:   0 total
Time:        3.521 s
```

✓ All tests pass
✓ No regressions introduced

VERIFICATION 3: Test edge case - incorrect password

```typescript
it('should return 401 for incorrect password', async () => {
  await User.create({ email: 'test@example.com', password: 'password123' });

  const response = await request(app)
    .post('/api/auth/login')
    .send({ email: 'test@example.com', password: 'wrongpassword' });

  expect(response.status).toBe(401);
});
```

RESULT: ✓ Passes (still correctly rejects wrong password)

VERIFICATION 4: Manual test

Started dev server and tested:

```bash
$ curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "correctpassword"}'

Response: { "token": "eyJhbGc..." }
Status: 200 ✓
```

VERIFICATION COMPLETE (53 seconds)

═══════════════════════════════════════════════════════
```

---

## Debug Summary

```
════════════════════════════════════════════════════════
✅ DEBUGGING COMPLETE
════════════════════════════════════════════════════════

ROOT CAUSE:
  Password comparison used === operator instead of bcrypt.compare()

LOCATION:
  File: src/auth/authentication.ts
  Line: 56

FIX APPLIED:
  Changed: const isValid = user.password === password;
  To: const isValid = await bcrypt.compare(password, user.password);

VERIFICATION:
  ✓ Original failing test now passes
  ✓ All 16 tests pass (no regressions)
  ✓ Edge cases verified
  ✓ Manual testing successful

TIME BREAKDOWN:
  Step 1 (Reproduce):  48s
  Step 2 (Isolate):    94s
  Step 3 (Hypothesis): 42s
  Step 4 (Test):       78s
  Step 5 (Fix):        52s
  Step 6 (Verify):     53s
  ─────────────────────────
  Total:               367s (~6 minutes)

LESSONS LEARNED:
  - Always use bcrypt.compare() for hashed passwords
  - Never compare hashed values with ===
  - Test-driven debugging caught this immediately
  - Systematic approach prevented wild guessing

RECOMMENDATION:
  Add this to consistency-agent patterns:
  "Authentication password comparison pattern"

Would you like me to:
1. Commit this fix?
2. Add a comment explaining the bcrypt usage?
3. Create pattern for future authentication implementations?
════════════════════════════════════════════════════════
```

---

## User Response

```
User: "Yes, please commit the fix with a clear message"
```

---

## Quality Agent Activation (Automatic)

```
────────────────────────────────────────────────────────
🟢 QUALITY AGENT ACTIVATED
────────────────────────────────────────────────────────

TRIGGER: User said "commit" (quality-keyword-trigger)
Running pre-commit quality review...

QUALITY CHECKLIST:
  ✓ Tests: All 16 tests pass
  ✓ Documentation: Change is self-explanatory
  ✓ Error Handling: Already handled by try/catch
  ✓ Performance: bcrypt.compare is standard
  ✓ Security: Improves security (proper hash comparison)
  ✓ Code Quality: Follows best practices
  ✓ Integration: No breaking changes

QUALITY REVIEW: ✓ ALL CHECKS PASSED

Commit allowed. Creating commit...
────────────────────────────────────────────────────────
```

---

## Commit

```bash
$ git add src/auth/authentication.ts

$ git commit -m "$(cat <<'EOF'
fix(auth): use bcrypt.compare for password verification

Changed password comparison from === operator to bcrypt.compare()
to properly validate hashed passwords. The === comparison was
always failing because it compared plaintext with bcrypt hash.

Fixes test failure in authentication.test.ts
All tests now pass (16/16)
EOF
)"

[main abc123def] fix(auth): use bcrypt.compare for password verification
 1 file changed, 1 insertion(+), 1 deletion(-)
```

---

## Outcome

**Bug Fixed**: ✓
**Tests Passing**: ✓ (16/16)
**Code Quality**: ✓ (verified)
**Committed**: ✓
**Time**: ~8 minutes total
**Methodology**: 6-step debugging followed precisely
**Agents Used**: debug-agent → quality-agent

---

## Key Takeaways

1. **Systematic approach works**: 6 steps prevented guessing
2. **Isolation is critical**: Narrowed from "auth broken" to specific line
3. **Hypothesis testing validates**: Confirmed root cause before fixing
4. **Verification prevents regressions**: Full test suite caught no side effects
5. **Quality gates help**: Auto-review ensured fix was complete

This example demonstrates how the debug-agent enforces disciplined debugging even under pressure, preventing incomplete or symptomatic fixes.
