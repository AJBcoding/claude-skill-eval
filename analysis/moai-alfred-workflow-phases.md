# MoAI Alfred Workflow Phases and Orchestration Analysis

**Analysis Date:** 2025-11-19  
**System Version:** MoAI-ADK 0.25.8  
**Analyzed Repository:** `/home/user/claude-skill-eval/moai-adk-main/`

---

## Executive Summary

MoAI-ADK implements a **4-phase workflow** orchestrated by Alfred, a superintelligent agent system. The workflow follows SPEC-First TDD methodology with complete agent delegation, coordinating 31+ specialized agents through a hierarchical command-agent-skill architecture.

**Key Findings:**
- **4 Major Phases** with 11 sub-phases total
- **31+ Specialized Agents** across 7 domain categories
- **100+ Skills** providing domain knowledge
- **Sequential workflow** with explicit user approval gates
- **Complete delegation model** (commands only orchestrate, agents execute)

---

## 1. Workflow Phase Structure

### 1.1 Overview: The 4-Phase Workflow

MoAI Alfred implements a structured **4-phase development workflow**:

```
┌────────────────────────────────────────────────────────────────┐
│                    ALFRED WORKFLOW PHASES                      │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  Phase 0: Project Setup (/alfred:0-project)                   │
│  ├─ Initialize project metadata                               │
│  ├─ Configure language and settings                           │
│  ├─ Set up Git strategy (Personal/Team)                       │
│  └─ Establish project conventions                             │
│                    ↓                                           │
│  Phase 1: Planning (/alfred:1-plan)                           │
│  ├─ PHASE 1A: Project Exploration (optional)                  │
│  ├─ PHASE 1B: SPEC Planning (required)                        │
│  ├─ PHASE 2: SPEC Document Creation                           │
│  └─ PHASE 3: Git Branch & PR Setup                            │
│                    ↓                                           │
│  Phase 2: Implementation (/alfred:2-run)                      │
│  ├─ PHASE 1: Analysis & Planning                              │
│  ├─ PHASE 2: TDD Implementation                               │
│  ├─ PHASE 3: Git Operations                                   │
│  └─ PHASE 4: Completion                                       │
│                    ↓                                           │
│  Phase 3: Sync & Documentation (/alfred:3-sync)               │
│  ├─ PHASE 1: Analysis & Planning                              │
│  ├─ PHASE 2: Execute Document Synchronization                 │
│  ├─ PHASE 3: Git Operations & PR                              │
│  └─ PHASE 4: Completion & Next Steps                          │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

### 1.2 Phase 0: Project Setup

**Command:** `/alfred:0-project`  
**Purpose:** Initialize project metadata and documentation  
**Duration:** 2-5 minutes (interactive)

#### Execution Modes

| Mode | Trigger | Purpose |
|------|---------|---------|
| **INITIALIZATION** | No config exists | First-time project setup |
| **AUTO-DETECT** | Config exists | Modify settings or review |
| **SETTINGS** | `setting [tab_ID]` | Tab-based configuration |
| **UPDATE** | `update` | Template optimization |

#### Sub-Phases

```
Phase 0 Structure:
├─ PHASE 1: Command Routing & Analysis
│  ├─ Step 1: Route based on subcommand
│  └─ Step 2: Delegate to project-manager agent
├─ PHASE 2: Execute Mode
│  ├─ INITIALIZATION: Language-first interview
│  ├─ AUTO-DETECT: Display current config
│  ├─ SETTINGS: Tab-based batch questions (5 tabs, 41 settings)
│  └─ UPDATE: Template merge and optimization
├─ PHASE 2.5: Save Phase Context
│  ├─ Step 1: Extract context from agent response
│  └─ Step 2: Delegate context saving
└─ PHASE 3: Completion & Next Steps
   ├─ Step 1: Display completion status
   └─ Step 2: Offer next steps
```

#### Key Features

1. **Language-First Architecture**: Language selection always happens BEFORE other configuration
2. **Tab-Based Settings** (5 tabs):
   - Tab 1: User & Language (3 settings)
   - Tab 2: Project Basic Information (4 settings + 3 auto-processed)
   - Tab 3: Git Strategy & Workflow (16 settings)
   - Tab 4: Quality Principles & Reports (9 settings)
   - Tab 5: System & GitHub Integration (8 settings)
3. **Atomic Configuration Updates**: Backup/rollback support for safe updates
4. **Multi-Language Support**: 50+ languages supported

#### Agent Delegation

- **Primary Agent:** `project-manager`
- **Skills Used:**
  - `moai-project-language-initializer` - Language selection
  - `moai-project-config-manager` - Config operations
  - `moai-project-template-optimizer` - Template merging
  - `moai-project-batch-questions` - Tab-based questions

---

### 1.3 Phase 1: Planning

**Command:** `/alfred:1-plan "feature description"`  
**Purpose:** Define specifications and create development branch  
**Duration:** 5-15 minutes (depends on complexity)

#### Workflow Steps

```
Phase 1 Structure:
├─ PHASE 1: Project Analysis & SPEC Planning
│  ├─ PHASE 1A: Project Exploration (optional)
│  │  └─ Step 1A.1: Invoke Explore agent (if needed)
│  ├─ PHASE 1B: SPEC Planning (required)
│  │  ├─ Step 1B.1: Invoke spec-builder for analysis
│  │  └─ Step 1B.2: Request user approval
│  └─ Step 3.5: Progress report & user confirmation
├─ PHASE 2: SPEC Document Creation
│  ├─ Directory naming: `.moai/specs/SPEC-{ID}/`
│  ├─ Generate spec.md (EARS structure)
│  ├─ Generate plan.md (implementation strategy)
│  └─ Generate acceptance.md (test scenarios)
└─ PHASE 3: Git Branch & PR Setup
   ├─ Step 1: Check Git configuration
   ├─ Step 2: Create branch (Personal mode)
   ├─ Step 3: Create draft PR (Team mode)
   └─ Step 4: Final status report
```

#### SPEC Document Structure

All SPEC documents follow the **EARS format** (Easy Approach to Requirements Syntax):

| Pattern | Usage | Example |
|---------|-------|---------|
| **Ubiquitous** | Always true | The system SHALL hash passwords with bcrypt |
| **Event-Driven** | WHEN trigger | WHEN user submits credentials → Authenticate |
| **Unwanted** | IF bad condition | IF invalid → reject + log attempt |
| **State-Driven** | WHILE state | WHILE session active → validate token |
| **Optional** | WHERE user choice | WHERE 2FA enabled → send SMS code |

#### Directory Naming Convention

**Critical Format:** `.moai/specs/SPEC-{ID}/`

**Correct Examples:**
- ✅ `SPEC-AUTH-001/`
- ✅ `SPEC-REFACTOR-001/`
- ✅ `SPEC-UPDATE-REFACTOR-001/` (composite domain)

**Incorrect Examples:**
- ❌ `AUTH-001/` (missing SPEC- prefix)
- ❌ `SPEC-001-auth/` (text after ID)
- ❌ `SPEC-AUTH-001-jwt/` (text after ID)

#### Agent Delegation

- **Phase 1A:** `Explore` agent (optional, for codebase exploration)
- **Phase 1B:** `spec-builder` agent (required, for SPEC creation)
- **Phase 3:** `git-manager` agent (Git operations)

#### Skills Used

- `moai-alfred-issue-labels` - GitHub issue integration
- `moai-foundation-ears` - EARS requirement format
- `moai-alfred-git-workflow` - Git strategy
- Domain-specific skills (as needed)

---

### 1.4 Phase 2: Implementation

**Command:** `/alfred:2-run SPEC-{ID}`  
**Purpose:** Execute TDD implementation cycle  
**Duration:** Varies (30 minutes to several days)

#### Workflow Steps

```
Phase 2 Structure:
├─ PHASE 1: Analysis & Planning
│  ├─ Read SPEC document
│  ├─ Invoke implementation-planner to analyze
│  ├─ Present execution plan to user
│  ├─ Handle user approval (proceed/modify/postpone)
│  └─ Update SPEC status if approved
├─ PHASE 2: TDD Implementation
│  ├─ Initialize TodoWrite for task tracking
│  ├─ Check domain readiness (multi-domain SPECs)
│  ├─ Invoke tdd-implementer (RED → GREEN → REFACTOR)
│  ├─ Invoke quality-gate for TRUST 5 validation
│  └─ Handle quality gate results (PASS/WARNING/CRITICAL)
├─ PHASE 3: Git Operations
│  ├─ Invoke git-manager to create commits
│  ├─ Verify commits were created
│  └─ Display commit summary
└─ PHASE 4: Completion
   ├─ Display implementation summary
   ├─ Ask user for next steps
   └─ Guide to /alfred:3-sync or new feature
