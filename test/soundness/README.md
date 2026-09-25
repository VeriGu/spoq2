# Soundness of the refinement check

Each `*_wrong_*`, `precondition_*`, `loop_invariant_false`, `return_type_mismatch`
and `parse_error` case is a patch or a specification spoq must not report as
verified; each `*_right_*` or `loop_invariant_inductive` companion is the
nearest correct one, which the fix must still prove.

| case | expected | what it guards |
|---|---|---|
| `cache_forward_wrong_patch` / `_right_patch` | false / true | a value z3_eval decided under one vuln leaf's path condition is not reused under another (`SPOQ_HOIST_BUDGET=1` keeps the If inside a scrutinee, where z3_eval decides it) |
| `unfold_path_wrong_patch` / `_right_patch` | false / true | demand unfolding simplifies a callee under the failing path only, on a copy, not in the shared tree |
| `precondition_unsat` | false | an unsatisfiable precondition leaves no initial state; that is not a proof |
| `precondition_weaker` | false | the check starts both sides from one state, so a precondition that relates unequal states is refused |
| `parse_error` | error | a syntax error stops spoq instead of being recovered by dropping a token |
| `args_swapped_wrong_patch` / `_right_patch` | false / true | the two functions' arguments correspond by position, not by name |
| `args_extra_param_wrong_patch` / `_right_patch` | false / true | a parameter only the patch takes is free, and distinct from a vuln parameter of the same name |
| `return_type_mismatch` | false | functions with different return types are refused |
| `loop_invariant_false` / `_inductive` | false / true | a loop invariant the refinement assumes is checked first |
| `rebind_after_call` | true, UB eliminated | a pattern that re-binds a name in scope, here the call result state `when st == (step_spec st)`, is a new variable: the loads before and after the call read different states |
| `rebound_state_call` | false | the result state of a call bound as `st` is not the entry state: a patch that skips the call changes the final state |
| `postcond_call_result` | true | a loop result bound by a pattern is the loop's result, with the invariant assumed of it, so two applications of one loop to the same arguments agree |
| `srem_pow2_*`, `srem_other_*`, `sdiv_pow2_*`, `sdiv_other_*` | false / true | `srem` and `sdiv` truncate toward zero, as LLVM defines them, in both sort modes and for divisors that are and are not powers of two |

The result cache and the parsing of raced solver output have unit tests in
`test/unit/Z3UtilsTest.cpp`: the cache is keyed by the exact query, not a hash
of it, and a raced answer is the last line of output, exactly `sat` or `unsat`.
