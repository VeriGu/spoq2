# LLVM IR -> Spoq IR fixtures

Inputs for the two unit tests that drive the front end directly from a `.ll`
file, with no project, `main.v` or solver:

| test | entry point | what it covers |
|---|---|---|
| `CfgConversionTest` | `control_flow_conversion_v2` | CFG normalisation |
| `IrTranslationTest` | `llvm_ir_to_spoq_ir` + `spoq_inst_to_spec` | translation to Spoq IR and on to SpecNodes, CFG pass **skipped** |

`IrTranslationTest` covers two stages, and they fail differently:

1. **`llvm_ir_to_spoq_ir`** -- CFG walk to a flat `spoq_inst_vec_t`. Does *not*
   interpret instructions; `dfs_llvm_ir_to_spoq_inst_vec` packs every non-branch
   instruction as an opaque `SpoqLLVMInst`, so this stage accepts anything the
   walk reaches.
2. **`spoq_inst_to_spec`** -- that vector to a `SpecNode`. This is where
   instructions are interpreted, so an unsupported opcode fails *here*. Needs a
   `Project` and `SpoqIRContext`; `make_minimal_project()` builds the smallest
   one that works (one `Layer` with an `abs_data` type, plus `cmds.StackMap`
   entries for any allocas -- that arm asserts on a missing entry).

Stage-2 assertions check the emitted SpecNode text, so a silently wrong
translation fails rather than passing on "something was produced":

    let sum := (a + (b)) in
    let prod := (sum * (3)) in
    ...
    (Some (masked, st))

Both run each case in a forked child with a deadline, so a hang or an `assert()`
is reported rather than taking the suite down, and both double as
`llvm-reduce` oracles (`--convert` / `--translate`).

## Translation fixtures

Straight-line and branching cases: `translate_straightline.ll`,
`translate_ifelse.ll` (arms return), `translate_memory.ll`
(alloca/store/load/GEP/global).

Join phis, resolved per incoming edge: `translate_ifelse_joinphi.ll`,
`translate_multi_phi.ll` (several phis at the top of one block, taken
simultaneously), `translate_multi_phi_three_preds.ll`.

Out of scope for the bypass: `nested_loop.ll`, which needs the
preheader/postheader rewrite the CFG pass performs. It doubles as the
`CfgConversionTest` sanity case.

### Joins below a loop exit

All run with the CFG pass for real (`run_cfg`) since they contain loops. All
pass. The first six were the fix target; the rest guard against overshooting it.

| fixture | |
|---|---|
| `loop_exit_join_body_value.ll` | one exit, `%add` used below it |
| `loop_two_exits_body_value.ll` | two exits, `%sum` used below them |
| `loop_two_exits_distinct_values.ll` | one value per exit, `%a` and `%b` |
| `nested_loop_inner_value_escapes.ll` | inner-loop value escaping two levels, `%prod` |
| `nested_loop_inner_value_via_outer_backedge.ll` | inner value escaping only via the outer backedge |
| `sibling_loops_value_via_header_phi.ll` | one loop's value as a sibling's header-phi initial value |
| `loop_exit_join_header_phi.ll` | pins the loop's call-site arity |
| `loop_exit_value_partial_dominance.ll` | value live on one exit path |
| `loop_header_phi_used_after_loop.ll` | pins the duplicate carry-out |
| `sibling_loops_value_used_directly.ll` | pins pass_out into a sibling's pass_in |

`nested_loop_inner_value_escapes.ll` is the closest reproduction of lua002: it
does not merely leave a free name in the spec but aborts in `check_well_typed`
with `Unknown symbol: prod`, the same assert lua002 hits. Nesting is what makes
the difference -- a Definition is built for the inner loop and type-checked
there and then.

The two nested fixtures pin opposite halves of a header phi. A header phi's
backedge operand is normally the loop's own carried value and needs nothing, but
in `nested_loop_inner_value_via_outer_backedge.ll` it is defined one level
deeper and has to be carried out of the inner loop first.

`sibling_loops_value_via_header_phi.ll` is why a fix cannot simply skip header
phis. A header phi's backedge operand is the loop's carried value and needs
nothing, but its preheader-edge operand is evaluated outside the loop and has to
be available there -- which, for a value defined in a sibling loop, means being
passed out of that one.

`loop_two_exits_distinct_values.ll` is the one that reaches the UndefValue
substitution in `update_loop_break_return_list`: `%a` is defined in the header
and dominates both exiting blocks, `%b` is defined in the latch and dominates
only itself, so the return list built for the early exit has to stand something
in for `%b`.

