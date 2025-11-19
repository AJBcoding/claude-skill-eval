#!/bin/bash

#==============================================================================
# Phase 2 Rollback Script
# Version: 1.0.0
# Purpose: Safely disable Phase 2 configuration in under 2 minutes
# Created: 2025-11-19
#==============================================================================

set -e  # Exit on error (disabled for certain operations)

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$PROJECT_ROOT/.claude"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_DIR="$CLAUDE_DIR/rollback"
LOG_FILE="$LOG_DIR/rollback-$TIMESTAMP.log"
BACKUP_DIR="$CLAUDE_DIR/backups"

# Flags
DRY_RUN=false
EMERGENCY=false
FULL_ROLLBACK=false
TEMPORARY=false
PERMANENT=false
ENABLE=false
VERIFY_ONLY=false
VERIFY_ENABLED=false
SPECIFIC_AGENT=""
RESTORE_TIMESTAMP=""
CREATE_BACKUP=true

#==============================================================================
# Logging Functions
#==============================================================================

log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $*" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $*" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" | tee -a "$LOG_FILE"
}

#==============================================================================
# Utility Functions
#==============================================================================

init_log_dir() {
    mkdir -p "$LOG_DIR"
    log_info "Rollback script started at $(date)"
    log_info "Log file: $LOG_FILE"
}

create_backup() {
    if [ "$CREATE_BACKUP" = false ]; then
        log_info "Skipping backup creation (emergency mode or disabled)"
        return 0
    fi

    log_info "Creating backup of Phase 2 components..."

    local backup_root="$BACKUP_DIR/phase2-$TIMESTAMP"
    mkdir -p "$backup_root"

    # Backup agents
    if [ -d "$CLAUDE_DIR/agents" ]; then
        cp -r "$CLAUDE_DIR/agents/debug-agent" "$backup_root/" 2>/dev/null || true
        cp -r "$CLAUDE_DIR/agents/consistency-agent" "$backup_root/" 2>/dev/null || true
        cp -r "$CLAUDE_DIR/agents/quality-agent" "$backup_root/" 2>/dev/null || true
        log_info "Backed up agents to $backup_root/"
    fi

    # Backup hooks
    if [ -d "$CLAUDE_DIR/hooks" ]; then
        mkdir -p "$backup_root/hooks"
        cp "$CLAUDE_DIR/hooks/pre-implementation.yml" "$backup_root/hooks/" 2>/dev/null || true
        cp "$CLAUDE_DIR/hooks/post-error.yml" "$backup_root/hooks/" 2>/dev/null || true
        cp "$CLAUDE_DIR/hooks/post-implementation.yml" "$backup_root/hooks/" 2>/dev/null || true
        cp "$CLAUDE_DIR/hooks/validate-hooks.sh" "$backup_root/hooks/" 2>/dev/null || true
        log_info "Backed up hooks to $backup_root/hooks/"
    fi

    # Backup config
    if [ -d "$CLAUDE_DIR/config" ]; then
        mkdir -p "$backup_root/config"
        cp "$CLAUDE_DIR/config/triggers.yml" "$backup_root/config/" 2>/dev/null || true
        log_info "Backed up triggers to $backup_root/config/"
    fi

    # Backup rules
    if [ -d "$CLAUDE_DIR/rules" ]; then
        mkdir -p "$backup_root/rules"
        cp "$CLAUDE_DIR/rules/debugging-methodology.md" "$backup_root/rules/" 2>/dev/null || true
        cp "$CLAUDE_DIR/rules/consistency-patterns.md" "$backup_root/rules/" 2>/dev/null || true
        cp "$CLAUDE_DIR/rules/quality-standards.md" "$backup_root/rules/" 2>/dev/null || true
        log_info "Backed up rules to $backup_root/rules/"
    fi

    # Create archive
    if [ "$PERMANENT" = true ]; then
        log_info "Creating backup archive for permanent removal..."
        cd "$BACKUP_DIR"
        tar -czf "phase2-$TIMESTAMP.tar.gz" "phase2-$TIMESTAMP" 2>/dev/null
        if [ $? -eq 0 ]; then
            log_success "Backup archive created: $BACKUP_DIR/phase2-$TIMESTAMP.tar.gz"
            rm -rf "$backup_root"
        else
            log_error "Failed to create backup archive"
            return 4
        fi
    else
        log_success "Backup created: $backup_root"
    fi

    return 0
}

