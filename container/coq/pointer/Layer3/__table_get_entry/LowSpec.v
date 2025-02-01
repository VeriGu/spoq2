Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer3___table_get_entry_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __table_get_entry_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((granule_map_spec v_0 6 st));
    when v_6, st_1 == ((__tte_read_spec (ptr_offset v_3 (8 * (v_1))) st_0));
    (Some (v_6, st_1)).

End Layer3___table_get_entry_LowSpec.

#[global] Hint Unfold __table_get_entry_spec_low: spec.
