# stack_frame/

A call cannot write a stack slot of its caller unless it is given a pointer
based on the slot.  If the slot's provenance never escapes the caller, every
such pointer is an SSA value the caller derives from the alloca, so when each
argument derived from the slot is `readonly`, `readnone` or `byval`, the slot
holds the same value after the call.  The translator states this as
`rely (st'.(stack) @ "slot" = st.(stack) @ "slot")` after the call
(`slots_preserved_by` in `SpoqIRTranslator.cpp`) and logs
`[FRAME] <caller>: call to <callee>_spec preserves "<slot>" ...`.  No frame
is emitted for an external function whose spec `main.v` defines: the
definition states the call's effect exactly.

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
| callee spec defined in `main.v` | `defined_spec`: no frame line for `ext`, which the old rule framed |
| value across a join | `join_slot_value`: both arms leave `%x` holding `&g`, and the reload after the join is resolved; `join_slot_passthrough`: neither arm writes `%x`, and the reload reads the state before the If; `join_slot_nested`: the outer join's result is the state an inner join binds; `join_slot_outer`: a result updates a state bound by an earlier join outside the scrutinee; control `join_slot_differs`, where the arms disagree |
| scope of a forwarded value | controls `join_scope_arm_local`, `join_scope_global_name`, `join_scope_adjacent`, `join_scope_inner_rebind`, where the read must stay; `join_scope_body_rebinds`, which verifies only if the value is not moved under a rebinding |
| pointers loaded from memory | `noesc_load_store`, `noesc_inttoptr`: a store through a loaded pointer leaves `%x` alone; `noesc_group`: the same with an escaped slot `%z` of `%x`'s type, so the store's arm for that type stays and its key is resolved by the rely; control `noesc_escaped`, where `%x` escapes |
| callee spec synthesized from memory attributes | `attr_spec_writeback`: `@fill` is `memory(argmem: write)` and writes through a loaded pointer, and `%x` is written back after the call; control `attr_spec_writeback_control`, where `@fill` writes through `%x` |
| value across a loop | `loop_slot_preserved`: the loop writes only `%y`, and the reload of `%x` after the loop is resolved; control `loop_slot_written`, where the loop passes `%x` to a writable parameter |

Not covered: a call that may recurse into the caller gets no frame, because
spoq names slots per type and index rather than per activation.

The preserved slots a caller loads from are written back into the state after
the call, `st'.[stack] :< (st'.(stack) # "slot" == st.(stack) @ "slot")`, so a
later read reduces to the slot's earlier value.  At a join that keeps an If as
one bound state, a slot every arm writes with one value is read as that value
(`rule_forward_join_slots`); an arm that leaves the slot alone passes on the value it had before the If.  A result that is the state an inner
`when` binds has the value that inner term's results agree on.  The `join_slot_*` cases set
`SPOQ_HOIST_BUDGET=1` so the join is not duplicated into the arms; they are
written by hand rather than by `gen_cases.py`, as are the `loop_slot_*` cases.
`join_slot_outer` states its join shape directly as the spec of an external
function in `join_slot_outer.defs.v`: in C, the transformation's other rules
simplify the shape before the join rule sees it.  `mk_fixture.sh` replaces the
Parameters that a `<case>.defs.v` defines.

The `join_scope_*` cases state, in `.defs.v` specs, joins whose result values
name binders that differ between the result and the read: arm-local binders
that share a name (`arm_local`), an arm-local binder with the name of a global
Parameter (`global_name`), a rebinding in the body (`body_rebinds`), an
adjacent rebinding of the state (`adjacent`), and a rebinding of a base state
inside one arm (`inner_rebind`).  Each `body2_spec` is what forwarding the
value regardless of scope would give, so a forwarding that ignores scope makes
the first four verify and `body_rebinds` fail.  In a full run
eliminate_ambiguity renames shadowing binders apart before the rule runs,
except binders that share a name across sibling arms and binders with a
global's name, so only `arm_local` and `global_name` reach the rule with the
shadowing intact; `test/unit/JoinScopeTest.cpp` applies the rule directly to
each shape.

A loop's result state gets the same write-back for each slot no iteration
writes: no store in the loop goes through a pointer derived from the slot, and
no call in the loop may write it by the call rule.  A loop with an indirect
call, or a call that may recurse into the caller, preserves no slot.

## Regenerating

    python3 src/gen_cases.py .
    for f in *.ll; do PV_PIPELINE=<patchverification>/examples/pipeline src/mk_fixture.sh $f; done
    python3 src/gen_cases.py .

`mk_fixture.sh` assembles `main.v` as the patchverification pipeline does.

## Pointers loaded from memory

No memory ever holds a pointer with the provenance of an alloca whose address
does not escape, in any activation, so a load or an inttoptr cannot produce
one.  After each, the translator states
`rely (~ (p.(pbase) =s "s1") /\ ...)` for the slots the function loads from
whose allocas, under that name anywhere in the module, do not escape
(`[NOESC]` in the log).  Parameters get no such rely: a recursive call may
pass a slot of the same name down.  The join rule reads facts like this one,
and If conditions on the path, to decide whether a store with a symbolic key
`# (p.(pbase))` writes the slot it forwards.

The memory model's stores are `Hint DelayUnfold`, so for most of the
transformation a store is a folded call such as
`store_RData 1 (ptr_offset_inbounds q k st) 0 st`.  The join rule reads such a
call through a private copy of the called definition's current body, with the
arguments substituted (pre-unfolding); the spec is not changed.  A key such as
`(ptr_offset_inbounds q k st).(pbase)` is read the same way, through the
definitions' branches and the `mkPtr` constructor, as one of the terms it may
be (`q.(pbase)` or `"null"` here), and decided only if every one of them is
decided alike.  Nothing about the memory model is built into the rule: a
definition that changes what a store writes changes what the rule concludes,
and a Fixpoint, a definition hinted NoUnfold, or one over the size limit is
not read, so its call decides nothing.  `test/unit/JoinScopeTest.cpp` covers
these cases (`JoinScopePreUnfold.*`), including definitions that write the
slot or move a pointer's base.

A spec synthesized from a callee's memory attributes states the call's frame
only as a rely on the oracle's post-state, so the translator writes the frame
out after such a call as after any other (`attr_spec_writeback`); only a
Definition the user wrote gets none.  The transformation may still fold a
write-back into the post-state using that rely.  The join rule then reads a
state with no structure of its own through a fact on the path stating
`(T.(stack)) = M` of that state term (`JoinScopeOpaque.*` in
`test/unit/JoinScopeTest.cpp`).
