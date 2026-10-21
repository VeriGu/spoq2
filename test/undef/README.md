# undef/

A scalar `undef` or `poison` is translated by type: an integer as 0, an `i1`
as `true`, a pointer as null, and a floating-point value as the declared
constant `undef_<type>` (`undef_double`), one per type.  Spoq itself passes
`undef` as the initial value of a loop's pass_out argument, which is never read.

| test | input | expected | discriminates |
|---|---|---|---|
| `undef_scalar_double` | a double pass_out of a loop, and `phi double [ %r, %a ], [ undef, %c ]` read only on the `%a` edge (mruby's fmt_fp) | `verified: true` | spoq stopped at `unsupported undef value encountered: double undef` |
| `undef_scalar_observed` | the patch returns the double `undef` where the vuln returns 0.0 | `verified: false` | `undef_double` is not equal to a literal |

All undefs of a type are one constant, which is more than LLVM says: a patch
that relies on two of them being equal is checked only where they are.
