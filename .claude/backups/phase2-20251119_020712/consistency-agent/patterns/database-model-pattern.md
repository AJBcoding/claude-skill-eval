# Database Model Pattern

## Purpose

Standardized structure for database models (ORM) ensuring consistent schema definition, validation, relationships, and query patterns across the application.

## When to Use

- Creating new database tables/collections
- Defining ORM models (Sequelize, TypeORM, Prisma, SQLAlchemy, Mongoose)
- Implementing data persistence layer
- Setting up database migrations

## When NOT to Use

- Raw SQL queries (use query builder or repository pattern)
- NoSQL document stores without schema (use schema validation patterns)
- In-memory data structures (use appropriate data structure patterns)

## Structure

### Sequelize (Node.js/TypeScript)

```typescript
// models/User.ts

import {
  Model,
  DataTypes,
  InferAttributes,
  InferCreationAttributes,
  CreationOptional,
  Association,
  HasManyGetAssociationsMixin,
  HasManyCreateAssociationMixin
} from 'sequelize';
import { sequelize } from '@/config/database';
import { Order } from './Order';

// 1. Define model class with type inference
export class User extends Model<
  InferAttributes<User>,
  InferCreationAttributes<User>
> {
  // 2. Primary key
  declare id: CreationOptional<number>;

  // 3. Required fields
  declare email: string;
  declare name: string;
  declare passwordHash: string;

  // 4. Optional fields
  declare avatar: string | null;
  declare role: 'user' | 'admin' | 'moderator';

  // 5. Timestamp fields (handled by Sequelize)
  declare createdAt: CreationOptional<Date>;
  declare updatedAt: CreationOptional<Date>;
  declare deletedAt: CreationOptional<Date | null>;

  // 6. Association mixins
  declare getOrders: HasManyGetAssociationsMixin<Order>;
  declare createOrder: HasManyCreateAssociationMixin<Order>;

  // 7. Static associations property
  declare static associations: {
    orders: Association<User, Order>;
  };

  // 8. Instance methods
  toJSON() {
    const values = { ...this.get() };
    delete values.passwordHash; // Never expose password hash
    return values;
  }

  // 9. Static methods
  static async findByEmail(email: string): Promise<User | null> {
    return await User.findOne({ where: { email } });
  }
}

// 10. Initialize model
User.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    email: {
      type: DataTypes.STRING(255),
      allowNull: false,
      unique: true,
      validate: {
        isEmail: {
          msg: 'Invalid email address'
        }
      }
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false,
      validate: {
        len: {
          args: [2, 100],
          msg: 'Name must be between 2 and 100 characters'
        }
      }
    },
    passwordHash: {
      type: DataTypes.STRING(255),
      allowNull: false,
      field: 'password_hash' // Database column name (snake_case)
    },
    avatar: {
      type: DataTypes.STRING(500),
      allowNull: true,
      validate: {
        isUrl: {
          msg: 'Avatar must be a valid URL'
        }
      }
    },
    role: {
      type: DataTypes.ENUM('user', 'admin', 'moderator'),
      allowNull: false,
      defaultValue: 'user'
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      field: 'created_at'
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      field: 'updated_at'
    },
    deletedAt: {
      type: DataTypes.DATE,
      allowNull: true,
      field: 'deleted_at'
    }
  },
  {
    sequelize,
    tableName: 'users',
    modelName: 'User',
    timestamps: true,
    paranoid: true, // Soft delete
    underscored: true, // Use snake_case for auto-generated fields
    indexes: [
      {
        unique: true,
        fields: ['email']
      },
      {
        fields: ['role']
      },
      {
        fields: ['created_at']
      }
    ]
  }
);

// 11. Define associations (in separate file or after all models loaded)
export const setupUserAssociations = () => {
  User.hasMany(Order, {
    foreignKey: 'userId',
    as: 'orders'
  });
};
```

### SQLAlchemy (Python)