disable_agent() {
    local agent_name="$1"
    local agent_path="$CLAUDE_DIR/agents/$agent_name"
    local disabled_path="$agent_path.disabled"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would disable agent: $agent_name"
        return 0
    fi

    if [ -d "$agent_path" ]; then
        if [ "$TEMPORARY" = true ]; then
            touch "$agent_path/.disabled"
            log_success "Temporarily disabled agent: $agent_name"
        elif [ "$PERMANENT" = true ]; then
            rm -rf "$agent_path"
            log_success "Permanently removed agent: $agent_name"
        else
            mv "$agent_path" "$disabled_path"
            log_success "Disabled agent: $agent_name (renamed to $agent_name.disabled)"
        fi
    else
        if [ -d "$disabled_path" ]; then
            log_warning "Agent already disabled: $agent_name"
        else
            log_warning "Agent not found: $agent_name"
        fi
    fi
}

enable_agent() {
    local agent_name="$1"
    local agent_path="$CLAUDE_DIR/agents/$agent_name"
    local disabled_path="$agent_path.disabled"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would enable agent: $agent_name"
        return 0
    fi

    # Check for temporary disable marker
    if [ -f "$agent_path/.disabled" ]; then
        rm "$agent_path/.disabled"
        log_success "Re-enabled agent: $agent_name"
        return 0
    fi

    # Check for renamed directory
    if [ -d "$disabled_path" ]; then
        mv "$disabled_path" "$agent_path"
        log_success "Re-enabled agent: $agent_name"
    else
        if [ -d "$agent_path" ]; then
            log_warning "Agent already enabled: $agent_name"
        else
            log_error "Cannot enable agent: $agent_name (not found in disabled state)"
            return 1
        fi
    fi
}

disable_hook() {
    local hook_name="$1"
    local hook_path="$CLAUDE_DIR/hooks/$hook_name"
    local disabled_path="$hook_path.disabled"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would disable hook: $hook_name"
        return 0
    fi

    if [ -f "$hook_path" ]; then
        if [ "$TEMPORARY" = true ]; then
            touch "$hook_path.disabled"
            log_success "Temporarily disabled hook: $hook_name"
        elif [ "$PERMANENT" = true ]; then
            rm -f "$hook_path"
            log_success "Permanently removed hook: $hook_name"
        else
            mv "$hook_path" "$disabled_path"
            log_success "Disabled hook: $hook_name"
        fi
    else
        if [ -f "$disabled_path" ]; then
            log_warning "Hook already disabled: $hook_name"
        else
            log_warning "Hook not found: $hook_name"
        fi
    fi
}

enable_hook() {
    local hook_name="$1"
    local hook_path="$CLAUDE_DIR/hooks/$hook_name"
    local disabled_path="$hook_path.disabled"
    local marker_path="$hook_path.disabled"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would enable hook: $hook_name"
        return 0
    fi

    # Check for temporary marker
    if [ -f "$marker_path" ] && [ -f "$hook_path" ]; then
        rm "$marker_path"
        log_success "Re-enabled hook: $hook_name"
        return 0
    fi

    # Check for renamed file
    if [ -f "$disabled_path" ]; then
        mv "$disabled_path" "$hook_path"
        log_success "Re-enabled hook: $hook_name"
    else
        if [ -f "$hook_path" ]; then
            log_warning "Hook already enabled: $hook_name"
        else
            log_error "Cannot enable hook: $hook_name (not found in disabled state)"
            return 1
        fi
    fi
}

disable_triggers() {
    local trigger_path="$CLAUDE_DIR/config/triggers.yml"
    local disabled_path="$trigger_path.disabled"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would disable trigger system"
        return 0
    fi

    if [ -f "$trigger_path" ]; then
        if [ "$TEMPORARY" = true ]; then
            touch "$trigger_path.disabled"
            log_success "Temporarily disabled trigger system"
        elif [ "$PERMANENT" = true ]; then
            rm -f "$trigger_path"
            log_success "Permanently removed trigger system"
        else
            mv "$trigger_path" "$disabled_path"
            log_success "Disabled trigger system"
        fi
    else
        log_warning "Trigger system already disabled or not found"
    fi
}

