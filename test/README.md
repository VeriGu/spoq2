# spoq regression tests

`SpoqTest` is a GoogleTest driver, built as part of the default build. Because
the CMake target depends on `spoq`, building or running it always rebuilds the
executable under test first, and the path to it is baked in at configure time —
the tests can never run against a stale binary.

    make SpoqTest && ./build/SpoqTest      # all cases
    ./build/SpoqTest --gtest_filter=Spoq.attr_readonly
    ctest                                  # one ctest entry per case
    ctest -R attr_readonly

`SPOQ_TEST_ARGS` is appended to every spoq command line, so the suite can be
run under another solver configuration:

    SPOQ_TEST_ARGS=--race ctest

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
case's spoq run only, for a case that needs a knob such as `SPOQ_HOIST_BUDGET`,
and `args`, extra spoq options for that run.

An option is tested by running one fixture with and without it. A variant
`<test>.<variant>.expected.json` is a further case, `Spoq.<test>.<variant>`, on
the same `<test>.ll` and `<test>.main.v`; its `args` supply the option. The
`.race` variants run `--race` and require `race: true` in stderr, which spoq
prints when the option is in effect:

    test/soundness/precondition_weaker.expected.json        default solver
    test/soundness/precondition_weaker.race.expected.json   --race

An `unimplemented` marker turns every mismatch in its file into a skip. A value
that already holds for such a fixture is pinned in a variant without the marker
(`divzero_overflow_wrap.ub`), and a known wrong value in a variant with it
(`loop_invariant_inductive.ub`), so the rest of the file still fails on a change.

Every case that gives `impl_eliminates_ub: true` pins it.

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
| `attr_return_range` | `memory(none)`, `range(i32 0, 2)` on the result | `verified: true` | the patch returns the result if it is below 2 and 7 otherwise, which equals the vuln's result only within the range |
| `attr_return_range_control` | `memory(none)`, no range | `verified: false` | negative control for the range |

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

### Parameter attributes

The `attr_param_*` cases exercise `readonly`, `writeonly` and `nofree` on the
pointer parameters of a declaration, as the patchverification pipeline emits
them on outlined `pv_shared_*` functions. Each positive case fails without the
attribute; its control differs from it only in the attribute.

| test | callee | expected | why |
|---|---|---|---|
| `attr_param_readonly` | `memory(read, argmem: readwrite, ...)`, `ptr readonly`, `&g` passed | `verified: true` | the only pointer is not written through, so the callee is state-preserving; `attr_argmem` is the same without `readonly` |
| `attr_param_readonly_mixed` | the same, `ptr readonly` `&g` and `ptr` `&local` | `verified: true` | only `&local` is framed as written, so the globals are pinned |
| `attr_param_readonly_unframed` | `memory(readwrite)`, `ptr nofree readonly captures(none)` | `verified: false` | control: `readonly` forbids writes through the parameter, not to `g` directly |
| `attr_param_writeonly` | `memory(argmem: readwrite)`, `ptr writeonly`, `&g` passed | `verified: true` | vuln and patch store different values to `g` before the call; the callee cannot read `g`, so the call behaves the same in both |
| `attr_param_writeonly_control` | the same without `writeonly` | `verified: false` | control: the callee may read `g` |
| `attr_param_nofree` | `memory(argmem: readwrite)`, `ptr nofree`, argument pointer | `verified: true` | patch loads through `p` after the call; the block is still allocated with its size unchanged |
| `attr_param_nofree_control` | the same without `nofree` | `verified: false` | control: the callee may free `p`, so the load in patch may be undefined |

`classify_memory_attrs` applies each attribute only to argument memory, as
LangRef defines it:

- A `readonly` or `readnone` parameter is not written through. It is left out of
  the argmem frame, and if no written parameter remains the callee is Pure.
  Aliasing is sound: an object named by both a readonly and a written parameter
  is framed through the written one.