```

#### TDD Cycle

The implementation follows strict **Test-Driven Development** (TDD):

```
RED Phase:
├─ Write failing test first
├─ Verify test fails as expected
└─ Ensure test is meaningful

GREEN Phase:
├─ Write minimal code to pass test
├─ Run test suite
└─ Verify all tests pass

REFACTOR Phase:
├─ Improve code quality
├─ Maintain test coverage
├─ Run tests again to ensure nothing broke
└─ TRUST 5 validation
```

#### TRUST 5 Quality Principles

| Principle | What | How |
|-----------|------|-----|
| **T**est-first | No code without tests | TDD mandatory (85%+ coverage) |
| **R**eadable | Clear, maintainable code | Mypy, ruff, pylint auto-run |
| **U**nified | Consistent patterns | Style guides enforced |
| **S**ecured | Security-first | OWASP + dependency audit |
| **T**rackable | Requirements linked | SPEC → Code → Tests → Docs |

#### Agent Delegation

- **Primary Orchestrator:** `run-orchestrator` agent
- **Supporting Agents:**
  - `implementation-planner` - SPEC analysis (Phase 1)
  - `tdd-implementer` - TDD cycle (Phase 2)
  - `quality-gate` - TRUST 5 validation (Phase 2)
  - `git-manager` - Git commits (Phase 3)

#### Expert Agent Auto-Delegation

The `implementation-planner` automatically detects domain keywords and delegates to specialists:

| Expert Agent | Trigger Keywords | Purpose |
|--------------|------------------|---------|
| **backend-expert** | api, server, database, auth | Server architecture, API design |
| **frontend-expert** | ui, component, client-side | UI components, state management |
| **devops-expert** | deployment, docker, ci/cd | Infrastructure, automation |
| **ui-ux-expert** | design, accessibility, a11y | Design systems, UX patterns |

---

### 1.5 Phase 3: Sync & Documentation

**Command:** `/alfred:3-sync [mode] [path]`  
**Purpose:** Synchronize documentation and finalize PR  
**Duration:** 2-10 minutes

#### Execution Modes

| Mode | Scope | PR Processing | Use Case |
|------|-------|---------------|----------|
| **auto** (default) | Smart selective sync | PR Ready conversion | Daily development |
| **force** | Full project re-sync | Full regeneration | Error recovery |
| **status** | Status check only | Report only | Quick health check |
| **project** | Project-wide sync | Project-level updates | Milestone completion |

#### Workflow Steps

```
Phase 3 Structure:
├─ PHASE 1: Analysis & Planning
│  ├─ Step 1.1: Verify prerequisites & load skills
│  ├─ Step 1.2: Analyze project status
│  ├─ Step 1.3: Project status verification
│  ├─ Step 1.4: Invoke doc-syncer for sync plan
│  └─ Step 1.5: Request user approval
├─ PHASE 2: Execute Document Synchronization
│  ├─ Step 2.1: Create safety backup
│  ├─ Step 2.2: Invoke doc-syncer for execution
│  ├─ Step 2.3: Invoke quality-gate for verification
│  └─ Step 2.4: Update SPEC status to completed
├─ PHASE 3: Git Operations & PR
│  ├─ Step 3.1: Invoke git-manager for commit
│  ├─ Step 3.2: PR Ready transition (Team mode)
│  └─ Step 3.3: PR auto-merge (if --auto-merge flag)
└─ PHASE 4: Completion & Next Steps
   ├─ Step 4.1: Display completion report
   └─ Step 4.2: Ask for next action
```

#### Living Documents Synchronized

1. **README.md** - Project overview and quickstart
2. **API Documentation** - Auto-generated from code
3. **Architecture Docs** - System design documents
4. **SPEC Index** - `.moai/indexes/tags.db`
5. **Domain-Specific Docs** - Per-domain reports

#### Agent Delegation

- **Primary Agents:**
  - `doc-syncer` - Document synchronization
  - `quality-gate` - Verification
  - `git-manager` - Git operations
- **Skills Used:**
  - `moai-docs-sync` - Living document sync
  - `moai-alfred-trust-validation` - Quality validation
  - `moai-alfred-git-workflow` - Git operations

---

## 2. Phase Transitions

### 2.1 Transition Mechanisms

Phase transitions in MoAI are **sequential and explicit** with user approval gates:

```
┌────────────────────────────────────────────────────────────┐
│                  Phase Transition Flow                     │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Phase N Completion                                        │
│         ↓                                                  │
│  AskUserQuestion (Next Steps)                             │
│         ↓                                                  │
│  ┌──────────────────────────────────────┐                │
│  │  User Decision                        │                │
│  │  ├─ Proceed to next phase            │                │
│  │  ├─ Modify current phase             │                │
│  │  ├─ Save as draft                    │                │
│  │  └─ Cancel operation                 │                │
│  └──────────────────────────────────────┘                │
│         ↓                                                  │
│  Phase N+1 Initiation                                     │
│         ↓                                                  │
│  Context Transfer (via .moai/memory/)                     │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

### 2.2 Approval Gates

**User approval is required at:**

1. **Phase 0 → 1:** After project initialization
2. **Phase 1 PHASE 1B → PHASE 2:** After SPEC planning approval
3. **Phase 1 PHASE 2 → PHASE 3:** After SPEC document creation
4. **Phase 2 PHASE 1 → PHASE 2:** After implementation plan approval
5. **Phase 3 PHASE 1 → PHASE 2:** After sync plan approval

### 2.3 Can You Skip Phases?

**No, phases cannot be skipped**, but:

- **Phase 0** can be run once and reused (settings persist)
- **Phase 1A** (Exploration) is optional if SPEC is clear
- **Phase 3 PHASE 3** (Git operations) respects mode (Personal vs Team)

### 2.4 Can You Go Backward?

**Yes, with limitations:**

1. **Within a phase:** User can request modifications before proceeding
2. **Across phases:** Can return to Phase 1 to modify SPEC, but changes require re-running Phase 2
3. **Draft system:** Can save work as draft and resume later

**Example backward flow:**
```
Phase 2 (Implementation) → User discovers SPEC issue
  ↓
User runs /alfred:1-plan SPEC-{ID} modifications
  ↓
SPEC updated with new version
  ↓
Re-run /alfred:2-run SPEC-{ID} with updated requirements
```

---

## 3. Agent Orchestration

### 3.1 Orchestration Architecture

MoAI uses a **4-layer hierarchical architecture**:

```
┌────────────────────────────────────────────────────────────┐
│              MoAI 4-Layer Architecture                     │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Layer 1: Commands (Orchestration)                        │
│  ├─ /alfred:0-project                                     │
│  ├─ /alfred:1-plan                                        │
│  ├─ /alfred:2-run                                         │
│  └─ /alfred:3-sync                                        │
│         ↓ Task() delegation                               │
│                                                            │
│  Layer 2: Agents (Domain Expertise)                       │
│  ├─ Orchestrator Agents (project-manager, run-orchestrator) │
│  ├─ Specialist Agents (spec-builder, tdd-implementer)    │
│  ├─ Expert Agents (backend-expert, frontend-expert)      │
│  └─ Utility Agents (git-manager, quality-gate)           │
│         ↓ Skill() invocation                              │
│                                                            │
│  Layer 3: Skills (Knowledge Capsules)                     │
│  ├─ Foundation Skills (moai-foundation-*)                │
│  ├─ Language Skills (moai-lang-*)                        │
│  ├─ Domain Skills (moai-domain-*)                        │
│  └─ Essential Skills (moai-essentials-*)                 │
│         ↓ Progressive disclosure                          │
│                                                            │
│  Layer 4: Hooks (Guardrails & Context)                   │
│  ├─ SessionStart hooks                                    │
│  ├─ SessionEnd hooks                                      │
│  ├─ PreToolUse hooks                                      │
│  └─ PostToolUse hooks                                     │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

### 3.2 Agent Categories (31+ Agents)

#### Orchestrator Agents (2)
- `project-manager` - Phase 0 orchestration
- `run-orchestrator` - Phase 2 orchestration

#### Specialist Agents (6)
- `spec-builder` - SPEC creation and planning
- `implementation-planner` - Implementation strategy
- `tdd-implementer` - TDD cycle execution
- `doc-syncer` - Documentation synchronization
- `quality-gate` - TRUST 5 validation
- `git-manager` - Git operations

#### Domain Expert Agents (8)
- `backend-expert` - Server-side architecture
- `frontend-expert` - Client-side UI/UX
- `database-expert` - Schema design and optimization
- `devops-expert` - Infrastructure and deployment
- `security-expert` - OWASP and compliance
- `api-designer` - REST/GraphQL APIs
- `ui-ux-expert` - Design systems and accessibility
- `performance-engineer` - Performance optimization

#### MCP Integration Agents (4)
- `mcp-context7-integrator` - Context7 MCP server
- `mcp-notion-integrator` - Notion integration
- `mcp-playwright-integrator` - Browser automation
- `mcp-sequential-thinking-integrator` - Enhanced reasoning

#### Factory Agents (2)
- `agent-factory` - Create new agents
- `skill-factory` - Create new skills

#### Utility Agents (9+)
- `cc-manager` - Claude Code configuration
- `docs-manager` - Documentation management
- `sync-manager` - Multi-SPEC synchronization
- `trust-checker` - TRUST 5 compliance
- `debug-helper` - Error analysis
- `format-expert` - Code formatting
- `component-designer` - Component architecture
- `migration-expert` - Migration planning
- `monitoring-expert` - Observability setup
- And more...

### 3.3 Parallel vs Sequential Execution

#### Sequential Execution (Default)

Most workflows are **sequential** with clear dependencies:

```
SPEC Planning → User Approval → SPEC Creation → Git Branch
     ↓              ↓                ↓              ↓
