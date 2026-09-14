# Demand-driven unfolding

The transformation stage leaves a call to another function's spec folded, and
`z3_eval` encodes it as an uninterpreted function. When a proof then fails, the
verification driver inlines one specific callee into the already-transformed
body and re-checks (`inline_callee`, `inline_folded_scrutinee`). These cases
cover what that costs and when it is allowed to happen.

`SPOQ_EAGER_UNFOLD=1` unfolds every callee during the transformation instead,
which is the behaviour these cases are measured against.

| case | asks |
|---|---|
| `unfold_not_needed` | a proof that goes through with the callee left folded |
| `unfold_needed` | a proof that needs the callee, so the retry fires |
| `unfold_needed_nounfold` | the same, with `Hint NoUnfold` blocking the retry |
| `hidden_ub_unfold_not_triggered_fail` | the retry on a real case, against the eager result |

## `unfold_needed` / `unfold_needed_nounfold`

One module, two `.main.v` files differing only by

    Hint NoUnfold helper_spec.

`helper` writes the global `vuln` reads back, so the refinement cannot be
decided with it folded. Without the hint the retry inlines it and the proof
succeeds; with the hint the callee is never even deferred -- `rule_unfold_specs`
returns at the `NoUnfold` check, ahead of `UnfoldPolicy::defer` -- so no retry
candidate exists, and the proof is expected to fail with `helper_spec` still a
call in the emitted spec.

`unfold_not_needed` is the same shape with `helper` writing an unrelated global,
so its effect cancels and no retry is needed at all.

## `hidden_ub_unfold_not_triggered_fail`

`peek_next_val(d, skip)` dereferences `d->next` only when `skip` is set, and
both entry points pass 0, so the UB is never reachable. Deciding that needs the
callee's body, so the retry fires: it inlines `peek_next_val_spec` and re-checks.

Both modes agree on the values in `.expected.json`. The specs they reach are not
the same, though: the lazy one is substantially larger and keeps more `None`
branches, because `inline_callee` splices the callee into a body whose branch
structure was already fixed while the callee was opaque. The verdict agrees with
less slack than eager's.
