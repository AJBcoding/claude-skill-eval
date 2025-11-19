# API Endpoint Pattern

## Purpose

Standardized structure for RESTful API endpoints ensuring consistent authentication, validation, error handling, and response formatting across the application.

## When to Use

- Creating new REST API endpoints
- Adding routes to Express/Fastify/similar frameworks
- Implementing CRUD operations
- Exposing backend functionality to frontend

## When NOT to Use

- GraphQL resolvers (use graphql-resolver-pattern.md)
- WebSocket handlers (use websocket-pattern.md)
- Internal service methods (use service-pattern.md)
- Scheduled jobs or background tasks

## Structure

```javascript
// Standard API endpoint structure

router.[method]('/resource/:id?',
  // 1. Authentication middleware (if required)
  authenticate,

  // 2. Authorization middleware (if required)
  authorize(['role1', 'role2']),

  // 3. Validation middleware
  validate(resourceSchema),

  // 4. Rate limiting (if required)
  rateLimit({ windowMs: 15 * 60 * 1000, max: 100 }),

  // 5. Async route handler
  async (req, res, next) => {
    try {
      // 6. Extract and validate inputs
      const { id } = req.params;
      const data = req.body;

      // 7. Business logic (preferably delegated to service layer)
      const result = await ResourceService.operation(id, data);

      // 8. Standard success response
      res.status(200).json({
        success: true,
        data: result,
        meta: {
          timestamp: new Date().toISOString()
        }
      });

    } catch (error) {
      // 9. Error handling
      next(error); // Pass to error handling middleware
    }
  }
);
```

## Key Elements

1. **HTTP Method Selection**: Use appropriate HTTP verb (GET, POST, PUT, PATCH, DELETE)
2. **Route Path**: RESTful naming conventions (`/resources`, `/resources/:id`)
3. **Middleware Chain**: Authentication → Authorization → Validation → Handler
4. **Async Handlers**: Always use async/await for asynchronous operations
5. **Error Handling**: Try/catch with next(error) or global error handler
6. **Response Format**: Consistent JSON structure across all endpoints
7. **Status Codes**: Appropriate HTTP status codes (200, 201, 400, 404, 500, etc.)

## Example Implementation

### GET Endpoint (Read)

```javascript
// GET /api/users/:id - Retrieve single user

router.get('/users/:id',
  authenticate,
  async (req, res, next) => {
    try {
      const { id } = req.params;

      const user = await User.findByPk(id);

      if (!user) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'USER_NOT_FOUND',
            message: 'User not found'
          }
        });
      }

      res.status(200).json({
        success: true,
        data: user.toJSON()
      });

    } catch (error) {
      next(error);
    }
  }
);
```

### POST Endpoint (Create)

```javascript
// POST /api/users - Create new user

const createUserSchema = Joi.object({
  email: Joi.string().email().required(),
  name: Joi.string().min(2).max(100).required(),
  role: Joi.string().valid('user', 'admin').default('user')
});

router.post('/users',
  authenticate,
  authorize(['admin']),
  validate(createUserSchema),
  async (req, res, next) => {
    try {
      const userData = req.body;

      // Use transaction for data integrity
      const user = await db.transaction(async (trx) => {
        const newUser = await User.create(userData, { transaction: trx });

        // Additional operations in same transaction
        await AuditLog.create({
          action: 'USER_CREATED',
          userId: req.user.id,
          resourceId: newUser.id
        }, { transaction: trx });

        return newUser;
      });

      res.status(201).json({
        success: true,
        data: user.toJSON(),
        meta: {
          created: true
        }
      });

    } catch (error) {
      if (error.name === 'SequelizeUniqueConstraintError') {
        return res.status(409).json({
          success: false,
          error: {
            code: 'USER_ALREADY_EXISTS',
            message: 'User with this email already exists'
          }
        });
      }
      next(error);
    }
  }
);
```

### PUT/PATCH Endpoint (Update)

```javascript
// PATCH /api/users/:id - Update user

const updateUserSchema = Joi.object({
  name: Joi.string().min(2).max(100),
  email: Joi.string().email(),
  role: Joi.string().valid('user', 'admin')
}).min(1); // At least one field required

router.patch('/users/:id',
  authenticate,
  authorize(['admin', 'self']), // Can update self or admin can update anyone
  validate(updateUserSchema),
  async (req, res, next) => {
    try {
      const { id } = req.params;
      const updates = req.body;

      const user = await User.findByPk(id);

      if (!user) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'USER_NOT_FOUND',
            message: 'User not found'
          }
        });
      }

      await user.update(updates);

      res.status(200).json({
        success: true,
        data: user.toJSON(),
        meta: {
          updated: true
        }
      });

    } catch (error) {
      next(error);
    }
  }
);
```

### DELETE Endpoint (Delete)

```javascript
// DELETE /api/users/:id - Delete user (soft delete)

router.delete('/users/:id',
  authenticate,
  authorize(['admin']),
  async (req, res, next) => {
    try {
      const { id } = req.params;

      const user = await User.findByPk(id);

      if (!user) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'USER_NOT_FOUND',
            message: 'User not found'
          }
        });
      }

      // Soft delete (sets deleted_at timestamp)
      await user.destroy();

      res.status(200).json({
        success: true,
        data: {
          id: user.id,
          deleted: true
        }
      });

    } catch (error) {
      next(error);
    }
  }
);
```

## Testing Pattern

