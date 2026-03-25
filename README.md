# Spoq2

Highly automated verification framework for security properties of unmodified system software. Spoq2 reduces security properties (e.g., noninterference) to inductive invariants on individual transitions, then automatically verifies them using Z3. Published at [ASPLOS '26](https://doi.org/10.1145/3779212.3790171).

> **Note:** For the artifact packed for ASPLOS '26, please see https://zenodo.org/records/17946847

## Quick Start (Docker)

```bash
git submodule update --init --recursive
docker build --no-cache -t spoq2:builder --target builder .
docker run --rm -it spoq2:builder bash
```

### Run Artifacts

Clone artifacts inside the container (or mount them):

```bash
git clone git@github.com:VeriGu/spoq2-artifacts.git
cd spoq2-artifacts/rmm-pa/ && python3 run.py
```

## Native Build

### Dependencies

- Z3 4.12.5 (cmake build, so CMake can find it)
- LLVM 14.0.0
- Boost (log, program\_options)
- CMake 3.10+, C++17 compiler (clang/clang++)
- Antlr4 runtime (git submodule)

### Build

```bash
git submodule update --init --recursive
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
  -DZ3_DIR=/path/to/z3/lib/cmake/z3
cmake --build build -j$(nproc)
```

For debug: use `-DCMAKE_BUILD_TYPE=Debug`.

### Usage

```bash
./build/spoq <config-file> [options]
```

Key options: `--llvm`, `--new-trans`, `--transform-io`, `--race`, `--check-simulation`, `--check-sys-inv`, `--check-loop-inv`, `--profile` / `--no-profile`.

## Features

- **LLVM-to-Coq Translation** — compiles unmodified C/assembly into Coq representations via LLVM IR, applying verified transformation rules to produce self-contained per-transition specs
- **Proof Goal Construction** — decomposes security properties (safety, information-flow, k-safety hyperproperties) into per-transition inductive invariant proof goals, enumerating all execution paths automatically
- **Cone-of-Influence (COI) Analysis** — per-transition COI to prune irrelevant state variables, reduce proof goals, and simplify clauses within goals; extends classical COI from whole-system to individual transitions
- **Pointer Abstraction** — user-provided storage format and layout configs replace bitwise pointer operations with abstract attribute accessors, avoiding expensive bit-vector SMT reasoning
- **Z3 Query Caching** — caches SMT formulas and query results by structural hash to eliminate redundant Z3 calls

## Commands

| Flag | Description |
|------|-------------|
| `--check-sys-inv` | Check system invariants (defined by `Invariant`) |
| `--check-loop-inv` | Check loop invariants (defined by `Loop_inv`) |
| `--check-pre-post` | Check precondition ⇒ postcondition |
| `--check-simulation` | Check relational simulation |
| `--race` | Multi-solver: race multiple Z3 versions, keep best result |
| `--race-timeout <sec>` | Z3 CPU limit per solver in seconds (default 120000) |
| `--new-trans` | Use new transformation rules |
| `--profile` / `--no-profile` | Z3 overhead profiling (on by default) |

## Config File Syntax

**Definitions:** `Definition`, `Invariant`, `Loop_inv`, `Axiom`

**Hints:**
- `Hint Precondition/Postcondition <fname> <Expr>`
- `Hint Preserve <fname>` — assume function preserves invariant
- `Hint CheckInv <fname>` — only check invariant for this function

## Citation

```bibtex
@inproceedings{10.1145/3779212.3790171,
author = {Yang, Ganxiang and Qiang, Wei and Rong, Yi and Li, Xuheng and Yu, Fanqi and Nieh, Jason and Gu, Ronghui},
title = {Highly Automated Verification of Security Properties for Unmodified System Software},
year = {2026},
isbn = {9798400723599},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
url = {https://doi.org/10.1145/3779212.3790171},
doi = {10.1145/3779212.3790171},
abstract = {System software is often complex and hides exploitable security vulnerabilities. Formal verification promises bug-free software but comes with a prohibitive proof cost. We present Spoq2, the first verification framework to highly automate security verification of unmodified system software. Spoq2 is based on the observation that many security properties, such as noninterference, can be reduced to establishing inductive invariants on individual transitions of a transition system that models system software. However, directly verifying such invariants for real system code overwhelms existing SMT solvers. Spoq2 makes this possible by automatically reducing verification complexity. It decomposes transitions into individual execution paths, extends cone-of-influence analysis to the individual transition level, and eliminates irrelevant machine states, clauses, and control-flow paths before invoking the SMT solver. Spoq2 further optimizes how pointer operations are modeled and verified through pointer abstractions that eliminate expensive bit-wise operations from SMT queries. We demonstrate the effectiveness of Spoq2 by verifying security properties of four unmodified, real-world system codebases with minimal manual effort.},
booktitle = {Proceedings of the 31st ACM International Conference on Architectural Support for Programming Languages and Operating Systems, Volume 2},
pages = {912–928},
numpages = {17},
keywords = {formal verification, system software, automated verification, security properties, smt solvers},
location = {USA},
series = {ASPLOS '26}
}
```
