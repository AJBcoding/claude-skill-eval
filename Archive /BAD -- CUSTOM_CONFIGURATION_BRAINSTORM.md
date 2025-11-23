# Custom Claude Code Configuration - Brainstorming Session

**Date:** 2025-11-18
**Goal:** Create a robust, non-conflicting configuration drawing from the best of three frameworks
**Base:** obra/superpowers (current workflow)

---

## Phase 1: Current State Analysis

### What You Already Have (obra/superpowers)

Based on analysis of claude-code-stuff-main which uses superpowers, you already have these **19 core skills**:

#### Testing & Quality (4 skills)
- ✅ **test-driven-development** - RED-GREEN-REFACTOR cycle
- ✅ **testing-anti-patterns** - Prevents mock behavior testing
- ✅ **condition-based-waiting** - Replaces arbitrary timeouts
- ✅ **verification-before-completion** - Evidence before claims

#### Debugging (3 skills)
- ✅ **systematic-debugging** - 4-phase framework (root cause first)
- ✅ **root-cause-tracing** - Backward tracing through call stack
- ✅ **defense-in-depth** - Multi-layer validation

#### Development Workflow (2 skills)
- ✅ **using-git-worktrees** - Multiple branches simultaneously
- ✅ **finishing-a-development-branch** - Systematic completion

#### Collaboration (2 skills)
- ✅ **requesting-code-review** - Dispatch code-reviewer agent
- ✅ **receiving-code-review** - Technical rigor in feedback

#### Planning & Execution (3 skills)
- ✅ **writing-plans** - Comprehensive implementation plans
- ✅ **executing-plans** - Systematic execution
- ✅ **subagent-driven-development** - Agent delegation patterns

#### Meta-Skills (5 skills)
- ✅ **brainstorming** - Structured idea exploration
- ✅ **using-superpowers** - How to use skills properly
- ✅ **writing-skills** - TDD for process documentation
- ✅ **testing-skills-with-subagents** - Skill validation
- ✅ **sharing-skills** - Contributing back to upstream

#### Additional
- ✅ **commands** - Command patterns
- ✅ **dispatching-parallel-agents** - Concurrent execution

### What obra/superpowers Does Well

**Strengths:**
1. **Battle-tested engineering practices** - Used by many developers
2. **Testing focus** - TDD, anti-patterns, verification
3. **Debugging methodology** - Systematic, not ad-hoc
4. **Git workflow optimization** - Worktrees, branching
5. **Quality over speed** - Verification before completion
6. **Modular design** - Single-responsibility skills
7. **Clear documentation** - Well-written SKILL.md files
8. **Active maintenance** - Jesse Vincent actively maintains

**Gaps/Limitations:**
- ❌ No domain-specific skills (backend, frontend, database)
- ❌ No language-specific skills (Python, TypeScript, Go, etc.)
- ❌ No BaaS platform integration
- ❌ No document processing (docx, pdf)
- ❌ No MCP server development
- ❌ No cost optimization patterns (model selection)
- ❌ No security-specific skills (OWASP, encryption)
- ❌ No performance optimization beyond debugging

---

## Phase 2: Gap Analysis - What's Missing

### Critical Gaps to Fill

#### 1. Cost Optimization (High Priority)
**Current:** No explicit cost management
**Need:** Agent specialization for token/cost savings

**Best Source:** claude-code-stuff-main
- ✅ Search agent (Haiku) - 40-60% cost reduction
- ✅ Model selection strategy
- ✅ Context pollution prevention

**Action:** Add cost-optimized agents without duplicating superpowers debugging

#### 2. Domain Expertise (High Priority)
**Current:** No backend/frontend/database specialization
**Need:** Domain-specific patterns and best practices

**Best Source:** moai-adk-main
- ✅ moai-domain-backend
- ✅ moai-domain-frontend
- ✅ moai-domain-database
- ✅ moai-domain-security

**Filter:** Only add domains you actually use

#### 3. Language-Specific Skills (Medium Priority)
**Current:** Generic practices, no language-specific guidance
**Need:** Language best practices for your stack

**Best Source:** moai-adk-main has 18 languages
**Action:** Select only the languages you use

#### 4. Document Processing (Low Priority if not needed)
**Current:** No docx/pdf/pptx capabilities
**Need:** Only if you work with documents

**Best Source:** agentic-coding-main
- ✅ Comprehensive OOXML schemas
- ✅ Python scripts for automation

