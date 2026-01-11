#/bin/sh

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <iterations>"
  exit 1
fi

for ((i = 1; i <= $1; i++)); do
  echo "----------------------------------------"
  echo "Iteration $i: Running Ralph plan..."

  ralph plan run --plan ralph_plan.yaml
  results=$(opencode --prompt "@plans/prd.json @progress.txt \
1. Find the highest priority feature in prd.json to work on and only work on that feature. \
This should be the one that YOU decide has the highest priority. not necessarily the first that you encounter. \
2. Check that all the tests are passing. \
3. Update the PRD file with the work that was done. \
4. Append your progress to progress.txt. \
Use this to make a note for the next person working on this codebase. \
5. Make a git commit of that feature. \
ONLY WORK ON ONE SINGLE FEATURE AT A TIME. \
if, while working on that feature, you notice that the PRD is complete, output <promise>COMPLETE</promise>. \
    ")

  echo "$results"
  echo "Iteration $i: Completed."

  if [[ results == *"<promise>COMPLETE</promise>"* ]]; then
    echo "Ralph plan indicates that the PRD is complete. Exiting loop."
    exit 0
  fi

done
