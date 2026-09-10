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

The two stages are coupled by a precondition worth stating once: the translator
asserts that PHI nodes appear only in loop headers/postheaders
(`SpoqIRTranslator.cpp:132`). Getting rid of join phis is what
`control_flow_clone_and_split` does, by cloning the join point until nothing
merges there -- which is also why that pass blows up exponentially. So a fixture
with a join phi is in scope for `CfgConversionTest` but not for
`IrTranslationTest`.

## Translation fixtures

In scope for the CFG-pass bypass (no natural loops, no join phis):
`translate_straightline.ll`, `translate_ifelse.ll` (arms return),
`translate_memory.ll` (alloca/store/load/GEP/global).

Out of scope, kept to pin the boundaries: `translate_ifelse_joinphi.ll` (hits
the PHI assert) and `nested_loop.ll` (needs the preheader/postheader rewrite).
`nested_loop.ll` doubles as the `CfgConversionTest` sanity case, where it
converts in ~100ms.

`translate_select.ll` and `translate_select_chain.ll` cover `select`, which
`spoq_inst_to_spec` now translates directly to an `If`:

    let cmp := (x =? (50)) in
    let sel := (
        if cmp
        then 100
        else 200) in
    (Some (sel, st))

It used to be removed earlier instead, by `control_flow_eliminate_select`
(Phase 1), which rewrote each select into a diamond with a join phi. That is no
longer called -- see "Exponential block cloning" below for why.

## Exponential block cloning

`control_flow_clone_and_split` removes a join point -- any block with two or
more predecessors -- by cloning it and everything downstream of it. Join points
in sequence therefore compound. The cost is not merely "exponential" but exactly

    clone steps(N) = 2^(N+2) - 4        for N sequential join points

measured by bisecting `SPOQ_CFG_REPEAT_LIMIT` for N = 1..18: 4, 12, 28, 60, 124,
252, 508, 1020, ..., 1048572, a ratio of 2.000 from N = 12 up. The pass does not
hang; it runs until the `repeats` budget is gone and throws "block size too
large".

**What counts is join points, not phi nodes.** `require_split`
(`SpoqIRModule.h:275`) ends in `pred_size(bb) >= 2` and never looks at phis, so
a diamond costs the same whether or not a value is merged at the bottom of it.
`CfgConversion.PhiNodesDoNotChangeTheCost` pins that at the budget boundary,
where one clone step either way flips the verdict.

With the default budget of 10^7 steps:

| N join points | outcome | wall | peak RSS |
|---|---|---|---|
| 20 | converts | 13.0s | 2.1GB |
| 21 | converts | 26.7s | 4.2GB |
| 22 | **over budget** | 23.9s to give up | 4.4GB |

`ffm001_sws_init_context.ll` has 254 blocks, of which **91 are join points** (40
of them carrying a phi). At 2^93 clone steps no budget reaches it; it throws
after ~255s. Its 197 `select`s used to contribute -- Phase 1 rewrote each into a
diamond -- but selects are now translated directly, so what remains is the
function's own control flow.

`ffm001_single_block_valuename.ll` is the same story from the other side: one
basic block, 51 `||` short-circuit selects, no join points of its own. It took
~26s to reach the guard while Phase 1 was expanding selects, and **converts in
~0.1s now**. It is kept as the regression test for that, since it has no source
of join points other than selects.

### Measuring it yourself

    ./gen_join_chain.py 22 > chain22.ll        # N diamonds, no phis, no selects
    ./gen_join_chain.py 22 phi > chain22.ll    # same with phis, same cost

    ./join_scaling_sweep.sh 10000000 > join_scaling_10e6.csv   # production budget
    ./join_scaling_sweep.sh 1000000  > join_scaling_1e6.csv    # ~10x cheaper
    ./plot_join_scaling.py join_scaling.png \
        "budget 10^7 (default)=join_scaling_10e6.csv" \
        "budget 10^6=join_scaling_1e6.csv"

