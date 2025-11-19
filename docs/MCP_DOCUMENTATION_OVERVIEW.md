# Comprehensive MCP Server Documentation Overview

**Repository**: /home/user/claude-skill-eval  
**Date**: 2025-11-19  
**Scope**: MCP documentation catalog across moAI, agentic-coding, claude-code-stuff, and tapestry systems

---

## 1. REPOSITORY SYSTEMS & STRUCTURES

### Primary Systems Identified

#### 1.1 moai-adk-main (MOAI Framework)
- **Path**: `/home/user/claude-skill-eval/moai-adk-main/`
- **Status**: Enterprise-grade, production-ready
- **MCP Integration**: 3 MCPs integrated (highest maturity)
- **Skills Count**: 125+ enterprise skills

#### 1.2 agentic-coding-main (Sam's Framework)
- **Path**: `/home/user/claude-skill-eval/agentic-coding-main/`
- **Status**: Production-proven, token-efficient
- **MCP Integration**: 1 always-on (dev-tools), 6 optional
- **MCP Configs**: Separate configuration files (MVP vs "sometimes")

#### 1.3 claude-code-stuff-main (Carlo's Framework)
- **Path**: `/home/user/claude-skill-eval/claude-code-stuff-main/`
- **Status**: Cost-optimized (40-60% savings)
- **MCP Integration**: 0 MCPs (pure CLI tool approach)
- **Philosophy**: Zero external MCP dependencies

#### 1.4 tapestry-skills-for-claude-code-main
- **Path**: `/home/user/claude-skill-eval/tapestry-skills-for-claude-code-main/`
- **Focus**: Content extraction and action planning skills

#### 1.5 skills/ (Shared Skills Library)
- **Path**: `/home/user/claude-skill-eval/skills/`
- **Content**: 130+ modular skills including MCP-related skills
- **Key MCP Skills**: moai-mcp-builder, moai-cc-mcp-builder, moai-cc-mcp-plugins

---

## 2. MCP SERVER DOCUMENTATION BY SYSTEM

### 2.1 MOAI-ADK MCP Integration (Most Mature)

#### Configured MCPs (3 Always-On)

**1. Context7 MCP** (`@upstash/context7-mcp`)
- **Configuration**: `/home/user/claude-skill-eval/moai-adk-main/src/moai_adk/templates/.mcp.json`
- **Purpose**: Latest API documentation, 13,157+ code examples
- **Tools Available**: 
  - `resolve-library-id` - Find library identifiers
  - `get-library-docs` - Retrieve latest documentation
- **Timeout**: 30 seconds
- **Retries**: 3 attempts before failure
- **Integration**: Dedicated `mcp-context7-integrator` agent
- **Session Management**: Save/resume research in `.moai/sessions/`
- **Auto-Triggers**: Keywords like "official documentation", "API reference", "check docs"

**2. Playwright MCP** (`@playwright/mcp`)
- **Purpose**: Browser automation, E2E testing
- **Tools**: Screenshot capture, form interaction, UI testing
- **Integration**: Dedicated `mcp-playwright-integrator` agent
- **Use Cases**: UI testing, form validation, visual regression

**3. Sequential Thinking MCP** (`@modelcontextprotocol/server-sequential-thinking`)
- **Purpose**: Complex reasoning, multi-step problem solving
- **Tool**: `mcp__sequential_thinking_think`
- **Integration**: Dedicated `mcp-sequential-thinking-integrator` agent
- **Benefit**: Transparent reasoning for architecture decisions

#### MCP Integrator Agents (Specialized Agents)

Located: `/home/user/claude-skill-eval/moai-adk-main/.claude/agents/alfred/`

**mcp-context7-integrator.md** (v1.0.0)
- **Function**: Documentation research specialist
- **Capabilities**:
  - Query effectiveness analysis
  - Documentation quality assessment
  - Research pattern recognition
  - Performance metrics monitoring
  - Smart query suggestions with typo correction
  - Context-aware research based on project type
  - Knowledge base management
- **Auto-triggers**: Documentation requests, query failures
- **Collaboration**: Works with other agents (playwright, sequential-thinking, spec-builder)
- **Tool Access**: Read, Write, Edit, Glob, Bash, WebFetch, AskUserQuestion, Context7 MCP tools

**mcp-notion-integrator.md** (v1.0.0)
- **Function**: Notion workspace integration
- **Purpose**: Project management and documentation sync
- **File Size**: 18,477 bytes (largest integrator agent)

