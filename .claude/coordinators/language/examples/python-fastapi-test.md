# Test Case: Python FastAPI Endpoint

## Test Input
"Create a FastAPI endpoint for user registration with email and password validation"

## Expected Routing

### Detection Phase
- **Keyword Match**: "FastAPI" → HIGH precedence match
- **Pattern**: `fastapi` route (routes.yml line 22)
- **Language**: Python

### Activation Sequence
1. **using-superpowers** - Check for applicable skills
2. **brainstorming** - Design the endpoint structure
3. **moai-lang-python** - Python/FastAPI expertise
4. **moai-domain-backend** - API patterns (optional)
5. **test-driven-development** - Write tests first
6. **moai-domain-security** - Auth patterns (suggested)
7. **verification-before-completion** - Verify endpoint works
8. **requesting-code-review** - Review the implementation

### Expected Code Structure
```python
# test_user_registration.py (TDD - written first)
import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_user_registration_success():
    response = client.post(
        "/register",
        json={"email": "user@example.com", "password": "SecurePass123!"}
    )
    assert response.status_code == 201
    assert "id" in response.json()

def test_user_registration_invalid_email():
    response = client.post(
        "/register",
        json={"email": "invalid", "password": "SecurePass123!"}
    )
    assert response.status_code == 422

# user_registration.py (implementation)
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr, Field
from typing import Optional

router = APIRouter()

class UserRegistration(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8, regex="^(?=.*[A-Za-z])(?=.*\\d)")

class UserResponse(BaseModel):
    id: str
    email: str
    created_at: str

@router.post("/register", response_model=UserResponse, status_code=201)
async def register_user(user: UserRegistration):
    # Implementation following TDD
    pass
```

## Validation Points

✅ **Language Detection**: Correctly identifies Python from "FastAPI"
✅ **Obra Pattern Usage**: Uses TDD, brainstorming, verification
✅ **Skill Activation**: Routes to moai-lang-python
✅ **Domain Enhancement**: Suggests moai-domain-backend and security
✅ **Quality Enforcement**: Triggers code review

## Metrics to Measure
- Detection time: < 2 seconds
- Correct routing: Python path
- Obra patterns used: 100%
- Skills activated: 2-3 (python, backend, security)

## Common Variations

### Variation 1: With Database
"Create a FastAPI endpoint for user registration that saves to PostgreSQL"
- Additional routing: moai-domain-database
- Additional pattern: sql-optimization-patterns

### Variation 2: With Authentication
"Create a FastAPI endpoint for user registration with JWT token generation"
- Priority routing: moai-domain-security (CRITICAL precedence)
- Additional pattern: defense-in-depth

### Variation 3: Async Focus
"Create an async FastAPI endpoint for user registration with background tasks"
- Emphasis: Python async patterns
- Additional consideration: performance optimization

## Edge Cases

### Edge Case 1: Ambiguous Language
"Create an endpoint for user registration"
- No explicit FastAPI mention
- Should prompt for clarification or check project context

### Edge Case 2: Multi-Framework
"Create a FastAPI endpoint that returns data for a React component"
- Should trigger parallel activation
- Both Python and TypeScript paths

## Success Criteria
- ✅ Routes to Python path in < 2 seconds
- ✅ Activates all required obra patterns
- ✅ Produces working, tested code
- ✅ Follows FastAPI best practices
- ✅ Includes proper validation and error handling