spec-builder → AskUserQuestion → spec-builder → git-manager
(sequential, blocking on user input)
```

#### Parallel Execution (Within Agents)

Agents can execute **parallel tasks** internally:

```python
# Example: implementation-planner can delegate to multiple experts in parallel
await asyncio.gather(
    Task(subagent_type="backend-expert", prompt="Design API"),
    Task(subagent_type="frontend-expert", prompt="Design UI"),
    Task(subagent_type="database-expert", prompt="Design schema")
)
# All three experts work in parallel
```

**When parallel execution occurs:**
- Multiple independent domain experts needed (backend + frontend + database)
- Research tasks (multiple Context7 lookups)
- Validation tasks (linting + security scan + test coverage)

**When sequential execution required:**
- User approval needed (blocking)
- Dependencies between steps (SPEC → Implementation → Docs)
- Git operations (branch → commit → PR)

### 3.4 Central Orchestrator vs Distributed Control

**MoAI uses HYBRID orchestration:**

#### Central Orchestration (Command Level)

Commands act as **central orchestrators**:
- `/alfred:0-project` orchestrates via `project-manager`
- `/alfred:1-plan` orchestrates via `spec-builder`
- `/alfred:2-run` orchestrates via `run-orchestrator`
- `/alfred:3-sync` orchestrates via `doc-syncer`

#### Distributed Control (Agent Level)

Agents have **autonomous decision-making**:
- `implementation-planner` auto-detects domain keywords and delegates
- `tdd-implementer` manages its own TDD cycle
- `doc-syncer` determines which documents need updating
- `quality-gate` runs independent validation checks

**Example of distributed control:**
```
implementation-planner agent:
├─ Scans SPEC for keywords
├─ Detects: ['api', 'database', 'authentication']
├─ Auto-delegates to backend-expert (no command intervention)
├─ Auto-delegates to database-expert (autonomous decision)
└─ Auto-delegates to security-expert (proactive)
```

### 3.5 Agent Handoff Mechanisms

#### Task() Function

**Primary delegation mechanism:**

```python
# Command delegates to agent
Task(
    subagent_type="spec-builder",
    description="Create SPEC document",
    prompt="Analyze requirements and create SPEC-AUTH-001",
    model="sonnet"  # Optional: specify model
)
```

#### Context Passing

Agents pass context through:

1. **Explicit parameters** in Task() prompt
2. **File system** (`.moai/memory/`, `.moai/specs/`)
3. **Configuration** (`.moai/config/config.json`)
4. **Session state** (managed by hooks)

**Example context flow:**
```
spec-builder creates SPEC → saves to .moai/specs/SPEC-001/
    ↓
implementation-planner reads SPEC → creates execution plan
    ↓
tdd-implementer reads plan → implements code
    ↓
doc-syncer reads code + SPEC → synchronizes docs
```

#### AskUserQuestion for Handoff

User input acts as **explicit handoff point**:

```python
# Agent completes work, asks for next action
AskUserQuestion({
    "questions": [{
        "question": "SPEC creation complete. Next steps?",
        "options": [
            {"label": "Start Implementation", "description": "Run /alfred:2-run"},
            {"label": "Modify SPEC", "description": "Edit specification"},
            {"label": "Cancel", "description": "Exit workflow"}
        ]
    }]
})

# User selection triggers next agent handoff
```

---

## 4. Workflow Examples

### 4.1 Example 1: Simple Feature Implementation

**Scenario:** Implement user authentication with email and password

```
┌────────────────────────────────────────────────────────────┐
│  Example: User Authentication Feature                     │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Day 1: Planning (30 minutes)                             │
│  ────────────────────────────────                         │
│  User: /alfred:1-plan "user login with email/password"   │
│         ↓                                                  │
│  PHASE 1A: Exploration (5 min)                            │
│  ├─ Explore agent: Scan existing auth patterns           │
│  └─ Result: No existing auth, suggest new implementation │
│         ↓                                                  │
│  PHASE 1B: SPEC Planning (10 min)                        │
│  ├─ spec-builder: Analyze requirements                   │
│  ├─ Propose SPEC-AUTH-001                                │
│  ├─ EARS format: Ubiquitous, Event-Driven, Unwanted     │
│  └─ User approval: ✅ Proceed                            │
│         ↓                                                  │
│  PHASE 2: SPEC Creation (10 min)                         │
│  ├─ spec-builder creates:                                │
│  │  ├─ .moai/specs/SPEC-AUTH-001/spec.md               │
│  │  ├─ .moai/specs/SPEC-AUTH-001/plan.md               │
│  │  └─ .moai/specs/SPEC-AUTH-001/acceptance.md         │
│  └─ Content: EARS structure, acceptance criteria         │
│         ↓                                                  │
│  PHASE 3: Git Setup (5 min)                              │
│  ├─ git-manager: Create feature/SPEC-AUTH-001 branch    │
│  └─ Initial commit: "feat(spec): Add SPEC-AUTH-001"     │
│                                                            │
│  ────────────────────────────────────────────────────────│
│  Day 2-3: Implementation (4 hours)                        │
│  ────────────────────────────────                         │
│  User: /alfred:2-run SPEC-AUTH-001                       │
│         ↓                                                  │
│  PHASE 1: Planning (15 min)                              │
│  ├─ implementation-planner analyzes SPEC                 │
│  ├─ Detects keywords: ['authentication', 'api']         │
│  ├─ Auto-delegates to backend-expert                     │
│  │  └─ Recommends: FastAPI, bcrypt, JWT                 │
│  ├─ Auto-delegates to security-expert                    │
│  │  └─ Security checklist: password hashing, OWASP     │
│  └─ User approval: ✅ Proceed                            │
│         ↓                                                  │
│  PHASE 2: TDD Implementation (3 hours)                   │
│  ├─ run-orchestrator → tdd-implementer                   │
│  ├─ RED: Write test_user_login_success()                │
│  ├─ RED: Write test_user_login_invalid_credentials()    │
│  ├─ GREEN: Implement auth endpoints                      │
│  ├─ GREEN: Implement password hashing                    │
│  ├─ REFACTOR: Clean up code                             │
│  ├─ quality-gate: TRUST 5 validation                    │
│  │  ├─ Test coverage: 92% ✅                            │
│  │  ├─ Security scan: PASS ✅                           │
│  │  └─ Code quality: PASS ✅                            │
│  └─ TodoWrite tracking: 8/8 tasks complete              │
│         ↓                                                  │
│  PHASE 3: Git Commit (10 min)                            │
│  ├─ git-manager: Create commits                          │
│  └─ Commit: "feat(auth): Implement user login"          │
│         ↓                                                  │
│  PHASE 4: Completion                                      │
│  └─ Prompt: "Proceed to /alfred:3-sync"                 │
│                                                            │
│  ────────────────────────────────────────────────────────│
│  Day 3: Documentation (15 minutes)                        │
│  ────────────────────────────────                         │
│  User: /alfred:3-sync auto                               │
│         ↓                                                  │
│  PHASE 1: Analysis (5 min)                               │
│  ├─ doc-syncer analyzes Git changes                     │
│  ├─ Detects: auth.py, test_auth.py                      │
│  ├─ Plans: Update README, create API docs               │
│  └─ User approval: ✅ Proceed                            │
│         ↓                                                  │
│  PHASE 2: Sync (5 min)                                   │
│  ├─ doc-syncer updates:                                  │
│  │  ├─ README.md (add authentication section)          │
│  │  ├─ docs/api/auth.md (API endpoints)                │
│  │  └─ .moai/indexes/tags.db (SPEC index)              │
│  ├─ quality-gate verification                            │
│  └─ Update SPEC-AUTH-001 status: completed              │
│         ↓                                                  │
│  PHASE 3: Git & PR (5 min)                              │
│  ├─ git-manager: Commit documentation                    │
│  ├─ Commit: "docs: sync auth documentation"             │
│  └─ (Team mode) Create PR: "feat(auth): User login"    │
│         ↓                                                  │
│  PHASE 4: Complete                                        │
│  └─ Summary: Feature complete, PR ready for review      │
│                                                            │
└────────────────────────────────────────────────────────────┘

