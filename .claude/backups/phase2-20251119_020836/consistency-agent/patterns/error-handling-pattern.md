# Error Handling Pattern

## Purpose

Standardized approach to error handling ensuring consistent error creation, propagation, logging, and user-facing messaging across the application.

## When to Use

- Handling exceptions and errors
- Validating user input
- Managing external API failures
- Database operation errors
- Business logic violations

## When NOT to Use

- Expected control flow (use if/else, not exceptions)
- Performance-critical paths (exceptions are expensive)
- Simple validation (use simple return values)

## Structure

### Node.js/TypeScript Pattern

```typescript
// errors/base-error.ts

// 1. Base error class
export abstract class BaseError extends Error {
  abstract readonly statusCode: number;
  abstract readonly code: string;
  abstract readonly isOperational: boolean;

  constructor(
    message: string,
    public readonly details?: Record<string, any>
  ) {
    super(message);
    this.name = this.constructor.name;
    Error.captureStackTrace(this, this.constructor);
  }

  toJSON() {
    return {
      name: this.name,
      code: this.code,
      message: this.message,
      statusCode: this.statusCode,
      details: this.details,
      ...(process.env.NODE_ENV === 'development' && {
        stack: this.stack
      })
    };
  }
}

// 2. Specific error classes
export class ValidationError extends BaseError {
  readonly statusCode = 400;
  readonly code = 'VALIDATION_ERROR';
  readonly isOperational = true;

  constructor(message: string, details?: Record<string, any>) {
    super(message, details);
  }
}

export class NotFoundError extends BaseError {
  readonly statusCode = 404;
  readonly code = 'NOT_FOUND';
  readonly isOperational = true;

  constructor(resource: string, identifier?: string | number) {
    super(
      `${resource} not found${identifier ? `: ${identifier}` : ''}`,
      { resource, identifier }
    );
  }
}

export class UnauthorizedError extends BaseError {
  readonly statusCode = 401;
  readonly code = 'UNAUTHORIZED';
  readonly isOperational = true;

  constructor(message = 'Unauthorized access') {
    super(message);
  }
}

export class ForbiddenError extends BaseError {
  readonly statusCode = 403;
  readonly code = 'FORBIDDEN';
  readonly isOperational = true;

  constructor(message = 'Access forbidden') {
    super(message);
  }
}

export class ConflictError extends BaseError {
  readonly statusCode = 409;
  readonly code = 'CONFLICT';
  readonly isOperational = true;

  constructor(message: string, details?: Record<string, any>) {
    super(message, details);
  }
}

export class InternalError extends BaseError {
  readonly statusCode = 500;
  readonly code = 'INTERNAL_ERROR';
  readonly isOperational = false;

  constructor(message = 'Internal server error', details?: Record<string, any>) {
    super(message, details);
  }
}

export class ExternalServiceError extends BaseError {
  readonly statusCode = 502;
  readonly code = 'EXTERNAL_SERVICE_ERROR';
  readonly isOperational = true;

  constructor(
    public readonly service: string,
    message?: string
  ) {
    super(message || `External service error: ${service}`, { service });
  }
}
```

### Error Handler Middleware

```typescript
// middleware/error-handler.ts

import { Request, Response, NextFunction } from 'express';
import { BaseError } from '@/errors/base-error';
import { logger } from '@/utils/logger';

// 1. Error logging
function logError(error: Error, req: Request) {
  const logData = {
    message: error.message,
    stack: error.stack,
    method: req.method,
    path: req.path,
    query: req.query,
    body: req.body,
    user: req.user?.id,
    timestamp: new Date().toISOString()
  };

  if (error instanceof BaseError) {
    if (error.isOperational) {
      logger.warn('Operational error', logData);
    } else {
      logger.error('Non-operational error', logData);
    }
  } else {
    logger.error('Unexpected error', logData);
  }
}

// 2. Error response formatting
function formatErrorResponse(error: Error) {
  if (error instanceof BaseError) {
    return {
      success: false,
      error: {
        code: error.code,
        message: error.message,
        ...(error.details && { details: error.details })
      }
    };
  }

  // Unknown errors - don't expose internals
  return {
    success: false,
    error: {
      code: 'INTERNAL_ERROR',
      message: 'An unexpected error occurred'
    }
  };
}

// 3. Main error handler
export function errorHandler(
  error: Error,
  req: Request,
  res: Response,
  next: NextFunction
) {
  // Log the error
  logError(error, req);

  // Determine status code
  const statusCode = error instanceof BaseError
    ? error.statusCode
    : 500;

  // Format and send response
  res.status(statusCode).json(formatErrorResponse(error));
}

// 4. Async error wrapper
export function asyncHandler(
  fn: (req: Request, res: Response, next: NextFunction) => Promise<any>
) {
  return (req: Request, res: Response, next: NextFunction) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
}

// 5. 404 handler
export function notFoundHandler(
  req: Request,
  res: Response,
  next: NextFunction
) {
  next(new NotFoundError('Route', req.path));
}
```

