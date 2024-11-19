## Build IR2Json
```
cd IR2Json
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
mkdir llvm
tar xvf clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz --strip 1 -C llvm
rm clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
make -j$(nproc)
cd ..
```

## Build Spoq

```
git submodule update --init --recursive
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
```


## SpoqDSL
- This branch is build on modified Spoq, and aim to support spec generation from unmodified system, invariant definitions, bound annotation, automated invariant checking, counter-example generation. It is also expected to redesign the specification language so that it is aimed to be translated to verification conditions.