Total Time: 4.75 hours (Planning 0.5h + Implementation 4h + Docs 0.25h)
Agents Used: 7 (Explore, spec-builder, git-manager, implementation-planner,
             backend-expert, security-expert, tdd-implementer, quality-gate,
             doc-syncer)
```

### 4.2 Example 2: Full-Stack Application

**Scenario:** Build full-stack e-commerce product catalog

```
┌────────────────────────────────────────────────────────────┐
│  Example: E-Commerce Product Catalog                      │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Week 1: Multi-SPEC Planning                              │
│  ────────────────────────────────                         │
│  User: /alfred:1-plan "product catalog with search"      │
│         ↓                                                  │
│  PHASE 1B: SPEC Planning                                  │
│  ├─ spec-builder: Complex feature detection              │
│  ├─ Proposes 3 SPECs:                                    │
│  │  ├─ SPEC-BACKEND-001 (API + Database)                │
│  │  ├─ SPEC-FRONTEND-001 (UI Components)                │
│  │  └─ SPEC-SEARCH-001 (Search functionality)           │
│  └─ User selects: All 3 SPECs                            │
│         ↓                                                  │
│  Implementation sequence determined:                       │
│  1. SPEC-BACKEND-001 (foundation)                         │
│  2. SPEC-FRONTEND-001 (depends on API)                   │
│  3. SPEC-SEARCH-001 (depends on both)                    │
│                                                            │
│  ────────────────────────────────────────────────────────│
│  Week 1-2: Backend Implementation                         │
│  ────────────────────────────────                         │
│  User: /alfred:2-run SPEC-BACKEND-001                    │
│         ↓                                                  │
│  PHASE 1: Auto-Expert Delegation                         │
│  ├─ implementation-planner scans keywords:                │
│  │  ['api', 'database', 'rest', 'postgresql']           │
│  ├─ Parallel delegation:                                  │
│  │  ├─ backend-expert → API design                       │
│  │  ├─ database-expert → Schema design                   │
│  │  └─ api-designer → OpenAPI spec                       │
│  └─ Combined execution plan                               │
│         ↓                                                  │
│  PHASE 2: TDD Implementation                              │
│  ├─ tdd-implementer executes:                            │
│  │  ├─ Database models (Product, Category)              │
│  │  ├─ API endpoints (CRUD operations)                  │
│  │  ├─ Test coverage: 94%                                │
│  │  └─ Integration tests                                 │
│  └─ quality-gate: PASS ✅                                │
│                                                            │
│  ────────────────────────────────────────────────────────│
│  Week 2-3: Frontend Implementation                        │
│  ────────────────────────────────                         │
│  User: /alfred:2-run SPEC-FRONTEND-001                   │
│         ↓                                                  │
│  PHASE 1: Auto-Expert Delegation                         │
│  ├─ implementation-planner scans keywords:                │
│  │  ['react', 'component', 'ui', 'state']               │
│  ├─ Parallel delegation:                                  │
│  │  ├─ frontend-expert → Component architecture          │
│  │  ├─ ui-ux-expert → Design system                     │
│  │  └─ component-designer → Component specs             │
│  └─ Combined execution plan                               │
│         ↓                                                  │
│  PHASE 2: TDD Implementation                              │
│  ├─ Components: ProductList, ProductCard, SearchBar      │
│  ├─ State management: React Query                        │
│  └─ Tests: Component tests, integration tests            │
│                                                            │
│  ────────────────────────────────────────────────────────│
│  Week 3-4: Search Implementation                          │
│  ────────────────────────────────                         │
│  User: /alfred:2-run SPEC-SEARCH-001                     │
│         ↓                                                  │
│  Multi-domain coordination:                                │
│  ├─ backend-expert: Elasticsearch integration            │
│  ├─ frontend-expert: Search UI                           │
│  └─ performance-engineer: Optimization                    │
│                                                            │
│  ────────────────────────────────────────────────────────│
│  Week 4: Documentation & Deployment                       │
│  ────────────────────────────────                         │
│  User: /alfred:3-sync project                            │
│         ↓                                                  │
│  PHASE 2: Multi-SPEC Sync                                │
│  ├─ doc-syncer coordinates:                              │
│  │  ├─ API documentation (OpenAPI)                       │
│  │  ├─ Component documentation (Storybook)              │
│  │  ├─ Architecture diagrams                             │
│  │  └─ README with quickstart                            │
│  ├─ All 3 SPECs marked completed                        │
│  └─ Project-level sync report generated                  │
│         ↓                                                  │
│  PHASE 3: Deployment (optional)                           │
│  ├─ devops-expert: CI/CD pipeline                        │
│  ├─ Railway deployment                                    │
│  └─ Production monitoring setup                           │
│                                                            │
└────────────────────────────────────────────────────────────┘

Total Time: 4 weeks
SPECs: 3 (Backend, Frontend, Search)
Agents Used: 12+ (spec-builder, implementation-planner, backend-expert,
             database-expert, api-designer, frontend-expert, ui-ux-expert,
             component-designer, tdd-implementer, quality-gate, doc-syncer,
             devops-expert, performance-engineer)
```

---

## 5. Coordination Mechanisms

### 5.1 Agent Communication

Agents communicate through **multiple channels**:

```
┌────────────────────────────────────────────────────────────┐
│            Agent Communication Channels                    │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  1. Task() Function (Primary)                             │
│     ├─ Direct agent-to-agent delegation                   │
│     ├─ Explicit prompt with context                       │
│     └─ Return value capture                               │
│                                                            │
│  2. File System (Persistent)                              │
│     ├─ .moai/specs/ - SPEC documents                     │
│     ├─ .moai/memory/ - Session state                     │
│     ├─ .moai/config/ - Configuration                     │
│     └─ .moai/reports/ - Analysis reports                 │
│                                                            │
│  3. Configuration (Shared State)                          │
│     ├─ .moai/config/config.json - Global settings        │
│     ├─ Language preferences                               │
│     ├─ Git strategy                                        │
│     └─ TRUST 5 principles                                 │
│                                                            │
│  4. AskUserQuestion (Human-in-Loop)                       │
│     ├─ User approval gates                                │
│     ├─ Clarification requests                             │
│     └─ Decision points                                     │
│                                                            │
│  5. Hooks (Lifecycle Events)                              │
│     ├─ SessionStart - Initialize context                  │
│     ├─ PreToolUse - Validate operations                   │
│     ├─ PostToolUse - Log changes                          │
│     └─ SessionEnd - Cleanup and save                      │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

### 5.2 State and Context Sharing

#### Shared State Locations

| Location | Purpose | Scope | Persistence |
|----------|---------|-------|-------------|
| `.moai/config/config.json` | Global configuration | Project-wide | Permanent |
| `.moai/memory/last-session-state.json` | Session state | Per-session | 30 days |
| `.moai/specs/SPEC-*/` | SPEC documents | Per-feature | Permanent |
| `.moai/reports/` | Analysis reports | Per-operation | 90 days |
| `.moai/indexes/tags.db` | SPEC index | Project-wide | Permanent |
| `.moai/cache/` | Temporary data | Short-term | 30 days |

#### Context Passing Example

```python
# Phase 1: spec-builder creates SPEC
spec_builder_output = Task(
    subagent_type="spec-builder",
    prompt="Create SPEC-AUTH-001"
)
# Saves to: .moai/specs/SPEC-AUTH-001/spec.md

# Phase 2: implementation-planner reads SPEC
implementation_plan = Task(
    subagent_type="implementation-planner",
    prompt="Analyze SPEC-AUTH-001 and create execution plan"
    # Agent automatically reads from .moai/specs/SPEC-AUTH-001/
)

# Phase 2: tdd-implementer executes
implementation = Task(
    subagent_type="tdd-implementer",
    prompt=f"Implement SPEC-AUTH-001 following {implementation_plan}"
    # Receives plan context explicitly via prompt
)
```

### 5.3 Conflict Resolution

#### Strategy 1: Configuration Priority

**Configuration hierarchy** (highest to lowest priority):

1. User explicit choice (via AskUserQuestion)
2. `.moai/config/config.json` settings
3. SPEC document constraints
4. Agent default behavior
5. Skill recommendations

**Example:**
```
User sets: git_strategy.mode = "personal"
Agent detects: keywords suggest Team workflow
→ Resolution: Use Personal mode (user config wins)
```

#### Strategy 2: Validation Checkpoints

**Critical validation points:**

1. **Tab 1 Checkpoint** (Language settings)
   - Validates conversation_language is valid
   - Verifies agent_prompt_language consistency
   - Error recovery: Re-ask Tab 1 if validation fails

