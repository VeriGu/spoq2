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

`.expected.json` may also carry structural assertions against the generated Coq,
for properties the result JSON cannot express -- *how* a spec was produced, not
just whether it proved:

| key | meaning |
|---|---|
| `spec_v_definition` | the `Definition` whose body is inspected, in any generated `Spec.v` |
| `spec_v_contains` | `;`-separated substrings that must appear in that body |
| `spec_v_lacks` | `;`-separated substrings that must not |

It may also set `env`, `;`-separated `VAR=value` assignments applied to that
case's spoq run only, for a case that needs a knob such as `SPOQ_HOIST_BUDGET`.

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

### Where the attribute lands

A declaration has no body for the CFG pass to convert, so its spec reaches spoq
as a `Parameter f_spec` from `main.v` — an uninterpreted function about which
nothing is known. Where the attributes *do* say something, spoq demotes that
Parameter to an oracle and defines `f_spec` as a wrapper that calls the oracle
under a Rely carrying the attribute
(`SpoqIRModule::synthesize_attribute_specs`). `main.v` needs no change: callers
keep naming `f_spec` and now see the wrapper.

    Parameter ext_pure_oracle : RData -> (option (Z * RData)).

    Definition ext_pure_spec (st: RData) : (option (Z * RData)) :=
      when ret_value, st_callee == ((ext_pure_oracle st));
      rely ((st_callee = (st)));
      (Some (ret_value, st_callee)).

The property is stated once, at the function, rather than re-derived at every
callsite, which is what the transformation phase can exploit.

A callee whose attributes say nothing usable is left exactly as `main.v` wrote
it — `attr_writeonly` still gets a bare `Parameter ext_wo_spec`. A callee the
user gave a real `Definition` is never rewritten either: a hand-written body
already says more than an attribute can.

Only declarations get a synthesised spec. Where a function is defined in the
module, spoq derives a spec from the body, which is strictly more precise than
any attribute.

### What each test actually discriminates

`attr_readnone` and `attr_readonly` pin the coarse memory rule,
`attr_argmem_nopointers` the empty-argmem narrowing, and `attr_argmem_frame` the
three-way argmem frame. Each fails without the code it exercises.

`attr_writeonly` and `attr_argmem` are negative controls and cannot show the
feature works: `verified: false` is also what no attribute support produces.
They catch a future change that becomes
*unsoundly* aggressive — the plausible mistake being to read
`memory(read, argmem: readwrite, ...)` as read-only by taking the leading `read`
and missing the per-location override, which would flip them to `true`.

When argument memory is the only thing a callee may write, and there is exactly
one pointer argument, the post-call state is now *framed* rather than left
unconstrained — at most the object that pointer designates changes. The frame
mirrors `store_RData`'s own dispatch:

    rely (   ((~ (is_global_ptr p)) /\ (~ (is_stack_ptr p))
              /\ (st_callee.(heap) = (mkMEM ((st.(heap)).(blocks)
                                           # (spvn (p.(pbase)))
                                           == (((st_callee.(heap)).(blocks)) @ (spvn (p.(pbase)))))
                                          ((st.(heap)).(nextBlock))))
              /\ (st_callee.(stack) = st.(stack)) /\ (st_callee.(globals) = st.(globals)))
          \/ ((is_stack_ptr p)  /\ (st_callee.(heap) = st.(heap))  /\ (st_callee.(globals) = st.(globals)))
          \/ ((is_global_ptr p) /\ (st_callee.(heap) = st.(heap))  /\ (st_callee.(stack) = st.(stack))));
    (Some (ret_value, st_callee)).

Whichever region the pointer names is the only one that may differ; the other
two are pinned. The witness for "some block" is the callee's own block, so no
existential is needed, and `nextBlock` is pinned because an argmem-only callee
cannot allocate.

Stating this as an assumption rather than building the conditional into the
state keeps `st` a plain symbol, so later loads and stores are not forced to
reason through an if-expression in the state itself.

The two names matter: `st` is the wrapper's own parameter and `st_callee` is a
`when` binder over an opaque oracle call, so nothing can inline them together and
the Rely survives the pipeline. Do not "simplify" the wrapper into returning
`Some (ret_value, st)` — that would make the Rely redundant and then removable.

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

## demand_unfolding/

Spoq leaves calls to other functions' specs folded during transformation and
inlines one only when a proof fails without it (`UnfoldPolicy`, `unfold_calls_to`).
`unfold_not_needed` pins the *point* of that: a callee the proof does not need
must stay a call.

Both `vuln` and `patch` call `helper()` **first**, from the same state, so with
`helper_spec` uninterpreted its result is the same opaque term on both sides;
the divergence (`return g` vs `return 5`) happens afterwards on that shared state
and is decided by the store to `g` alone.  `helper` writes an unrelated global
`g2`.  The fixture asserts the entry body still names `helper_spec` as a call and
never mentions `g_g2`:

    Definition vuln_spec (st: RData) : (option (Z * RData)) :=
      when st_0 == ((helper_spec st));
      (Some (5, (st_0.[globals].[g_g] :< 5))).

The order of the call matters.  Had the call sat *between* the store and the
load, the opaque post-call state would hide `g` and the retry would (correctly)
unfold `helper` -- and the test could not pass.  The subroutine has to be
irrelevant even while uninterpreted, not merely irrelevant once its body is seen.

Discrimination: with `SPOQ_EAGER_UNFOLD=1` the proof still verifies but both
structural assertions fail (`helper_spec ` gone, `g_g2` present), so the test
distinguishes unfolding from provability rather than re-testing the verdict.

## Attribute disposition

Every function attribute appearing in the reference corpus
(`~/workspace/patchverification/examples`), and what spoq does with it:

**Used.** `memory(none)` / `readnone`, `memory(read)` / `readonly` — the callee
provably never writes, so its output state is its input state. The per-location
`memory(..., argmem: ...)` forms also qualify when the function has no pointer
parameter, since the callee then has no argument memory to write.

**Used, framed rather than preserved.** The per-location argmem forms when the
function has exactly one pointer parameter — at most the object that pointer
designates changes, and the rest of `RData` is pinned. See the frame above.

**Deliberately unused, unsound to exploit as-is:**

- `memory(write)` / `writeonly` — permits a write anywhere, so nothing follows
  about the state as a whole. Covered by `attr_writeonly`.
- The per-location argmem forms with *several* pointer parameters — the frame
  would have to permit all of the objects they name to change at once, which is
  not implemented.
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
