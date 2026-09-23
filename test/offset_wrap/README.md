# 64-bit wraparound of pointer offsets

Under `SPOQ_BV_SORTS=1` a pointer offset and a block size are 64-bit
bitvectors; in Coq they are Z. A bounds check chain relies on Z arithmetic:
`off + 8 <= size` implies `off + 4 <= size`. In 64 bits it does not, because
`off + 8` wraps negative at `off = 2^63 - 8`, and the offset of a symbolic
pointer argument is unconstrained.

| case | asks |
|---|---|
| `offset_wrap_reordered_loads` | a patch that reads 8 bytes before 4 does not eliminate UB the vuln has |

`vuln` reads 4 bytes then 8 bytes at `d`; `patch` reads the 8 bytes first and
returns 0 when they are zero. Where the 4-byte read is out of bounds the 8-byte
read is too, so both have UB and `impl_eliminates_ub` is false. In bitvector
mode z3 picks the wrapping offset, the 8-byte read succeeds, the patch returns
0 on a path where the vuln has UB, and the field flips to true.

The memory model closes the hole without assuming anything about the
pointer: every block size is `rely (size_in_range bk_sz)`, below 2^62, and
the bounds test is written `p.(poffset) <=? bk_sz - sz` so the subtraction
is on the bounded side. `off <= size - 4` false and `off <= size - 16` true
is then unsatisfiable in 64 bits as in Z, and the case passes in both modes.
A pointer argument is not bounded: it may carry any value.
