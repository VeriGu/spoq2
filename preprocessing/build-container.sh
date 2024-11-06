current_path=$(pwd)

root_dir="$(realpath "$1")" # root_dir is the dir for the container project
echo $root_dir

cd $root_dir
make clean
make 

cd $current_path
