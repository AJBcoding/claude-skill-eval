# 🔴 Critical Issues Report

**Implementation**: [Brief description]
**Reviewed**: [YYYY-MM-DD]
**Status**: ⛔ BLOCKED - Critical Issues Must Be Resolved

---

## ⚠️ BLOCKING ISSUES FOUND

This implementation has **[N] CRITICAL issues** that must be addressed immediately before proceeding. These issues present serious risks to security, data integrity, or system stability.

---

## Critical Issues Summary

| # | Issue | File | Impact | Severity |
|---|-------|------|--------|----------|
| 1 | [Issue title] | [file:line] | [Impact] | 🔴 CRITICAL |
| 2 | [Issue title] | [file:line] | [Impact] | 🔴 CRITICAL |
| 3 | [Issue title] | [file:line] | [Impact] | 🔴 CRITICAL |

---

## Issue Details

### 🔴 Critical Issue #1: [Title]

**Category**: [Security / Data Loss / System Crash / Authorization Bypass]
**Severity**: CRITICAL
**File**: `/path/to/file.py:123-145`
**Priority**: Must fix immediately

#### Problem Description
[Clear description of what the problem is and why it's critical]

#### Risk Assessment
- **Likelihood**: [High / Medium / Low]
- **Impact**: [Severe / High / Medium]
- **Risk Level**: CRITICAL

**Potential Consequences:**
- [Consequence 1]
- [Consequence 2]
- [Consequence 3]

#### Current Code
```python
[Code snippet showing the problematic code]
# Line 123
problematic_code()
```

#### Why This Is Critical
[Detailed explanation of why this issue is considered critical]

#### Recommended Fix
```python
[Code snippet showing the recommended fix]
# Secure implementation
fixed_code()
```

#### Step-by-Step Fix Instructions
1. [Step 1]
2. [Step 2]
3. [Step 3]

#### Verification Steps
- [ ] [How to verify the fix works]
- [ ] [Additional verification step]
- [ ] [Test to run]

---

### 🔴 Critical Issue #2: [Title]

**Category**: [Security / Data Loss / System Crash / Authorization Bypass]
**Severity**: CRITICAL
**File**: `/path/to/file.ts:67-89`
**Priority**: Must fix immediately

#### Problem Description
[Clear description of what the problem is and why it's critical]

#### Risk Assessment
- **Likelihood**: [High / Medium / Low]
- **Impact**: [Severe / High / Medium]
- **Risk Level**: CRITICAL

**Potential Consequences:**
- [Consequence 1]
- [Consequence 2]

#### Current Code
```typescript
[Code snippet showing the problematic code]
```

#### Why This Is Critical
[Detailed explanation of why this issue is considered critical]

#### Recommended Fix
```typescript
[Code snippet showing the recommended fix]
```

#### Step-by-Step Fix Instructions
1. [Step 1]
2. [Step 2]
3. [Step 3]

#### Verification Steps
- [ ] [How to verify the fix works]
- [ ] [Test to run]

---

## Common Critical Issue Types

### 🔐 Security Vulnerabilities

#### SQL Injection
**Problem:**
```python
# CRITICAL: SQL Injection vulnerability
query = f"SELECT * FROM users WHERE email = '{email}'"
cursor.execute(query)
```

**Fix:**
```python
# Use parameterized queries
query = "SELECT * FROM users WHERE email = ?"
cursor.execute(query, (email,))
```

#### XSS (Cross-Site Scripting)
**Problem:**
```javascript
// CRITICAL: XSS vulnerability
element.innerHTML = userInput;
```

**Fix:**
```javascript
// Use textContent or proper sanitization
element.textContent = userInput;
// OR use DOMPurify for HTML content
element.innerHTML = DOMPurify.sanitize(userInput);
```

#### Exposed Secrets
**Problem:**
```python
# CRITICAL: Hardcoded secret in version control
API_KEY = "sk_live_abc123def456"
DATABASE_PASSWORD = "super_secret_password"
```

**Fix:**
```python
# Load from environment variables
import os
API_KEY = os.getenv('API_KEY')
if not API_KEY:
    raise ConfigError("API_KEY environment variable required")

DATABASE_PASSWORD = os.getenv('DATABASE_PASSWORD')
if not DATABASE_PASSWORD:
    raise ConfigError("DATABASE_PASSWORD environment variable required")
```

#### Authentication Bypass
**Problem:**
```python
# CRITICAL: No authentication check
@app.route('/admin/users')
def get_all_users():
    return User.query.all()
```

**Fix:**
```python
# Require authentication and authorization
@app.route('/admin/users')
@require_auth
@require_role('admin')
def get_all_users():
    return User.query.all()
```

---

### 💥 Data Loss Risks

#### No Transaction / Rollback
**Problem:**
```python
# CRITICAL: Partial updates without transaction
user.delete()
user_profile.delete()  # If this fails, user is deleted but profile remains
user_settings.delete()
```

**Fix:**
```python
# Use database transaction
with db.transaction():
    user.delete()
    user_profile.delete()
    user_settings.delete()
# Automatically rolls back if any operation fails
```

#### Destructive Operation Without Confirmation
**Problem:**
```python
# CRITICAL: Deletes all data without confirmation
@app.route('/admin/reset')
def reset_database():
    db.drop_all_tables()
    return "Database reset"
```

**Fix:**
```python
# Require explicit confirmation and authorization
@app.route('/admin/reset', methods=['POST'])
@require_auth
@require_role('super_admin')
def reset_database():
    confirmation = request.json.get('confirmation')
    if confirmation != "DELETE_ALL_DATA_PERMANENTLY":
        return {"error": "Invalid confirmation"}, 400

    # Log the operation
    logger.critical(f"Database reset initiated by {current_user.id}")

    # Perform backup first
    backup_database()

    # Then reset
    db.drop_all_tables()
    return {"status": "Database reset"}
```

---

### 💣 System Crash Risks

#### Unhandled Exception in Critical Path
**Problem:**
```python
# CRITICAL: Crash if external API fails
@app.route('/checkout')
def checkout():
    payment = process_payment()  # Raises exception if API down
    order = create_order()
    return {"order_id": order.id}
```

**Fix:**
```python
# Handle failures gracefully
@app.route('/checkout')
def checkout():
    try:
        payment = process_payment()
    except PaymentAPIError as e:
        logger.error(f"Payment API error: {e}")
        return {"error": "Payment service unavailable", "retry": True}, 503
    except Exception as e:
        logger.critical(f"Unexpected error: {e}", exc_info=True)
        return {"error": "An error occurred"}, 500

    try:
        order = create_order(payment)
        return {"order_id": order.id}
    except Exception as e:
        logger.error(f"Order creation failed: {e}")
        # Refund payment
        refund_payment(payment)
        return {"error": "Order creation failed"}, 500
```

#### Memory Exhaustion
**Problem:**
```python
# CRITICAL: Loads entire large file into memory
@app.route('/export/users')
def export_users():
    users = User.query.all()  # Could be millions of records
    return json.dumps([u.to_dict() for u in users])
```

**Fix:**
```python
# Stream data in batches
@app.route('/export/users')
def export_users():
    def generate():
        batch_size = 1000
        offset = 0
        while True:
            users = User.query.offset(offset).limit(batch_size).all()
            if not users:
                break
            for user in users:
                yield json.dumps(user.to_dict()) + '\n'
            offset += batch_size

    return Response(generate(), mimetype='application/x-ndjson')
```

---

## Immediate Action Required

### Priority 1 (Fix First)
[List the most critical issues that must be fixed first]

1. **[Issue Title]**
   - Risk: [Description]
   - Action: [What to do]
   - ETA: [Immediate / < 1 hour]

### Priority 2 (Fix Next)
[List secondary critical issues]

2. **[Issue Title]**
   - Risk: [Description]
   - Action: [What to do]
   - ETA: [< 2 hours]

---

## Verification Checklist

After fixing all critical issues, verify:

- [ ] All security vulnerabilities patched
- [ ] No secrets in code or version control
- [ ] Data loss risks mitigated
- [ ] Error handling prevents crashes
- [ ] Authentication/authorization enforced
- [ ] Input validation in place
- [ ] Output sanitization in place
- [ ] Tests verify fixes work
- [ ] Code review completed

---

## Testing Requirements

Before marking issues as resolved, you must:

### Security Testing
- [ ] Test with malicious input (SQL injection, XSS)
- [ ] Verify authentication checks work
- [ ] Verify authorization checks work
- [ ] Confirm secrets are not in code

### Stability Testing
- [ ] Test error conditions
- [ ] Test with invalid inputs
- [ ] Test resource limits
- [ ] Verify graceful degradation

### Data Integrity Testing
- [ ] Test transaction rollbacks
- [ ] Verify data consistency
- [ ] Test concurrent access
- [ ] Verify backup/restore works

---

## Re-Review Required

After fixing these critical issues:

1. **Run automated checks**
   ```bash
   # Security scanning
   bandit -r src/

   # Dependency vulnerabilities
   pip-audit  # or npm audit

   # Linting
   pylint src/  # or eslint src/
   ```

2. **Request re-review**
   - Update code with fixes
   - Run all tests
   - Request quality agent re-review

3. **Document changes**
   - Note what was fixed
   - Add tests for the fixes
   - Update documentation if needed

---

## Resources and References

### Security Resources
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [CWE Top 25](https://cwe.mitre.org/top25/)

### Best Practices
- [Python Security Best Practices](https://snyk.io/blog/python-security-best-practices/)
- [Node.js Security Best Practices](https://nodejs.org/en/docs/guides/security/)
- [SQL Injection Prevention](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)

---

## Get Help

If you need help fixing these critical issues:
- I can provide detailed fix implementations
- I can write tests to verify the fixes
- I can review the fixes after implementation
- I can explain security concepts in more detail

**Just ask!** These issues are critical and must be addressed.

---

**⛔ BLOCK DEPLOYMENT**: Do not commit or deploy until all critical issues are resolved and verified.

**Status**: Waiting for fixes...
