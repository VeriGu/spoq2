current_path=$(pwd)

if [ ! -e "$1" ]; then
    echo "Argument is missing or incorrect."
    echo "Usage: ./get-ir.sh /path/to/container"
    exit 0
fi

container_dir="$(realpath "$1")" # container_dir is the dir for the container project
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "The container root:" $container_dir 

if [ -e "$container_dir/build/rmm.linked.bc" ]; then
    echo "BC file exists. Skip building the container."
else
    echo "Cannot find BC file. Build the container."
    "$root_dir/build-container.sh" $1
fi

# Convert BC file to IR file
llvm-dis-14 "$container_dir/build/rmm.linked.bc" -o "$container_dir/verification/rmm.linked.ll"

# Run preprocessing passes
"$root_dir/opt.sh" "$container_dir/verification/rmm.linked.ll" "$container_dir/verification/rmm-opt.linked.ll"

echo "IR file generated:" "$container_dir/verification/rmm-opt.linked.ll"

# Convert IR file to JSON file
if [ ! -e "$root_dir/../IR2Json/ir2json" ]; then
    echo "IR2Json is missing. Stop."
    exit 0
else 
    "$root_dir/../IR2Json/ir2json" "$container_dir/verification/rmm-opt.linked.ll" >  \
      "$container_dir/verification/rmm-opt.linked.ir2json.json"
    echo "IR2Json found. IR Json file generated:" "$container_dir/verification/rmm-opt.linked.ir2json.json"
fi

cd $current_path