What they were reduced from: a join below the loop takes a value defined
*inside* the body, and nothing carried it out, leaving a name nothing binds.

    let baseline_08 := baseline_08_after in
    let baseline_0_lcssa := add in

`pass_analysis` skipped PHI nodes when collecting operands, so a value used only
by a phi at a join below the loop was never recorded as a `pass_out` and the
loop never returned it; `bind_loop_results` binds what the loop returns, so it
could not help. Reduced from `luaG_getfuncline` in lua002, where this aborted
the run in `check_well_typed` with `Unknown symbol: add`.

Every case checks that the spec it emits closes over nothing but the function's
arguments and `st`, which is what makes a regression here fail at translation
rather than much later.

`translate_select.ll` and `translate_select_chain.ll` cover `select`, which
`spoq_inst_to_spec` now translates directly to an `If`:

    let cmp := (x =? (50)) in
    let sel := (
        if cmp
        then 100
        else 200) in
    (Some (sel, st))

`control_flow_eliminate_select` (Phase 1), which rewrites a select into a
diamond with a join phi, is not called.

## Floating point

Floats are not modelled.  Every floating point computation is an application of
a declared, uninterpreted function, so a function containing one translates,
prints as valid Coq and reaches the solver -- which is the whole requirement:
verify behaviour *next to* float instructions, not behaviour that depends on
them.  An uninterpreted function is consistent with every real semantics, so
nothing that goes through is wrong because of floats; anything needing float
reasoning does not go through.

`Float := Z` stays, and not only because the preludes say so: it is the field
type of records the abstraction layer reads (ffm049's datatypes have twenty of
them).  What changed is that nothing is claimed about the values.

    let conv := (sitofp n) in
    let mul := (fmul conv float_lit_0x1p_1) in
    let back := (fptosi mul) in

| fixture | |
|---|---|
| `translate_sitofp_double.ll`, `translate_sitofp_float.ll` | the casts, and that width does not reach the spec -- the two must be character-identical |
| `translate_float_arithmetic.ll` | `fmul` between two casts, reduced from `fill_xyztables` in ffm001 |
| `translate_float_ops.ll` | every arithmetic opcode including `fneg` |
| `translate_float_cmp.ll` | eight `fcmp` predicates, ordered and unordered |
| `translate_float_intrinsic.ll` | `llvm.fabs` and `llvm.fmuladd` |
| `translate_float_literal_local.ll`, `translate_float_literal_shared.ll` | literals: one constant per value, no collisions |
| `translate_float_literal_global.ll` | a global initialiser, which does not reach the function's spec |

`test/float/float_adjacent_postcondition` is the acceptance case: a function
whose branch turns on a float comparison, with bounds on the return value that
hold whatever the floats do.  The branch cannot be decided, so both arms are
explored and the property has to hold on both.

### How it is decided

Not by listing opcodes.  The corpus has ~43,000 float instructions and a dozen
distinct intrinsics -- `fabs`, `fmuladd`, `round`, `floor`, `is.fpclass`, `pow`,
`lrint`, `sqrt`, `sin`, `exp`, `cos`, `ceil` -- and every gap in a list is a
fresh assert.  So `is_float_computation` asks whether the instruction is one of
the four computing classes (binary, unary, cast, compare) *and* touches a
floating point type.  That catches the six arithmetic opcodes, the six casts and
`fcmp` without naming them, and leaves a load, a store, a GEP, a phi or a select
over floats to their ordinary treatment -- those are operations on an opaque
value, not float computations.  Intrinsics get the same test on their argument
and result types.

The gate matters in both directions: without "touches a float" the catch-all
would swallow unhandled *integer* instructions and hide real gaps.

Names come from the opcode alone -- `fmul`, `fcmp_olt`, `llvm_fabs` -- never
from the containing function, which is the opposite of the function pointer
convention next door.  vuln and patch must call the *same* uninterpreted
function or no refinement proof could relate them.  Widths collapse for the same
reason `Float` is one type.

Literal names come from the exact bits (`float_lit_0x1p_1`), so one value is one
constant everywhere and neighbouring doubles do not merge -- which a printed
decimal does at the seventeenth digit.  Declarations go to `GlobalDefs`, the one
location every generated spec imports.

### What this does not do

No proof involving float magnitude, comparison or rounding.  Since `Float` *is*
`Z`, nothing stops a spec adding a float to an integer either; only an opaque
`Float` would, and that breaks every prelude record.

Every `fcmp` is an unresolvable branch, so both arms survive -- 93% of the
corpus's 5686 float comparisons are ordered relationals that can never be
decided.  That is no worse than any unknown integer condition, but there are a
lot of them.

