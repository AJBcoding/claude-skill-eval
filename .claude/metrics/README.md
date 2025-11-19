# Phase 2 Metrics System

This directory contains the configuration and documentation for the Phase 2 measurement framework.

## Overview

The metrics system tracks the effectiveness of Phase 2 configuration systems (agents, hooks, rules) by measuring five primary success criteria:

1. **Bug Catch Rate**: 90% of bugs caught before code execution
2. **Pattern Adherence**: Similar tasks follow identical patterns
3. **Redirection Reduction**: 50% reduction in Claude behavior corrections
4. **Debug Methodology**: Debugging follows 6-step process consistently
5. **Skill Activation**: Language/domain skills activated appropriately

## Files

### Configuration

- **`tracking.yml`**: Main metrics configuration
  - Defines all metrics to track
  - Specifies data collection points
  - Documents data format and formulas
  - Sets target values and thresholds

### Data Storage

- **`.claude/data/metrics.jsonl`**: Metrics event storage
  - JSON Lines format (one event per line)
  - Automatically written by agents
  - Analyzed by `scripts/analyze-metrics.py`

### Analysis

- **`scripts/analyze-metrics.py`**: Analysis script
  - Calculates all metrics from raw data
  - Generates summary reports
  - Outputs dashboard data as JSON
  - Run with: `python scripts/analyze-metrics.py`

### Documentation

- **`docs/metrics-dashboard.md`**: Metrics dashboard template
  - Visual representation of all metrics
  - Trend analysis and comparisons
  - Recommendations based on data
  - Update weekly with latest results

- **`analysis/phase2-baseline.md`**: Baseline measurements
  - Pre-Phase 2 state documentation
  - Baseline estimates for all metrics
  - Historical analysis
  - Validation methodology

## Quick Start

### 1. Verify Setup

Check that all components are in place:

```bash
# Check configuration file
cat .claude/metrics/tracking.yml

# Check data file exists
ls -la .claude/data/metrics.jsonl

# Test analysis script
python scripts/analyze-metrics.py
```

### 2. Start Collecting Metrics

Metrics are automatically collected when agents run. To manually log a metric:

```bash
# Append a metric event to the data file
echo '{"timestamp":"2025-11-19T10:00:00Z","event_type":"agent_completion","metric_name":"debug_methodology_adherence","agent_name":"debug-agent","session_id":"test-001","task_id":"task-001","data":{"steps_completed":["reproduce","isolate","hypothesis","test","fix","verify"],"steps_skipped":[],"bug_resolved":true,"session_duration":600,"bug_severity":"medium","bug_type":"logic"},"metadata":{"user":"developer","branch":"main"}}' >> .claude/data/metrics.jsonl
```

### 3. View Results

Run the analysis script to see current metrics:

```bash
python scripts/analyze-metrics.py
```

View the dashboard:

```bash
cat docs/metrics-dashboard.md
```

## Metric Collection Points

Metrics are collected at these points:

1. **Agent Activation**: When an agent starts
2. **Agent Completion**: When an agent finishes
3. **Hook Execution**: When a hook runs
4. **Error Occurrence**: When bugs are identified
5. **Code Changes**: When Edit/Write operations happen
6. **Skill Activation**: When skills are used

## Data Format

Each metric event is a single-line JSON object:

```json
{
  "timestamp": "ISO 8601 datetime",
  "event_type": "agent_activation|agent_completion|hook_execution|error_occurrence|code_change|skill_activation",
  "metric_name": "bug_catch_rate|pattern_adherence_rate|redirection_frequency|debug_methodology_adherence|skill_activation_rate",
  "agent_name": "debug-agent|consistency-agent|quality-agent",
  "session_id": "unique session identifier",
  "task_id": "unique task identifier",
  "data": {
    // Metric-specific fields (see tracking.yml)
  },
  "metadata": {
    "user": "username",
    "branch": "git branch",
    "commit": "git commit hash"
  }
}
```

## Agent Integration

Each agent has metric logging instructions:

### Debug Agent

Logs:
- Steps completed/skipped
- Bugs caught pre/during/post execution
- Bug severity and type
- Session duration

See: `.claude/agents/debug-agent/instructions.md` (Metrics Collection section)

### Consistency Agent

Logs:
- Pattern matches found
- Pattern suggestions made/accepted
- Skill activation reminders
- Task types and languages

See: `.claude/agents/consistency-agent/instructions.md` (Metrics Collection section)

### Quality Agent

Logs:
- Issues found by severity/category
- Quality scores
- Review duration
- Verdicts (pass/fail/recommendations)