**Action:** Add only if document-heavy work

#### 5. MCP Integration (Medium Priority)
**Current:** No MCP server development
**Need:** If building MCP servers or using Context7

**Best Source:**
- agentic-coding-main (mcp-builder skill)
- moai-adk-main (Context7, Playwright integration)

---

## Phase 3: Platform & Language Filtering

### Languages/Platforms to Evaluate

Based on the three frameworks, here are ALL languages/platforms covered. **Check which you actually use:**

#### Languages (18 total in moai-adk-main)
- [ ] Python
- [ ] TypeScript/JavaScript
- [ ] Go
- [ ] Java
- [ ] C#
- [ ] C++
- [ ] Rust
- [ ] Ruby
- [ ] PHP
- [ ] Swift (iOS/macOS)
- [ ] Kotlin (Android)
- [ ] Dart (Flutter)
- [ ] Elixir
- [ ] Scala
- [ ] R (data science)
- [ ] Shell scripting
- [ ] SQL
- [ ] HTML/CSS

#### Domains (30+ in moai-adk-main)
- [ ] Backend development (APIs, microservices)
- [ ] Frontend development (React, Vue, Angular)
- [ ] Database (SQL, NoSQL, schema design)
- [ ] Mobile (iOS, Android, React Native)
- [ ] Cloud (AWS, GCP, Azure)
- [ ] DevOps (Docker, Kubernetes, CI/CD)
- [ ] Security (OWASP, encryption, OAuth)
- [ ] Machine Learning / AI
- [ ] Data Engineering
- [ ] Performance optimization
- [ ] Testing/QA
- [ ] Documentation

