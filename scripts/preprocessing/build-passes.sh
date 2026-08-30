#!/bin/bash
# Build the preprocessing pass plugins.
#
# Usage: ./build-passes.sh [<llvm-dir>]   (default: $LLVM_ROOT, else the local
#                                          LLVM 23 build at ~/workspace/llvm-project/build)
#
# The passes are New PM plugins; load them with
#   <llvm-dir>/bin/opt --load-pass-plugin=<dir>/lib/lib<pass>.so -passes=<pass> ...

set -u

llvm_dir="$(realpath "${1:-${LLVM_ROOT:-$HOME/workspace/llvm-project/build}}")"
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Not yet ported past LLVM 15 -- see the note in its CMakeLists.txt.
skip=( pv_ir_outliner )

if [ ! -d "$llvm_dir" ]; then
    echo "Error: The llvm directory $llvm_dir does not exist."
    exit 1
fi

failed=()
for subdir in "$root_dir"/*/; do
    [ -d "$subdir" ] || continue
    name="$(basename "$subdir")"
    [ -f "$subdir/CMakeLists.txt" ] || continue

    if [[ " ${skip[*]} " == *" $name "* ]]; then
        echo "Skipping $name (not ported to LLVM 23)"
        continue
    fi

    # Each pass's CMakeLists defaults LT_LLVM_INSTALL_DIR to ./llvm, so keep the
    # link in sync with whichever tree we were asked to build against.
    ln -sfn "$llvm_dir" "$subdir/llvm"

    ( cd "$subdir" \
        && cmake . -DLT_LLVM_INSTALL_DIR="$llvm_dir" \
        && make -j"$(nproc)" ) || failed+=("$name")
    echo "Pass make: $subdir"
done

if [ ${#failed[@]} -ne 0 ]; then
    echo "FAILED: ${failed[*]}"
    exit 1
fi
