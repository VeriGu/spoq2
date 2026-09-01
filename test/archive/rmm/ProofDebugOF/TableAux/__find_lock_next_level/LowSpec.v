Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import Helpers.Spec.
Require Import S2TTEOps.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section TableAux___find_lock_next_level_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_lock_next_level_spec_low (v_g_tbl: Ptr) (v_map_addr: Z) (v_level: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((s2_addr_to_idx_spec v_map_addr v_level st));
    when v_call1, st_1 == ((__find_next_level_idx_spec v_g_tbl v_call st_0));
    if (ptr_eqb v_call1 (mkPtr "null" 0))
    then (Some (v_call1, st_1))
    else (
      when st_2 == ((granule_lock_spec v_call1 6 st_1));
      (Some (v_call1, st_2))).

End TableAux___find_lock_next_level_LowSpec.

#[global] Hint Unfold __find_lock_next_level_spec_low: spec.
