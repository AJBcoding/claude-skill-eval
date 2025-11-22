# Claude Code Skills Inventory

**Last Updated:** 2025-11-18
**Total Skills:** ~35-40

---

## Foundation (obra superpowers, ~20 skills)

**Process Methodology:**
- brainstorming - Refine ideas into designs through collaborative dialogue
- test-driven-development - RED-GREEN-REFACTOR discipline
- systematic-debugging - Four-phase debugging framework
- root-cause-tracing - Systematic backward tracing through call stacks
- verification-before-completion - Evidence before claims always

**Git Workflows:**
- using-git-worktrees - Isolated workspaces for parallel work
- finishing-a-development-branch - Systematic branch completion

**Code Review:**
- requesting-code-review - Dispatch code-reviewer subagent
- receiving-code-review - Framework for receiving feedback

**Planning & Execution:**
- writing-plans - Comprehensive implementation plans
- executing-plans - Execute plans systematically
- subagent-driven-development - Fresh subagent per task with reviews

**Testing:**
- testing-anti-patterns - Prevent mock testing, production pollution
- defense-in-depth - Multi-layered validation
- condition-based-waiting - Wait for conditions vs arbitrary timeouts

**Meta:**
- dispatching-parallel-agents - Launch multiple agents concurrently
- sharing-skills - Contribute skills back to upstream
- writing-skills - TDD for process documentation
- testing-skills-with-subagents - RED-GREEN-REFACTOR for skills
- using-superpowers - Mandatory workflows for finding/using skills

**Purpose:** Complete process foundation. All skills preserved, fully interconnected.

---

## Language Expertise (3 skills)

**moai-lang-python**
- Python 3.13, FastAPI 0.115, Django 5.2 LTS
- Pydantic v2, SQLAlchemy 2.0, async patterns
- Production deployment strategies
- **Coverage:** fitbod-project, hearing-test-tracker, knowledge-extraction-suite, Python419

**moai-lang-typescript**
- TypeScript 5.9, React 19, Next.js 16
- Type-safe schemas (Zod, tRPC)
- Framework-agnostic patterns
- **Coverage:** fitbod-project, hearing-test-tracker frontends

**developing-with-swift**
- SwiftUI development, macOS patterns
- Native state management, async/await
- Xcode build tools
- **Coverage:** Sticky To Do project

---

## Domain Patterns (4 skills)

**moai-domain-database**
- Schema design, migration strategies
- Query optimization, indexing
- PostgreSQL best practices
- **Coverage:** Python419, fitbod, hearing-test databases

**moai-domain-backend**
- API architecture (REST, GraphQL, gRPC)
- Error handling, validation
- Microservices patterns
- **Coverage:** All FastAPI/Flask backends

**moai-domain-frontend**
- React patterns, state management
- Performance optimization
- Component architecture
- **Coverage:** React 18.2 frontends

**moai-domain-security**
- OWASP compliance
- Authentication/authorization
- Encryption, audit logging
- **Coverage:** Health apps (fitbod, hearing-test)

---

## Document Processing (4 skills)

**docx**
- Word document creation, editing, analysis
- Tracked changes, formatting preservation
- OOXML manipulation

**pdf**
- PDF extraction, creation, merging/splitting
- Form filling, text/table extraction

**xlsx**
- Spreadsheet creation with formulas
- Data analysis and visualization
- Excel format preservation

**pptx**
- Presentation creation and editing
- Template usage, formatting

**Purpose:** Report generation, data exports, documentation

---

## Optimization & Utilities (2-3 skills)

**sql-optimization-patterns**
- Query optimization, indexing strategies
- EXPLAIN analysis
- Performance patterns

**python-performance-optimization**
- cProfile, memory profiling
- Bottleneck detection
- Optimization best practices

**(Verification pending):**
- Check if moai has pytest-specific skills
- Check if moai has data-viz skills (Plotly/Recharts)

---

## Excluded Skills (and Why)

### moai Skills Excluded to Avoid Conflicts

**moai-essentials-debug**
- **Overlaps with:** obra's systematic-debugging
- **Why:** Obra's 4-phase framework is core, AI-powered debug would create activation conflicts

**moai-essentials-review**
- **Overlaps with:** obra's requesting-code-review
- **Why:** Obra's code-reviewer subagent pattern is established

**moai-foundation-specs (SPEC-First TDD)**
- **Overlaps with:** obra's test-driven-development
- **Why:** Different TDD methodology would confuse workflow

**moai-foundation-git**
- **Overlaps with:** obra's using-git-worktrees, finishing-a-development-branch
- **Why:** Obra's git workflows are interconnected

### Language Skills Excluded (Not in Tech Stack)

- moai-lang-go, moai-lang-rust, moai-lang-java
- moai-lang-php, moai-lang-csharp, moai-lang-cpp
- moai-lang-ruby, moai-lang-kotlin, moai-lang-elixir
- moai-lang-haskell, moai-lang-scala, moai-lang-r, moai-lang-julia, moai-lang-dart

**Rationale:** Not used in current projects. Can add later if needed.

### Configuration Elements Excluded (Deferred to Phase 2)

**Australian English rules** (sam's framework)
- Not needed for US-based work

---

## Phase 2 - Configuration Systems Focus (7 todos)

### Configuration Systems Evaluation & Integration
1. Evaluate agents, hooks, rules from all 3 frameworks
2. Compare cost-optimization: carlo's Haiku (40-60%) vs moai delegation (80-85%)
3. Evaluate quality agents: docs-quality-reviewer, code-simplifier, documentation-generator
4. Review global rules: Craft hybrid without Australian English
5. Evaluate workflow command systems
6. Test hooks systems
7. Craft hybrid configuration

## Phase 3 - Advanced Tools & Custom Skills (7 todos)

### Advanced Tool Research
1. Research Alfred SuperAgent value-add
2. Research Mise build system value-add

### Skill Verification & Creation
3. Verify if moai has pytest-specific skills
4. Verify if moai has data-viz skills (Plotly/Recharts)
5. Create custom NLP/ML skill (BERTopic, embeddings, topic modeling)
6. Create pytest-patterns skill (fixtures, SQLAlchemy testing, FastAPI overrides)
7. Create plotly-recharts-dashboards skill

---

## Maintenance & Updates

### Tracking moai Updates
- moai skills use `moai-` prefix for easy identification
- Check moai-adk releases for skill updates
- Batch update moai skills when new versions available

### Adding/Removing Skills
- Document all changes in git commits
- Update this inventory
- Run QA checklist before deployment
- Test activation scenarios

### Quality Assurance
- Verify no duplicate activation triggers
- Check dependency chains (no broken skill references)
- Validate `allowed-tools` in all frontmatter
- Test with sample user requests

---

## Reference

**Design Document:** `docs/plans/2025-11-18-claude-code-configuration-curation-design.md`

**Configuration Decisions:** `CONFIGURATION_DECISIONS.md`

**Framework Sources:**
- obra superpowers: `.claude/skills/superpowers/`
- moai-adk: `moai-adk-main/.claude/skills/`
- carlo: `claude-code-stuff-main/skills/`
- sam: `agentic-coding-main/Claude/skills/`
