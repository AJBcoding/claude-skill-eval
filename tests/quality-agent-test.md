# Quality Agent Test Scenarios

This document defines test scenarios for validating the quality-agent's ability to detect quality issues and provide actionable feedback.

---

## Test Scenario 1: Production Code with Security Vulnerabilities

### Setup

Create a test file with intentional security issues:

**File**: `test_files/vulnerable_api.py`

```python
import sqlite3
from flask import Flask, request

app = Flask(__name__)

# CRITICAL: Hardcoded secret
API_KEY = "sk_live_abc123def456"
DATABASE_PASSWORD = "super_secret_password"

@app.route('/users/<user_id>')
def get_user(user_id):
    # CRITICAL: SQL injection vulnerability
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    query = f"SELECT * FROM users WHERE id = '{user_id}'"
    cursor.execute(query)
    user = cursor.fetchone()

    return {"user": user}

@app.route('/admin/delete_all')
def delete_all_users():
    # CRITICAL: No authentication check
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute("DELETE FROM users")
    conn.commit()
    return {"status": "deleted"}

if __name__ == '__main__':
    app.run(debug=True)
```

### Test Execution

**User Message**: "I'm done implementing the user API. Ready to commit."

**Expected Agent Behavior**:
1. Activate on keyword "done" and "commit"
2. Review the implementation
3. Detect critical security issues
4. Block commit with REQUIRES CHANGES verdict

### Expected Output

**Verdict**: ❌ REQUIRES CHANGES

**Critical Issues Found**:
1. 🔴 Hardcoded secrets (API_KEY, DATABASE_PASSWORD)
2. 🔴 SQL injection vulnerability in get_user()
3. 🔴 Missing authentication in delete_all_users()
4. 🔴 Destructive operation without confirmation

**Quality Checklist Results**:
- Tests: ❌ FAIL (no tests found)
- Documentation: ❌ FAIL (no docstrings)
- Error Handling: ❌ FAIL (no error handling)
- Edge Cases: ❌ FAIL (no input validation)
- Performance: ⚠️ PARTIAL (minor concern: no connection pooling)
- Security: ❌ FAIL (multiple critical issues)
- Code Quality: ⚠️ PARTIAL (readable but lacks validation)

### Success Criteria

✅ Agent identifies all 4 critical security issues
✅ Agent provides specific file:line references
✅ Agent provides concrete fix recommendations
✅ Agent blocks commit with clear verdict
✅ Agent offers to help fix issues

---

## Test Scenario 2: Internal Tool with Missing Tests

### Setup

Create a test file with missing test coverage:

**File**: `test_files/data_processor.py`

```python
import json
from typing import List, Dict

def process_user_data(users: List[Dict]) -> Dict:
    """Process user data and generate report."""
    total_users = len(users)
    active_users = sum(1 for u in users if u.get('active'))
    total_revenue = sum(u.get('revenue', 0) for u in users)

    return {
        'total_users': total_users,
        'active_users': active_users,
        'total_revenue': total_revenue,
        'average_revenue': total_revenue / total_users if total_users > 0 else 0
    }

def export_to_json(data: Dict, filename: str):
    """Export data to JSON file."""
    with open(filename, 'w') as f:
        json.dump(data, f, indent=2)

if __name__ == '__main__':
    # Manual test
    users = [
        {'id': 1, 'active': True, 'revenue': 100},
        {'id': 2, 'active': False, 'revenue': 50}
    ]
    result = process_user_data(users)
    export_to_json(result, 'report.json')
```

### Test Execution

**User Message**: "Finished the data processor. Let's commit it."

