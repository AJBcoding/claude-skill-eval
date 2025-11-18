# Claude Skills Evaluation Repository - Comprehensive Summary

This document provides a complete overview of all skills and resources contained in this repository, organized by category and location.

---

## Table of Contents

- [Repository Folders](#repository-folders)
- [Skills by Category](#skills-by-category)
  - [AI & Agent Development](#ai--agent-development)
  - [Authentication & Security](#authentication--security)
  - [Backend Development](#backend-development)
  - [Career & Job Search](#career--job-search)
  - [Code Quality & Review](#code-quality--review)
  - [Content Processing](#content-processing)
  - [Creative & Design](#creative--design)
  - [Data Analysis](#data-analysis)
  - [Database & Performance](#database--performance)
  - [Debugging & Troubleshooting](#debugging--troubleshooting)
  - [Development Tools & Frameworks](#development-tools--frameworks)
  - [Documentation](#documentation)
  - [Document Processing](#document-processing)
  - [Frontend Development](#frontend-development)
  - [Meta Skills](#meta-skills)
  - [Platform Integration (BaaS)](#platform-integration-baas)
  - [Programming Languages](#programming-languages)
  - [Project Management](#project-management)
  - [Requirements & Specifications](#requirements--specifications)
  - [Testing & QA](#testing--qa)
  - [Version Control](#version-control)
  - [Visualization](#visualization)
  - [Writing & Communication](#writing--communication)

---

## Repository Folders

### agentic-coding-main

**Location:** `/agentic-coding-main/`

A comprehensive collection of coding rules, templates, workflows, skills, and configurations for working with AI-powered agentic coding tools, primarily Claude Code and Cline.

**Key Components:**
- **Claude/**: Resources for Claude Code including core rules (CLAUDE.md), 8 specialized agents, 9 slash commands, 11 skills, and configuration
- **Cline/**: Resources for Cline including rules (XML and markdown format), 13 workflow templates, and ad-hoc rules
- **MCP/**: Model Context Protocol server configurations (mvp and optional configs)
- **Kiro/**: Rules for Amazon Kiro

**Core Philosophy:**
- Australian/British English spelling (critical importance)
- Favor simplicity over complexity
- Token efficiency and parallel task execution
- Clear, specific language avoiding AI clichés
- SPEC-first development approach

**Size:** 241 files, 3.7MB

---

### claude-code-stuff-main

**Location:** `/claude-code-stuff-main/`

A personal, production-ready configuration system for Claude Code that extends capabilities through modular architecture.

**Key Components:**
- **agents/**: 4 custom sub-agents (search, documentation-generator, code-reviewer) optimized for cost/performance
- **skills/**: 3 custom skills (developing-with-swift, generating-swift-package-docs, using-linear) + 19 symlinked superpowers skills
- **rules/**: 8 global behavior guideline files compiled into AGENTS.md
- **hooks-scripts/**: Claude Code hook scripts (session-start, user-prompt-submit)
- **mise-tasks/**: 6 build automation scripts for compilation and deployment

**Key Benefits:**
- 40-60% cost reduction through model selection
- 30-50% speed improvement for code search
- Modular, version-controlled configuration
- Symlink-based deployment for instant updates

**Architecture:** Hybrid system combining custom domain expertise (Swift/iOS) with proven practices from obra/superpowers library

---

### moai-adk-main

**Location:** `/moai-adk-main/`

The complete MoAI-ADK (MoAI Agentic Development Kit) - an AI-powered SPEC-First TDD development framework designed for Claude Code.

**Key Components:**
- **src/moai_adk/**: Python package with core functionality, CLI, status line integration, utilities
- **.moai/**: Runtime configuration, backups, cache, memory, reports
- **.claude/**: Alfred SuperAgent, 125+ skills, commands, hooks, settings
- **tests/**: Comprehensive test suite (CI, E2E, integration, unit tests)
- **scripts/**: Development and maintenance utilities
- **.github/workflows/**: 11 automated workflows

**Core Features:**
- SPEC-First Development using EARS format
- Automated TDD workflow (RED → GREEN → REFACTOR)
- Alfred SuperAgent with 19 specialized agents
- 125+ production-ready skills
- TRUST 5 quality principles (Test-first, Readable, Unified, Secured, Trackable)
- 85%+ test coverage requirement

**Version:** 0.25.10 (Python package available via PyPI)

---

### skills

**Location:** `/skills/`

Collection of 128+ moai-prefixed skills and additional standalone skills covering comprehensive development workflows.

**Categories:**
- **Alfred Skills** (19): Agent orchestration, workflow automation, session management
- **Artifacts Builder**: Development artifact creation
- **BaaS Extensions** (9+): Auth0, Clerk, Convex, Firebase, Neon, Railway, Supabase, Cloudflare, Vercel
- **Claude Code Skills**: Agents, commands, skill management
- **Design Systems**: UI/UX patterns and component libraries
- **Domain Skills**: Backend, frontend, security
- **Essentials** (4): AI-powered debug, performance, refactor, review
- **Foundation Skills**: EARS, Git, Specs, TRUST principles
- **Language Skills**: Python 3.13, TypeScript 5.9, Go, C#, PHP, and 20+ more
- **Security Skills**: API security, authentication/authorization
- **Standalone Skills**: Algorithmic art, canvas design, document processing (DOCX, PDF, PPTX, XLSX), MCP builder, skill creator, theme factory

**Total:** 136+ skills

---

### tapestry-skills-for-claude-code-main

**Location:** `/tapestry-skills-for-claude-code-main/`

Productivity skills for Claude Code that transform passive learning content into actionable implementation plans.

**Key Components:**
- **ship-learn-next/**: Converts learning content into 5-rep action plans
- **youtube-transcript/**: Downloads and cleans YouTube video transcripts
- **install.sh**: Automated installation script

**Core Philosophy:**
- "Learning = doing better, not knowing more"
- Ship-Learn-Next framework: Ship → Learn → Next
- Focus on concrete iterations (reps) over passive consumption
- "100 reps beats 100 hours of study"

**Note:** Appears incomplete - references tapestry/ and article-extractor/ directories that are not present

---

### .claude

**Location:** `/.claude/`

Claude Code configuration directory containing skills and synchronization metadata.

**Contents:**
- **.gitignore**: Ignores `.sync-metadata.json`
- **skills/**: Comprehensive collection of skills (analyzed separately)

---

### Root Configuration

**Root-level files:**
- **.gitignore**: Standard patterns for Python, macOS, IDEs, and log files

**Organizational Structure:**
- Minimal configuration approach
- Collection-style structure aggregating skills from various sources
- No formal README or license at root level
- Development-ready ignore patterns

---

## Skills by Category

### AI & Agent Development

#### moai-alfred-agent-factory
- **Location:** `skills/`
- **Summary:** Factory pattern for creating and managing specialized AI agents with standardized interfaces and lifecycle management.

#### moai-alfred-ask-user-questions
- **Location:** `skills/`
- **Summary:** Structured framework for AI agents to gather user requirements through intelligent questioning patterns.

#### moai-alfred-clone-pattern
- **Location:** `skills/`
- **Summary:** Standardized patterns for cloning and replicating codebases with AI-assisted configuration.

#### moai-alfred-config-schema
- **Location:** `skills/`
- **Summary:** Schema validation and management for agent configurations across MoAI-ADK ecosystem.

#### moai-alfred-context-budget
- **Location:** `skills/`
- **Summary:** Token and context budget management for AI agents to optimize performance and cost.

#### moai-alfred-expertise-detection
- **Location:** `skills/`
- **Summary:** Automatic detection of required expertise and routing to appropriate specialized agents.

#### moai-alfred-language-detection
- **Location:** `skills/`
- **Summary:** Automatic programming language detection with context-aware analysis for polyglot codebases.

#### moai-alfred-personas
- **Location:** `skills/`
- **Summary:** Predefined AI agent personas for different roles (architect, reviewer, optimizer, security expert).

#### moai-alfred-session-state
- **Location:** `skills/`
- **Summary:** Session state management across multi-turn AI agent conversations and workflows.

#### moai-alfred-workflow
- **Location:** `skills/`
- **Summary:** End-to-end workflow orchestration for complex development processes with AI coordination.

---

### Authentication & Security

#### moai-baas-auth0-ext
- **Location:** `skills/`
- **Summary:** Auth0 integration for enterprise authentication, MFA, and identity management.

#### moai-baas-clerk-ext
- **Location:** `skills/`
- **Summary:** Clerk integration for modern authentication with built-in UI components and session management.

#### moai-domain-security
- **Location:** `skills/`
- **Summary:** Comprehensive security patterns covering authentication, authorization, encryption, and OWASP compliance.

#### moai-security-api
- **Location:** `skills/`
- **Summary:** Comprehensive API security for REST, GraphQL, and gRPC with OAuth 2.1 authentication, JWT validation, rate limiting, OWASP API Top 10 protection, and multi-tenant isolation.

#### moai-security-auth
- **Location:** `skills/`
- **Summary:** Modern authentication patterns with MFA, FIDO2, WebAuthn, Passkeys, NextAuth.js 5.x, Passport.js, session management, and audit logging.

---

### Backend Development

#### moai-domain-backend
- **Location:** `skills/`
- **Summary:** Backend architecture patterns including API design, database optimization, and microservices.

---

### Career & Job Search

#### cover-letter-voice
- **Location:** `.claude/skills/`
- **Summary:** Develops authentic cover letter narrative frameworks grounded in career philosophy, established narrative patterns, and job cultural requirements. Creates strategic foundation with tone profile, structure guidance, and complete source documentation.

#### format-cover-letter
- **Location:** `.claude/skills/`
- **Summary:** Formats cover letters with intelligent style application and automatic play title italicization using a shared 19-style template with dictionary-based auto-styling.

#### format-resume
- **Location:** `.claude/skills/`
- **Summary:** Intelligently formats CV/resume content using semantic understanding and visual verification with 19 semantic styles. Uses LLM analysis to understand content context rather than regex patterns.

#### job-description-analysis
- **Location:** `.claude/skills/`
- **Summary:** Analyzes job postings to identify requirements, extract ATS keywords, decode organizational culture, and surface values alignment opportunities with structured output matching lexicon categories.

#### job-fit-analysis
- **Location:** `.claude/skills/`
- **Summary:** Analyzes fit between job requirements and career background using lexicons to identify strengths, gaps, and develop strategic reframing approaches with gap verification and cover letter planning.

#### resume-alignment
- **Location:** `.claude/skills/`
- **Summary:** Tailors resumes to job descriptions using verified achievements from career lexicons, ensuring every statement is traceable to source material with no fabrication.

---

### Code Quality & Review

#### moai-alfred-code-reviewer
- **Location:** `skills/`
- **Summary:** Automated code review guidance with AI-powered quality analysis and feedback generation.

#### moai-alfred-feedback-templates
- **Location:** `skills/`
- **Summary:** Standardized templates for providing consistent, constructive feedback in agent interactions.

#### moai-alfred-proactive-suggestions
- **Location:** `skills/`
- **Summary:** Proactive suggestions and recommendations based on code analysis and context awareness.

#### moai-alfred-rules
- **Location:** `skills/`
- **Summary:** Rule engine for enforcing coding standards, security policies, and quality gates.

#### moai-essentials-review
- **Location:** `skills/`
- **Summary:** Enterprise code review automation with AI-powered quality analysis, TRUST 5 enforcement, security scanning, performance analysis, test coverage validation, and automated feedback generation.

#### receiving-code-review
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Framework for receiving code review feedback with technical rigor requiring verification before implementation, technical evaluation over emotional performance, and pushing back with reasoning when feedback is technically incorrect.

#### requesting-code-review
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Process for dispatching code-reviewer subagent to catch issues before they cascade, mandatory after major features or before merge, providing feedback on strengths and issues (Critical/Important/Minor).

---

### Content Processing

#### article-extractor
- **Location:** `.claude/skills/`
- **Summary:** Extracts clean article content from web URLs (blog posts, articles, tutorials) and saves as readable text files, removing ads, navigation, and other clutter using Mozilla's Readability or trafilatura.

#### ship-learn-next
- **Location:** `tapestry-skills-for-claude-code-main/`
- **Summary:** Transforms learning content into actionable implementation plans using the Ship-Learn-Next framework. Creates 5-rep action plans with timelines, focusing on doing over studying.

#### tapestry
- **Location:** `.claude/skills/`
- **Summary:** Unified workflow that detects content type from URLs (YouTube, article, PDF), extracts content using appropriate methods, and automatically creates Ship-Learn-Next action plans to turn learning into implementation.

#### youtube-transcript
- **Location:** `tapestry-skills-for-claude-code-main/`
- **Summary:** Downloads and cleans YouTube video transcripts using yt-dlp with fallback to Whisper transcription if no subtitles available. Automatically removes duplicate lines and uses video title for filename.

---

### Creative & Design

#### algorithmic-art
- **Location:** `skills/`
- **Summary:** Creates algorithmic art using p5.js with seeded randomness and interactive parameter exploration. Generates computational aesthetic movements through flow fields, particle systems, and mathematical beauty.

#### brand-guidelines
- **Location:** `.claude/skills/`
- **Summary:** Applies Anthropic's official brand identity including colors (dark, light, orange, blue, green) and typography (Poppins for headings, Lora for body text) to any artifact.

#### canvas-design
- **Location:** `skills/`
- **Summary:** Creates beautiful visual art in PNG and PDF documents using design philosophy. Generates aesthetic movements through form, space, color, and composition with minimal text for museum or magazine-quality work.

#### moai-design-systems
- **Location:** `skills/`
- **Summary:** Component libraries, design tokens, and accessibility patterns for consistent UI development.

#### slack-gif-creator
- **Location:** `skills/`
- **Summary:** Toolkit for creating animated GIFs optimized for Slack with validators for size constraints and composable animation primitives (shake, bounce, spin, pulse, fade, zoom, etc.) with strict 64KB limits.

#### theme-factory
- **Location:** `skills/`
- **Summary:** Toolkit for styling artifacts with 10 professionally curated themes with coordinated color palettes and font pairings. Can be applied to slides, documents, reports, and HTML landing pages.

---

### Data Analysis

#### csv-data-summarizer-claude-skill-main
- **Location:** `.claude/skills/`
- **Summary:** Automatically analyzes CSV files and provides comprehensive summaries with statistical insights and visualizations using Python and pandas. Intelligently adapts analysis approach based on data type.

---

### Database & Performance

#### moai-essentials-perf
- **Location:** `skills/`
- **Summary:** AI-powered performance optimization with Context7 integration, Scalene AI profiling, intelligent bottleneck detection, automated optimization strategies, GPU profiling, and predictive performance tuning.

#### python-performance-optimization
- **Location:** `.claude/skills/`
- **Summary:** Comprehensive guide to profiling, analyzing, and optimizing Python code using cProfile, memory profilers, and performance best practices to identify bottlenecks and improve application performance.

#### sql-optimization-patterns
- **Location:** `.claude/skills/`
- **Summary:** Master SQL query optimization, indexing strategies, and EXPLAIN analysis to dramatically improve database performance through systematic optimization, proper indexing, and query plan analysis.

---

### Debugging & Troubleshooting

#### moai-essentials-debug
- **Location:** `skills/`
- **Summary:** AI-powered enterprise debugging with Context7 integration, intelligent error pattern recognition, automated root cause analysis, predictive fix suggestions, and multi-process debugging coordination across 25+ languages.

#### root-cause-tracing
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Systematic approach to tracing bugs backward through call stack using instrumentation when needed to identify the source of invalid data or incorrect behavior rather than fixing symptoms.

#### systematic-debugging
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Four-phase framework (root cause investigation, pattern analysis, hypothesis testing, implementation) ensuring understanding before attempting solutions, requiring root cause identification before any fix attempts.

---

### Development Tools & Frameworks

#### artifacts-builder
- **Location:** `skills/`
- **Summary:** Suite of tools for creating elaborate, multi-component claude.ai HTML artifacts using React, TypeScript, Vite, Tailwind CSS, and shadcn/ui. Provides initialization scripts, development workflow, and bundling capabilities.

#### creating-karabiner-modifications
- **Location:** `.claude/skills/`
- **Summary:** Provides systematic workflow for creating Karabiner-Elements keyboard customizations on macOS with correct JSON structure, common patterns, and guidance on manual vs generator approaches.

#### developing-with-swift
- **Location:** `.claude/skills/`
- **Summary:** Establishes Swift coding style guidelines and teaches modern SwiftUI development with emphasis on native state management, async/await patterns, view composition, and proper use of Xcode build tools.

#### extracting-filemaker-business-logic
- **Location:** `.claude/skills/`
- **Summary:** Extracts calculations, custom functions, and business logic from FileMaker DDR reports for PostgreSQL implementations. Focuses on understanding and adapting FileMaker logic rather than direct schema migration.

#### moai-artifacts-builder
- **Location:** `skills/`
- **Summary:** Builder pattern for creating and managing development artifacts with AI-assisted generation.

#### moai-baas-convex-ext
- **Location:** `skills/`
- **Summary:** Convex integration for reactive backends with real-time database and serverless functions.

#### moai-baas-firebase-ext
- **Location:** `skills/`
- **Summary:** Firebase integration for Google's BaaS platform with authentication, Firestore, and cloud functions.

#### moai-baas-foundation
- **Location:** `skills/`
- **Summary:** Foundational patterns and abstractions for working with any BaaS platform.

#### moai-cc-agents
- **Location:** `skills/`
- **Summary:** Agent system integration for Claude Code CLI with skill-based architecture.

#### moai-cc-commands
- **Location:** `skills/`
- **Summary:** Custom slash commands and command patterns for Claude Code workflows.

#### moai-cc-skills
- **Location:** `skills/`
- **Summary:** Skill creation, management, and orchestration patterns for Claude Code.

---

### Documentation

#### moai-alfred-dev-guide
- **Location:** `skills/`
- **Summary:** Comprehensive development guide for building skills and agents within MoAI-ADK framework.

#### moai-alfred-spec-authoring
- **Location:** `skills/`
- **Summary:** Tools and patterns for authoring formal specifications using EARS methodology.

#### documenting-sessions
- **Location:** `.claude/skills/`
- **Summary:** Creates professional session summary documents that track development work with evidence-based commit history, artifact links, and clear writing standards with consistent template structure.

#### internal-comms
- **Location:** `skills/`
- **Summary:** Resources for writing various types of internal communications using company-preferred formats. Covers 3P updates (Progress, Plans, Problems), newsletters, FAQs, status reports, leadership updates, and incident reports.

---

### Document Processing

#### docx (agentic-coding)
- **Location:** `skills/`
- **Summary:** Comprehensive document creation, editing, and analysis for .docx files with support for tracked changes, comments, formatting preservation, and text extraction.

#### docx (claude-skills)
- **Location:** `.claude/skills/`
- **Summary:** Comprehensive toolkit for creating, editing, and analyzing Word documents with support for tracked changes, comments, formatting preservation, and text extraction. Provides multiple workflows including OOXML editing.

#### pdf (agentic-coding)
- **Location:** `skills/`
- **Summary:** Comprehensive PDF manipulation toolkit for extracting text and tables, creating new PDFs, merging/splitting documents, and handling forms using pypdf, pdfplumber, and reportlab.

#### pdf (claude-skills)
- **Location:** `.claude/skills/`
- **Summary:** Comprehensive PDF manipulation toolkit for extracting text and tables, creating new PDFs, merging/splitting documents, and handling forms. Uses Python libraries for programmatic processing at scale.

#### pptx (agentic-coding)
- **Location:** `skills/`
- **Summary:** Presentation creation, editing, and analysis for PowerPoint files. Supports creating presentations from scratch using html2pptx, templates, and OOXML manipulation with visual validation.

#### pptx (claude-skills)
- **Location:** `.claude/skills/`
- **Summary:** Comprehensive presentation creation, editing, and analysis workflow supporting both creating new presentations from scratch or templates and editing existing presentations while preserving formatting.

#### xlsx (agentic-coding)
- **Location:** `skills/`
- **Summary:** Comprehensive spreadsheet creation, editing, and analysis with support for formulas, formatting, data analysis, and visualization. Emphasizes zero formula errors and proper formula usage.

#### xlsx (claude-skills)
- **Location:** `.claude/skills/`
- **Summary:** Comprehensive spreadsheet creation, editing, and analysis with support for formulas, formatting, data analysis, and visualization with emphasis on Excel formulas over hardcoded values and recalculation capabilities.

---

### Frontend Development

#### moai-domain-frontend
- **Location:** `skills/`
- **Summary:** Modern frontend patterns with React, Vue, Svelte including state management and performance.

---

### Meta Skills

#### brainstorming
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Structured brainstorming workflows for exploring ideas and solutions.

#### dispatching-parallel-agents
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Patterns for launching multiple agents concurrently to maximize performance and efficiency.

#### executing-plans
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Execute implementation plans systematically with quality gates and verification steps.

#### moai-alfred-practices
- **Location:** `skills/`
- **Summary:** Codified best practices and patterns for MoAI-ADK development workflows.

#### moai-alfred-todowrite-pattern
- **Location:** `skills/`
- **Summary:** Standardized TodoWrite patterns for tracking progress and task management in AI workflows.

#### sharing-skills
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Guide for contributing skills from local branch back to upstream repository via pull request using the branch → edit/create → commit → push → PR workflow.

#### skill-creator (agentic-coding)
- **Location:** `skills/`
- **Summary:** Guide for creating effective skills that extend Claude's capabilities with specialized knowledge, workflows, or tool integrations through structured process.

#### skill-creator (claude-skills)
- **Location:** `.claude/skills/`
- **Summary:** Guide for creating effective skills that extend Claude's capabilities with specialized knowledge, workflows, and tool integrations. Provides structured process from understanding through planning and iteration.

#### subagent-driven-development
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Execute implementation plans by dispatching fresh subagent per task with code review between tasks, enabling fast iteration with quality gates.

#### testing-skills-with-subagents
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Applies RED-GREEN-REFACTOR TDD cycle to process documentation by running baseline without skill, writing to address failures, and iterating through pressure scenarios.

#### using-superpowers
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Establishes mandatory workflows for finding and using skills including using Skill tool before announcing usage, checking for relevant skills before any task, and creating TodoWrite todos.

#### writing-skills
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Applies Test-Driven Development to process documentation by testing with subagents before writing, using RED-GREEN-REFACTOR cycle where failing test is baseline agent behavior.

---

### Platform Integration (BaaS)

#### moai-baas-cloudflare-ext
- **Location:** `skills/`
- **Summary:** Cloudflare Workers and platform integration.

#### moai-baas-neon-ext
- **Location:** `skills/`
- **Summary:** Neon serverless PostgreSQL integration.

#### moai-baas-railway-ext
- **Location:** `skills/`
- **Summary:** Railway platform deployment and integration.

#### moai-baas-supabase-ext
- **Location:** `skills/`
- **Summary:** Supabase integration for open-source Firebase alternative with PostgreSQL, authentication, and real-time features.

#### moai-baas-vercel-ext
- **Location:** `skills/`
- **Summary:** Vercel platform deployment and integration.

---

### Programming Languages

#### moai-lang-csharp
- **Location:** `skills/`
- **Summary:** C# language expertise with modern patterns and best practices.

#### moai-lang-go
- **Location:** `skills/`
- **Summary:** Go language development patterns and best practices.

#### moai-lang-php
- **Location:** `skills/`
- **Summary:** PHP language development patterns and modern practices.

#### moai-lang-python
- **Location:** `skills/`
- **Summary:** Enterprise-grade Python 3.13 expertise with FastAPI 0.115, Django 5.2 LTS, Pydantic v2, SQLAlchemy 2.0, async patterns, and production deployment strategies.

#### moai-lang-typescript
- **Location:** `skills/`
- **Summary:** Enterprise TypeScript 5.9 with strict typing, Next.js 16, Turbopack, React 19, tRPC, Zod for type-safe schemas, and framework-agnostic patterns.

---

### Project Management

#### managing-handoffs
- **Location:** `.claude/skills/`
- **Summary:** Manages handoff documents through their full lifecycle (create → work → resolve → archive) with evidence-based verification requiring implementation completion, documentation, passing tests, and git commits.

#### managing-imports
- **Location:** `.claude/skills/`
- **Summary:** Organizes incoming files and tracks import status through file staging workflow (inbox → staged → processing → archive) with duplicate detection via SHA256 hashing.

#### moai-alfred-issue-labels
- **Location:** `skills/`
- **Summary:** Automated issue labeling and categorization for better project organization and tracking.

#### moai-project-language-initializer
- **Location:** `skills/`
- **Summary:** Project initialization and language setup automation.

#### moai-session-info
- **Location:** `skills/`
- **Summary:** Session information tracking and management.

#### project-status
- **Location:** `.claude/skills/`
- **Summary:** Quick dashboard aggregating project status from multiple sources including active handoffs, recent sessions, current TODOs, import queue, and recent git activity.

---

### Requirements & Specifications

#### moai-foundation-ears
- **Location:** `skills/`
- **Summary:** Easy Approach to Requirements Syntax (EARS) for writing clear, testable requirements with event-driven, ubiquitous, state-driven, optional, and unwanted patterns.

#### moai-foundation-specs
- **Location:** `skills/`
- **Summary:** SPEC document lifecycle management with versioning, approval workflows, 50+ references, and SPEC-first TDD integration. Covers Draft, Active, Deprecated, and Archived states.

---

### Testing & QA

#### condition-based-waiting
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Wait for specific conditions to be met before proceeding, useful for async operations and integration testing.

#### defense-in-depth
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Multi-layered security and validation approach ensuring robustness through redundant checks.

#### moai-foundation-trust
- **Location:** `skills/`
- **Summary:** Complete TRUST 4 principles framework covering Test First (≥85% coverage), Readable (clear code), Unified (consistent patterns), and Secured (OWASP compliance) with enterprise quality gates.

#### playwright-skill
- **Location:** `.claude/skills/`
- **Summary:** Complete browser automation using Playwright that auto-detects dev servers, writes clean test scripts, and supports testing pages, filling forms, taking screenshots, and automating browser tasks.

#### test-driven-development
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Write test first, watch it fail, write minimal code to pass—ensures tests actually verify behavior by requiring failure first following Red-Green-Refactor cycle.

#### testing-anti-patterns
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Prevents testing mock behavior, production pollution with test-only methods, and mocking without understanding dependencies by establishing that tests must verify real behavior.

#### verification-before-completion
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Requires running verification commands and confirming output before making any success claims—evidence before assertions always, with no completion claims without fresh verification.

#### webapp-testing
- **Location:** `.claude/skills/`
- **Summary:** Toolkit for interacting with and testing local web applications using Playwright, supporting verification of frontend functionality, debugging UI behavior, capturing screenshots, and viewing browser logs.

---

### Version Control

#### finishing-a-development-branch
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Systematic workflow for completing development branches including final tests, documentation updates, and PR preparation.

#### moai-foundation-git
- **Location:** `skills/`
- **Summary:** Git workflow patterns, branching strategies, commit conventions, and integration with MoAI-ADK development pipeline.

#### using-git-worktrees
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Creates isolated git worktrees with systematic directory selection and safety verification, allowing work on multiple branches simultaneously without switching contexts.

---

### Visualization

#### claude-d3js-skill-main
- **Location:** `.claude/skills/`
- **Summary:** Creates custom, interactive data visualizations using D3.js for charts, graphs, network diagrams, geographic visualizations, and complex SVG-based visualizations requiring fine-grained control. Works across vanilla JavaScript, React, Vue, Svelte.

---

### Writing & Communication

#### collaborative-writing
- **Location:** `.claude/skills/`
- **Summary:** Co-creates professional and institutional writing through Socratic dialogue, integrating established voice patterns. Guides from conceptual intent to polished draft through discovery, message architecture, voice calibration, and collaborative drafting.

#### corpus-discovery-dialogue
- **Location:** `.claude/skills/`
- **Summary:** Transforms vague interest in a text corpus into concrete, answerable research questions with clear analytical roadmaps through Socratic questioning. Prevents aimless exploration.

#### writing-clearly-and-concisely
- **Location:** `.claude/skills/`
- **Summary:** Applies Strunk's timeless writing rules from The Elements of Style to any prose humans will read—documentation, commit messages, error messages, explanations—to make writing clearer, stronger, and more professional.

#### writing-plans
- **Location:** `.claude/skills/superpowers/`
- **Summary:** Creates comprehensive implementation plans with exact file paths, complete code examples, and verification steps assuming engineer has minimal domain knowledge, breaking work into bite-sized 2-5 minute tasks.

---

### MCP & Integration

#### mcp-builder
- **Location:** `skills/`
- **Summary:** Guide for creating high-quality MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. Provides comprehensive workflow for research, planning, implementation in both Python (FastMCP) and Node/TypeScript.

---

### Refactoring & Code Transformation

#### moai-essentials-refactor
- **Location:** `skills/`
- **Summary:** AI-powered refactoring with Context7 integration, automated code transformation using Rope patterns, technical debt quantification, and architecture evolution across multiple languages.

---

## Summary Statistics

### Total Counts

- **Repository Folders:** 6 top-level directories
- **Skills in .claude/skills:** 50+ skills
- **Skills in skills/ (moai-*):** 128+ skills
- **Skills in skills/ (other):** 12+ skills
- **Total Skills:** 190+ skills
- **Skill Categories:** 23 categories

### Key Themes

1. **Comprehensive Coverage:** From requirements to deployment, testing to documentation
2. **AI-Powered Development:** Alfred SuperAgent, Context7 integration, intelligent automation
3. **Quality Focus:** TRUST principles, 85%+ test coverage, systematic verification
4. **Multi-Language Support:** Python, TypeScript, Go, C#, PHP, Swift, and 20+ more
5. **Platform Integrations:** 9+ BaaS platforms, MCP servers, cloud platforms
6. **Enterprise-Grade:** Production-ready patterns, security compliance, performance optimization
7. **Modular Architecture:** Mix-and-match skills, agents, and workflows
8. **SPEC-First Philosophy:** Clear requirements before code, living documentation

---

*Document generated: 2025-11-18*
*Repository: claude-skill-eval*
