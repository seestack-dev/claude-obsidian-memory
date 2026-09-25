#!/bin/bash
# daily-journal.sh — creates today's journal and maintains the day → month → year hierarchy
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VAULT="$(cd "$SCRIPT_DIR/../.." && pwd)"
JOURNAL="$VAULT/Journal"
TEMPLATE="$VAULT/Templates/Daily.md"

YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
TIME=$(date +%H:%M)

YEAR_NOTE="$JOURNAL/$YEAR.md"
MONTH_NOTE="$JOURNAL/$YEAR/$MONTH.md"
DAY_NOTE="$JOURNAL/$YEAR/$MONTH/$DAY.md"

# --- 1. year-note ---
if [ ! -f "$YEAR_NOTE" ]; then
  mkdir -p "$JOURNAL"
  printf '# %s\n\n## Months\n' "$YEAR" > "$YEAR_NOTE"
fi
grep -qF "[[Journal/$YEAR/$MONTH|$MONTH]]" "$YEAR_NOTE" || printf -- '- [[Journal/%s/%s|%s]]\n' "$YEAR" "$MONTH" "$MONTH" >> "$YEAR_NOTE"

# --- 2. month-note ---
if [ ! -f "$MONTH_NOTE" ]; then
  mkdir -p "$JOURNAL/$YEAR"
  printf '# %s · %s\n\n## Up\n- [[Journal/%s|%s]]\n\n## Days\n' "$MONTH" "$YEAR" "$YEAR" "$YEAR" > "$MONTH_NOTE"
fi
grep -qF "[[Journal/$YEAR/$MONTH/$DAY|$DAY]]" "$MONTH_NOTE" || printf -- '- [[Journal/%s/%s/%s|%s]]\n' "$YEAR" "$MONTH" "$DAY" "$DAY" >> "$MONTH_NOTE"

# --- 3. day-note ---
if [ ! -f "$DAY_NOTE" ]; then
  mkdir -p "$JOURNAL/$YEAR/$MONTH"
  if [ -f "$TEMPLATE" ]; then
    # apply template, replacing date/time variables
    sed -e "s|{{date:YYYY}}|$YEAR|g" \
        -e "s|{{date:MM}}|$MONTH|g" \
        -e "s|{{date:DD}}|$DAY|g" \
        -e "s|{{date}}|$YEAR-$MONTH-$DAY|g" \
        -e "s|{{time}}|$TIME|g" \
        "$TEMPLATE" > "$DAY_NOTE"
  else
    printf '# %s-%s-%s\n\n## Up\n- [[Journal/%s/%s|%s]]\n' "$YEAR" "$MONTH" "$DAY" "$YEAR" "$MONTH" "$MONTH" > "$DAY_NOTE"
  fi
fi

echo "done: $DAY_NOTE"
