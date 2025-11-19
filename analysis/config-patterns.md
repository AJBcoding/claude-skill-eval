# Configuration Patterns Analysis

Analysis of configuration structures from three Claude Code frameworks: Carlo's claude-code-stuff, Sam's Agentic Coding, and MoAI-ADK.

**Date**: 2025-11-19
**Frameworks Analyzed**:
- Carlo Zottmann's claude-code-stuff-main (obra-inspired)
- Sam McLeod's agentic-coding-main/Claude
- MoAI-ADK (moai-adk-main)

---

## Framework Overviews

### 1. Carlo's Framework (claude-code-stuff-main)

**Location**: `/home/user/claude-skill-eval/claude-code-stuff-main`

**Philosophy**: Hybrid architecture combining custom Swift/iOS development tools with battle-tested engineering practices from obra/superpowers.

**Key Characteristics**:
- Modular rule compilation pattern
- Symlink-based deployment
- Separation of concerns (rules, skills, agents)
- Integration with external dependencies via git submodules
- Task automation via mise

**Structure**:
```
claude-code-stuff/
├── agents/              # Specialized sub-agents (4 agents)
├── rules/               # Individual behavior guidelines (11 files)
├── skills/              # Custom + linked superpowers skills
├── libs/superpowers/    # Git submodule (obra/superpowers)
├── .build/              # Compiled AGENTS.md
└── mise-tasks/          # Automation scripts
```

### 2. Sam's Framework (agentic-coding-main/Claude)

**Location**: `/home/user/claude-skill-eval/agentic-coding-main/Claude`

**Philosophy**: Practical, opinionated rules focused on efficiency, cost optimization, and preventing common AI coding pitfalls.

**Key Characteristics**:
- XML-style pseudo-markup for LLM adherence
- Strong emphasis on Australian English spelling
- Context window management guidance
- Anti-pattern prevention (avoiding placeholders, marketing language)
- Tool-use optimization
- MCP integration patterns

**Structure**:
```
Claude/
├── CLAUDE.md            # Master global rules file
├── agents/              # Specialized sub-agents (8 agents)
├── skills/              # Domain-specific skills (12 skills)
├── commands/            # Slash commands
├── output-styles/       # Output formatting options
└── settings.json        # Configuration
```

### 3. MoAI-ADK Framework (moai-adk-main)

**Location**: `/home/user/claude-skill-eval/moai-adk-main`

**Philosophy**: Enterprise-grade SPEC-First TDD development with comprehensive agent orchestration and Claude Code v4.0 integration.

**Key Characteristics**:
- SPEC-First philosophy (EARS format requirements)
- 4-phase workflow (Plan → Run → Sync → Deploy)
- Extensive agent delegation patterns (19+ specialized agents)
- Comprehensive hooks system (SessionStart, PreToolUse, PostToolUse, SessionEnd)
- Multi-language support (50+ languages)
- Context7 MCP integration
- TRUST 5 quality principles

**Structure**:
```
.claude/
├── settings.json        # Comprehensive config with hooks, permissions, MCP
├── agents/alfred/       # 31 specialized domain agents
├── commands/alfred/     # 4-phase workflow commands
├── commands/moai/       # Framework commands
├── skills/              # MoAI-specific skills
├── hooks/alfred/        # Python hooks for lifecycle events
└── output-styles/       # Persona-based output formatting
```

---

## Configuration Patterns by Framework

### Carlo's Configuration Patterns

#### 1. Rules Compilation Pattern

**Pattern**: Modular rule files compiled into single CLAUDE.md

**Implementation**:
- Individual rule files in `/rules/` directory
- Numbered for ordering (0-start.md, 1-skills-usage.md)
- Build script concatenates into `.build/AGENTS.md`
- Symlinked to `~/.claude/CLAUDE.md`

**Example** (`rules/0-start.md`):
```markdown
You are an experienced, pragmatic software engineer.

Rule #1: If you want exception to ANY rule, YOU MUST STOP and get
explicit permission from Carlo first.

## Foundational rules
- Doing it right is better than doing it fast
- Tedious, systematic work is often the correct solution
- Honesty is a core value

## Our relationship
- We're colleagues working together as "Carlo" and "Claude"
- Don't glaze me. The last assistant was a sycophant
- YOU MUST speak up immediately when you don't know something
```

**Benefits**:
- Easy to maintain individual rules
- Clear separation of concerns
- Version controlled changes
- Instant updates via symlinks