```javascript
// tests/api/users.test.js

describe('POST /api/users', () => {
  it('should create a new user with valid data', async () => {
    const userData = {
      email: 'test@example.com',
      name: 'Test User',
      role: 'user'
    };

    const response = await request(app)
      .post('/api/users')
      .set('Authorization', `Bearer ${adminToken}`)
      .send(userData)
      .expect(201);

    expect(response.body.success).toBe(true);
    expect(response.body.data).toHaveProperty('id');
    expect(response.body.data.email).toBe(userData.email);
  });

  it('should return 400 for invalid email', async () => {
    const userData = {
      email: 'invalid-email',
      name: 'Test User'
    };

    const response = await request(app)
      .post('/api/users')
      .set('Authorization', `Bearer ${adminToken}`)
      .send(userData)
      .expect(400);

    expect(response.body.success).toBe(false);
    expect(response.body.error).toHaveProperty('code');
  });

  it('should return 401 without authentication', async () => {
    const userData = {
      email: 'test@example.com',
      name: 'Test User'
    };

    await request(app)
      .post('/api/users')
      .send(userData)
      .expect(401);
  });
});
```

## Common Variations

### Variation 1: Paginated List Endpoint

**When**: Returning lists of resources
**Changes**: Add pagination, filtering, sorting

```javascript
router.get('/users',
  authenticate,
  async (req, res, next) => {
    try {
      const {
        page = 1,
        limit = 10,
        sortBy = 'createdAt',
        order = 'DESC',
        search = ''
      } = req.query;

      const offset = (page - 1) * limit;

      const { rows: users, count } = await User.findAndCountAll({
        where: search ? {
          [Op.or]: [
            { name: { [Op.iLike]: `%${search}%` } },
            { email: { [Op.iLike]: `%${search}%` } }
          ]
        } : {},
        limit: parseInt(limit),
        offset: parseInt(offset),
        order: [[sortBy, order]]
      });

      res.status(200).json({
        success: true,
        data: users.map(u => u.toJSON()),
        meta: {
          pagination: {
            page: parseInt(page),
            limit: parseInt(limit),
            total: count,
            pages: Math.ceil(count / limit)
          }
        }
      });

    } catch (error) {
      next(error);
    }
  }
);
```

### Variation 2: Bulk Operations

**When**: Operating on multiple resources
**Changes**: Accept array of items, return array of results

```javascript
router.post('/users/bulk',
  authenticate,
  authorize(['admin']),
  validate(Joi.object({
    users: Joi.array().items(createUserSchema).min(1).max(100)
  })),
  async (req, res, next) => {
    try {
      const { users } = req.body;

      const results = await db.transaction(async (trx) => {
        return await Promise.all(
          users.map(userData => User.create(userData, { transaction: trx }))
        );
      });

      res.status(201).json({
        success: true,
        data: results.map(u => u.toJSON()),
        meta: {
          created: results.length
        }
      });

    } catch (error) {
      next(error);
    }
  }
);
```

### Variation 3: File Upload Endpoint

**When**: Handling file uploads
**Changes**: Add multer middleware, handle files

```javascript
const upload = multer({ dest: 'uploads/' });

router.post('/users/:id/avatar',
  authenticate,
  upload.single('avatar'),
  async (req, res, next) => {
    try {
      const { id } = req.params;
      const file = req.file;

      if (!file) {
        return res.status(400).json({
          success: false,
          error: {
            code: 'FILE_REQUIRED',
            message: 'Avatar file is required'
          }
        });
      }

      const user = await User.findByPk(id);

      if (!user) {
        return res.status(404).json({
          success: false,
          error: {
            code: 'USER_NOT_FOUND',
            message: 'User not found'
          }
        });
      }

      // Upload to storage service
      const avatarUrl = await StorageService.upload(file.path, {
        folder: 'avatars',
        public: true
      });

      await user.update({ avatar: avatarUrl });

      res.status(200).json({
        success: true,
        data: {
          avatar: avatarUrl
        }
      });

    } catch (error) {
      next(error);
    }
  }
);
```

## Related Patterns

- **Service Pattern**: Business logic should be in service layer
- **Error Handling Pattern**: Centralized error handling middleware
- **Validation Pattern**: Request validation schemas
- **Authentication Pattern**: JWT/session authentication middleware
- **Database Transaction Pattern**: Ensuring data consistency

## Common Pitfalls

1. **Missing Authentication**: Always require auth unless explicitly public
2. **Inconsistent Response Format**: Use standard `{ success, data, error }` structure
3. **No Input Validation**: Always validate request data
4. **Direct Database Access**: Use service layer for business logic
5. **Ignoring Error Handling**: Always catch errors and use proper status codes
6. **Missing Tests**: Every endpoint needs tests for success, validation, and auth

## Response Format Standards

### Success Response

```javascript
{
  "success": true,
  "data": {
    // Resource data
  },
  "meta": {
    "timestamp": "2025-11-19T10:30:00Z",
    // Optional: pagination, stats, etc.
  }
}
```

### Error Response

```javascript
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {
      // Optional: validation errors, field errors, etc.
    }
  },
  "meta": {
    "timestamp": "2025-11-19T10:30:00Z",
    "requestId": "uuid"
  }
}
```

## References

- Express.js routing: https://expressjs.com/en/guide/routing.html
- REST API best practices: https://restfulapi.net/
- HTTP status codes: https://httpstatuses.com/

## Version History

- v1.0.0 (2025-11-19): Initial pattern documentation
