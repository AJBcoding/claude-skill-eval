# Phase 2 Rollback - Quick Start Guide

## Emergency Rollback (< 1 second)

```bash
cd /home/user/claude-skill-eval
./scripts/disable-phase2.sh --emergency
```

**What it does:**
- Disables all Phase 2 components immediately
- Skips backup for maximum speed
- Completes in ~0.5 seconds

**Use when:** Production is down, need immediate rollback

---

## Standard Rollback (< 1 second, with backup)

```bash
cd /home/user/claude-skill-eval
./scripts/disable-phase2.sh --full
```

**What it does:**
- Disables all Phase 2 components
- Creates timestamped backup
- Completes in ~0.8 seconds

**Use when:** Normal rollback needed, want backup safety

---

## Verify Rollback Successful

```bash
./scripts/disable-phase2.sh --verify
```

**Checks:**
- All Phase 2 components disabled ✓
- Phase 1 (37 skills) intact ✓

---

## Re-enable Phase 2

```bash
./scripts/disable-phase2.sh --enable
```

**What it does:**
- Re-enables all Phase 2 components
- Removes disable markers
- Completes in ~0.5 seconds

---

## Disable Single Agent Only

```bash
# Disable debug agent only
./scripts/disable-phase2.sh --agent debug-agent

# Disable consistency agent only
./scripts/disable-phase2.sh --agent consistency-agent

# Disable quality agent only
./scripts/disable-phase2.sh --agent quality-agent
```

**Use when:** One agent causing issues, others working fine

---

## All Available Commands

```bash
./scripts/disable-phase2.sh --help
```

---

## File Locations

- **Script:** `/home/user/claude-skill-eval/scripts/disable-phase2.sh`
- **Docs:** `/home/user/claude-skill-eval/docs/rollback-procedure.md`
- **Backups:** `/home/user/claude-skill-eval/.claude/backups/`
- **Logs:** `/home/user/claude-skill-eval/.claude/rollback/`

---

## What Gets Disabled

✓ Debug Agent (`.claude/agents/debug-agent`)
✓ Consistency Agent (`.claude/agents/consistency-agent`)
✓ Quality Agent (`.claude/agents/quality-agent`)
✓ Pre-Implementation Hook (`.claude/hooks/pre-implementation.yml`)
✓ Post-Error Hook (`.claude/hooks/post-error.yml`)
✓ Post-Implementation Hook (`.claude/hooks/post-implementation.yml`)
✓ Trigger System (`.claude/config/triggers.yml`)
✓ Phase 2 Rules (debugging, consistency, quality)

---

## What Stays Enabled (Phase 1)

✓ All 37 Skills (`.claude/skills/`)
✓ Skill Activation Rules (`.claude/rules/skill-activation.md`)

---

## Troubleshooting

**Problem:** Script permission denied
```bash
chmod +x /home/user/claude-skill-eval/scripts/disable-phase2.sh
```

**Problem:** Phase 2 still active after rollback
```bash
./scripts/disable-phase2.sh --verify
# Check output for which components still active
```

**Problem:** Want to test without making changes
```bash
./scripts/disable-phase2.sh --dry-run --full
```

---

## Performance

| Operation | Time | Target Met |
|-----------|------|------------|
| Emergency Rollback | 0.56s | ✅ (target: 30s) |
| Full Rollback | 0.77s | ✅ (target: 2m) |
| Re-enable | 0.46s | ✅ (target: 1m) |
| Partial Rollback | 0.43s | ✅ (target: 20s) |

**All operations complete well under targets.**