#### 2. Agent Definition Pattern

**Pattern**: YAML frontmatter + markdown content

**Implementation**:
```markdown
---
name: search
description: "Isolates expensive search operations..."
color: orange
tools: Grep, Glob, Read, Bash
model: haiku
---

You are a specialized code search agent...

## Core Responsibilities
1. Rapid grep iterations
2. Smart filtering
3. Validate findings
```

**Key Elements**:
- Clear role definition
- Specific tool permissions
- Model selection for cost optimization
- Structured output format requirements

#### 3. Skill Integration Pattern

**Pattern**: Custom skills + external library symlinks

**Implementation**:
- Custom skills in `skills/` directory
- Superpowers skills linked via `libs/superpowers/`
- Namespaced external skills: `superpowers:brainstorming`
- Build tasks handle linking

**Benefits**:
- Mix domain expertise with proven practices
- Update components independently
- Single source of truth

### Sam's Configuration Patterns

#### 1. Structured Global Rules

**Pattern**: XML-style pseudo-markup for rule organization

**Implementation** (from CLAUDE.md):
```markdown
<SPELLING_AND_LOCALISATION note="IMPORTANT">
  <IMPORTANT note="This is VERY important">
    **CRITICAL: YOU MUST ALWAYS USE INTERNATIONAL / AUSTRALIAN
    ENGLISH SPELLING...**
  </IMPORTANT>
  <AUSTRALIAN_ENGLISH_RULES>
    <KEY_PATTERNS>
        1. Use -our instead of -or (e.g., colour, favour)
        2. Use -ise/-yse instead of -ize/-yze
    </KEY_PATTERNS>
  </AUSTRALIAN_ENGLISH_RULES>
</SPELLING_AND_LOCALISATION>

<WORKFLOW note="**IMPORTANT**">
  - Edit only what's necessary
  - Run make lint/format/test/build if available
  - Use Australian/British English spelling
</WORKFLOW>
```

**Benefits**:
- LLMs trained on XML, better adherence
- Clear hierarchical organization
- Emphasis levels (IMPORTANT, CRITICAL)
- Structured validation

#### 2. Anti-Pattern Rules

**Pattern**: Explicit "NEVER DO THESE" sections

**Implementation**:
```markdown
<NEVER_DO_THESE note="**IMPORTANT**">
  - NEVER perform git add/commit/push operations
  - NEVER hardcode credentials, unique identifiers
  - NEVER add comments pertaining only to development process
  - NEVER claim an issue is resolved until user verification
  - NEVER implement placeholder or mocked functionality
</NEVER_DO_THESE>
```

**Benefits**:
- Prevents common AI mistakes
- Clear boundaries
- Reduces rework

#### 3. Context Budget Guidance

**Pattern**: Built-in token optimization rules

**Implementation**:
```markdown
<DO_NOT_WASTE_TOKENS note="**IMPORTANT**">
  - Be succinct and concise - don't waste tokens
  - Combine multiple file edits to the same file where possible
</DO_NOT_WASTE_TOKENS>

<TOOL_USE note="**IMPORTANT**">
  - CRITICAL: Prioritise available tools over manual approaches
  - Keep files under 700 lines - split if longer
  - Remember can delegate tasks to sub-agents
</TOOL_USE>
```

**Benefits**:
- Cost-effective operations
- Performance optimization
- Clear guidance on tool selection

### MoAI-ADK Configuration Patterns

#### 1. Settings-Based Configuration

**Pattern**: Comprehensive JSON configuration with hooks

**Implementation** (`settings.json`):
```json
{
  "companyAnnouncements": [
    "SPEC-First: Use /alfred:1-plan to define requirements first",
    "TDD Cycle: RED → GREEN → REFACTOR ensures quality",
    "4-Phase Workflow: plan → implement → validate → deploy"
  ],
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "uv run ./.claude/hooks/alfred/session_start__show_project_info.py"
      }]
    }],
    "PreToolUse": [{
      "matcher": "Edit|Write|MultiEdit",
      "hooks": [{
        "type": "command",
        "command": "uv run ./.claude/hooks/alfred/pre_tool__auto_checkpoint.py"
      }]
    }]
  },
  "permissions": {
    "defaultMode": "default",
    "allow": ["Task", "Read", "Write", "Edit", "Bash(git status:*)"],
    "ask": ["Bash(git add:*)", "Bash(git commit:*)"],
    "deny": ["Read(./secrets/**)", "Bash(rm -rf /:*)"]
  }
}
```

