# React Component Pattern

## Purpose

Standardized structure for React components ensuring consistent typing, styling, performance optimization, and maintainability across the application.

## When to Use

- Creating new React functional components
- Building reusable UI elements
- Implementing feature components
- Developing page/route components

## When NOT to Use

- Class components (use functional components instead)
- Non-React UI frameworks (Vue, Angular, etc.)
- Server-side only components (use appropriate SSR patterns)

## Structure

```typescript
// Standard React component structure

import React, { useState, useEffect, useCallback, useMemo } from 'react';
import styled from 'styled-components'; // or your styling solution

// 1. Type definitions
interface ComponentNameProps {
  // Required props (no default values)
  id: string;
  title: string;

  // Optional props (use ?)
  description?: string;
  onAction?: (id: string) => void;

  // Props with defaults (defined in destructuring)
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

// 2. Main component (functional with TypeScript)
export const ComponentName: React.FC<ComponentNameProps> = React.memo(
  ({
    id,
    title,
    description,
    onAction,
    variant = 'primary',
    disabled = false
  }) => {
    // 3. State hooks (group by related state)
    const [isLoading, setIsLoading] = useState(false);
    const [data, setData] = useState<DataType | null>(null);

    // 4. Custom hooks (if any)
    const { user } = useAuth();
    const theme = useTheme();

    // 5. Memoized values
    const processedData = useMemo(() => {
      if (!data) return null;
      return expensiveOperation(data);
    }, [data]);

    // 6. Callbacks (use useCallback for event handlers)
    const handleAction = useCallback(() => {
      if (disabled || !onAction) return;
      onAction(id);
    }, [id, disabled, onAction]);

    // 7. Effects (group by concern)
    useEffect(() => {
      // Effect logic
      const fetchData = async () => {
        setIsLoading(true);
        try {
          const result = await api.getData(id);
          setData(result);
        } catch (error) {
          console.error('Failed to fetch data:', error);
        } finally {
          setIsLoading(false);
        }
      };

      fetchData();
    }, [id]);

    // 8. Early returns for loading/error states
    if (isLoading) {
      return <LoadingSpinner />;
    }

    if (!data) {
      return <ErrorMessage message="No data available" />;
    }

    // 9. Main render
    return (
      <Container variant={variant}>
        <Header>{title}</Header>
        {description && <Description>{description}</Description>}
        <Content>{processedData}</Content>
        <ActionButton onClick={handleAction} disabled={disabled}>
          Action
        </ActionButton>
      </Container>
    );
  }
);

// 10. Display name for debugging
ComponentName.displayName = 'ComponentName';

// 11. Styled components (below main component)
const Container = styled.div<{ variant: 'primary' | 'secondary' }>`
  padding: 1rem;
  background-color: ${({ variant, theme }) =>
    variant === 'primary' ? theme.colors.primary : theme.colors.secondary};
`;

const Header = styled.h2`
  font-size: 1.5rem;
  margin-bottom: 0.5rem;
`;

const Description = styled.p`
  color: ${({ theme }) => theme.colors.text.secondary};
`;

const Content = styled.div`
  margin: 1rem 0;
`;

const ActionButton = styled.button`
  padding: 0.5rem 1rem;
  background-color: ${({ theme }) => theme.colors.button};

  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
`;
```

## Key Elements

1. **TypeScript Props Interface**: Strong typing for all props
2. **Functional Component**: Use `React.FC` with TypeScript
3. **React.memo**: Wrap for performance optimization
4. **Hook Organization**: State → Custom hooks → Memoization → Callbacks → Effects
5. **Early Returns**: Loading/error states before main render
6. **Styled Components**: Co-located styling below component
7. **Display Name**: For better debugging experience

## Example Implementation

### Simple Display Component

