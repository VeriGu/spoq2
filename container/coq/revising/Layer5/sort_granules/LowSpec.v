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
    when st_0 == ((new_frame "sort_granules" st));
    when v__sroa_3, st_1 == ((alloc_stack "sort_granules" 24 8 st_0));
    when v__sroa_0_0_copyload, st_2 == ((load_RData 8 (ptr_offset v_0 40) st_1));
    when v__sroa_2_0_copyload, st_3 == ((load_RData 8 (ptr_offset v_0 48) st_2));
    when st_4 == ((llvm_memcpy_p0i8_p0i8_i64_spec v__sroa_3 (ptr_offset v_0 56) 24 false st_3));
    when v_10, st_5 == ((load_RData 8 (ptr_offset v_0 8) st_4));
    if ((v_10 - (v__sroa_2_0_copyload)) >? (0))
    then (sort_granules_0_low st_0 st_5 v_0 v_10 v__sroa_0_0_copyload v__sroa_2_0_copyload v__sroa_3)
    else (
      when st_8 == ((free_stack "sort_granules" st_0 st_5));
      (Some st_8)).

  Definition sort_granules_0_low (st_0: RData) (st_5: RData) (v_0: Ptr) (v_10: Z) (v__sroa_0_0_copyload: Z) (v__sroa_2_0_copyload: Z) (v__sroa_3: Ptr) : (option RData) :=
    rely ((((v_10 - (v__sroa_2_0_copyload)) >? (0)) = (true)));
    when st_6 == ((llvm_memcpy_p0i8_p0i8_i64_spec (ptr_offset v_0 40) v_0 40 false st_5));
    when st_8 == ((store_RData 8 v_0 v__sroa_0_0_copyload st_6));
    when st_9 == ((store_RData 8 (ptr_offset v_0 8) v__sroa_2_0_copyload st_8));
    when st_10 == ((llvm_memcpy_p0i8_p0i8_i64_spec (ptr_offset v_0 16) v__sroa_3 24 false st_9));
    when st_12 == ((free_stack "sort_granules" st_0 st_10));
    (Some st_12).

End Layer5_sort_granules_LowSpec.

#[global] Hint Unfold sort_granules_spec_low: spec.
#[global] Hint Unfold sort_granules_0_low: spec.
