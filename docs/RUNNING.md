# Running spoq3

The paths below are for this machine: LLVM 23 is a source build at
`~/workspace/llvm-project/build`, Z3 4.17 is at `~/workspace/z3/build`, and
patchverification is at `~/workspace/patchverification`.

## 1. New worktree

```
cd ~/workspace/spoq3
git worktree add ../spoq3-<name> -b <branch> [<start-commit>]
cd ../spoq3-<name>
git submodule update --init src/frontend/parser/antlr4
```

`git worktree list` shows the existing trees.  Each worktree needs its own
build and its own preprocessing plugins (steps 2 and 3).

## 2. Build spoq

```
cmake -S . -B build -DCMAKE_BUILD_TYPE=DEBUG \
      -DCMAKE_C_COMPILER=/usr/bin/clang-18 -DCMAKE_CXX_COMPILER=/usr/bin/clang++-18
make -C build -j$(nproc)
```

- Z3 comes from the `Z3_DIR` cache variable (default `$HOME/workspace/z3/build`,
  version 4.17 required).  LLVM comes from `LLVM_ROOT` (argument or environment
  variable).  An existing build directory that used another Z3 needs
  `-DZ3_DIR=$HOME/workspace/z3/build` once.
- The build produces `build/spoq`, `build/json2coq`, `build/SpoqTest` and the
  unit-test binaries.  Their output directory is `<source>/build`, so a
  second build directory in the same tree overwrites `build/spoq`.
- Do not swap libz3 with `LD_LIBRARY_PATH`: the ABI differs between versions
  and spoq segfaults.

## 3. Build the preprocessing plugins and IR2Json

The patchverification pipelines load these from `$SPOQ_DIR`:

```
scripts/preprocessing/build-passes.sh      # uses ~/workspace/llvm-project/build by default
make -C scripts/IR2Json -j$(nproc) LLVM_ROOT=$HOME/workspace/llvm-project/build
```

`build-passes.sh` configures each plugin under `scripts/preprocessing/*`
(extractbasics, extractpointers, cleaner, my_mergefunc, ...) in place.  After
changing a plugin, rebuild it with `make -C scripts/preprocessing/<plugin>`.

patchverification's own passes are built separately, from the top-level
Makefile so that the shared headers stay consistent:

```
make -C ~/workspace/patchverification/src/LLVMPasses all    # `rebuild` after a header change
```

## 4. Tests

```
cd build
cmake .                          # re-run after adding a test case, to register it with ctest
ctest -j8                        # integer sorts
SPOQ_BV_SORTS=1 ctest -j8        # bitvector sorts
ctest -R <name>                  # one case, e.g. ctest -R gep_inbounds
./HoistScopeTest                 # a unit-test binary run directly
```

- A spoq test case is a triple in `test/<dir>/`: `<case>.ll`,
  `<case>.main.v` and `<case>.expected.json`.  `SpoqTest` assembles the `.ll`,
  runs spoq on it with
  `--new-trans --llvm --no-profile --check-patch-refinement --check-pre-post`,
  and compares the JSON result with the expected fields.
- Keys of `expected.json`, besides result fields such as `verified` and
  `spec_has_ub`:

  | key | meaning |
  |---|---|
  | `unimplemented` | a mismatch is reported as a skip, with this reason |
  | `unimplemented_bv_sorts` | the same, only under `SPOQ_BV_SORTS=1` |
  | `expect_error` | spoq must exit non-zero with this text on stderr |
  | `stderr_contains`, `stderr_lacks` | text that must or must not be on stderr |
  | `spec_v_definition` with `spec_v_contains`, `spec_v_lacks` | `;`-separated text that must or must not be in that Definition's body in the generated Spec.v |
  | `coq_contains` | `;`-separated text that must be in some generated `.v` file |
  | `env`, `args` | extra environment (`;`-separated `VAR=value`) and spoq options for this case |

- `SPOQ_TEST_KEEP=1` keeps each case's scratch directory, and
  `SPOQ_TEST_ARGS="--race"` appends options to every run.
- Unit tests (`test/unit/*.cpp`) are separate GoogleTest binaries, each with
  an `add_executable` and `add_test` entry in `CMakeLists.txt`.

## 5. patchverification examples

