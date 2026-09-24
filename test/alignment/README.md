# Alignment-directed refinement

`!pv.align !{i64 N}` on an instruction gives the spec node translated from it
alignment index N. `simulate_by_traverse` steps the patch first when its head
has a lower index than the vuln's, or when only the vuln's head has one, so the
patch's inserted code is walked before the traversal returns to the aligned code.

| case | expected | asks |
|---|---|---|
| `align_cache_wrong_patch` | `verified: false` | a wrong patch is rejected when the vuln is walked once per patch branch |
| `align_cache_right_patch` | `verified: true` | the same traversal still proves a correct patch |

Both patches check `*pp` for null before the aligned `n < 64` branch, and the
vuln dereferences `*pp` on every path. Stepping the patch first walks the vuln
under both outcomes of that check. z3_eval decides the Ifs and Matches inside an
expression under the path condition and caches the value on the node. Under the
null outcome the vuln's inner load evaluates to None, so a value reused under
the non-null outcome makes the vuln look undefined there. The wrong patch's
`**pp + 1` then goes unchecked, and it verifies. Clearing both subtrees' cached
values at each patch-first step keeps the cases apart.

`SPOQ_HOIST_BUDGET=1` (the `env` key) keeps the inlined `load_RData` body inside
its Match's scrutinee instead of hoisting it into the spec tree; that is the
shape lua002 reaches at the default budget.
