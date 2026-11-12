# Lockstep refinement traversal

`simulate_by_traverse` steps an impl If or Match together with the spec's when
their condition or scrutinee is provably equal, resolving corresponding
patterns once. `SPOQ_NO_LOCKSTEP=1` disables this. `Hint NoTrans` on a high
spec also leaves its `_low` spec untransformed, and the traversal then hoists a
match out of its scrutinee (`hoist_match_root`) so the untransformed branches
can still be paired; `SPOQ_TRAVERSAL_HOIST_BUDGET` (default 2000) bounds the
number of these rewrites per run.

| case | expected | asks |
|---|---|---|
| `lockstep_renamed_binder` | `verified: true` | patterns equal up to the impl's renamed binders (`Some b` vs `Some b_5`) are resolved together |
| `lockstep_renamed_binder.no_lockstep` | `verified: true` | with `SPOQ_NO_LOCKSTEP=1` no pattern or branch is stepped together |
| `lockstep_notrans` | `verified: true` | `Hint NoTrans` on `vuln_spec`/`patch_spec` still verifies an identical pair |
| `lockstep_notrans_join` | `verified: true` | the untransformed specs' match-of-match is hoisted on both sides and then paired |
| `lockstep_notrans_join.no_hoist` | `verified: true` | with `SPOQ_TRAVERSAL_HOIST_BUDGET=0` the traversal hoists nothing |
| `lockstep_notrans_join_wrong` | `verified: false` | the same hoist rejects a patch that returns `v + 1` |
| `notrans_low_name` | `verified: true` | `Hint NoTrans` naming the `_low` spec skips only the low spec's transformation |
