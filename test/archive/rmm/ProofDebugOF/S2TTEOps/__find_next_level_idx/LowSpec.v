Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import S2TTEDesc.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEOps___find_next_level_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_next_level_idx_spec_low (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_call, st_0 == ((__table_get_entry_spec v_g_tbl v_idx st));
    when v_call2, st_1 == ((entry_is_table_spec v_call st_0));
    if v_call2
    then (
      when v_call3, st_2 == ((table_entry_to_phys_spec v_call st_1));
      when v_call4, st_3 == ((addr_to_granule_spec v_call3 st_2));
      (Some (v_call4, st_3)))
    else (Some ((mkPtr "null" 0), st_1)).

End S2TTEOps___find_next_level_idx_LowSpec.

#[global] Hint Unfold __find_next_level_idx_spec_low: spec.