**Benefits**:
- Centralized configuration
- Automatic lifecycle integration
- Fine-grained permissions
- Runtime context injection

#### 2. Agent Orchestration Pattern

**Pattern**: Task() delegation with metadata

**Implementation** (from spec-builder.md):
```markdown
---
name: spec-builder
description: "Use when: When you need to create an EARS-style SPEC..."
tools: Read, Write, Edit, MultiEdit, Bash, Glob, Grep, TodoWrite
model: inherit
---

# Agent Orchestration Metadata (v1.0)
orchestration:
  can_resume: true
  typical_chain_position: "initial"
  depends_on: []
  resume_pattern: "single-session"
  parallel_safe: false

coordination:
  spawns_subagents: false
  delegates_to: ["backend-expert", "frontend-expert", "database-expert"]
  requires_approval: true

performance:
  avg_execution_time_seconds: 300
  context_heavy: true
  mcp_integration: ["sequential_thinking", "context7"]
```

**Benefits**:
- Clear agent capabilities and constraints
- Explicit delegation patterns
- Performance expectations
- Workflow coordination metadata

#### 3. Multi-Language Support Pattern

**Pattern**: Language configuration with skill invocation rules

**Implementation**:
```markdown
## Language Handling

**IMPORTANT**: You will receive prompts in the user's
**configured conversation_language**.

**Language Guidelines**:
1. Prompt Language: You receive prompts in user's conversation_language
2. Output Language: Generate SPEC documents in user's conversation_language
3. Always in English (regardless of conversation_language):
   - Skill names: `Skill("moai-foundation-specs")`
   - YAML frontmatter fields
   - Technical function/variable names
```

**Benefits**:
- Global accessibility
- Consistent technical standards
- Clear language boundaries

#### 4. Workflow Command Pattern

**Pattern**: Multi-phase commands with explicit steps

**Implementation** (`commands/alfred/1-plan.md`):
```markdown
---
name: alfred:1-plan
description: "Define specifications and create development branch"
argument-hint: Title 1 Title 2 ... | SPEC-ID modifications
allowed-tools: [Read, Write, Edit, MultiEdit, Grep, Glob]
skills: [moai-alfred-issue-labels]
---

## The 4-Step Agent-Based Workflow Command Logic (v5.0.0)

1. **STEP 1**: Intent Understanding (Clarify user requirements)
2. **STEP 2**: Plan Creation (Create execution strategy)
3. **STEP 3**: Task Execution (Execute via tdd-implementer)
4. **STEP 4**: Report & Commit (Documentation and git operations)

**Command Scope**: Only executes Steps 1-2

## PHASE 1: Project Analysis & SPEC Planning
## PHASE 2: SPEC Document Creation
## PHASE 3: Git Branch & PR Setup
```

**Benefits**:
- Clear workflow stages
- Explicit scope boundaries
- Phase-based execution
- Tool and skill dependencies declared

#### 5. Hook System Pattern

**Pattern**: Python-based lifecycle hooks with caching

**Implementation** (`hooks/alfred/session_start__show_project_info.py`):
```python
#!/usr/bin/env python3
"""SessionStart Hook: Enhanced Project Information

Claude Code Event: SessionStart
Purpose: Display project status with Git info, test status, SPEC progress
Execution: Triggered automatically when Claude Code session begins
"""

def get_git_info() -> dict[str, Any]:
    """Get comprehensive git information with parallel execution and caching

    Uses ThreadPoolExecutor to run git commands in parallel (47ms → ~20ms).
    Caches results for 1 minute to avoid redundant git queries.
    """
    # Try cache first
    cached = load_git_cache()
    if cached:
        return result

    # Execute git commands in parallel
    # ...

def format_session_output() -> str:
    """Format the complete session start output

    Uses caches for config and SPEC progress to minimize file I/O.
    """
    # Gather information
    git_info = get_git_info()
    spec_progress = get_spec_progress()

    output = [
        "🚀 MoAI-ADK Session Started",
        f"📦 Version: {moai_version}",
        f"🌿 Branch: {git_info['branch']}",
        f"🎯 SPEC Progress: {spec_progress['completed']}/{spec_progress['total']}"
    ]
    return "\n".join(output)
```

**Benefits**:
- Performance optimization (caching, parallel execution)
- Context injection at session start
- Automatic project status monitoring
- Extensible hook architecture

---

## Common Patterns Across Frameworks

### 1. Agent Definition with YAML Frontmatter