Float *vectors* work through the same rule: `<4 x float>` maps to `ZMap Z` and
vector arithmetic is uninterpreted like the scalar kind.  Element access
(`extractelement` and friends) is still unsupported, but that gap is shared with
integer vectors and is not a float question.

## Calls through a function pointer

`translate_fptr_call.ll`. An indirect call becomes a call to
`<ptr>_<argc>_fptr_<caller>_spec`, applied to the pointer itself, then the
arguments, then the state:

    when call, st == ((fp_1_fptr_vuln_spec fp n st));

Translation succeeds and the fixture passes. Nothing defines that spec -- it is a
name the project supplies, as `ext_spec` is for an external declaration -- so a
full run stops at `unknown expr op`, which is where ffm054 ends once its
reconvergence problem is out of the way. The convention is pinned because it is
the interface a project writes against, and changing it would break every
hand-written function pointer spec with no error until z3_eval.

## switch

A switch is lowered to a chain of `icmp eq` + conditional branch before any
other phase runs (`lower_switches`, Phase 0), because nothing downstream reads a
`SwitchInst`: the traversals follow `BranchInst` successors, loop normalisation
asserts that an exiting block ends in a branch, and `spoq_inst_to_spec` has no
arm for one. The cases are mutually exclusive and nothing falls through, so
testing them one at a time is equivalent. All of these run with the CFG pass for
real (`run_cfg`), since without it the walk meets the switch itself.

| fixture | |
|---|---|
| `translate_switch.ll` | three cases and a default reconverging at one join |
| `switch_before_loop.ll` | the same with a loop below the join, as `decode_str` has |
| `switch_shared_case_targets.ll` | two cases sharing a target, so a phi there names the switch block twice |
| `switch_degenerate.ll` | `one_case`, `no_cases`, `case_is_default` -- the boundaries of the case list |
| `switch_in_loop_multi_exit.ll` | a switch inside a loop leaving by two different exits |
| `switch_default_unreachable.ll` | an exhaustive switch, whose default clang makes `unreachable` |
| `switch_arms_return.ll` | every arm returns, so there is no join at any level |

The lowered chain is a ladder, the shape `unrolled_ladder_before_loop.ll` pins:
the outermost test reconverges at the join and every inner one is declined for
not dominating the join's other predecessors, so each inherits the outer stop
and yields the join's phi values on its own edge. The code below the join is
emitted once.

    let sw_eq := (n =? (0)) in
    when r, st == (
        if sw_eq
        then (let a0 := (n + (10)) in (Some (a0, st)))
        else (
          let sw_eq1 := (n =? (1)) in
          if sw_eq1
          then (let a1 := (n + (20)) in (Some (a1, st)))
          else (Some (0, st))));
    let s := (r + (1)) in
    (Some (s, st))

Every edge out of the switch block becomes one edge out of one test block, so no
block gains or loses a predecessor: lowering creates no join and removes none.
The phi bookkeeping is what keeps that true. A target reached on two edges holds
two entries naming the switch block -- the verifier requires them to agree, so
there is one value to carry -- and after lowering those entries belong to
different test blocks. A case whose target is already the default's is dropped
instead of tested, which is the one place an edge does disappear.

`switch_default_unreachable.ll` pins a cost rather than a guarantee: the default
is on no path to the return, so nothing post-dominates the switch block, there is
no reconvergence point, and each arm walks the code below the join for itself.
Two cases is two copies.

## A branch reconverging at a loop preheader

| fixture | |
|---|---|
| `join_two_preds_before_loop.ll` | passes -- two arms meeting at the preheader |
| `join_three_preds_before_loop.ll` | passes -- three arms, as ffm021 has |
| `unrolled_ladder_before_loop.ll` | passes -- a ladder of early exits, as ffm054 has |
| `join_then_loop_preheader.ll` | passes -- a block between the join and the loop |

