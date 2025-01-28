Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4___find_next_level_idx_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __find_next_level_idx_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_3, st_0 == ((__table_get_entry_spec v_0 v_1 st));
    when v_4, st_1 == ((entry_is_table_spec v_3 st_0));
    if v_4
    then (
      when v_7, st_2 == ((table_entry_to_phys_spec v_3 st_1));
      when v_8, st_3 == ((addr_to_granule_spec v_7 st_2));
      (Some (v_8, st_3)))
    else (Some ((mkPtr "null" 0), st_1)).

End Layer4___find_next_level_idx_LowSpec.

#[global] Hint Unfold __find_next_level_idx_spec_low: spec.
