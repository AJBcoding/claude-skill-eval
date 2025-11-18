# Claude Code Configuration Curation Design

**Date:** 2025-11-18
**Status:** Validated
**Author:** Design session with user

---

## Executive Summary

This design curates a Claude Code configuration from three frameworks (obra superpowers, carlo's claude-code-stuff, sam's agentic-coding) for a Python/TypeScript/Swift developer working on full-stack web applications, data processing systems, and NLP/ML pipelines.

**Core Strategy:** Preserve obra superpowers completely as process foundation. Layer in moai language/domain expertise. Cherry-pick standalone utilities. Defer complex configuration systems to Phase 2.

**Result:** ~35-40 curated skills covering process methodology, language expertise, domain patterns, document processing, and optimization tools.

---

## Context

### Tech Stack
- **Backend:** Python (FastAPI 0.115, Flask), SQLAlchemy 2.0, PostgreSQL
- **Frontend:** React 18.2, TypeScript, Vite, Mantine UI, Recharts/Plotly
- **Data/ML:** Spacy, Transformers, BERT, BERTopic, Gensim, pandas
- **Native:** Swift (SwiftUI for macOS)
- **Testing:** pytest, Playwright

### Current Projects
1. **fitbod-project** - Full-stack fitness coaching app (FastAPI + React)
2. **hearing-test-tracker** - Health tracking web app (Flask + React)
3. **knowledge-extraction-suite** - NLP/document analysis platform (FastAPI + Streamlit)
4. **Python419** - Enterprise academic data management system (PostgreSQL)
5. **Sticky To Do** - Native macOS productivity app (Swift/SwiftUI)

### Primary Pain Points
1. **Manual work** - Re-explaining context and patterns
2. **Inconsistent quality** - Claude skips steps or makes preventable mistakes
3. **Missing capabilities** - Need better tools for testing, debugging, documentation
4. **Document processing gaps** - DOCX/PDF/Excel handling for reports and data exports
5. **Database expertise gaps** - Schema design, migration strategies, SQL optimization
6. **Cost concerns** - Sessions get expensive with large contexts

### Core Constraint
**Preserve obra superpowers completely** - It's the workflow foundation. Only replace obra skills if moai versions are "substantially better." Otherwise, only ADD complementary capabilities.

---

## Architecture

### Philosophy: Foundation + Specialization

**Three layers:**

1. **Process Foundation (obra superpowers)**
   - TDD, systematic debugging, verification
   - Git workflows, code review
   - Planning, brainstorming, execution
   - All skills kept unchanged, fully interconnected

2. **Domain Expertise (moai skills)**
   - Language patterns: Python, TypeScript, Swift
   - Domain patterns: Database, backend, frontend, security
   - Fill gaps obra doesn't address

3. **Utilities (standalone skills)**
   - Document processing: docx, pdf, xlsx, pptx
   - Optimization: SQL, Python performance
   - Cherry-picked from all three frameworks

### Key Constraints

1. **Flat structure** - .claude/skills/ must be flat (no subfolders)
2. **Prefix preservation** - Keep moai- prefixes for source tracking and batch updates
3. **Language exclusions** - Skip all non-Python/TypeScript/Swift language skills
4. **No conflicts** - Avoid duplicating or breaking obra's interconnected skill system
5. **YAGNI** - Only skills that address real pain points

---

## Skill Selection

### Category 1: Foundation Process (obra superpowers, ~20 skills)

**All obra skills preserved:**
- brainstorming
- test-driven-development
- systematic-debugging
- root-cause-tracing
- verification-before-completion
- using-git-worktrees
- finishing-a-development-branch
- requesting-code-review
- receiving-code-review
- writing-plans
- executing-plans
- subagent-driven-development
- testing-anti-patterns
- defense-in-depth
- condition-based-waiting
- dispatching-parallel-agents
- sharing-skills
- writing-skills
- testing-skills-with-subagents
- using-superpowers

**Rationale:** These skills are interconnected. Removing any breaks the system. They provide process methodology that moai/carlo don't replace.

### Category 2: Language Expertise (3 skills)

**moai-lang-python**
- Python 3.13, FastAPI 0.115, Django 5.2 LTS
- Pydantic v2, SQLAlchemy 2.0, async patterns
- Production deployment strategies
- **Addresses:** FastAPI/SQLAlchemy patterns obra doesn't cover

