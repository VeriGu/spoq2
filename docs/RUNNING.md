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

## 6. Reference: options, environment variables and parameters

Each run logs `Z3 unknowns: <n>/<total>` near the end of stderr.  Switches
marked "set" take effect when the variable is set to any value; the others
state the values they accept.

### spoq command line

`spoq <file>.main.v [options]`; the file can also be given as
`--input <file>`.  The standard invocation is
`--new-trans --llvm --no-profile --check-patch-refinement --check-pre-post`,
with `--race` and `--query-path` added by the case Makefiles.

| option | default | effect |
|---|---|---|
| `--llvm` | off | use the LLVM frontend, which reads the bitcode named by `PROJ_BC_PATH` in the `.main.v` |
| `--new-trans` | off | use the current transformation pipeline |
| `--check-patch-refinement` | off | check the vuln/patch refinement given by `Hint Refines` |
| `--check-pre-post` | off | check that preconditions imply postconditions |
| `--check-loop-inv` | off | check loop invariants |
| `--check-sys-inv` | on | check system invariants |
| `--check-simulation`, `--decom-check-simul` | off | check relational simulation |
| `--check-none` | off | check None paths |
| `--race` | off | decide each check out of process by racing several `z3` processes, taking the first definite answer (see below) |
| `--race-timeout <n>` | 2000 | per-process limit passed to `z3 -t:`, in milliseconds (the help text and the log line say seconds), then scaled by `SPOQ_Z3_TIMEOUT_SCALE` |
| `--query-path <dir>` | `./llvm.container/z3_queries/` | where queries are dumped, one subdirectory per function and pass |
| `--profile` / `--no-profile` | on | Z3 overhead profiling |
| `--coi` / `--no-coi` | on | cone-of-influence reduction |
| `--no-prune-path` | off | do not use cone of influence to prune paths |
| `--lens` / `--no-lens` | on | use lenses |
| `--count-leaves` | off | count unfolded leaves before and after transformation |
| `--conditional-spec`, `-c` | off | generate conditional specs |
| `--transform-io` | off | transform IO paths |
| `--dry-run-asm` | off | list inline-assembly specs without definitions in `missing_asm.txt` |
| `--target-transition <fn>` | none | the top-level transition function to verify |
| `--no-expr-cache` | off | accepted for compatibility; no effect |
| `--help`, `-h` | | list the options |

`--race` starts, per check, `z3 -t:<ms> <query>` and
`z3 -t:<ms> smt.arith.solver=2 <query>`.  Under `SPOQ_BV_SORTS=1` it adds
`tactic.default_tactic=qfaufbv`.  It also always races the query under the
retry tactic, independent of `SPOQ_Z3_RETRY`.  `z3` is taken from `PATH`
(here `/usr/bin/z3`, 4.17.0).

### spoq environment variables

Encoding and solver:

| variable | default | effect |
|---|---|---|
| `SPOQ_BV_SORTS=1` | off | declare values with an LLVM width as bitvectors instead of integers |
| `SPOQ_Z3_BITVEC=0` | on | turn off the bitvector encoding of bitwise operations |
| `SPOQ_Z3_TACTIC=<tactic>` | `qfaufbv` under bitvector sorts, else the default solver | in-process solver tactic |
| `SPOQ_Z3_PARAMS="k=v ..."` | none | space-separated global Z3 parameters (`z3::set_param`) |
| `SPOQ_Z3_TIMEOUT_SCALE=<k>` | 3 under bitvector sorts, else 1 | multiplies every Z3 timeout, including `--race-timeout` |
| `SPOQ_Z3_RETRY=0\|1` | on with integer sorts, off with bitvector sorts | retry an unknown in-process check with the retry tactic |
| `SPOQ_BV_CONGRUENCE=0` | on under bitvector sorts | turn off congruence lemmas for uninterpreted calls whose bitvector arguments are identical |
| `SPOQ_DIV_LEMMAS=0` | on | turn off the rounding-division lemmas (integer sorts) |
| `SPOQ_FORCE_CMP_NORM` (set) | off | rewrite `a op b` to `(a - b) op 0` under bitvector sorts as well; unsound there, for measurement only |
| `SPOQ_STACK_TYPING=1` | off | assume each stack slot holds its declared constructor (`docs/stack_assumptions.md`, assumption 1) |

Unfolding, transformation and CFG conversion:

| variable | default | effect |
|---|---|---|
| `SPOQ_EAGER_UNFOLD` (set) | lazy | unfold every callee eagerly instead of on demand |
| `SPOQ_EAGER_SPEC` (set) | lazy | transform every spec at generation time instead of when a proof opens it |
| `SPOQ_HOIST_BUDGET=<n>` | 400 | leaves `hoist_match_from_branch` may duplicate per rewrite; 0 removes the limit |
| `SPOQ_CFG_REPEAT_LIMIT=<n>` | 10000000 | clone-step budget of CFG structuring before it gives up; lowering it is for reducing test cases |
| `SPOQ_CFG_CLONE_JOINS` (set) | off | clone join points during CFG structuring instead of resolving phis per edge |

Dumps and traces:

