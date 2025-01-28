Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.
Require Import Layer4.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_find_lock_granule_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition find_lock_granule_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
    when v_3, st_0 == ((find_granule_spec v_0 st));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (Some ((mkPtr "null" 0), st_0))
    else (
      when v_6, st_1 == ((granule_try_lock_spec v_3 v_1 st_0));
      if v_6
      then (Some (v_3, st_1))
      else (Some ((mkPtr "null" 0), st_1))).

End Layer5_find_lock_granule_LowSpec.

#[global] Hint Unfold find_lock_granule_spec_low: spec.