**moai-lang-typescript**
- TypeScript 5.9, React 19, Next.js 16
- Type-safe schemas (Zod, tRPC)
- Framework-agnostic patterns
- **Addresses:** React/TypeScript patterns obra doesn't cover

**developing-with-swift**
- SwiftUI development, macOS patterns
- Native state management, async/await
- Xcode build tools integration
- **Addresses:** Sticky To Do project needs

### Category 3: Domain Patterns (4 skills)

**moai-domain-database**
- Schema design, migration strategies
- Query optimization, indexing
- PostgreSQL best practices
- **Addresses:** Database expertise gap (Python419, fitbod, hearing-test)

**moai-domain-backend**
- API architecture (REST, GraphQL, gRPC)
- Error handling, validation patterns
- Microservices patterns
- **Addresses:** API design patterns beyond FastAPI basics

**moai-domain-frontend**
- React patterns, state management
- Performance optimization
- Component architecture
- **Addresses:** Frontend patterns for React 18.2 projects

**moai-domain-security**
- OWASP compliance
- Authentication/authorization patterns
- Encryption, audit logging
- **Addresses:** Security needs for health apps (fitbod, hearing-test)

### Category 4: Document Processing (4 skills)

**docx, pdf, xlsx, pptx**
- Comprehensive OOXML/document manipulation
- Creating, editing, analyzing documents
- Tracked changes, formulas, formatting preservation
- **Addresses:** Report generation, data exports, documentation needs

**Source:** Standalone skills from .claude/skills/ (already in repo)

### Category 5: Optimization & Utilities (2-3 skills)

**sql-optimization-patterns**
- Query optimization, indexing strategies
- EXPLAIN analysis
- Performance improvement patterns
- **Addresses:** Database performance for Python419, fitbod

**python-performance-optimization**
- cProfile, memory profiling
- Bottleneck detection
- Optimization best practices
- **Addresses:** NLP pipeline performance (knowledge-extraction)

**Verification pending:**
- Check if moai has pytest-specific skills (fixtures, mocking patterns)
- Check if moai has data visualization skills (Plotly/Recharts)

---

## Exclusions

### Skills Excluded (and Why)

**moai-essentials-debug**
- **Overlaps with:** obra's systematic-debugging
- **Why excluded:** Obra's 4-phase framework is core to workflow. Adding AI-powered debug would create activation conflicts.

**moai-essentials-review**
- **Overlaps with:** obra's requesting-code-review
- **Why excluded:** Obra's code-reviewer subagent pattern is established. Moai's automated review would conflict.

**moai-foundation-specs (SPEC-First TDD)**
- **Overlaps with:** obra's test-driven-development
- **Why excluded:** Obra's RED-GREEN-REFACTOR is core methodology. SPEC-First is different approach, would confuse workflow.

**moai-foundation-git**
- **Overlaps with:** obra's using-git-worktrees, finishing-a-development-branch
- **Why excluded:** Obra's git workflows are established and interconnected.

