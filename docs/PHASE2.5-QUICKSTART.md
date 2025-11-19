# Phase 2.5 Domain Coordinators - Quick Start Guide

**Get started with domain coordinators in 5 minutes**

---

## What Are Domain Coordinators?

Domain coordinators intelligently route your tasks to the right skills and enforce best practices. They enhance your trabajo while staying true to obra principles.

**Example:**
```
You: "Create a FastAPI endpoint"
Language Coordinator:
  ✓ Detects FastAPI keyword
  ✓ Routes to Python skill
  ✓ Enforces test-driven-development
  ✓ Suggests API pattern skill
```

---

## Installation: 30 Seconds

### Step 1: Files Already Installed ✅
Coordinators are already deployed to your repository:
```
.claude/coordinators/
├── language/
├── architecture/
├── document/
├── quality/
├── data-analysis/
├── planning/
└── git-workflow/
```

### Step 2: Verify Installation
Check that files exist:
```bash
ls -la .claude/coordinators/
```

Should show 7 directories with .yml configuration files.

### Step 3: Ready to Use!
No additional setup needed. Coordinators are active immediately.

---

## 5-Minute Tutorial

### Scenario 1: Write Python Code

**You say:**
```
"Create a FastAPI endpoint for user authentication"
```

**Coordinator handles:**
1. Detects "FastAPI" keyword
2. Routes to moai-lang-python skill
3. Activates test-driven-development pattern
4. Suggests security domain patterns
5. Enforces verification before completion

**You get:**
- Properly tested Python code
- Following best practices
- With documentation

---

### Scenario 2: Build Full-Stack Feature

**You say:**
```
"Implement user registration from database to React UI"
```

**Coordinator handles:**
1. Planning Coordinator orchestrates
2. Language Coordinator routes code (Python + TypeScript)
3. Architecture Coordinator validates:
   - Database schema
   - API contract
   - Frontend integration
   - Security everywhere
4. Quality Coordinator validates before merge

**You get:**
- Coordinated full-stack feature
- Consistency across layers
- Security verified

---

### Scenario 3: Generate Report

**You say:**
```
"Create a quarterly summary report"
```

**Coordinator handles:**
1. Detects task type
2. Routes to Document Coordinator
3. Auto-detects format (Word/PDF/Excel)
4. Applies templates
5. Verifies completeness

**You get:**
- Formatted report
- Ready to share

---

## Common Tasks

### Write Code
```
"Create a [Language] [thing]"
Examples:
- "Create a FastAPI endpoint"
- "Build a React component"
- "Write a Swift view"

→ Language Coordinator activates
```

### Full-Stack Work
```
"Build [feature] with database and UI"
Examples:
- "Build user auth with API and React"
- "Create shopping cart with backend and UI"

→ Architecture Coordinator orchestrates all layers
```

### Plan Work
```
"Plan [scope of work]"
Examples:
- "Plan this 2-week sprint"
- "Plan a major refactoring"
- "Orchestrate user auth system"

→ Planning Coordinator structures everything
```

### Ensure Quality
```
"Review this code for quality"
"Validate before release"

→ Quality Coordinator runs comprehensive checks
```

### Process Documents
```
"Create/analyze [document type]"
Examples:
- "Generate quarterly report"
- "Export data to Excel"
- "Extract from PDF"

→ Document Coordinator handles format automatically
```

---

## Coordinator Quick Reference

| When... | Use This | Example |
|---------|----------|---------|
| Writing code | Language | "Create a FastAPI endpoint" |
| Building features across layers | Architecture | "Build user auth (DB→API→UI)" |
| Processing documents | Document | "Generate report" |
| Checking quality | Quality | "Validate before release" |
| Analyzing data | Data Analysis | "Analyze this CSV" |
| Planning projects | Planning | "Plan this sprint" |
| Managing git | Git Workflow | "Prepare for merge" |

---

## Decision Tree

**Quick question to choose coordinator:**

```
What are you doing?
├─ Writing code?
│  ├─ Single language (Python/TS/Swift)?
│  │  → Language Coordinator
│  └─ Multiple layers (DB + API + UI)?
│     → Architecture Coordinator
│
├─ Processing documents (Word/Excel/PDF)?
│  → Document Coordinator
│
├─ Analyzing data (CSV/corpus)?
│  → Data Analysis Coordinator
│
├─ Checking quality?
│  → Quality Coordinator
│
├─ Planning/organizing work?
│  → Planning Coordinator
│
└─ Managing git/branches?
   → Git Workflow Coordinator
```

