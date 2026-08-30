
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Which LLVM 23 to use.  Defaults to the local source build; override LLVM_ROOT
# (a prefix or build tree) or OPT directly.  Falls back to opt-23 on PATH.
LLVM_ROOT="${LLVM_ROOT:-$HOME/workspace/llvm-project/build}"
OPT="${OPT:-$LLVM_ROOT/bin/opt}"
command -v "$OPT" >/dev/null 2>&1 || OPT=opt-23

# The pass writes its rename report to stderr and the renamed IR to stdout, so
# keep the IR on stdout for callers that redirect the two separately.
"$OPT" \
  -S \
  --load-pass-plugin="$root_dir/rename/lib/librenamepass.so" \
  -passes=renamepass \
  $1 > $2