- A `writeonly` or `readnone` parameter is not read through. When the callee
  reads no "other" memory, it reads only through its remaining parameters, so
  the oracle is passed a view of the state with `globals` replaced by
  `<f>_view_globals` unless one of those parameters `is_global_ptr`. The layout of
  the globals is static, so the view keeps everything their definedness
  depends on. The heap and the stack are passed whole, because which of their
  objects exist is state. The oracle's post-state is computed from the view, so
  it cannot be the call's post-state. For an argmem callee that comes from
  `<f>_post_oracle` applied to the real state and is framed as before; for a
  Pure callee it is the pre-state.
- A `nofree` parameter only forbids frees through pointers based on it, so it
  is used only when every pointer parameter carries it (or the function is
  `nofree`), and only for an argmem callee. Such a callee cannot pass a pointer
  from other memory to a deallocator without writing other memory. Each written
  pointer then gets `spoq_nofree_room (post.(heap)) p =
  spoq_nofree_room (st.(heap)) p`, where `spoq_nofree_room` is
  `max_heap_ptr_offset` under a name marked DelayUnfold. The clause is a
  separate Rely from the frame. Unfolded, it is a match on the block in both
  states; conjoined with the frame, the transformer copied the frame into each
  arm, and the corpus projects that call `memcpy` ran about 2x slower.

`readonly` on a `memory(readwrite)` callee, as on `pv_shared_11`, says nothing
usable: the callee may reach the same object through a global.

The nofree fixtures take `p` as an argument and load through it before the call,
which establishes that the block exists. A block from `malloc` cannot be used
here: `malloc` inserts at key `nextBlock`, a load looks up `spvn (pvns
nextBlock)`, and no axiom relates the two. The writeonly fixtures use a global
rather than a local. After the call, a later store matches on the slot's
`StackVal` constructor in the post-state, which the callee leaves unconstrained.

`src/` holds the C the `.ll` files were compiled from, with
`clang -S -emit-llvm -fno-discard-value-names -O1 -Xclang -disable-llvm-passes`
(matching how `examples/synthetic` builds its IR). `attr_writeonly.ll` then has
`memory(write)` substituted by hand, since C has no attribute that spells it.
The `attr_param_*` files are then run through `opt -passes=mem2reg` and have
their function and parameter attributes substituted by hand.

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

## loop_identification/

A loop is a Fixpoint with postcondition `true`, so after two separately
translated loops the vuln and patch states are unrelated.  When the low spec of
`<base>_patch_loop_k` is alpha-equivalent to that of a `<base>_vuln_loop_j`,
`identify_patch_loops` (`project.cpp`) defines the patch loop as a call to the
vuln loop.  The log reports `Identified loop ...`.

| test | input | expected | discriminates |
|---|---|---|---|
| `loop_ident_equal` | same loop up to value and block names, guard added after it | `verified: true` | without identification the result is `false` |
| `loop_ident_nested` | the same with a nested loop | `verified: true` | the inner pair is matched together with the outer pair |
| `loop_ident_differ` | the patch loop adds `2 * pick()` | `verified: false` | the loops are not identified |

## stack_frame/

A stack slot whose provenance never escapes its function keeps its value across
a call whose arguments based on the slot are all `readonly`, `readnone` or
`byval`; the translator states this after each call.  The cases cover each
parameter attribute, several pointer parameters, derived pointers and each
`captures(...)` annotation.  The `join_slot_*` and `loop_slot_*` cases cover
forwarding a slot's value across joins and loops, and the `join_scope_*` cases,
with `unit/JoinScopeTest.cpp`, cover the scope checks on a forwarded value.  See
`stack_frame/README.md`.

## path_facts/

Path facts that decide conditions without Z3: a negated disjunction, such as an
unfolded `~ (is_stack_ptr p)`, refutes each of its disjuncts.  The cases check
that the stack arms of an access through `p` are pruned under the fact, and kept
without it or when `is_stack_ptr` is defined so that the fact excludes no slot.
See `path_facts/README.md`.

## loop_invariant_shared/

