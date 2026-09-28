# Poison from `getelementptr inbounds`

An `inbounds` GEP with a non-zero index is poison unless its base, and the
address after each offset, is an in-bounds address of the object the base is
based on (offset 0 to the object's size, the end included).  A load or store
through poison is UB.  A GEP without `inbounds` is address arithmetic: only
the address accessed has to be in bounds.

When the model defines `ptr_offset_inbounds (p: Ptr) (ofs: intSizeT) (st: RData)`,
spoq translates each non-zero step of an `inbounds` GEP into a call of it on
the previous step's result, and a GEP without `inbounds`, or with only
constant-zero indices, into `ptr_offset`.  The model in these fixtures, from
patchverification's `main_v_suffix_common.v`, returns `mkPtr "null" (-1)` for
poison; every load and store through a `"null"` base is None.

In each case `r` is a 16-byte heap object at offset 0 and `p` has `r`'s base.

| case | `p` | vuln | patch | asks |
|---|---|---|---|---|
| `gep_inbounds_negative_base_strict` | `r - 4` | `p[1]`, inbounds | `r[0]` | an inbounds GEP from an out-of-bounds base is UB even when its result is in bounds |
| `gep_noinbounds_negative_base_strict` | `r - 4` | `p[5]`, no inbounds | `p[1]`, no inbounds | a GEP without inbounds from an out-of-bounds base is defined when the access is in bounds |
| `gep_inbounds_negative_index_strict` | `r + 4` | `p[3]` | `p[j]`, `j = -1` | a negative index from an in-bounds base, landing in bounds, is defined |

Each expects `spec_has_ub`, `impl_eliminates_ub` and `verified` true and
`impl_has_non_spec_ub` false.  The negative index is an argument because
spoq's constant folding (`rules.cpp`) folds a negative constant as unsigned.
The C sources are in patchverification's `examples/synthetic/two_file_code`;
the second is compiled with `-fwrapv-pointer`, which makes clang emit GEPs
without `inbounds`.
