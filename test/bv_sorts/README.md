# Bitvector-sort encoding failures

Cases whose integer-sort answer is pinned and which fail only under
`SPOQ_BV_SORTS=1`, marked `unimplemented_bv_sorts` so the bitvector run
reports a skip with the reason until they are fixed.

| case | asks |
|---|---|
| `heap_ptr_eq_as_int` | a pointer comparison, reloaded from the heap and returned as an int, keeps its width |

`heap_ptr_eq_as_int`: `zext (icmp eq ptr ...)` is translated as
`if cond then 1 else 0` with widthless literals.  Where the condition is an
uninterpreted `ptr_eqb` call, the `ite` reaches the `int32` return slot as an
unbounded integer and spoq aborts with "Z value reaches a (_ BitVec 32) slot".
The same comparison on argument pointers, or on a stack slot, folds during
transformation and does not reach the slot as a term.
