# ptrtoint

`ptrtoint` is where a program observes an address as a number. Forming a pointer
more than one element past its object is undefined, so an address outside the
width cannot arise from a defined program: the conversion carries that as an
obligation rather than narrowing, and an address that does not fit is reported
rather than silently reduced to one that aliases a real object.

| case | asks |
|---|---|
| `ptoi_address_fits` | a converted address is in `[0, 2^64)` |

The bound is 2^64-1 rather than 2^64 because `IntConst` holds an `unsigned
long`. It agrees with the memory model, which bounds a base plus its size by
2^64 (`IntPtrCast.ptr_int_base_range` in `coqlib/LayerSem/IRSem.v`).
