# spoq regression tests

`SpoqTest` is a GoogleTest driver, built as part of the default build. Because
the CMake target depends on `spoq`, building or running it always rebuilds the
executable under test first, and the path to it is baked in at configure time —
the tests can never run against a stale binary.

    make SpoqTest && ./build/SpoqTest      # all cases
    ./build/SpoqTest --gtest_filter=Spoq.attr_readonly
    ctest                                  # one ctest entry per case
    ctest -R attr_readonly

Set `SPOQ_TEST_KEEP=1` to keep every scratch directory — on pass as well as on
fail — for inspection. Each kept directory holds the `.bc`, the `.main.v`, the
full spoq `stderr.log` and the `.smt2` queries, so a case can be re-run by hand.
The paths are reported three ways:

    [ KEPT     ] Spoq.attr_readonly -> /tmp/spoq-test-attr_readonly-3814199

a per-case line as it completes, an end-of-run summary listing them all, and
`$TMPDIR/spoq-test-kept.txt`. The file matters because `ctest` hides the output
of a *passing* test: use `ctest -V` to see the lines, or just read the file.

A test is three files sharing a stem:

| file | contents |
|---|---|
| `<test>.ll` | the module under analysis |
| `<test>.main.v` | the spoq configuration, self-contained |
| `<test>.expected.json` | the fields of spoq's result JSON that are pinned |

The driver assembles each case in its own scratch directory, assembles the `.ll`
to the `.bc` that `PROJ_BC_PATH` names (in process, via the same LLVM spoq links
against), runs spoq there, and compares only the keys present in the expected
file — timings and leaf counts are ignored, so only the semantic verdict is
pinned.

Cases are discovered at run time, so adding a triple of files needs no build
change; re-run `cmake` only if you want the new case to get its own `ctest`
entry.

`archive/` holds the older ad-hoc fixtures; they are ignored because they have no
`.expected.json`.

## function_attributes/

These exercise spoq's use of LLVM function attributes. Each one is written so
that it **cannot** be verified without them: the callee is an external
declaration, so its result state is otherwise unconstrained and the value read
back from a global after the call is unknown.

| test | attribute on the callee | expected | why |
|---|---|---|---|
| `attr_readnone` | `memory(none)` | `verified: true` | callee touches no memory, so the state survives the call |
| `attr_readonly` | `memory(read)` | `verified: true` | callee cannot write, so the state survives the call |
| `attr_writeonly` | `memory(write)` | `verified: false` | negative control — a callee that may write must not be assumed harmless |
| `attr_argmem` | `memory(read, argmem: readwrite, inaccessiblemem: none, target_mem: none)`, `&g` passed | `verified: false` | the granular form still permits writes through pointer arguments |
| `attr_argmem_nopointers` | the same attribute, no pointer passed | `verified: true` | argument memory the callee cannot name is memory it cannot write |
| `attr_argmem_frame` | the same attribute, `&local` passed | `verified: true` | the pointer can only name the stack, so the globals stay framed |

The last two are a pair over the *same* attribute, differing only in whether a
pointer reaches the callee, and they isolate the per-location narrowing: argument
memory the callee cannot name is argument memory it cannot touch, so with no
pointer argument `argmem: readwrite` licenses no write at all.

The generated specs show the mechanism directly:

    state reused (continuation keeps the incoming st):
      attr_readonly:            when call, st_unused_0 == ((ext_pure_spec st));
      attr_argmem_nopointers:   when call, st_unused_0 == ((ext_argmem_np_spec 1 st));

    state re-bound (post-call state is unconstrained):
      attr_argmem:              when call, st == ((ext_argmem_spec (mkPtr "g" 0) st));

### What each test actually discriminates

Measured by re-running each case against earlier builds. `no attr` has no
attribute support; `coarse` has only the "never writes anything" rule.

| test | no attr | coarse | current | pins |
|---|---|---|---|---|
| `attr_readnone` | false | **true** | true | the coarse memory rule |
| `attr_readonly` | false | **true** | true | the coarse memory rule |
| `attr_argmem_nopointers` | false | false | **true** | the empty-argmem narrowing |
| `attr_argmem_frame` | — | false | **true** | the three-way argmem frame |
| `attr_writeonly` | false | false | false | negative control only |
| `attr_argmem` | false | false | false | negative control only |

The bolded transitions are the point: those four tests fail against a build
lacking the code they exercise, so every part of the attribute handling has a
test that earns its keep.

