
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

opt-14 -enable-new-pm=0 -O0 \
  -S \
  -load "$root_dir/rename/lib/librenamepass.so" \
  --renamepass \
  $1 > $2