**All three frameworks** use YAML frontmatter for agent metadata:

```yaml
---
name: agent-name
description: "Clear description of agent purpose"
tools: [Tool1, Tool2]
model: haiku|sonnet|inherit
---
```

**Common Elements**:
- Name and description
- Tool permissions
- Model selection
- Additional metadata (color, allowed-tools, skills)

### 2. Model Selection for Cost Optimization

**Pattern**: Strategic model assignment based on task complexity

**Carlo's approach**:
```yaml
---
model: haiku  # For fast, focused tasks like search
---
```

**Sam's approach**:
- Context window management rules
- Token budget guidance
- Tool usage over manual approaches

**MoAI's approach**:
```yaml
---
model: inherit  # Inherit from parent context
---
# With orchestration metadata:
performance:
  avg_execution_time_seconds: 300
  context_heavy: true
```

### 3. Structured Rules with Emphasis

**All frameworks** use markdown emphasis for rule priority:

```markdown
**CRITICAL**: [Most important rule]
**IMPORTANT**: [High priority rule]
*Note*: [Contextual information]
```

### 4. Tool Permissions Management

**Carlo**: Implicit via agent tools list
```yaml
tools: Grep, Glob, Read, Bash
```

**Sam**: Via rules documentation
```markdown
<TOOL_USE note="**IMPORTANT**">
  - Prioritise available tools over manual approaches
</TOOL_USE>
```

**MoAI**: Explicit permissions in settings.json
```json
"permissions": {
  "allow": ["Task", "Read", "Write"],
  "ask": ["Bash(git add:*)"],
  "deny": ["Read(./secrets/**)"]
}
```

### 5. Skill Integration Patterns

**All frameworks** support skill libraries:

**Carlo**: Symlink-based external skills
```
skills/superpowers:brainstorming -> libs/superpowers/skills/brainstorming
```

**Sam**: Direct skill directories
```
skills/creating-development-plans/
skills/systematic-debugging/
```

**MoAI**: Namespaced skills with explicit invocation
```markdown
- `Skill("moai-foundation-ears")`
- `Skill("moai-lang-python")`
```

### 6. Git Workflow Integration

**Common pattern**: Git operations delegated to specialized agents/rules

**Carlo**: git-manager agent (delegated)
**Sam**: Explicit git rules in CLAUDE.md
**MoAI**: git-manager agent with GitFlow strategy

### 7. Session Context Injection

**Carlo**: Via symlinked CLAUDE.md
**Sam**: Via CLAUDE.md global rules
**MoAI**: Via SessionStart hooks + settings.json companyAnnouncements

---

## Reusable Patterns for Rules and Agents

### Rule Patterns

#### 1. Relationship Definition Pattern

**Purpose**: Establish working relationship and communication style

**Reusable Template**:
```markdown
## Our Relationship

- We're colleagues working together as "[User]" and "Claude"
- Speak up immediately when you don't know something
- Call out bad ideas and mistakes - I depend on this
- NEVER be agreeable just to be nice
- Push back when you disagree
- If uncomfortable pushing back, say "[safe word]"
```

**Source**: Carlo's 0-start.md
**Applicability**: Universal - all projects benefit from clear relationship boundaries

#### 2. Anti-Pattern Prevention Pattern

**Purpose**: Prevent common AI coding mistakes

**Reusable Template**:
```markdown
## NEVER Do These

- NEVER perform git operations without explicit request
- NEVER hardcode credentials or unique identifiers
- NEVER add placeholder/mock functionality unless explicitly instructed
- NEVER claim issues resolved until user verification
- NEVER implement without tests (if TDD project)
- NEVER use marketing language in documentation
```

**Source**: Sam's CLAUDE.md
**Applicability**: Universal - prevents common AI pitfalls

#### 3. Context Budget Pattern

**Purpose**: Optimize token usage and performance

**Reusable Template**:
```markdown
## Context Window Management

- Keep files under 700 lines (split if longer)
- Combine multiple edits to same file
- Delegate to sub-agents for parallel work
- Use tools instead of manual approaches
- Don't pipe large data into LLMs
- Cache frequently accessed information
```

**Source**: Sam's CLAUDE.md + MoAI's hook caching
**Applicability**: All medium-to-large projects

#### 4. Language and Spelling Pattern

**Purpose**: Enforce consistent language/spelling standards

