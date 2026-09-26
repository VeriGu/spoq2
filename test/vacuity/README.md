# Vacuous refinements

`spec_reaches_some` and `impl_reaches_some` in the result report whether some
path the traversal did not prove unsat ends in a `Some` of the spec, and of the
impl. With neither, every covered path ends in `None` or is unreachable, and a
verified refinement is vacuous.

| case | asks |
|---|---|
| `always_none` | both sides fail on every path: verified, and neither reaches a Some |

`test/offset_wrap/offset_wrap_reordered_loads` pins the ordinary case, where
both sides reach a Some.