enable_triggers() {
    local trigger_path="$CLAUDE_DIR/config/triggers.yml"
    local disabled_path="$trigger_path.disabled"
    local marker_path="$trigger_path.disabled"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would enable trigger system"
        return 0
    fi

    # Check for temporary marker
    if [ -f "$marker_path" ] && [ -f "$trigger_path" ]; then
        rm "$marker_path"
        log_success "Re-enabled trigger system"
        return 0
    fi

    # Check for renamed file
    if [ -f "$disabled_path" ]; then
        mv "$disabled_path" "$trigger_path"
        log_success "Re-enabled trigger system"
    else
        if [ -f "$trigger_path" ]; then
            log_warning "Trigger system already enabled"
        else
            log_error "Cannot enable trigger system (not found in disabled state)"
            return 1
        fi
    fi
}

disable_rules() {
    local rules=(
        "debugging-methodology.md"
        "consistency-patterns.md"
        "quality-standards.md"
    )

    for rule in "${rules[@]}"; do
        local rule_path="$CLAUDE_DIR/rules/$rule"
        local disabled_path="$rule_path.disabled"

        if [ "$DRY_RUN" = true ]; then
            log_info "[DRY RUN] Would disable rule: $rule"
            continue
        fi

        if [ -f "$rule_path" ]; then
            if [ "$TEMPORARY" = true ]; then
                touch "$rule_path.disabled"
                log_success "Temporarily disabled rule: $rule"
            elif [ "$PERMANENT" = true ]; then
                rm -f "$rule_path"
                log_success "Permanently removed rule: $rule"
            else
                mv "$rule_path" "$disabled_path"
                log_success "Disabled rule: $rule"
            fi
        else
            if [ -f "$disabled_path" ]; then
                log_warning "Rule already disabled: $rule"
            else
                log_warning "Rule not found: $rule"
            fi
        fi
    done
}

enable_rules() {
    local rules=(
        "debugging-methodology.md"
        "consistency-patterns.md"
        "quality-standards.md"
    )

    for rule in "${rules[@]}"; do
        local rule_path="$CLAUDE_DIR/rules/$rule"
        local disabled_path="$rule_path.disabled"
        local marker_path="$rule_path.disabled"

        if [ "$DRY_RUN" = true ]; then
            log_info "[DRY RUN] Would enable rule: $rule"
            continue
        fi

        # Check for temporary marker
        if [ -f "$marker_path" ] && [ -f "$rule_path" ]; then
            rm "$marker_path"
            log_success "Re-enabled rule: $rule"
            continue
        fi

        # Check for renamed file
        if [ -f "$disabled_path" ]; then
            mv "$disabled_path" "$rule_path"
            log_success "Re-enabled rule: $rule"
        else
            if [ -f "$rule_path" ]; then
                log_warning "Rule already enabled: $rule"
            else
                log_warning "Cannot enable rule: $rule (not found in disabled state)"
            fi
        fi
    done
}

verify_phase1_intact() {
    log_info "Verifying Phase 1 integrity..."

    local errors=0

    # Check skills directory exists
    if [ ! -d "$CLAUDE_DIR/skills" ]; then
        log_error "Skills directory missing!"
        errors=$((errors + 1))
    else
        log_success "Skills directory exists"
    fi

    # Count skills (should be 37)
    if [ -d "$CLAUDE_DIR/skills" ]; then
        local skill_count=$(ls -1 "$CLAUDE_DIR/skills" | wc -l)
        if [ "$skill_count" -eq 37 ]; then
            log_success "All 37 skills present"
        else
            log_warning "Expected 37 skills, found $skill_count"
            errors=$((errors + 1))
        fi
    fi

    # Check Phase 1 rules
    if [ ! -f "$CLAUDE_DIR/rules/skill-activation.md" ]; then
        log_error "Phase 1 rules missing!"
        errors=$((errors + 1))
    else
        log_success "Phase 1 rules intact"
    fi

    # Check for disabled files in Phase 1
    if find "$CLAUDE_DIR/skills" -name "*.disabled" 2>/dev/null | grep -q .; then
        log_error "Some Phase 1 skills are disabled!"
        errors=$((errors + 1))
    else
        log_success "No Phase 1 skills disabled"
    fi

    if [ $errors -eq 0 ]; then
        log_success "Phase 1 integrity check PASSED"
        return 0
    else
        log_error "Phase 1 integrity check FAILED ($errors errors)"
        return 3
    fi
}

