# loop_pass/

Values a loop body uses from outside the loop become parameters of the loop's
Fixpoint (`pass_analysis`, `SpoqIRCFG.cpp`).

| test | input | expected | discriminates |
|---|---|---|---|
| `loop_ptrdiff_hoisted` | `p - dst` in a loop, with `ptrtoint ptr %dst` hoisted out of it by LICM | `verified: false`, `fill_loop_0` reads `dst.(poffset)` | the pointer difference is translated from `dst` rather than from the cast (`is_ptr_to_int`), so `dst` is a parameter; without it spoq stops at `Unknown symbol: dst` |
| `loop_ptrdiff_sunk` | `ptrtoint ptr %next` in the loop, `p - dst` after it (hand-written, not LCSSA) | `verified: false`, the result is `next.(poffset) - dst.(poffset)` | the loop passes out `%next`; without it spoq stops at `Unknown symbol` |
| `loop_pass_in_rebind` | a `do`-loop over `p` whose exit block has no predecessor outside the loop, then a load of `p[0]`; `InitRely ~(is_stack_ptr p)`, an escaped local `s` | `entry_sec0_vuln_spec` has the rely on `p` and no split of `p_after` against `stack_entry__s` | the loop returns its pass-in `p` unchanged as `p_after`; `bind_loop_results` (`SpoqIRModule.h`) rebinds only the header phis, so the code after the loop reads `p`, which the rely covers.  Rebinding `p := p_after` too would split the load on `p_after` being the slot `s` |

`loop_ptrdiff_hoisted` is `false` because the patch returns 0 for `n > 3`
where the vuln may return 1 without undefined behaviour; `loop_ptrdiff_sunk`
because the patch returns `n`, which differs from `p - dst` for `n <= 0`.
`loop_ptrdiff_hoisted.ll` is the output of the patchverification pipeline on
`src/`.

`loop_pass_in_rebind` is the libredwg CVE-2020-21827 symptom (`sec_dat_after_121` split against
stack slots after its unpaired outer loop), reduced; `.ll` is the patchverification pipeline's
output on `src/`, whose patch counts down so that the two loops are not outlined into one function.