![conversion time vs join points](join_scaling.png)

The flat tails are the budget cap, not the input: past the cap the run reports
the time to *give up*, and the dotted lines are what completing would have cost
at the measured step rate (~314k steps/s). N = 30 would need ~3.8 hours.

`SPOQ_CFG_REPEAT_LIMIT` lowers the budget so an oracle gets a verdict in seconds
instead of ~256s; unset it keeps the 10^7 default. It is a sharp instrument and
easy to misuse: `sws_setColorspaceDetails` (48 blocks, same ffmpeg module)
genuinely converts and needs ~5x10^5 steps, so a budget below that would call a
healthy function broken. Anything reduced under a lowered budget has to be
re-checked against the default.

The `CfgConversion.JoinScaling` cases run at a budget of 10^5 and assert the
prediction two-sided -- small N must *fit* as well as large N must not. Only the
lower half pins the base to 2; without it, 3^N or N! would pass just as well.

## tiffillstrip.ll

`TIFFFillStrip` and its callees, extracted from
`patchverification/examples/libtiff/tif003/build/tif_read.ll` with

    llvm-extract --func=TIFFFillStrip --recursive

909 lines, 7 functions, reproduces in ~2s where the full module is very slow.
`control_flow_conversion_v2` returns false (it does not throw, so there is no
`error:` line -- only `[CFG] TIFFFillStrip not converted.`), from
`SpoqIRCFG.cpp:430`:

    phi:   %cond = phi i1 [ false, %if.then113 ], [ false, %if.then76 ],
                          [ false, %if.then107 ], [ true, %if.end131 ],
                          [ false, %if.then101 ]
    some PHI are not eliminated but required so

After Phase 3 cloning, this five-way join still has several predecessors, so its
phi cannot be reduced to a single incoming value.

`TIFFFillStrip` also contains two unreachable blocks -- `land.lhs.true` and
`if.then9`, both marked `; No predecessors!` -- and these are present in the
*original* module, not introduced by `llvm-extract`. Running
`opt -passes=unreachableblockelim` on the extracted module makes the failure go
away, so they are implicated, but see below: they are not on their own
sufficient.

## tiffillstrip_dup_phi_pred.ll

14 lines, produced by `llvm-reduce` from the above. It provokes the same error
message, but **by a different mechanism**, so it is kept separate rather than
treated as a minimisation of the first:

    if.then21:                        ; No predecessors!
      br i1 false, label %cleanup138, label %cleanup138
    cleanup138:                       ; preds = %if.then21, %if.then21, %entry
      %retval.3 = phi i32 [ 0, %entry ], [ 0, %if.then21 ], [ 0, %if.then21 ]

The conditional branch has both targets equal, so the phi has two incoming
entries from the *same* predecessor. The cloner splits per predecessor edge and
cannot collapse a duplicated one. The original `TIFFFillStrip` phi has five
*distinct* predecessors and no duplicates, so a fix for this case would not
necessarily fix that one.

Checked, so nobody repeats it: an unreachable predecessor feeding a phi at a
reachable join is **not** sufficient on its own -- that case converts fine.
So the first failure needs something beyond "has a dead block", still unidentified.

## reproduce.sh

    ./reproduce.sh tiffillstrip.ll     # exit 0 = the failure is present

Builds a scratch project around the given module (it reuses a fixed `main.v`, so
it only varies the bitcode) and greps spoq's stderr. Also usable as an
`llvm-reduce --test=` interestingness script.

## Relationship to `SpoqTest`

These cases are deliberately *not* `SpoqTest` cases. That harness runs spoq
end to end and compares `<test>.expected.json`, which requires a clean exit and
a result JSON; several fixtures here abort or run for minutes. Driving the two
front-end entry points directly keeps them fast and attributes a failure to the
stage that caused it.

Note that `CfgConversion.Ffm001SwsInitContextConverts` currently **fails** by
design -- it asserts the conversion should succeed, which is the fix target.
Everything else here passes.