#### BaaS Platforms (12 in moai-adk-main)
- [ ] Supabase (PostgreSQL + Auth + Realtime)
- [ ] Firebase (Google's platform)
- [ ] Vercel (Next.js, edge functions)
- [ ] Cloudflare (Workers, D1, R2)
- [ ] Auth0 (Enterprise auth)
- [ ] Clerk (User management)
- [ ] Convex (Real-time backend)
- [ ] Railway (All-in-one deployment)
- [ ] Neon (Serverless PostgreSQL)
- [ ] PlanetScale (MySQL)
- [ ] Heroku
- [ ] Netlify

#### Document Types (if needed)
- [ ] Microsoft Word (.docx)
- [ ] PDF
- [ ] PowerPoint (.pptx)
- [ ] Excel (.xlsx)

#### Specializations
- [ ] Australian English enforcement (from agentic-coding-main)
- [ ] Swift/iOS specific (from claude-code-stuff-main)
- [ ] SPEC-First TDD (from moai-adk-main)
- [ ] TRUST 5 quality gates (from moai-adk-main)

---

## Phase 4: Non-Conflicting Integration Strategy

### Conflicts to Avoid

#### 1. Duplicate Debugging Skills
**Conflict:** All three frameworks have debugging approaches
- obra/superpowers: systematic-debugging, root-cause-tracing
- agentic-coding-main: systematic-debugging skill
- moai-adk-main: moai-essentials-debug (AI-powered)

**Resolution:**
- ✅ KEEP: obra/superpowers systematic-debugging (proven, lightweight)
- ❌ SKIP: agentic-coding-main version (duplicate)
- ⚠️ EVALUATE: moai-essentials-debug if you want AI-powered assistance

#### 2. Duplicate TDD Skills
**Conflict:** TDD appears in multiple places
- obra/superpowers: test-driven-development
- moai-adk-main: moai-foundation-tdd

**Resolution:**
- ✅ KEEP: obra/superpowers (simpler, battle-tested)
- ❌ SKIP: moai version (more complex, SPEC-First focused)

#### 3. Duplicate Code Review
**Conflict:** Code review in multiple frameworks
- obra/superpowers: requesting/receiving-code-review
- agentic-coding-main: code-reviewer agent
- moai-adk-main: moai-essentials-review (AI-powered)

**Resolution:**
- ✅ KEEP: obra/superpowers (human-focused process)
- ✅ ADD: moai-essentials-review IF you want automated AI review
- ❌ SKIP: agentic-coding-main (covered by superpowers)

#### 4. Duplicate Planning Skills
**Conflict:** Development planning in multiple places
- obra/superpowers: writing-plans, executing-plans
- agentic-coding-main: create-development-plan (497 lines, very detailed)
- moai-adk-main: /alfred:1-plan (SPEC-First)

**Resolution:**
- ✅ KEEP: obra/superpowers (good balance)
- ⚠️ CONSIDER: agentic-coding-main if you need more detailed planning templates
- ⚠️ CONSIDER: moai /alfred:1-plan if you want SPEC-First methodology

#### 5. Language Style Rules
**Conflict:** Different style philosophies
- agentic-coding-main: Australian English MANDATORY
- claude-code-stuff-main: American English, specific Swift rules
- moai-adk-main: Configurable (Korean/English)

**Resolution:**
- ✅ SKIP: Australian English requirement (you don't need this)
- ✅ EVALUATE: Swift rules if you use Swift
- ✅ USE: Standard American English

#### 6. Git Workflows
**Conflict:** Different git approaches
- obra/superpowers: using-git-worktrees, finishing-a-development-branch
- agentic-coding-main: Manual git rules, NEVER auto-commit/push
- claude-code-stuff-main: Git workflow guidance in rules
- moai-adk-main: Auto-checkpoint system, personal vs team strategies

**Resolution:**
- ✅ KEEP: obra/superpowers git-worktrees (excellent practice)
- ✅ ADD: moai auto-checkpoint (safety net, doesn't conflict)
- ❌ SKIP: agentic-coding strict "NEVER push" rule (too restrictive)

---

## Phase 5: Recommended Additions (Non-Conflicting)

### Tier 1: High Value, Zero Conflict

These add significant value without duplicating superpowers:

#### From claude-code-stuff-main:
1. **Search Agent (Haiku-based)** - NEW CAPABILITY
   - 40-60% cost reduction
   - Fast code location (<30s, <5K tokens)
   - Does NOT conflict with superpowers debugging
   - **Action:** Add as separate agent for cost optimization

#### From moai-adk-main (select based on your stack):
2. **Domain Skills** - NEW CAPABILITY (pick yours)
   - moai-domain-backend (if you do backend)
   - moai-domain-frontend (if you do frontend)
   - moai-domain-database (if you do DB work)
   - moai-domain-security (OWASP patterns)
   - **Action:** Add only domains you actively use

3. **Language Skills** - NEW CAPABILITY (pick yours)
   - moai-lang-python (if Python)
   - moai-lang-typescript (if TypeScript)
   - moai-lang-go (if Go)
   - **Action:** Add only languages in your stack

4. **BaaS Platform Skills** - NEW CAPABILITY (if you use them)
   - moai-baas-supabase (if using Supabase)
   - moai-baas-vercel (if using Vercel)
   - moai-baas-cloudflare (if using Cloudflare Workers)
   - **Action:** Add only platforms you actively deploy to

5. **Performance Skills** - COMPLEMENTS superpowers
   - moai-essentials-perf (AI-powered performance optimization)
   - Does NOT conflict with systematic-debugging
   - **Action:** Add if performance work is common

6. **Auto-Checkpoint System** - SAFETY NET
   - moai-adk-main's pre-tool hook for auto-checkpoints
   - Does NOT conflict with superpowers git workflows
   - Adds safety without changing workflow
   - **Action:** Add as pre-commit hook

### Tier 2: Moderate Value, Evaluate Need

These are useful but may not be needed:

#### From agentic-coding-main:
7. **MCP Builder Skill** - NEW CAPABILITY
   - Only if you're building MCP servers
   - Comprehensive guide for FastMCP/Node
   - **Action:** Add only if doing MCP development

8. **Document Skills** - NEW CAPABILITY
   - docx, pdf, pptx processing
   - Only if document-heavy work
   - **Action:** Add only if you work with documents

9. **Artifacts Builder** - NEW CAPABILITY
   - React + Tailwind + shadcn components
   - Only if building claude.ai artifacts
   - **Action:** Add only if creating artifacts

#### From moai-adk-main:
10. **Context7 MCP Integration** - NEW CAPABILITY
    - Latest API documentation via MCP
    - Requires MCP setup
    - **Action:** Add if you want latest docs integration

11. **SPEC-First Workflow** - METHODOLOGY CHANGE
    - /alfred:1-plan, /alfred:2-run, /alfred:3-sync
    - Complete methodology shift
    - **Action:** Phase 2 consideration (major change)

### Tier 3: Low Priority / Skip

These are either duplicates or not generally useful:

#### Skip (Already in Superpowers):
- ❌ agentic-coding-main: systematic-debugging (duplicate)
- ❌ agentic-coding-main: skill-creator (obra has writing-skills)
- ❌ Any TDD skills outside superpowers

#### Skip (Not Needed):
- ❌ Australian English enforcement
- ❌ Swift-specific rules (unless you use Swift)
- ❌ Languages you don't use
- ❌ Platforms you don't deploy to

---

## Phase 6: Proposed Configuration Structure

### Recommended Directory Structure

```
~/.claude/
├── agents/
│   ├── search.md                    # NEW: From claude-code-stuff-main (Haiku cost optimization)
│   ├── code-reviewer.md             # EXISTING: From superpowers
│   └── [domain-expert].md           # NEW: Add if needed (backend, frontend, etc.)
│
├── skills/
│   ├── superpowers/                 # EXISTING: Your current 19 skills (KEEP ALL)
│   │   ├── test-driven-development/
│   │   ├── systematic-debugging/
│   │   ├── using-git-worktrees/
│   │   └── ... (16 more)
│   │
│   ├── domain/                      # NEW: Domain-specific (pick yours)
│   │   ├── backend/                 # If you do backend
│   │   ├── frontend/                # If you do frontend
│   │   └── security/                # OWASP patterns
│   │
│   ├── languages/                   # NEW: Language-specific (pick yours)
│   │   ├── python/                  # If Python
│   │   ├── typescript/              # If TypeScript
│   │   └── go/                      # If Go
│   │
│   ├── baas/                        # NEW: Platform integration (if used)
│   │   ├── supabase/                # If using Supabase
│   │   └── vercel/                  # If using Vercel
│   │
│   ├── performance/                 # NEW: Performance optimization
│   │   └── moai-essentials-perf/
│   │
│   └── optional/                    # NEW: Special use cases
│       ├── mcp-builder/             # If building MCP servers
│       ├── document-skills/         # If document processing
│       └── artifacts-builder/       # If building artifacts
│
├── hooks/
│   ├── pre-tool-auto-checkpoint.py  # NEW: From moai-adk-main (safety net)
│   └── session-start.sh             # EXISTING: From superpowers
│
├── rules/                           # NEW: Modular rules (from claude-code-stuff-main pattern)
│   ├── 0-core-principles.md         # Quality over speed, verification required
│   ├── cost-optimization.md         # When to use Haiku vs Sonnet
│   ├── git-workflow.md              # Your preferred git patterns
│   └── [domain-specific].md         # Add as needed
│
├── CLAUDE.md                        # Compiled from rules/ (or manually maintained)
└── settings.json                    # Tool permissions, hooks, MCP servers
```

---

## Phase 7: Implementation Plan

### Phase 1A: Cost Optimization (Week 1) - HIGH PRIORITY

**Goal:** Reduce Claude Code costs by 40-60% without changing workflow

**Actions:**
1. Add search agent from claude-code-stuff-main
2. Create rules/cost-optimization.md with model selection guidance
3. Test with code location tasks
4. Measure token usage before/after

**Files to Add:**
- `agents/search.md` (Haiku-based, fast code location)
- `rules/cost-optimization.md` (when to use Haiku vs Sonnet)

**Validation:**
- Run 10 search tasks, measure tokens (target: <5K per search)
- Compare to previous approach (likely 15-30K tokens)

### Phase 1B: Safety Net (Week 1) - HIGH PRIORITY

**Goal:** Add auto-checkpoint without disrupting superpowers workflow

**Actions:**
1. Add pre-tool auto-checkpoint hook from moai-adk-main
2. Configure for dangerous operations (delete, refactor, merge)
3. Test with intentional breaking change

**Files to Add:**
- `hooks/pre-tool-auto-checkpoint.py`
- Update `settings.json` with hook configuration

**Validation:**
- Delete a file, verify checkpoint created
- Verify no impact on normal edit operations

### Phase 2: Domain & Language Skills (Week 2-3) - MEDIUM PRIORITY

**Goal:** Add domain expertise for your specific stack

**Prerequisites:** Complete language/platform checklist above

**Actions (based on YOUR stack - customize this):**

**Example for Full-Stack TypeScript Developer:**
1. Add moai-lang-typescript
2. Add moai-domain-backend
3. Add moai-domain-frontend
4. Add moai-domain-database
5. Add moai-domain-security (OWASP)

**Example for Python Backend Developer:**
1. Add moai-lang-python
2. Add moai-domain-backend
3. Add moai-domain-database
4. Add moai-domain-cloud (if deploying)

**Example for Go Microservices Developer:**
1. Add moai-lang-go
2. Add moai-domain-backend
3. Add moai-domain-cloud
4. Add moai-domain-devops (Docker/Kubernetes)

**Validation:**
- Try a typical feature implementation in your stack
- Verify skills activate appropriately
- Check for conflicts with superpowers TDD

### Phase 3: Platform Integration (Week 4) - OPTIONAL

**Goal:** Add BaaS platform skills if you use them

**Actions (only if applicable):**
1. Identify which platforms you actually use
2. Add corresponding moai-baas-* skills
3. Configure any MCP integrations

**Example Platforms:**
- Supabase user? Add moai-baas-supabase
- Vercel user? Add moai-baas-vercel
- Cloudflare Workers? Add moai-baas-cloudflare

**Validation:**
- Deploy to platform using skill guidance
- Verify patterns match your architecture

### Phase 4: Specialized Capabilities (Future) - LOW PRIORITY

**Goal:** Add specialized skills as needs arise

**Consider Later:**
- MCP server development → mcp-builder skill
- Document processing → document-skills
- Artifact creation → artifacts-builder
- SPEC-First methodology → moai /alfred workflow (major change)

**Validation:**
- Only add when you have concrete use case
- Test thoroughly before committing

---

## Phase 8: Configuration Principles

### Core Principles (Non-Negotiable)

1. **Superpowers is Foundation**
   - NEVER remove or replace superpowers skills
   - Build around them, don't duplicate
   - When in doubt, keep superpowers version

2. **Single Responsibility**
   - Each skill does ONE thing well
   - No overlapping capabilities
   - Clear activation triggers

3. **Cost-Conscious**
   - Use Haiku for simple tasks (search, location)
   - Use Sonnet for complex reasoning
   - Measure token usage regularly

4. **Quality First**
   - Keep verification-before-completion
   - Keep test-driven-development
   - Keep systematic-debugging
   - Add domain quality gates as needed

5. **Progressive Adoption**
   - Start with Phase 1A (cost optimization)
   - Add domain skills gradually
   - Measure impact at each step
   - Don't add everything at once

### Quality Gates for New Skills

Before adding ANY skill, verify:

- [ ] Does NOT duplicate existing superpowers skill
- [ ] Does NOT conflict with superpowers principles
- [ ] Provides clear, unique value
- [ ] Has well-defined activation triggers
- [ ] Documentation is clear (read SKILL.md completely)
- [ ] You will actually use it (not just "nice to have")
- [ ] Fits your language/platform stack

### Red Flags (Skip These)

- ❌ Requires different testing philosophy than TDD
- ❌ Conflicts with systematic debugging approach
- ❌ Duplicates existing functionality
- ❌ Language/platform you don't use
- ❌ Too complex for actual need
- ❌ Mandatory style rules you don't want (Australian English)

---

## Phase 9: Specific Recommendations

### Must-Add (Everyone)

These provide universal value without conflicts:

1. ✅ **Search agent (Haiku)** - 40-60% cost savings
2. ✅ **Auto-checkpoint hook** - Safety net for dangerous operations
3. ✅ **Domain security skill** - OWASP patterns (if you write production code)

### Highly Recommended (Most Developers)

Add based on your stack:

4. ✅ **Your primary language skill** - Language-specific best practices
5. ✅ **Your primary domain skill** - Backend, frontend, or database
6. ✅ **Performance optimization** - If performance work is common

### Optional (Special Use Cases)

Add only if you have specific need:

7. ⚠️ **BaaS platform skills** - Only if you use that platform
8. ⚠️ **MCP builder** - Only if building MCP servers
9. ⚠️ **Document skills** - Only if document-heavy work
10. ⚠️ **SPEC-First workflow** - Major methodology change, evaluate carefully

---

## Phase 10: obra Superpowers - Where to Build Around It

### What Superpowers Owns (Don't Touch)

**Core Engineering Practices:**
- ✅ TDD methodology (test-driven-development)
- ✅ Debugging process (systematic-debugging, root-cause-tracing)
- ✅ Code review (requesting/receiving-code-review)
- ✅ Git workflows (using-git-worktrees, finishing-a-development-branch)
- ✅ Verification (verification-before-completion)
- ✅ Planning (writing-plans, executing-plans)

**Why These Are Excellent:**
- Battle-tested by community
- Well-documented
- Single responsibility
- Proven effectiveness
- Regular updates from obra

**Your Action:** Keep using these, don't replace

### Where to Enhance Superpowers

**Cost Layer (NEW):**
- Superpowers doesn't optimize for cost
- ADD: Search agent (Haiku) for code location
- ADD: Model selection rules
- **Result:** 40-60% cost reduction without changing practices

**Domain Layer (NEW):**
- Superpowers is domain-agnostic
- ADD: Backend/frontend/database skills for your stack
- ADD: Security patterns (OWASP)
- **Result:** Domain expertise without conflicting with TDD/debugging

**Language Layer (NEW):**
- Superpowers is language-agnostic
- ADD: Python/TypeScript/Go skills for your languages
- **Result:** Language best practices without conflicting with TDD

**Platform Layer (NEW):**
- Superpowers doesn't cover BaaS platforms
- ADD: Supabase/Vercel/Cloudflare skills if you use them
- **Result:** Platform expertise for deployment

**Safety Layer (NEW):**
- Superpowers has verification, but no auto-backup
- ADD: Auto-checkpoint hook
- **Result:** Safety net for mistakes

### Where New Approaches Are Substantially Better

#### 1. Cost Optimization
**Superpowers:** No cost optimization
**claude-code-stuff-main:** Search agent (Haiku) = 40-60% savings
**Winner:** claude-code-stuff-main search agent
**Action:** ADD search agent, keep superpowers debugging

#### 2. Domain Expertise
**Superpowers:** Generic practices
**moai-adk-main:** 30+ domain skills (backend, frontend, database, security)
**Winner:** moai-adk-main domain skills
**Action:** ADD domain skills for your stack, keep superpowers TDD

#### 3. Language Best Practices
**Superpowers:** Language-agnostic
**moai-adk-main:** 18 language-specific skills
**Winner:** moai-adk-main language skills
**Action:** ADD your language skills, keep superpowers TDD

#### 4. Safety/Checkpoints
**Superpowers:** Verification before completion (manual)
**moai-adk-main:** Auto-checkpoint (automatic)
**Winner:** BOTH - complementary
**Action:** ADD auto-checkpoint hook, keep verification skill

#### 5. BaaS Platform Integration
**Superpowers:** Not covered
**moai-adk-main:** 12 platform skills
**Winner:** moai-adk-main (only option)
**Action:** ADD if you use BaaS platforms

#### 6. Documentation/Artifacts
**Superpowers:** Not covered
**agentic-coding-main:** Comprehensive document skills, artifact builder
**Winner:** agentic-coding-main (only option)
**Action:** ADD only if document-heavy work

### Integration Strategy with Superpowers

**Layers that Stack Well:**

```
┌─────────────────────────────────────┐
│   Platform Layer (moai BaaS)        │  ← ADD: Only platforms you use
├─────────────────────────────────────┤
│   Language Layer (moai-lang-*)      │  ← ADD: Only your languages
├─────────────────────────────────────┤
│   Domain Layer (moai-domain-*)      │  ← ADD: Only your domains
├─────────────────────────────────────┤
│   Cost Layer (search agent)         │  ← ADD: Universal benefit
├─────────────────────────────────────┤
│   Safety Layer (auto-checkpoint)    │  ← ADD: Safety net
├─────────────────────────────────────┤
│   obra/superpowers Foundation       │  ← KEEP: Don't change
│   (TDD, debugging, git, verification)│
└─────────────────────────────────────┘
```

**Key Insight:** Everything above superpowers is ADDITIVE, not REPLACEMENT

---

## Phase 11: Decision Checklist

Before finalizing your configuration, answer these:

### Your Development Profile

**Primary Languages (check all that apply):**
- [ ] Python
- [ ] TypeScript/JavaScript
- [ ] Go
- [ ] Java
- [ ] C#/F#
- [ ] Other: _______________

**Primary Domains (check all that apply):**
- [ ] Backend APIs
- [ ] Frontend web apps
- [ ] Database design
- [ ] Mobile development
- [ ] DevOps/Infrastructure
- [ ] Security
- [ ] Machine Learning
- [ ] Other: _______________

**Platforms You Deploy To:**
- [ ] Supabase
- [ ] Vercel
- [ ] Cloudflare
- [ ] Firebase
- [ ] AWS/GCP/Azure (raw cloud)
- [ ] Other: _______________

**Special Needs:**
- [ ] Document processing (docx, pdf, pptx)
- [ ] MCP server development
- [ ] Artifact creation (React components)
- [ ] Cost optimization critical
- [ ] Performance optimization frequent
- [ ] Security compliance required (OWASP, etc.)

### Recommended Configuration Based on Profile

**Example 1: Full-Stack TypeScript Developer on Vercel**
```
Base: obra/superpowers (19 skills)
Add:
- agents/search.md (cost optimization)
- skills/languages/typescript/
- skills/domain/backend/
- skills/domain/frontend/
- skills/domain/security/
- skills/baas/vercel/
- hooks/pre-tool-auto-checkpoint.py

Result: 19 + 6 + 1 agent + 1 hook = Focused, cost-effective setup
```

**Example 2: Python Backend Developer on Supabase**
```
Base: obra/superpowers (19 skills)
Add:
- agents/search.md (cost optimization)
- skills/languages/python/
- skills/domain/backend/
- skills/domain/database/
- skills/domain/security/
- skills/baas/supabase/
- skills/performance/moai-essentials-perf/
- hooks/pre-tool-auto-checkpoint.py

Result: 19 + 7 + 1 agent + 1 hook = Backend-optimized setup
```

**Example 3: Go Microservices Developer on Kubernetes**
```
Base: obra/superpowers (19 skills)
Add:
- agents/search.md (cost optimization)
- skills/languages/go/
- skills/domain/backend/
- skills/domain/cloud/
- skills/domain/devops/
- skills/domain/security/
- skills/performance/moai-essentials-perf/
- hooks/pre-tool-auto-checkpoint.py

Result: 19 + 7 + 1 agent + 1 hook = Microservices-optimized setup
```

---

## Phase 12: Next Steps

### Immediate Actions (This Week)

1. **Complete the checklists** in Phase 11
2. **Identify your profile** (languages, domains, platforms)
3. **Review Phase 1A** (cost optimization) - universal benefit
4. **Review Phase 1B** (auto-checkpoint) - safety net

### Week 1 Implementation

1. Create directory structure (Phase 6)
2. Add search agent (Phase 1A)
3. Add auto-checkpoint hook (Phase 1B)
4. Test cost optimization with 10 tasks
5. Measure results

### Week 2-3 Implementation

1. Add language skills for YOUR stack
2. Add domain skills for YOUR work
3. Add platform skills for YOUR deployments
4. Test integration with superpowers
5. Verify no conflicts

### Week 4+ Maintenance

1. Monitor token usage and costs
2. Review skill utilization
3. Remove unused skills
4. Add new skills as needs arise
5. Update skills quarterly

### Questions to Answer Before Starting

1. What languages do you code in daily? (Will inform language skills)
2. What platforms do you deploy to? (Will inform BaaS skills)
3. What % of your work is backend vs frontend vs database? (Will inform domain skills)
4. Do you work with documents (docx, pdf)? (Will inform document skills)
5. Are you building MCP servers? (Will inform MCP builder)
6. Is cost optimization important? (Almost certainly yes)

---

## Phase 13: Output Format

Once you've made decisions, I'll create:

1. **CUSTOM_CONFIGURATION_PLAN.md** - Your specific plan
   - Exact skills to add
   - Directory structure
   - Implementation timeline
   - Installation commands

2. **MIGRATION_GUIDE.md** - Step-by-step migration
   - How to add new skills without breaking superpowers
   - Testing procedures
   - Rollback plan if issues arise

3. **SKILLS_INVENTORY.md** - Your final skill list
   - All skills with descriptions
   - Activation triggers
   - When to use each
   - Conflicts to watch for

---

## Summary

**Current State:** obra/superpowers (19 excellent engineering practice skills)

**Gaps:**
- Cost optimization
- Domain expertise (backend, frontend, database, security)
- Language-specific best practices
- BaaS platform integration
- Auto-checkpoint safety net

**Recommended Additions:**
- **Universal:** Search agent (Haiku), auto-checkpoint hook
- **Based on stack:** Language skills, domain skills
- **Based on platforms:** BaaS platform skills
- **Special cases:** MCP builder, document skills, artifacts

**Non-Negotiables:**
- Keep ALL 19 superpowers skills
- No duplicates or conflicts
- Progressive adoption (Phase 1A, 1B, 2, 3, 4)
- Measure impact at each phase

**Next Step:** Complete the checklists in Phase 11 so I can create your custom configuration plan.
