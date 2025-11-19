# Phase 2 Metrics - Quick Reference Card

## 📊 5 Success Metrics

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| **Bug Catch Rate** | TBD | 90% | ○ |
| **Pattern Adherence** | TBD | 90% | ○ |
| **Redirection Reduction** | TBD | 50% | ○ |
| **Debug Methodology** | TBD | 95% | ○ |
| **Skill Activation** | TBD | 85% | ○ |

Legend: ✓ On Track | ✗ Below Target | ○ No Data Yet

---

## 🚀 Quick Commands

### View Current Metrics
```bash
python scripts/analyze-metrics.py
```

### View Dashboard
```bash
cat docs/metrics-dashboard.md
```

### Check Raw Data
```bash
cat .claude/data/metrics.jsonl
```

### Weekly Report
```bash
python scripts/analyze-metrics.py > analysis/metrics/week-$(date +%Y-%m-%d).txt
```

---

## 📝 What Gets Logged

### Debug Agent
- Steps completed/skipped
- Bugs caught pre/during/post execution
- Bug severity and type

### Consistency Agent
- Pattern matches found/followed
- Skill activation reminders
- Task types

### Quality Agent
- Issues by severity/category
- Quality scores
- Review verdicts

---

## 📁 Key Files

| Purpose | File Path |
|---------|-----------|
| Configuration | `.claude/metrics/tracking.yml` |
| Data Storage | `.claude/data/metrics.jsonl` |
| Analysis Script | `scripts/analyze-metrics.py` |
| Dashboard | `docs/metrics-dashboard.md` |
| Baseline | `analysis/phase2-baseline.md` |

---

## 🔍 Troubleshooting

**No data collected?**
- Check agents are running
- Verify `.claude/data/metrics.jsonl` is writable

**Script errors?**
- Python 3.7+ required
- Check file paths are correct

**Invalid JSON?**
- Each line must be valid JSON
- No trailing commas
- Comments start with #

---

## 📅 Weekly Workflow

1. Run analysis script
2. Review results
3. Update dashboard
4. Add commentary
5. Update recommendations

---

## 🎯 Success Criteria

Phase 2 is successful when:
- ✓ Bug Catch Rate ≥ 90%
- ✓ Pattern Adherence ≥ 90%
- ✓ Redirection ≥ 50% reduction
- ✓ Debug Methodology ≥ 95%
- ✓ Skill Activation ≥ 85%

---

**Last Updated**: 2025-11-19
**For Details**: See `.claude/metrics/README.md`
