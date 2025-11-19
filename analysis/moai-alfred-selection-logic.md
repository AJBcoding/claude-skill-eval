# MoAI Alfred Agent Selection and Calling Mechanisms

**Analysis Date:** 2025-11-19  
**Project:** MoAI-ADK (v0.25.8)  
**Location:** `/home/user/claude-skill-eval/moai-adk-main/`  
**Total Agents:** 31 specialized agents  
**Total Skills:** 128+ knowledge capsules  

---

## Executive Summary

The MoAI-ADK system does **NOT** have automatic agent selection or routing logic. Instead, it uses an **explicit delegation model** where:

1. **Alfred** (the main Claude instance reading CLAUDE.md) serves as the orchestrator
2. **Commands** (`/alfred:0-project`, `/alfred:1-plan`, etc.) define workflow entry points
3. **Agents** are explicitly invoked via `Task(subagent_type="agent-name")` calls
4. **Skills** are explicitly loaded via `Skill("skill-name")` invocations

**Key Finding:** The "Use PROACTIVELY when" descriptions in agent files are **guidance for Alfred's decision-making**, not automatic triggers. All agent selection is manual and explicit.

---

## 1. Agent Selection Mechanisms

### 1.1 The Core Architecture: Explicit Delegation

**No Automatic Routing Exists.** The system architecture is:

```
User Input
    ↓
Slash Command (/alfred:0-project, /alfred:1-plan, /alfred:2-run, /alfred:3-sync)
    ↓
Alfred (Main Claude Instance reading CLAUDE.md)
    ↓
Task(subagent_type="specific-agent-name") - EXPLICIT CALL
    ↓
Agent Execution (isolated context)
    ↓
Skill("skill-name") - EXPLICIT LOAD
    ↓
Return Results to Alfred
```

### 1.2 How Alfred Makes Selection Decisions

Alfred's decision-making is based on:

**A. Command Instructions**
- Each slash command file (`.claude/commands/alfred/*.md`) contains explicit instructions
- Commands tell Alfred which agents to call and in what sequence
- Example from `/alfred:1-plan`:
  ```
  Tool: Task
  Parameters:
  - subagent_type: "spec-builder"
  - description: "Analyze project and create SPEC plan"
  ```

**B. Agent Descriptions as Guidance**
- Agent files have `description` fields with "Use PROACTIVELY when" patterns
- These are **hints for Alfred**, not automatic triggers
- Example: `security-expert.md`
  ```yaml
  description: "Use PROACTIVELY for security analysis, vulnerability assessment...
  Activated by keywords: 'security', 'auth', 'encryption', 'vulnerability'..."
  ```
- Alfred reads these descriptions and makes contextual decisions

**C. CLAUDE.md Priority Stack**
- CLAUDE.md defines a 3-tier priority system:
  ```
  Priority 1: MoAI-ADK Agents (spec-builder, tdd-implementer, backend-expert...)
  Priority 2: MoAI-ADK Skills (moai-lang-python, moai-domain-backend...)
  Priority 3: Claude Code Native (Explore, Plan as fallbacks)
  ```
- This guides Alfred to prefer MoAI agents when applicable

### 1.3 Selection Decision Tree

```
User Request Received by Alfred
    ↓
Does it match a slash command pattern?
    ├─ YES → Execute command workflow (command defines agents)
    └─ NO → Alfred analyzes request intent
             ↓
         Check CLAUDE.md guidance:
             - Complexity assessment
             - Domain identification
             - Available agents review
             ↓
         Alfred makes explicit Task() call:
             - Single domain → Specific agent (backend-expert, database-expert, etc.)
             - Multi-domain → Sequential agent calls or Plan mode
             - High complexity → Use Task(subagent_type="Plan") first
             ↓
         Agent executes with isolated context
```

### 1.4 No Centralized Router

**Critical Finding:** There is NO centralized routing engine or selection algorithm. Agent selection is distributed across:

1. **Command Files:** Define standard workflows and agent sequences
2. **CLAUDE.md:** Provides decision-making guidance to Alfred
3. **Agent Descriptions:** Offer contextual hints about when to use each agent
4. **Alfred's Reasoning:** Claude's native intelligence makes final decisions

---

## 2. Trigger Systems

### 2.1 Types of Triggers

#### A. Manual Triggers (Primary)
- **Slash Commands:** `/alfred:0-project`, `/alfred:1-plan`, `/alfred:2-run`, `/alfred:3-sync`
- **Explicit Mentions:** `@agent-cc-manager`, `@agent-debug-helper`
- **Task() Calls:** Direct agent invocation in custom workflows

