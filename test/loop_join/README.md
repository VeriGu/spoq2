# Joins that merge a loop exit with a path that skipped the loop

## `buf_local_string_loop`

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
the two edges do not agree on what is in scope. Resolving the join's phis per
incoming edge has no notion of a value being live on only some of them, and the
emitted spec referenced `tmp_0` where only `tmp_0_after` was bound.

`bind_loop_results` (`include/SpoqIRModule.h`) closes that by binding each of a
loop's header phis and pass-in values to its `_after` name around the loop body,
so both edges of the join agree on the names in scope.

`SPOQ_CFG_CLONE_JOINS=1` gives each path its own copy of everything downstream
instead, which also passes and is the independent check on `.expected.json`.
