# Integer widths

`kMaxIntWidth` is 64. Three things bound it: `2^bits` has to be an `IntConst`,
which holds an `unsigned long`; the bitwise encoding assumes that width
(`kBitwiseWidth`); and there is no bitvector sort beyond it. A wider integer has
no faithful translation, so `SpecTypeOf::integer` rejects it rather than
producing a value that silently behaves as an unbounded one -- `wrapN` and the
range relies are both skipped above the limit, so the arithmetic would not
overflow where the machine does.

| case | asks |
|---|---|
| `int_width_too_wide` | an i128 is reported, not translated |

The rejection is a thrown `std::invalid_argument`, not an `assert`, so it fires
in a release build too, where `-DNDEBUG` would compile an assert out.

## A folding defect this makes unreachable

`rule_simplify_expr` folds two integer constants by computing in `unsigned
long`, so a result wider than 64 bits wraps at 2^64 and a shift amount of 64 or
more is taken modulo 64. Neither disagrees with the machine at i64 or narrower,
because there the folder's wrap is exactly what the operation does. Making them
observable took an i128 -- `mul i128 5000000000, 5000000000` and
`shl i128 1, 100` -- and that is now rejected at the type, so no LLVM input
reaches the defect. The arithmetic in the folder is still wrong; raising
`kMaxIntWidth`, or giving a wider integer any other path in, brings it back.
