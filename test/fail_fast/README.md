# fail_fast

With `fail_fast` (the default) the refinement traversal returns at the first
leaf that does not verify; `--no-fail-fast` visits every branch.  A failed
result then carries `spec_has_ub`, `impl_eliminates_ub` and
`impl_has_non_spec_ub` only for the leaves visited, so fixtures that pin these
flags on a result that does not verify run with `--no-fail-fast`.

| case | expected | asks |
|---|---|---|
| `fail_fast_first_branch` | `verified: false` | the then leaf fails and the else leaf is not visited |
| `fail_fast_first_branch.no_fail_fast` | `verified: false` | with `--no-fail-fast` both leaves are visited |
