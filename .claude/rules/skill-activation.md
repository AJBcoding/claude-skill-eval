# Skill Activation Guidelines

## Core Principle
**Check for applicable skills before implementing.** Skills provide specialized knowledge, patterns, and context that improve code quality and consistency.

## Skill Check Process

### Step 1: Analyze the Task
**Strong nudge:** Before writing any code, identify the task domain and technology.

**Ask yourself:**
- What language am I working with?
- What framework or library is involved?
- What type of problem is this (database, frontend, security, etc.)?
- Are there specialized tools or patterns for this domain?

### Step 2: Check for Applicable Skills
**Strong nudge:** Review available skills to see if any match your task.

**How to check:**
1. Review the skills list in your context
2. Look for domain-specific skills (Python, TypeScript, security, etc.)
3. Look for task-specific skills (database optimization, testing, etc.)
4. Consider meta-skills (skill creation, documentation, etc.)

### Step 3: Activate Before Implementing
**Strong nudge:** Load the skill BEFORE starting implementation.

**Good workflow:**
```
Task: "Optimize this slow SQL query"
1. Identify: This is a database/SQL task
2. Check: sql-optimization-patterns skill available
3. Activate: Use the skill
4. Implement: Follow the skill's guidance
```

**Bad workflow:**
```
Task: "Optimize this slow SQL query"
1. Start writing query modifications
2. Realize there might be better patterns
3. Try to retrofit skill guidance (too late)
```

## Required Skill Usage

### Python Development
**ENFORCE:** Use `moai-lang-python` for ALL Python tasks.

The moai-lang-python skill provides:
- Python 3.13.9 best practices
- FastAPI 0.115.x patterns
- Django 5.2 LTS patterns
- Pydantic v2 validation
- SQLAlchemy 2.0 patterns
- Async/await patterns
- Testing frameworks
- Production deployment strategies

**When to activate:**
- Writing new Python code
- Modifying existing Python code
- API development with FastAPI or Django
- Database operations with SQLAlchemy
- Data validation with Pydantic
- Async Python operations
- Python testing
- Python performance optimization

**Example triggers:**
```
"Create a FastAPI endpoint for..."           → moai-lang-python
"Add Pydantic validation to..."              → moai-lang-python
"Optimize this Python function..."           → moai-lang-python
"Write tests for this Python module..."      → moai-lang-python
"Set up SQLAlchemy models for..."            → moai-lang-python
```

### TypeScript Development
**ENFORCE:** Use `moai-lang-typescript` for ALL TypeScript tasks.

The moai-lang-typescript skill provides:
- TypeScript 5.9.3 best practices
- Next.js 16 patterns
- React 19 patterns
- tRPC usage
- Zod schemas for type safety
- Full-stack development patterns
- API contract definition
- Framework-agnostic TypeScript

**When to activate:**
- Writing new TypeScript code
- Modifying existing TypeScript code
- React component development
- Next.js application development
- tRPC API development
- Type definition and type safety
- Frontend state management
- TypeScript testing

**Example triggers:**
```
"Create a React component for..."            → moai-lang-typescript
"Add type definitions for..."                → moai-lang-typescript
"Set up tRPC router for..."                  → moai-lang-typescript
"Create Zod schema for..."                   → moai-lang-typescript
"Build Next.js page for..."                  → moai-lang-typescript
```

### Frontend Development
**STRONG NUDGE:** Use `moai-domain-frontend` for complex frontend tasks.

The moai-domain-frontend skill provides:
- Modern architecture patterns
- Component orchestration
- State management
- Performance optimization
- Accessibility standards
- Responsive design

**When to activate:**
- Complex UI component development
- Frontend architecture decisions
- State management setup
- Performance optimization
- Accessibility improvements

### Database Operations
**STRONG NUDGE:** Use `moai-domain-database` for database tasks.

**When to activate:**
- Schema design
- Query optimization
- Database migrations
- ORM configuration
- Data modeling

### Security Implementation
**ENFORCE:** Use `moai-domain-security` for security-related tasks.