```typescript
// components/UserCard.tsx

import React from 'react';
import styled from 'styled-components';
import { User } from '@/types';

interface UserCardProps {
  user: User;
  onClick?: (userId: string) => void;
  variant?: 'compact' | 'detailed';
}

export const UserCard: React.FC<UserCardProps> = React.memo(
  ({ user, onClick, variant = 'detailed' }) => {
    const handleClick = () => {
      if (onClick) {
        onClick(user.id);
      }
    };

    return (
      <Card onClick={handleClick} clickable={!!onClick}>
        <Avatar src={user.avatar} alt={user.name} />
        <Info>
          <Name>{user.name}</Name>
          <Email>{user.email}</Email>
          {variant === 'detailed' && (
            <Details>
              <Role>{user.role}</Role>
              <JoinDate>Joined {user.joinedAt}</JoinDate>
            </Details>
          )}
        </Info>
      </Card>
    );
  }
);

UserCard.displayName = 'UserCard';

const Card = styled.div<{ clickable: boolean }>`
  display: flex;
  gap: 1rem;
  padding: 1rem;
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: 8px;
  cursor: ${({ clickable }) => (clickable ? 'pointer' : 'default')};

  &:hover {
    background-color: ${({ clickable, theme }) =>
      clickable ? theme.colors.hover : 'transparent'};
  }
`;

const Avatar = styled.img`
  width: 48px;
  height: 48px;
  border-radius: 50%;
`;

const Info = styled.div`
  flex: 1;
`;

const Name = styled.h3`
  margin: 0;
  font-size: 1.1rem;
`;

const Email = styled.p`
  margin: 0.25rem 0;
  color: ${({ theme }) => theme.colors.text.secondary};
  font-size: 0.9rem;
`;

const Details = styled.div`
  margin-top: 0.5rem;
  display: flex;
  gap: 1rem;
`;

const Role = styled.span`
  font-size: 0.85rem;
  color: ${({ theme }) => theme.colors.primary};
`;

const JoinDate = styled.span`
  font-size: 0.85rem;
  color: ${({ theme }) => theme.colors.text.tertiary};
`;
```

### Interactive Form Component

```typescript
// components/UserForm.tsx

import React, { useState, useCallback } from 'react';
import styled from 'styled-components';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

// Validation schema
const userSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  role: z.enum(['user', 'admin', 'moderator'])
});

type UserFormData = z.infer<typeof userSchema>;

interface UserFormProps {
  initialData?: Partial<UserFormData>;
  onSubmit: (data: UserFormData) => Promise<void>;
  onCancel?: () => void;
}

export const UserForm: React.FC<UserFormProps> = React.memo(
  ({ initialData, onSubmit, onCancel }) => {
    const [isSubmitting, setIsSubmitting] = useState(false);

    const {
      register,
      handleSubmit,
      formState: { errors }
    } = useForm<UserFormData>({
      resolver: zodResolver(userSchema),
      defaultValues: initialData
    });

    const handleFormSubmit = useCallback(
      async (data: UserFormData) => {
        setIsSubmitting(true);
        try {
          await onSubmit(data);
        } catch (error) {
          console.error('Form submission failed:', error);
        } finally {
          setIsSubmitting(false);
        }
      },
      [onSubmit]
    );

    return (
      <Form onSubmit={handleSubmit(handleFormSubmit)}>
        <FormGroup>
          <Label htmlFor="name">Name</Label>
          <Input
            id="name"
            {...register('name')}
            aria-invalid={!!errors.name}
          />
          {errors.name && <ErrorMessage>{errors.name.message}</ErrorMessage>}
        </FormGroup>

        <FormGroup>
          <Label htmlFor="email">Email</Label>
          <Input
            id="email"
            type="email"
            {...register('email')}
            aria-invalid={!!errors.email}
          />
          {errors.email && <ErrorMessage>{errors.email.message}</ErrorMessage>}
        </FormGroup>

        <FormGroup>
          <Label htmlFor="role">Role</Label>
          <Select id="role" {...register('role')}>
            <option value="user">User</option>
            <option value="moderator">Moderator</option>
            <option value="admin">Admin</option>
          </Select>
          {errors.role && <ErrorMessage>{errors.role.message}</ErrorMessage>}
        </FormGroup>

        <Actions>
          {onCancel && (
            <CancelButton type="button" onClick={onCancel}>
              Cancel
            </CancelButton>
          )}
          <SubmitButton type="submit" disabled={isSubmitting}>
            {isSubmitting ? 'Submitting...' : 'Submit'}
          </SubmitButton>
        </Actions>
      </Form>
    );
  }
);

UserForm.displayName = 'UserForm';

const Form = styled.form`
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  max-width: 500px;
`;

const FormGroup = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
`;

const Label = styled.label`
  font-weight: 500;
  font-size: 0.9rem;
`;

const Input = styled.input`
  padding: 0.75rem;
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: 4px;
  font-size: 1rem;

  &[aria-invalid="true"] {
    border-color: ${({ theme }) => theme.colors.error};
  }

  &:focus {
    outline: none;
    border-color: ${({ theme }) => theme.colors.primary};
  }
`;

