
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Which LLVM 23 to use.  Defaults to the local source build; override LLVM_ROOT
# (a prefix or build tree) or OPT directly.  Falls back to opt-23 on PATH.
LLVM_ROOT="${LLVM_ROOT:-$HOME/workspace/llvm-project/build}"
OPT="${OPT:-$LLVM_ROOT/bin/opt}"
command -v "$OPT" >/dev/null 2>&1 || OPT=opt-23

# LLVM 17 dropped the legacy pass manager from opt, so the passes are loaded as
# New PM plugins and named in -passes instead of as -<passname> flags.
"$OPT" \
  --load-pass-plugin="$root_dir/extractpointers/lib/libextractpointers.so" \
  --load-pass-plugin="$root_dir/extractbasics/lib/libextractbasics.so" \
  -passes='extractbasics,extractpointers' \
  -disable-output \
  $1