verify_phase2_disabled() {
    log_info "Verifying Phase 2 components are disabled..."

    local components_active=0

    # Check agents
    for agent in debug-agent consistency-agent quality-agent; do
        if [ -d "$CLAUDE_DIR/agents/$agent" ]; then
            # Check for temporary disable marker
            if [ -f "$CLAUDE_DIR/agents/$agent/.disabled" ]; then
                log_success "Agent disabled (temporary): $agent"
            else
                log_error "Agent still enabled: $agent"
                components_active=$((components_active + 1))
            fi
        else
            log_success "Agent disabled: $agent"
        fi
    done

    # Check hooks
    for hook in pre-implementation.yml post-error.yml post-implementation.yml; do
        if [ -f "$CLAUDE_DIR/hooks/$hook" ]; then
            # Check for temporary disable marker
            if [ -f "$CLAUDE_DIR/hooks/$hook.disabled" ]; then
                log_success "Hook disabled (temporary): $hook"
            else
                log_error "Hook still enabled: $hook"
                components_active=$((components_active + 1))
            fi
        else
            log_success "Hook disabled: $hook"
        fi
    done

    # Check triggers
    if [ -f "$CLAUDE_DIR/config/triggers.yml" ]; then
        if [ -f "$CLAUDE_DIR/config/triggers.yml.disabled" ]; then
            log_success "Triggers disabled (temporary)"
        else
            log_error "Triggers still enabled"
            components_active=$((components_active + 1))
        fi
    else
        log_success "Triggers disabled"
    fi

    # Check rules
    for rule in debugging-methodology.md consistency-patterns.md quality-standards.md; do
        if [ -f "$CLAUDE_DIR/rules/$rule" ]; then
            if [ -f "$CLAUDE_DIR/rules/$rule.disabled" ]; then
                log_success "Rule disabled (temporary): $rule"
            else
                log_error "Rule still enabled: $rule"
                components_active=$((components_active + 1))
            fi
        else
            log_success "Rule disabled: $rule"
        fi
    done

    if [ $components_active -eq 0 ]; then
        log_success "All Phase 2 components disabled"
        return 0
    else
        log_error "$components_active Phase 2 components still active"
        return 2
    fi
}

verify_phase2_enabled() {
    log_info "Verifying Phase 2 components are enabled..."

    local components_disabled=0

    # Check agents
    for agent in debug-agent consistency-agent quality-agent; do
        if [ -d "$CLAUDE_DIR/agents/$agent" ]; then
            if [ -f "$CLAUDE_DIR/agents/$agent/.disabled" ]; then
                log_error "Agent still disabled (temporary): $agent"
                components_disabled=$((components_disabled + 1))
            else
                log_success "Agent enabled: $agent"
            fi
        else
            log_error "Agent not found: $agent"
            components_disabled=$((components_disabled + 1))
        fi
    done

    # Check hooks
    for hook in pre-implementation.yml post-error.yml post-implementation.yml; do
        if [ -f "$CLAUDE_DIR/hooks/$hook" ]; then
            if [ -f "$CLAUDE_DIR/hooks/$hook.disabled" ]; then
                log_error "Hook still disabled (temporary): $hook"
                components_disabled=$((components_disabled + 1))
            else
                log_success "Hook enabled: $hook"
            fi
        else
            log_error "Hook not found: $hook"
            components_disabled=$((components_disabled + 1))
        fi
    done

    # Check triggers
    if [ -f "$CLAUDE_DIR/config/triggers.yml" ]; then
        if [ -f "$CLAUDE_DIR/config/triggers.yml.disabled" ]; then
            log_error "Triggers still disabled (temporary)"
            components_disabled=$((components_disabled + 1))
        else
            log_success "Triggers enabled"
        fi
    else
        log_error "Triggers not found"
        components_disabled=$((components_disabled + 1))
    fi

    if [ $components_disabled -eq 0 ]; then
        log_success "All Phase 2 components enabled"
        return 0
    else
        log_error "$components_disabled Phase 2 components still disabled"
        return 2
    fi
}

#==============================================================================
# Main Rollback Functions
#==============================================================================

rollback_full() {
    log_info "Performing FULL rollback of Phase 2..."

    # Create backup
    if [ "$CREATE_BACKUP" = true ]; then
        create_backup
        if [ $? -ne 0 ]; then
            log_error "Backup creation failed"
            return 4
        fi
    fi

    # Disable all agents
    disable_agent "debug-agent"
    disable_agent "consistency-agent"
    disable_agent "quality-agent"

    # Disable all hooks
    disable_hook "pre-implementation.yml"
    disable_hook "post-error.yml"
    disable_hook "post-implementation.yml"

    # Disable triggers
    disable_triggers

    # Disable rules
    disable_rules

    log_success "Full rollback completed"
}

