#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

if [ -z "$1" ]; then
  echo "Usage: $0 <iterations>"
  exit 1
fi

if [ ! -f "plans/prd.json" ]; then
  echo "Error: plans/prd.json not found"
  exit 1
fi

if [ ! -f "plans/progress.txt" ]; then
  echo "Error: progress.txt not found"
  exit 1
fi

PROMPT=$(
  cat <<'EOF'
1. Find the highest priority feature in prd.json to work on and only work on that feature. This should be the one that YOU decide has the highest priority, not necessarily the first that you see.
2. Check any feedback loops, such as types and tests.
3. Update the PRD file with the work that was done.
4. Append your progress to progress.txt. Use this to make a note for the next person working on this codebase.
5. Make a git commit of that feature.
ONLY WORK ON ONE SINGLE FEATURE AT A TIME. If, while working on that feature, you notice that the PRD is complete, output <promise>COMPLETE</promise>.
EOF
)

echo "--- Option 1 ---"
for ((i = 1; i <= $1; i++)); do
  printf "%b\n" "${YELLOW}--------------------------------------------------------------------------------${RESET}"
  echo "Iteration $i: Running Ralph plan..."

  results=$(opencode -m "zai-coding-plan/glm-4.7" run "@plans/prd.json @plans/progress.txt $PROMPT")

  # echo "$results"
  echo "Iteration $i: Completed."
  echo ""

  if [[ "$results" == *"<promise>COMPLETE</promise>"* ]]; then
    # echo ">> Ralph plan indicates that the PRD is complete. Exiting loop."
    printf "%b\n" "${BOLD}${GREEN}>> Ralph plan indicates that the PRD is complete. Exiting loop.${RESET}"
    echo ""
    exit 0
  fi

done
exit 0

echo "--- Option 2 ---"
for ((i = 1; i <= $1; i++)); do
  printf "%b\n" "${YELLOW}--------------------------------------------------------------------------------${RESET}"
  echo "Iteration $i: Running Ralph plan..."

  max_retries=3
  retry_delay=5
  retry_count=0

  while [ $retry_count -lt $max_retries ]; do
    if [ $retry_count -eq 0 ]; then
      results=$(opencode -m "zai-coding-plan/glm-4.7" run "@plans/prd.json @plans/progress.txt $PROMPT" 2>&1) || true
    else
      results=$(opencode --continue 2>&1) || true
    fi

    if [[ "$results" != *"<error>"* ]] || [ $retry_count -eq $max_retries ]; then
      break
    fi

    retry_count=$((retry_count + 1))
    # echo "Command failed (attempt $retry_count/$max_retries). Retrying in ${retry_delay}s..."
    printf "%b\n" "${BOLD}${RED}>> Command failed (attempt $retry_count/$max_retries). Retrying in ${retry_delay}s... .${RESET}"
    sleep $retry_delay
  done

  # echo "$results"
  echo "Iteration $i: Completed."

  if [[ "$results" == *"<promise>COMPLETE</promise>"* ]]; then
    printf "%b\n" "${BOLD}${GREEN}>> Ralph plan indicates that the PRD is complete. Exiting loop.${RESET}"
    exit 0
  fi

done
