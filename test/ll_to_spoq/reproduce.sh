#!/bin/bash
# Interesting = spoq still reports the unlminated-phi failure for TIFFFillStrip.
set -u

# The log lives OUTSIDE the scratch dir: $W is deleted on exit, so a log kept
# inside it would be gone by the time the reported path was read.  It is left
# behind deliberately -- these accumulate under /tmp/tifred when the script is
# driven by llvm-reduce, so clear them out after a reduction run.
W=$(mktemp -d /tmp/tifred/cand-XXXXXX)
LOG=$(mktemp /tmp/tifred/reproduce-XXXXXX.log)
trap 'rm -rf "$W"' EXIT
echo "reproduce.sh: log -> $LOG" >&2

cp /tmp/tifred/fill.main.v "$W"/ || exit 1
/home/rjs2247/workspace/llvm-project/build/bin/llvm-as "$1" -o "$W/fill.bc" 2>/dev/null || exit 1
cd "$W" || exit 1
timeout 120 /home/rjs2247/workspace/spoq3/build/spoq fill.main.v --new-trans --llvm --no-profile \
    --check-pre-post --query-path "$W/z3/" >/dev/null 2>"$LOG"

# Capture the verdict before anything else can clobber $?, so the exit status
# this oracle reports stays exactly what it was.
if grep -q "some PHI are not eliminated" "$LOG" &&
   grep -q "\[CFG\] TIFFFillStrip not converted" "$LOG"; then
    rc=0
else
    rc=1
fi
exit "$rc"
