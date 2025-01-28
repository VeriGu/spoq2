Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_map_extra_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_map_extra_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((s1tte_pa_spec v_2 st));
    when v_5, st_1 == ((find_lock_granule_spec v_4 4 st_0));
    rely (((((v_5.(poffset)) mod (16)) = (0)) /\ (((v_5.(poffset)) >= (0)))));
    rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (
      when v_7, st_2 == ((pack_return_code_spec 1 3 st_1));
      (Some (v_7, st_2)))
    else (
      when v_11, st_2 == ((find_lock_granule_spec v_0 5 st_1));
      rely (((((v_11.(poffset)) mod (16)) = (0)) /\ (((v_11.(poffset)) >= (0)))));
      rely ((((v_11.(pbase)) = ("granules")) \/ (((v_11.(pbase)) = ("null")))));
      if (ptr_eqb v_11 (mkPtr "null" 0))
      then (
        when v_13, st_3 == ((pack_return_code_spec 1 2 st_2));
        (Some (v_13, st_3)))
      else (
        when v_16, st_3 == ((data_create_internal_spec v_2 v_11 v_1 (mkPtr "null" 0) (mkPtr "null" 0) 0 st_2));
        when st_4 == ((granule_unlock_spec v_5 st_3));
        (Some (((v_16 << (32)) >> (32)), st_4)))).

End Layer9_rsi_data_map_extra_LowSpec.

#[global] Hint Unfold rsi_data_map_extra_spec_low: spec.