The moai-domain-security skill provides:
- OWASP Top 10 2021 protection
- Zero-trust architecture
- Threat modeling (STRIDE, PASTA)
- Secure SDLC
- DevSecOps automation
- Cloud security
- Cryptography patterns
- Identity & access management
- Compliance (SOC 2, ISO 27001, GDPR, CCPA)

**When to activate:**
- Authentication implementation
- Authorization logic
- Security vulnerability fixes
- Encryption implementation
- Security audit or review
- Compliance requirements
- Threat modeling

**Example triggers:**
```
"Add authentication to..."                   → moai-domain-security
"Implement role-based access control..."     → moai-domain-security
"Encrypt sensitive data..."                  → moai-domain-security
"Fix security vulnerability..."              → moai-domain-security
"Review code for security issues..."         → moai-domain-security
```

## Other Specialized Skills

### SQL Optimization
**STRONG NUDGE:** Use `sql-optimization-patterns` for query optimization.

**When to activate:**
- Slow query debugging
- Index optimization
- EXPLAIN plan analysis
- Query rewriting
- Database performance tuning

**Example:**
```
Task: "This query is taking 10 seconds"
→ Activate sql-optimization-patterns
→ Follow EXPLAIN analysis patterns
→ Apply indexing strategies
```

### Python Performance
**STRONG NUDGE:** Use `python-performance-optimization` for performance issues.

**When to activate:**
- Profiling Python code
- Optimizing bottlenecks
- Memory optimization
- Performance debugging

### Browser Automation
**STRONG NUDGE:** Use `playwright-skill` or `webapp-testing` for browser tasks.

**When to activate:**
- Testing web applications
- Browser automation
- Screenshot capture
- Form interaction testing
- E2E testing

### Swift Development
**STRONG NUDGE:** Use `developing-with-swift` for Swift/iOS tasks.

**When to activate:**
- Writing Swift code
- Xcode tooling
- iOS development
- macOS development

### Document Processing
**STRONG NUDGE:** Use specialized document skills:
- `pdf` for PDF operations
- `docx` for Word documents
- `pptx` for PowerPoint
- `xlsx` for spreadsheets

## Skill Combination

**Strong nudge:** Some tasks benefit from multiple skills.

**Example combinations:**

**Full-stack TypeScript app with security:**
```
1. moai-lang-typescript (primary)
2. moai-domain-security (for auth)
3. moai-domain-frontend (for complex UI)
```

**Python API with database optimization:**
```
1. moai-lang-python (primary)
2. sql-optimization-patterns (for queries)
3. moai-domain-security (for auth/validation)
```

**Load skills sequentially as needed:**
- Start with primary language skill
- Add domain skills when entering that domain
- Add specialized skills for specific subtasks

## Skill Activation Patterns

### Pattern 1: Language-First
For development tasks, always start with the language skill.

```
Task: "Create a FastAPI endpoint with JWT auth"
1. Activate: moai-lang-python
2. Activate: moai-domain-security (when implementing auth)
3. Implement with both skills' guidance
```

### Pattern 2: Domain-First
For analysis or architecture tasks, start with domain skill.

```
Task: "Design a secure user authentication system"
1. Activate: moai-domain-security
2. Activate: moai-lang-python or moai-lang-typescript (for implementation)
3. Design with security patterns, implement with language patterns
```

### Pattern 3: Tool-First
For specialized tasks, start with the tool skill.

```
Task: "Extract tables from PDF and analyze"
1. Activate: pdf (for extraction)
2. Activate: moai-lang-python (for analysis)
3. Extract with PDF skill, analyze with Python patterns
```

## Decision Tree

```
Is this a Python task?
├─ Yes → MUST activate moai-lang-python
└─ No → Is this a TypeScript task?
    ├─ Yes → MUST activate moai-lang-typescript
    └─ No → Continue checking...

Is this a security-related task?
├─ Yes → MUST activate moai-domain-security
└─ No → Continue checking...

Is this a frontend architecture task?
├─ Yes → SHOULD activate moai-domain-frontend
└─ No → Continue checking...

Is this a database task?
├─ Yes → SHOULD activate moai-domain-database
└─ No → Continue checking...

Is this SQL optimization?
├─ Yes → SHOULD activate sql-optimization-patterns
└─ No → Continue checking...

Is this Python performance tuning?
├─ Yes → SHOULD activate python-performance-optimization
└─ No → Continue checking...

Is this browser automation/testing?
├─ Yes → SHOULD activate playwright-skill or webapp-testing
└─ No → Continue checking...

Is this document processing?
├─ Yes → SHOULD activate pdf/docx/pptx/xlsx
└─ No → Proceed without specialized skill
```

