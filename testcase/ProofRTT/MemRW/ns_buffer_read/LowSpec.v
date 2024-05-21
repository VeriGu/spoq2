Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MemRW_ns_buffer_read_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ns_buffer_read_spec_low (v_slot: Z) (v_ns_gr: Ptr) (v_offset: Z) (v_size: Z) (v_dest: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((v_offset = (0)));
    rely ((((v_ns_gr.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_ns_gr.(pbase)) = ("granules")));
    rely ((v_slot = (SLOT_NS)));
    let v_0 := (v_offset & (4095)) in
    when v_call, st == ((ns_granule_map_spec v_slot v_ns_gr st));
    let v_1 := (ptr_to_int v_call) in
    let v_conv3 := v_0 in
    let v_add := (v_1 + (v_conv3)) in
    let v_2 := (int_to_ptr v_add) in
    let v_conv4 := v_size in
    when v_call5, st == ((memcpy_ns_read_spec v_dest v_2 v_conv4 st));
    when st == ((ns_buffer_unmap_spec v_call st));
    let __return__ := true in
    let __retval__ := v_call5 in
    (Some (__retval__, st)).

End MemRW_ns_buffer_read_LowSpec.

#[global] Hint Unfold ns_buffer_read_spec_low: spec.
