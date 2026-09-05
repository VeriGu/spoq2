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
callsite — which is both what the transformation phase can exploit and a fix for
a duplication bug: the old per-callsite emission wrote the `attr_argmem_frame`
frame three times, because `llvm.lifetime.start`/`end` also carry
`memory(argmem: readwrite)`.

A callee whose attributes say nothing usable is left exactly as `main.v` wrote
it — `attr_writeonly` still gets a bare `Parameter ext_wo_spec`. A callee the
user gave a real `Definition` is never rewritten either: a hand-written body
already says more than an attribute can.

This is narrower than the per-callsite version it replaces, deliberately. That
version also fired on calls to functions *defined* in the module, where the
attribute is redundant: spoq derives a spec from the body, which is strictly more
precise than any attribute. Only declarations, where there is no body to derive
from, get a synthesised one.

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
reason through an if-expression in the state itself. Both encodings were
implemented and pass all six tests; the Rely form is measurably cheaper —
10.1s/10.2s versus 11.1s/11.1s for the suite, with the difference concentrated
in `attr_argmem_frame`, the only case where the frame does real work.

Note this Rely survives the pipeline where the obvious one does not. Writing
preservation as `let st_pre := st in ... rely (st = st_pre)` is silently
eliminated: the `when` rebinds `st`, let-inlining captures it and the assumption
collapses to `st = st`. Here `st` is the wrapper's own parameter and `st_callee`
is a `when` binder over an opaque oracle call, so the two are distinct names that
nothing can inline together. Do not "simplify" the wrapper into returning
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

One field is deliberately **not** pinned here: `spec_has_ub`. It reads `true`
under demand-driven unfolding and `false` under eager, with `verified` and both
`impl_*` fields identical. The cause is the folded call itself: `helper_spec st`
is an uninterpreted `option`, so its `None` arm survives into the final spec and
the UB analysis counts it as possible spec UB -- a conservative verdict that
comes from not looking inside the callee, not from the program. It only appears
when a callee is genuinely never needed; anything the retry inlines loses the
artefact, which is why all 104 result fields across the 26 synthetic examples
are identical between the two modes. Whether the UB report should treat an
opaque callee's `None` as "unknown" rather than "UB" is an open design choice,
and this fixture stays out of it.

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