Loop pairs that identification leaves separate get a relational postcondition
(`shared_loop_inv.cpp`, design in `docs/shared_loop_invariant.md`).  Where the
refinement check meets a call of a vuln loop and of a patch loop on one path, it
infers by Houdini on the product of the two bodies a relation R of their
arguments, an exit-code mapping with related results E, the divergence
predicates Q and U, and adds the theorem at the two calls.  The log reports
`Shared loop invariant <patch> ~ <vuln>: R = {...}` or `No shared loop
invariant ...`, which the `stderr_contains` pins check.
`SPOQ_SHARED_LOOP_INV=0` disables the analysis; every `verified: true` case
below is then `false`.

| test | loops | expected | discriminates |
|---|---|---|---|
| `extra_param` | the patch loop carries `a`, which the vuln loop does not | `verified: true` | R leaves `a` free; E has `r'.a = a'` from the stable argument |
| `entry_differs` | `extra_param` with the patch accumulator starting at 1 | `verified: false` | `sum' = acc` fails at the call and leaves R |
| `added_continue` | the patch skips the iterations on which the vuln divides by zero | `verified: true` | the vuln path is None in the same iteration |
| `added_break_later_ub` | the patch breaks on `c < 0`; the vuln keeps iterating and exits to a division by zero | `verified: true` | U = `c < 0`; the vuln exits under U are diverged |
| `added_break_no_ub` | as above, but the vuln adds 1 and continues | `verified: false` | no vuln invariant holds where only the patch exits |
| `early_exit_ub_after` | the patch returns early at `x == 0`, where the vuln breaks to `100 / x` | `verified: true` | exit codes 0 -> 1, 1 -> 2; Q = `r.x = 0` |
| `early_exit_no_ub` | as above, but the vuln returns `x` after the break | `verified: false` | the same relation; the failure is at the diverged exit |
| `permuted_exits` | the same exits, numbered in the other order | `verified: true` | exit codes 0 -> 1, 1 -> 0 |
| `scaled_accumulator` | `loop_ident_differ` | `verified: false` | R has `sum' = 2*acc (mod 2^32)`; the patch's zero test differs under wrap |
| `unrelated_loops` | count up and add `pick()` vs. count down and add `2 * pick()` | `verified: false` | no relation |
| `patch_adds_ub` | the patch divides by zero where the vuln continues | `verified: false` | no relation |
| `nested_inner_differs` | outer loops differ only in their inner loops, which differ as in `extra_param` | `verified: true` | the inner relation is instantiated in the product of the outer loops |
| `stack_scratch_slot` | the patch loop writes a scratch stack slot `tmp`; both loops read the slot `keep` | `verified: true` | R has the stack equal outside `tmp`'s slot, and at `keep`'s |
| `stack_scratch_differs` | as above, but the patch loop writes `keep` | `verified: false` | the frame does not relate `keep` |
| `global_scratch` | the patch loop writes the global `dumb`; both read `keep` after the loop | `verified: true` | R relates `globals.g_keep` and not `globals.g_dumb` |
| `global_keep_clobbered` | the patch loop writes `keep` | `verified: false` | R does not relate `globals.g_keep` |

When R equates the states, it relates the parts of them too.  When the first
inference does not, it is repeated with the memory accessors (`load_RData`,
`store_RData` and what they call) inlined into the loop bodies, since folded
they are functions of the whole state.  The candidates are then the equality
of each record field of the state, and for the stack, which is indexed by
strings, equality outside a set of keys, equality at each key, and that a key
is allocated on either side.  The keys are the string constants of the bodies
and the `pbase` of each pointer argument.  The two stack cases set
`SPOQ_STACK_TYPING=1`: without typed slots, the patch's store to `tmp` may meet
a slot of another type and is None where the vuln continues, so
`stack_scratch_slot` is `false`.  Their postcondition relates the heaps and
globals only, since the stack is dead after the return.

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

**Used, at the call site.** Parameter `readonly` / `readnone` / `byval` and
`captures(...)` — together they show a call cannot write a caller's stack slot
whose provenance has not escaped. See `stack_frame/`.

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
