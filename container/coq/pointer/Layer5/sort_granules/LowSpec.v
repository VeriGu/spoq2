Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_sort_granules_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition sort_granules_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v__sroa_0_0_copyload, st_4 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (40))) st));
    when v__sroa_2_0_copyload, st_5 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (48))) st_4));
    when v_10, st_7 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) st_5));
    if ((v_10 - (v__sroa_2_0_copyload)) >? (0))
    then (
      when st_9 == ((store_RData 8 v_0 v__sroa_0_0_copyload st_7));
      when st_10 == ((store_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) v__sroa_2_0_copyload st_9));
      (Some st_10))
    else (Some st_7).

End Layer5_sort_granules_LowSpec.

#[global] Hint Unfold sort_granules_spec_low: spec.
