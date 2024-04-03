Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableAux___find_lock_next_level_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_lock_next_level_spec_low (v_g_tbl: Ptr) (v_map_addr: Z) (v_level: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st == ((s2_addr_to_idx_spec v_map_addr v_level st));
    when v_call1, st == ((__find_next_level_idx_spec v_g_tbl v_call st));
    let v_cmp_not := (ptr_eqb v_call1 (mkPtr "null" 0)) in
    when st == (
        if v_cmp_not
        then (Some st)
        else (
          when st == ((granule_lock_spec v_call1 6 st));
          (Some st)));
    let __return__ := true in
    let __retval__ := v_call1 in
    (Some (__retval__, st)).

End TableAux___find_lock_next_level_LowSpec.

#[global] Hint Unfold __find_lock_next_level_spec_low: spec.