**Language skills (Go, Rust, Java, PHP, C#, C++, Ruby, etc.)**
- **Why excluded:** Not in tech stack. Can add later if projects require.

**Australian English rules (sam's framework)**
- **Why excluded:** Not needed for US-based work.

### Configuration Elements Deferred to Phase 2

**Agents:**
- carlo's Haiku search agent (40-60% cost savings)
- sam's docs-quality-reviewer, code-simplifier
- carlo's documentation-generator
- moai's Alfred SuperAgent (19 specialized agents)

**Global Rules:**
- carlo's 8 rules (honest partnership, parallel execution)
- sam's CLAUDE.md (token efficiency, no clichés)
- Hybrid rules system without Australian English

**Build Systems:**
- carlo's Mise tasks for compilation/deployment
- moai's /alfred:0-project, /alfred:1-plan, /alfred:2-run, /alfred:3-sync workflow

**Hooks:**
- carlo's session-start, user-prompt-submit scripts
- moai's comprehensive lifecycle hooks

**Rationale:** These require deeper evaluation to avoid conflicts and ensure value-add. Need to research online, compare approaches, and craft hybrid system.

---

## File Organization

### Directory Structure (Flat, as Required)

```
.claude/skills/
├── brainstorming/                       # obra
├── test-driven-development/             # obra
├── systematic-debugging/                # obra
├── root-cause-tracing/                  # obra
├── verification-before-completion/      # obra
├── using-git-worktrees/                 # obra
├── finishing-a-development-branch/      # obra
├── requesting-code-review/              # obra
├── receiving-code-review/               # obra
├── writing-plans/                       # obra
├── executing-plans/                     # obra
├── subagent-driven-development/        # obra
├── testing-anti-patterns/               # obra
├── defense-in-depth/                    # obra
├── condition-based-waiting/             # obra
├── dispatching-parallel-agents/        # obra
├── sharing-skills/                      # obra
├── writing-skills/                      # obra
├── testing-skills-with-subagents/      # obra
├── using-superpowers/                   # obra
├── moai-lang-python/                    # moai
├── moai-lang-typescript/                # moai
├── moai-domain-database/                # moai
├── moai-domain-backend/                 # moai
├── moai-domain-frontend/                # moai
├── moai-domain-security/                # moai
├── developing-with-swift/               # carlo
├── docx/                                # standalone
├── pdf/                                 # standalone
├── xlsx/                                # standalone
├── pptx/                                # standalone
├── sql-optimization-patterns/           # standalone
└── python-performance-optimization/     # standalone
```

### Naming Convention

**moai- prefix preserved:**
- Folder name matches frontmatter name exactly
- Easy to identify source for batch updates
- Clear when moai releases new versions
- Can remove prefix later if desired

**Example:**
```yaml
# .claude/skills/moai-lang-python/SKILL.md
---
name: moai-lang-python
description: Enterprise Python 3.13 with FastAPI...
---
```

---

## Deployment Strategy

### Phase 1: Immediate Deployment

**Step 1: Keep existing obra skills**
- No changes to superpowers/ directory
- All interconnected skills remain intact

**Step 2: Copy moai skills**
- Source: `moai-adk-main/.claude/skills/`
- Copy 6 skills: lang-python, lang-typescript, domain-database, domain-backend, domain-frontend, domain-security
- Preserve moai- prefix in both folder and frontmatter

**Step 3: Verify standalone skills present**
- Check .claude/skills/ for: docx, pdf, xlsx, pptx
- Add if missing: sql-optimization-patterns, python-performance-optimization
- Add developing-with-swift from carlo's collection

**Step 4: Document decisions**
- Create SKILLS_INVENTORY.md (master reference)
- Create CONFIGURATION_DECISIONS.md (rationale)
- List exclusions and Phase 2 deferrals

**Step 5: Quality assurance**
- Verify no duplicate activation triggers
- Check all moai skills reference only included dependencies
- Validate allowed-tools in all frontmatter
- Test activation with sample scenarios

**Step 6: Commit**
- Commit skill additions with clear message
- Reference this design document

### Phase 2: Configuration Systems Evaluation

**Research tasks (14 todos created):**
1. Deep dive: Evaluate agents, hooks, rules from all 3 frameworks
2. Compare cost optimization: carlo's Haiku (40-60%) vs moai delegation (80-85%)
3. Evaluate quality agents: docs-quality-reviewer, code-simplifier, documentation-generator
4. Review global rules: Craft hybrid without Australian English
5. Research Alfred SuperAgent value-add
6. Research Mise build system value-add
7. Evaluate workflow command systems
8. Test hooks systems
9. Craft hybrid configuration
10. Verify moai pytest skills
11. Verify moai data-viz skills
12. Create custom NLP/ML skill
13. Create pytest-patterns skill (if needed)
14. Create plotly-recharts-dashboards skill (if needed)

---

## Conflict Prevention

### Activation Trigger Review

**Before deployment, verify:**
- moai-lang-python doesn't overlap with test-driven-development triggers
- moai-domain-* skills don't overlap with obra process skills
- Document skills (docx/pdf/xlsx/pptx) have clear, distinct triggers

**Method:**
- Read all frontmatter descriptions
- Check "When to Use" sections
- Test with sample user requests

### Dependency Chain Verification

**Check each moai skill for references to:**
- moai-foundation-specs (excluded)
- moai-foundation-git (excluded)
- moai-essentials-debug (excluded)
- moai-essentials-review (excluded)

**If references exist:**
- Update documentation to point to obra equivalents
- Or include referenced skill if critical

### Tool Constraint Validation

**Ensure all skills have:**
- `allowed-tools` in frontmatter
- Minimum necessary tools listed
- Security boundary established

**Add if missing.**

---

## Quality Assurance Checklist

### Pre-Deployment Validation

- [ ] All obra skills present and unchanged
- [ ] All moai skills have moai- prefix (folder name = frontmatter name)
- [ ] No duplicate activation triggers across skill set
- [ ] Document processing skills (docx/pdf/xlsx/pptx) present
- [ ] Language skills cover tech stack (Python/TypeScript/Swift only)
- [ ] No skills for excluded languages (Go, Rust, Java, PHP, etc.)
- [ ] Dependency chains verified (no broken references)
- [ ] Tool constraints validated (all have allowed-tools)
- [ ] SKILLS_INVENTORY.md created
- [ ] CONFIGURATION_DECISIONS.md created
- [ ] Design document committed

### Post-Deployment Testing

- [ ] Test obra skill activation (brainstorming, TDD, systematic-debugging)
- [ ] Test moai skill activation (moai-lang-python for FastAPI questions)
- [ ] Test document skill activation (docx for "create Word document")
- [ ] Verify no conflicts (multiple skills activating for same request)
- [ ] Check token usage (no unexpected spikes)

---

## Documentation Deliverables

### SKILLS_INVENTORY.md

**Master reference listing:**
- All 35-40 skills with brief descriptions
- Organized by category (Foundation, Language, Domain, Documents, Optimization)
- Exclusion list with rationale
- Phase 2 deferrals with todo references
- Update tracking (when skills added/removed)

### CONFIGURATION_DECISIONS.md

**Rationale document capturing:**
- Why we chose each skill
- Why we excluded others (especially moai-essentials-*, moai-foundation-*)
- Configuration systems deferred to Phase 2
- Trade-offs considered
- Future decision points

### Phase 2 Evaluation Guide

**Todo list (14 items) for deep dive:**
- Configuration systems comparison
- Cost optimization research
- Quality agents evaluation
- Global rules crafting
- Alfred and Mise value assessment
- Custom skill creation (NLP/ML, pytest, data-viz)

---

## Success Metrics

### Immediate Wins (Phase 1)

1. **Reduced manual work** - Language/domain skills provide Python/TypeScript/database patterns automatically
2. **Better quality** - obra process + moai domain expertise catches more issues
3. **Document handling** - docx/pdf/xlsx skills handle report generation
4. **Database expertise** - moai-domain-database guides schema design, migrations
5. **Security patterns** - moai-domain-security enforces OWASP compliance

### Future Optimization (Phase 2)

1. **Cost reduction** - 40-85% savings via specialized agents
2. **Token efficiency** - Global rules prevent wasted context
3. **Workflow automation** - /alfred or slash commands streamline repeated tasks
4. **Custom capabilities** - NLP/ML, pytest, data-viz skills for specialized work

---

## Next Steps

### Immediate (if proceeding to implementation)

1. **Create isolated workspace**
   - Use obra's `using-git-worktrees` skill
   - Branch: `feature/curated-skills-phase1`

2. **Create implementation plan**
   - Use obra's `writing-plans` skill
   - Detail exact copy/verification/testing steps

3. **Execute deployment**
   - Copy moai skills
   - Verify standalone skills
   - Create documentation
   - Run QA checklist
   - Test activation scenarios

4. **Commit and merge**
   - Commit with reference to this design
   - Create PR for review
   - Merge to main

### Phase 2 (deferred)

- Work through 14-item todo list
- Research configuration systems online
- Craft hybrid agents/rules/hooks
- Create custom skills for NLP/pytest/data-viz
- Deploy Phase 2 configuration

---

## Appendix: Framework Sources

### obra superpowers
- **Source:** .claude/skills/superpowers/
- **Already installed:** Yes
- **Version:** Current
- **Skills used:** All (~20 process methodology skills)

### moai-adk-main
- **Source:** moai-adk-main/.claude/skills/
- **Version:** 0.25.10
- **Skills used:** 6 (lang-python, lang-typescript, domain-database, domain-backend, domain-frontend, domain-security)
- **Skills excluded:** essentials-*, foundation-specs, foundation-git, all non-Python/TS languages

### carlo's claude-code-stuff-main
- **Source:** claude-code-stuff-main/skills/
- **Skills used:** 1 (developing-with-swift)
- **Configuration deferred:** Agents, rules, hooks to Phase 2

### sam's agentic-coding-main
- **Source:** agentic-coding-main/Claude/
- **Skills used:** 0 (document skills already in .claude/skills/)
- **Configuration deferred:** Agents, rules to Phase 2
- **Excluded:** Australian English rules

### Standalone skills
- **Source:** .claude/skills/
- **Skills used:** docx, pdf, xlsx, pptx, sql-optimization-patterns, python-performance-optimization

---

**End of Design Document**
