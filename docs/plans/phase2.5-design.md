# Phase 2.5 Design: Domain Coordination Architecture

**Created:** 2025-11-19
**Status:** Design Document
**Principle:** Domains enhance obra, never replace it

## Executive Summary

Phase 2.5 introduces a 7-domain coordination layer that enhances obra superpowers through semantic routing and specialized orchestration. Rather than analyzing all possible patterns from three frameworks, we focus on implementing domain coordinators that multiply the effectiveness of our existing 37 skills and Phase 2 agents.

## Core Design Principle

```yaml
Obra Superpowers = Operating System (unchanged)
Domain Coordinators = Smart Applications (new)
Together = Enhanced Intelligence
```

Every domain coordinator MUST:
1. Use obra patterns internally (brainstorming, TDD, systematic-debugging)
2. Leverage Phase 2 agents (debug, consistency, quality)
3. Route to appropriate skills from our 37 curated capabilities
4. Enhance, never bypass, existing workflows

## Architecture Overview

```
┌──────────────────────────────────────────┐
│         User Request                      │
└────────────┬─────────────────────────────┘
             ↓
┌──────────────────────────────────────────┐
│    Phase 2: Consistency Agent            │
│    (Initial routing + pattern check)      │
└────────────┬─────────────────────────────┘
             ↓
┌──────────────────────────────────────────┐
│    Domain Coordinator Layer (New)         │
│  ┌─────────────────────────────────────┐ │
│  │ 1. Language Coordinator             │ │
│  │ 2. Architecture Coordinator         │ │
│  │ 3. Document Coordinator             │ │
│  │ 4. Quality Coordinator              │ │
│  │ 5. Data Analysis Coordinator        │ │
│  │ 6. Planning Coordinator             │ │
│  │ 7. Git Workflow Coordinator         │ │
│  └─────────────────────────────────────┘ │
└────────────┬─────────────────────────────┘
             ↓
┌──────────────────────────────────────────┐
│    Obra Superpowers + 37 Skills          │
│    (Execution layer - unchanged)          │
└──────────────────────────────────────────┘
```

## The 7 Domain Coordinators

### 1. Language Coordinator
**Purpose:** Route language-specific tasks to appropriate specialists

**Orchestrates:**
- `moai-lang-python` (FastAPI, Django, async patterns)
- `moai-lang-typescript` (React, Next.js, type safety)
- `developing-with-swift` (SwiftUI, macOS patterns)

**Obra Integration:**
```yaml
When activated:
  1. Uses brainstorming to clarify requirements
  2. Activates test-driven-development for implementation
  3. Triggers verification-before-completion
  4. Can dispatch-parallel-agents for multi-language tasks
```

**Triggers:**
- Tool-based: Edit/Write with .py, .ts, .tsx, .swift extensions
- Keywords: "FastAPI", "React component", "SwiftUI", "type safety"

---

### 2. Architecture Coordinator
**Purpose:** Ensure consistent patterns across system layers

**Orchestrates:**
- `moai-domain-database` (schema, migrations, optimization)
- `moai-domain-backend` (API patterns, microservices)
- `moai-domain-frontend` (component architecture, state)
- `moai-domain-security` (auth, OWASP compliance)

**Obra Integration:**
```yaml
When activated:
  1. Uses brainstorming for architecture decisions
  2. Enforces systematic-debugging for issues
  3. Triggers requesting-code-review for changes
  4. Applies defense-in-depth for validation
```

**Triggers:**
- Keywords: "database schema", "API endpoint", "component design", "authentication"
- Patterns: Multi-file changes across layers

---

### 3. Document Coordinator
**Purpose:** Intelligent document processing and generation

**Orchestrates:**
- `docx` (Word documents)
- `xlsx` (Spreadsheets)
- `pptx` (Presentations)
- `pdf` (PDF processing)

**Obra Integration:**
```yaml
When activated:
  1. Auto-selects appropriate skill by file extension
  2. Uses writing-plans for complex documents
  3. Applies verification-before-completion
  4. Can dispatch-parallel-agents for batch processing
```

**Triggers:**
- File extensions: .docx, .xlsx, .pptx, .pdf
- Keywords: "generate report", "extract data", "create presentation"

---

### 4. Quality Coordinator
**Purpose:** Multi-layered quality assurance beyond basic checks

**Enhances Phase 2 quality-agent with:**
- Test coverage analysis
- Performance profiling
- Security scanning
- Documentation completeness

**Orchestrates:**
- `test-driven-development`
- `python-performance-optimization`
- `sql-optimization-patterns`
- `testing-anti-patterns`
- `defense-in-depth`