const Select = styled.select`
  padding: 0.75rem;
  border: 1px solid ${({ theme }) => theme.colors.border};
  border-radius: 4px;
  font-size: 1rem;
`;

const ErrorMessage = styled.span`
  color: ${({ theme }) => theme.colors.error};
  font-size: 0.85rem;
`;

const Actions = styled.div`
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 1rem;
`;

const Button = styled.button`
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;

  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
`;

const SubmitButton = styled(Button)`
  background-color: ${({ theme }) => theme.colors.primary};
  color: white;
`;

const CancelButton = styled(Button)`
  background-color: transparent;
  border: 1px solid ${({ theme }) => theme.colors.border};
`;
```

### Data Fetching Component

```typescript
// components/UserList.tsx

import React, { useEffect, useState, useCallback } from 'react';
import styled from 'styled-components';
import { useQuery } from '@tanstack/react-query';
import { User } from '@/types';
import { fetchUsers } from '@/api/users';
import { UserCard } from './UserCard';
import { LoadingSpinner } from './LoadingSpinner';
import { ErrorMessage } from './ErrorMessage';

interface UserListProps {
  onUserClick?: (userId: string) => void;
  filters?: {
    role?: string;
    search?: string;
  };
}

export const UserList: React.FC<UserListProps> = React.memo(
  ({ onUserClick, filters }) => {
    const {
      data: users,
      isLoading,
      error,
      refetch
    } = useQuery({
      queryKey: ['users', filters],
      queryFn: () => fetchUsers(filters),
      staleTime: 5 * 60 * 1000 // 5 minutes
    });

    const handleUserClick = useCallback(
      (userId: string) => {
        if (onUserClick) {
          onUserClick(userId);
        }
      },
      [onUserClick]
    );

    if (isLoading) {
      return (
        <LoadingContainer>
          <LoadingSpinner />
        </LoadingContainer>
      );
    }

    if (error) {
      return (
        <ErrorContainer>
          <ErrorMessage
            message="Failed to load users"
            onRetry={refetch}
          />
        </ErrorContainer>
      );
    }

    if (!users || users.length === 0) {
      return (
        <EmptyState>
          <EmptyIcon>👥</EmptyIcon>
          <EmptyText>No users found</EmptyText>
        </EmptyState>
      );
    }

    return (
      <Container>
        <Header>
          <Title>Users</Title>
          <Count>{users.length} users</Count>
        </Header>
        <Grid>
          {users.map((user) => (
            <UserCard
              key={user.id}
              user={user}
              onClick={handleUserClick}
            />
          ))}
        </Grid>
      </Container>
    );
  }
);

UserList.displayName = 'UserList';

const Container = styled.div`
  width: 100%;
`;

const LoadingContainer = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 200px;
`;

const ErrorContainer = styled.div`
  padding: 2rem;
`;

const Header = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
`;

const Title = styled.h2`
  margin: 0;
  font-size: 1.5rem;
`;

const Count = styled.span`
  color: ${({ theme }) => theme.colors.text.secondary};
  font-size: 0.9rem;
`;

const Grid = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1rem;
`;

const EmptyState = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 4rem 2rem;
`;

const EmptyIcon = styled.div`
  font-size: 3rem;
  margin-bottom: 1rem;
`;

const EmptyText = styled.p`
  color: ${({ theme }) => theme.colors.text.secondary};
  font-size: 1.1rem;
`;
```

## Testing Pattern

```typescript
// components/UserCard.test.tsx

import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import { ThemeProvider } from 'styled-components';
import { UserCard } from './UserCard';
import { theme } from '@/styles/theme';

const mockUser = {
  id: '1',
  name: 'John Doe',
  email: 'john@example.com',
  avatar: 'https://example.com/avatar.jpg',
  role: 'admin',
  joinedAt: '2024-01-01'
};

const renderWithTheme = (component: React.ReactElement) => {
  return render(
    <ThemeProvider theme={theme}>
      {component}
    </ThemeProvider>
  );
};

