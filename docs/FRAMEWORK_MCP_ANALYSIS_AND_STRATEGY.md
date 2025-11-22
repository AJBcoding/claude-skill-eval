# Framework & MCP Configuration Analysis and Strategy

**Date:** 2025-11-19
**Purpose:** Comprehensive analysis of three framework configurations (agentic-coding, claude-code-stuff, moai-adk) and strategic recommendations for custom Claude Code configuration with MCP integration

**Executive Summary:** This document analyzes three mature Claude Code configurations, their MCP integration strategies, and provides actionable recommendations for Phase 2 configuration development building on Phase 1's successful skill curation.

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Framework Comparison Matrix](#framework-comparison-matrix)
3. [MCP Integration Analysis](#mcp-integration-analysis)
4. [Configuration Architecture Patterns](#configuration-architecture-patterns)
5. [Strategic Insights and Recommendations](#strategic-insights-and-recommendations)
6. [Phase 2 Roadmap with MCP Integration](#phase-2-roadmap-with-mcp-integration)
7. [Implementation Priorities](#implementation-priorities)
8. [Appendix: Detailed Framework Analyses](#appendix-detailed-framework-analyses)

---

## Executive Summary

### Three Framework Philosophies

**Sam's agentic-coding-main:** Token-efficient, document-focused, Australian English, minimal MCP (1 always-on)
**Carlo's claude-code-stuff-main:** Cost-optimized (40-60% savings), delegation-first, zero MCP, CLI-centric
**MOAI-ADK:** Enterprise-grade, SPEC-First TDD, agent orchestration (31 agents), deep MCP integration (3 servers)

### Key Findings

1. **MCP Adoption Varies Dramatically:**
   - Sam: 1 MCP always-on (dev-tools), 6 optional
   - Carlo: 0 MCPs (pure CLI tool approach)
   - MOAI: 3 MCPs integrated (Context7, Playwright, Sequential-Thinking)

2. **Agent Strategies Differ:**
   - Sam: 8 specialized agents for delegation
   - Carlo: 4 agents (search, documentation, code-review, plus superpowers)
   - MOAI: 31 agents in Alfred SuperAgent orchestration system

3. **Cost Optimization Approaches:**
   - Sam: Progressive disclosure, file size limits, sub-agent delegation
   - Carlo: Haiku for search (40-60% savings), isolated contexts
   - MOAI: Agent delegation (80-85% savings), model selection optimization

4. **Skills vs MCPs:**
   - Skills teach HOW to do things (workflows, patterns, best practices)
   - MCPs provide ACCESS to things (databases, APIs, external systems)
   - All three frameworks emphasize skills; only MOAI deeply integrates MCPs

### Strategic Recommendation

**Adopt a hybrid approach:**
- Phase 1's skill foundation (37 skills preserved)
- Carlo's cost optimization patterns (Haiku search agents)
- MOAI's MCP integration architecture (Context7 priority)
- Sam's token efficiency strategies (progressive disclosure)
- Custom MCPs for PostgreSQL, GitHub, and Playwright

---

## Framework Comparison Matrix

### Overview Metrics

| Framework | Skills | Agents | Commands | MCPs Always-On | MCPs Optional | Primary Philosophy |
|-----------|--------|--------|----------|----------------|---------------|-------------------|
| **agentic-coding (Sam)** | 14 | 8 | 9 | 1 (dev-tools) | 6 | Token efficiency, document processing |
| **claude-code-stuff (Carlo)** | 24 (3+21) | 4 | 0 | 0 | 0 | Cost optimization, CLI delegation |
| **moai-adk** | 125+ | 31 | 5 | 3 (Context7, Playwright, Sequential) | 0 | Enterprise TDD, agent orchestration |
| **Your Phase 1** | 37 | 0 | 0 | 0 | 0 | Foundation + specialization |

### MCP Server Comparison

| MCP Server | Sam | Carlo | MOAI | Purpose | Tech Stack Match |
|------------|-----|-------|------|---------|------------------|
| **Context7** | ❌ | ❌ | ✅ Always | Latest API docs, 13K+ examples | ⭐⭐⭐⭐⭐ High |
| **Playwright** | ❌ Optional | ❌ | ✅ Always | Browser automation, E2E testing | ⭐⭐⭐⭐ High |
| **PostgreSQL** | ❌ | ❌ | ❌ | Database access, schema inspection | ⭐⭐⭐⭐⭐ Critical |
| **GitHub** | ❌ | ❌ | ❌ | Issue/PR management | ⭐⭐⭐⭐ High |
| **dev-tools (Sam's)** | ✅ Always | ❌ | ❌ | Brave search, security functions | ⭐⭐⭐ Medium |
| **Sequential Thinking** | ❌ | ❌ | ✅ Always | Complex reasoning | ⭐⭐⭐ Medium |
| **Markdownify** | ❌ Optional | ❌ | ❌ | File conversion to Markdown | ⭐⭐ Low |
| **Memory Bank** | ❌ Optional | ❌ | ❌ | Persistent session memory | ⭐⭐⭐ Medium |

### Configuration Elements Comparison

| Element | Sam | Carlo | MOAI | Notes |
|---------|-----|-------|------|-------|
| **Global Rules (CLAUDE.md)** | ✅ 181 lines | ✅ 171 lines (compiled from 8 files) | ✅ 32,458 bytes | Carlo uses modular compilation |
| **Hooks** | ❌ | ✅ 2 hooks (SessionStart, UserPromptSubmit) | ✅ 12+ hooks | MOAI has comprehensive lifecycle hooks |
| **Build System** | ❌ | ✅ Mise (5 tasks) | ✅ Python packaging | Carlo uses Fish + Mise, MOAI uses pip |
| **Output Styles** | ✅ 1 (concise-only) | ❌ | ✅ 2 (Yoda, R2D2) | MOAI has personality modes |
| **Permissions Model** | ✅ Detailed (allowed/denied/ask) | ❌ | ✅ In settings.json | Sam's is most granular |
| **Multi-Language** | ❌ (Australian English only) | ❌ (English only) | ✅ 25+ languages | MOAI supports Korean, Japanese, Spanish, etc. |

### Skills Organization Comparison

| Category | Sam | Carlo | MOAI | Your Phase 1 |
|----------|-----|-------|------|--------------|
| **Process Methodology** | ❌ | ✅ 21 (superpowers) | ✅ 20+ (Alfred system) | ✅ 21 (obra) |
| **Language Skills** | ❌ | ❌ | ✅ 18 (Python, TS, Go, Rust, etc.) | ✅ 3 (Python, TS, Swift) |
| **Domain Skills** | ❌ | ❌ | ✅ 25+ (backend, frontend, DB, security, etc.) | ✅ 4 (backend, frontend, DB, security) |
| **Document Processing** | ✅ 4 (PDF, DOCX, XLSX, PPTX) | ❌ | ❌ | ✅ 4 (PDF, DOCX, XLSX, PPTX) |
| **Development Tools** | ✅ 4 (MCP builder, artifacts, shell, Go) | ❌ | ✅ 10+ (CC integration skills) | ❌ |
| **BaaS Platforms** | ❌ | ❌ | ✅ 10 (Supabase, Firebase, Vercel, etc.) | ❌ |
| **Optimization** | ❌ | ❌ | ✅ 8 (debug, perf, refactor, review) | ✅ 2 (SQL, Python perf) |

### Cost Optimization Strategies

| Framework | Approach | Claimed Savings | Verification | Complexity |
|-----------|----------|-----------------|--------------|------------|
| **Sam** | Progressive disclosure, file size limits, sub-agents | Not quantified | Qualitative (proven in production) | Medium |
| **Carlo** | Haiku search agents, isolated contexts | 40-60% cost, 30-50% speed | Token counts documented (20-40K → 5.5K) | Low |
| **MOAI** | Agent delegation, model selection | 80-85% token savings, 70% cost reduction | Claimed but not benchmarked | High |

---

## MCP Integration Analysis

### MOAI's MCP Architecture (Most Mature)

**3 MCPs Integrated:**

1. **Context7 (@upstash/context7-mcp)**
   - **Purpose:** Latest API documentation, 13,157+ code examples
   - **Integration:** Dedicated `mcp-context7-integrator` agent
   - **Tools:** `resolve-library-id`, `get-library-docs`
   - **Session Management:** Save/resume research in `.moai/sessions/`
   - **Activation:** Auto-triggered on keywords ("official documentation", "API reference", "check docs")
   - **Benefits:** Eliminates hallucination, always up-to-date knowledge

2. **Playwright (@playwright/mcp)**
   - **Purpose:** Browser automation, E2E testing
   - **Integration:** Dedicated `mcp-playwright-integrator` agent
   - **Use Cases:** UI testing, screenshot capture, form validation
   - **Benefits:** Automated testing workflows

3. **Sequential Thinking (@modelcontextprotocol/server-sequential-thinking)**
   - **Purpose:** Complex reasoning, multi-step problem solving
   - **Integration:** Dedicated `mcp-sequential-thinking-integrator` agent
   - **Tool:** `mcp__sequential_thinking_think`
   - **Use Cases:** Architecture decisions, complex debugging
   - **Benefits:** Transparent reasoning process

**MOAI's Integration Pattern:**
```
Command (/alfred:1-plan)
  ↓ Task() delegation
Agent (spec-builder)
  ↓ Skill() invocation
Skill (moai-lang-python)
  ↓ Direct tool usage
MCP Tool (mcp__context7__get-library-docs)
```

**Key Insight:** MOAI treats MCPs as first-class citizens with dedicated integrator agents, not just raw tool access.

### Sam's Minimal MCP Strategy

**1 MCP Always-On:**
- **dev-tools** (custom Go binary): Brave search, security functions
- Philosophy: "The only MCP server I always have enabled"
- Rationale: Avoid token pollution from MCP tool descriptions

**6 MCPs Optional (Disabled by Default):**
- chrome-browser-use, chrome-browser-control
- markdownify (file conversion)
- @21st-dev/magic
- memory-bank (persistent memory)
- figma-mcp (design integration)

**Sam's Philosophy:**
- Minimal by default to prevent context pollution
- High timeouts (60-600s) for complex operations
- Auto-approval for frequently used operations
- Enable selectively based on task needs

**Token Awareness:** "Some tools abuse their descriptions and pollute the context window"

### Carlo's Zero-MCP Approach

**Alternative Integration Strategy:**
- **No MCPs at all**
- **CLI Tool Wrapping:** kagi-ken-cli, linearis, interfazzle via Bash
- **Skills Layer:** `using-linear` skill wraps linearis CLI
- **Hooks Layer:** Context injection at lifecycle events
- **Sub-agents:** Task-specific model optimization

**Benefits:**
- Zero external dependencies beyond CLI tools
- Complete control over tool integration
- No MCP server management overhead
- Proven cost optimization (40-60% savings without MCPs)

**Trade-off:** Misses MCP ecosystem standardization, protocol benefits

### MCP Ecosystem Research Findings

**Top Recommended MCPs for Your Tech Stack:**

**Database & Data:**
- **PostgreSQL MCP** (`gldc/mcp-postgres` or `stuzero/pg-mcp-server`) - Critical for Python419, fitbod, hearing-test projects
- **database-mcp** - Universal connector (PostgreSQL, MySQL, BigQuery, 10+ others)

**Development & Version Control:**
- **GitHub MCP** - Issue management, PRs, repository metadata - Gold standard for development workflows
- **Playwright MCP** - Browser automation for React frontend testing (already in your config, disabled)

**System & Infrastructure:**
- **Memory Bank MCP** - Persistent context storage (already in your config, disabled)
- **Markdownify MCP** - File/PDF/webpage conversion to Markdown (already in your config, disabled)
- **AWS MCP** - Documentation, billing, resource metadata (if deploying to AWS)

**Specialized:**
- **Context7 MCP** - Latest API documentation (MOAI's killer feature)
- **Sequential Thinking MCP** - Complex reasoning assistance

---

## Configuration Architecture Patterns

### Pattern 1: Separation of Concerns (All 3 Frameworks)

**Common Structure:**
```
Rules (Global Behavior)
  ↓ guides
Skills (Workflows & Patterns)
  ↓ invoked by
Agents (Task Delegation)
  ↓ uses
MCPs (External Access)
```

**Variations:**
- **Sam:** Rules → Skills → Agents → MCPs (minimal MCP)
- **Carlo:** Rules → Skills → Agents (zero MCP, CLI tools instead)
- **MOAI:** Commands → Agents → Skills → MCPs (command-orchestrated)

### Pattern 2: Progressive Disclosure (Sam + MOAI)

**Three-Tier Loading:**
1. **Metadata/Frontmatter:** Always loaded (~100 words) - Description, triggers, tools
2. **SKILL.md Body:** Loaded when triggered (<5K words) - Core instructions
3. **Bundled Resources:** Loaded as needed (unlimited) - References, examples, scripts

**Benefits:**
- Reduces context pollution
- Faster skill selection
- Token efficiency

**Your Phase 1:** Already using this pattern (SKILL.md structure)

### Pattern 3: Model Selection Optimization (Carlo + MOAI)

**Carlo's Approach:**
- **Haiku** for search, location finding, simple tasks (<5K tokens)
- **Sonnet** for complex reasoning, code generation, documentation
- **Isolated contexts** prevent token pollution
- **Result:** 40-60% cost reduction

**MOAI's Approach:**
- **Haiku 4.5** ($0.0008/1K tokens) for fast exploration, codebase searches
- **Sonnet 4.5** ($0.003/1K tokens) for complex reasoning, SPEC creation, architecture
- **Agent delegation** enables per-task model selection
- **Result:** 70% cheaper than all-Sonnet, 80-85% token savings

**Recommendation:** Adopt Carlo's simpler approach first (Haiku search agent), expand to MOAI's delegation if needed.

### Pattern 4: Hook-Based Context Injection (Carlo + MOAI)

**Carlo's Hooks (2):**
1. **SessionStart:** Injects `superpowers:using-superpowers` skill content with `<EXTREMELY_IMPORTANT>` tags
2. **UserPromptSubmit:** Gentle reminder: `<IMPORTANT>Remember to use relevant skills</IMPORTANT>`

**Benefits:**
- Skills loaded without conversation token cost
- Ensures skill awareness every session
- Minimal implementation (13-22 lines of Fish script)

**MOAI's Hooks (12+):**
- **SessionStart:** Project info, config health check
- **PreToolUse:** Auto-checkpoint, document management
- **UserPromptSubmit:** JIT load docs
- **SessionEnd:** Auto-cleanup, metrics, work state
- **PostToolUse:** Streaming UI, log changes

**Benefits:**
- Comprehensive lifecycle automation
- Graceful degradation on timeout
- Python-based customization

**Recommendation:** Start with Carlo's 2 hooks (simple, proven), expand to MOAI's system if automation needs grow.

### Pattern 5: MCP Integrator Agents (MOAI Only)

**Dedicated MCP Agents Pattern:**
- **mcp-context7-integrator:** Documentation specialist
- **mcp-playwright-integrator:** Browser automation
- **mcp-notion-integrator:** Workspace integration
- **mcp-sequential-thinking-integrator:** Complex reasoning

**Benefits:**
- Encapsulates MCP tool usage best practices
- Provides fallback strategies when MCP unavailable
- Monitors research effectiveness
- Query optimization

**Agent Responsibilities:**
- Proactive suggestions when MCP valuable
- Auto-triggered on relevant keywords
- Session management and resume
- Performance monitoring

**Recommendation:** If adopting Context7 or Playwright MCPs, create dedicated integrator agents following MOAI's pattern.

### Pattern 6: CLI Tool Abstraction via Skills (Carlo)

**Pattern:**
```
External CLI Tool (linearis, kagi-ken-cli, interfazzle)
  ↓ wrapped by
Skill (using-linear, kagi.md rule, generating-swift-package-docs)
  ↓ documents
Usage Protocols, Error Handling, Best Practices
```

**Benefits:**
- Tool usage patterns codified, not rediscovered
- Skill provides error handling guidance
- Bash tool usage isolated in skill
- Can evolve tool without changing main config

**Example:** `using-linear` skill wraps `linearis` CLI for Linear ticketing

**Recommendation:** If adopting CLI tools, wrap them in skills. If adopting MCPs, create integrator agents.

### Pattern 7: Tab-Based Configuration (MOAI Only)

**5 Tabs, 12 Batches, 40 Questions:**
- **Tab 1:** Language & Localization
- **Tab 2:** Project Settings
- **Tab 3:** Workflow & TDD
- **Tab 4:** Tools & Integrations
- **Tab 5:** Advanced Configuration

**Validation Checkpoints:** Tab 1, Tab 3, Final

**Atomic Operations:** Backup → Merge → Validate → Write → Verify → Rollback on failure

**Benefits:**
- Organized, digestible configuration
- Validation prevents invalid states
- Atomic updates with rollback
- Interactive via AskUserQuestion

**Complexity:** High (24,055 bytes for /alfred:0-project command)

**Recommendation:** For simple configurations, skip this. For team/enterprise configurations with 20+ settings, adopt tab-based approach.

---

## Strategic Insights and Recommendations

### Insight 1: MCP Adoption is Optional but Powerful

**Evidence:**
- Carlo achieves 40-60% cost savings with ZERO MCPs
- Sam minimizes MCPs (1 always-on) and achieves production token efficiency
- MOAI integrates 3 MCPs and achieves 80-85% token savings (but unclear how much is MCP vs agent delegation)

**Recommendation:**
- **Don't rush to adopt all MCPs**
- **Start with 1-2 high-value MCPs** (Context7, PostgreSQL)
- **Measure actual impact** before expanding
- **CLI tool wrapping (Carlo's approach) is valid alternative** for tools without MCP servers

### Insight 2: Skills are Universal, MCPs are Selective

**Evidence:**
- All 3 frameworks emphasize skills (14-125 skills)
- MCP adoption varies wildly (0-3 always-on)
- Skills work with or without MCPs

**Recommendation:**
- **Phase 1's skill foundation (37 skills) was correct priority**
- **Phase 2 should add MCPs selectively**, not comprehensively
- **Skills teach HOW, MCPs provide ACCESS** - ensure both layers are present

### Insight 3: Cost Optimization Doesn't Require Complex Systems

**Evidence:**
- Carlo's simple Haiku search agent: 40-60% savings, <500 token searches
- Sam's progressive disclosure + file size limits: Production-proven efficiency
- MOAI's 31-agent system: 80-85% savings but high complexity

**Recommendation:**
- **Start with Carlo's Haiku search agent** (simple, proven, low complexity)
- **Adopt Sam's progressive disclosure and file size limits** (already using SKILL.md pattern)
- **Defer MOAI's 31-agent orchestration** unless enterprise-scale needs emerge

### Insight 4: Hooks Provide High ROI for Low Complexity

**Evidence:**
- Carlo's 2 hooks (13-22 lines each) provide skill awareness without token cost
- MOAI's 12+ hooks automate comprehensive lifecycle management
- Sam has zero hooks but achieves efficiency through other means

**Recommendation:**
- **Adopt Carlo's 2 hooks first** (SessionStart, UserPromptSubmit) - simple, proven
- **Expand to MOAI's comprehensive hooks** if automation needs grow
- **Hooks are optional** - Sam proves you can succeed without them

### Insight 5: Context7 MCP is MOAI's Killer Feature

**Evidence:**
- 13,157+ code examples, latest API versions
- Eliminates AI hallucination on APIs
- Session management for research workflows
- Auto-triggered on documentation keywords

**Recommendation:**
- **Context7 should be Priority 1 MCP** for Phase 2
- **Create mcp-context7-integrator agent** following MOAI's pattern
- **Test with Python/FastAPI and TypeScript/React projects** first
- **Measure reduction in hallucination and outdated advice**

### Insight 6: PostgreSQL MCP is Critical Gap

**Evidence:**
- Your tech stack: PostgreSQL primary database (Python419, fitbod, hearing-test)
- NONE of the 3 frameworks have PostgreSQL MCP
- MCP ecosystem has mature PostgreSQL servers (`gldc/mcp-postgres`, `stuzero/pg-mcp-server`)

**Recommendation:**
- **PostgreSQL MCP should be Priority 2** for Phase 2
- **Start read-only** (schema inspection, query analysis)
- **Expand to read/write** after validation
- **Pair with moai-domain-database skill** for workflow guidance

### Insight 7: Agent Complexity Should Match Team Size

**Evidence:**
- Sam (individual): 8 agents
- Carlo (individual): 4 agents
- MOAI (enterprise): 31 agents

**Recommendation:**
- **For individual use:** 4-8 agents sufficient (Carlo/Sam approach)
- **For small team (2-5):** 10-15 agents reasonable
- **For enterprise:** 20+ agents (MOAI approach)
- **Your Phase 1:** Zero agents (correct for foundation phase)
- **Your Phase 2:** Start with 3-5 agents (search, documentation, code-review, context7, postgres)

### Insight 8: SPEC-First TDD is Powerful but Disruptive

**Evidence:**
- MOAI claims 80% reduction in rework, 2-3 weeks → 3-5 days development
- Phase 1 explicitly excluded moai-foundation-specs to preserve obra's TDD
- Adopting SPEC-First requires workflow change, training

**Recommendation:**
- **Keep obra's RED-GREEN-REFACTOR for now** (established workflow)
- **Experiment with SPEC-First on 1-2 projects** in Phase 2
- **Create custom spec-authoring skill** if beneficial (simpler than full MOAI adoption)
- **Don't force metodology change without proven value**

### Insight 9: Multi-Language Support is Over-Engineering for Many

**Evidence:**
- MOAI supports 25+ languages (Korean-first design)
- Sam enforces Australian English only
- Carlo uses English only
- You're US-based, English-speaking

**Recommendation:**
- **Skip multi-language support** (not needed for your use case)
- **Use American English** (not Australian)
- **Focus token budget on capabilities**, not localization

### Insight 10: Build Systems are Optional

**Evidence:**
- Carlo uses Mise (5 tasks for compilation/deployment)
- Sam has no build system
- MOAI uses Python packaging

**Recommendation:**
- **Skip build system initially** (Sam proves it's optional)
- **If configuration complexity grows** (8+ rule files, symlink management), adopt Mise pattern
- **For now, use git for versioning**, manual deployment for simplicity

---

## Phase 2 Roadmap with MCP Integration

### Phase 2 Goals (Revised)

**Original Phase 2 (from Phase 1 design):**
1-9. Configuration systems deep dive (agents, hooks, rules)
10-14. Skill verification and creation

**Revised Phase 2 (incorporating MCP analysis):**

**Phase 2A: MCP Integration (Weeks 1-3)**
1. Implement Context7 MCP with integrator agent
2. Implement PostgreSQL MCP with integrator agent
3. Evaluate and potentially enable Playwright MCP
4. Create custom mcp-context7-integrator agent
5. Create custom mcp-postgres-integrator agent
6. Measure token savings and quality improvement

**Phase 2B: Cost Optimization (Weeks 4-5)**
7. Implement Haiku search agent (Carlo's pattern)
8. Measure actual token usage baseline (before/after)
9. Implement progressive disclosure optimizations
10. Document cost savings metrics

**Phase 2C: Custom Skills (Weeks 6-7)**
11. Verify moai pytest-specific skills exist (or create custom)
12. Verify moai data-viz skills exist (or create custom)
13. Create custom NLP/ML skill (BERTopic, embeddings, topic modeling)

**Phase 2D: Configuration Systems (Weeks 8-10)**
14. Implement 2 hooks (SessionStart, UserPromptSubmit) using Carlo's pattern
15. Create 3-5 custom agents (search, documentation, code-review, mcp-integrators)
16. Craft hybrid global rules (Sam + Carlo patterns, no Australian English)
17. Evaluate workflow commands (decide if /alfred-style commands valuable)

### Detailed Phase 2A: MCP Integration (Priority)

**Week 1: Context7 MCP**

**Implementation:**
```json
// Add to ~/.claude/settings.json
"mcpServers": {
  "context7": {
    "command": "npx",
    "args": ["-y", "@upstash/context7-mcp"],
    "env": {
      "UPSTASH_CONTEXT7_API_KEY": "your-key-here"
    },
    "timeout": 30000
  }
}
```

**Tasks:**
1. Install Context7 MCP via npx
2. Obtain Upstash API key
3. Create `.claude/agents/mcp-context7-integrator.md` agent (following MOAI's pattern)
4. Test with Python/FastAPI documentation lookup
5. Test with TypeScript/React documentation lookup
6. Create session management workflow (save/resume in `.moai/sessions/`)

**Success Metrics:**
- Reduced hallucination on API usage
- Latest API version references (FastAPI 0.115, React 19)
- Research session resume working
- Documentation lookup <5 seconds

**Week 2: PostgreSQL MCP**

**Implementation:**
```json
// Add to ~/.claude/settings.json
"mcpServers": {
  "postgres": {
    "command": "uvx",
    "args": ["mcp-server-postgres", "postgresql://user:pass@localhost:5432/dbname"],
    "timeout": 60000
  }
}
```

**Tasks:**
1. Install PostgreSQL MCP server (`stuzero/pg-mcp-server` recommended)
2. Configure read-only connection to Python419 database (test safely)
3. Create `.claude/agents/mcp-postgres-integrator.md` agent
4. Test schema inspection, query analysis
5. Integrate with moai-domain-database skill
6. Document query patterns and best practices

**Success Metrics:**
- Schema inspection working (tables, columns, constraints)
- Query explanation and optimization
- Integration with moai-domain-database skill
- Safe read-only operation confirmed

**Week 3: Playwright MCP (Optional)**

**Already in config (disabled), just enable:**
```json
// Already present in your config, change enabled: false → true
"mcpServers": {
  "chrome-browser-use": {
    "command": "npx",
    "args": ["-y", "@browsermcp/mcp"],
    "enabled": true  // Change this
  }
}
```

**Tasks:**
1. Enable Playwright MCP in settings
2. Test browser automation for React frontends (fitbod, hearing-test)
3. Create E2E test workflow with playwright-integrator agent
4. Document screenshot capture and form validation patterns

**Success Metrics:**
- E2E tests for React apps working
- Screenshot validation automated
- Form validation workflows documented

### Detailed Phase 2B: Cost Optimization

**Week 4: Haiku Search Agent**

**Create `.claude/agents/search.md` (following Carlo's pattern):**
```yaml
---
name: search
description: Fast code location finding with minimal context pollution
color: orange
tools: Grep, Glob, Read, Bash
model: haiku
allowed-tools: [Grep, Glob, Read, Bash]
---

# Search Agent

**Model**: Haiku (cost-optimized)
**Purpose**: Isolated expensive search operations

## Performance Targets
- <10 file reads per search
- <30 seconds completion
- <5K tokens context usage

## Output Format
```
SEARCH RESULT: found|partial|not_found
CONFIDENCE: high|medium|low
LOCATIONS: [file paths with line ranges]
SEARCH STRATEGY: [methodology used]
STATS: [files searched, files read, grep iterations]
```
```

**Tasks:**
1. Create search agent markdown file
2. Test with codebase location queries
3. Measure token usage (before/after)
4. Document search strategies (keyword, pattern, layered expansion)

**Success Metrics:**
- Search operations <5K tokens (vs. 20-40K in main conversation)
- 90-95% token savings on exploratory searches
- <30 second search completion

**Week 5: Measure and Document**

**Tasks:**
1. Collect token usage baseline (from Claude Code sessions before optimization)
2. Collect token usage after optimization (search agent, progressive disclosure)
3. Calculate actual cost savings percentage
4. Document optimization strategies in CONFIGURATION_DECISIONS.md
5. Update Phase 2 plan with measured results

### Detailed Phase 2C: Custom Skills

**Week 6: NLP/ML Skill**

**Create `.claude/skills/nlp-ml-workflows/SKILL.md`:**
- BERTopic topic modeling patterns
- Spacy NLP pipelines
- Transformers fine-tuning
- Embeddings generation and storage
- Performance optimization for large text corpora

**Projects:** knowledge-extraction-suite

**Week 7: Pytest Patterns (if moai doesn't have)**

**Create `.claude/skills/pytest-patterns/SKILL.md`:**
- Fixture design patterns
- SQLAlchemy testing (in-memory databases, session management)
- FastAPI TestClient overrides
- Async test patterns
- Coverage reporting and thresholds

**Projects:** All Python projects

### Detailed Phase 2D: Configuration Systems

**Week 8: Hooks Implementation**

**SessionStart Hook (`.claude/hooks/session-start.sh`):**
```bash
#!/bin/bash
# Inject using-superpowers skill at session start
SKILL_PATH="$HOME/.claude/skills/superpowers:using-superpowers/SKILL.md"
if [ -f "$SKILL_PATH" ]; then
  cat <<EOF
{
  "additionalContext": "<EXTREMELY_IMPORTANT>$(cat "$SKILL_PATH")</EXTREMELY_IMPORTANT>"
}
EOF
else
  echo '{"additionalContext": ""}'
fi
```

**UserPromptSubmit Hook (`.claude/hooks/user-prompt-submit.sh`):**
```bash
#!/bin/bash
cat <<EOF
{
  "additionalContext": "<IMPORTANT>Remember to use relevant skills from your skills library.</IMPORTANT>"
}
EOF
```

**Configure in `~/.claude/settings.json`:**
```json
"hooks": {
  "SessionStart": [
    {
      "matcher": "startup|resume|clear|compact",
      "command": "/Users/yourname/.claude/hooks/session-start.sh"
    }
  ],
  "UserPromptSubmit": [
    {
      "matcher": ".*",
      "command": "/Users/yourname/.claude/hooks/user-prompt-submit.sh"
    }
  ]
}
```

**Week 9-10: Agents and Rules**

**Create 5 Custom Agents:**
1. **search.md** (Haiku, cost-optimized)
2. **documentation-generator.md** (Sonnet, quality-optimized)
3. **code-reviewer.md** (Sonnet, quality-optimized, using obra patterns)
4. **mcp-context7-integrator.md** (Sonnet, MCP specialist)
5. **mcp-postgres-integrator.md** (Sonnet, MCP specialist)

**Craft Hybrid Global Rules (CLAUDE.md):**

Combine best of Sam + Carlo:
- Token efficiency strategies (progressive disclosure, file size limits)
- Anti-fluff language (banned AI-isms)
- Honest partnership (Carlo's "don't glaze me")
- Git safety protocols (atomic commits, conventional format)
- Cost awareness (use Haiku when appropriate)
- Systematic thinking (step-by-step processes)

**Exclude:**
- Australian English enforcement
- Korean/multi-language support
- Overly prescriptive skill usage mandates

---

## Implementation Priorities

### Priority 1: High-Value MCPs (Immediate Impact)

**Context7 MCP** - Priority 1A
- **Why first:** Eliminates hallucination, latest API knowledge for all languages
- **Effort:** Low (npx installation, API key)
- **Impact:** High (affects all development)
- **Timeline:** Week 1 of Phase 2

**PostgreSQL MCP** - Priority 1B
- **Why second:** Critical for database-heavy projects (Python419, fitbod, hearing-test)
- **Effort:** Medium (server setup, connection config, safety validation)
- **Impact:** High (affects database work)
- **Timeline:** Week 2 of Phase 2

### Priority 2: Cost Optimization (Quick Wins)

**Haiku Search Agent** - Priority 2A
- **Why:** Carlo proves 40-60% savings, simple to implement
- **Effort:** Low (single agent file, 300 lines)
- **Impact:** Medium-High (frequent searches get cheaper)
- **Timeline:** Week 4 of Phase 2

**Progressive Disclosure Optimization** - Priority 2B
- **Why:** Already using SKILL.md pattern, can enhance
- **Effort:** Low (mostly documentation)
- **Impact:** Medium (incremental improvement)
- **Timeline:** Week 5 of Phase 2

### Priority 3: Custom Skills (Fill Gaps)

**NLP/ML Workflows Skill** - Priority 3A
- **Why:** Specific to knowledge-extraction-suite project needs
- **Effort:** Medium (requires domain expertise documentation)
- **Impact:** Medium (one project benefits)
- **Timeline:** Week 6 of Phase 2

**Pytest Patterns Skill** - Priority 3B (conditional)
- **Why:** If moai doesn't provide this, it's needed for all Python projects
- **Effort:** Medium (requires testing expertise documentation)
- **Impact:** Medium (affects all Python projects)
- **Timeline:** Week 7 of Phase 2

### Priority 4: Configuration Infrastructure (Foundation)

**2 Hooks** - Priority 4A
- **Why:** Simple, proven (Carlo's approach), high ROI
- **Effort:** Low (two 10-20 line scripts)
- **Impact:** Low-Medium (skill awareness, context efficiency)
- **Timeline:** Week 8 of Phase 2

**Hybrid Global Rules** - Priority 4B
- **Why:** Codifies best practices, prevents token waste
- **Effort:** Medium (synthesize from Sam + Carlo)
- **Impact:** Medium (affects all sessions)
- **Timeline:** Week 9 of Phase 2

**5 Custom Agents** - Priority 4C
- **Why:** Enable delegation, cost optimization, MCP integration
- **Effort:** Medium-High (5 agents × 200-500 lines each)
- **Impact:** Medium-High (enables advanced workflows)
- **Timeline:** Weeks 8-10 of Phase 2

### Priority 5: Advanced Features (Deferred to Phase 3)

**Playwright MCP** - Priority 5A
- **Why:** Valuable for E2E testing but not critical
- **Effort:** Low (already in config, just enable)
- **Impact:** Low-Medium (affects frontend testing)
- **Timeline:** Phase 3 or as-needed

**/alfred-style Workflow Commands** - Priority 5B
- **Why:** MOAI's workflow is powerful but requires major change
- **Effort:** High (5 commands × 6-24KB each)
- **Impact:** Medium-High (systematic workflow benefits)
- **Timeline:** Phase 3, after evaluating Phase 2 success

**Additional Agents (beyond 5)** - Priority 5C
- **Why:** 5 agents likely sufficient for individual use
- **Effort:** Varies
- **Impact:** Diminishing returns
- **Timeline:** Phase 3, if specific needs emerge

---

## Quick Start: First 3 Actions for Phase 2

### Action 1: Enable Context7 MCP (Week 1, Day 1)

**Steps:**
1. Get Upstash API key: https://console.upstash.com/
2. Add to `~/.claude/settings.json`:
   ```json
   "mcpServers": {
     "context7": {
       "command": "npx",
       "args": ["-y", "@upstash/context7-mcp"],
       "env": {
         "UPSTASH_CONTEXT7_API_KEY": "cak_xxx..."
       },
       "timeout": 30000
     }
   }
   ```
3. Restart Claude Code
4. Test: "Use Context7 to look up FastAPI 0.115 Pydantic v2 integration patterns"
5. Verify: Claude uses `mcp__context7__resolve-library-id` and `mcp__context7__get-library-docs`

**Success Criteria:** Claude retrieves latest FastAPI docs, no hallucination

### Action 2: Create Haiku Search Agent (Week 1, Day 2-3)

**Steps:**
1. Create `.claude/agents/search.md` using Carlo's pattern (see Phase 2B above)
2. Test: "Use the search agent to find all FastAPI route definitions in the codebase"
3. Measure: Token usage in isolated agent vs. main conversation
4. Document: Actual token savings percentage

**Success Criteria:** Search completes in <5K tokens, 90%+ savings vs. main conversation

### Action 3: Measure Baseline (Week 1, Day 4-5)

**Steps:**
1. Review last 10 Claude Code sessions
2. Extract token usage from conversation history
3. Identify common expensive operations (searches, explorations, documentation lookups)
4. Document baseline metrics in `docs/COST_OPTIMIZATION_BASELINE.md`
5. Set targets for Phase 2 (e.g., "Reduce search token usage by 80%")

**Success Criteria:** Clear baseline established, measurable targets set

---

## Appendix: When to Use What

### Skills vs Agents vs MCPs - Decision Matrix

| Need | Use Skill When... | Use Agent When... | Use MCP When... |
|------|-------------------|-------------------|-----------------|
| **Knowledge** | Teaching patterns, best practices, workflows | Orchestrating complex multi-step tasks | Accessing latest external documentation |
| **Execution** | Guiding tool usage (Read, Write, Edit, Bash) | Delegating expensive operations (search, exploration) | Querying external systems (databases, APIs) |
| **Context** | Progressive disclosure (load on-demand) | Isolated context (prevent pollution) | Real-time data access (not stored in context) |
| **Cost** | Zero cost (loaded only when relevant) | Model selection (Haiku for simple tasks) | External API costs (but current data) |
| **Maintenance** | Update skill file when patterns change | Update agent when workflow changes | Update when external system changes |

### Examples:

**Use a Skill:**
- "How do I write a FastAPI endpoint with Pydantic validation?" → moai-lang-python skill
- "What's the pytest fixture pattern for SQLAlchemy testing?" → pytest-patterns skill
- "How do I debug a systematic problem?" → systematic-debugging skill

**Use an Agent:**
- "Find all occurrences of User model in the codebase" → search agent (Haiku, isolated context)
- "Review this code change for quality issues" → code-reviewer agent (Sonnet, quality focus)
- "Generate comprehensive documentation for this project" → documentation-generator agent (Sonnet, parallel task delegation)

**Use an MCP:**
- "What's the latest FastAPI documentation for async database connections?" → Context7 MCP
- "Show me the schema for the users table" → PostgreSQL MCP
- "Run an E2E test on the login form" → Playwright MCP

### Cost Optimization Decision Tree

```
Is the task exploratory? (searching, locating, browsing)
├─ YES → Use Haiku search agent (40-60% savings)
└─ NO → Is it complex reasoning or code generation?
    ├─ YES → Use Sonnet in main conversation
    └─ NO → Is it documentation lookup?
        ├─ YES → Use Context7 MCP (zero hallucination)
        └─ NO → Is it database query?
            ├─ YES → Use PostgreSQL MCP (current schema)
            └─ NO → Proceed with appropriate tool/skill
```

---

## Conclusion and Next Steps

### Key Takeaways

1. **Phase 1 was correct:** Skill foundation (37 skills) before configuration systems
2. **MCPs are powerful but selective:** Start with Context7 + PostgreSQL, expand carefully
3. **Cost optimization is achievable simply:** Haiku search agent (Carlo) provides 40-60% savings without complexity
4. **Hooks provide high ROI:** 2 simple hooks (Carlo) deliver skill awareness without token cost
5. **Agent count should match needs:** 5 agents sufficient for individual, 10-15 for team, 31 for enterprise
6. **SPEC-First TDD is optional:** Obra's RED-GREEN-REFACTOR working, don't force change
7. **Build systems are optional:** Git versioning + manual deployment sufficient initially

### Recommended Phase 2 Timeline (10 weeks)

**Weeks 1-3: MCP Integration**
- Context7 MCP + integrator agent
- PostgreSQL MCP + integrator agent
- Playwright MCP evaluation

**Weeks 4-5: Cost Optimization**
- Haiku search agent
- Baseline measurement
- Progressive disclosure enhancements

**Weeks 6-7: Custom Skills**
- NLP/ML workflows skill
- Pytest patterns skill (if moai doesn't have)
- Data visualization skill (if moai doesn't have)

**Weeks 8-10: Configuration Systems**
- 2 hooks (SessionStart, UserPromptSubmit)
- 5 custom agents (search, docs, review, context7, postgres)
- Hybrid global rules (Sam + Carlo, no Australian English)

### Success Metrics for Phase 2

**MCP Integration:**
- [ ] Context7 reduces API hallucination by 80%+
- [ ] PostgreSQL MCP enables schema inspection and query optimization
- [ ] Session management working (save/resume research)

**Cost Optimization:**
- [ ] Search operations use <5K tokens (down from 20-40K)
- [ ] Overall session cost reduced by 40-60%
- [ ] Haiku search agent completes in <30 seconds

**Custom Skills:**
- [ ] NLP/ML skill created and tested on knowledge-extraction-suite
- [ ] Pytest patterns skill created (if needed) and tested on Python projects
- [ ] Custom skills follow progressive disclosure pattern

**Configuration Systems:**
- [ ] Hooks implemented and working (session-start, user-prompt-submit)
- [ ] 5 agents created and tested
- [ ] Hybrid global rules documented and deployed
- [ ] No regressions in Phase 1 skills

### Next Immediate Action

**Create Phase 2 Implementation Plan:**
- Use this strategy document as input
- Create detailed task breakdown for weeks 1-3 (MCP integration)
- Set up measurement framework for cost optimization
- Schedule weekly review checkpoints

**Begin with Context7 MCP:**
- Highest impact, lowest effort
- Addresses immediate pain point (API documentation accuracy)
- Validates MCP integration architecture
- Provides quick win to build momentum

---

## Implementation Design

**UPDATE (2025-11-22):** A complete implementation plan for Priority 1 MCPs has been created based on this analysis.

**See:** `docs/plans/2025-11-22-priority1-mcp-integration-design.md`

**Key decisions from brainstorming session:**
- **Approach:** Parallel Foundation + Sequential Intelligence (10-day plan)
- **Strategy:** Lean-first, disabled-by-default, per-project enabling
- **Integration:** Hybrid (direct MCP tools + smart agents for complex workflows)
- **Workflow:** Discovery-driven patterns based on actual codebase analysis
- **Deployment:** All three MCPs at once (Context7, PostgreSQL, Playwright)

**Session details:** `docs/SESSION_2025-11-22_mcp-implementation-design.md`

---

**Document Version:** 1.0
**Date:** 2025-11-19
**Status:** Ready for Phase 2 Implementation
**Next Review:** After Week 3 of Phase 2 (MCP Integration Complete)

**UPDATE:** Implementation design completed 2025-11-22