#### B. Contextual Triggers (Secondary)
- **Keyword Patterns:** Agent descriptions list keywords that suggest usage
  - `security-expert`: 'security', 'auth', 'encryption', 'vulnerability', 'owasp'
  - `database-expert`: 'database', 'schema', 'query', 'migration', 'orm'
  - `backend-expert`: 'backend', 'api', 'server', 'microservice'
- **Domain Detection:** Alfred infers domain from user request
  - Frontend keywords → Consider `frontend-expert`
  - Performance issues → Consider `performance-engineer`
  - Documentation needs → Consider `docs-manager`

#### C. Hook-Based Triggers (Automatic)
- **SessionStart Hooks:** Run automatically when Claude Code session starts
  - `.claude/hooks/alfred/session_start__show_project_info.py`
  - `.claude/hooks/alfred/session_start__config_health_check.py`
- **PreToolUse Hooks:** Run before certain tools execute
  - `.claude/hooks/alfred/pre_tool__auto_checkpoint.py` (before Edit/Write)
- **UserPromptSubmit Hooks:** Run when user submits prompt
  - `.claude/hooks/alfred/user_prompt__jit_load_docs.py`
- **SessionEnd Hooks:** Run when session ends
  - `.claude/hooks/alfred/session_end__auto_cleanup.py`

**Important:** Hooks trigger Python scripts, NOT agents. Hooks provide context but don't select agents.

### 2.2 Proactive Descriptions Are Guidance, Not Automation

All 31 agent files contain descriptions like:
```yaml
description: "Use PROACTIVELY when: [conditions]. Triggered by SPEC keywords: [keywords]."
```

**These are NOT automatic triggers.** They are:
- Documentation for Alfred to understand when each agent is appropriate
- Guidelines for human developers extending the system
- Context for Alfred's decision-making process

**Example:** `backend-expert.md`
```yaml
description: "Use PROACTIVELY when: Backend architecture, API design, server 
implementation, database integration, or microservices architecture is needed. 
Triggered by SPEC keywords: 'backend', 'api', 'server', 'database', 'microservice', 
'deployment', 'authentication'. CRITICAL: This agent MUST be invoked via 
Task(subagent_type='backend-expert') - NEVER executed directly."
```

The description explicitly states the agent **MUST be invoked via Task()** - proving there's no automatic invocation.

---

## 3. The Alfred Component

### 3.1 What Alfred IS

**Alfred is the main Claude instance with enhanced capabilities:**

- **Identity:** Claude Sonnet 4.5 reading CLAUDE.md as its system prompt/persona
- **Role:** SuperAgent orchestrator coordinating 31 specialized agents
- **Function:** Makes all agent selection decisions based on context and guidance
- **Architecture:** 4-layer system (Commands → Agents → Skills → Hooks)

### 3.2 What Alfred is NOT

- **NOT a meta-agent:** Alfred doesn't run as a separate agent that selects other agents
- **NOT a router service:** No centralized routing algorithm or decision engine
- **NOT automatic:** All agent calls are explicit Task() invocations
- **NOT a separate process:** Alfred IS Claude reading the enhanced system prompt

### 3.3 Alfred's SuperAgent Concept

The "SuperAgent" concept means:

```
┌─────────────────────────────────────────────────────────┐
│ Alfred SuperAgent (Main Claude Instance)                │
│                                                          │
│ Capabilities:                                           │
│  • Reads CLAUDE.md for identity and workflow guidance   │
│  • Analyzes user requests for intent and complexity     │
│  • Selects appropriate agents via Task() delegation     │
│  • Orchestrates multi-agent workflows                   │
│  • Manages context across agent interactions            │
│  • Integrates MCP servers for external data             │
│  • Applies SPEC-First TDD methodology                   │
│                                                          │
│ Decision Sources:                                       │
│  1. CLAUDE.md guidance (priority stack, workflows)      │
│  2. Command instructions (explicit agent sequences)     │
│  3. Agent descriptions ("Use PROACTIVELY when...")      │
│  4. User context (project type, complexity, intent)     │
│  5. Native Claude reasoning (decision-making)           │
└─────────────────────────────────────────────────────────┘
```

### 3.4 Alfred's Decision Logic

**5-Phase Workflow Protocol (from CLAUDE.md):**

1. **Intent:** Clarify ambiguous requests via AskUserQuestion
2. **Assess:** Evaluate complexity (LOW/MEDIUM/HIGH)
3. **Plan:** Decompose into phases and assign agents
4. **Confirm:** Get user approval for execution plan
5. **Execute:** Coordinate agents in optimal sequence (parallel when possible)

**Complexity-Based Agent Selection:**
```
Request Complexity Assessment:
├─ LOW (simple bug fix, formatting)
│   → Direct execution, minimal agent delegation
│   → Use lightweight agents (format-expert, debug-helper)
│
├─ MEDIUM (single domain, 1-2 days)
│   → Quick complexity check
│   → Single domain agent (backend-expert, frontend-expert, etc.)
│
└─ HIGH (multi-domain, 2+ weeks, security requirements)
    → Full planning phase REQUIRED
    → Task(subagent_type="Plan") for decomposition
    → Multi-agent coordination (backend-expert + database-expert + security-expert)
    → Parallel execution where possible
```