**Obra Integration:**
```yaml
When activated:
  1. Inherits quality-agent's 7-point checklist
  2. Adds domain-specific quality checks
  3. Uses root-cause-tracing for issues
  4. Triggers requesting-code-review for validation
```

---

### 5. Data Analysis Coordinator
**Purpose:** End-to-end data pipeline automation

**Orchestrates:**
- `csv-data-summarizer-claude-skill-main`
- `corpus-discovery-dialogue`
- Future: plotly/matplotlib skills

**Obra Integration:**
```yaml
When activated:
  1. Uses brainstorming to understand analysis goals
  2. Applies systematic approach to data exploration
  3. Uses verification-before-completion for results
  4. Can dispatch-parallel-agents for multiple analyses
```

---

### 6. Planning Coordinator
**Purpose:** Complex project orchestration

**Orchestrates:**
- `writing-plans`
- `executing-plans`
- `brainstorming`
- `subagent-driven-development`

**Obra Integration:**
```yaml
When activated:
  1. Always starts with brainstorming
  2. Creates comprehensive plans via writing-plans
  3. Executes via subagent-driven-development
  4. Reviews progress with verification-before-completion
```

---

### 7. Git Workflow Coordinator
**Purpose:** Safe, sophisticated git operations

**Orchestrates:**
- `using-git-worktrees`
- `finishing-a-development-branch`
- Git operations with safety checks

**Obra Integration:**
```yaml
When activated:
  1. Checks branch status before operations
  2. Uses verification-before-completion for commits
  3. Can dispatch-parallel-agents for multi-branch work
  4. Triggers requesting-code-review for PRs
```

## Implementation Strategy

### Phase 1: Core Three (Week 1)
Start with highest-value coordinators:

**Language Coordinator**
- Most frequently activated
- Clear trigger patterns
- Immediate value for daily coding

**Architecture Coordinator**
- Ensures system consistency
- Prevents architectural drift
- High impact on code quality

**Document Coordinator**
- Clear file-based triggers
- Self-contained operations
- Easy to test and validate

### Phase 2: Enhancement Layer (Week 2)
Add coordinators that enhance existing agents:

**Quality Coordinator**
- Extends Phase 2 quality-agent
- Adds specialized quality checks
- Measurable improvement metrics

**Data Analysis Coordinator**
- Handles common analysis tasks
- Clear value proposition
- Limited complexity

### Phase 3: Advanced Orchestration (Week 3)
Complete with meta-coordinators:

**Planning Coordinator**
- For complex, multi-phase projects
- Builds on proven patterns

**Git Workflow Coordinator**
- Advanced git operations
- Safety-critical workflows

## Integration Patterns

### Pattern 1: Coordinator as Obra Subagent
```python
class DomainCoordinator:
    def __init__(self):
        self.obra_skills = load_obra_superpowers()
        self.domain_skills = load_domain_specific()

    def handle(self, task):
        # Always use obra's using-superpowers first
        self.obra_skills.using_superpowers(task)

        # Then add domain-specific routing
        if self.is_domain_relevant(task):
            return self.orchestrate_domain(task)
```

### Pattern 2: Enhanced Trigger System
```yaml
# Extends Phase 2 triggers.yml
domain_triggers:
  language_coordinator:
    precedence: HIGH
    type: compound  # New: combines tool + keyword
    conditions:
      - tool_match: "Edit|Write"
        file_pattern: "\\.(py|ts|tsx|swift)$"
      - keyword_match: "FastAPI|React|SwiftUI"
    delegates_to:
      - moai-lang-python
      - moai-lang-typescript
      - developing-with-swift
```

### Pattern 3: Coordinator Chaining
```yaml
# Coordinators can activate each other
User: "Create a FastAPI endpoint with database schema"
  → language_coordinator (FastAPI detected)
    → architecture_coordinator (schema + API detected)
      → Both work in parallel via dispatching-parallel-agents
```

## Success Metrics

### Quantitative Metrics
| Metric | Current (Phase 2) | Target (Phase 2.5) | Measurement |
|--------|-------------------|-------------------|-------------|
| Skill activation accuracy | 85-90% | 95-98% | Correct skill activated first try |
| Multi-skill coordination | Manual | Automatic | Tasks requiring 2+ skills |
| Pattern consistency | 90-95% | 98-99% | Architecture adherence |
| Task completion time | Baseline | -20% | Complex task duration |

### Qualitative Metrics
- **Developer Experience:** Less manual skill selection
- **Code Quality:** More consistent patterns across domains
- **Reduced Cognitive Load:** Coordinators handle orchestration

## Risk Mitigation