| variable | effect |
|---|---|
| `SPOQ_DUMP_REFINES` (set) | write the vuln and patch bodies at each refinement check to `refines_<fn>_<n>_{vuln,patch}` in the working directory |
| `SPOQ_DUMP_HOIST=<def>` | write `<def>` before and after each hoist pass to `<def>_iter<N>_{pre,post}_hoist.txt` |
| `SPOQ_DUMP_SPEC=<def>[,<def>...]` | write each listed definition before transformation to `<def>_iter0.txt` and after each transformation iteration to `<def>_iter<N>.txt`, in the working directory |
| `SPOQ_SLOW_QUERY_DIR=<dir>` | save every check that takes at least `SPOQ_SLOW_QUERY_MS` (default 200) as `<dir>/slow_<n>.smt2`, with its time and result; the directory is created |
| `SPOQ_CURRENT_QUERY=<file>` | overwrite `<file>` with each query before it is checked, so a hang leaves the query behind |
| `SPOQ_TRACE_TRANSFORM` (set) | log spec size after each transformation pass (`[PASS]`), hoist decisions (`[HOIST]`) and unfolds (`[TRACE]`) |
| `SPOQ_TRACE_ALIGN` (set) | log the alignment skeletons of both bodies at the refinement check, and nodes still carrying an alignment index after each pass |
| `SPOQ_TRACE_IF` (set) | log the Z3 form of match scrutinees in forward simulation and the result of each rely check in `z3_eval` |
| `SPOQ_TRACE_SORTS` (set) | at exit, count integer/bitvector conversions by kind and site |
| `SPOQ_HOIST_NOOP` (set) | report hoist rewrites that leave the term unchanged |
| `SPOQ_DUMP_LOOPCTX` (set) | print the values in each loop's context during translation (`[loopctx]`) |

Other:

| variable | effect |
|---|---|
| `AUTOV_HOME` | root under which the inline-assembly translator finds `scripts/AsmGen/asmgen.native`; empty if unset |
| `TURN_OFF_LR_LOOP_ENTRY_BRANCH_OPT=1` | an ANTLR runtime setting, not spoq's |

### Test harness

| variable | read by | effect |
|---|---|---|
| `SPOQ_BV_SORTS=1` | `SpoqTest` | passed to spoq, and makes `unimplemented_bv_sorts` apply |
| `SPOQ_TEST_KEEP` (set) | `SpoqTest` | keep every scratch directory; the list is also written to `$TMPDIR/spoq-test-kept.txt` |
| `SPOQ_TEST_ARGS="<options>"` | `SpoqTest` | append options to every spoq run |
| `TMPDIR` | `SpoqTest` | where the kept-directory list goes (default `/tmp`) |
| `OPT`, `LLVM_ROOT` | `PreprocessingTest` | the `opt` that loads the plugins: `$OPT`, else `$LLVM_ROOT/bin/opt`, else `~/workspace/llvm-project/build/bin/opt`, else `opt` |
| `SPOQ_DUMP_CFG` (set) | `IrTranslationTest` | print each function after CFG conversion |
| `CTRL=<spec>` | `Z3SimplifyFixpointTest` | replace the control spec of `ReportsAChangeWhenItSimplifies` |
| `Z3_PATH` | `Z3UtilsTest` | set by the test; spoq no longer reads it |

### Build parameters

| parameter | default | effect |
|---|---|---|
| `-DCMAKE_BUILD_TYPE` | | `DEBUG` or `Release` |
| `-DZ3_DIR=<dir>` | `$HOME/workspace/z3/build` | directory with `Z3Config.cmake`; version 4.17 required |
| `-DLLVM_ROOT=<dir>` or env `LLVM_ROOT` | the local build | LLVM 23 prefix or build tree; `-DLLVM_DIR=<dir>/lib/cmake/llvm` also works |
| `build-passes.sh [<llvm-dir>]` | `$LLVM_ROOT`, else `~/workspace/llvm-project/build` | LLVM the plugins are built against |
| `make -C scripts/IR2Json LLVM_ROOT=<dir>` | `/usr/lib/llvm-23` | LLVM IR2Json is built against |

### Preprocessing scripts

`scripts/preprocessing/*.sh` read `LLVM_ROOT` (default
`~/workspace/llvm-project/build`), and from it `OPT`, `CLANG`, `LLVM_AS` and
`LLVM_DIS` (each defaulting to `$LLVM_ROOT/bin/<tool>`, falling back to
`<tool>-23` on `PATH`).  The rename pass reads `RENAMING_PLAN` (required, the
plan JSON) and `RENAME_SUFFIX`; the case Makefiles set both.

### patchverification Makefiles

Per case (`examples/<project>/<case>/Makefile`) and in `examples/synthetic`:

| variable | default | effect |
|---|---|---|
| `SPOQ_DIR` | `~/workspace/spoq3` | spoq3 tree: `build/spoq`, `build/json2coq`, plugins, IR2Json |
| `LLVM_DIR` | `~/workspace/llvm-project` | LLVM source tree; `LLVM_BIN` defaults to `$(LLVM_DIR)/build/bin` |
| `OPT`, `CLANG`, `LLVM_AS` | `$(LLVM_BIN)/<tool>` | individual tools; `OPT` is exported to the spoq3 scripts |
| `LLVM_LIB` | `$(LLVM_DIR)/build/lib` | added to `LD_LIBRARY_PATH` for `ir2json` |
| `PV_PASS_DIR` | `../../../src/LLVMPasses` | patchverification's passes (per-case Makefiles only) |

In `examples/Makefile` (Docker builds of the `.ll` pairs): `GROUP` (filter for
`make list`), `DOCKER` (default `docker`), `JQ` (default `jq`),
`LLVM_VERSION` (default 23) and `PV_COMPAT_CFLAGS` (extra compiler flags passed
into the build container).
