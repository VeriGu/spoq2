#!/bin/bash
# Interesting = spoq still reports the unlminated-phi failure for TIFFFillStrip.
set -u
W=$(mktemp -d /tmp/tifred/cand-XXXXXX)
trap 'rm -rf "$W"' EXIT
cp /tmp/tifred/fill.main.v "$W"/ || exit 1
/home/rjs2247/workspace/llvm-project/build/bin/llvm-as "$1" -o "$W/fill.bc" 2>/dev/null || exit 1
cd "$W" || exit 1
timeout 120 /home/rjs2247/workspace/spoq3/build/spoq fill.main.v --new-trans --llvm --no-profile \
    --check-pre-post --query-path "$W/z3/" >/dev/null 2>"$W/err.log"
grep -q "some PHI are not eliminated" "$W/err.log" && \
grep -q "\[CFG\] TIFFFillStrip not converted" "$W/err.log"