`usable_join` refuses a postheader, which from outside the loop looks like an
ordinary two-predecessor join but whose phis carry the loop's results and have to
be read through the pass-out list. It used to refuse preheaders as well, via
`can_remove`, which is false for both ends of the jump. A preheader is not like
that: its phis are ordinary ones merging the arms that reach the loop, and the
loop's own phis are in the header. Refusing them left each arm to walk into the
loop and emit it again, asserting on the second:

    Assertion `!context.has_loop_inst_for_jump(block)' failed.

Arity is not what decides it -- the two-arm case was declined for the join being
a preheader, the three-arm case for being neither a diamond nor a triangle.

`unrolled_ladder_before_loop.ll` separates the two causes. Its join has two
successors, so it is not a preheader, and only its shape is in the way: a chain
of early exits where each rung's taken edge goes to the next rung rather than to
the join, so no arm is a single block reaching it. ffm054 has this seventeen
rungs deep, from a fully unrolled search, with three seventeen-way phis at the
join. No enumeration of shapes catches that, which is why the reconvergence
point is now computed -- as the immediate post-dominator, accepted only when
every edge into it comes from a block the branch dominates -- rather than
matched. `join_then_loop_preheader.ll` separates the join from the loop header,
and passed throughout.

## A loop entered on two paths

| fixture | |
|---|---|
| `loop_preheader_on_two_paths.ll` | the minimal reproduction |
| `loop_preheader_on_two_paths_value_out.ll` | a value carried out of the loop and read below it |
| `loop_preheader_on_two_paths_multi_exit.ll` | two exits, so a selector to dispatch on at each call site |
| `loop_preheader_on_three_paths.ll` | three paths in, the arity ffm015 has |
| `loop_preheader_on_two_paths_nested.ll` | the duplicated preheader one level down, inside another loop |
| `loop_preheader_on_two_paths_two_loops.ll` | two loops each entered twice, so loop numbering is exercised |

All pass. They used to abort in the walk:

    Assertion `!context.has_loop_inst_for_jump(block)' failed.

Nothing makes the walk pass through the preheader once. `entry` reconverges
below the loop, not at the preheader, because one arm skips the loop entirely;
and the arm that can reach the preheader does not dominate its other
predecessor. So the walk enters the loop once per path.

That is correct in itself -- the loop runs on both paths, so the call belongs on
both. What could not be duplicated was the body: `loop_insts` maps a preheader
to one `spoq_inst_vec_t`, and `llvm_ir_to_spoq_ir` fills exactly one of them,
while `spoq_inst_to_spec` read each `SpoqLoopInst`'s own `body`. Registration
now keeps the first rather than the last, and the definition is built from the
body the context holds, so which instruction the walk reaches first no longer
decides anything.

Reached through switches in ffm015 (`decode_str`), where the block above the
preheader is reached from one case of an outer switch and two of an inner one,
and in ffm001's `sws_init_context`. Nothing about it is switch-specific: the
first fixture reproduces it in seventeen lines of plain branches.

The other five exist because the first cannot tell a correct fix from a
plausible one. Its loop returns nothing anyone reads, so simply deleting the
assert yields a closed, free-variable-clean spec whose top-level text is
byte-identical to the correct one -- only the definition differs:

    Fixpoint vuln_loop_0_low (m: Z) (i: Z) (sum: Z) ... :=
      (Some st).

Body dropped, no recursive call, ill-typed against its own return type. In a
build with `NDEBUG` that is what the assert was holding back. So every case
after the first reads the emitted definition rather than only the spec:
`expect_spec` takes an `out_defs` for that, and `--spec-cfg` prints the
definitions too. Deleting the assert alone satisfies the first fixture and fails
the other five, which is what they are for.

The nested case needs `out_defs` most: its duplication is entirely inside the
outer loop's `Fixpoint`, so the top-level spec -- which enters the outer loop
once -- shows none of it.

## Join points

`control_flow_clone_and_split` does not run. A join phi is resolved during
translation against the edge the walk arrived on, and when both arms of a branch
reconverge the arms stop at the join and the code after it is emitted once:

    %r = phi i32 [ %t, %then ], [ %e, %else ]

    let cmp := (a >? (b)) in
    when r, st == (
        if cmp
        then (let t := (a + (1)) in (Some (t, st)))
        else (let e := (b - (1)) in (Some (e, st))));
    (Some (r, st))

See `SpoqPhiInst` and `SpoqJoinInst` (`include/SpoqIR.h`), `reconvergence_point`
and the `SpoqIfInst` arm of `spoq_inst_to_spec`.

A chain of N diamonds therefore costs O(N) in both time and spec size.

### What `SPOQ_CFG_CLONE_JOINS=1` restores

Cloning removes a join point -- any block with two or more predecessors -- by
duplicating it and everything downstream of it, once per incoming edge, so that
no phi has more than one incoming value. Join points in sequence compound, and
the cost is not merely "exponential" but exactly

    clone steps(N) = 2^(N+2) - 4        for N sequential join points

measured by bisecting `SPOQ_CFG_REPEAT_LIMIT`. It does not hang; it runs until
the `repeats` budget is gone and throws "block size too large".