2. **Tab 3 Checkpoint** (Git strategy)
   - Personal mode: main_branch should not be "develop"
   - Team mode: PR base must be develop or main
   - Error recovery: Highlight conflicts, offer fixes

3. **Final Checkpoint** (Before config update)
   - Check all required fields set
   - Verify no conflicting settings
   - Validate field value types

#### Strategy 3: Quality Gate Enforcement

**TRUST 5 principle violations trigger:**

```
quality-gate validation:
├─ PASS: All checks pass → Proceed
├─ WARNING: Minor issues → User decides
│  └─ AskUserQuestion: Proceed or fix?
└─ CRITICAL: Major violations → Block until fixed
   └─ Mandatory fixes required
```

**Example conflict:**
```
Test coverage: 78% (target: 85%)
quality-gate result: WARNING
User prompt: "Coverage below target. Proceed anyway or add tests?"
User choice: Add tests → tdd-implementer adds tests → Re-validate
```

#### Strategy 4: Human-in-the-Loop

**Complex conflicts escalate to user:**

```python
# Example: Multiple valid approaches
AskUserQuestion({
    "questions": [{
        "question": "Two authentication strategies available. Which do you prefer?",
        "options": [
            {"label": "JWT Tokens", "description": "Stateless, scalable"},
            {"label": "Session Cookies", "description": "Simpler, traditional"}
        ]
    }]
})
# User decision resolves architectural conflict
```

### 5.4 Chaos Prevention Mechanisms

#### Mechanism 1: Single Command Entry Point

**Only one command active at a time:**
- User runs `/alfred:1-plan` → Workflow starts
- During execution, other commands blocked (implicitly via conversation flow)
- Command completes → User can run next command

#### Mechanism 2: Sequential Phase Execution

**Phases cannot overlap:**
```
✅ VALID: Phase 1 → Phase 2 → Phase 3 → Phase 4
❌ INVALID: Phase 1 + Phase 2 simultaneously
❌ INVALID: Phase 3 before Phase 2 complete
```

#### Mechanism 3: Agent Isolation

**Each agent has isolated context:**
- Agent A's Task() execution doesn't interfere with Agent B
- File system operations atomic (one agent writes at a time)
- Configuration reads are safe (no concurrent writes)

#### Mechanism 4: Explicit Dependencies

**Agents declare dependencies in frontmatter:**

```yaml
---
name: tdd-implementer
depends_on:
  - implementation-planner  # Must run after planner
  - spec-builder           # Requires SPEC document
tools: Read, Write, Edit, Bash
---
```

#### Mechanism 5: TodoWrite Tracking

**Task tracking prevents duplicates:**

```python
# TodoWrite ensures only one instance of task active
TodoWrite({
    "action": "create",
    "title": "Implement authentication",
    "status": "in_progress"
})

# Attempting to create duplicate:
TodoWrite({
    "action": "create",
    "title": "Implement authentication",  # Duplicate detected
    "status": "in_progress"
})
# → Returns existing task, prevents chaos
```

#### Mechanism 6: Hooks as Guardrails

**Hooks enforce system integrity:**

```python
# PreToolUse hook example
def pre_tool_use(tool_name, parameters):
    if tool_name == "Edit" and "config.json" in parameters:
        # Validate config before allowing edit
        validate_config_schema(parameters)
        create_backup()
    
    if tool_name == "Bash" and "rm -rf" in parameters:
        # Block dangerous operations
        raise SecurityError("Destructive operation blocked")
    
    return allow_operation()
```

**Hook execution points:**
- `SessionStart`: Initialize context, verify prerequisites
- `PreToolUse`: Validate operations before execution
- `PostToolUse`: Log changes, update indexes
- `SessionEnd`: Cleanup, save state, generate reports

---

## 6. Phase Transition Diagram (Text-Based)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                   MoAI Alfred Workflow Phase Transitions                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Phase 0: Project Setup                                              │  │
│  │  Command: /alfred:0-project [mode]                                   │  │
│  │  ┌────────────────────────────────────────────────────────────────┐  │  │
│  │  │  PHASE 1: Route & Analyze                                       │  │  │
│  │  │  ├─ Detect mode (INIT/AUTO/SETTINGS/UPDATE)                    │  │  │
│  │  │  └─ Delegate to project-manager                                │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 2: Execute Mode                                          │  │  │
│  │  │  ├─ Language-first configuration                               │  │  │
│  │  │  ├─ Tab-based settings (if SETTINGS mode)                      │  │  │
│  │  │  └─ Template optimization (if UPDATE mode)                     │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 3: Completion                                            │  │  │
│  │  │  ├─ Save context to .moai/memory/                              │  │  │
│  │  │  └─ AskUserQuestion: Next steps?                               │  │  │
│  │  └────────────────────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                              ↓                                              │
│                   User approves → Proceed to Phase 1                        │
│                              ↓                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Phase 1: Planning                                                   │  │
│  │  Command: /alfred:1-plan "feature description"                       │  │
│  │  ┌────────────────────────────────────────────────────────────────┐  │  │
│  │  │  PHASE 1A: Exploration (optional)                               │  │  │
│  │  │  └─ Explore agent: Find relevant files and patterns            │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 1B: SPEC Planning (required)                             │  │  │
│  │  │  ├─ spec-builder: Analyze requirements                         │  │  │
│  │  │  ├─ Propose SPEC candidates                                    │  │  │
│  │  │  ├─ Design EARS structure                                      │  │  │
│  │  │  └─ AskUserQuestion: Approve plan?                             │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │                User Decision Point                              │  │  │
│  │  │  ┌─────────────┬──────────────┬──────────────┬──────────────┐  │  │  │
│  │  │  │   Proceed   │    Modify    │ Save Draft   │    Cancel    │  │  │  │
│  │  │  └──────┬──────┴──────┬───────┴──────┬───────┴──────┬───────┘  │  │  │
│  │  │         ↓              ↓              ↓              ↓          │  │  │
│  │  │    Continue      Re-analyze     Save & Exit     Abort          │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 2: SPEC Document Creation (if approved)                  │  │  │
│  │  │  ├─ Create .moai/specs/SPEC-{ID}/                              │  │  │
│  │  │  ├─ Generate spec.md (EARS structure)                          │  │  │
│  │  │  ├─ Generate plan.md (implementation strategy)                 │  │  │
│  │  │  └─ Generate acceptance.md (test scenarios)                    │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 3: Git Branch & PR Setup                                 │  │  │
│  │  │  ├─ git-manager: Check Git configuration                       │  │  │
│  │  │  ├─ Create feature/SPEC-{ID} branch                            │  │  │
│  │  │  ├─ Personal mode: Local branch                                │  │  │
│  │  │  └─ Team mode: Draft PR to develop                             │  │  │
│  │  └────────────────────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                              ↓                                              │
│                   SPEC created → Proceed to Phase 2                         │
│                              ↓                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Phase 2: Implementation                                             │  │
│  │  Command: /alfred:2-run SPEC-{ID}                                    │  │
│  │  ┌────────────────────────────────────────────────────────────────┐  │  │
│  │  │  PHASE 1: Analysis & Planning                                   │  │  │
│  │  │  ├─ Read .moai/specs/SPEC-{ID}/spec.md                         │  │  │
│  │  │  ├─ implementation-planner: Analyze SPEC                       │  │  │
│  │  │  ├─ Auto-delegate to domain experts (backend/frontend/etc)    │  │  │
│  │  │  ├─ Create execution plan                                      │  │  │
│  │  │  └─ AskUserQuestion: Approve implementation plan?              │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 2: TDD Implementation                                    │  │  │
│  │  │  ├─ Initialize TodoWrite tracking                              │  │  │
│  │  │  ├─ tdd-implementer: RED → GREEN → REFACTOR                    │  │  │
│  │  │  │  ├─ RED: Write failing tests                                │  │  │
│  │  │  │  ├─ GREEN: Implement code to pass                           │  │  │
│  │  │  │  └─ REFACTOR: Improve code quality                          │  │  │
│  │  │  ├─ quality-gate: TRUST 5 validation                           │  │  │
│  │  │  │  ├─ Test coverage ≥85%?                                     │  │  │
│  │  │  │  ├─ Code quality passing?                                   │  │  │
│  │  │  │  └─ Security scan clean?                                    │  │  │
│  │  │  └─ Handle quality gate results:                               │  │  │
│  │  │     ├─ PASS → Continue                                         │  │  │
│  │  │     ├─ WARNING → User decides                                  │  │  │
│  │  │     └─ CRITICAL → Fix required                                 │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 3: Git Operations                                        │  │  │
│  │  │  ├─ git-manager: Create commits                                │  │  │
│  │  │  ├─ Conventional commit format                                 │  │  │
│  │  │  └─ Verify commits successful                                  │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 4: Completion                                            │  │  │
│  │  │  ├─ Display implementation summary                             │  │  │
│  │  │  └─ AskUserQuestion: Next steps?                               │  │  │
│  │  └────────────────────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                              ↓                                              │
│              Implementation complete → Proceed to Phase 3                   │
│                              ↓                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Phase 3: Sync & Documentation                                       │  │
│  │  Command: /alfred:3-sync [mode]                                      │  │
│  │  ┌────────────────────────────────────────────────────────────────┐  │  │
│  │  │  PHASE 1: Analysis & Planning                                   │  │  │
│  │  │  ├─ Verify prerequisites (.moai/, .claude/, Git)               │  │  │
│  │  │  ├─ Analyze Git changes (git diff, git status)                 │  │  │
│  │  │  ├─ Read .moai/config/config.json                              │  │  │
│  │  │  ├─ Determine sync mode (auto/force/status/project)            │  │  │
│  │  │  ├─ doc-syncer: Create synchronization plan                    │  │  │
│  │  │  └─ AskUserQuestion: Approve sync plan?                        │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 2: Execute Document Synchronization                      │  │  │
│  │  │  ├─ Create safety backup (.moai-backups/)                      │  │  │
│  │  │  ├─ doc-syncer: Synchronize documents                          │  │  │
│  │  │  │  ├─ Living Documents (README, API docs)                     │  │  │
│  │  │  │  ├─ SPEC documents (update status)                          │  │  │
│  │  │  │  ├─ Architecture diagrams                                   │  │  │
│  │  │  │  └─ SPEC index (.moai/indexes/tags.db)                      │  │  │
│  │  │  ├─ quality-gate: Verify synchronization                       │  │  │
│  │  │  │  ├─ Documentation complete?                                 │  │  │
│  │  │  │  ├─ Links valid?                                            │  │  │
│  │  │  │  └─ Formatting consistent?                                  │  │  │
│  │  │  └─ Update SPEC status: draft → active → completed             │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 3: Git Operations & PR                                   │  │  │
│  │  │  ├─ git-manager: Commit documentation changes                  │  │  │
│  │  │  ├─ Team mode: Transition PR Draft → Ready                     │  │  │
│  │  │  ├─ Optional: PR auto-merge (--auto-merge flag)                │  │  │
│  │  │  └─ Branch cleanup (if merged)                                 │  │  │
│  │  ├──────────────────────────────────────────────────────────────────┤  │  │
│  │  │  PHASE 4: Completion & Next Steps                               │  │  │
│  │  │  ├─ Display completion report                                   │  │  │
│  │  │  ├─ List updated files and improvements                         │  │  │
│  │  │  ├─ Show backup location                                        │  │  │
│  │  │  └─ AskUserQuestion: Next action?                               │  │  │
│  │  │     ├─ Create Next SPEC (→ Phase 1)                            │  │  │
│  │  │     ├─ Start New Session                                        │  │  │
│  │  │     ├─ Review PR (Team mode)                                    │  │  │
│  │  │     └─ Continue Development                                     │  │  │
│  │  └────────────────────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                              ↓                                              │
│                    Feature complete! Return to Phase 1                      │
│                      (for next feature) or exit workflow                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 7. Agent Orchestration Mechanisms

