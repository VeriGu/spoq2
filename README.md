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
- This branch wei-newdsl is build on Spoq, and aim to build a new domain specific specification language for systems extended from Spoq's specification language that support spec generation from unmodified system, invariant definitions, bound annotation, automated invariant checking, counter-example generation. It could also potentially support bmc(bounded model checking). While Spoq proves Code refines Low-Spec automatically, then use Spoq to generate specification and then feeded to SpoqDSL.