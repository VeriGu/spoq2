# stack_frame/

A call cannot write a stack slot of its caller unless it is given a pointer
based on the slot.  If the slot's provenance never escapes the caller, every
such pointer is an SSA value the caller derives from the alloca, so when each
argument derived from the slot is `readonly`, `readnone` or `byval`, the slot
holds the same value after the call.  The translator states this as
`rely (st'.(stack) @ "slot" = st.(stack) @ "slot")` after the call
(`slots_preserved_by` in `SpoqIRTranslator.cpp`) and logs
`[FRAME] <caller>: call to <callee>_spec preserves "<slot>" ...`.

The provenance escapes if a derived pointer is stored, returned, converted to
an integer, or passed to a parameter whose `captures(...)` grant full provenance
outside the return value.  `read_provenance` and address-only captures grant no
write; `captures(ret: ..., provenance)` makes the call's result a derived pointer.

Each case stores 5 into `%x`, calls an external `@ext` that has no memory
attributes, and reads `%x` back: `f_vuln` returns what it read, `f_patch`
returns 5, so the refinement holds exactly when the call is known not to write
`%x`.  `&x` is first passed to `@init(ptr captures(none))`, which is writable:
otherwise SROA promotes `%x`, as it does an alloca whose only call uses are
`readonly captures(none)`, and the load is forwarded before spoq sees it.
Every `verified: true` case fails without the rule.  The `verified: false` cases
are negative controls; each pins that `%x`'s slot is not in the frame line.

| group | cases |
|---|---|
| attribute on the one parameter | `param_readonly`, `param_readnone`, `param_byval`, `callsite_readonly`; controls `param_writable`, `param_writeonly` |
| `&x` not passed | `not_passed_other_slot`, `not_passed_no_args` |
| several pointer parameters | `two_params_x_readonly`, `two_params_both_readonly`; controls `two_params_x_writable`, `two_params_same_slot` |
| pointers derived from `&x` | `gep_readonly`, `select_readonly`; controls `gep_alias_writable`, `select_writable`, `phi_writable` |
| pointers that cannot be based on `%x` | `loaded_ptr_writable`, `global_ptr_writable`, `arg_ptr_writable` |
| escape before the call | controls `escape_store`, `escape_ptrtoint` |
| `captures(...)` of an earlier call | `capture_none`, `capture_address`, `capture_address_is_null`, `capture_read_provenance`, `capture_ret_readonly`, `capture_ret_address`; controls `capture_default`, `capture_provenance`, `capture_ret_writable` |
| slot value types | `ptr_slot_readonly`, `array_slot_readonly`; control `array_slot_writable` |

Not covered: a call that may recurse into the caller gets no frame, because
spoq names slots per type and index rather than per activation.

## Regenerating

    python3 src/gen_cases.py .
    for f in *.ll; do PV_PIPELINE=<patchverification>/examples/pipeline src/mk_fixture.sh $f; done
    python3 src/gen_cases.py .

`mk_fixture.sh` assembles `main.v` as the patchverification pipeline does.