**Reusable Template**:
```markdown
<LANGUAGE_RULES>
  <SPELLING note="CRITICAL">
    **Use [LANGUAGE] spelling for all content**
    - Examples: [specific patterns]
    - Final check: Did I use correct spelling?
  </SPELLING>

  <ALWAYS_ENGLISH>
    - Skill invocations: Skill("name")
    - Technical keywords and function names
    - Code comments (optional, configurable)
  </ALWAYS_ENGLISH>
</LANGUAGE_RULES>
```

**Source**: Sam's + MoAI's multi-language patterns
**Applicability**: International teams, non-English projects

#### 5. Workflow Definition Pattern

**Purpose**: Define clear development workflow

**Reusable Template**:
```markdown
## Development Workflow

1. **Planning Phase**
   - Analyze requirements
   - Create specification/plan
   - Get user approval

2. **Implementation Phase**
   - Write tests first (if TDD)
   - Implement minimal code
   - Run tests and verify

3. **Review Phase**
   - Run linters/formatters
   - Check test coverage
   - Request user review

4. **Completion Phase**
   - Documentation updates
   - Commit with meaningful message
   - Mark tasks complete
```

**Source**: MoAI's 4-phase workflow
**Applicability**: All structured development projects

### Agent Patterns

#### 1. Search/Exploration Agent Pattern

**Purpose**: Fast codebase exploration without context pollution

**Reusable Template**:
```yaml
---
name: search
description: "Fast code location finding - isolates search from main context"
tools: Grep, Glob, Read
model: haiku  # Fast, cheap model
---

You are a specialized search agent.

## Core Responsibilities
1. Rapid pattern matching with multiple strategies
2. Smart filtering (file types, directories)
3. Validate findings by reading snippets
4. Return structured locations with confidence scores

## Output Format
- SEARCH RESULT: found|partial|not_found
- CONFIDENCE: high|medium|low
- LOCATIONS: [file paths with line numbers]
- REASONING: [search strategy used]

## Performance Guidelines
- <10 file reads per search
- <30 seconds total time
- <5K tokens context usage
```

**Source**: Carlo's search.md
**Applicability**: Any project with >100 files

#### 2. Documentation Generator Agent Pattern

**Purpose**: Automated documentation creation

**Reusable Template**:
```yaml
---
name: doc-generator
description: "Generate comprehensive documentation from code"
tools: Read, Write, Grep, Glob
model: sonnet  # Need good writing quality
---

You are a documentation specialist.

## Responsibilities
1. Read code and extract structure
2. Generate clear documentation
3. Include examples and usage
4. Follow project documentation standards

## Output Format
- README.md with quickstart
- API documentation
- Architecture overview
- Examples directory
```

**Source**: Carlo's documentation-generator.md
**Applicability**: All projects needing documentation

#### 3. SPEC Builder Agent Pattern

**Purpose**: Requirements analysis and specification creation

**Reusable Template**:
```yaml
---
name: spec-builder
description: "Create structured specifications from requirements"
tools: Read, Write, Edit, AskUserQuestion
model: inherit
---

You are a requirements analysis expert.

## Workflow
1. Analyze user requirements
2. Ask clarifying questions
3. Create structured specification
4. Get user approval

## Output
- spec.md: Core requirements
- plan.md: Implementation plan
- acceptance.md: Test criteria
```

**Source**: MoAI's spec-builder.md
**Applicability**: Projects using SPEC-first or requirements-driven development

#### 4. Quality Gate Agent Pattern

**Purpose**: Automated quality checks before completion

**Reusable Template**:
```yaml
---
name: quality-gate
description: "Validate code quality before marking complete"
tools: Bash, Read, Grep
model: haiku  # Fast checks
---

You are a quality assurance specialist.

## Checks
1. Tests pass (run test suite)
2. Linting passes (run linters)
3. Coverage meets threshold
4. No placeholder code
5. Documentation updated

## Report Format
- ✅ PASSED: [criterion]
- ❌ FAILED: [criterion] - [reason]
- Overall: PASS|FAIL
```

**Source**: MoAI's quality-gate.md + Sam's workflow rules
**Applicability**: All projects with quality standards

#### 5. Git Manager Agent Pattern

**Purpose**: Centralized git operations

**Reusable Template**:
```yaml
---
name: git-manager
description: "Handle all git operations with strategy enforcement"
tools: Bash(git:*), Bash(gh:*)
model: haiku
---

You are a git workflow specialist.

## Responsibilities
1. Branch creation (strategy enforcement)
2. Commit message formatting (conventional commits)
3. PR creation and management
4. Merge conflict resolution guidance

## Git Strategy
- Branch naming: [pattern]
- Commit format: [conventional commits]
- PR process: [draft → review → merge]
- Protected branches: [main, develop]
```

