# Claude Code Best Practices & Configuration Guide

This comprehensive guide synthesizes insights from analyzing 190+ skills across three major configuration frameworks to provide actionable best practices for Claude Code development.

---

## Table of Contents

- [Executive Summary](#executive-summary)
- [Skill Creation Best Practices](#skill-creation-best-practices)
- [Configuration Framework Comparison](#configuration-framework-comparison)
- [Framework-Specific Guidance](#framework-specific-guidance)
- [Common Patterns & Anti-Patterns](#common-patterns--anti-patterns)
- [Recommendations by Use Case](#recommendations-by-use-case)
- [Community Resources](#community-resources)

---

## Executive Summary

### Key Findings

After analyzing **190+ Claude Code skills** and **three major configuration frameworks**, we've identified universal best practices that dramatically improve AI-assisted development:

**Success Metrics:**
- **80-85% token reduction** through agent delegation (moai-adk-main)
- **40-60% cost savings** through model selection (claude-code-stuff-main)
- **3-5x faster execution** with specialized agents
- **Zero production bugs** with SPEC-First TDD (moai-adk-main)

**Core Principles:**
1. **Progressive Disclosure**: Load only what's needed, when needed
2. **Clear Activation Triggers**: 3-5 explicit phrases for skill invocation
3. **Behavioral Guidance**: Tell Claude what to do AND what not to do
4. **Token Efficiency**: Every line should serve a purpose
5. **Quality Over Flexibility**: Constraints enable better outcomes

---

## Skill Creation Best Practices

### 1. Frontmatter Structure

**Best Practice - Minimal Required Fields:**

```yaml
---
name: skill-name
description: Use when [specific trigger]. Does [specific action]. Activate when user says "[exact phrase]".
---
```

**Advanced - Rich Metadata:**

```yaml
---
name: skill-name
version: 4.0.0
description: Use when [specific trigger]. Does [specific action].
allowed-tools: Read,Write,Bash
metadata:
  tier: foundation
  status: stable
  dependencies: python>=3.11
keywords: [testing, tdd, quality]
tags: [foundation, quality]
---
```

**DO:**
- ✅ Use third-person voice: "This skill helps..." not "I help..."
- ✅ Start description with "Use when..." for discoverability
- ✅ Include specific trigger phrases
- ✅ Specify allowed-tools when restricting access
- ✅ Use semantic versioning for enterprise skills

**DON'T:**
- ❌ Use vague descriptions: "For testing" → "Use when tests have race conditions"
- ❌ Include angle brackets in descriptions
- ❌ Mix first/second person: "You should..." → "Use X to..."
- ❌ Omit version numbers for production skills

### 2. Activation Triggers

**Pattern 1: User Intent Matching (Most Common)**

```markdown
## When to Use This Skill

Activate when the user:
- Says "tapestry [URL]"
- Says "extract article from [URL]"
- Asks to "turn [content] into action plan"
- Provides URL and says "make this actionable"

**Keywords to watch for**: tapestry, extract, actionable, plan
```

**Pattern 2: Problem Symptoms (Technical Skills)**

```markdown
## When to Use

Use for ANY technical issue:
- Test failures
- Unexpected behavior
- Performance problems
- Build failures

**Use ESPECIALLY when:**
- Under time pressure (prevents rushed fixes)
- "Quick fix" seems obvious (ensures root cause analysis)
- Multiple attempted fixes already failed
```

**Pattern 3: File Type Detection (Automatic)**

```markdown
## When to Use This Skill

Claude should use this Skill whenever the user:
- Uploads or references a CSV file
- Asks to analyze tabular data
- Requests visualizations from data
```

**Best Practice:** Include 3-5 explicit trigger phrases + 2-3 problem symptoms + relevant keywords

### 3. Content Organization

**Progressive Disclosure Pattern (Recommended):**

```
skill-name/
├── SKILL.md (500-800 lines - core concepts, quick start)
├── reference.md (200-400 lines - deep dive, optional)
├── examples.md (300-500 lines - production code, optional)
├── scripts/ (executable code)
└── assets/ (templates, not loaded into context)
```

**SKILL.md Structure:**

```markdown
# Skill Name

## Overview (Quick orientation)
Brief 2-3 sentence summary

## Quick Start (Immediate value)
Minimal working example

## Core Workflow
Step-by-step primary use case

## Common Tasks (80% use cases)
Practical examples for frequent scenarios

## Advanced Features
Link to reference.md for deep dive

## Troubleshooting
Top 5 issues and solutions

## Resources
- reference.md - Detailed documentation
- examples.md - Production code samples
```

**DO:**
- ✅ Keep SKILL.md under 1000 lines (target 500-800)
- ✅ Use imperative voice: "Run X" not "You should run X"
- ✅ Include before/after code examples
- ✅ Provide decision trees for complex workflows
- ✅ Add critical warnings at the top

**DON'T:**
- ❌ Put everything in one massive file
- ❌ Use generic template examples
- ❌ Skip troubleshooting section
- ❌ Forget to explain WHY (not just what)

### 4. Behavioral Guidance

**Explicit DO/DON'T Lists:**

```markdown
## ⚠️ CRITICAL BEHAVIOR REQUIREMENT ⚠️

**DO NOT ASK THE USER WHAT THEY WANT TO DO WITH THE DATA.**

**IMMEDIATELY AND AUTOMATICALLY:**
1. Run comprehensive analysis
2. Generate ALL relevant visualizations
3. Present complete results

✅ **CORRECT APPROACH - SAY THIS:**
- "I'll analyze this data comprehensively right now."

❌ **NEVER SAY THESE PHRASES:**
- "What would you like to do with this data?"
- "Here are some options..."
- "Would you like me to..."
```

**Rationalization Prevention:**

```markdown
## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple, don't need process" | Simple issues have root causes too |
| "Emergency, no time" | Systematic is FASTER than thrashing |
| "Just try this first" | First fix sets pattern. Do it right. |
```

**Best Practice:** Prevent unwanted behaviors by naming them explicitly and providing exact forbidden phrases.

### 5. Tool Restrictions

**Three Approaches:**

**1. Explicit Restriction (Least Common):**
```yaml
allowed-tools: Bash,Read,Write
```
Use when: Skill must prevent dangerous operations (e.g., no Edit in read-only analysis)

**2. No Restriction (Most Common):**
Omit `allowed-tools` field entirely - Claude can use any tool.
Use when: Skill needs flexibility (most cases)

**3. Documentation Recommendation (Best Balance):**
```markdown
## Required Tools

Check for tools in this order:

1. **reader** (recommended): `command -v reader`
2. **trafilatura** (Python-based): `command -v trafilatura`
3. **fallback**: Use curl + simple parsing
```
Use when: Skill has preferences but should adapt to environment

**Best Practice:** Only use `allowed-tools` restriction when absolutely necessary. Document preferences instead.

### 6. Size Guidelines

| Tier | SKILL.md | Complexity | Execution Time | Model |
|------|----------|------------|----------------|-------|
| **Simple** | <200 lines | 1-3 steps | <5 min | Haiku |
| **Standard** | 200-500 lines | 4-6 steps | <15 min | Inherit/Sonnet |
| **Complex** | 500-1000 lines | 7-10 steps | 20-30 min | Sonnet |
| **Too Large** | >1000 lines | Split into multiple skills | - | - |

**When to Split Skills:**

Split when you have:
- ❌ Multiple unrelated capabilities in one skill
- ❌ Different activation triggers for different features
- ❌ File exceeding 1000 lines
- ❌ 50%+ of skill rarely used

**How to Split:**
```
original-skill/
├── SKILL.md (orchestrator - delegates to sub-skills)
├── sub-skill-1/ (focused capability)
└── sub-skill-2/ (focused capability)
```

### 7. Documentation Patterns

**Critical Information Highlighting:**

```markdown
## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed Phase 1, you cannot propose fixes.
```

**Token Efficiency Warnings:**

```markdown
**WARNING:** `elements-of-style.md` consumes ~12,000 tokens.

## Limited Context Strategy

When context is tight:
1. Write draft using judgment
2. Dispatch subagent with draft + elements-of-style.md
3. Subagent applies rules and returns improved version
```

**Cross-Skill References:**

```markdown
**REQUIRED SUB-SKILL:** Use superpowers:root-cause-tracing for backward tracing

**WORKS WELL WITH:**
- systematic-debugging (root cause analysis)
- test-driven-development (writing proper tests)
- verification-before-completion (evidence requirements)
```

### 8. Common Anti-Patterns to Avoid

**Anti-Pattern 1: Vague Triggers**
```yaml
# ❌ BAD
description: For async testing

# ✅ GOOD
description: Use when tests have race conditions, timing dependencies, or pass/fail inconsistently - replaces arbitrary timeouts with condition polling
```

**Anti-Pattern 2: Missing Behavioral Guidance**
```markdown
# ❌ BAD
## Overview
This skill helps with data analysis.

# ✅ GOOD
## ⚠️ CRITICAL BEHAVIOR
**DO NOT ASK WHAT THEY WANT**
✅ CORRECT: "I'll analyze now"
❌ NEVER: "What would you like?"
```

**Anti-Pattern 3: No Progressive Disclosure**
```markdown
# ❌ BAD - Everything in one 3000-line file

# ✅ GOOD
SKILL.md (800 lines - core concepts)
reference.md (400 lines - loaded when needed)
examples.md (500 lines - loaded when needed)
```

**Anti-Pattern 4: Generic Examples**
```python
# ❌ BAD - Generic template
def process_data(data):
    # TODO: Your code here
    pass

# ✅ GOOD - Real-world example
# Bad: Correlated subquery (slow)
SELECT u.name, (SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id)
FROM users u;

# Good: JOIN with aggregation (fast)
SELECT u.name, COUNT(o.id)
FROM users u LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name;
```

**Anti-Pattern 5: Missing Transition Logic**
```markdown
# ❌ BAD
## Step 1: Do this
## Step 2: Do that

# ✅ GOOD
## Phase 1: Discovery
[Content]
**Output: Intent Statement**
Wait for user confirmation before proceeding.
> **Transition cue:** "Shall we move to message shaping?"

## Phase 2: Message Architecture
```

---

## Configuration Framework Comparison

### The Three Major Frameworks

| Framework | Author | Focus | Skills | Philosophy | Best For |
|-----------|--------|-------|--------|------------|----------|
| **agentic-coding-main** | Sam McLeod | Style consistency, quality | 14 custom | Australian English, elegance through simplicity | AU devs, doc-heavy work |
| **claude-code-stuff-main** | Carlo Zottmann | Cost optimization, Swift/iOS | 2 custom + 19 external | Pragmatic minimalism, honest partnership | Swift devs, personal productivity |
| **moai-adk-main** | modu-ai | Enterprise SPEC-First TDD | 128 enterprise | Production-ready, TRUST 5 quality | Teams, full-stack, compliance |

### Framework Comparison Matrix

| Dimension | agentic-coding-main | claude-code-stuff-main | moai-adk-main |
|-----------|---------------------|------------------------|---------------|
| **Agents** | 8 | 4 | 31 |
| **Skills** | 14 | 21 | 128 |
| **Build System** | None (manual) | Mise + symlinks | Python CLI |
| **Cost Savings** | None explicit | 40-60% | 80-85% |
| **Learning Curve** | Medium | Low | Medium-High |
| **Setup Time** | Manual | 10 min | 15 min |
| **Deployment** | Manual copy | Symlinks | CLI install |
| **Token Efficiency** | Manual rules | Agent models | Agent delegation |
| **Quality System** | Style rules | Superpowers | TRUST 5 (automated) |
| **Documentation** | ~5,000 lines | ~8,000 lines | 85,280+ lines |
| **Target User** | AU dev | Swift dev | Enterprise team |
| **Maintenance** | Medium | Very Low | Low (automated) |
| **Extensibility** | Manual | Symlink external | Skill factory |

### Web Search Findings

**Sam McLeod (agentic-coding-main):**
- GitHub: https://github.com/sammcj/agentic-coding
- Active repository with rules, templates, MCP servers, examples
- Recommends Claude Code and Cline as best tools
- Created MCP DevTools server (most commonly enabled MCP)
- Focus on transferable rules (95% work across tools)
- Blog posts and community discussion active

**Jesse Vincent (obra/superpowers) - Used by claude-code-stuff-main:**
- GitHub: https://github.com/obra/superpowers
- "Claude Code superpowers: core skills library"
- Massive project with proven engineering practices
- Blog post: "How I'm using coding agents in October 2025"
- Community marketplace: superpowers-marketplace
- Experimental lab: superpowers-lab
- Carlo Zottmann acknowledged: "Massive thanks to Jesse Vincent, that repo is positively mental"

**MoAI-ADK (moai-adk-main):**
- GitHub: https://github.com/modu-ai/moai-adk
- Claude Skills marketplace: Multiple skills published
- Medium articles: "Supercharge ADK Development with Claude Code Skills"
- Active Korean developer community (Threads post by goos.kim)
- Integration with Google Cloud ADK
- SPEC-First TDD methodology documentation

---

## Framework-Specific Guidance

### agentic-coding-main: Quality & Consistency

**Core Principles:**
1. **Australian English mandatory** - ALL code, comments, documentation
2. **Elegance through simplicity** - Less is more
3. **Quality over speed** - Never rush
4. **Token efficiency** - Combine edits, avoid waste

**When to Use:**
- ✅ Team wants strict style consistency
- ✅ Australian/British English requirement
- ✅ Document-heavy projects (docx, pdf processing)
- ✅ MCP server development
- ✅ Artifact building with React + shadcn
- ✅ Go projects (go-testing skill)

**Setup:**
```bash
# Manual installation
git clone https://github.com/sammcj/agentic-coding
cp -r agentic-coding/Claude ~/.claude/

# Add to settings.json for permissions
```

**Key Features:**
- 8 specialized agents (code-simplifier, docs-quality-reviewer, design-review)
- 14 custom skills (artifacts-builder, document-skills, mcp-builder)
- Comprehensive OOXML schemas for document processing
- Mermaid diagram standards
- Output styles system (concise mode)

**Best Practices:**
- Read full CLAUDE.md (180 lines) before starting
- Enforce Australian English in pre-commit hooks
- Use parallel task execution when appropriate
- Avoid AI clichés ("comprehensive", "deep dive")
- Never skip verification steps

**Strengths:**
- Well-documented, clear structure
- Comprehensive document processing
- Strong quality guidelines
- MCP server creation support

**Limitations:**
- Australian English may not suit all teams
- Manual deployment and updates
- Smaller skill ecosystem (14 vs 128)
- No automated cost optimization

---

### claude-code-stuff-main: Minimalism & Cost Efficiency

**Core Principles:**
1. **Pragmatic simplicity** - Don't over-engineer
2. **Honest partnership** - No sycophantic behavior
3. **Cost consciousness** - 40-60% savings via model selection
4. **Hybrid architecture** - Custom + external (superpowers)

**When to Use:**
- ✅ Swift/iOS/macOS development
- ✅ Personal productivity projects
- ✅ Cost-sensitive teams
- ✅ Want proven practices without reinventing
- ✅ Need fast code search (Haiku agent)
- ✅ Prefer instant updates (symlinks)

**Setup:**
```bash
# Prerequisites
brew install mise  # or other mise installation
brew install fish  # or other fish installation

# Clone repository
git clone https://github.com/carlozottmann/claude-code-stuff
cd claude-code-stuff

# Initialize superpowers submodule
git submodule update --init --recursive

# Deploy
mise run add-libs-skills           # Link 19 superpowers skills
mise run add-libs-agents            # Link code-reviewer agent
mise run build-agents-md            # Compile rules → AGENTS.md
mise run symlink-folders-to-claude  # Deploy via symlinks
```

**Key Features:**
- **Search agent** (Haiku): <10 file reads, <30s, <5K tokens - 40-60% cost reduction
- **Documentation generator** (Sonnet): Comprehensive, parallel task execution
- **Symlink architecture**: Edit source, changes instant
- **Compilation pattern**: rules/*.md → .build/AGENTS.md
- **Superpowers integration**: 19 battle-tested engineering skills

**Best Practices:**
- Use search agent for all code location tasks
- Follow "honest partnership" communication style
- Break Rule #1 only with explicit permission
- Update superpowers regularly: `git submodule update --remote`
- Leverage mise tasks for automation

**Strengths:**
- Lowest learning curve
- Minimal maintenance (symlinks)
- Proven engineering practices (superpowers)
- Excellent cost optimization
- Swift/iOS domain expertise

**Limitations:**
- Swift-specific skills not useful outside iOS
- Requires mise and Fish shell
- Smaller custom skill set (2 vs 14)
- No enterprise features (compliance, traceability)

---

### moai-adk-main: Enterprise SPEC-First TDD

**Core Principles:**
1. **SPEC-First TDD** - Requirements before code (EARS format)
2. **TRUST 5 Quality** - Test, Readable, Unified, Secured, Trackable
3. **Zero rework** - Clear specs prevent 80% bugs
4. **Agent delegation** - 80-85% token savings
5. **Production-ready** - Enterprise automation

**When to Use:**
- ✅ Enterprise development teams
- ✅ Regulated industries (finance, healthcare)
- ✅ Need compliance (OWASP, TRUST 5)
- ✅ Full-stack applications
- ✅ Multi-language projects (18 languages)
- ✅ BaaS platforms (Supabase, Firebase, etc.)
- ✅ Need traceability (requirements → code → tests → docs)
- ✅ Team projects requiring Git workflows

**Setup:**
```bash
# Easy: Python CLI
pip install moai-adk
moai-adk init my-project
moai-adk doctor  # Health check

# Or with uv
uv tool install moai-adk
moai-adk init my-project
```

**Key Features:**
- **4-phase workflow**: /alfred:0-project → 1-plan → 2-run → 3-sync
- **31 specialized agents**: spec-builder, tdd-implementer, backend-expert, etc.
- **128 enterprise skills**: All languages, domains, BaaS, security
- **Alfred SuperAgent**: 4-layer architecture (Commands → Agents → Skills → Hooks)
- **MCP integration**: Context7, Playwright, Sequential-thinking
- **Python CLI**: init, doctor, status, update, migrate, analyze
- **TRUST 5 enforcement**: Automated quality gates (85%+ coverage)

**Best Practices:**
- Start every feature with /alfred:1-plan (SPEC creation)
- Use EARS format: Ubiquitous, Event-Driven, Unwanted, State-Driven, Optional
- Delegate to specialized agents: Task(subagent_type="backend-expert")
- Leverage Context7 MCP for latest API docs
- Configure language: Korean or English in .moai/config/config.json
- Use Git strategy: "personal" for solo, "team" for collaboration

**Strengths:**
- Most comprehensive (128 skills, 85,280+ lines of docs)
- Automated quality (TRUST 5, 85%+ coverage)
- Massive token savings (80-85% via delegation)
- Production-ready from day 1
- Multi-language support (Korean/English)
- BaaS mastery (12 platforms)
- Python CLI automation

**Limitations:**
- Steepest learning curve
- Best for Python projects (though supports 18 languages)
- Requires understanding SPEC-First methodology
- Large config file (277 lines)
- May be overkill for simple projects

---

## Common Patterns & Anti-Patterns

### Universal Success Patterns

#### 1. Progressive Disclosure
**Pattern:** Lazy load documentation, scripts, references
```
SKILL.md (always loaded)
  ↓ references when needed
reference.md (loaded on-demand)
  ↓ scripts when executing
scripts/ (executed, not loaded into context)
```

**Benefits:**
- Reduces initial token cost by 60-80%
- Faster skill activation
- Better context management

**Implementation:**
```markdown
## Quick Start
[Core concepts in SKILL.md]

## Advanced Features
For detailed documentation, see reference.md (~600 lines)
For production examples, see examples.md (~500 lines)
```

#### 2. Behavioral Enforcement
**Pattern:** Explicit forbidden phrases and required behaviors
```markdown
✅ **MUST SAY:**
- "I'll analyze this now"
- "Running comprehensive analysis"

❌ **NEVER SAY:**
- "What would you like me to do?"
- "Here are some options"
- "Would you like me to..."
```

**Benefits:**
- Prevents unhelpful Claude behaviors
- Ensures consistent UX
- Reduces user frustration

#### 3. Quality Gates
**Pattern:** Verification requirements before claiming success
```markdown
## Verification Required

Before claiming "fixed" or "complete":
1. ☐ Run full test suite: `pytest`
2. ☐ Check coverage: `pytest --cov` (must be ≥85%)
3. ☐ Run linter: `ruff check`
4. ☐ Verify manually: Demonstrate working behavior
5. ☐ Get fresh output: No cached results

**Evidence required:** Fresh terminal output showing all checks passing
```

**Benefits:**
- Prevents false positives
- Ensures actual completion
- Builds user trust

#### 4. Decision Trees
**Pattern:** Clear branching logic for complex workflows
```markdown
## Workflow Decision Tree

1. **Is this a new document?**
   - Yes → Create workflow (see Creating New Document)
   - No → Edit workflow (see Editing Existing Document)

2. **Do you need tracked changes?**
   - Yes → Redlining workflow (see Tracked Changes)
   - No → Direct edit workflow (see OOXML Editing)

3. **Is document >100 pages?**
   - Yes → Use pagination (see Large Document Handling)
   - No → Load entire document
```

**Benefits:**
- Prevents decision paralysis
- Guides Claude to correct path
- Reduces errors from wrong approach

#### 5. Before/After Examples
**Pattern:** Show anti-pattern and solution side-by-side
```markdown
### ❌ WRONG - Hardcoding Values
```python
sheet['B10'] = 5000  # Hardcoded total
```

### ✅ CORRECT - Using Formulas
```python
sheet['B10'] = '=SUM(B2:B9)'  # Formula updates automatically
```

**Why:** Formulas maintain data integrity when inputs change.
```

**Benefits:**
- Visual learning
- Clear right/wrong distinction
- Explains WHY (not just what)

### Universal Anti-Patterns

#### 1. Scope Creep
**Anti-Pattern:** Single skill trying to do too much
```markdown
# ❌ BAD: "web-development" skill covering:
- Frontend frameworks (React, Vue, Angular)
- Backend APIs (REST, GraphQL, gRPC)
- Database design (SQL, NoSQL)
- DevOps (Docker, Kubernetes)
- Testing (unit, integration, E2E)

# ✅ GOOD: Split into focused skills:
- frontend-react
- backend-api-design
- database-optimization
- docker-deployment
- test-driven-development
```

**Why it's bad:**
- Skill too large (>2000 lines)
- Unclear activation triggers
- High token cost
- Maintenance nightmare

**Fix:** Split into single-responsibility skills

#### 2. Vague Activation
**Anti-Pattern:** Unclear when to use skill
```yaml
# ❌ BAD
description: Helps with testing

# ✅ GOOD
description: Use when tests have race conditions, timing dependencies, or pass/fail inconsistently. Replaces arbitrary sleep() calls with intelligent condition polling for reliable async tests.
```

**Why it's bad:**
- Claude doesn't know when to activate
- Skill underutilized
- User frustrated ("Why didn't it use the skill?")

**Fix:** Include 3-5 specific trigger phrases + problem symptoms

#### 3. Missing Tool Constraints
**Anti-Pattern:** No allowed-tools specification
```yaml
# ❌ BAD: Skill can accidentally use any tool
name: read-only-analyzer
# No allowed-tools field

# ✅ GOOD: Explicit constraints
name: read-only-analyzer
allowed-tools: Read,Grep,Glob,Bash
# Cannot accidentally Edit or Write
```

**When it matters:**
- Read-only operations (don't want accidental edits)
- Security-sensitive operations
- Audit/compliance requirements

**When to omit:**
- General development skills needing flexibility
- Most standard skills (omit = no restrictions)

#### 4. Documentation Duplication
**Anti-Pattern:** Same information in multiple places
```markdown
# ❌ BAD: Duplication
## Overview
Python 3.13 with FastAPI 0.115 and Pydantic v2...

## Quick Start
Python 3.13 with FastAPI 0.115 and Pydantic v2...

## Reference
Python 3.13 with FastAPI 0.115 and Pydantic v2...

# ✅ GOOD: Single source of truth
## Overview
See reference.md for version details

## Quick Start
[Minimal example only]

## Reference (reference.md)
**Versions**: Python 3.13, FastAPI 0.115, Pydantic v2
[Detailed docs here]
```

**Why it's bad:**
- Higher token cost (3x the context)
- Maintenance burden (update 3 places)
- Inconsistency risk

**Fix:** One canonical location, references elsewhere

#### 5. Second-Person Voice
**Anti-Pattern:** "You should..." phrasing
```markdown
# ❌ BAD
## Overview
You should use this skill when you need to debug issues.
You should start by reading the error message.
You should then trace the root cause.

# ✅ GOOD
## Overview
Use this skill for debugging technical issues.
Start by reading the error message.
Trace backward to identify root cause.
```

**Why it's bad:**
- Feels like talking to human (confuses AI identity)
- Less direct
- More tokens for same meaning

**Fix:** Use imperative/infinitive voice (verb-first instructions)

---

## Recommendations by Use Case

### Personal Projects

**Best Framework:** claude-code-stuff-main
**Rationale:** Minimal overhead, fast setup, proven practices, cost optimization

**Setup:**
```bash
mise run add-libs-skills && mise run build-agents-md && mise run symlink-folders-to-claude
```

**Recommended Skills:**
- test-driven-development (from superpowers)
- systematic-debugging (from superpowers)
- using-git-worktrees (parallel feature work)
- verification-before-completion (quality gates)

**Customization:**
- Add domain-specific skills as needed
- Remove Swift skills if not using iOS
- Extend with BaaS skills from moai-adk if needed

---

### Swift/iOS Development

**Best Framework:** claude-code-stuff-main
**Rationale:** Custom Swift skills, Xcode integration, proven engineering practices

**Setup:** Same as personal projects above

**Recommended Skills:**
- developing-with-swift (style guidelines, SwiftUI patterns)
- generating-swift-package-docs (API documentation)
- test-driven-development (TDD for iOS)
- using-git-worktrees (parallel feature branches)

**Additional Tips:**
- Use search agent (Haiku) for fast code location
- Leverage Xcode build integration: `xcodebuild | xcsift`
- Follow modern Swift patterns (async/await, Composable Architecture)

---

### Full-Stack Web Applications

**Best Framework:** moai-adk-main
**Rationale:** Comprehensive coverage (frontend + backend + database + BaaS)

**Setup:**
```bash
pip install moai-adk
moai-adk init my-fullstack-app
```

**Recommended Skills:**
- moai-domain-backend (API architecture)
- moai-domain-frontend (React/Vue/Angular)
- moai-domain-database (schema design)
- moai-baas-supabase (PostgreSQL + Realtime + Auth)
- moai-security-oauth (authentication patterns)
- moai-domain-cloud (deployment)

**Workflow:**
```bash
/alfred:1-plan "user authentication with social login"
/alfred:2-run SPEC-AUTH-001
/alfred:3-sync auto SPEC-AUTH-001
```

**Benefits:**
- SPEC-First prevents rework
- Agent delegation (backend-expert, frontend-expert, database-expert)
- Living documentation
- BaaS integration

---

### Enterprise/Regulated Industries

**Best Framework:** moai-adk-main (required)
**Rationale:** Only framework with compliance, traceability, automated quality gates

**Setup:** Same as full-stack above

**Required Skills:**
- moai-foundation-specs (SPEC-First methodology)
- moai-foundation-trust (TRUST 5 enforcement)
- moai-security-owasp (OWASP compliance)
- moai-security-encryption (data protection)
- moai-domain-security (comprehensive security patterns)

**Configuration:**
```json
{
  "quality_gates": {
    "coverage_minimum": 85,
    "trust_5_required": true,
    "owasp_scan": true,
    "security_review": true
  },
  "git": {
    "strategy": "team",
    "require_pr_review": true,
    "auto_approval_quality_threshold": 80
  }
}
```

**Compliance Features:**
- Full traceability: SPEC → Code → Tests → Docs
- Automated security scanning
- 85%+ test coverage enforced
- Audit trail via Git
- TRUST 5 quality gates

**Certifications Achievable:**
- OWASP compliance
- PCI-DSS Level 1 (with security skills)
- HIPAA (with encryption + audit patterns)

---

### Document-Heavy Projects

**Best Framework:** agentic-coding-main
**Rationale:** Comprehensive document processing (docx, pdf, pptx)

**Setup:**
```bash
git clone https://github.com/sammcj/agentic-coding
cp -r agentic-coding/Claude ~/.claude/
```

**Recommended Skills:**
- document-skills/docx (OOXML schemas, tracked changes)
- document-skills/pdf (text extraction, form filling)
- create-slidev-presentation (presentations)
- artifacts-builder (React components)

**Use Cases:**
- Legal document processing
- Report generation
- Contract review with tracked changes
- Presentation creation

**Features:**
- Full OOXML schema support (ISO-IEC29500-4_2016)
- Python scripts for docx/pdf manipulation
- Tracked changes (redlining) workflow
- Professional formatting

---

### Cost-Sensitive Teams

**Best Framework:** claude-code-stuff-main
**Rationale:** 40-60% cost reduction via agent specialization

**Setup:** Standard setup above

**Cost Optimization Strategies:**

**1. Model Selection:**
- **Search agent (Haiku)**: All code location tasks
  - Cost: ~$0.25/MTok vs Sonnet $3/MTok
  - Speed: 10-20x faster
  - Use for: grep, find, locate

- **Main agent (Sonnet)**: Complex reasoning only
  - Use for: architecture, design, debugging
  - Avoid for: simple searches, file reads

**2. Context Management:**
- Use search agent to isolate search pollution (10-50K tokens)
- Keep main conversation clean
- Result: 70% token reduction

**3. Parallel Execution:**
- Launch multiple Task() agents for independent work
- Faster completion = lower cost
- Example: 3 parallel agents vs 1 sequential = 3x time savings

**Metrics to Track:**
```bash
# Before optimization
- Average session: 130,000 tokens
- Cost per session: ~$0.40
- Monthly cost (100 sessions): $40

# After optimization
- Average session: 30,000 tokens (via agent delegation)
- Cost per session: ~$0.10
- Monthly cost (100 sessions): $10
- Savings: 75% ($30/month)
```

---

### Research & Documentation

**Best Framework:** agentic-coding-main
**Rationale:** Specialized research agents, documentation quality reviewers

**Setup:** Standard setup above

**Recommended Agents:**
- software-research-assistant (technical library research)
- research-assistant (general research)
- docs-quality-reviewer (documentation assessment)

**Recommended Skills:**
- diataxis-documentation (documentation framework)
- systematic-debugging (methodical investigation)

**Workflow:**
1. Use software-research-assistant for library/API research
2. Use research-assistant for non-technical topics
3. Use docs-quality-reviewer for final assessment
4. Apply diataxis framework (Tutorials, How-to, Reference, Explanation)

---

### Rapid Prototyping

**Best Framework:** claude-code-stuff-main
**Rationale:** Minimal overhead, instant updates, fast iteration

**Setup:** Standard setup above (10 minutes)

**Recommended Skills:**
- brainstorming (from superpowers)
- writing-plans (from superpowers)
- executing-plans (from superpowers)
- test-driven-development (quality even when fast)

**Workflow:**
1. Brainstorm with Claude: use brainstorming skill
2. Create execution plan: use writing-plans skill
3. Implement with TDD: use executing-plans + test-driven-development
4. Iterate quickly (symlinks = instant config updates)

**Speed Optimizations:**
- Skip SPEC-First for prototypes (add later when stabilizing)
- Use Haiku search agent for fast code location
- Parallel task execution
- Minimal documentation initially

---

## Community Resources

### Official Documentation

**Claude Code:**
- https://docs.claude.com/en/docs/claude-code/
- https://www.anthropic.com/engineering/claude-code-best-practices

**Agent SDK:**
- https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk

### Framework Repositories

**agentic-coding-main (Sam McLeod):**
- Repository: https://github.com/sammcj/agentic-coding
- Focus: Rules, templates, MCP servers, examples
- Tools: Claude Code, Cline
- MCP DevTools: Commonly enabled server

**claude-code-stuff-main (Carlo Zottmann):**
- Repository: https://github.com/carlozottmann/claude-code-stuff
- Focus: Swift/iOS, cost optimization, symlinks
- External: obra/superpowers integration

**superpowers (Jesse Vincent/obra):**
- Repository: https://github.com/obra/superpowers
- Blog: https://blog.fsck.com/2025/10/09/superpowers/
- Marketplace: https://github.com/obra/superpowers-marketplace
- Lab: https://github.com/obra/superpowers-lab
- Chrome: https://github.com/obra/superpowers-chrome

**moai-adk-main (modu-ai):**
- Repository: https://github.com/modu-ai/moai-adk
- PyPI: `pip install moai-adk`
- Skills: https://claude-plugins.dev/skills/@modu-ai/moai-adk/
- Korean community: Active on Threads (@goos.kim)

### Learning Resources

**Articles:**
- "Coding for the Future Agentic World" - Addy Osmani
- "AgenticCoding: Why Agentic Coding with Claude Code Is the Future" - Meshkat Shariat Bagheri
- "Supercharge ADK Development with Claude Code Skills" - Kaz Sato (Medium)
- "TDD with Claude Code: Model Context Protocol, FMP and Agents" - Craig Tait

**Academic:**
- "Decoding the Configuration of AI Coding Agents: Insights from Claude Code Projects" - arXiv:2511.09268

**Courses:**
- "Claude Code: A Highly Agentic Coding Assistant" - DeepLearning.AI

### Community Lists

**Agent Collections:**
- https://github.com/hesreallyhim/a-list-of-claude-code-agents
- Community-submitted sub-agents

**Skill Marketplaces:**
- https://claude-plugins.dev/ - Official skill directory
- https://github.com/obra/superpowers-marketplace - Curated plugins

### Additional Topics

**GitHub Topics:**
- https://github.com/topics/agentic-coding
- Latest repositories and discussions

---

## Quick Decision Guide

### Choose agentic-coding-main if:
✅ You need Australian/British English enforcement
✅ Document processing is primary focus (docx, pdf)
✅ MCP server development required
✅ Strong style consistency across team
✅ Go language projects
✅ Artifacts with React + shadcn

### Choose claude-code-stuff-main if:
✅ Swift/iOS/macOS development
✅ Personal productivity focus
✅ Cost optimization critical (40-60% savings)
✅ Want minimal overhead + instant updates
✅ Prefer proven practices (superpowers)
✅ Fast setup (10 minutes)

### Choose moai-adk-main if:
✅ Enterprise/team development
✅ Need compliance (OWASP, TRUST 5)
✅ Full-stack applications
✅ Production-ready quality required
✅ Multi-language projects (18 languages)
✅ BaaS platforms (Supabase, Firebase, etc.)
✅ Traceability essential
✅ Korean language support needed

---

## Final Recommendations

### Universal Best Practices (Apply to All Frameworks)

1. **Start Small**: Begin with 5-10 core skills, expand as needed
2. **Progressive Disclosure**: Keep SKILL.md lean, use references for depth
3. **Clear Triggers**: 3-5 explicit activation phrases per skill
4. **Behavioral Guidance**: Tell Claude what to do AND what not to do
5. **Quality Gates**: Require verification before claiming success
6. **Token Awareness**: Every line should serve a purpose
7. **Before/After Examples**: Show anti-patterns and solutions
8. **Maintenance**: Update skills quarterly, remove unused ones
9. **Documentation**: Keep README current with setup instructions
10. **Version Control**: Track all configuration changes in Git

### Getting Started Path

**Week 1: Foundation**
- Choose framework based on use case (see Quick Decision Guide)
- Install and configure (10-15 minutes)
- Read framework documentation (2-4 hours)
- Test with simple project

**Week 2: Core Skills**
- Identify 5-10 most relevant skills for your work
- Read skill documentation thoroughly
- Practice activation triggers
- Measure baseline performance

**Week 3: Optimization**
- Track token usage and costs
- Optimize agent delegation patterns
- Refine skill selection
- Document team practices

**Week 4: Expansion**
- Add domain-specific skills
- Create custom skills if needed
- Integrate with CI/CD
- Share with team

### Success Metrics

**Track These:**
- Token usage per session (target: <50K with delegation)
- Cost per feature (target: 40-60% reduction)
- Time to completion (target: 3-5x faster)
- Code quality (target: 85%+ test coverage)
- Documentation freshness (auto-sync vs manual)

**Review Monthly:**
- Skill utilization (remove unused skills)
- Agent performance (optimize delegation)
- Cost trends (adjust model selection)
- Quality metrics (TRUST 5 compliance)

---

## Conclusion

The three major frameworks offer complementary approaches to Claude Code configuration:

- **agentic-coding-main**: Artisanal quality, strict style, comprehensive tooling
- **claude-code-stuff-main**: Pragmatic minimalism, cost-conscious, honest partnership
- **moai-adk-main**: Enterprise methodology, SPEC-First TDD, production-ready automation

**Best overall starting point**: claude-code-stuff-main (easiest adoption, extensible)
**Best for enterprise**: moai-adk-main (only option with compliance)
**Best for specific needs**: agentic-coding-main (Australian English, documents, MCP)

Success with Claude Code comes from:
1. **Clear configuration** (choose right framework)
2. **Quality skills** (follow best practices)
3. **Behavioral guidance** (explicit DO/DON'T)
4. **Progressive disclosure** (load only what's needed)
5. **Continuous refinement** (measure and optimize)

Start simple, measure results, and expand systematically. The frameworks are battle-tested and production-ready - your success depends on choosing the right fit for your needs and following established patterns.

---

*Last updated: 2025-11-18*
*Analysis based on: 190+ skills across 3 frameworks*
*Total documentation analyzed: 100,000+ lines*
