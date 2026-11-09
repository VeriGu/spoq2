# state_validity_heap/

Struct validity predicates applied to heap memory (prototype).

`valid_<T>` in the assumptions makes an access of an invalid `<T>` UB.  For a
stack slot, `state_validity.py` applies it in `load_<T>`/`store_<T>`.
`state_validity.py --heap` applies it to the heap too, in two parts:

- Each top-level conjunct of `valid_<T>` that names one field `f` becomes
  `valid_field_<T>_f v`, a predicate of the field's value (a `Ptr` if the
  conjunct reads the field as `int_to_ptr (s.(f))`).  The translator makes an
  access of `f` through `getelementptr %T, p, 0, k` None unless it holds of the
  value loaded or stored.  This needs no decoding of the struct and holds with
  the memory accessors folded.
- A conjunct that names several fields becomes, for each field `f` it names,
  `valid_rel_<T>_f v p st`: the conjunct with `v` for `f` and, for each other
  field, the word of `p`'s heap block at `p`'s offset plus the field's, read at
  the field's width as a load does (true for a stack or global pointer or no
  block).  The translator makes an access of `f` None unless it holds of the
  value loaded or stored, the struct `p` (the field pointer less the field's
  offset: inside a loop only the values the loop uses are bound) and the state
  before the access, which a store leaves unchanged in the other fields.  An
  access of a field the conjunct does not name is not checked against it.

An invalid value is UB (None), not an assumption: a `rely` would discard the
path, so a patch that writes an invalid field would verify.

Each case's `main.v` is the synthetic `state_validity_reject_strict` one, with
`c` stated to be a heap pointer and, except in the `_nocheck` controls, the
`--heap` definitions appended.  `valid_s_cfg` is `1 <= n <= 1024` (per field),
or `a <= n` (two fields) in the `_whole` cases.

| test | program | expected |
|---|---|---|
| `heap_load_valid` | vuln returns 0 if `q->n` is outside the range, else 1; patch returns 1 | true: reading an invalid n is UB |
| `heap_load_nocheck` | the same without the `--heap` definitions | false |
| `heap_load_valid_diff` | vuln returns `q->n`, patch `q->n + 1` | false: the check does not hide a difference |
| `heap_load_whole` | vuln returns whether `q->a <= q->n`, patch 1 | true: reading an a or n with a above n is UB |
| `heap_load_whole_diff` | vuln returns `q->n`, patch `q->n + 1`, two-field predicate | false |
| `heap_store_valid` | both store `q->n = v`; vuln returns whether `v` is outside the range, patch 0 | true: writing an invalid n is UB in both |
| `heap_store_nocheck` | the same without the `--heap` definitions | false |
| `heap_store_patch_invalid` | vuln stores `v` if in range (5 otherwise), patch `v` | false: only the patch writes an invalid n |
| `heap_store_whole` | both store `q->a = v`; vuln returns whether `v > q->n`, patch 0 | true: writing an a above n is UB in both |
| `heap_store_whole_patch_invalid` | vuln stores `v` in `q->a` if `v <= q->n` (n otherwise), patch `v` | false: only the patch writes an a above n |
| `heap_load_narrow` | vuln loads the low byte of `q->n` as an i8 and returns whether it is 0, patch 1 | false: n = 256 is valid; an access at another type than the field's is not checked |

Not covered: an access of a field at a type other than the field's (a
narrower load, a union member, an array element), a load of field 0 through
the struct pointer itself (no getelementptr, so no type), a field of a nested
struct (`gep %T, p, 0, k, j`), a pointer into a stack slot at another offset
(`valid_rel_<T>_f` defers to the slot's accessor, which checks the slot's own
struct), and a conjunct that names a record or array field.