**Source**: Carlo's + MoAI's git-manager patterns
**Applicability**: All git-based projects

---

## Key Differences in Approach

### 1. Configuration Philosophy

| Framework | Philosophy | Deployment |
|-----------|-----------|------------|
| **Carlo** | Compiled modular rules | Symlinks to `~/.claude/` |
| **Sam** | Monolithic structured rules | Single CLAUDE.md file |
| **MoAI** | Settings-driven + hooks | `.claude/settings.json` + Python hooks |

**Analysis**:
- Carlo's approach: Best for evolving rules, easy to maintain
- Sam's approach: Best for sharing complete configurations
- MoAI's approach: Best for runtime behavior and automation

### 2. Agent Organization

| Framework | Count | Organization | Specialization |
|-----------|-------|-------------|----------------|
| **Carlo** | 4 | Task-focused (search, docs, review) | Minimal, focused agents |
| **Sam** | 8 | Research + analysis focused | Medium specialization |
| **MoAI** | 31 | Domain-expert model | High specialization |

**Analysis**:
- Carlo: Fewer, more general-purpose agents
- Sam: Balanced specialization for common tasks
- MoAI: Enterprise-grade domain coverage

### 3. Skill Integration

| Framework | Approach | Benefits |
|-----------|----------|----------|
| **Carlo** | Symlinked external + custom | Reuse obra/superpowers, easy updates |
| **Sam** | Direct inclusion | Self-contained, no dependencies |
| **MoAI** | Namespaced invocation | Explicit, version-controlled |

### 4. Workflow Definition

| Framework | Style | Phases |
|-----------|-------|--------|
| **Carlo** | Implicit workflow via rules | Build → Test → Deploy |
| **Sam** | Explicit workflow rules | Setup → Plan → Act → Review |
| **MoAI** | Command-driven workflow | Plan → Run → Sync → Deploy |

### 5. Automation Level

| Framework | Automation | Implementation |
|-----------|-----------|----------------|
| **Carlo** | Build-time (mise tasks) | Rule compilation, symlinking |
| **Sam** | Guidance-based | Rules tell AI what to do |
| **MoAI** | Runtime (Python hooks) | SessionStart, PreToolUse, PostToolUse |

**Analysis**:
- Carlo: Developer-controlled automation
- Sam: AI-guided manual execution
- MoAI: Automatic lifecycle integration

### 6. Permission Model

| Framework | Granularity | Enforcement |
|-----------|-------------|-------------|
| **Carlo** | Agent-level (tools list) | Implicit via agent definition |
| **Sam** | Rule-based warnings | Explicit "NEVER" rules |
| **MoAI** | Fine-grained (settings.json) | allow/ask/deny per tool pattern |

**Analysis**:
- Carlo: Simple, agent-scoped permissions
- Sam: Social contract via rules
- MoAI: Technical enforcement via settings

### 7. Multi-Language Support

| Framework | Support Level | Implementation |
|-----------|---------------|----------------|
| **Carlo** | English-focused | N/A |
| **Sam** | English + Australian English | Spelling rules |
| **MoAI** | 50+ languages | conversation_language config |

### 8. Documentation Approach

| Framework | Style | Audience |
|-----------|-------|----------|
| **Carlo** | Technical + examples | Developers familiar with Claude Code |
| **Sam** | Prescriptive + tips | Developers new to AI coding |
| **MoAI** | Comprehensive + persona-based | Enterprise teams |

---

## Recommendations for Our Implementation

### Phase 1: Foundation (Immediate)

#### 1.1 Adopt Carlo's Rule Compilation Pattern

**Recommendation**: Use modular rules with build-time compilation

**Implementation**:
```
.claude/
├── rules/
│   ├── 00-foundation.md      # Core principles
│   ├── 01-relationship.md    # Working relationship
│   ├── 02-workflow.md        # Development workflow
│   ├── 10-git.md             # Git operations
│   ├── 20-testing.md         # Testing requirements
│   └── 99-anti-patterns.md   # NEVER rules
├── .build/
│   └── CLAUDE.md             # Compiled output
└── scripts/
    └── build-rules.sh        # Compilation script
```

**Benefits**:
- Easy to maintain and version control
- Clear separation of concerns
- Team members can own specific rule files
- Instant updates via symlinks

