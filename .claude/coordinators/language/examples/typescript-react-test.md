# Test Case: TypeScript React Component

## Test Input
"Build a TypeScript React component for a data table with sorting and filtering"

## Expected Routing

### Detection Phase
- **Keyword Matches**: "TypeScript", "React", "component" → HIGH precedence
- **Pattern**: `react` route (routes.yml line 50)
- **Language**: TypeScript

### Activation Sequence
1. **using-superpowers** - Check for applicable skills
2. **brainstorming** - Design component architecture
3. **moai-lang-typescript** - TypeScript/React expertise
4. **moai-domain-frontend** - Component patterns
5. **test-driven-development** - Write tests first
6. **verification-before-completion** - Verify component renders
7. **requesting-code-review** - Review the implementation

### Expected Code Structure
```typescript
// DataTable.test.tsx (TDD - written first)
import { render, screen, fireEvent } from '@testing-library/react';
import { DataTable } from './DataTable';

const mockData = [
  { id: 1, name: 'Alice', age: 30 },
  { id: 2, name: 'Bob', age: 25 },
];

describe('DataTable', () => {
  test('renders data correctly', () => {
    render(<DataTable data={mockData} />);
    expect(screen.getByText('Alice')).toBeInTheDocument();
    expect(screen.getByText('Bob')).toBeInTheDocument();
  });

  test('sorts data when header clicked', () => {
    render(<DataTable data={mockData} />);
    const nameHeader = screen.getByText('Name');
    fireEvent.click(nameHeader);
    // Assert sorted order
  });

  test('filters data based on search input', () => {
    render(<DataTable data={mockData} />);
    const searchInput = screen.getByPlaceholderText('Search...');
    fireEvent.change(searchInput, { target: { value: 'Alice' } });
    expect(screen.getByText('Alice')).toBeInTheDocument();
    expect(screen.queryByText('Bob')).not.toBeInTheDocument();
  });
});

// DataTable.tsx (implementation)
import React, { useState, useMemo } from 'react';
import { ChevronUp, ChevronDown } from 'lucide-react';

interface DataTableProps<T extends Record<string, any>> {
  data: T[];
  columns?: Array<{
    key: keyof T;
    label: string;
    sortable?: boolean;
  }>;
}

export function DataTable<T extends Record<string, any>>({
  data,
  columns,
}: DataTableProps<T>) {
  const [sortKey, setSortKey] = useState<keyof T | null>(null);
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('asc');
  const [filterText, setFilterText] = useState('');

  const filteredData = useMemo(() => {
    if (!filterText) return data;
    return data.filter((row) =>
      Object.values(row).some((value) =>
        String(value).toLowerCase().includes(filterText.toLowerCase())
      )
    );
  }, [data, filterText]);

  const sortedData = useMemo(() => {
    if (!sortKey) return filteredData;
    return [...filteredData].sort((a, b) => {
      const aVal = a[sortKey];
      const bVal = b[sortKey];
      const modifier = sortOrder === 'asc' ? 1 : -1;
      return aVal > bVal ? modifier : -modifier;
    });
  }, [filteredData, sortKey, sortOrder]);

  return (
    <div className="data-table">
      <input
        type="text"
        placeholder="Search..."
        value={filterText}
        onChange={(e) => setFilterText(e.target.value)}
        className="search-input"
      />
      <table>
        {/* Table implementation */}
      </table>
    </div>
  );
}

// DataTable.types.ts (Type definitions)
export interface SortConfig<T> {
  key: keyof T;
  direction: 'asc' | 'desc';
}

export interface FilterConfig {
  text: string;
  columns?: string[];
}

export interface DataTableColumn<T> {
  key: keyof T;
  label: string;
  sortable?: boolean;
  filterable?: boolean;
  render?: (value: T[keyof T], row: T) => React.ReactNode;
}
```

## Validation Points

✅ **Language Detection**: Correctly identifies TypeScript from "TypeScript" + "React"
✅ **Obra Pattern Usage**: Uses brainstorming, TDD, verification
✅ **Skill Activation**: Routes to moai-lang-typescript
✅ **Domain Enhancement**: Adds moai-domain-frontend for component patterns
✅ **Type Safety**: Ensures proper TypeScript types throughout

## Metrics to Measure
- Detection time: < 2 seconds
- Correct routing: TypeScript path
- Obra patterns used: 100%
- Skills activated: 2 (typescript, frontend)
- Type safety: 100% typed

## Common Variations

### Variation 1: With State Management
"Build a React component with Redux for state management"
- Additional consideration: State management patterns
- Enhanced complexity handling

### Variation 2: With API Integration
"Build a React component that fetches data from an API"
- Additional routing: Consider backend API patterns
- Async handling: Loading states, error boundaries

### Variation 3: With Styling
"Build a styled React component using Tailwind CSS"
- Additional focus: CSS-in-JS or utility classes
- Responsive design considerations

## Edge Cases

### Edge Case 1: JavaScript Instead of TypeScript
"Build a React component in JavaScript"
- Should still route to moai-lang-typescript (handles JS too)
- Adjust type safety requirements

### Edge Case 2: Next.js SSR Component
"Build a Next.js server-side rendered component"
- Should detect Next.js pattern
- Additional SSR considerations

### Edge Case 3: React Native
"Build a React Native component for mobile"
- May need different routing
- Platform-specific considerations

## Success Criteria
- ✅ Routes to TypeScript path in < 2 seconds
- ✅ Activates all required obra patterns
- ✅ Produces working, tested component
- ✅ Follows React best practices
- ✅ Maintains type safety throughout
- ✅ Includes proper prop validation