The last two do not, and it is worth being explicit about that: `verified: false`
is also what an implementation with *no* attribute support produces, so they
cannot show the feature works. They only catch a future change that becomes
*unsoundly* aggressive — the plausible mistake being to read
`memory(read, argmem: readwrite, ...)` as read-only by taking the leading `read`
and missing the per-location override, which would flip them to `true`.

When argument memory is the only thing a callee may write, and there is exactly
one pointer argument, the post-call state is now *framed* rather than left
unconstrained — at most the object that pointer designates changes. The frame
mirrors `store_RData`'s own dispatch:

    rely (   ((~ (is_global_ptr p)) /\ (~ (is_stack_ptr p))
              /\ (st_call.(heap) = (mkMEM ((st.(heap)).(blocks)
                                           # (spvn (p.(pbase)))
                                           == (((st_call.(heap)).(blocks)) @ (spvn (p.(pbase)))))
                                          ((st.(heap)).(nextBlock))))
              /\ (st_call.(stack) = st.(stack)) /\ (st_call.(globals) = st.(globals)))
          \/ ((is_stack_ptr p)  /\ (st_call.(heap) = st.(heap))  /\ (st_call.(globals) = st.(globals)))
          \/ ((is_global_ptr p) /\ (st_call.(heap) = st.(heap))  /\ (st_call.(stack) = st.(stack))));
    let st := st_call in

Whichever region the pointer names is the only one that may differ; the other
two are pinned. The witness for "some block" is the callee's own block, so no
existential is needed, and `nextBlock` is pinned because an argmem-only callee
cannot allocate.

Stating this as an assumption rather than building the conditional into the
state keeps `st` a plain symbol, so later loads and stores are not forced to
reason through an if-expression in the state itself. Both encodings were
implemented and pass all six tests; the Rely form is measurably cheaper —
10.1s/10.2s versus 11.1s/11.1s for the suite, with the difference concentrated
in `attr_argmem_frame`, the only case where the frame does real work.

Note this Rely survives the pipeline where the obvious one does not. Writing
preservation as `let st_pre := st in ... rely (st = st_pre)` is silently
eliminated: the `when` rebinds `st`, let-inlining captures it and the assumption
collapses to `st = st`. Here the pre-state and the callee's state are distinct
names where the Rely is written, so there is nothing to capture.

Two limits worth knowing:

- The heap branch is per-block precise, but the globals and stack branches take
  the *whole* region from the callee's state. Framing those per-object would need
  the project's global and slot layout, which the translator does not have.  So a
  call passing a pointer to a global — `attr_argmem`, which passes `&g` — still
  gets no useful information, which is why its expectation is unchanged.
- Only the single-pointer case is framed. With several pointer arguments the
  frame would have to permit all of them to change at once.

`src/` holds the C the `.ll` files were compiled from, with
`clang -S -emit-llvm -fno-discard-value-names -O1 -Xclang -disable-llvm-passes`
(matching how `examples/synthetic` builds its IR). `attr_writeonly.ll` then has
`memory(write)` substituted by hand, since C has no attribute that spells it.

## Attribute disposition

Every function attribute appearing in the reference corpus
(`~/workspace/patchverification/examples`), and what spoq does with it:

**Used.** `memory(none)` / `readnone`, `memory(read)` / `readonly` — the callee
provably never writes, so the call's output state is its input state.  The
per-location `memory(..., argmem: ...)` forms also qualify when the call passes
no pointer argument, since the callee then has no argument memory to write.

**Deliberately unused, unsound to exploit as-is:**

- `memory(write)` / `writeonly`, and the per-location forms
  (`memory(argmem: ...)` / `argmemonly`,
  `memory(read, argmem: readwrite, ...)`) *when a pointer actually reaches the
  callee* — these permit a write, so nothing follows about the state as a whole.
  Going further would need alias reasoning about which locations the call may
  touch. Covered by `attr_writeonly` and `attr_argmem`.
- `inaccessiblememonly` — only touches memory the program cannot reach, so it
  arguably preserves the *observable* state, but spoq's `RData` does not draw
  that distinction. Two occurrences in the corpus; not worth the subtlety.

**Not yet implemented, would be sound and useful:**

- `noreturn` — control never continues past the call, so the continuation could
  be replaced by `None` outright. Today users hand-write this, e.g.
  `Definition exit_spec (v_0: Z) (st: RData) : (option RData) := None.`
- `willreturn` + `nounwind` (+ `mustprogress`) — the call returns normally,
  which could justify discharging the `None` branch at a call site.

**Not useful to spoq's model:** `nofree`, `nosync`, `nocallback`, `norecurse`,
`speculatable` — these constrain concurrency, recursion and allocator
behaviour that `RData` does not model.
