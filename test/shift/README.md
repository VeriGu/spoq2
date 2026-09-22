# Shifts

A shift by a constant amount folds to a multiply or divide by an integer
literal, so only a variable amount exercises the shift itself.  Nothing else in
the test suite has one.

Z3's power is real-valued over the integers, so the integer encoding of a
variable shift left a real in the term.  A real reaching `wrapN` left the width
reduction uninterpreted under integer sorts and was a sort mismatch under
bitvector sorts.  Found in ffm021's `nsv_resync`, which shifts bytes read from
`avio_r8` by a computed amount.