### Try-Catch Pattern

```typescript
// services/user-service.ts

import {
  NotFoundError,
  ValidationError,
  ConflictError,
  InternalError
} from '@/errors';
import { logger } from '@/utils/logger';

export class UserService {
  async createUser(userData: CreateUserDTO): Promise<User> {
    // 1. Input validation (throw ValidationError)
    if (!userData.email || !userData.name) {
      throw new ValidationError('Email and name are required', {
        fields: {
          email: !userData.email ? 'Email is required' : null,
          name: !userData.name ? 'Name is required' : null
        }
      });
    }

    try {
      // 2. Business logic with specific error handling
      const existingUser = await User.findByEmail(userData.email);

      if (existingUser) {
        throw new ConflictError('User with this email already exists', {
          email: userData.email
        });
      }

      // 3. Database operation
      const user = await User.create(userData);

      // 4. Additional operations with error handling
      try {
        await EmailService.sendWelcomeEmail(user.email, user.name);
      } catch (emailError) {
        // Log but don't fail the operation
        logger.warn('Failed to send welcome email', {
          userId: user.id,
          error: emailError
        });
      }

      return user;

    } catch (error) {
      // 5. Categorize and re-throw errors
      if (error instanceof BaseError) {
        // Already a known error type, re-throw
        throw error;
      }

      // 6. Database-specific errors
      if (error.name === 'SequelizeUniqueConstraintError') {
        throw new ConflictError('User already exists', {
          constraint: error.parent?.constraint
        });
      }

      if (error.name === 'SequelizeValidationError') {
        throw new ValidationError('Invalid user data', {
          errors: error.errors.map(e => ({
            field: e.path,
            message: e.message
          }))
        });
      }

      // 7. Unknown errors
      logger.error('Unexpected error in createUser', { error });
      throw new InternalError('Failed to create user');
    }
  }

  async getUserById(id: number): Promise<User> {
    try {
      const user = await User.findByPk(id);

      if (!user) {
        throw new NotFoundError('User', id);
      }

      return user;

    } catch (error) {
      if (error instanceof BaseError) {
        throw error;
      }

      logger.error('Unexpected error in getUserById', { error, id });
      throw new InternalError('Failed to retrieve user');
    }
  }

  async updateUser(id: number, updates: UpdateUserDTO): Promise<User> {
    try {
      const user = await this.getUserById(id); // May throw NotFoundError

      // Validate updates
      if (updates.email && updates.email !== user.email) {
        const existingUser = await User.findByEmail(updates.email);
        if (existingUser) {
          throw new ConflictError('Email already in use', {
            email: updates.email
          });
        }
      }

      await user.update(updates);
      return user;

    } catch (error) {
      if (error instanceof BaseError) {
        throw error;
      }

      logger.error('Unexpected error in updateUser', { error, id, updates });
      throw new InternalError('Failed to update user');
    }
  }
}
```

### Python Pattern