```python
# models/user.py

from sqlalchemy import Column, Integer, String, DateTime, Enum, Index
from sqlalchemy.orm import relationship
from sqlalchemy.ext.hybrid import hybrid_property
from datetime import datetime
from typing import List
import enum

from database import Base
from .order import Order

# 1. Enum definitions
class UserRole(str, enum.Enum):
    USER = "user"
    ADMIN = "admin"
    MODERATOR = "moderator"

# 2. Model class
class User(Base):
    __tablename__ = "users"

    # 3. Primary key
    id = Column(Integer, primary_key=True, autoincrement=True)

    # 4. Required fields
    email = Column(String(255), nullable=False, unique=True, index=True)
    name = Column(String(100), nullable=False)
    password_hash = Column(String(255), nullable=False)

    # 5. Optional fields
    avatar = Column(String(500), nullable=True)
    role = Column(Enum(UserRole), nullable=False, default=UserRole.USER)

    # 6. Timestamp fields
    created_at = Column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
        onupdate=datetime.utcnow
    )
    deleted_at = Column(DateTime, nullable=True)

    # 7. Relationships
    orders: List["Order"] = relationship(
        "Order",
        back_populates="user",
        lazy="select",
        cascade="all, delete-orphan"
    )

    # 8. Indexes
    __table_args__ = (
        Index("idx_user_email", "email"),
        Index("idx_user_role", "role"),
        Index("idx_user_created_at", "created_at"),
    )

    # 9. Hybrid properties
    @hybrid_property
    def is_admin(self) -> bool:
        return self.role == UserRole.ADMIN

    # 10. Instance methods
    def to_dict(self) -> dict:
        """Convert model to dictionary (excluding password_hash)"""
        return {
            "id": self.id,
            "email": self.email,
            "name": self.name,
            "avatar": self.avatar,
            "role": self.role.value,
            "created_at": self.created_at.isoformat(),
            "updated_at": self.updated_at.isoformat(),
        }

    def __repr__(self) -> str:
        return f"<User(id={self.id}, email={self.email}, role={self.role})>"

    # 11. Class methods
    @classmethod
    def find_by_email(cls, email: str):
        """Find user by email"""
        from database import db_session
        return db_session.query(cls).filter_by(email=email).first()

    @classmethod
    def find_active_users(cls):
        """Find all non-deleted users"""
        from database import db_session
        return db_session.query(cls).filter(cls.deleted_at.is_(None)).all()
```

### Prisma (Node.js/TypeScript)

```prisma
// schema.prisma

model User {
  // 1. Primary key
  id        Int      @id @default(autoincrement())

  // 2. Required fields
  email     String   @unique @db.VarChar(255)
  name      String   @db.VarChar(100)
  passwordHash String @map("password_hash") @db.VarChar(255)

  // 3. Optional fields
  avatar    String?  @db.VarChar(500)
  role      UserRole @default(USER)

  // 4. Timestamp fields
  createdAt DateTime @default(now()) @map("created_at")
  updatedAt DateTime @updatedAt @map("updated_at")
  deletedAt DateTime? @map("deleted_at")

  // 5. Relations
  orders    Order[]

  // 6. Indexes
  @@index([email])
  @@index([role])
  @@index([createdAt])

  // 7. Table name
  @@map("users")
}

enum UserRole {
  USER
  ADMIN
  MODERATOR
}
```

## Key Elements

1. **Primary Key**: Auto-incrementing ID or UUID
2. **Required Fields**: Core business data (NOT NULL)
3. **Optional Fields**: Additional data (NULLABLE)
4. **Timestamps**: created_at, updated_at (auto-managed)
5. **Soft Delete**: deleted_at field (paranoid delete)
6. **Validations**: Field-level constraints and validation
7. **Indexes**: Performance optimization for queries
8. **Relationships**: Foreign keys and associations
9. **Methods**: Instance and class methods for business logic

## Example Implementations

### One-to-Many Relationship

```typescript
// models/Order.ts

export class Order extends Model<
  InferAttributes<Order>,
  InferCreationAttributes<Order>
> {
  declare id: CreationOptional<number>;
  declare userId: number;
  declare total: number;
  declare status: 'pending' | 'completed' | 'cancelled';
  declare createdAt: CreationOptional<Date>;
  declare updatedAt: CreationOptional<Date>;

  // Association
  declare user?: NonAttribute<User>;
  declare getUser: BelongsToGetAssociationMixin<User>;
}

Order.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      field: 'user_id',
      references: {
        model: 'users',
        key: 'id'
      },
      onDelete: 'CASCADE',
      onUpdate: 'CASCADE'
    },
    total: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
      validate: {
        min: {
          args: [0],
          msg: 'Total must be positive'
        }
      }
    },
    status: {
      type: DataTypes.ENUM('pending', 'completed', 'cancelled'),
      allowNull: false,
      defaultValue: 'pending'
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      field: 'created_at'
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      field: 'updated_at'
    }
  },
  {
    sequelize,
    tableName: 'orders',
    modelName: 'Order',
    timestamps: true,
    underscored: true,
    indexes: [
      {
        fields: ['user_id']
      },
      {
        fields: ['status']
      },
      {
        fields: ['created_at']
      }
    ]
  }
);

// Setup association
Order.belongsTo(User, {
  foreignKey: 'userId',
  as: 'user'
});
```