### 7.1 Task() Delegation Pattern

**Primary orchestration mechanism** in MoAI:

```python
# Basic syntax
Task(
    subagent_type="agent-name",       # Required: Which agent to invoke
    description="Brief task summary",  # Required: What to do
    prompt="Detailed instructions",    # Required: Full context
    model="sonnet|haiku"              # Optional: Model selection
)

# Example: Command delegates to orchestrator
result = Task(
    subagent_type="run-orchestrator",
    description="Execute SPEC-AUTH-001 implementation",
    prompt="""
    You are the run-orchestrator agent.
    
    Execute SPEC-AUTH-001 through 4 phases:
    1. Analysis & Planning
    2. TDD Implementation
    3. Git Operations
    4. Completion
    
    SPEC location: .moai/specs/SPEC-AUTH-001/
    """
)

# Example: Agent delegates to specialist
backend_plan = Task(
    subagent_type="backend-expert",
    description="Design REST API for authentication",
    prompt="""
    Design REST API endpoints for SPEC-AUTH-001.
    
    Requirements:
    - POST /api/auth/login
    - POST /api/auth/logout
    - GET /api/auth/me
    
    Technologies: FastAPI, JWT, bcrypt
    """,
    model="sonnet"  # Use Sonnet for complex design
)
```

### 7.2 Skill() Invocation Pattern

**Knowledge capsule invocation** (used by agents, not commands):

```python
# Agents invoke skills for domain knowledge

# Example 1: Language-specific knowledge
Skill("moai-lang-python")
# Loads: FastAPI 0.118.3, Pydantic v2, SQLAlchemy 2.0 patterns

# Example 2: Domain-specific knowledge
Skill("moai-domain-backend")
# Loads: API design patterns, microservices architecture

# Example 3: Foundation knowledge
Skill("moai-foundation-ears")
# Loads: EARS requirement format, SPEC templates

# Example 4: Conditional loading
if spec_has_performance_requirements():
    Skill("moai-essentials-perf")
    # Loads: Performance budgets, monitoring setup
```

**Skill characteristics:**
- **Progressive disclosure:** Only loaded when needed
- **Lazy loading:** Saves token budget
- **Cross-skill references:** Skills can reference other skills
- **Version-controlled:** Knowledge updates independently

### 7.3 AskUserQuestion for User Interaction

**Interactive decision points:**

```python
# Single question
response = AskUserQuestion({
    "questions": [{
        "question": "SPEC planning complete. Proceed?",
        "header": "Plan Approval",
        "multiSelect": false,
        "options": [
            {
                "label": "Proceed with SPEC Creation",
                "description": "Create SPEC files based on approved plan"
            },
            {
                "label": "Request Modifications",
                "description": "Modify plan content before creation"
            },
            {
                "label": "Cancel",
                "description": "Abort operation"
            }
        ]
    }]
})

# Batched questions (1-4 questions per call)
responses = AskUserQuestion({
    "questions": [
        {
            "question": "Project name?",
            "header": "Basic Configuration",
            "multiSelect": false,
            "options": [
                {"label": "Keep Current", "description": "Use existing name"},
                {"label": "Other", "description": "Enter new name"}
            ]
        },
        {
            "question": "Conversation language?",
            "header": "Language Settings",
            "multiSelect": false,
            "options": [
                {"label": "English (en)", "description": "English"},
                {"label": "Korean (ko)", "description": "한국어"},
                {"label": "Japanese (ja)", "description": "日本語"}
            ]
        }
    ]
})
```

**Best practices:**
- **Batch 1-4 questions** per call (minimize interaction turns)
- **No emojis** in question/header/options
- **Clear descriptions** for each option
- **Conversation language** from config

### 7.4 Configuration-Driven Behavior

**.moai/config/config.json** drives system behavior:

```json
{
  "moai": {
    "version": "0.25.8"
  },
  "project": {
    "name": "MoAI-ADK",
    "mode": "development",
    "language": "Python"
  },
  "language": {
    "conversation_language": "ko",
    "agent_prompt_language": "ko"
  },
  "git_strategy": {
    "personal": {
      "auto_checkpoint": "event-driven",
      "branch_prefix": "feature/SPEC-"
    },
    "team": {
      "develop_branch": "develop",
      "main_branch": "main",
      "use_gitflow": true
    }
  },
  "constitution": {
    "enforce_tdd": true,
    "test_coverage_target": 90
  }
}
```

**Configuration influences:**
- **Git operations:** Personal vs Team mode workflows
- **Language:** All agent responses and documents
- **Quality gates:** TRUST 5 enforcement levels
- **Workflow:** Auto-checkpoint, branch naming, PR strategy

### 7.5 Hook Lifecycle Management

**Hooks provide guardrails** and context management:

```
┌────────────────────────────────────────────────────────────┐
│                    Hook Execution Lifecycle                │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  SessionStart                                              │
│  ├─ auto_cleanup.py - Clean old reports                   │
│  ├─ config_health_check.py - Validate config              │
│  ├─ show_project_info.py - Display project status         │
│  └─ Initialize context for new session                    │
│                                                            │
│  PreToolUse (before each tool call)                       │
│  ├─ auto_checkpoint.py - Create Git checkpoint            │
│  ├─ document_management.py - Validate file locations      │
│  └─ Validate operation is safe                            │
│                                                            │
│  PostToolUse (after each tool call)                       │
│  ├─ log_changes.py - Record file changes                  │
│  ├─ enable_streaming_ui.py - Update progress UI           │
│  └─ Update indexes and caches                             │
│                                                            │
│  SessionEnd                                                │
│  ├─ auto_cleanup.py - Final cleanup                       │
│  ├─ cleanup.py - Remove temporary files                   │
│  └─ Save session state to .moai/memory/                   │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

**Hook locations:**
- `.claude/hooks/alfred/session_start__*.py`
- `.claude/hooks/alfred/pre_tool__*.py`
- `.claude/hooks/alfred/post_tool__*.py`
- `.claude/hooks/alfred/session_end__*.py`

---

## 8. Coordination and Conflict Resolution Strategies

### 8.1 Configuration Priority System

**Hierarchy (highest to lowest):**

1. **User explicit choice** (via AskUserQuestion) - Overrides all
2. **Project configuration** (.moai/config/config.json) - Project-specific
3. **SPEC constraints** (SPEC document requirements) - Feature-specific
4. **Agent recommendations** (Expert suggestions) - Based on analysis
5. **Skill defaults** (Best practices) - General guidelines

**Example conflict resolution:**
```
Situation: Authentication implementation approach

