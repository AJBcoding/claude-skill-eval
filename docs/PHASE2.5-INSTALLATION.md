# Phase 2.5 Domain Coordinators - Installation & Setup Guide

**Complete guide to installing, activating, and configuring domain coordinators**

---

## Pre-Installation Checklist

Before you start, verify you have:

- ✅ Phase 2 agents activated (debug, consistency, quality)
- ✅ 37 curated skills available
- ✅ Obra superpowers enabled
- ✅ Latest Claude Code version

---

## Installation Steps

### Step 1: Verify Files Are Present (2 minutes)

```bash
# Check coordinator directory exists
ls -la .claude/coordinators/

# Should show:
# architecture/
# data-analysis/
# document/
# git-workflow/
# language/
# planning/
# quality/
# README.md
```

### Step 2: Verify Configuration Files (2 minutes)

```bash
# Check main coordinator configurations
ls -la .claude/coordinators/*/coordinator.yml

# Should list 7 .yml files:
# architecture/coordinator.yml
# data-analysis/coordinator.yml
# document/coordinator.yml
# git-workflow/coordinator.yml
# language/coordinator.yml
# planning/coordinator.yml
# quality/coordinator.yml
```

### Step 3: Verify Documentation (1 minute)

```bash
# Check coordinator documentation
ls -la .claude/coordinators/README.md
ls -la .claude/coordinators/language/activate.md

# Check Phase 2.5 docs
ls -la docs/phase2.5-*.md
ls -la docs/PHASE2.5-*.md
```

### Step 4: Reload Configuration (1 minute)

**Option A: If using Claude Code CLI**
```bash
# Restart Claude Code session to load new configurations
# Exit current session and start new one
```

**Option B: If using Claude Code GUI**
- Refresh the configuration
- Coordinators will auto-load

### Step 5: Verify Installation Success (1 minute)

Try a simple test:
```
"Create a Python function"
```

**Expected result:**
- Language Coordinator activates
- Routes to moai-lang-python
- Suggests TDD approach

If this works, ✅ **Installation successful!**

---

## Activation Guide

### Automatic Activation (Default)

Coordinators activate automatically when:

1. **File extensions match**
   - .py → Language Coordinator (Python)
   - .tsx → Language Coordinator (TypeScript)
   - .swift → Language Coordinator (Swift)
   - .docx → Document Coordinator
   - .xlsx → Document Coordinator
   - .pdf → Document Coordinator

2. **Keywords detected**
   - "FastAPI" → Language Coordinator (Python)
   - "React" → Language Coordinator (TypeScript)
   - "SwiftUI" → Language Coordinator (Swift)
   - "database schema" → Architecture Coordinator
   - "plan sprint" → Planning Coordinator
   - etc.

3. **Context recognized**
   - Multi-layer task → Architecture Coordinator
   - Data analysis → Data Analysis Coordinator
   - Quality review → Quality Coordinator
   - Git operations → Git Workflow Coordinator

### Manual Activation

Explicitly invoke a coordinator:

```
"Use the [coordinator name] to [task]"

Examples:
- "Use the language coordinator to write this Python function"
- "Use the planning coordinator to organize this project"
- "Use the quality coordinator to review this code"
```

### Testing Activation

Verify each coordinator:

```bash
# Test Language Coordinator
"Create a FastAPI endpoint"
→ Should activate language coordinator for Python

# Test Architecture Coordinator
"Build user registration (database, API, UI)"
→ Should activate architecture coordinator

# Test Document Coordinator
"Generate a quarterly report"
→ Should activate document coordinator

# Test Quality Coordinator
"Check code quality before release"
→ Should activate quality coordinator

# Test Data Analysis Coordinator
"Analyze this CSV file"
→ Should activate data analysis coordinator

# Test Planning Coordinator
"Plan a 2-week sprint"
→ Should activate planning coordinator

# Test Git Workflow Coordinator
"Create feature branch and setup PR"
→ Should activate git workflow coordinator
```

---

## Configuration Files Location

