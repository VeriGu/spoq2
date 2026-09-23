# Machine integer range facts

spoq used to map every LLVM integer width to unbounded `Z` and every
integer-to-integer cast to the identity. These cases assert the facts a width
carries instead, and all seven pass. A cast is an explicit application:
`wrapN` truncates, `sextN_M` and `zextN_M` extend, so arithmetic after an
extension is at the destination width.

| case | asks |
|---|---|
| `int_zext_i8_range` | an i8 zero-extends to 0..255 |
| `int_trunc_i32_range` | a truncation to i32 lands in an i32's range |
| `int_trunc_wraps_to_zero` | `trunc i64 2^32 to i32` is 0, not 2^32 |
| `int_sext_i8_negative` | the two extensions of the i8 0xFF differ by 256 |
| `int_add_i32_wraps` | a sum of two i32 values is reduced to an i32's range |
| `int_trunc_divisor_zero` | png001's shape: the truncation is what makes a divisor zero |
| `int_bitand_masks` | `x & 255` lands in 0..255 |

The representation is two's complement with a signed residue: a value of LLVM
type iN lies in `[-2^(N-1), 2^(N-1))`. `int_sext_i8_negative` is the case that
pins it -- under an unsigned residue the same sign extension would be
4294967295. The others hold either way, since each asserts on a zero extension
or on a value the code itself produced.

`int_trunc_divisor_zero` needs both halves at once. The truncation has to be
modular for the vuln's divisor to reach zero, and an i32 and an i8 have to be
bounded for the patch's `width * channels + 1` to be at least 1. With one and
not the other the case is either two identical functions or a false positive on
negative widths.

They are branch-free by construction: `Hint Postcondition` states its query at a
leaf without the path condition that reaches it, so a value only reachable under
a guard cannot be pinned this way.

## Bitwise operations

`int_bitand_masks` is the only coverage of the bitwise operations, which are
uninterpreted functions over Z (`land`, `lor`, `lxor` in `values.cpp`) unless
they are encoded as bitvectors. Nothing in the synthetic corpus uses one. It
passes under both integer and bitvector sorts, and fails under
`SPOQ_Z3_BITVEC=0`, which is what turns that encoding off.

Measured over the 47-project corpus, all three give 30 True / 14 False / 3 ERR
with identical per-project verdicts:

| | corpus |
|---|---|
| default | 72 s |
| `SPOQ_BV_SORTS=1` | 75 s |
| `SPOQ_Z3_BITVEC=0` | 69 s |

The bitwise encoding is free because a mask is rare, and it is the only way the
solver learns anything about one.

## Why the bitvector sorts are off

`SPOQ_BV_SORTS=1` declares a width-carrying value at a bitvector sort instead of
converting at each use. It proves the same things, so the choice is about how
much the solver can see, and today it sees less. A value declared in a `.main.v`
-- an oracle result, a record field, a global -- is a `Z` and carries no width,
so it meets a width-carrying value constantly, and each meeting is a `bv2int` or
an `int2bv` that does not compose with the arithmetic around it. Over the corpus
that is 848 such conversions.

Closing that means giving the declarations widths: a Coq alias `intN := Z`
leaves the proofs unchanged, since it is convertible with `Z`, while the width
reaches the solver through the declared type. Measured on one project, typing
its record fields and the memory model's value slot takes it from 195
conversions to 0, with the verdict unchanged.

It has to be done for a whole project at once. Typing only the memory model
across the corpus moved the count the wrong way, from 848 to 2989: a bitvector
slot fed by a value that still arrives as `Z` needs an `int2bv`, so partial
typing relocates the conversions rather than removing them.
