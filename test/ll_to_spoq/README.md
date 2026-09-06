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
(`SpoqIRTranslator.cpp:132`). Removing join phis is exactly what
`control_flow_clone_and_split` does -- it clones the diamond until the phi is
gone -- which is also why that pass blows up exponentially. So a fixture with a
join phi is in scope for `CfgConversionTest` but not for `IrTranslationTest`.

## Translation fixtures

In scope for the CFG-pass bypass (no natural loops, no join phis):
`translate_straightline.ll`, `translate_ifelse.ll` (arms return),
`translate_memory.ll` (alloca/store/load/GEP/global).

Out of scope, kept to pin the boundaries: `translate_ifelse_joinphi.ll` (hits
the PHI assert) and `nested_loop.ll` (needs the preheader/postheader rewrite).
`nested_loop.ll` doubles as the `CfgConversionTest` sanity case, where it
converts in ~100ms.

`translate_select.ll` and `translate_select_chain.ll` cover `select`, and show
the two stages apart cleanly: both *pack* fine at stage 1, then hit

    Unsupported SpoqIR instruction [LLVM]:   %sel = select i1 %cmp, i32 100, i32 200

at stage 2 (`SpoqIRTranslator.cpp:1173`) -- `spoq_inst_to_spec` has no
`SelectInst` arm. A real run never gets there, because
`control_flow_eliminate_select` rewrites every select into a diamond first.

## Exponential block cloning

`ffm001_sws_init_context.ll` and `ffm001_single_block_valuename.ll` both reach
the `repeats > 10000000` guard in `control_flow_clone_and_split` and throw
"block size too large", after ~228s and ~26s respectively. Neither is a hang,
though both look like one under any ordinary timeout. Details in the file
headers.

The trigger is `select`. `control_flow_eliminate_select` rewrites every select
into a diamond with a join phi, and `control_flow_clone_and_split` clones
diamonds to remove those phis -- its own comment gives the cost as 2^N for N
sequential diamonds. The counts line up:

| fixture | selects | time to the guard |
|---|---|---|
| `ffm001_sws_init_context.ll` | 197 | ~228s |
| `ffm001_single_block_valuename.ll` | 51 (one block) | ~26s |

Which is also why a *single-basic-block* function can blow up: the block holds
51 `||` short-circuit selects. `translate_select_chain.ll` is the same shape at
four terms, small enough to convert instantly.

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

Note that the `CfgConversion` cases currently **fail** by design -- they assert
the conversion should succeed, which is the fix target. `IrTranslation` passes.
