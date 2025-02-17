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

### Build Spoq (for debug)
```
cmake -DCMAKE_BUILD_TYPE=Debug ..
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

## Features

### Pointer Abstraction

### Z3 Cache
```
include/z3_rules.h
src/optimizations/z3_utils.cpp
```

### Automated Verification
```
include/symbolic.h
src/optimizations/symbolic.cpp
```

#### Cone of Influence (COI)

#### Recursive Proof for Folded Specs

#### Data-Race-Free (DRF) Detection 

#### Machine-checkable SMT2 Query Generation 

## Development

#### Z3 Overhead Profiling

```
src/optimizations/profile.cpp:
	static bool __PROFILE_ON = false;
```

#### Memory Leakage Detection 

Option 1. Use Valgrind
```
valgrind --leak-check=full --undef-value-errors=no --log-file=<log file>  ./build/spoq <config file>
```

Option 2. Dynamic Monitor
```
watch -n 0.1 'MEMTOTAL=$(awk "/MemTotal/ {print \$2}" /proc/meminfo); \
 ps -eo pid,rss,comm --sort=-rss | head -n 20 | \
 awk -v mt=$MEMTOTAL "NR==1 {printf \"%-8s %10s %10s  %s\\n\",\"PID\",\"RSS(KB)\",\"MemUse(%)\",\"COMMAND\"} NR>1 {usage=(\$2/mt)*100; printf \"%-8s %10d %9.3f%%  %s\\n\",\$1,\$2,usage,\$3}"'
```



