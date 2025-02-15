current_path=$(pwd)

# get the source directory of this file
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

O1_passes="-verify -lower-expect -simplifycfg -sroa -early-cse -annotation2metadata -forceattrs -inferattrs -ipsccp -called-value-propagation -globalopt -mem2reg -instcombine -always-inline -function-attrs -libcalls-shrinkwrap -pgo-memop-opt -reassociate -loop-simplify -lcssa -licm -loop-rotate -loop-idiom -indvars -loop-deletion -loop-unroll -sccp -bdce -adce -memcpyopt -rpo-function-attrs -globaldce -float2int -lower-constant-intrinsics -loop-distribute -inject-tli-mappings -loop-vectorize -loop-load-elim -vector-combine -transform-warning -alignment-from-assumptions -strip-dead-prototypes -cg-profile -loop-sink -instsimplify -div-rem-pairs -annotation-remarks"

opt-14 -enable-new-pm=0 -O0 \
  -load "$root_dir/remove_opt_none/lib/libremove_opt_none.so" \
  -load "$root_dir/cleaner/lib/libcleaner.so" \
  -load "$root_dir/my_mergefunc/lib/libMyMergeFunc.so" \
  --cleaner \
  --rm_opt_none \
  --mymergefunc \
  ${O1_passes} \
  --mymergefunc \
  -S \
  -o $2 \
  $1