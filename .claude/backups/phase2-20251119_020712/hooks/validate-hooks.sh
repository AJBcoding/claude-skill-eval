#!/bin/bash
# Validation script for integration hooks
# Checks hook configurations for common issues

set -e

HOOKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_DIR="$(dirname "$HOOKS_DIR")/agents"

echo "🔍 Validating Integration Hooks..."
echo "=================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0
warnings=0
checks=0

# Function to print check result
check_pass() {
    checks=$((checks + 1))
    echo -e "${GREEN}✓${NC} $1"
}

check_warn() {
    checks=$((checks + 1))
    warnings=$((warnings + 1))
    echo -e "${YELLOW}⚠${NC} $1"
}

check_fail() {
    checks=$((checks + 1))
    errors=$((errors + 1))
    echo -e "${RED}✗${NC} $1"
}

echo "1. Checking Hook Files"
echo "----------------------"

# Check if hook files exist
for hook in pre-implementation post-error post-implementation; do
    if [ -f "$HOOKS_DIR/${hook}.yml" ]; then
        check_pass "Hook file exists: ${hook}.yml"
    else
        check_fail "Hook file missing: ${hook}.yml"
    fi
done

echo

# Check if README exists
echo "2. Checking Documentation"
echo "-------------------------"

if [ -f "$HOOKS_DIR/README.md" ]; then
    check_pass "README.md exists"
    lines=$(wc -l < "$HOOKS_DIR/README.md")
    if [ "$lines" -gt 100 ]; then
        check_pass "README.md is comprehensive ($lines lines)"
    else
        check_warn "README.md might be incomplete ($lines lines)"
    fi
else
    check_fail "README.md missing"
fi

if [ -f "$HOOKS_DIR/QUICKREF.md" ]; then
    check_pass "QUICKREF.md exists"
else
    check_warn "QUICKREF.md missing (optional)"
fi

echo

# Check YAML syntax (basic check)
echo "3. Checking YAML Syntax"
echo "-----------------------"