Level 1 - User choice: "Use JWT tokens" (via AskUserQuestion)
Level 2 - Project config: security.auth_method = "session"
Level 3 - SPEC constraint: "Stateless authentication required"
Level 4 - backend-expert: "JWT recommended for scalability"
Level 5 - moai-domain-backend: "Session cookies default"

Resolution: JWT tokens (User choice wins)
```

### 8.2 Validation Checkpoints

**Critical validation points** with enforcement:

#### Checkpoint 1: Language Settings (Tab 1)
```python
def validate_tab1(settings):
    """Validate language configuration"""
    errors = []
    
    # Check conversation_language is valid
    valid_languages = ['ko', 'en', 'ja', 'es', 'fr', 'de', ...]
    if settings['conversation_language'] not in valid_languages:
        errors.append("Invalid conversation language")
    
    # Verify agent_prompt_language consistency
    if settings['agent_prompt_language'] not in valid_languages:
        errors.append("Invalid agent prompt language")
    
    # Auto-update language_name
    language_names = {'ko': 'Korean', 'en': 'English', 'ja': 'Japanese'}
    settings['conversation_language_name'] = language_names.get(
        settings['conversation_language'], 'Unknown'
    )
    
    if errors:
        return False, errors
    return True, settings
```

#### Checkpoint 2: Git Strategy (Tab 3)
```python
def validate_tab3(settings):
    """Validate Git configuration for conflicts"""
    errors = []
    mode = settings.get('project.mode', 'personal')
    
    # Personal mode validations
    if mode == 'personal':
        if settings.get('git_strategy.personal.main_branch') == 'develop':
            errors.append("Personal mode should use 'main' branch, not 'develop'")
        
        if settings.get('git_strategy.personal.push_to_remote') == True:
            errors.append("Personal mode typically doesn't push to remote")
    
    # Team mode validations
    if mode == 'team':
        pr_base = settings.get('git_strategy.team.default_pr_base')
        if pr_base not in ['develop', 'main']:
            errors.append(f"Invalid PR base: {pr_base}")
        
        if settings.get('git_strategy.team.use_gitflow') == True:
            if settings.get('git_strategy.team.develop_branch') != 'develop':
                errors.append("GitFlow requires 'develop' branch")
    
    if errors:
        # Offer auto-fix suggestions
        suggestions = generate_autofix_suggestions(errors, settings)
        return False, errors, suggestions
    
    return True, settings
```

#### Checkpoint 3: Final Validation (Before Update)
```python
def validate_final(config):
    """Final validation before atomic update"""
    errors = []
    
    # Check all required fields
    required_fields = [
        'moai.version',
        'project.name',
        'language.conversation_language',
        'git_strategy.personal.branch_prefix',
        'constitution.enforce_tdd'
    ]
    
    for field in required_fields:
        if not get_nested_value(config, field):
            errors.append(f"Required field missing: {field}")
    
    # Verify field types
    type_validations = {
        'constitution.enforce_tdd': bool,
        'constitution.test_coverage_target': int,
        'hooks.timeout_ms': int
    }
    
    for field, expected_type in type_validations.items():
        value = get_nested_value(config, field)
        if value is not None and not isinstance(value, expected_type):
            errors.append(f"Invalid type for {field}: {type(value)}")
    
    # Check for conflicting settings
    conflicts = detect_conflicts(config)
    errors.extend(conflicts)
    
    return len(errors) == 0, errors
```

### 8.3 Quality Gate Enforcement

**TRUST 5 validation levels:**

```python
class QualityGateResult:
    """Quality gate validation result"""
    
    PASS = "PASS"           # All checks passed
    WARNING = "WARNING"     # Minor issues, user decides
    CRITICAL = "CRITICAL"   # Major violations, must fix
    
    def __init__(self, level, issues, recommendations):
        self.level = level
        self.issues = issues
        self.recommendations = recommendations

# Example quality gate execution
def quality_gate_validation():
    """Execute TRUST 5 validation"""
    results = []
    
    # T - Test First
    coverage = run_coverage_analysis()
    if coverage < 85:
        if coverage < 70:
            results.append(QualityGateResult(
                CRITICAL,
                [f"Test coverage {coverage}% below 70%"],
                ["Add tests to critical paths", "Review untested modules"]
            ))
        else:
            results.append(QualityGateResult(
                WARNING,
                [f"Test coverage {coverage}% below target 85%"],
                ["Consider adding edge case tests"]
            ))
    else:
        results.append(QualityGateResult(PASS, [], []))
    
    # R - Readable
    linting = run_linters()  # mypy, ruff, pylint
    if linting.errors > 0:
        results.append(QualityGateResult(
            CRITICAL,
            [f"{linting.errors} linting errors"],
            linting.fix_suggestions
        ))
    elif linting.warnings > 5:
        results.append(QualityGateResult(
            WARNING,
            [f"{linting.warnings} linting warnings"],
            ["Consider addressing warnings"]
        ))
    
    # U - Unified
    style_check = verify_style_consistency()
    # ... similar pattern
    
    # S - Secured
    security_scan = run_security_audit()  # OWASP checks
    if security_scan.vulnerabilities:
        results.append(QualityGateResult(
            CRITICAL,
            [f"{len(security_scan.vulnerabilities)} security issues"],
            security_scan.remediation_steps
        ))
    
    # T - Trackable
    spec_linkage = verify_spec_traceability()
    # ... similar pattern
    
    # Determine overall result
    if any(r.level == CRITICAL for r in results):
        return CRITICAL, results
    elif any(r.level == WARNING for r in results):
        return WARNING, results
    else:
        return PASS, results

# Handle quality gate results
gate_level, gate_results = quality_gate_validation()

if gate_level == PASS:
    # Proceed to next phase
    proceed_to_git_operations()

elif gate_level == WARNING:
    # Ask user to decide
    response = AskUserQuestion({
        "questions": [{
            "question": "Quality gate has warnings. Proceed?",
            "header": "Quality Gate Warning",
            "multiSelect": false,
            "options": [
                {"label": "Proceed Anyway", "description": "Continue despite warnings"},
                {"label": "Fix Issues", "description": "Address warnings first"}
            ]
        }]
    })
    
    if response == "Proceed Anyway":
        proceed_to_git_operations()
    else:
        fix_quality_issues(gate_results)

elif gate_level == CRITICAL:
    # Block until fixed
    print("CRITICAL: Quality gate failed. Must fix before proceeding:")
    for result in gate_results:
        if result.level == CRITICAL:
            print(f"  - {result.issues[0]}")
            print(f"    Recommendations: {', '.join(result.recommendations)}")
    
    # Force user to fix
    fix_quality_issues(gate_results)
    # Re-run validation
    quality_gate_validation()
```

### 8.4 Atomic Operations and Rollback

**Safe configuration updates:**

```python
def atomic_config_update(updates):
    """Update configuration with atomic rollback support"""
    config_path = Path('.moai/config/config.json')
    timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
    backup_path = config_path.parent / f'config.json.backup-{timestamp}'
    
    try:
        # Step 1: Load current config
        with open(config_path, 'r') as f:
            current_config = json.load(f)
        
        # Step 2: Create backup
        with open(backup_path, 'w') as f:
            json.dump(current_config, f, indent=2)
        
        # Step 3: Deep merge updates
        merged_config = deep_merge(current_config, updates)
        
        # Step 4: Validate merged config
        is_valid, errors = validate_final(merged_config)
        if not is_valid:
            raise ValidationError(f"Config validation failed: {errors}")
        
        # Step 5: Write atomically (temp file + rename)
        temp_path = config_path.parent / f'config.json.tmp-{timestamp}'
        with open(temp_path, 'w') as f:
            json.dump(merged_config, f, indent=2, ensure_ascii=False)
        
        # Atomic rename (OS-level atomic operation)
        temp_path.replace(config_path)
        
        # Step 6: Verify write success
        with open(config_path, 'r') as f:
            verification = json.load(f)
        
        if verification != merged_config:
            raise IntegrityError("Config verification failed")
        
        # Step 7: Success - delete backup
        backup_path.unlink()
        
        return True, merged_config
        
    except Exception as e:
        # Rollback: Restore from backup
        if backup_path.exists():
            backup_path.replace(config_path)
            print(f"ERROR: Config update failed. Rolled back to backup.")
            print(f"Backup preserved at: {backup_path}")
        
        return False, str(e)