See: `.claude/agents/quality-agent/instructions.md` (Metrics Collection section)

## Viewing Metrics

### Command Line

```bash
# Quick summary
python scripts/analyze-metrics.py

# Save to file
python scripts/analyze-metrics.py > analysis/metrics/report-$(date +%Y-%m-%d).txt

# View JSON output
cat analysis/metrics/latest.json | jq .
```

### Dashboard

The dashboard (`docs/metrics-dashboard.md`) provides:
- Executive summary with progress bars
- Detailed metric breakdowns
- Trend analysis
- Recommendations

Update weekly:
1. Run analysis script
2. Copy results to dashboard
3. Add commentary on trends
4. Update recommendations

## Troubleshooting

### No Data Collected

**Problem**: Analysis shows 0 events

**Solutions**:
- Verify agents are running (check agent.yml files)
- Check that agents have metric logging instructions
- Manually test metric logging (see Quick Start #2)
- Ensure `.claude/data/metrics.jsonl` is writable

### Malformed JSON Errors

**Problem**: Analysis script shows JSON parsing warnings

**Solutions**:
- Each line must be valid JSON
- No trailing commas
- No comments in data lines (comments start with #)
- Use online JSON validator to check format

### Script Errors

**Problem**: `python scripts/analyze-metrics.py` fails

**Solutions**:
- Check Python version: `python3 --version` (need 3.7+)
- Verify script is executable: `chmod +x scripts/analyze-metrics.py`
- Check file paths are correct
- Review error message for specific issue

### Missing Metrics

**Problem**: Some metrics not appearing in analysis

**Solutions**:
- Verify metric_name matches tracking.yml definitions
- Check that agents are logging correct metric names
- Ensure event_type is one of the defined types
- Review tracking.yml for metric configuration

## Customization

### Adding New Metrics

1. Edit `tracking.yml`:
   - Add metric definition under `metrics:` section
   - Define data fields
   - Set target value
   - Document calculation formula

2. Update analysis script:
   - Add calculation method to `MetricsAnalyzer` class
   - Update `generate_summary_report()` to include metric
   - Add to `generate_dashboard_data()` output

3. Update dashboard template:
   - Add section for new metric
   - Include target and progress bar
   - Document interpretation

4. Update agent instructions:
   - Add logging for new metric
   - Document when to log
   - Provide example event

### Adjusting Targets

Edit `tracking.yml` and update target values:

```yaml
metrics:
  bug_catch_rate:
    target: 90  # Change this value
```

### Changing Collection Points

Edit `tracking.yml` collection_points section:

```yaml
collection_points:
  - agent_activation
  - agent_completion
  # Add or remove collection points
```

## Best Practices

### Data Collection

- **Log consistently**: Use same format for all events
- **Include context**: Always fill in metadata fields
- **Be specific**: Use detailed metric_name and event_type
- **Validate format**: Test JSON validity before appending

### Analysis

- **Run regularly**: Weekly analysis minimum
- **Review trends**: Don't just look at current values
- **Compare to baseline**: Track improvement over time
- **Act on insights**: Use data to improve system

### Maintenance

- **Archive old data**: Move old metrics to archive/ after 90 days
- **Update baselines**: Re-establish baselines quarterly
- **Refine metrics**: Adjust based on what's useful
- **Document changes**: Note any metric definition changes

## Example Workflow

### Weekly Metrics Review

```bash
# 1. Run analysis
python scripts/analyze-metrics.py > analysis/metrics/week-$(date +%Y-%m-%d).txt

# 2. View summary
cat analysis/metrics/week-$(date +%Y-%m-%d).txt

# 3. Update dashboard
# - Copy key results to docs/metrics-dashboard.md
# - Add weekly commentary
# - Update trend section

# 4. Review against targets
# - Check which metrics are on track
# - Identify areas needing improvement
# - Update recommendations

# 5. Archive data (monthly)
# - Move old events to analysis/metrics/archive/
# - Keep last 90 days in active file
```

## References

- **Metric Definitions**: `.claude/metrics/tracking.yml`
- **Analysis Script**: `scripts/analyze-metrics.py`
- **Dashboard Template**: `docs/metrics-dashboard.md`
- **Baseline Data**: `analysis/phase2-baseline.md`
- **Agent Specifications**: `docs/agent-specifications.md`
- **Implementation Plan**: `docs/plans/2025-11-18-phase2-configuration-systems.md`

## Support

For questions or issues:
- Review this README
- Check `tracking.yml` for metric definitions
- See agent instructions for logging examples
- Review baseline document for context