**mcp-playwright-integrator.md** (v1.0.0)
- **Function**: Browser automation specialist
- **Capabilities**: E2E testing, UI automation, screenshot validation
- **File Size**: 8,848 bytes

**mcp-sequential-thinking-integrator.md** (v1.0.0)
- **Function**: Complex reasoning coordinator
- **Use Cases**: Architecture decisions, systematic problem-solving
- **File Size**: 9,736 bytes

---

### 2.2 Sam's agentic-coding Framework MCP Integration

#### Configuration Files

**mcp-config-mvp.json**
```json
{
  "mcpServers": {
    "dev-tools": {
      "disabled": false,
      "timeout": 600s,
      "command": "/Users/samm/go/bin/mcp-devtools",
      "env": {
        "BRAVE_API_KEY": "redacted"
      }
    }
  }
}
```
- **Philosophy**: Minimal by default (1 MCP always-on)
- **MCP**: dev-tools (custom Go binary)
- **Features**: Brave search, security functions
- **Rationale**: Avoid token pollution from MCP tool descriptions

**mcp-config-sometimes.json**
- **Status**: Optional MCPs (all disabled by default)
- **MCPs Included**:
  1. **chrome-browser-use** - Browser automation
  2. **chrome-browser-control** - Browser control
  3. **markdownify** - File/document conversion (10 supported formats)
  4. **@21st-dev/magic** - Enhanced capabilities
  5. **memory-bank** - Persistent session memory
  6. **figma-mcp** - Design system integration

#### Key Insights
- Token-conscious approach (high timeouts: 60-600s)
- Auto-approval for frequently used operations
- Enable selectively based on task needs

---

### 2.3 Carlo's claude-code-stuff Framework (Zero-MCP Approach)

**Philosophy**: No MCPs, CLI tool wrapping instead
- **Tools Used**: kagi-ken-cli, linearis, interfazzle
- **Integration**: Via Skills layer + Bash tool wrapping
- **Example**: `using-linear` skill wraps linearis CLI
- **Benefits**:
  - Zero external MCP dependencies
  - Complete control over tool integration
  - No MCP server management overhead
  - Proven cost optimization (40-60% savings without MCPs)

---

## 3. MCP DOCUMENTATION & REFERENCE FILES

### 3.1 MCP Builder Skills

#### moai-cc-mcp-builder Skill (Enterprise Grade)
- **Path**: `/home/user/claude-skill-eval/skills/moai-cc-mcp-builder/`
- **Version**: 4.0.0 (2025-11-11)
- **Status**: Stable, production-ready
- **Tier**: Essential AI-Powered Development
- **AI Integration**: Context7 MCP for latest standards

**Capabilities**:
- Intelligent architecture design with ML-based pattern recognition
- AI-enhanced code generation using Context7
- Agent-centric tool design with AI optimization
- Real-time schema validation
- Automated best practice application
- Performance optimization with AI profiling
- Predictive maintenance using ML pattern analysis

**Reference Documentation**:
- `reference/mcp_best_practices.md` - Best practices guide
- `reference/python_mcp_server.md` - Python/FastAPI patterns
- `reference/node_mcp_server.md` - Node/TypeScript patterns
- `reference/evaluation.md` - Quality metrics and evaluation

**Languages Supported**: Python (FastMCP), Node/TypeScript (MCP SDK)  
**Frameworks**: FastAPI, Express.js, MCP SDK, FastMCP

#### moai-mcp-builder Skill
- **Location**: `/home/user/claude-skill-eval/skills/moai-mcp-builder/`
- **Status**: Stable (2025-11-11)
- **Content**:
  - `SKILL.md` - Main skill documentation
  - `reference.md` - Comprehensive reference
  - `examples.md` - Usage examples
  - `reference/` folder with detailed guides

#### mcp-builder Skill
- **Location**: `/home/user/claude-skill-eval/skills/mcp-builder/`
- **Status**: Baseline skill for MCP development
- **Documentation Structure**:
  - SKILL.md (core documentation)
  - reference/evaluation.md
  - reference/mcp_best_practices.md
  - reference/python_mcp_server.md
  - reference/node_mcp_server.md

### 3.2 MCP Plugins & Configuration Skill

#### moai-cc-mcp-plugins Skill
- **Path**: `/home/user/claude-skill-eval/skills/moai-cc-mcp-plugins/`
- **Purpose**: MCP server configuration and plugin management
- **Content**: 
  - `SKILL.md` - Configuration guide
  - `templates/settings-mcp-template.json` - MCP configuration template

### 3.3 Strategic Documentation Files

