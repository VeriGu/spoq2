current_path=$(pwd)

if [ ! -e "$1" ]; then
    echo "Argument is missing or incorrect."
    echo "Usage: ./get-ir.sh filename"
    exit 0
fi

root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

filename="$(realpath "$1")" # container_dir is the dir for the container project

echo "The single file name:" $filename

clang-14 -c -emit-llvm "$filename" -o "$filename.bc"

# Convert BC file to IR file
llvm-dis-14 "$filename.bc" -o "$filename.ll"

# Run preprocessing passes
"$root_dir/opt.sh" "$filename.ll" "$filename.ll"


llvm-as-14 "$filename.ll" -o "$filename.bc"


echo "IR file generated:" "$filename.ll"
echo "BC file generated:" "$filename.bc"

cd $current_path
