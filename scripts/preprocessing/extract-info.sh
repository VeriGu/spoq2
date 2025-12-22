
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

opt-14 -enable-new-pm=0 \
  -load "$root_dir/extractpointers/lib/libextractpointers.so" \
  -load "$root_dir/extractbasics/lib/libextractbasics.so" \
  --extractbasics \
  --extractpointers \
  $1 > /dev/null