#### FRAMEWORK_MCP_ANALYSIS_AND_STRATEGY.md (38KB)
- **Location**: `/home/user/claude-skill-eval/docs/FRAMEWORK_MCP_ANALYSIS_AND_STRATEGY.md`
- **Comprehensive Analysis**:
  - Framework comparison matrix (Sam vs Carlo vs MOAI)
  - MCP integration analysis for all three frameworks
  - Configuration architecture patterns
  - Strategic insights and recommendations
  - Phase 2 roadmap with MCP integration
  - Implementation priorities
  - When to use Skills vs Agents vs MCPs (decision matrix)

**Key Recommendations from Document**:
1. Context7 MCP should be Priority 1 (eliminates hallucination)
2. PostgreSQL MCP should be Priority 2 (critical for database-heavy projects)
3. Start with Haiku search agent for cost optimization (Carlo's pattern)
4. Create 2 hooks (SessionStart, UserPromptSubmit) following Carlo's pattern
5. Create 5 custom agents (search, docs, review, context7, postgres)

#### PHASE2_README.md (53KB)
- **Location**: `/home/user/claude-skill-eval/PHASE2_README.md`
- **Content**: Configuration systems for process discipline
- **Problem Solved**: Ad-hoc debugging, inconsistent implementations, skipped quality checks
- **Solution**: 3 specialized agents (debug, consistency, quality)
- **Architecture**: Rules layer, Agents layer, Hooks layer

#### REPOSITORY_SUMMARY.md (35KB)
- **Location**: `/home/user/claude-skill-eval/REPOSITORY_SUMMARY.md`
- **Coverage**: Overview of all three frameworks and Phase 1/2 implementation

#### CUSTOM_CONFIGURATION_BRAINSTORM.md (30KB)
- **Location**: `/home/user/claude-skill-eval/CUSTOM_CONFIGURATION_BRAINSTORM.md`
- **Content**: Ideas for custom configuration based on framework analysis

---

## 4. MCP CONFIGURATION FILES

### Configuration File Locations

| Framework | Config Files | Location |
|-----------|--------------|----------|
| **MOAI-ADK** | .mcp.json | `/moai-adk-main/src/moai_adk/templates/.mcp.json` |
| **Sam's** | mcp-config-mvp.json | `/agentic-coding-main/MCP/mcp-config-mvp.json` |
| **Sam's** | mcp-config-sometimes.json | `/agentic-coding-main/MCP/mcp-config-sometimes.json` |
| **Carlo's** | None | Zero-MCP approach |
| **Template** | settings-mcp-template.json | `/skills/moai-cc-mcp-plugins/templates/` |

### MCP Servers Across All Frameworks

| MCP Server | MOAI | Sam | Carlo | Purpose |
|-----------|------|-----|-------|---------|
| **Context7** | ✅ Always | ❌ | ❌ | Latest API docs, 13K+ examples |
| **Playwright** | ✅ Always | ❌ Optional | ❌ | Browser automation, E2E testing |
| **Sequential Thinking** | ✅ Always | ❌ | ❌ | Complex reasoning |
| **dev-tools** | ❌ | ✅ Always | ❌ | Brave search, security |
| **chrome-browser-use** | ❌ | ❌ Optional | ❌ | Browser automation |
| **markdownify** | ❌ | ❌ Optional | ❌ | File conversion to Markdown |
| **memory-bank** | ❌ | ❌ Optional | ❌ | Persistent memory |
| **figma-mcp** | ❌ | ❌ Optional | ❌ | Design system integration |
| **GitHub MCP** | ❌ | ❌ | ❌ | Issue/PR management (recommended) |
| **PostgreSQL MCP** | ❌ | ❌ | ❌ | Database access (recommended) |

---

## 5. MCP INTEGRATION PATTERNS

### Pattern 1: Dedicated Integrator Agents (MOAI Pattern)

Each MCP has a specialized agent managing it:

```
MCP Server (e.g., Context7)
    ↓
Integrator Agent (e.g., mcp-context7-integrator)
    ↓
Skill Invocation
    ↓
Main Task Execution
```

**Benefits**:
- Encapsulates MCP best practices
- Provides fallback strategies when MCP unavailable
- Monitors research effectiveness
- Query optimization
- Session management and resume capability

### Pattern 2: Token Efficiency with Agent Delegation (MOAI Pattern)

- **Monolithic approach**: Load everything (130,000+ tokens)
- **Agent delegation**: 20,000-30,000 tokens per agent (82% reduction)
- **Result**: 80-85% token savings, 3-5x faster processing

### Pattern 3: Minimal MCP Approach (Sam's Pattern)

- 1 MCP always-on (dev-tools)
- 6 optional MCPs (disabled by default)
- High timeouts (600s) for complex operations
- Auto-approval for frequently used operations
- Token-conscious configuration

### Pattern 4: Zero-MCP with CLI Wrapping (Carlo's Pattern)

- No MCPs at all
- CLI tools wrapped in skills
- Complete control over tool integration
- No MCP server management
- Proven cost optimization

---

## 6. MCP DOCUMENTATION QUALITY ASSESSMENT

### Comprehensive Documentation (Excellent)

**MOAI-ADK**:
- ✅ 3 MCPs with dedicated integrator agents
- ✅ Clear configuration in .mcp.json
- ✅ CLAUDE.md with extensive MCP integration details
- ✅ Session management for research workflows
- ✅ Auto-trigger keywords documented
- ✅ Agent collaboration documented
- ✅ Performance metrics and KPIs

**MCP Builder Skills**:
- ✅ moai-cc-mcp-builder v4.0.0 with Context7 integration
- ✅ Detailed reference documentation
- ✅ Python and Node/TypeScript examples
- ✅ Best practices guide
- ✅ Evaluation criteria

**Strategic Documentation**:
- ✅ FRAMEWORK_MCP_ANALYSIS_AND_STRATEGY.md (comprehensive 38KB analysis)
- ✅ Comparison matrix of all frameworks
- ✅ MCP integration decision matrix
- ✅ Phase 2 roadmap with MCP priorities
- ✅ Cost optimization strategies

### Moderate Documentation (Good)

**Sam's Framework**:
- ✅ Two MCP configurations (MVP vs Sometimes)
- ✅ Clear dev-tools configuration
- ✅ Optional MCPs listed with timeouts
- ⚠️ Less detailed integration guidance
- ⚠️ Philosophy documented but limited examples

**Carlo's Framework**:
- ✅ Zero-MCP approach well-defined
- ✅ CLI tool wrapping patterns shown
- ⚠️ No dedicated MCP documentation (intentional)

### Minimal Documentation (Limited)

**PostgreSQL MCP**:
- ❌ Not implemented in any framework
- ⚠️ Recommended but not documented
- ⚠️ High priority gap (critical for database projects)

**GitHub MCP**:
- ❌ Not implemented
- ⚠️ Recommended but not documented

---

## 7. SKILLS INVENTORY FOR MCP DEVELOPMENT

### Core MCP Skills

1. **moai-cc-mcp-builder** (v4.0.0) - Enterprise MCP development with Context7
2. **moai-mcp-builder** - Standard MCP building patterns
3. **mcp-builder** - Baseline MCP development
4. **moai-cc-mcp-plugins** - MCP configuration and plugins

### Related Supporting Skills

5. **moai-context7-integration** - Context7 MCP usage patterns
6. **moai-context7-lang-integration** - Language-specific Context7 patterns
7. **moai-cc-configuration** - Claude Code configuration
8. **moai-cc-hooks** - Hook implementation patterns

---

## 8. KEY FINDINGS & RECOMMENDATIONS

### Critical Gaps Identified

1. **PostgreSQL MCP** (Priority 1)
   - Zero implementations across all frameworks
   - Critical for Python419, fitbod, hearing-test projects
   - Mature ecosystem: `gldc/mcp-postgres`, `stuzero/pg-mcp-server`

2. **GitHub MCP** (Priority 2)
   - Zero implementations
   - Standard for development workflows
   - Issue/PR management essential

3. **Playwright MCP Documentation** (Priority 3)
   - Only MOAI has it (with agent)
   - Sam has optional config but no integration docs
   - Need more examples and best practices

### Strategic Recommendations

**Phase 2A (Weeks 1-3): MCP Integration**
- [ ] Implement Context7 MCP + mcp-context7-integrator agent
- [ ] Implement PostgreSQL MCP + mcp-postgres-integrator agent
- [ ] Evaluate and enable Playwright MCP

**Phase 2B (Weeks 4-5): Cost Optimization**
- [ ] Implement Haiku search agent (Carlo's pattern)
- [ ] Measure baseline token usage
- [ ] Document cost savings

**Phase 2C (Weeks 6-7): Custom Skills**
- [ ] Create NLP/ML workflows skill
- [ ] Create Pytest patterns skill (if moai doesn't have)

**Phase 2D (Weeks 8-10): Configuration Systems**
- [ ] Implement 2 hooks (SessionStart, UserPromptSubmit)
- [ ] Create 5 custom agents
- [ ] Craft hybrid global rules

### MCP Selection Decision Matrix

| Use Skill When... | Use Agent When... | Use MCP When... |
|---|---|---|
| Teaching patterns, best practices, workflows | Orchestrating complex multi-step tasks | Accessing latest external documentation |
| Guiding tool usage | Delegating expensive operations (search) | Querying external systems (databases, APIs) |
| Progressive disclosure (load on-demand) | Isolated context (prevent pollution) | Real-time data access (not stored in context) |
| Zero cost | Model selection (Haiku for simple) | External API costs (but current data) |

---

## 9. QUICK REFERENCE: MCP CAPABILITIES BY FRAMEWORK

### MOAI-ADK (Enterprise, 3 MCPs, Highest Maturity)
```
✅ Context7: Latest API documentation
✅ Playwright: E2E testing and automation
✅ Sequential Thinking: Complex reasoning
✅ Notion: Project management integration
✅ 4 dedicated integrator agents
✅ Session management and resume
✅ Performance monitoring
✅ Auto-trigger keywords
```

### Sam's Framework (Production-Proven, 1+6 MCPs, Minimal)
```
✅ dev-tools (always-on): Search, security
⚠️ Optional: Browser, file conversion, memory, design
✅ Token-conscious configuration
✅ High timeouts for complex operations
✅ Auto-approval for frequent ops
```

### Carlo's Framework (Cost-Optimized, 0 MCPs, Zero Dependencies)
```
✅ No external MCP dependencies
✅ CLI tool wrapping via skills
✅ 40-60% cost savings proven
✅ Complete control over tools
✅ Zero MCP server management
```

---

## 10. FILES LOCATION REFERENCE

### Documentation Files
```
/home/user/claude-skill-eval/
├── docs/
│   ├── FRAMEWORK_MCP_ANALYSIS_AND_STRATEGY.md (38KB) ⭐ PRIMARY
│   ├── plans/
│   │   ├── phase2.5-config-mcp-analysis.md (23KB)
│   │   └── 2025-11-18-phase2-configuration-systems.md (10KB)
│   └── phase2-handoff.md (23KB)
├── PHASE2_README.md (53KB)
├── REPOSITORY_SUMMARY.md (35KB)
└── CUSTOM_CONFIGURATION_BRAINSTORM.md (30KB)
```

### MCP Configuration Files
```
/home/user/claude-skill-eval/
├── moai-adk-main/
│   └── src/moai_adk/templates/.mcp.json
├── agentic-coding-main/
│   └── MCP/
│       ├── mcp-config-mvp.json
│       └── mcp-config-sometimes.json
└── skills/moai-cc-mcp-plugins/templates/settings-mcp-template.json
```

### MCP Agent Files (MOAI)
```
/home/user/claude-skill-eval/moai-adk-main/.claude/agents/alfred/
├── mcp-context7-integrator.md ⭐ PRIMARY
├── mcp-notion-integrator.md
├── mcp-playwright-integrator.md
└── mcp-sequential-thinking-integrator.md
```

### MCP Builder Skills
```
/home/user/claude-skill-eval/skills/
├── moai-cc-mcp-builder/ (v4.0.0) ⭐ ENTERPRISE
│   ├── SKILL.md
│   └── reference/
│       ├── mcp_best_practices.md
│       ├── python_mcp_server.md
│       ├── node_mcp_server.md
│       └── evaluation.md
├── moai-mcp-builder/
│   ├── SKILL.md
│   ├── reference.md
│   ├── examples.md
│   └── reference/ (detailed guides)
└── mcp-builder/
    └── reference/
        ├── mcp_best_practices.md
        ├── python_mcp_server.md
        └── node_mcp_server.md
```

---

## CONCLUSION

The repository contains **comprehensive MCP documentation** across multiple frameworks:

1. **MOAI-ADK** has the most mature MCP integration (3 MCPs + integrator agents)
2. **Sam's framework** has a well-thought-out minimal approach (1 always-on + 6 optional)
3. **Carlo's framework** demonstrates zero-MCP is viable with CLI wrapping
4. **Strategic documentation** (especially FRAMEWORK_MCP_ANALYSIS_AND_STRATEGY.md) provides clear roadmap
5. **MCP builder skills** provide templates and best practices for creating custom MCPs
6. **Critical gaps**: PostgreSQL and GitHub MCPs are recommended but not implemented

**Recommended Next Steps**:
- Prioritize Context7 MCP integration (highest impact)
- Implement PostgreSQL MCP (critical for data projects)
- Create 4 integrator agents following MOAI pattern
- Follow Phase 2 roadmap (10-week implementation plan)

