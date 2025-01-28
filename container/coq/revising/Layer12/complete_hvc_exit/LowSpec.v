Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_complete_hvc_exit_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition complete_hvc_exit_0_low (st_0: RData) (v_0: Ptr) (v_1: Ptr) (v_4: Z) : (option RData) :=
    rely ((((v_4 & (4227858432)) =? (1476395008)) = (true)));
    when v_9, st_1 == ((load_RData 8 (ptr_offset v_1 0) st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_0 24) v_9 st_1));
    when v_12, st_3 == ((load_RData 8 (ptr_offset v_1 8) st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_0 32) v_12 st_3));
    when v_15, st_5 == ((load_RData 8 (ptr_offset v_1 16) st_4));
    when st_6 == ((store_RData 8 (ptr_offset v_0 40) v_15 st_5));
    when v_18, st_7 == ((load_RData 8 (ptr_offset v_1 24) st_6));
    when st_8 == ((store_RData 8 (ptr_offset v_0 48) v_18 st_7));
    when v_21, st_9 == ((load_RData 8 (ptr_offset v_1 32) st_8));
    when st_10 == ((store_RData 8 (ptr_offset v_0 56) v_21 st_9));
    when v_24, st_11 == ((load_RData 8 (ptr_offset v_1 40) st_10));
    when st_12 == ((store_RData 8 (ptr_offset v_0 64) v_24 st_11));
    when v_27, st_13 == ((load_RData 8 (ptr_offset v_1 48) st_12));
    when st_14 == ((store_RData 8 (ptr_offset v_0 72) v_27 st_13));
    when st_15 == ((reset_last_run_info_spec v_0 st_14));
    (Some st_15).

  Definition complete_hvc_exit_spec_low (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 952) st));
    if ((v_4 & (4227858432)) =? (1476395008))
    then (complete_hvc_exit_0_low st_0 v_0 v_1 v_4)
    else (Some st_0).


End Layer12_complete_hvc_exit_LowSpec.

#[global] Hint Unfold complete_hvc_exit_spec_low: spec.
#[global] Hint Unfold complete_hvc_exit_0_low: spec.
