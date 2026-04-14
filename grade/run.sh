#!/bin/bash
# Grading script for 01_checklist assignment
# Checks that all checkbox items in README.md are marked [x]

set -euo pipefail

README="README.md"
PASS=true

if [ ! -f "$README" ]; then
  echo "FAIL: README.md が見つかりません"
  exit 1
fi

# Find unchecked items (lines matching "- [ ]")
unchecked=$(grep -n '^\s*- \[ \]' "$README" || true)

if [ -n "$unchecked" ]; then
  echo "FAIL: 未チェックの項目があります:"
  echo "$unchecked"
  exit 1
fi

# Verify at least one checked item exists (guard against empty/broken README)
checked_count=$(grep -c '^\s*- \[x\]' "$README" || true)

if [ "$checked_count" -eq 0 ]; then
  echo "FAIL: チェック済み項目が1つも見つかりません。README.md が正しく編集されていない可能性があります"
  exit 1
fi

echo "PASS: すべての項目がチェックされています (${checked_count}項目)"
exit 0
