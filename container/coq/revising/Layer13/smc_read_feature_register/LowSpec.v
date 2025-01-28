Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_read_feature_register_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_read_feature_register_spec_low (v_0: Z) (v_1: Ptr) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when v_4, st_0 == ((rmm_feature_register_0_value_spec st));
      when st_1 == ((store_RData 8 (ptr_offset v_1 8) v_4 st_0));
      when st_2 == ((store_RData 8 (ptr_offset v_1 0) 0 st_1));
      (Some st_2))
    else (
      when v_8, st_0 == ((pack_return_code_spec 1 1 st));
      when st_1 == ((store_RData 8 (ptr_offset v_1 0) v_8 st_0));
      (Some st_1)).

End Layer13_smc_read_feature_register_LowSpec.

#[global] Hint Unfold smc_read_feature_register_spec_low: spec.
