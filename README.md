# Spoq3

This repo is based on the previous work by Spoq and Spoq2. It is expected to be thoroughly tested, well structured, and fully documented.

## Documentation

See here[http://128.59.16.30:5050/]. 

```
Username: the github group name (lowercase)
Password: the biggest positive int32
```
## Build (Artifact)

1. Get the source code and artifacts

```
git submodule update --init --recursive
```
Optional: fetch the artifact
```
cd spoq && git clone git@github.com:VeriGu/spoq3-artifacts.git && cd ..
```

2. Build Spoq 

```
docker build --no-cache -t spoq3:builder --target builder .
docker run --rm -it spoq3:builder bash
```

3. Run the artifact (in docker, after step 2)

ARM CCA 
```
cd spoq3-artifacts/rmm-pa/ && python3 run.py
```


## Build (Development)

### Dependencies

- Z3 : 4.12.5 (Please use the cmake-version for our cmakefile to correctly find z3).
- LLVM : 14.0.0
- Antlr4: Served as a submodule
- Boost: (todo: specify version)


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

## Workflow

The desired workflow of Spoq3:

```
LLVM IR  
  |
  |[auto: inline/unfold functions]
  v
Inlined
LLVM IR
  |
  |[translator]
  v
Spoq IR
w. control structure
  |
  v
Spoq IR --------------[auto]-----------> Gen. Machine Model
 |   |                                            |          user-defined
 |   |                         user-provided      |<----------- specs
 |   +-----+                   memory layout----->|
 |         |                                      [manual]
 |         [auto]                                v
 |         v                            Revised Machine Model
 |    Layer Config                                |
 |         |               user-provided          |
 |         |        ptr abstraction template----->|
 |         [auto]                                [auto]
 |         v                                      v
 +----> Low Spec <-----[auto]---------- Final Machine Model                      
     w. ptr abstraction                 w. ptr abstraction
           |                             
           [auto]
           v
        Low Spec 
    w. more abstraction
          |
          [auto: z3/nonz3 transformation rules]
          |
          |
          |
          v
       High Spec----[auto:gen_coq]------> coq definition
          |                                    |
          |                                    |
          |          user-defined              |
          |<--[auto]- invariant   ---[manual]--+---> coq 
          |                                         proof
          |                                     
          v                                     
       automated                        
      verification
```		

## Features

### LLVM Translation Algorithm

### Pointer Abstraction

### Z3 Cache

```
include/z3_rules.h
src/optimizations/z3_utils.cpp
```

### Automated Verification for Trace Property 

We perform invariant satisfiability check for security invariants, loop invariants, etc.

```
include/symbolic.h
src/optimizations/symbolic.cpp
```

#### Cone of Influence (COI)

#### Recursive Proof for Folded Specs

#### Data-Race-Free (DRF) Detection 

#### Machine-checkable SMT2 Query Generation 

#### Loop Invariant Inductiveness Checking

#### Expressive Pre/Post condition

#### Decidable-Fragement Checking

### Automated Verification for Relational Property 

We perform downward simulation for given relations in Section Relations.

```
include/simulate.h
src/optimizations/simulate.cpp
```
#### Witness Instantiation

## Development

### Commandline Commands -command
- conditional_spec
- check-sys-inv: check system invariants defined by "Invariants"
- check-loop-inv: check loop invariants defined by "Loop_inv"
- check-pre-post: check precondition implies post condition
- check-simulation: check relational simulation for specs
- check-drf: check if the spec is drf. 
- new-trans: use new transformations defined.

#### Z3 Overhead Profiling

The profiler is by default on (`-profile`). Use `--no-profile` to turn it off.

```
cmd.h: Line 101
  autov::—__PROFILE_ON = this->profile;

src/optimizations/profile.cpp:
	static bool __PROFILE_ON = false;
```

### Configuration file commands and Syntax
#### Definitions
- Definition 
- Invariant
- Loop_inv
- Axiom(TODO)

#### Config Commands
- Hint Precondition/Postcondition < fname > < Expr >
- Hint Preserve fname: Assume(rely) fname preserve invariant.
- Hint CheckInv fname: only check invariant for fname




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


