root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Which LLVM 23 to use.  Defaults to the local source build; override LLVM_ROOT
# (a prefix or build tree) or OPT directly.  Falls back to opt-23 on PATH.
LLVM_ROOT="${LLVM_ROOT:-$HOME/workspace/llvm-project/build}"
OPT="${OPT:-$LLVM_ROOT/bin/opt}"
command -v "$OPT" >/dev/null 2>&1 || OPT=opt-23

# Usage: rename_with_suffix.sh <input.ll> <renamed-output.ll> [> changes.json]
#
# The renamed IR goes to $2 through opt's -o, which leaves stdout carrying only
# the pass's rename report -- one line of JSON.  Diagnostics stay on stderr:
# opt's own "warning: ignoring invalid debug info" and the pass's "No renaming
# plan entry for ..." notices.  So redirect stdout, not stderr, to capture the
# report; `2>changes.json` would collect the warnings instead.
"$OPT" \
  -S \
  -o "$2" \
  --load-pass-plugin="$root_dir/rename/lib/librenamepass.so" \
  -passes=renamepass \
  "$1"