### Risk 1: Over-Coordination
**Risk:** Coordinators add unnecessary layers
**Mitigation:**
- Start with 3 coordinators, validate value
- Bypass mechanism: `--no-coordinators` flag
- Measure overhead, must be <5% token increase

### Risk 2: Obra Pattern Dilution
**Risk:** Coordinators bypass obra patterns
**Mitigation:**
- Mandatory obra skill usage in coordinators
- Audit logs showing obra pattern usage
- Code review of all coordinator implementations

### Risk 3: Complexity Creep
**Risk:** System becomes too complex
**Mitigation:**
- Hard limit: 7 coordinators maximum
- Each coordinator must replace 3+ manual steps
- Regular complexity audits

## Implementation Timeline

### Week 1: Foundation (20 hours)
**Monday-Tuesday:** Language Coordinator
- Implement routing logic
- Test with Python/TypeScript/Swift tasks
- Measure activation accuracy

**Wednesday-Thursday:** Architecture Coordinator
- Implement cross-layer orchestration
- Test with full-stack tasks
- Validate pattern consistency

**Friday:** Document Coordinator
- Implement file-based routing
- Test with various document types
- Create usage examples

### Week 2: Enhancement (20 hours)
**Monday-Tuesday:** Quality Coordinator
- Extend Phase 2 quality-agent
- Add domain-specific checks
- Measure quality improvements

**Wednesday-Thursday:** Data Analysis Coordinator
- Implement analysis pipelines
- Test with real datasets
- Document patterns

**Friday:** Integration Testing
- Test coordinator interactions
- Validate obra pattern usage
- Measure performance impact

### Week 3: Completion (20 hours)
**Monday-Tuesday:** Planning & Git Coordinators
- Implement remaining coordinators
- Test advanced workflows
- Document usage patterns

**Wednesday-Thursday:** System Integration
- Full system testing
- Performance optimization
- Create bypass mechanisms

**Friday:** Documentation & Handoff
- Complete usage guides
- Create maintenance procedures
- Prepare Phase 3 recommendations

## Configuration Files

### New Files Structure
```
.claude/
  coordinators/
    language/
      coordinator.yml       # Configuration
      routes.yml           # Routing rules
      examples/            # Usage examples
    architecture/
      coordinator.yml
      patterns.yml         # Architectural patterns
    document/
      coordinator.yml
      processors.yml       # File type handlers
    quality/
      coordinator.yml
      checks.yml          # Domain-specific checks
    [... other coordinators ...]
```

### Example Coordinator Configuration
```yaml
# .claude/coordinators/language/coordinator.yml
name: language-coordinator
description: Routes language-specific tasks to specialists
version: 1.0.0

obra_dependencies:
  required:
    - using-superpowers
    - brainstorming
    - test-driven-development
  optional:
    - dispatching-parallel-agents
    - requesting-code-review

skills:
  python:
    skill: moai-lang-python
    triggers: ["FastAPI", "Django", "Python", "\.py$"]
    precedence: HIGH
  typescript:
    skill: moai-lang-typescript
    triggers: ["React", "TypeScript", "\.tsx?$"]
    precedence: HIGH
  swift:
    skill: developing-with-swift
    triggers: ["SwiftUI", "Swift", "\.swift$"]
    precedence: HIGH

routing_strategy: first_match  # or: best_match, all_matching
fallback: brainstorming  # If no match, use brainstorming
```

## Validation Plan

### Week 1 Validation
- Each coordinator successfully routes 10 test tasks
- Obra patterns used in 100% of executions
- No degradation in Phase 2 metrics

### Week 2 Validation
- Coordinators interact correctly on 5 complex tasks
- 20% improvement in multi-skill task completion
- Developer feedback positive

### Week 3 Validation
- Full system handles 20 real-world tasks
- All success metrics met or exceeded
- Rollback procedure tested and documented

## Next Steps

1. **Immediate:** Implement Language Coordinator as proof-of-concept
2. **Day 2-3:** If successful, proceed with Architecture and Document
3. **Week 2:** Assess value, decide on remaining coordinators
4. **Week 3:** Complete implementation or pivot based on results

## Decision Points

### After Week 1:
- Are coordinators providing measurable value?
- Is obra integration working as designed?
- Should we proceed with all 7 or focus on top 3?

### After Week 2:
- Is the complexity worth the benefit?
- Are users finding it helpful or confusing?
- Any unexpected issues or opportunities?

### After Week 3:
- Which coordinators to keep for Phase 3?
- What patterns to extract for future work?
- How to maintain and evolve the system?

---

**Design Complete:** Ready for stakeholder review and implementation planning

**Key Takeaway:** Domain coordinators are sophisticated routers that enhance obra superpowers through intelligent orchestration, not a replacement architecture.