```python
# errors/base_error.py

from typing import Optional, Dict, Any

class BaseError(Exception):
    """Base error class"""

    def __init__(
        self,
        message: str,
        code: str,
        status_code: int,
        details: Optional[Dict[str, Any]] = None
    ):
        super().__init__(message)
        self.message = message
        self.code = code
        self.status_code = status_code
        self.details = details or {}

    def to_dict(self) -> Dict[str, Any]:
        return {
            "code": self.code,
            "message": self.message,
            "details": self.details
        }


class ValidationError(BaseError):
    def __init__(self, message: str, details: Optional[Dict[str, Any]] = None):
        super().__init__(
            message=message,
            code="VALIDATION_ERROR",
            status_code=400,
            details=details
        )


class NotFoundError(BaseError):
    def __init__(self, resource: str, identifier: Optional[str] = None):
        message = f"{resource} not found"
        if identifier:
            message += f": {identifier}"

        super().__init__(
            message=message,
            code="NOT_FOUND",
            status_code=404,
            details={"resource": resource, "identifier": identifier}
        )


class UnauthorizedError(BaseError):
    def __init__(self, message: str = "Unauthorized access"):
        super().__init__(
            message=message,
            code="UNAUTHORIZED",
            status_code=401
        )


class ConflictError(BaseError):
    def __init__(self, message: str, details: Optional[Dict[str, Any]] = None):
        super().__init__(
            message=message,
            code="CONFLICT",
            status_code=409,
            details=details
        )


# services/user_service.py

import logging
from typing import Optional
from sqlalchemy.exc import IntegrityError
from errors import NotFoundError, ValidationError, ConflictError

logger = logging.getLogger(__name__)


class UserService:
    def create_user(self, user_data: dict) -> User:
        """Create a new user"""

        # Input validation
        if not user_data.get("email") or not user_data.get("name"):
            raise ValidationError(
                "Email and name are required",
                details={
                    "fields": {
                        "email": "Email is required" if not user_data.get("email") else None,
                        "name": "Name is required" if not user_data.get("name") else None
                    }
                }
            )

        try:
            # Check for existing user
            existing_user = User.find_by_email(user_data["email"])
            if existing_user:
                raise ConflictError(
                    "User with this email already exists",
                    details={"email": user_data["email"]}
                )

            # Create user
            user = User(**user_data)
            db.session.add(user)
            db.session.commit()

            # Send welcome email (don't fail if this fails)
            try:
                EmailService.send_welcome_email(user.email, user.name)
            except Exception as e:
                logger.warning(f"Failed to send welcome email: {e}", extra={"user_id": user.id})

            return user

        except (ValidationError, ConflictError):
            # Re-raise known errors
            raise

        except IntegrityError as e:
            db.session.rollback()
            raise ConflictError("User already exists", details={"error": str(e)})

        except Exception as e:
            db.session.rollback()
            logger.error(f"Unexpected error creating user: {e}", exc_info=True)
            raise InternalError("Failed to create user")

    def get_user_by_id(self, user_id: int) -> User:
        """Get user by ID"""
        try:
            user = User.query.get(user_id)

            if not user:
                raise NotFoundError("User", str(user_id))

            return user

        except NotFoundError:
            raise

        except Exception as e:
            logger.error(f"Unexpected error retrieving user: {e}", exc_info=True)
            raise InternalError("Failed to retrieve user")
```

## Key Elements

1. **Error Hierarchy**: Base class with specific error types
2. **Error Codes**: Consistent error codes for client handling
3. **HTTP Status Codes**: Appropriate status codes for each error type
4. **Error Details**: Additional context for debugging
5. **Operational vs Programming Errors**: Distinguish expected vs unexpected
6. **Logging**: Comprehensive error logging with context
7. **User-Friendly Messages**: Clear, actionable error messages
8. **Stack Traces**: Include in development, exclude in production

## Common Error Types

### Client Errors (4xx)

```typescript
// 400 Bad Request
throw new ValidationError('Invalid input', {
  fields: {
    email: 'Invalid email format',
    age: 'Must be positive number'
  }
});

// 401 Unauthorized
throw new UnauthorizedError('Authentication required');

// 403 Forbidden
throw new ForbiddenError('Insufficient permissions');

// 404 Not Found
throw new NotFoundError('User', userId);

// 409 Conflict
throw new ConflictError('Resource already exists');

// 429 Too Many Requests
throw new RateLimitError('Too many requests');
```

### Server Errors (5xx)

```typescript
// 500 Internal Server Error
throw new InternalError('Unexpected error occurred');

// 502 Bad Gateway
throw new ExternalServiceError('payment-gateway', 'Service unavailable');

// 503 Service Unavailable
throw new ServiceUnavailableError('Database connection failed');
```

## Testing Pattern