#### 1.2 Adopt Sam's XML-Style Rule Structure

**Recommendation**: Use structured markup for better LLM adherence

**Template**:
```markdown
<FOUNDATION_RULES note="CRITICAL">
  <RELATIONSHIP>
    - We're colleagues working together
    - Speak up when uncertain
    - Push back on bad ideas
  </RELATIONSHIP>

  <WORKFLOW>
    1. Plan before implementing
    2. Test-driven development
    3. Review before committing
  </WORKFLOW>
</FOUNDATION_RULES>

<ANTI_PATTERNS note="NEVER DO THESE">
  - NEVER commit without tests
  - NEVER hardcode credentials
  - NEVER use placeholder code
</ANTI_PATTERNS>
```

**Benefits**:
- Improved AI adherence (XML-trained models)
- Clear hierarchy and emphasis
- Easy to scan and understand

#### 1.3 Adopt MoAI's Settings-Based Configuration

**Recommendation**: Use settings.json for runtime configuration

**Initial Configuration**:
```json
{
  "permissions": {
    "defaultMode": "default",
    "allow": [
      "Read(**/*.{js,ts,py,md})",
      "Edit(**/*.{js,ts,py})",
      "Bash(git status:*)",
      "Bash(git log:*)",
      "Bash(npm:*)",
      "Bash(pytest:*)"
    ],
    "ask": [
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(git push:*)"
    ],
    "deny": [
      "Read(./secrets/**)",
      "Read(~/.ssh/**)",
      "Bash(rm -rf:*)",
      "Bash(sudo:*)"
    ]
  },
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "echo 'Session started'"
      }]
    }]
  }
}
```

**Benefits**:
- Fine-grained security control
- Runtime behavior customization
- Hook integration for automation

### Phase 2: Core Agents (Week 2-3)

#### 2.1 Implement Essential Agents

**Priority 1 Agents** (implement first):

1. **search** (from Carlo)
   - Fast codebase exploration
   - Model: haiku (cost-effective)
   - Tools: Grep, Glob, Read

2. **quality-gate** (from MoAI)
   - Automated quality checks
   - Model: haiku (fast checks)
   - Tools: Bash, Read, Grep

3. **git-manager** (from Carlo + MoAI)
   - Centralized git operations
   - Model: haiku
   - Tools: Bash(git:*), Bash(gh:*)

**Priority 2 Agents** (implement second):

4. **doc-generator** (from Carlo)
   - Automated documentation
   - Model: sonnet (quality writing)
   - Tools: Read, Write, Glob

5. **spec-builder** (from MoAI - simplified)
   - Requirements analysis
   - Model: sonnet
   - Tools: Read, Write, AskUserQuestion

#### 2.2 Agent Template

**Standard Agent Structure**:
```yaml
---
name: agent-name
description: "Clear one-line purpose"
tools: [Tool1, Tool2]
model: haiku|sonnet
color: blue|green|orange|red
---

You are a [role] specialist.

## Core Responsibilities
1. [Primary responsibility]
2. [Secondary responsibility]
3. [Validation responsibility]

## Workflow
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Output Format
[Structured output specification]

## Performance Guidelines
- Time budget: [X seconds]
- Token budget: [X tokens]
- File read limit: [X files]
```

### Phase 3: Workflow Integration (Week 3-4)

#### 3.1 Implement Phased Workflow Commands

**Recommended Commands** (inspired by MoAI):

1. **`/plan`** - Planning phase
   - Analyze requirements
   - Create implementation plan
   - Get user approval

2. **`/implement`** - Implementation phase
   - Execute plan with TDD
   - Run quality checks
   - Document changes

3. **`/review`** - Review phase
   - Code review checklist
   - Test coverage check
   - Documentation validation

4. **`/ship`** - Completion phase
   - Final quality gate
   - Git operations
   - Deployment preparation

#### 3.2 Command Template

```markdown
---
name: plan
description: "Create implementation plan for new feature"
argument-hint: "[feature-description]"
allowed-tools: [Read, Write, AskUserQuestion]
---

# Planning Command

## Purpose
Create structured implementation plan with user approval

## Workflow

### Phase 1: Analysis
1. Read requirements
2. Identify affected files
3. Determine dependencies

### Phase 2: Planning
1. Break into tasks
2. Estimate complexity
3. Identify risks

### Phase 3: Approval
1. Present plan to user
2. Get explicit approval
3. Proceed or revise
```

