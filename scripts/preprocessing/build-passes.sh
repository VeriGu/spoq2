if [ ! -ne "$1" ]; then
    echo "Usage: $0 <llvm-path>"
    exit 1
fi

# Assign input arguments to variables
llvm_dir="$(realpath "$1")" # container_dir is the dir for the container project
root_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if the directory exists
if [ ! -d "$llvm_dir" ]; then
    echo "Error: The llvm directory $llvm_dir does not exist."
    exit 1
fi

# Iterate through each subdirectory in the specified directory
for subdir in "$root_dir"/*/; do
    if [ -d "$subdir" ]; then
        # Check if the 'llvm' link already exists
        if [ ! -e "$subdir/llvm" ]; then
            # Create the soft link if it does not exist
            ln -sf "$llvm_dir" "$subdir/llvm"
            echo "Created link: $subdir/llvm -> $llvm_dir"
        else
            echo "Link already exists: $subdir/llvm"
        fi
        cd $subdir
        cmake .
        make -j4
        echo "Pass make: $subdir"
        cd ..
    fi
done