### Directory Structure
```
.claude/coordinators/
├── README.md
│   └── Main coordinator system documentation
│
├── language/
│   ├── coordinator.yml       ← Main configuration
│   ├── routes.yml            ← Routing rules
│   ├── activate.md           ← How to use
│   └── examples/
│       ├── python-fastapi-test.md
│       └── typescript-react-test.md
│
├── architecture/
│   └── coordinator.yml       ← Configuration
│
├── document/
│   └── coordinator.yml       ← Configuration
│
├── quality/
│   └── coordinator.yml       ← Configuration
│
├── data-analysis/
│   └── coordinator.yml       ← Configuration
│
├── planning/
│   └── coordinator.yml       ← Configuration
│
└── git-workflow/
    └── coordinator.yml       ← Configuration
```

### Key Files for Each Coordinator

| Coordinator | Config File | Purpose |
|------------|-------------|---------|
| Language | language/coordinator.yml + routes.yml | Python/TS/Swift routing |
| Architecture | architecture/coordinator.yml | Cross-layer coordination |
| Document | document/coordinator.yml | Format-aware processing |
| Quality | quality/coordinator.yml | Multi-dimensional QA |
| Data Analysis | data-analysis/coordinator.yml | Data pipelines |
| Planning | planning/coordinator.yml | Project orchestration |
| Git Workflow | git-workflow/coordinator.yml | Safe git operations |

---

## Custom Configuration

### Editing a Coordinator Configuration

**Example: Add new FastAPI version detection to Language Coordinator**

1. Open `.claude/coordinators/language/coordinator.yml`
2. Find the `fastapi` trigger section
3. Add new keyword:
   ```yaml
   triggers:
     keywords:
       - FastAPI
       - fastapi
       - "FastAPI v0.115"  # Add new version
   ```
4. Save file
5. Restart Claude Code session

### Common Customizations

**Add Python package trigger:**
```yaml
# In .claude/coordinators/language/coordinator.yml
python:
  triggers:
    keywords:
      - FastAPI
      - Django
      - "your-custom-package"  # Add here
```

**Add new file pattern:**
```yaml
# In .claude/coordinators/language/routes.yml
- pattern: "your_custom_pattern_\.py$"
  route_to: moai-lang-python
```

**Modify quality thresholds:**
```yaml
# In .claude/coordinators/quality/coordinator.yml
thresholds:
  test_coverage: ">= 85%"  # Change from 80%
  api_response_time: "< 150ms"  # Change from 200ms
```

---

## Integration with Phase 2

### Phase 2 Agents
Domain coordinators work seamlessly with Phase 2:

1. **Consistency Agent** (Phase 2)
   - Validates patterns before routing
   - Coordinators enhance with domain-specific checks

2. **Debug Agent** (Phase 2)
   - Handles errors
   - Coordinators add language-specific debugging

3. **Quality Agent** (Phase 2)
   - Basic quality checks
   - Quality Coordinator extends with multi-dimensional checks

### Activation Order
```
User Request
    ↓
Consistency Agent (Phase 2) ← Initial validation
    ↓
Domain Coordinator ← Smart routing & orchestration
    ↓
Specialized Skills ← Implementation
    ↓
Quality Agent (Phase 2) ← Final validation
```

---

## Verification Procedures

### Verify All Coordinators Working

Run through each coordinator:

**1. Language Coordinator**
```
Input: "Create a FastAPI endpoint"
Expected: Routes to Python skill with TDD
Status: ✅ or ❌
```

**2. Architecture Coordinator**
```
Input: "Design database schema and API endpoint"
Expected: Coordinates database and backend domains
Status: ✅ or ❌
```

**3. Document Coordinator**
```
Input: "Create a Word document report"
Expected: Routes to docx skill
Status: ✅ or ❌
```

**4. Quality Coordinator**
```
Input: "Validate code quality"
Expected: Runs all quality gates
Status: ✅ or ❌
```

**5. Data Analysis Coordinator**
```
Input: "Analyze CSV data"
Expected: Routes to data analysis pipeline
Status: ✅ or ❌
```

**6. Planning Coordinator**
```
Input: "Plan this sprint"
Expected: Creates structured plan
Status: ✅ or ❌
```

**7. Git Workflow Coordinator**
```
Input: "Create feature branch"
Expected: Sets up safe git workflow
Status: ✅ or ❌
```

### Troubleshooting Verification Failures

| Issue | Solution |
|-------|----------|
| Coordinator not activating | Check trigger keywords match exactly |
| Wrong coordinator activates | Check precedence levels in config |
| Slow activation | Clear detection cache, optimize patterns |
| Configuration not loading | Restart Claude Code session |