rollback_agent() {
    local agent="$1"

    log_info "Performing PARTIAL rollback (agent: $agent)..."

    # Create backup
    if [ "$CREATE_BACKUP" = true ]; then
        create_backup
        if [ $? -ne 0 ]; then
            log_error "Backup creation failed"
            return 4
        fi
    fi

    # Disable specific agent
    disable_agent "$agent"

    # Disable related hooks
    case "$agent" in
        debug-agent)
            disable_hook "post-error.yml"
            ;;
        consistency-agent)
            disable_hook "pre-implementation.yml"
            ;;
        quality-agent)
            disable_hook "post-implementation.yml"
            ;;
    esac

    log_success "Partial rollback completed (agent: $agent)"
}

enable_phase2() {
    log_info "Re-enabling Phase 2 components..."

    # Enable all agents
    enable_agent "debug-agent"
    enable_agent "consistency-agent"
    enable_agent "quality-agent"

    # Enable all hooks
    enable_hook "pre-implementation.yml"
    enable_hook "post-error.yml"
    enable_hook "post-implementation.yml"

    # Enable triggers
    enable_triggers

    # Enable rules
    enable_rules

    log_success "Phase 2 re-enabled"
}

restore_from_backup() {
    local timestamp="$1"
    local backup_path="$BACKUP_DIR/phase2-$timestamp"
    local backup_archive="$BACKUP_DIR/phase2-$timestamp.tar.gz"

    log_info "Restoring from backup: $timestamp..."

    # Check if directory backup exists
    if [ -d "$backup_path" ]; then
        log_info "Restoring from directory backup..."

        # Restore agents
        if [ -d "$backup_path/debug-agent" ]; then
            cp -r "$backup_path/debug-agent" "$CLAUDE_DIR/agents/"
            log_success "Restored debug-agent"
        fi
        if [ -d "$backup_path/consistency-agent" ]; then
            cp -r "$backup_path/consistency-agent" "$CLAUDE_DIR/agents/"
            log_success "Restored consistency-agent"
        fi
        if [ -d "$backup_path/quality-agent" ]; then
            cp -r "$backup_path/quality-agent" "$CLAUDE_DIR/agents/"
            log_success "Restored quality-agent"
        fi

        # Restore hooks
        if [ -d "$backup_path/hooks" ]; then
            cp "$backup_path/hooks"/* "$CLAUDE_DIR/hooks/" 2>/dev/null || true
            log_success "Restored hooks"
        fi

        # Restore config
        if [ -d "$backup_path/config" ]; then
            cp "$backup_path/config"/* "$CLAUDE_DIR/config/" 2>/dev/null || true
            log_success "Restored triggers"
        fi

        # Restore rules
        if [ -d "$backup_path/rules" ]; then
            cp "$backup_path/rules"/* "$CLAUDE_DIR/rules/" 2>/dev/null || true
            log_success "Restored rules"
        fi

        log_success "Restore completed from directory backup"
        return 0

    # Check if archive backup exists
    elif [ -f "$backup_archive" ]; then
        log_info "Restoring from archive backup..."

        cd "$BACKUP_DIR"
        tar -xzf "phase2-$timestamp.tar.gz"

        if [ $? -eq 0 ]; then
            # Recursive call to restore from extracted directory
            restore_from_backup "$timestamp"
            return $?
        else
            log_error "Failed to extract backup archive"
            return 1
        fi

    else
        log_error "Backup not found: $timestamp"
        log_error "Checked: $backup_path"
        log_error "Checked: $backup_archive"
        return 1
    fi
}

#==============================================================================
# Usage and Help
#==============================================================================

show_usage() {
    cat << EOF
Phase 2 Rollback Script v1.0.0

USAGE:
    $0 [OPTIONS]

OPTIONS:
    --full                  Full rollback (disable all Phase 2 components)
    --agent <name>          Disable specific agent (debug-agent, consistency-agent, quality-agent)
    --emergency             Emergency rollback (skip backup, fastest)
    --temporary             Temporary disable (easy re-enable)
    --permanent             Permanent removal (creates backup archive)
    --enable                Re-enable Phase 2 components
    --restore <timestamp>   Restore from backup
    --verify                Verify Phase 2 is disabled
    --verify-enabled        Verify Phase 2 is enabled
    --dry-run               Show what would happen without making changes
    --help                  Show this help message

EXAMPLES:
    # Full rollback with backup
    $0 --full

    # Emergency rollback (no backup, fastest)
    $0 --emergency

    # Disable specific agent
    $0 --agent debug-agent

    # Temporary disable (easy re-enable)
    $0 --temporary

    # Re-enable after temporary disable
    $0 --enable

    # Restore from backup
    $0 --restore 20251119_143022

    # Verify Phase 2 is disabled
    $0 --verify

EXIT CODES:
    0 - Success
    1 - General error
    2 - Phase 2 not found or already disabled
    3 - Phase 1 integrity check failed
    4 - Backup creation failed
    5 - Insufficient permissions

EOF
}

#==============================================================================
# Argument Parsing
#==============================================================================

parse_arguments() {
    if [ $# -eq 0 ]; then
        show_usage
        exit 0
    fi

    while [ $# -gt 0 ]; do
        case "$1" in
            --full)
                FULL_ROLLBACK=true
                ;;
            --agent)
                shift
                SPECIFIC_AGENT="$1"
                ;;
            --emergency)
                EMERGENCY=true
                CREATE_BACKUP=false
                FULL_ROLLBACK=true
                ;;
            --temporary)
                TEMPORARY=true
                FULL_ROLLBACK=true
                ;;
            --permanent)
                PERMANENT=true
                FULL_ROLLBACK=true
                ;;
            --enable)
                ENABLE=true
                ;;
            --restore)
                shift
                RESTORE_TIMESTAMP="$1"
                ;;
            --verify)
                VERIFY_ONLY=true
                ;;
            --verify-enabled)
                VERIFY_ENABLED=true
                ;;
            --dry-run)
                DRY_RUN=true
                ;;
            --help)
                show_usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
        shift
    done
}

#==============================================================================
# Main Execution
#==============================================================================

main() {
    # Parse arguments
    parse_arguments "$@"

    # Initialize logging
    init_log_dir

    # Print banner
    echo "=================================="
    echo "Phase 2 Rollback Script v1.0.0"
    echo "=================================="
    echo ""

    # Check permissions
    if [ ! -w "$CLAUDE_DIR" ]; then
        log_error "Insufficient permissions to modify .claude directory"
        exit 5
    fi

    # Dry run notice
    if [ "$DRY_RUN" = true ]; then
        log_info "DRY RUN MODE - No changes will be made"
        echo ""
    fi

    # Execute requested operation
    local exit_code=0

    if [ "$VERIFY_ONLY" = true ]; then
        verify_phase2_disabled
        exit_code=$?
        verify_phase1_intact
        local phase1_code=$?
        if [ $phase1_code -ne 0 ]; then
            exit_code=$phase1_code
        fi

    elif [ "$VERIFY_ENABLED" = true ]; then
        verify_phase2_enabled
        exit_code=$?

    elif [ "$ENABLE" = true ]; then
        enable_phase2
        exit_code=$?
        if [ $exit_code -eq 0 ]; then
            verify_phase2_enabled
            exit_code=$?
        fi

    elif [ -n "$RESTORE_TIMESTAMP" ]; then
        restore_from_backup "$RESTORE_TIMESTAMP"
        exit_code=$?
        if [ $exit_code -eq 0 ]; then
            verify_phase2_enabled
            exit_code=$?
        fi

    elif [ -n "$SPECIFIC_AGENT" ]; then
        rollback_agent "$SPECIFIC_AGENT"
        exit_code=$?
        if [ $exit_code -eq 0 ]; then
            verify_phase1_intact
            exit_code=$?
        fi

    elif [ "$FULL_ROLLBACK" = true ]; then
        rollback_full
        exit_code=$?
        if [ $exit_code -eq 0 ]; then
            verify_phase2_disabled
            local verify_code=$?
            verify_phase1_intact
            local phase1_code=$?
            if [ $verify_code -ne 0 ]; then
                exit_code=$verify_code
            elif [ $phase1_code -ne 0 ]; then
                exit_code=$phase1_code
            fi
        fi

    else
        log_error "No operation specified"
        show_usage
        exit 1
    fi

    # Summary
    echo ""
    echo "=================================="
    if [ $exit_code -eq 0 ]; then
        log_success "Operation completed successfully"
    else
        log_error "Operation completed with errors (exit code: $exit_code)"
    fi
    echo "Log file: $LOG_FILE"
    echo "=================================="

    exit $exit_code
}

# Run main function
main "$@"
