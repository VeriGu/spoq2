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
| `hidden_ub_unfold_not_triggered_fail` | the retry's cost on a real case |

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

**This case still fails.** Kept as the fix target.

`peek_next_val(d, skip)` dereferences `d->next` only when `skip` is set, and
both entry points pass 0, so the UB is never reachable. Deciding that needs the
callee's body, so the retry fires.

With `SPOQ_EAGER_UNFOLD=1` it takes ~9s and produces the values in
`.expected.json`. By default it takes ~198s and then reports
`impl_eliminates_ub: true` where eager reports `false` -- so it fails on the
verdict, not only on the clock. The ctest timeout is 120s, well under 198s, so
in the suite it is reported as a timeout; run it directly to see the divergence.

### Where the time goes

Profiling (`perf record` ~4 minutes in) puts every sample under one call chain:

    finalize_project_v2 -> spec_prover -> inline_callee
      -> spec_transformer_v2 -> SpecRules::eliminate_ambiguity -> subst

`eliminate_ambiguity` recurses up to 45 deep and 72% of samples are under
`subst`. The call site is `projection.cpp`, in the `hoist_changed` branch --
resolved with `addr2line`, not inferred. The other two call sites in that
function cannot fire here: one is guarded by `still_unfolding`, and
`inline_callee` passes `unfold=false`.

Two things reduce that, both by renaming at the point a term moves rather than
repairing the whole body afterwards:

  - `rule_unfold_specs` renames the callee's binders as it copies them in.
  - `hoist_match_from_branch` renames as it moves terms under new binders.

Neither removes the repair call itself. It is not redundant: it also rebuilds
Rely/If/Match nodes, which re-derives their types, and `simple_if_by_z3` asserts
on those -- dropping it aborts seven of the other cases in this suite. What it
costs when it finds nothing left to rename is a `free_vars` walk per Match,
which is still quadratic in the length of a let-chain. That is the next thing to
fix if this case matters.
