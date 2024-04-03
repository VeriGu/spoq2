Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEOps___find_next_level_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_next_level_idx_spec_low (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st == ((__table_get_entry_spec v_g_tbl v_idx st));
    when v_call2, st == ((entry_is_table_spec v_call st));
    when v_retval_0, st == (
        let v_retval_0 := (mkPtr "#" 0) in
        if v_call2
        then (
          when v_call3, st == ((table_entry_to_phys_spec v_call st));
          when v_call4, st == ((addr_to_granule_spec v_call3 st));
          let v_retval_0 := v_call4 in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := (mkPtr "null" 0) in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End S2TTEOps___find_next_level_idx_LowSpec.

#[global] Hint Unfold __find_next_level_idx_spec_low: spec.