```typescript
// tests/errors/user-service.test.ts

describe('UserService Error Handling', () => {
  describe('createUser', () => {
    it('should throw ValidationError for missing email', async () => {
      const userData = { name: 'Test User' };

      await expect(
        userService.createUser(userData)
      ).rejects.toThrow(ValidationError);

      await expect(
        userService.createUser(userData)
      ).rejects.toMatchObject({
        code: 'VALIDATION_ERROR',
        statusCode: 400,
        details: expect.objectContaining({
          fields: expect.objectContaining({
            email: expect.any(String)
          })
        })
      });
    });

    it('should throw ConflictError for duplicate email', async () => {
      await User.create({
        email: 'test@example.com',
        name: 'Existing User'
      });

      const userData = {
        email: 'test@example.com',
        name: 'New User'
      };

      await expect(
        userService.createUser(userData)
      ).rejects.toThrow(ConflictError);
    });

    it('should throw NotFoundError for non-existent user', async () => {
      await expect(
        userService.getUserById(999)
      ).rejects.toThrow(NotFoundError);

      await expect(
        userService.getUserById(999)
      ).rejects.toMatchObject({
        code: 'NOT_FOUND',
        statusCode: 404,
        message: expect.stringContaining('User not found: 999')
      });
    });
  });
});
```

## Common Variations

### Variation 1: Result Type (Functional Approach)

```typescript
// Instead of throwing errors, return Result type

type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E };

export class UserService {
  async createUser(userData: CreateUserDTO): Promise<Result<User, BaseError>> {
    if (!userData.email) {
      return {
        ok: false,
        error: new ValidationError('Email is required')
      };
    }

    try {
      const user = await User.create(userData);
      return { ok: true, value: user };
    } catch (error) {
      return {
        ok: false,
        error: new InternalError('Failed to create user')
      };
    }
  }
}

// Usage:
const result = await userService.createUser(userData);
if (result.ok) {
  console.log('User created:', result.value);
} else {
  console.error('Error:', result.error);
}
```

### Variation 2: Domain-Specific Errors

```typescript
// Payment domain errors

export class PaymentError extends BaseError {
  readonly statusCode = 402;
  readonly code = 'PAYMENT_ERROR';
  readonly isOperational = true;
}

export class InsufficientFundsError extends PaymentError {
  readonly code = 'INSUFFICIENT_FUNDS';

  constructor(required: number, available: number) {
    super('Insufficient funds', { required, available });
  }
}

export class CardDeclinedError extends PaymentError {
  readonly code = 'CARD_DECLINED';

  constructor(reason?: string) {
    super('Card was declined', { reason });
  }
}
```

### Variation 3: Error Recovery

```typescript
// Retry with exponential backoff

async function withRetry<T>(
  operation: () => Promise<T>,
  maxRetries = 3,
  baseDelay = 1000
): Promise<T> {
  let lastError: Error;

  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      lastError = error;

      // Don't retry operational errors
      if (error instanceof BaseError && error.isOperational) {
        throw error;
      }

      // Wait before retry (exponential backoff)
      const delay = baseDelay * Math.pow(2, attempt);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }

  throw lastError!;
}

// Usage:
const user = await withRetry(() => fetchUserFromAPI(userId));
```

## Related Patterns

- **Logger Pattern**: Structured error logging
- **Middleware Pattern**: Centralized error handling
- **Circuit Breaker Pattern**: Preventing cascading failures
- **Retry Pattern**: Recovering from transient failures

## Common Pitfalls

1. **Swallowing Errors**: Catching but not handling or logging
2. **Generic Error Messages**: Not providing context
3. **Exposing Stack Traces**: Security risk in production
4. **No Error Codes**: Clients can't programmatically handle errors
5. **Throwing Strings**: Always throw Error objects
6. **Missing Async Error Handling**: Not catching promise rejections
7. **Logging Sensitive Data**: Including passwords, tokens in logs

## Best Practices Checklist

- [ ] Use specific error classes (not generic Error)
- [ ] Include error codes for programmatic handling
- [ ] Provide user-friendly error messages
- [ ] Log errors with sufficient context
- [ ] Use appropriate HTTP status codes
- [ ] Distinguish operational vs programming errors
- [ ] Never expose sensitive data in error messages
- [ ] Handle async errors properly (try/catch or .catch())
- [ ] Test error scenarios thoroughly
- [ ] Document expected errors in API docs

## Error Response Format

### Standard Error Response

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input provided",
    "details": {
      "fields": {
        "email": "Invalid email format",
        "age": "Must be a positive number"
      }
    }
  },
  "meta": {
    "timestamp": "2025-11-19T10:30:00Z",
    "requestId": "req_abc123"
  }
}
```

## References

- Error handling best practices: https://nodejs.org/en/docs/guides/error-handling/
- HTTP status codes: https://httpstatuses.com/
- Express error handling: https://expressjs.com/en/guide/error-handling.html

## Version History

- v1.0.0 (2025-11-19): Initial pattern documentation