```

---

## 9. Key Insights and Recommendations

### 9.1 Workflow Strengths

1. **Complete Agent Delegation Model**
   - Commands are pure orchestrators (no direct tool usage)
   - Agents have specialized expertise
   - Clear separation of concerns
   - 71% reduction in command complexity

2. **Sequential Phases with Approval Gates**
   - User always in control
   - Explicit approval at critical points
   - Can save as draft and resume
   - Clear phase boundaries

3. **SPEC-First TDD Methodology**
   - Requirements defined before coding (EARS format)
   - Tests written before implementation
   - TRUST 5 quality principles enforced
   - Traceability from SPEC → Code → Tests → Docs

4. **Multi-Language Support**
   - 50+ languages supported
   - Language-first architecture
   - Consistent across all phases
   - Auto-translation of announcements

5. **Comprehensive Validation**
   - Configuration checkpoints
   - Quality gate enforcement
   - Atomic updates with rollback
   - Safety backups before changes

### 9.2 Orchestration Highlights

1. **Hybrid Orchestration Model**
   - Central orchestration at command level
   - Distributed control at agent level
   - Agents auto-delegate to specialists
   - Optimal balance of control and autonomy

2. **Context Management**
   - File-based persistence (.moai/)
   - Configuration-driven behavior
   - Session state tracking
   - Hook lifecycle management

3. **Conflict Resolution**
   - Clear priority hierarchy
   - Validation checkpoints
   - Quality gate enforcement
   - Human-in-the-loop for complex decisions

4. **Chaos Prevention**
   - Single command entry point
   - Sequential phase execution
   - Agent isolation
   - Explicit dependencies
   - TodoWrite tracking
   - Hooks as guardrails

### 9.3 Workflow Efficiency

**Token Budget Optimization:**
- Agent delegation saves 80-85% tokens
- Progressive skill loading
- Lazy evaluation
- Context pruning

**Time Efficiency:**
- Simple feature: 4-5 hours (SPEC → Implementation → Docs)
- Complex feature: 1-4 weeks (multi-SPEC)
- Parallel expert delegation speeds analysis
- Automated documentation sync

**Quality Assurance:**
- 85%+ test coverage enforced
- TRUST 5 principles automatic
- Security audits built-in
- SPEC traceability guaranteed

### 9.4 Recommendations for Users

#### For Simple Features (< 1 day)
```bash
# Minimal workflow
/alfred:1-plan "simple feature description"
# → Approve SPEC creation
/alfred:2-run SPEC-{ID}
# → Implement with TDD
/alfred:3-sync auto
# → Documentation synced
```

#### For Complex Features (1-4 weeks)
```bash
# Multi-SPEC workflow
/alfred:1-plan "complex feature part 1"
# → Create SPEC-BACKEND-001
/alfred:1-plan "complex feature part 2"
# → Create SPEC-FRONTEND-001

/alfred:2-run SPEC-BACKEND-001
# → Foundation first
/alfred:2-run SPEC-FRONTEND-001
# → Build on foundation

/alfred:3-sync project
# → Full project sync
```

#### For Team Collaboration
```bash
# Set Team mode in config
/alfred:0-project setting tab_3_git_strategy
# → Configure Team GitFlow

# Use draft PRs
/alfred:1-plan "team feature"
# → Creates draft PR automatically

/alfred:2-run SPEC-{ID}
# → Implementation on feature branch

/alfred:3-sync auto --auto-merge
# → PR Ready → Auto-merge (if CI passes)
```

### 9.5 Future Enhancements

**Potential Improvements:**

1. **Parallel Phase Execution**
   - Allow PHASE 2 sub-tasks to run in parallel
   - Multi-SPEC parallel implementation
   - Parallel documentation generation

2. **Enhanced Context Passing**
   - Agent-to-agent direct communication channel
   - Richer context objects
   - Session resume from any phase

3. **Advanced Conflict Resolution**
   - ML-based conflict prediction
   - Auto-resolution for common conflicts
   - Conflict learning and prevention

4. **Workflow Customization**
   - User-defined phases
   - Custom approval gates
   - Workflow templates

5. **Performance Optimization**
   - Caching strategies
   - Incremental sync (only changed docs)
   - Faster quality gates

---

## 10. Conclusion

MoAI Alfred's 4-phase workflow demonstrates a **sophisticated orchestration system** that balances:

- **Control:** Sequential phases with explicit approval gates
- **Flexibility:** Can modify, save draft, or skip optional sub-phases
- **Quality:** TRUST 5 principles enforced automatically
- **Efficiency:** Agent delegation saves 80%+ tokens, parallel expert delegation
- **Safety:** Validation checkpoints, atomic operations, rollback support

**Key Success Factors:**

1. **Complete Agent Delegation:** Commands orchestrate, agents execute
2. **SPEC-First Methodology:** Requirements defined before coding
3. **TDD Enforcement:** Tests written before implementation
4. **Multi-Language Support:** 50+ languages, language-first architecture
5. **Hybrid Orchestration:** Central + distributed control
6. **Context Management:** File-based persistence + configuration-driven
7. **Conflict Resolution:** Clear priorities + validation + quality gates
8. **Chaos Prevention:** Single entry point + sequential phases + isolation

**Workflow Maturity:** The system shows **production-ready maturity** with comprehensive error handling, validation, rollback mechanisms, and extensive documentation.

---

## Appendix A: Agent Directory Structure

```
.claude/agents/alfred/
├── accessibility-expert.md          # WCAG, a11y audits
├── agent-factory.md                 # Create new agents
├── api-designer.md                  # REST/GraphQL APIs
├── backend-expert.md                # Server architecture
├── cc-manager.md                    # Claude Code config
├── component-designer.md            # Component architecture
├── database-expert.md               # Schema design
├── debug-helper.md                  # Error analysis
├── devops-expert.md                 # Infrastructure
├── doc-syncer.md                    # Documentation sync
├── docs-manager.md                  # Doc management
├── format-expert.md                 # Code formatting
├── frontend-expert.md               # Client-side UI
├── git-manager.md                   # Git operations
├── implementation-planner.md        # Implementation strategy
├── mcp-context7-integrator.md       # Context7 MCP
├── mcp-notion-integrator.md         # Notion integration
├── mcp-playwright-integrator.md     # Browser automation
├── mcp-sequential-thinking-integrator.md  # Enhanced reasoning
├── migration-expert.md              # Migration planning
├── monitoring-expert.md             # Observability
├── performance-engineer.md          # Performance optimization
├── project-manager.md               # Project orchestration
├── quality-gate.md                  # TRUST 5 validation
├── security-expert.md               # OWASP, compliance
├── skill-factory.md                 # Create new skills
├── spec-builder.md                  # SPEC creation
├── sync-manager.md                  # Multi-SPEC sync
├── tdd-implementer.md               # TDD cycle
├── trust-checker.md                 # TRUST 5 compliance
└── ui-ux-expert.md                  # Design systems, UX

Total: 31 agents
```

---

## Appendix B: Command-Phase Mapping

| Command | Phases | Sub-Phases | Duration | Agents Used |
|---------|--------|------------|----------|-------------|
| `/alfred:0-project` | 3 | 6 | 2-5 min | project-manager |
| `/alfred:1-plan` | 3 | 5 | 5-15 min | Explore, spec-builder, git-manager |
| `/alfred:2-run` | 4 | 8 | 30m-days | run-orchestrator, implementation-planner, tdd-implementer, quality-gate, git-manager, domain experts |
| `/alfred:3-sync` | 4 | 10 | 2-10 min | doc-syncer, quality-gate, git-manager |

**Total workflow:** 14 phases, 29 sub-phases, 4 commands, 31+ agents

---

## Appendix C: Quality Metrics

| Metric | Before Refactor | After Agent-First | Improvement |
|--------|----------------|-------------------|-------------|
| Command LOC | ~2,500 | ~800 | **68% reduction** |
| allowed-tools per command | 14 types | 1-3 types | **78% reduction** |
| Direct tool usage | High | None | **100% eliminated** |
| Agent coordination | Manual | Automatic | **Fully automated** |
| Token efficiency | Baseline | Optimized | **80-85% savings** |
| Test coverage | 80% | 92% | **15% increase** |
| Code quality | Good | Excellent | **TRUST 5 enforced** |

---

**Document Version:** 1.0  
**Analysis Completed:** 2025-11-19  
**Analyst:** Claude Code Agent (File Search Specialist)  
**Repository:** `/home/user/claude-skill-eval/moai-adk-main/`