---

## 4. Agent Selection Priority and Conflict Resolution

### 4.1 Priority System

**3-Tier Priority Stack (from CLAUDE.md):**

```
Priority 1: MoAI-ADK Agents (31 specialized agents)
   - spec-builder, tdd-implementer, backend-expert, frontend-expert
   - database-expert, security-expert, docs-manager, performance-engineer
   - monitoring-expert, api-designer, etc.
   → Specialized MoAI patterns, SPEC-First TDD, production-ready

Priority 2: MoAI-ADK Skills (128+ knowledge capsules)
   - moai-lang-python, moai-lang-typescript, moai-lang-go
   - moai-domain-backend, moai-domain-frontend, moai-domain-security
   - moai-essentials-debug, moai-essentials-perf, moai-essentials-refactor
   → Context7 integration, latest API versions, best practices

Priority 3: Claude Code Native (fallback/complementary)
   - Explore, Plan, debug-helper
   → Use when MoAI agents insufficient or specific context needed
```

### 4.2 Multi-Agent Scenarios

**When multiple agents could handle a task:**

**Scenario 1: Overlapping Capabilities**
- User: "Optimize database queries for the API"
- Candidates: `database-expert` + `backend-expert` + `performance-engineer`
- **Resolution:** Alfred prioritizes by primary domain
  - Primary: `database-expert` (query optimization is core domain)
  - Secondary: `performance-engineer` (if benchmarking needed)

**Scenario 2: Sequential Workflow**
- User: "Implement user authentication feature"
- Required agents:
  1. `spec-builder` → create SPEC
  2. `backend-expert` → API endpoints
  3. `database-expert` → user schema
  4. `security-expert` → OWASP compliance
  5. `tdd-implementer` → test-driven implementation
  6. `docs-manager` → API documentation
- **Resolution:** Alfred executes via `/alfred:1-plan` → `/alfred:2-run` → `/alfred:3-sync`

**Scenario 3: Parallel Execution**
- User: "Setup production deployment"
- Independent tasks:
  - `backend-expert`: API implementation
  - `database-expert`: Schema migration (parallel)
  - `security-expert`: Security audit (parallel)
  - `monitoring-expert`: Observability setup (parallel)
  - `devops-expert`: CI/CD pipeline (depends on all above)
- **Resolution:** Alfred runs first 4 agents in parallel, then devops-expert

### 4.3 Conflict Resolution Rules

**Rule 1:** Command Instructions Override Agent Descriptions
**Rule 2:** More Specialized Agent Wins
**Rule 3:** User Explicit Mention (@agent-name) Wins
**Rule 4:** No Duplicate Work
**Rule 5:** Graceful Degradation (Priority 1 → 2 → 3)

---

## 5. Configuration and Customization

### 5.1 Configuration Files

**`.moai/config/config.json`**
- Project metadata, language settings, git strategy, quality principles
- **Does NOT** configure agent routing or selection logic
- Provides context Alfred uses for decisions

**`.claude/settings.json`**
- Claude Code permissions, hooks, MCP servers, status line
- **Does NOT** contain agent selection rules
- Defines what tools agents can use

**`.claude/agents/alfred/*.md`**
- 31 agent definition files (13,652 total lines)
- Each defines: name, description, tools, model, skills, responsibilities
- **Descriptions guide Alfred, don't configure automatic triggers**

**`.claude/commands/alfred/*.md`**
- Slash command definitions
- **Explicitly define agent call sequences**
- Most direct control over agent orchestration

### 5.2 Customization Points

**A. Create New Agents**
- Use `@agent-agent-factory` to generate new specialized agents
- Define in `.claude/agents/alfred/new-agent.md`
- Add "Use PROACTIVELY when" description to guide Alfred

**B. Modify Agent Descriptions**
- Edit `.claude/agents/alfred/{agent-name}.md`
- Update `description` field to change when Alfred considers using the agent

**C. Create Custom Commands**
- Add new slash command in `.claude/commands/alfred/custom-command.md`
- Define explicit agent call sequence
- Most reliable way to control agent selection

**D. Adjust Priority Stack**
- Edit `CLAUDE.md` section "MoAI-ADK Agent & Skill Orchestration"
- Change Priority 1/2/3 preferences

---

## 6. Decision Tree Flowchart

### Overall Agent Selection Flow

