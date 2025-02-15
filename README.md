# Spoq3

This repo is based on the previous work by Spoq and Spoq2. It is expected to be thoroughly tested, well structured, and fully documented.

## Documentation
See at Ronghui's machine (port 5050):
```
Username: the github group name (lowercase)
Password: the biggest positive int32
```

## Build

### Build Spoq
```
git submodule update --init --recursive
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
```

### Build IR2Json
This component is to be removed in the future.
```
cd IR2Json
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
mkdir llvm
tar xvf clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz --strip 1 -C llvm
rm clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
make -j$(nproc)
cd ..
```

