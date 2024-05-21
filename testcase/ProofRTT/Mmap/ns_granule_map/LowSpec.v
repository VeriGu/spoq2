Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Mmap_ns_granule_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_granule_map_spec_low (v_slot: Z) (v_granule: Ptr) (st: RData) : (option (Ptr * RData)) :=
    rely ((v_slot = (SLOT_NS)));
    when v_call, st == ((granule_addr_spec v_granule st));
    when v_call1, st == ((buffer_map_internal_spec v_slot v_call st));
    let __return__ := true in
    let __retval__ := v_call1 in
    (Some (__retval__, st)).

End Mmap_ns_granule_map_LowSpec.

#[global] Hint Unfold ns_granule_map_spec_low: spec.