### Many-to-Many Relationship

```typescript
// models/Product.ts and models/Category.ts with junction table

export class Product extends Model<
  InferAttributes<Product>,
  InferCreationAttributes<Product>
> {
  declare id: CreationOptional<number>;
  declare name: string;
  declare price: number;
  declare createdAt: CreationOptional<Date>;
  declare updatedAt: CreationOptional<Date>;

  declare categories?: NonAttribute<Category[]>;
  declare getCategories: BelongsToManyGetAssociationsMixin<Category>;
  declare addCategory: BelongsToManyAddAssociationMixin<Category, number>;
}

export class Category extends Model<
  InferAttributes<Category>,
  InferCreationAttributes<Category>
> {
  declare id: CreationOptional<number>;
  declare name: string;
  declare createdAt: CreationOptional<Date>;
  declare updatedAt: CreationOptional<Date>;

  declare products?: NonAttribute<Product[]>;
  declare getProducts: BelongsToManyGetAssociationsMixin<Product>;
}

// Junction table
export class ProductCategory extends Model<
  InferAttributes<ProductCategory>,
  InferCreationAttributes<ProductCategory>
> {
  declare productId: number;
  declare categoryId: number;
  declare createdAt: CreationOptional<Date>;
}

// Setup associations
Product.belongsToMany(Category, {
  through: ProductCategory,
  foreignKey: 'productId',
  as: 'categories'
});

Category.belongsToMany(Product, {
  through: ProductCategory,
  foreignKey: 'categoryId',
  as: 'products'
});
```

### Model with Hooks/Middleware

```typescript
// models/User.ts with hooks

import bcrypt from 'bcrypt';

User.init(
  {
    // ... field definitions
  },
  {
    sequelize,
    tableName: 'users',
    hooks: {
      // Before create hook
      beforeCreate: async (user) => {
        // Hash password before saving
        if (user.passwordHash) {
          user.passwordHash = await bcrypt.hash(user.passwordHash, 10);
        }
      },

      // Before update hook
      beforeUpdate: async (user) => {
        // Hash password if changed
        if (user.changed('passwordHash')) {
          user.passwordHash = await bcrypt.hash(user.passwordHash, 10);
        }
      },

      // After create hook
      afterCreate: async (user) => {
        // Send welcome email
        await EmailService.sendWelcomeEmail(user.email, user.name);
      }
    }
  }
);
```

## Migration Pattern

### Sequelize Migration

```typescript
// migrations/20251119-create-users.ts

import { QueryInterface, DataTypes } from 'sequelize';

export default {
  up: async (queryInterface: QueryInterface) => {
    await queryInterface.createTable('users', {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      email: {
        type: DataTypes.STRING(255),
        allowNull: false,
        unique: true
      },
      name: {
        type: DataTypes.STRING(100),
        allowNull: false
      },
      password_hash: {
        type: DataTypes.STRING(255),
        allowNull: false
      },
      avatar: {
        type: DataTypes.STRING(500),
        allowNull: true
      },
      role: {
        type: DataTypes.ENUM('user', 'admin', 'moderator'),
        allowNull: false,
        defaultValue: 'user'
      },
      created_at: {
        type: DataTypes.DATE,
        allowNull: false
      },
      updated_at: {
        type: DataTypes.DATE,
        allowNull: false
      },
      deleted_at: {
        type: DataTypes.DATE,
        allowNull: true
      }
    });

    // Add indexes
    await queryInterface.addIndex('users', ['email'], { unique: true });
    await queryInterface.addIndex('users', ['role']);
    await queryInterface.addIndex('users', ['created_at']);
  },

  down: async (queryInterface: QueryInterface) => {
    await queryInterface.dropTable('users');
  }
};
```

## Testing Pattern