for hook_file in "$HOOKS_DIR"/*.yml; do
    if [ -f "$hook_file" ]; then
        filename=$(basename "$hook_file")

        # Check for basic YAML structure
        if grep -q "^name:" "$hook_file" && \
           grep -q "^version:" "$hook_file" && \
           grep -q "^enabled:" "$hook_file"; then
            check_pass "$filename has required fields"
        else
            check_fail "$filename missing required fields (name, version, enabled)"
        fi

        # Check if enabled
        if grep -q "^enabled: true" "$hook_file"; then
            check_pass "$filename is enabled"
        else
            check_warn "$filename is disabled"
        fi
    fi
done

echo

# Check agent references
echo "4. Checking Agent References"
echo "-----------------------------"

# Map hooks to expected agents
declare -A hook_agents=(
    ["pre-implementation.yml"]="consistency-agent"
    ["post-error.yml"]="debug-agent"
    ["post-implementation.yml"]="quality-agent"
)

for hook_file in "${!hook_agents[@]}"; do
    expected_agent="${hook_agents[$hook_file]}"

    if [ -f "$HOOKS_DIR/$hook_file" ]; then
        if grep -q "agent: $expected_agent" "$HOOKS_DIR/$hook_file"; then
            check_pass "$hook_file references $expected_agent"

            # Check if agent exists
            if [ -d "$AGENTS_DIR/$expected_agent" ]; then
                check_pass "$expected_agent directory exists"

                if [ -f "$AGENTS_DIR/$expected_agent/agent.yml" ]; then
                    check_pass "$expected_agent/agent.yml exists"
                else
                    check_fail "$expected_agent/agent.yml missing"
                fi
            else
                check_fail "$expected_agent directory missing"
            fi
        else
            check_fail "$hook_file doesn't reference $expected_agent"
        fi
    fi
done

echo

# Check for common configuration issues
echo "5. Checking Configuration"
echo "-------------------------"

# Check pre-implementation hook
if [ -f "$HOOKS_DIR/pre-implementation.yml" ]; then
    if grep -q "before:Edit\|before:Write" "$HOOKS_DIR/pre-implementation.yml"; then
        check_pass "pre-implementation triggers before Edit/Write"
    else
        check_fail "pre-implementation missing before:Edit/Write triggers"
    fi

    if grep -q "consistency-agent" "$HOOKS_DIR/pre-implementation.yml"; then
        check_pass "pre-implementation uses consistency-agent"
    else
        check_fail "pre-implementation doesn't reference consistency-agent"
    fi
fi

# Check post-error hook
if [ -f "$HOOKS_DIR/post-error.yml" ]; then
    if grep -q "after:Bash:error\|after:test:failure" "$HOOKS_DIR/post-error.yml"; then
        check_pass "post-error triggers after errors"
    else
        check_fail "post-error missing error trigger events"
    fi

    if grep -q "debug-agent" "$HOOKS_DIR/post-error.yml"; then
        check_pass "post-error uses debug-agent"
    else
        check_fail "post-error doesn't reference debug-agent"
    fi

    # Check for 6-step methodology
    if grep -q "reproduce\|isolate\|hypothesis\|test\|fix\|verify" "$HOOKS_DIR/post-error.yml"; then
        check_pass "post-error includes 6-step methodology"
    else
        check_warn "post-error might be missing debug steps"
    fi
fi

# Check post-implementation hook
if [ -f "$HOOKS_DIR/post-implementation.yml" ]; then
    if grep -q "after:Edit\|after:Write" "$HOOKS_DIR/post-implementation.yml"; then
        check_pass "post-implementation triggers after Edit/Write"
    else
        check_fail "post-implementation missing after:Edit/Write triggers"
    fi

    if grep -q "quality-agent" "$HOOKS_DIR/post-implementation.yml"; then
        check_pass "post-implementation uses quality-agent"
    else
        check_fail "post-implementation doesn't reference quality-agent"
    fi

    # Check for quality categories
    categories=("test_coverage" "documentation" "error_handling" "performance" "security" "code_quality" "integration")
    found_categories=0
    for category in "${categories[@]}"; do
        if grep -q "$category" "$HOOKS_DIR/post-implementation.yml"; then
            found_categories=$((found_categories + 1))
        fi
    done

    if [ "$found_categories" -ge 5 ]; then
        check_pass "post-implementation has comprehensive quality checklist ($found_categories/7 categories)"
    else
        check_warn "post-implementation quality checklist might be incomplete ($found_categories/7 categories)"
    fi
fi

echo

# Check for bypass mechanisms
echo "6. Checking Bypass Mechanisms"
echo "------------------------------"

for hook_file in "$HOOKS_DIR"/*.yml; do
    if [ -f "$hook_file" ]; then
        filename=$(basename "$hook_file")

        if grep -q "bypass:" "$hook_file"; then
            check_pass "$filename has bypass mechanisms"
        else
            check_warn "$filename missing bypass mechanisms"
        fi
    fi
done

echo

# Check for performance settings
echo "7. Checking Performance Settings"
echo "---------------------------------"

for hook_file in "$HOOKS_DIR"/*.yml; do
    if [ -f "$hook_file" ]; then
        filename=$(basename "$hook_file")

        if grep -q "performance:\|max_execution_time:" "$hook_file"; then
            check_pass "$filename has performance settings"
        else
            check_warn "$filename missing performance settings"
        fi
    fi
done

echo

# Check for examples
echo "8. Checking Documentation Examples"
echo "-----------------------------------"

for hook_file in "$HOOKS_DIR"/*.yml; do
    if [ -f "$hook_file" ]; then
        filename=$(basename "$hook_file")

        if grep -q "examples:" "$hook_file"; then
            check_pass "$filename includes usage examples"
        else
            check_warn "$filename missing usage examples"
        fi
    fi
done

echo

# Summary
echo "=========================================="
echo "Validation Summary"
echo "=========================================="
echo "Total checks: $checks"
echo -e "${GREEN}Passed: $((checks - warnings - errors))${NC}"
echo -e "${YELLOW}Warnings: $warnings${NC}"
echo -e "${RED}Errors: $errors${NC}"
echo

if [ $errors -eq 0 ]; then
    if [ $warnings -eq 0 ]; then
        echo -e "${GREEN}✅ All validations passed! Hooks are properly configured.${NC}"
        exit 0
    else
        echo -e "${YELLOW}⚠️  Validations passed with warnings. Review warnings above.${NC}"
        exit 0
    fi
else
    echo -e "${RED}❌ Validation failed with $errors error(s). Fix errors before using hooks.${NC}"
    exit 1
fi
