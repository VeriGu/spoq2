current_path=$(pwd)

if [ ! -e "$1" ]; then
    echo "Argument is missing or incorrect."
    echo "Usage: ./get-ir.sh filename"
    exit 0
fi

root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Which LLVM 23 to use.  Defaults to the local source build; override LLVM_ROOT.
LLVM_ROOT="${LLVM_ROOT:-$HOME/workspace/llvm-project/build}"
CLANG="${CLANG:-$LLVM_ROOT/bin/clang}";     command -v "$CLANG"    >/dev/null 2>&1 || CLANG=clang-23
LLVM_AS="${LLVM_AS:-$LLVM_ROOT/bin/llvm-as}";  command -v "$LLVM_AS"  >/dev/null 2>&1 || LLVM_AS=llvm-as-23
LLVM_DIS="${LLVM_DIS:-$LLVM_ROOT/bin/llvm-dis}"; command -v "$LLVM_DIS" >/dev/null 2>&1 || LLVM_DIS=llvm-dis-23


filename="$(realpath "$1")" # container_dir is the dir for the container project

echo "The single file name:" $filename

"$CLANG" -S -emit-llvm "$filename" -o "$filename.ll" -O0 -Wall -fno-builtin -ffunction-sections -fomit-frame-pointer -fno-common

# Convert BC file to IR file
# "$LLVM_DIS" "$filename.bc" -o "$filename.ll"

# Run preprocessing passes
"$root_dir/opt.sh" "$filename.ll" "$filename.ll"


"$LLVM_AS" "$filename.ll" -o "$filename.bc"


echo "IR file generated:" "$filename.ll"
echo "BC file generated:" "$filename.bc"

cd $current_path