### Real-world cases

Each case is `examples/<project>/<case>/`.  It holds `vuln/` and `patch/`
(the translation unit's `.o.ll` for each version), `config.json`, and
optionally `<tu>.assumptions.v`.  If the `.ll` files are missing, build them
in Docker from `examples/` with `make <project>/<case>`; see
`examples/README.md`.

```
cd ~/workspace/patchverification/examples/openjpeg/cve-2024-56827
make SPOQ_DIR=~/workspace/spoq3-<name>        # whole pipeline, then spoq
make SPOQ_DIR=... build/j2k.c.main.v          # stop after generating the spec file
```

- The result is `build/<tu>_result.json`, with stderr in
  `build/<tu>_result.log.err` and Z3 queries in `build/z3_queries/<tu>/`.
- The Makefile runs
  `spoq <tu>.main.v --check-pre-post --race --new-trans --llvm --no-profile --check-patch-refinement --query-path z3_queries/<tu>/`.
- `SPOQ_DIR` defaults to `~/workspace/spoq3`.  `LLVM_DIR` (default
  `~/workspace/llvm-project`) selects `opt` and `clang`.

To rerun spoq without redoing the pipeline, copy `<tu>.main.v` and `<tu>.bc`
into a scratch directory and run the command above there.  Large cases take
hours (openjpeg cve-2024-56827: about 3.7 h).  Start such runs detached so
they outlive the terminal:

```
setsid nohup ~/workspace/spoq3/build/spoq j2k.c.main.v <options> > out.json 2> err.log < /dev/null &
```

### Synthetic corpus

```
cd ~/workspace/patchverification/examples/synthetic
make -k SPOQ_DIR=~/workspace/spoq3-<name>                           # every case
make SPOQ_DIR=... two_file_spoq_projects/<name>.ll.main.v           # generate one two-file case
make SPOQ_DIR=... two_file_results/<name>.log                       # generate and run it
```

- A two-file case is `two_file_code/<name>_vuln.c` plus
  `two_file_code/<name>_patch.c`.  The pipeline writes
  `two_file_spoq_projects/<name>.{ll,bc,ll.main.v}`.  The result JSON goes to
  `two_file_results/<name>.log`, with stderr in `.log.err`.
- A case without `<name>.assumptions.v` prints `Error 1 (ignored)` from the
  `cat` step; this is expected.
- The `.main.v` files are assembled from `main_v_prefix.v` and
  `main_v_suffix_common.v`.  After editing either, regenerate the affected
  `.main.v` files.
- Without `-k`, `make` stops at the first case where spoq fails.  Three cases
  abort in both modes (`php009_static_arr`, `php009_static_struct_arr`,
  `struct_stack_ptr`).
- spoq writes a run's queries under `llvm.container/z3_queries/` in the
  directory it runs in (`two_file_spoq_projects/`), so runs started from the
  same directory share it.  Parallel corpus runs that shared it have aborted
  with a filesystem error; run them one at a time.

To turn a two-file case into a spoq test, copy `<name>.ll` and
`<name>.ll.main.v` into `test/<dir>/`.  Rename them to `<case>.ll` and
`<case>.main.v`, and change `PROJ_NAME`, `PROJ_BASE` and `PROJ_BC_PATH` in the
`.main.v` to the new stem.  Then add `<case>.expected.json` and re-run `cmake`.

## 6. Diagnostics

| variable | effect |
|---|---|
| `SPOQ_BV_SORTS=1` | bitvector sorts instead of integers |
| `SPOQ_DUMP_REFINES=1` | writes the vuln and patch bodies at the refinement check to `refines_<fn>_<n>_{vuln,patch}` |
| `SPOQ_TRACE_TRANSFORM=1` | logs spec size after each transformation pass |
| `SPOQ_SLOW_QUERY_DIR=<dir>`, `SPOQ_SLOW_QUERY_MS=<ms>` | saves queries slower than the threshold |
| `SPOQ_Z3_RETRY=0/1` | turns off/on the tactic retry after an unknown result |
| `SPOQ_Z3_TIMEOUT_SCALE=<k>` | scales the Z3 timeouts |

Each run logs `Z3 unknowns: <n>/<total>` near the end of stderr.