---

## Performance Tuning

### Cache Configuration

**Default settings (in coordinator.yml):**
```yaml
optimizations:
  cache_detection:
    enabled: true
    ttl: 300  # 5 minutes
```

**To optimize:**
- **Increase TTL** if repeated same work: `ttl: 600` (10 min)
- **Disable cache** if frequent changes: `enabled: false`

### Detection Performance

**Check performance:**
- Activation should complete in < 2 seconds
- If slower, check for pattern conflicts

**Optimize patterns:**
- Use specific file extensions over broad patterns
- Order patterns by frequency
- Use early termination for common cases

---

## Backup & Recovery

### Backup Configurations

Before customizing:
```bash
# Backup all coordinator configs
cp -r .claude/coordinators .claude/coordinators.backup
```

### Restore to Defaults

If something breaks:
```bash
# Restore from backup
rm -rf .claude/coordinators
cp -r .claude/coordinators.backup .claude/coordinators
```

---

## Monitoring & Metrics

### What to Monitor

1. **Activation Accuracy**
   - Is the right coordinator being activated?
   - Target: 95%+ accuracy

2. **Response Time**
   - How fast do coordinators detect and route?
   - Target: < 2 seconds

3. **Usage Frequency**
   - Which coordinators are most used?
   - Helps prioritize improvements

### Collecting Metrics

Enable metric tracking in coordinator.yml:
```yaml
metrics:
  track:
    - correct_detection
    - activation_time
    - skill_accuracy
    - multi_coordinator_usage
```

---

## Upgrading Coordinators

### When Coordinators Update

If Phase 2.5 is updated:

1. **Backup current config**
   ```bash
   cp -r .claude/coordinators .claude/coordinators.old
   ```

2. **Download updates**
   ```bash
   git pull origin main
   ```

3. **Merge custom changes** (if you modified configs)
   ```bash
   # Review changes in .claude/coordinators/
   # Re-apply your customizations
   ```

4. **Test after upgrade**
   ```
   "Test coordinator activation"
   ```

---

## Uninstallation (If Needed)

To remove coordinators and revert to obra-only:

```bash
# Remove coordinator configurations
rm -rf .claude/coordinators

# Remove Phase 2.5 documentation
rm docs/phase2.5-*.md
rm docs/PHASE2.5-*.md

# Restart Claude Code
# Obra patterns still available and active
```

**Note:** This is not recommended - coordinators enhance without overhead.

---

## Next Steps

1. ✅ **Verify Installation** - Run checks above
2. ✅ **Test Coordinators** - Try examples
3. ✅ **Customize** - Add your patterns (optional)
4. ✅ **Monitor** - Track metrics
5. ✅ **Integrate** - Use in daily work

---

## Support Resources

| Need | Resource |
|------|----------|
| Quick start | `docs/PHASE2.5-QUICKSTART.md` |
| Full guide | `.claude/coordinators/README.md` |
| Architecture | `docs/phase2.5-design.md` |
| Language details | `.claude/coordinators/language/activate.md` |
| Implementation | `docs/phase2.5-full-stack-complete.md` |

---

## Checklist: Installation Complete ✅

- ✅ Files verified in `.claude/coordinators/`
- ✅ Configurations loaded
- ✅ All 7 coordinators tested
- ✅ Integration with Phase 2 verified
- ✅ Ready for daily use

**Status: READY FOR PRODUCTION USE**

---

## Frequently Asked Questions

**Q: Do I need to do anything special to use coordinators?**
A: No, they activate automatically. Just work naturally.

**Q: Can I bypass coordinators?**
A: Yes, use `--no-coordinator-name` or obra patterns directly.

**Q: Do coordinators slow things down?**
A: No, detection is cached and < 2 seconds typically.

**Q: What if a coordinator doesn't activate?**
A: Check trigger patterns in coordinator.yml or activate manually.

**Q: Can I customize trigger keywords?**
A: Yes, edit coordinator.yml and restart session.

**Q: Are my custom configurations backed up?**
A: We recommend backing up before customizing.

---

**Installation Guide Complete**
**Time to completion: 5-10 minutes**
**Status: Ready to use**