```
User Input
    ↓
Is it a slash command? ─── YES ──→ Execute Command Workflow
    │                               (/alfred:0-project → project-manager)
    │                               (/alfred:1-plan → spec-builder)
    NO                              (/alfred:2-run → tdd-implementer)
    ↓                               (/alfred:3-sync → doc-syncer)
Alfred Analyzes Intent
    ↓
Assess Complexity: LOW/MEDIUM/HIGH
    │
    ├─ LOW/MEDIUM ──→ Identify Domain ──→ Single Agent
    │                                      Task(subagent_type="domain-expert")
    │
    └─ HIGH ──→ Use Plan Mode ──→ Task(subagent_type="Plan")
                     ↓
              Decompose Into Phases
                     ↓
              Execute Multi-Agent Workflow
                     ↓
              Load Priority 2 Skills if needed
                     ↓
              Execute Agents in Isolated Context
                     ↓
              Return Results to Alfred
```

---

## 7. Key Insights and Recommendations

### 7.1 Critical Insights

1. **No Magic Routing:** The system relies entirely on explicit Task() calls. There's no AI-powered automatic agent selection beyond Alfred's native reasoning.

2. **CLAUDE.md is the Orchestrator:** The CLAUDE.md file serves as Alfred's extended system prompt, providing decision-making guidance for 31 agents and 128+ skills.

3. **Proactive Descriptions Are Documentation:** Agent descriptions with "Use PROACTIVELY when" are human-readable guidance, not machine-parsed triggers.

4. **Commands Define Standard Workflows:** The 4 slash commands encode the most common agent sequences, reducing Alfred's decision burden.

5. **Hooks Provide Context, Not Selection:** Hooks run Python scripts that gather context but don't select agents.

6. **Skill Invocation is Agent-Driven:** Agents explicitly call Skill() to load knowledge.

7. **Priority Stack is Preference, Not Rule:** The 3-tier priority guides Alfred but doesn't enforce automatic selection.

### 7.2 Strengths

- **Predictable:** Explicit Task() calls make agent selection traceable
- **Flexible:** Alfred adapts to nuanced requests using native reasoning
- **Maintainable:** No complex routing engine to update
- **Transparent:** Users can see exactly which agents are called
- **Extensible:** Adding new agents only requires creating agent file + updating CLAUDE.md

### 7.3 Recommendations

**Short-Term:**
1. Create agent selection quick-reference table in CLAUDE.md
2. Add usage metrics logging for Task() calls
3. Standardize trigger keywords across agent descriptions
4. Add flowcharts to command files

**Medium-Term:**
1. Create `/alfred:agents` command to list available agents
2. Add PreToolUse hook to validate Task() calls
3. Reduce CLAUDE.md size via separate workflow files
4. Document agent dependency graph

**Long-Term:**
1. Add recommendation engine (suggests agents but requires explicit call)
2. Create DSL for multi-agent workflows
3. Track agent execution metrics
4. Allow user-customizable priority stack

---

## 8. Conclusion

The MoAI-ADK system implements a **deliberate manual delegation model** for agent selection. This design prioritizes:

- **Transparency:** All agent calls are explicit and traceable
- **Flexibility:** Alfred's native reasoning adapts to nuanced contexts
- **Maintainability:** No complex routing engine to break
- **Predictability:** Developers can understand and control agent selection

**Alfred** is the orchestrator - the main Claude instance reading CLAUDE.md. Alfred makes all agent selection decisions based on:
1. Slash command instructions (explicit)
2. CLAUDE.md guidance (priority stack, workflows)
3. Agent descriptions (contextual hints)
4. Native Claude reasoning (decision-making)

The 31 agents are specialized subagents invoked via `Task(subagent_type="agent-name")` for domain expertise, with 128+ skills providing knowledge via `Skill("skill-name")`.

This architecture successfully balances automation (hooks, workflows) with control (explicit delegation), making it suitable for production SPEC-First TDD development.

---

## Appendix: Agent Catalog

### Complete Agent List (31)

**Core Workflow:** project-manager, spec-builder, tdd-implementer, doc-syncer, quality-gate

**Domain Experts:** backend-expert, frontend-expert, database-expert, security-expert, devops-expert, performance-engineer, monitoring-expert

**Specialized Technical:** api-designer, component-designer, migration-expert, accessibility-expert, ui-ux-expert, format-expert

**Integration:** mcp-context7-integrator, mcp-notion-integrator, mcp-playwright-integrator, mcp-sequential-thinking-integrator

**Support:** git-manager, docs-manager, trust-checker, debug-helper, implementation-planner, sync-manager

**Infrastructure:** cc-manager, agent-factory, skill-factory

---

**Document Metadata:**
- Analysis Depth: Comprehensive
- Sources: 20+ files from `.claude/`, `.moai/`, project root
- Flowcharts: 3 text-based diagrams
- Key Finding: Explicit delegation model, no automatic routing
