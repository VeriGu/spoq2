# hints/

Hints (loop invariants, relies) whose evaluation by spoq was wrong.  Each
control differs from its case only in the construct that triggered the problem.

| test | hint | expected | cause (fixed) |
|---|---|---|---|
| `hint_match_infeasible_arm` | `Loop_inv` with a Prop-valued `match` on a heap block | `verified: true` | spoq aborts, `z3::sort::constructors(): Assertion is_datatype()`: `assume_callee_facts` (simulate.cpp) adds the invariant to the impl's Some arm of the loop call before checking that arm, which the vuln's None arm on the same call has made infeasible; `z3_eval` of the match then has no feasible arm and constructs `None` of the match's Prop type (z3_utils.cpp) |
| `hint_match_infeasible_arm_control` | the same invariant without the `match` | `verified: true` | passes |
| `hint_match_true_arm` | `Loop_inv` `(st = st_old) /\ blk_cell (st @ 0) = blk_cell (st_old @ 0)`, `blk_cell` a match unfolded into nested matches | invariant inductive, `verified: true` | reported not inductive: on an iteration that keeps `st`, the arm comparing the two cells simplifies to `true`, and `z3_eval` of a match replaces a `true` arm value by the next arm's value without its condition (the instantiate-Exists optimization), so the goal reads as "the cell is -1" |
| `hint_match_true_arm_control` | the same with the block in place of `blk_cell` of it | invariant inductive, `verified: true` | passes |
