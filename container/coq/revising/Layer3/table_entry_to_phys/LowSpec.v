Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3_table_entry_to_phys_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition table_entry_to_phys_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((addr_level_mask_spec v_0 3 st));
    (Some (v_2, st_0)).

End Layer3_table_entry_to_phys_LowSpec.

#[global] Hint Unfold table_entry_to_phys_spec_low: spec.
