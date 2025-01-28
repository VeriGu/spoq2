Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Spec.
Require Import Layer4.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_data_create_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_data_create_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when v_5, st_0 == ((find_granule_spec v_3 st));
    rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (
      when v_7, st_1 == ((pack_return_code_spec 1 4 st_0));
      (Some (v_7, st_1)))
    else (
      if ((v_1 & (1)) =? (0))
      then (
        when v_15, st_1 == ((data_create_spec v_0 v_1 v_2 v_5 st_0));
        (Some (((v_15 << (32)) >> (32)), st_1)))
      else (
        when v_13, st_1 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 v_5 st_0));
        (Some (((v_13 << (32)) >> (32)), st_1)))).

End Layer13_smc_data_create_LowSpec.

#[global] Hint Unfold smc_data_create_spec_low: spec.
