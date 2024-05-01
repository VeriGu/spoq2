Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import Mmap.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEDesc___table_get_entry_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __table_get_entry_spec_low (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g_tbl.(pbase)) = ("granules")));
    when v_call, st == ((granule_map_spec v_g_tbl 22 st));
    let v_0 := v_call in
    let v_arrayidx := (ptr_offset v_0 ((8 * (v_idx)) + (0))) in
    when v_call2, st == ((__tte_read_spec v_arrayidx st));
    when st == ((buffer_unmap_spec v_call st));
    let __return__ := true in
    let __retval__ := v_call2 in
    (Some (__retval__, st)).

End S2TTEDesc___table_get_entry_LowSpec.

#[global] Hint Unfold __table_get_entry_spec_low: spec.
