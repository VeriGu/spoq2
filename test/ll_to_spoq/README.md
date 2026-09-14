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

Four fixtures, all run with the CFG pass for real (`run_cfg`) since they contain
loops. Two fail and are the fix target; two pass and guard the fix.

| fixture | |
|---|---|
| `loop_exit_join_body_value.ll` | **fails** -- one exit, `%add` left free |
| `loop_two_exits_body_value.ll` | **fails** -- two exits, `%sum` left free |
| `loop_two_exits_distinct_values.ll` | **fails** -- one value per exit, `%a` and `%b` left free |
| `nested_loop_inner_value_escapes.ll` | **fails** -- inner-loop value escaping two levels, `%prod` |
| `nested_loop_inner_value_via_outer_backedge.ll` | **fails** -- inner value escaping only via the outer backedge |
| `sibling_loops_value_via_header_phi.ll` | **fails** -- one loop's value as a sibling's header-phi initial value |
| `loop_exit_join_header_phi.ll` | passes -- pins the loop's call-site arity |
| `loop_exit_value_partial_dominance.ll` | passes -- value live on one exit path |
| `loop_header_phi_used_after_loop.ll` | passes -- pins the duplicate carry-out |
| `sibling_loops_value_used_directly.ll` | passes -- pins pass_out into a sibling's pass_in |

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

The failure: a join below the loop takes a value defined *inside* the body, and
nothing carries it out.

    let baseline_08 := baseline_08_after in
    let baseline_0_lcssa := add in

`pass_analysis` (`SpoqIRCFG.cpp:546`) skips PHI nodes when collecting operands,
so a value used only by a phi at a join below the loop is never recorded as a
`pass_out`, and the loop never returns it. `bind_loop_results` binds what the
loop returns, so it cannot help. Reduced from `luaG_getfuncline` in lua002, where
this aborts the run in `check_well_typed` with `Unknown symbol: add`.

Every case checks that the spec it emits closes over nothing but the function's
arguments and `st`, which is what makes this one fail here rather than much later.

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

## Integer to floating point

`translate_sitofp_double.ll` and `translate_sitofp_float.ll` round trip an
integer through a float and back. Both pass. The prelude every project shares
defines `Float := Z`, so the casts are no-ops on the spec side, as float-to-float
already was:

    let conv := n in
    let back := conv in

The pair exists because the widths used to diverge -- the branch reporting the
cast tested `isFloatTy`, a 32-bit float specifically, so a double fell through
to a catch-all and asserted. Float is one type in the spec language, so both
must now translate identically.

`translate_float_arithmetic.ll` puts an `fmul` between the two casts, which
under `Float := Z` is integer multiplication and prints as one. Reduced from
`fill_xyztables` in ffm001.

`translate_float_literal_local.ll` and `translate_float_literal_global.ll` cover
where the literals come from. The **local** one **fails**:
`FloatConst::to_string` prints the value in full, so an operand comes out as
`(4095.000000)`, which is not a term the spec language has under `Float := Z`.
That is as far as ffm001 gets. The **global** one passes and shows the other
case needs nothing: a load from a global yields an opaque Z, and the initialiser
belongs to the project's globals model rather than the function body.

## Where the float model gives out

`Float := Z` comes from the prelude every project shares, and the front end now
matches it. What that costs is marked in the source with `FLOAT MODEL`:

    git grep -n "FLOAT MODEL"

The points are: the type mapping (fractions, NaN, the infinities and rounding
are all outside the model), float arithmetic typed and printed as integer
arithmetic, both casts and the float-to-float cast as no-ops, and the constant
path, where z3_eval truncates toward zero while `FloatConst::to_string` prints
in full -- so the emitted spec and the solved one disagree on any literal that
is not already an integer. Rendering literals as integers would settle that
disagreement and make the local fixture pass, at the cost of silently turning
ffm001's 0.5 and 0.6 into 0. It is left visible instead.

`Float::FLOAT` still exists in C++ and maps to a 64-bit IEEE sort in z3, which
the prelude does not agree with. Nothing produces it now, but it is there to be
picked up by mistake.

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
