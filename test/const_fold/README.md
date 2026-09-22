# Constant folding

`rule_simplify_expr` folds two integer constants by computing in `unsigned
long`. Both cases here are that computation disagreeing with the arithmetic the
spec denotes, and both report a skip.

| case | asks |
|---|---|
| `fold_mul_exceeds_64_bits` | a product wider than 64 bits is not reduced modulo 2^64 |
| `fold_shift_past_64_bits` | a shift by 64 or more is not taken modulo 64 |

Both use i128, because at i64 neither defect is observable: the folder's wrap at
2^64 is exactly what an i64 operation does, so the wrong arithmetic gives the
right answer. i128 is a width spoq does not reduce, so the operation is meant to
be exact and the two diverge.

The shift case cannot be fixed by folding more carefully -- 2^100 is not an
`IntConst` -- so a shift that wide has to be left unfolded.

A third defect on the same path is unreachable rather than wrong: the fold for a
unary minus computes `-std::get<unsigned long>(...)`, which on an unsigned
operand is `2^64 - v`, but the branch above it returns for a one-element MINUS
before `all_intconst` is reached. There is no case for it because there is no
way to reach it.
