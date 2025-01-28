Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_data_create_unknown_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_data_create_unknown_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_1 & (1)) =? (0))
    then (
      when v_9, st_0 == ((data_create_spec v_0 v_1 v_2 (mkPtr "null" 0) st));
      (Some (v_9, st_0)))
    else (
      when v_7, st_0 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 (mkPtr "null" 0) st));
      (Some (v_7, st_0))).

End Layer13_smc_data_create_unknown_LowSpec.

#[global] Hint Unfold smc_data_create_unknown_spec_low: spec.