**Expected Agent Behavior**:
1. Activate on keywords "finished" and "commit"
2. Review the implementation
3. Note missing tests
4. Note missing error handling
5. Provide PASS WITH RECOMMENDATIONS verdict (since it's an internal tool)

### Expected Output

**Verdict**: ⚠️ PASS WITH RECOMMENDATIONS

**Required Issues**:
1. 🟡 No tests for process_user_data()
2. 🟡 No error handling for file operations
3. 🟡 No validation of user data structure

**Recommended Issues**:
1. 🟢 Add input validation
2. 🟢 Handle edge case: empty users list
3. 🟢 Add docstring examples

**Quality Checklist Results**:
- Tests: ❌ FAIL (no tests)
- Documentation: ⚠️ PARTIAL (has docstrings but missing examples)
- Error Handling: ❌ FAIL (no error handling)
- Edge Cases: ⚠️ PARTIAL (division by zero handled, but not validated)
- Performance: ✅ PASS (acceptable for internal tool)
- Security: ✅ PASS (no security concerns for internal tool)
- Code Quality: ✅ PASS (readable, well-structured)

### Success Criteria

✅ Agent identifies missing tests
✅ Agent provides context-appropriate verdict (internal tool vs production)
✅ Agent categorizes issues correctly (required vs recommended)
✅ Agent acknowledges what was done well
✅ Agent allows commit with recommendations

---

## Test Scenario 3: Prototype with Appropriate Quality

### Setup

Create a prototype implementation:

**File**: `test_files/ml_experiment.py`

```python
"""
Experimental ML model for user classification.
Note: This is a prototype - not production ready.
"""

import numpy as np
from sklearn.linear_model import LogisticRegression

def train_model(X_train, y_train):
    """Train simple logistic regression model."""
    model = LogisticRegression()
    model.fit(X_train, y_train)
    return model

def evaluate_model(model, X_test, y_test):
    """Evaluate model accuracy."""
    accuracy = model.score(X_test, y_test)
    print(f"Accuracy: {accuracy:.2%}")
    return accuracy

# Quick test
if __name__ == '__main__':
    # Dummy data
    X_train = np.random.rand(100, 5)
    y_train = np.random.randint(0, 2, 100)
    X_test = np.random.rand(20, 5)
    y_test = np.random.randint(0, 2, 20)

    model = train_model(X_train, y_train)
    evaluate_model(model, X_test, y_test)
```

### Test Execution

**User Message**: "My ML experiment is done. Just a prototype for testing an idea."

**Expected Agent Behavior**:
1. Activate on keyword "done"
2. Recognize context: prototype/experiment
3. Apply appropriate quality standards
4. Provide PASS verdict with optional suggestions

### Expected Output

**Verdict**: ✅ PASS

**Quality Assessment**:
- Appropriate quality for prototype
- Documentation clearly states it's experimental
- Code is readable and functional
- No critical issues

**Optional Suggestions**:
1. ⚪ Add comments explaining the approach
2. ⚪ Document assumptions and limitations
3. ⚪ Add basic validation when transitioning to production

**Quality Checklist Results**:
- Tests: ✅ PASS (not required for prototype, manual test present)
- Documentation: ✅ PASS (clearly marked as prototype)
- Error Handling: ✅ PASS (fail-fast acceptable for prototype)
- Edge Cases: ⚪ OPTIONAL (note for production transition)
- Performance: ✅ PASS (not critical for prototype)
- Security: ✅ PASS (no security concerns)
- Code Quality: ✅ PASS (readable, appropriate for context)

### Success Criteria

✅ Agent recognizes prototype context
✅ Agent applies appropriate quality standards
✅ Agent provides PASS verdict
✅ Agent notes considerations for future production use
✅ Agent doesn't over-critique prototype code

---

## Test Scenario 4: Well-Written Production Code

### Setup

Create high-quality production code:

**File**: `test_files/payment_service.py`

```python
"""
Payment processing service with robust error handling.
"""

import os
import logging
from typing import Dict, Optional
from dataclasses import dataclass

logger = logging.getLogger(__name__)

# Configuration from environment
API_KEY = os.getenv('PAYMENT_API_KEY')
if not API_KEY:
    raise ValueError("PAYMENT_API_KEY environment variable required")

@dataclass
class PaymentResult:
    """Payment processing result."""
    success: bool
    transaction_id: Optional[str]
    error_message: Optional[str]

class PaymentService:
    """Handle payment processing with external gateway."""

    def __init__(self, api_key: str):
        """
        Initialize payment service.

        Args:
            api_key: Payment gateway API key

        Raises:
            ValueError: If api_key is empty
        """
        if not api_key:
            raise ValueError("API key is required")
        self.api_key = api_key

    def process_payment(
        self,
        amount: float,
        currency: str = 'USD'
    ) -> PaymentResult:
        """
        Process payment transaction.

        Args:
            amount: Payment amount (must be positive)
            currency: Currency code (default: USD)

        Returns:
            PaymentResult with transaction details

        Raises:
            ValueError: If amount is invalid

        Example:
            >>> service = PaymentService(api_key)
            >>> result = service.process_payment(99.99)
            >>> if result.success:
            ...     print(f"Transaction: {result.transaction_id}")
        """
        # Input validation
        if amount <= 0:
            raise ValueError(f"Invalid amount: {amount}")

        if not currency or len(currency) != 3:
            raise ValueError(f"Invalid currency code: {currency}")

        try:
            # Process payment (simplified for example)
            transaction_id = self._call_payment_gateway(amount, currency)

            logger.info(
                f"Payment processed successfully: {transaction_id}",
                extra={'amount': amount, 'currency': currency}
            )

            return PaymentResult(
                success=True,
                transaction_id=transaction_id,
                error_message=None
            )

        except Exception as e:
            logger.error(
                f"Payment processing failed: {e}",
                exc_info=True,
                extra={'amount': amount, 'currency': currency}
            )

            return PaymentResult(
                success=False,
                transaction_id=None,
                error_message=str(e)
            )

    def _call_payment_gateway(self, amount: float, currency: str) -> str:
        """Call external payment gateway."""
        # Implementation details
        return "txn_abc123"
```

**File**: `test_files/test_payment_service.py`

```python
"""Tests for payment service."""

import pytest
from payment_service import PaymentService, PaymentResult

@pytest.fixture
def payment_service():
    """Create payment service instance."""
    return PaymentService(api_key="test_key")

def test_successful_payment(payment_service):
    """Test successful payment processing."""
    result = payment_service.process_payment(99.99, 'USD')

    assert result.success is True
    assert result.transaction_id is not None
    assert result.error_message is None

def test_invalid_amount(payment_service):
    """Test payment with invalid amount."""
    with pytest.raises(ValueError, match="Invalid amount"):
        payment_service.process_payment(-10.00)

    with pytest.raises(ValueError, match="Invalid amount"):
        payment_service.process_payment(0)

def test_invalid_currency(payment_service):
    """Test payment with invalid currency."""
    with pytest.raises(ValueError, match="Invalid currency"):
        payment_service.process_payment(99.99, 'US')  # Too short

    with pytest.raises(ValueError, match="Invalid currency"):
        payment_service.process_payment(99.99, '')  # Empty

def test_service_requires_api_key():
    """Test that service requires API key."""
    with pytest.raises(ValueError, match="API key is required"):
        PaymentService(api_key="")
```

### Test Execution

**User Message**: "Payment service implementation complete. Ready to merge."

**Expected Agent Behavior**:
1. Activate on keywords "complete" and "merge"
2. Review implementation thoroughly
3. Find high quality code
4. Provide PASS verdict with positive feedback

### Expected Output

**Verdict**: ✅ PASS

**Quality Assessment**:
Excellent implementation with comprehensive error handling, input validation, tests, and documentation.

**What Was Done Well**:
- ✅ Comprehensive test coverage
- ✅ Excellent documentation with examples
- ✅ Robust error handling
- ✅ Proper input validation
- ✅ Secrets loaded from environment
- ✅ Structured logging
- ✅ Type hints throughout
- ✅ Clear, readable code

**Quality Checklist Results**:
- Tests: ✅ PASS (comprehensive test coverage)
- Documentation: ✅ PASS (excellent docstrings with examples)
- Error Handling: ✅ PASS (robust error handling)
- Edge Cases: ✅ PASS (validated and tested)
- Performance: ✅ PASS (efficient implementation)
- Security: ✅ PASS (secrets from environment)
- Code Quality: ✅ PASS (high quality code)

**Optional Suggestions**:
1. ⚪ Consider adding retry logic for transient failures
2. ⚪ Could add metrics/monitoring hooks

### Success Criteria

✅ Agent recognizes high-quality code
✅ Agent provides positive feedback
✅ Agent gives PASS verdict
✅ Agent acknowledges what was done well
✅ Agent makes only optional suggestions
✅ Agent approves for merge

---

## Test Scenario 5: Code with Mixed Quality

### Setup

Create code with both good and problematic elements:

**File**: `test_files/user_service.py`

```python
"""User service for managing user accounts."""

from typing import Optional
import hashlib

def create_user(email: str, password: str, name: str) -> dict:
    """
    Create a new user account.

    Args:
        email: User email address
        password: User password
        name: User full name

    Returns:
        User dictionary with id, email, name
    """
    # ISSUE: No input validation
    # ISSUE: Password not securely hashed (should use bcrypt)
    password_hash = hashlib.md5(password.encode()).hexdigest()

    # Good: Using proper data structure
    user = {
        'id': generate_id(),
        'email': email,
        'name': name,
        'password_hash': password_hash,
        'active': True
    }

    # ISSUE: No error handling for database operation
    save_to_database(user)

    return user

def get_user_by_email(email: str) -> Optional[dict]:
    """Get user by email address."""
    # ISSUE: No input validation
    # Good: Has error handling
    try:
        return database.query("SELECT * FROM users WHERE email = ?", (email,))
    except Exception as e:
        print(f"Error: {e}")  # ISSUE: Should use proper logging
        return None

def generate_id():
    """Generate unique user ID."""
    import uuid
    return str(uuid.uuid4())

def save_to_database(user):
    """Save user to database."""
    pass  # Simplified for example
```

### Test Execution

**User Message**: "User service is done. Review please."

**Expected Agent Behavior**:
1. Activate on keywords "done" and "review"
2. Identify both strengths and weaknesses
3. Categorize issues by severity
4. Provide balanced feedback

### Expected Output

**Verdict**: ⚠️ PASS WITH RECOMMENDATIONS

**Critical Issues**: None

**Required Issues**:
1. 🟡 Weak password hashing (MD5 instead of bcrypt)
2. 🟡 Missing input validation
3. 🟡 No tests found
4. 🟡 Poor error handling in create_user()

**Recommended Issues**:
1. 🟢 Use proper logging instead of print()
2. 🟢 Add email format validation
3. 🟢 Add docstring to helper functions

**What Was Done Well**:
- ✅ Good function documentation
- ✅ Type hints used
- ✅ Parameterized query prevents SQL injection
- ✅ Clear function names
- ✅ Logical code structure

**Quality Checklist Results**:
- Tests: ❌ FAIL (no tests)
- Documentation: ✅ PASS (good docstrings)
- Error Handling: ⚠️ PARTIAL (some but not all functions)
- Edge Cases: ❌ FAIL (no input validation)
- Performance: ✅ PASS (acceptable)
- Security: ⚠️ PARTIAL (weak password hash, but SQL injection prevented)
- Code Quality: ✅ PASS (readable, well-structured)

### Success Criteria

✅ Agent identifies both strengths and weaknesses
✅ Agent categorizes issues appropriately
✅ Agent provides balanced feedback
✅ Agent gives specific recommendations
✅ Agent acknowledges good practices

---

## Manual Testing Instructions

### How to Test the Quality Agent

1. **Create test file**:
   ```bash
   mkdir -p test_files
   # Copy one of the test scenarios above into a file
   ```

2. **Trigger the quality agent**:
   ```
   User: "I'm done with [implementation]. Ready to commit."
   ```

3. **Verify agent activation**:
   - Agent should activate on keywords (done, complete, commit, etc.)
   - Agent should identify itself as quality-agent

4. **Check review process**:
   - Agent reads the implementation files
   - Agent applies 7-point quality checklist
   - Agent categorizes issues by priority

5. **Verify output quality**:
   - Specific file paths and line numbers provided
   - Issues categorized (Critical/Required/Recommended/Optional)
   - Actionable recommendations given
   - Clear verdict (Pass/Pass with Recommendations/Requires Changes)

6. **Test context awareness**:
   - Production code: High standards
   - Internal tools: Medium standards
   - Prototypes: Low standards appropriate for context

---

## Success Metrics

The quality agent is working correctly if:

- ✅ Activates on appropriate keywords
- ✅ Reviews all changed files
- ✅ Identifies critical security issues (SQL injection, XSS, secrets)
- ✅ Detects missing tests
- ✅ Notes missing error handling
- ✅ Provides specific file:line references
- ✅ Categorizes issues by priority
- ✅ Gives actionable recommendations
- ✅ Adjusts standards based on context
- ✅ Acknowledges good work
- ✅ Provides clear verdict
- ✅ Offers to help fix issues

---

## Common Issues to Test

### Security
- [ ] Detects SQL injection vulnerabilities
- [ ] Detects XSS vulnerabilities
- [ ] Finds hardcoded secrets
- [ ] Identifies missing authentication
- [ ] Catches weak password hashing

### Testing
- [ ] Identifies missing tests
- [ ] Notes missing edge case coverage
- [ ] Detects tests that don't verify behavior

### Error Handling
- [ ] Finds missing error handling
- [ ] Detects silent failures
- [ ] Notes generic error messages

### Code Quality
- [ ] Identifies code duplication
- [ ] Notes missing input validation
- [ ] Catches magic numbers
- [ ] Identifies overly complex functions

### Documentation
- [ ] Detects missing docstrings
- [ ] Notes missing examples
- [ ] Identifies outdated comments

---

## Expected Response Time

- Initial activation: < 1 second
- File review: 2-5 seconds per file
- Quality analysis: 3-10 seconds total
- Report generation: 2-3 seconds

**Total**: Should complete within 30 seconds for typical implementation

---

## Regression Tests

Run these tests after any changes to quality-agent:

```bash
# Test 1: Security detection
python -m pytest tests/test_quality_agent_security.py

# Test 2: Context awareness
python -m pytest tests/test_quality_agent_context.py

# Test 3: Issue categorization
python -m pytest tests/test_quality_agent_priority.py

# Test 4: Output format
python -m pytest tests/test_quality_agent_output.py
```

---

**Document Version**: 1.0
**Last Updated**: 2025-11-19
**Status**: Ready for testing
