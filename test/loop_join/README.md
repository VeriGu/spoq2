# Joins that merge a loop exit with a path that skipped the loop

## `buf_local_string_loop`

**This case currently fails.** Kept as the fix target.

    char vuln(unsigned int idx) {
        char string[] = "hello, world!";
        char tmp = -1;
        if (idx > 13)
            return tmp;              // never enters the loop
        for (i = 0; i < idx; i++)
            tmp = string[idx];
        return tmp;
    }

`cleanup` has `preds = {for.end, if.then}`: one edge comes out of the loop, the
other skipped it entirely. A loop's pass-out values only exist on the first, so
the two edges do not agree on what is in scope.

Cloning the join gives each path its own copy of everything downstream, which is
why the case works under `SPOQ_CFG_CLONE_JOINS=1`. By default joins are left in
place and their phis are resolved per incoming edge, and that has no notion of a
value being live on only some edges: the emitted spec references `tmp_0` where
only `tmp_0_after` is bound, and `check_well_typed` aborts with

    [ERR]: Unknown symbol: tmp_0

`reconvergence_point` and `SpoqPhiInst` (`src/frontend/SpoqIRTranslator.cpp`) are
where that would have to be decided -- neither currently looks at whether the
predecessors of a join sit at different loop depths.

Run it under `SPOQ_CFG_CLONE_JOINS=1` to see it pass, which is also the check
that `.expected.json` holds the right values.
