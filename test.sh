#!/bin/bash

set -o pipefail

# Color codes (disabled if not a tty)
C_GREEN='\033[0;32m'
C_RED='\033[0;31m'
C_RESET='\033[0m'

if [[ ! -t 1 ]]; then
    C_GREEN=''
    C_RED=''
    C_RESET=''
fi

# ─────────────────────────────────────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────────────────────────────────────

hr() {
    echo "────────────────────────────────────────────"
}

banner() {
    echo "════════════════════════════════════════════"
    echo "  f02 — Version Control  /  test.sh"
    echo "════════════════════════════════════════════"
}

pass() {
    local label="$1"
    echo -e "${C_GREEN}PASS${C_RESET}  $label"
    PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
    local label="$1"
    local reason="$2"
    echo -e "${C_RED}FAIL${C_RESET}  $label"
    echo "      $reason"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

celebrate() {
    echo ""
    echo "════════════════════════════════════════════"
    echo ""
    echo "Perfect Dark. One contributor."
    echo "6,779 commits. No original source."
    echo ""
    echo "You now have the tool he used."
    echo ""
    echo "════════════════════════════════════════════"
}

# ─────────────────────────────────────────────────────────────────────────────
# Pre-flight
# ─────────────────────────────────────────────────────────────────────────────

if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: not inside a git repository."
    echo "Copy this script into your f02-practice directory and run it from there:"
    echo ""
    echo "  cp test.sh ~/f02-practice/"
    echo "  cd ~/f02-practice"
    echo "  bash test.sh"
    exit 1
fi

# ─────────────────────────────────────────────────────────────────────────────
# Checks
# ─────────────────────────────────────────────────────────────────────────────

PASS_COUNT=0
FAIL_COUNT=0

check_commits() {
    if ! git rev-parse main >/dev/null 2>&1; then
        fail "At least five commits on main" "Branch 'main' not found"
        return
    fi
    local count
    count=$(git log main --oneline 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$count" -ge 5 ]]; then
        pass "At least five commits on main ($count found)"
    else
        fail "At least five commits on main" "$count found — make at least 5 commits on the main branch"
    fi
}

check_merge_commit() {
    local count
    count=$(git log --merges --oneline 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$count" -ge 1 ]]; then
        pass "Merge commit present ($count found)"
    else
        fail "Merge commit present" "No merge commits — create a branch, commit on it, and merge back into main"
    fi
}

check_no_conflict_markers() {
    local conflicted
    conflicted=$(git ls-files -z | xargs -0 grep -lE '^<<<<<<< |^>>>>>>> ' 2>/dev/null || true)
    if [[ -z "$conflicted" ]]; then
        pass "No unresolved conflict markers in tracked files"
    else
        fail "No unresolved conflict markers" "Markers found in: $conflicted"
    fi
}

check_origin_remote() {
    if git remote | grep -q '^origin$'; then
        local url
        url=$(git remote get-url origin 2>/dev/null)
        pass "Remote 'origin' configured ($url)"
    else
        fail "Remote 'origin' configured" "No remote named 'origin' — add one with: git remote add origin <url>"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────────────────────────────────────

if [[ "$1" = "--help" || "$1" = "-h" ]]; then
    cat <<'HELP'
Usage: bash test.sh [OPTION]

  (no arguments)    Run all checks against the current repository.
  --help, -h        Show this message.

── Setup ────────────────────────────────────────────────────────────────────

Copy this script into your f02-practice repository and run it from there:

  cp test.sh ~/f02-practice/
  cd ~/f02-practice
  bash test.sh

── What the tester checks ───────────────────────────────────────────────────

  1. At least five commits exist on the main branch.
  2. A branch was created and merged back — a merge commit is present.
  3. No unresolved conflict markers (<<<<<<<, >>>>>>>) in any tracked file.
  4. A remote named 'origin' is configured.

The perfect-dark clone step is self-certified. The tester cannot verify
what you saw when you read someone else's repository history.
HELP
    exit 0
fi

if [[ -n "$1" ]]; then
    echo "Unknown option: $1"
    echo "Run bash test.sh --help for usage."
    exit 1
fi

banner
echo ""

check_commits
check_merge_commit
check_no_conflict_markers
check_origin_remote

echo ""
hr
TOTAL=$((PASS_COUNT + FAIL_COUNT))
echo "  $PASS_COUNT / $TOTAL checks passed"

if [[ "$FAIL_COUNT" -eq 0 ]]; then
    celebrate
    exit 0
else
    echo ""
    echo "Fix the failing checks and rerun."
    exit 1
fi
