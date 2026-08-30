current_path=$(pwd)

# get the source directory of this file
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Which LLVM 23 to use.  Defaults to the local source build; override LLVM_ROOT
# (a prefix or build tree) or OPT directly.  Falls back to opt-23 on PATH.
LLVM_ROOT="${LLVM_ROOT:-$HOME/workspace/llvm-project/build}"
OPT="${OPT:-$LLVM_ROOT/bin/opt}"
command -v "$OPT" >/dev/null 2>&1 || OPT=opt-23

# The same -O1-ish pass list as before, written for the New PM: opt's pipeline
# parser wraps each name in the adaptor its level needs, so the legacy
# -<passname> flags map one-to-one onto comma-separated -passes entries.
O1_passes="verify,lower-expect,simplifycfg,sroa,early-cse,annotation2metadata,forceattrs,inferattrs,ipsccp,called-value-propagation,globalopt,mem2reg,instcombine,always-inline,function-attrs,libcalls-shrinkwrap,pgo-memop-opt,reassociate,loop-simplify,lcssa,licm,loop-rotate,loop-idiom,indvars,loop-deletion,loop-unroll,sccp,bdce,adce,memcpyopt,rpo-function-attrs,globaldce,float2int,lower-constant-intrinsics,loop-distribute,inject-tli-mappings,loop-vectorize,loop-load-elim,vector-combine,transform-warning,alignment-from-assumptions,strip-dead-prototypes,cg-profile,loop-sink,instsimplify,div-rem-pairs,annotation-remarks"

# LLVM 17 dropped the legacy pass manager from opt, so the local passes are
# loaded as New PM plugins and named in -passes rather than as their own flags.
"$OPT" \
  --load-pass-plugin="$root_dir/remove_opt_none/lib/libremove_opt_none.so" \
  --load-pass-plugin="$root_dir/cleaner/lib/libcleaner.so" \
  --load-pass-plugin="$root_dir/my_mergefunc/lib/libMyMergeFunc.so" \
  -passes="cleaner,rm_opt_none,mymergefunc,${O1_passes},mymergefunc" \
  -S \
  -o $2 \
  $1