---

## How It Works Behind the Scenes

### 1. Detection
Coordinator detects what you're doing:
- File extensions (.py, .tsx, .swift, .docx, .xlsx)
- Keywords (FastAPI, React, SwiftUI, etc.)
- Context (current files, project structure)

### 2. Routing
Routes to the right skills:
- Python → moai-lang-python
- TypeScript → moai-lang-typescript
- Swift → developing-with-swift
- etc.

### 3. Enforcement
Ensures obra patterns are used:
- ✅ Brainstorming for design
- ✅ Test-driven-development for code
- ✅ Verification before completion
- ✅ Code review for quality

### 4. Coordination
Manages complex workflows:
- Parallel work streams (multiple languages)
- Sequential handoffs (database → API → frontend)
- Cross-layer validation (contracts align)
- Integration checks (security applies everywhere)

---

## Configuration Files

Coordinators are configured in `.yml` files. You don't need to edit them to use them, but you can:

### Language Coordinator
- **File:** `.claude/coordinators/language/coordinator.yml`
- **Contains:** Python, TypeScript, Swift routing rules
- **Edit if:** You want to add new language triggers

### Other Coordinators
- **Files:** `.claude/coordinators/[name]/coordinator.yml`
- **Edit if:** You want to customize routing or add patterns

---

## Examples You Can Try Right Now

### Example 1: Python Code
```
"Create a Python function to validate email addresses using regex"
```
→ Language Coordinator routes to Python + enforces TDD

### Example 2: React Component
```
"Build a TypeScript React component for a data table with sorting"
```
→ Language Coordinator routes to TypeScript + Frontend domain

### Example 3: Full-Stack
```
"Build a feature: FastAPI endpoint + React UI for user preferences"
```
→ Architecture Coordinator orchestrates both layers

### Example 4: Quality Check
```
"Ensure this code meets production quality standards"
```
→ Quality Coordinator runs testing, performance, security checks

### Example 5: Report
```
"Generate a quarterly revenue report in Word format"
```
→ Document Coordinator creates formatted Word document

---

## Bypass & Troubleshooting

### Skip Coordinator (Use obra patterns directly)
```
"[Task] (without coordinators)"
or
"--no-coordinator-name [task]"
```

### If Something Goes Wrong
1. Check the coordinator README: `.claude/coordinators/README.md`
2. Check decision tree above
3. Try explicit activation: "Use [coordinator] to..."
4. Read specific coordinator guide in `.claude/coordinators/[name]/`

---

## Next Steps

### 1. Try it Out
Pick a task and see how coordinators help:
- Write some code
- Create a document
- Plan a feature

### 2. Read Full Guides
For detailed documentation:
- `.claude/coordinators/README.md` - Complete system guide
- `.claude/coordinators/language/activate.md` - Language coordinator details
- `docs/phase2.5-full-stack-complete.md` - Full architecture

### 3. Customize (Optional)
Edit coordinator configurations in `.claude/coordinators/[name]/coordinator.yml` to add:
- New trigger keywords
- Additional routing rules
- Custom patterns

---

## Key Points to Remember

✅ **Coordinators enhance obra, never replace it**
- All obra patterns still active
- All safety gates still enforced

✅ **They're automatic**
- No special syntax needed
- Just use them naturally

✅ **They're optional**
- You can bypass if needed
- Obra patterns still available

✅ **They save time**
- Smart routing
- Parallel coordination
- Built-in quality checks

---

## Quick Reference Card

```
LANGUAGE WORK
"Create a FastAPI endpoint"
→ Python skill + TDD

FULL-STACK WORK
"Build auth system (DB→API→UI)"
→ All coordinators orchestrate

DOCUMENT WORK
"Generate report"
→ Auto-format selection

PLANNING
"Plan sprint"
→ Structured breakdown

GIT
"Prepare for merge"
→ Safety checks + workflow

QUALITY
"Final check"
→ All quality gates
```

---

## Support

**Need help?**
1. Check `.claude/coordinators/README.md` for comprehensive guide
2. Check specific coordinator in `.claude/coordinators/[name]/`
3. See examples in `.claude/coordinators/language/examples/`
4. Read `docs/phase2.5-full-stack-complete.md` for architecture

**Have feedback?**
Configurations are easy to modify in `.claude/coordinators/[name]/coordinator.yml`

---

**Status:** Ready to use immediately
**Setup time:** None - already installed
**Learning curve:** 5 minutes
**Value:** Immediate with coordinators routing all your tasks