## Common Mistakes to Avoid

### Mistake 1: Implementing First, Skill Later
```
❌ Write code → Realize skill exists → Try to retrofit

✓ Identify task → Check skills → Activate skill → Implement
```

### Mistake 2: Skipping Language Skills
```
❌ "I know Python, I'll just write this quickly"

✓ Even for small tasks, activate moai-lang-python for consistency
```

### Mistake 3: Forgetting Security
```
❌ Implement auth without moai-domain-security

✓ Always activate security skill for auth/encryption/validation
```

### Mistake 4: Not Combining Skills
```
❌ Use only moai-lang-python for a FastAPI app with complex security

✓ Combine moai-lang-python + moai-domain-security + sql-optimization-patterns
```

## Skill Activation Checklist

Before starting any implementation:

- [ ] Have I identified the task domain and language?
- [ ] Have I checked for applicable skills?
- [ ] For Python tasks: Have I activated moai-lang-python?
- [ ] For TypeScript tasks: Have I activated moai-lang-typescript?
- [ ] For security tasks: Have I activated moai-domain-security?
- [ ] For database tasks: Have I considered moai-domain-database?
- [ ] For performance issues: Have I considered optimization skills?
- [ ] Should I combine multiple skills for this task?

## Examples of Proper Skill Activation

### Example 1: FastAPI Endpoint with Auth

```
Task: "Create a FastAPI endpoint to update user profiles with JWT authentication"

Analysis:
- Language: Python → moai-lang-python
- Framework: FastAPI → moai-lang-python (includes FastAPI patterns)
- Security: JWT auth → moai-domain-security

Activation sequence:
1. Activate moai-lang-python
2. Activate moai-domain-security
3. Implement endpoint following both skills' patterns
```

### Example 2: Next.js Dashboard with Real-time Data

```
Task: "Build a Next.js dashboard with real-time data updates and responsive design"

Analysis:
- Language: TypeScript → moai-lang-typescript
- Framework: Next.js → moai-lang-typescript (includes Next.js patterns)
- Complex UI: Frontend architecture → moai-domain-frontend

Activation sequence:
1. Activate moai-lang-typescript
2. Activate moai-domain-frontend
3. Implement following modern frontend patterns
```

### Example 3: Slow Database Query

```
Task: "This query takes 30 seconds to run, optimize it"

Analysis:
- Domain: SQL optimization → sql-optimization-patterns
- Language: Likely Python/TypeScript ORM → Activate after analysis

Activation sequence:
1. Activate sql-optimization-patterns
2. Analyze query with EXPLAIN
3. Activate moai-lang-python if modifying Python ORM code
4. Apply optimizations following skill patterns
```

### Example 4: Security Audit

```
Task: "Review this authentication system for security vulnerabilities"

Analysis:
- Primary: Security review → moai-domain-security
- Language: Python/TypeScript → Activate as needed

Activation sequence:
1. Activate moai-domain-security
2. Review against OWASP Top 10 and security patterns
3. Activate moai-lang-python or moai-lang-typescript for fixes
4. Implement security improvements
```

## When Not to Use Skills

**Acceptable to skip skills:**
- Trivial tasks (fix typo, adjust spacing)
- Pure configuration changes
- Simple file operations
- Non-code tasks

**But when in doubt, use the skill.** The cost of activation is low, the benefit is consistency.

## Reminder System

**Before each implementation, mentally check:**

> "Is this Python?" → moai-lang-python
>
> "Is this TypeScript?" → moai-lang-typescript
>
> "Does this involve security?" → moai-domain-security
>
> "Is there a specialized skill for this?" → Check list

**Make skill activation a habit, not an afterthought.**
