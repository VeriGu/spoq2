Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_make_root_rtt_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_make_root_rtt_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((find_granule_spec v_0 st));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 22 st_0));
      (Some (v_4, st_1)))
    else (
      when v_7, st_1 == ((granule_try_lock_spec v_2 1 st_0));
      if v_7
      then (
        when v_9, st_2 == ((granule_map_spec v_2 1 st_1));
        when st_3 == ((s2tt_init_unassigned_spec v_9 1 st_2));
        when st_4 == ((granule_unlock_transition_spec v_2 5 st_3));
        (Some (0, st_4)))
      else (Some (0, st_1))).

End Layer9_rsi_data_make_root_rtt_LowSpec.

#[global] Hint Unfold rsi_data_make_root_rtt_spec_low: spec.