```typescript
// tests/models/User.test.ts

import { User } from '@/models/User';
import { sequelize } from '@/config/database';

describe('User Model', () => {
  beforeAll(async () => {
    await sequelize.sync({ force: true });
  });

  afterAll(async () => {
    await sequelize.close();
  });

  afterEach(async () => {
    await User.destroy({ where: {}, force: true });
  });

  describe('Validations', () => {
    it('should create user with valid data', async () => {
      const user = await User.create({
        email: 'test@example.com',
        name: 'Test User',
        passwordHash: 'hashedpassword'
      });

      expect(user.id).toBeDefined();
      expect(user.email).toBe('test@example.com');
      expect(user.role).toBe('user'); // Default value
    });

    it('should fail with invalid email', async () => {
      await expect(
        User.create({
          email: 'invalid-email',
          name: 'Test User',
          passwordHash: 'hashedpassword'
        })
      ).rejects.toThrow('Invalid email address');
    });

    it('should fail with duplicate email', async () => {
      await User.create({
        email: 'test@example.com',
        name: 'User 1',
        passwordHash: 'hashedpassword'
      });

      await expect(
        User.create({
          email: 'test@example.com',
          name: 'User 2',
          passwordHash: 'hashedpassword'
        })
      ).rejects.toThrow();
    });

    it('should fail with short name', async () => {
      await expect(
        User.create({
          email: 'test@example.com',
          name: 'A',
          passwordHash: 'hashedpassword'
        })
      ).rejects.toThrow('Name must be between 2 and 100 characters');
    });
  });

  describe('Methods', () => {
    it('should find user by email', async () => {
      await User.create({
        email: 'test@example.com',
        name: 'Test User',
        passwordHash: 'hashedpassword'
      });

      const user = await User.findByEmail('test@example.com');

      expect(user).toBeDefined();
      expect(user?.email).toBe('test@example.com');
    });

    it('should exclude passwordHash from JSON', () => {
      const user = User.build({
        email: 'test@example.com',
        name: 'Test User',
        passwordHash: 'hashedpassword'
      });

      const json = user.toJSON();

      expect(json.passwordHash).toBeUndefined();
      expect(json.email).toBe('test@example.com');
    });
  });

  describe('Soft Delete', () => {
    it('should soft delete user', async () => {
      const user = await User.create({
        email: 'test@example.com',
        name: 'Test User',
        passwordHash: 'hashedpassword'
      });

      await user.destroy();

      const foundUser = await User.findByPk(user.id);
      expect(foundUser).toBeNull(); // Not found in default scope

      const deletedUser = await User.findByPk(user.id, { paranoid: false });
      expect(deletedUser).toBeDefined();
      expect(deletedUser?.deletedAt).toBeDefined();
    });
  });
});
```

## Common Variations

### Variation 1: UUID Primary Key

```typescript
User.init(
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    // ... other fields
  },
  {
    // ... options
  }
);
```

### Variation 2: Composite Primary Key

```typescript
UserRole.init(
  {
    userId: {
      type: DataTypes.INTEGER,
      primaryKey: true
    },
    roleId: {
      type: DataTypes.INTEGER,
      primaryKey: true
    }
  },
  {
    sequelize,
    tableName: 'user_roles'
  }
);
```

### Variation 3: JSON Field

```typescript
Settings.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    preferences: {
      type: DataTypes.JSONB, // PostgreSQL JSONB
      allowNull: false,
      defaultValue: {}
    }
  },
  {
    sequelize,
    tableName: 'settings'
  }
);
```

## Related Patterns

- **Repository Pattern**: Abstract database access
- **Unit of Work Pattern**: Transaction management
- **Query Builder Pattern**: Complex query construction
- **Migration Pattern**: Schema versioning

## Common Pitfalls

1. **N+1 Query Problem**: Not using eager loading for associations
2. **Missing Indexes**: Slow queries on frequently searched fields
3. **No Validation**: Allowing invalid data into database
4. **Exposing Sensitive Data**: Including password hashes in JSON
5. **Hard Delete**: Not using soft delete for audit trail
6. **Missing Timestamps**: No created_at/updated_at tracking
7. **No Foreign Key Constraints**: Data integrity issues

## Best Practices Checklist

- [ ] Primary key defined (auto-increment or UUID)
- [ ] Timestamp fields (created_at, updated_at)
- [ ] Soft delete field (deleted_at) if applicable
- [ ] Proper validations on all fields
- [ ] Indexes on frequently queried fields
- [ ] Foreign key constraints with CASCADE rules
- [ ] Exclude sensitive data from toJSON()
- [ ] Migration file for schema changes
- [ ] Unit tests for validations and methods

## References

- Sequelize: https://sequelize.org/
- SQLAlchemy: https://www.sqlalchemy.org/
- Prisma: https://www.prisma.io/
- TypeORM: https://typeorm.io/

## Version History

- v1.0.0 (2025-11-19): Initial pattern documentation