describe('UserCard', () => {
  it('should render user information', () => {
    renderWithTheme(<UserCard user={mockUser} />);

    expect(screen.getByText('John Doe')).toBeInTheDocument();
    expect(screen.getByText('john@example.com')).toBeInTheDocument();
    expect(screen.getByAltText('John Doe')).toHaveAttribute(
      'src',
      mockUser.avatar
    );
  });

  it('should call onClick when card is clicked', () => {
    const handleClick = jest.fn();
    renderWithTheme(<UserCard user={mockUser} onClick={handleClick} />);

    const card = screen.getByText('John Doe').closest('div');
    fireEvent.click(card!);

    expect(handleClick).toHaveBeenCalledWith('1');
  });

  it('should render compact variant without details', () => {
    renderWithTheme(<UserCard user={mockUser} variant="compact" />);

    expect(screen.getByText('John Doe')).toBeInTheDocument();
    expect(screen.queryByText('admin')).not.toBeInTheDocument();
  });

  it('should render detailed variant with role and join date', () => {
    renderWithTheme(<UserCard user={mockUser} variant="detailed" />);

    expect(screen.getByText('admin')).toBeInTheDocument();
    expect(screen.getByText(/Joined/)).toBeInTheDocument();
  });
});
```

## Common Variations

### Variation 1: Compound Component Pattern

**When**: Building complex components with multiple sub-components
**Changes**: Use compound component pattern for composition

```typescript
// components/Accordion/Accordion.tsx

import React, { createContext, useContext, useState } from 'react';

interface AccordionContextValue {
  activeId: string | null;
  setActiveId: (id: string | null) => void;
}

const AccordionContext = createContext<AccordionContextValue | null>(null);

export const Accordion: React.FC<{ children: React.ReactNode }> = ({
  children
}) => {
  const [activeId, setActiveId] = useState<string | null>(null);

  return (
    <AccordionContext.Provider value={{ activeId, setActiveId }}>
      <div>{children}</div>
    </AccordionContext.Provider>
  );
};

export const AccordionItem: React.FC<{
  id: string;
  children: React.ReactNode;
}> = ({ id, children }) => {
  return <div data-id={id}>{children}</div>;
};

// Usage:
// <Accordion>
//   <AccordionItem id="1">...</AccordionItem>
//   <AccordionItem id="2">...</AccordionItem>
// </Accordion>
```

### Variation 2: Render Props Pattern

**When**: Sharing stateful logic between components
**Changes**: Pass render function as prop

```typescript
interface DataFetcherProps<T> {
  url: string;
  children: (data: {
    data: T | null;
    loading: boolean;
    error: Error | null;
  }) => React.ReactNode;
}

export function DataFetcher<T>({ url, children }: DataFetcherProps<T>) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    fetchData();
  }, [url]);

  return <>{children({ data, loading, error })}</>;
}

// Usage:
// <DataFetcher url="/api/users">
//   {({ data, loading, error }) => {
//     if (loading) return <Spinner />;
//     if (error) return <Error />;
//     return <UserList users={data} />;
//   }}
// </DataFetcher>
```

## Related Patterns

- **Custom Hook Pattern**: Extract reusable logic into hooks
- **Context Pattern**: Share state across component tree
- **HOC Pattern**: Wrap components with additional functionality
- **Styled Components Pattern**: Co-located component styling

## Common Pitfalls

1. **Missing React.memo**: Unnecessary re-renders for expensive components
2. **Inline Functions**: Not using useCallback for event handlers
3. **Missing Dependencies**: useEffect/useCallback dependency arrays
4. **Prop Drilling**: Not using context for deeply nested props
5. **No Error Boundaries**: Components crash entire app
6. **Missing Accessibility**: No ARIA attributes for screen readers

## Performance Optimization Checklist

- [ ] Use React.memo for components that receive stable props
- [ ] Use useCallback for event handlers passed to child components
- [ ] Use useMemo for expensive computations
- [ ] Avoid inline object/array creation in JSX
- [ ] Use code splitting (React.lazy) for large components
- [ ] Implement virtualization for long lists

## Accessibility Checklist

- [ ] Semantic HTML elements (button, nav, main, etc.)
- [ ] ARIA attributes where needed (aria-label, aria-describedby)
- [ ] Keyboard navigation support
- [ ] Focus management for modals/dialogs
- [ ] Color contrast ratios (WCAG AA minimum)
- [ ] Screen reader testing

## References

- React documentation: https://react.dev/
- TypeScript with React: https://react-typescript-cheatsheet.netlify.app/
- Styled Components: https://styled-components.com/
- React Testing Library: https://testing-library.com/react

## Version History

- v1.0.0 (2025-11-19): Initial pattern documentation