Nothing in the pipeline needs the switch; it exists so that cost stays
measurable, and `CfgConversion.JoinScaling.CloningCostIsTwoToTheNPlusTwo`
asserts the closed form through it.

**What counts is join points, not phi nodes.** `require_split`
(`SpoqIRModule.h:275`) ends in `pred_size(bb) >= 2` and never looks at phis, so
a diamond costs the same whether or not a value is merged at the bottom of it.
`CfgConversion.PhiNodesDoNotChangeTheCost` pins that.

| | cloning on | default |
|---|---|---|
| a chain of ~20 join points | exhausts the budget | converts |
| `ffm001_sws_init_context.ll` | throws, having consumed the budget | **converts** |
| `tiffillstrip.ll` | returns false, phi not eliminated | **converts** |
| `tiffillstrip_dup_phi_pred.ll` | returns false, phi not eliminated | **converts** |

`ffm001_single_block_valuename.ll` is a third case: one basic block, 51 `||`
short-circuit selects, no join points of its own. Selects translate directly to
an `If`, so it converts.

### Which branches reconverge

`reconvergence_point` is structural, and recognises two shapes: the diamond
(both arms a single block branching to a common join) and the triangle
(`if (c) { arm }`, where one successor is the join). Anything else -- an arm
with control flow of its own, or a join with three or more predecessors -- is
declined, and the walk runs each arm to its own return, duplicating whatever
follows. `translate_multi_phi_three_preds.ll` is an example of the fallback.

That fallback is still exponential in the number of declined branches, which is
why `sws_init_context_vuln` converts and then does not finish translating,
exhausting its memory cap. Widening the detector -- multi-block
arms via post-dominators, and joins with more than two predecessors -- is what
that case needs.

## tiffillstrip.ll

`TIFFFillStrip` and its callees, extracted from
`patchverification/examples/libtiff/tif003/build/tif_read.ll` with

    llvm-extract --func=TIFFFillStrip --recursive

Seven functions, small enough to run quickly where the full module is very slow.
It converts; kept as the real-world case for a five-way join, which under
`SPOQ_CFG_CLONE_JOINS=1` makes `control_flow_conversion_v2` return false (it
does not throw, so there is no `error:` line -- only
`[CFG] TIFFFillStrip not converted.`):

    phi:   %cond = phi i1 [ false, %if.then113 ], [ false, %if.then76 ],
                          [ false, %if.then107 ], [ true, %if.end131 ],
                          [ false, %if.then101 ]
    some PHI are not eliminated but required so

Cloning leaves that five-way join with several predecessors, so its phi cannot
be reduced to a single incoming value. Nothing requires it to be: the walk
resolves it against whichever of the five edges it arrived on.

`TIFFFillStrip` also contains two unreachable blocks -- `land.lhs.true` and
`if.then9`, both marked `; No predecessors!` -- and these are present in the
*original* module, not introduced by `llvm-extract`. Running
`opt -passes=unreachableblockelim` on the extracted module makes the failure go
away, so they are implicated, but see below: they are not on their own
sufficient.

## tiffillstrip_dup_phi_pred.ll

Produced by `llvm-reduce` from the above. It provoked the same error
message, but **by a different mechanism**, so it is kept separate rather than
treated as a minimisation of the first. It also converts now:

    if.then21:                        ; No predecessors!
      br i1 false, label %cleanup138, label %cleanup138
    cleanup138:                       ; preds = %if.then21, %if.then21, %entry
      %retval.3 = phi i32 [ 0, %entry ], [ 0, %if.then21 ], [ 0, %if.then21 ]

The conditional branch has both targets equal, so the phi has two incoming
entries from the *same* predecessor. The cloner split per predecessor edge and
could not collapse a duplicated one. Resolving per edge is indifferent to it:
LLVM's verifier rejects a phi that gives one predecessor two *different* values,
so taking the first entry for that predecessor is unambiguous.

## reproduce.sh

    ./reproduce.sh tiffillstrip.ll     # exit 0 = the failure is present

Builds a scratch project around the given module (it reuses a fixed `main.v`, so
it only varies the bitcode) and greps spoq's stderr. Also usable as an
`llvm-reduce --test=` interestingness script. The failure it greps for does not
occur by default, so it exits 1 unless `SPOQ_CFG_CLONE_JOINS=1` is set.

## Relationship to `SpoqTest`

These cases are deliberately *not* `SpoqTest` cases. That harness runs spoq
end to end and compares `<test>.expected.json`, which requires a clean exit and
a result JSON; several fixtures here abort or run for minutes. Driving the two
front-end entry points directly keeps them fast and attributes a failure to the
stage that caused it.

All of these pass.