### Phase 4: Advanced Features (Week 4+)

#### 4.1 Hook System

**Recommended Hooks** (from MoAI):

1. **SessionStart**
   - Display project status
   - Git branch info
   - Pending tasks

2. **PreToolUse** (Edit|Write)
   - Backup before editing
   - Check file permissions
   - Validate file paths

3. **PostToolUse** (Bash)
   - Log command execution
   - Check for errors
   - Update state

**Simple Hook Example**:
```python
#!/usr/bin/env python3
import json
import sys

def main():
    # Read input
    data = json.loads(sys.stdin.read())

    # Do work
    result = {
        "continue": True,
        "systemMessage": "Hook executed successfully"
    }

    # Return result
    print(json.dumps(result))
    sys.exit(0)

if __name__ == "__main__":
    main()
```

#### 4.2 Skill Library Integration

**Recommended Approach**: Hybrid (Carlo + MoAI)

1. **Custom Skills** (direct inclusion)
   - Project-specific workflows
   - Domain knowledge
   - Company standards

2. **External Skills** (symlinked)
   - obra/superpowers skills
   - Industry best practices
   - Reusable patterns

3. **Skill Invocation** (MoAI-style)
   ```markdown
   Skill("project:custom-workflow")
   Skill("superpowers:test-driven-development")
   ```

### Phase 5: Quality Patterns

#### 5.1 Testing Integration

**Pattern**: Combine Sam's and MoAI's approaches

```markdown
<TESTING_RULES note="CRITICAL">
  <TDD_WORKFLOW>
    1. RED: Write failing test first
    2. GREEN: Write minimal code to pass
    3. REFACTOR: Improve code quality
  </TDD_WORKFLOW>

  <QUALITY_GATES>
    - Test coverage ≥ 80%
    - All tests pass
    - No linting errors
    - No placeholder code
  </QUALITY_GATES>
</TESTING_RULES>
```

#### 5.2 Context Optimization

**Pattern**: Combine all three approaches

1. **Rules** (Sam): Token budget guidance
2. **Agents** (Carlo): Haiku for fast operations
3. **Hooks** (MoAI): Caching and parallel execution

```markdown
<CONTEXT_OPTIMIZATION>
  <FILE_SIZE>
    - Maximum 700 lines per file
    - Split when exceeding limit
    - Use modules for organization
  </FILE_SIZE>

  <TOOL_USAGE>
    - Prefer tools over manual grep
    - Delegate to sub-agents
    - Cache frequently accessed data
  </TOOL_USAGE>

  <MODEL_SELECTION>
    - Search: haiku (fast, cheap)
    - Documentation: sonnet (quality)
    - Complex reasoning: sonnet
  </MODEL_SELECTION>
</CONTEXT_OPTIMIZATION>
```

---

## Implementation Checklist

### Week 1: Foundation
- [ ] Create `.claude/` directory structure
- [ ] Implement rule compilation script
- [ ] Create initial rules (foundation, relationship, anti-patterns)
- [ ] Set up settings.json with permissions
- [ ] Test basic configuration

### Week 2: Core Agents
- [ ] Implement search agent
- [ ] Implement git-manager agent
- [ ] Implement quality-gate agent
- [ ] Test agent delegation
- [ ] Document agent usage

### Week 3: Workflow
- [ ] Implement /plan command
- [ ] Implement /implement command
- [ ] Implement /review command
- [ ] Create workflow documentation
- [ ] Test end-to-end workflow

### Week 4: Polish
- [ ] Add SessionStart hook
- [ ] Add PreToolUse hooks
- [ ] Implement caching for performance
- [ ] Create user documentation
- [ ] Gather team feedback

---

## Conclusion

Each framework has unique strengths:

- **Carlo**: Modular, maintainable, practical
- **Sam**: Comprehensive rules, cost-conscious, anti-pattern prevention
- **MoAI**: Enterprise-grade, highly automated, workflow-driven

**Recommended Hybrid Approach**:
1. Use Carlo's modular rule compilation
2. Adopt Sam's XML-style structure and anti-patterns
3. Implement MoAI's settings-based configuration
4. Start simple (3-4 agents) and expand based on needs
5. Prioritize quality gates and workflow commands

**Key Success Factors**:
- Start small and iterate
- Test with real projects
- Gather team feedback
- Document patterns as you discover them
- Version control all configurations

This analysis provides a foundation for building a robust, maintainable Claude Code configuration system that combines the best patterns from all three frameworks.
