# control_flow_conversion_v2 failures

Not yet wired into `SpoqTest`: both cases currently *fail*, and the harness has
no expected-failure marker. See the note at the bottom.

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

## Wiring these up

`SpoqTest` compares against `<test>.expected.json` and requires spoq to exit 0
with a result JSON. These cases make spoq abort, so they need either an
expected-failure marker in the harness or a fix first.
