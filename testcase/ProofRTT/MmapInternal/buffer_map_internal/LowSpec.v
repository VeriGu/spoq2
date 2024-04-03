Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MmapInternal_buffer_map_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition buffer_map_internal_spec_low (v_slot: Z) (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
    rely ((v_slot <= (24)));
    rely ((v_slot >= (0)));
    when v_call, st == ((slot_to_va_spec v_slot st));
    when v_call2, st == ((get_cached_llt_info_spec st));
    let v_cmp := (v_slot =? (0)) in
    let v_or := (
        if v_cmp
        then 1458
        else 434) in
    when v_call3, st == ((xlat_map_memory_page_with_attrs_spec v_call2 v_call v_addr v_or st));
    let v_cmp4_not := (v_call3 =? (0)) in
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_cmp4_not
        then (
          let v_0 := (int_to_ptr v_call) in
          let v_retval_0 := v_0 in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := (mkPtr "null" 0) in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End MmapInternal_buffer_map_internal_LowSpec.

#[global] Hint Unfold buffer_map_internal_spec_low: spec.
