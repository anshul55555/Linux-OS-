#!/bin/bash

# Configuration Variables
LOG_FILE="auth_security.log"
CLEANED_LOG="cleaned_security.log"
THRESHOLD=3

# Validate Log File Existence
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

echo "=== SSH SECURITY LOG ANALYSIS ==="
echo

# Normalize whitespace
sed 's/[[:space:]]\+/ /g' "$LOG_FILE" > "$CLEANED_LOG"

# Count totals
FAILED=$(grep -c "Failed password" "$CLEANED_LOG")
SUCCESS=$(grep -c "Accepted password" "$CLEANED_LOG")

echo "Total failed login attempts: $FAILED"
echo "Total successful login attempts: $SUCCESS"
echo

echo "Failed login attempts grouped by IP address:"
grep "Failed password" "$CLEANED_LOG" | \
    awk '{for(i=1;i<=NF;i++) if($i=="from") {print $(i+1); break}}' | \
    sort | uniq -c
echo

echo "Suspicious IP addresses (Exceeding threshold of $THRESHOLD failures):"
grep "Failed password" "$CLEANED_LOG" | \
    awk '{for(i=1;i<=NF;i++) if($i=="from") {print $(i+1); break}}' | \
    sort | uniq -c | \
    awk -v limit="$THRESHOLD" '$1 >= limit {print $2, "-", $1, "failed attempts"}'

echo
echo "=== ANALYSIS COMPLETE ==="
