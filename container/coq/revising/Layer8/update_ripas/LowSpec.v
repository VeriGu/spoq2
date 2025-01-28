Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_update_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition update_ripas_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData 8 v_0 st));
    when v_5, st_1 == ((s2tte_is_table_spec v_4 v_1 st_0));
    if v_5
    then (Some (false, st_1))
    else (
      when v_8, st_2 == ((load_RData 8 v_0 st_1));
      when v_9, st_3 == ((s1tte_is_valid_spec v_8 v_1 st_2));
      if v_9
      then (
        if (v_2 =? (0))
        then (
          when v_13, st_4 == ((load_RData 8 v_0 st_3));
          when v_14, st_5 == ((s2tte_pa_spec v_13 v_1 st_4));
          when v_15, st_6 == ((s2tte_create_assigned_spec v_14 v_1 st_5));
          when st_7 == ((store_RData 8 v_0 v_15 st_6));
          (Some (true, st_7)))
        else (Some (true, st_3)))
      else (
        when v_18, st_4 == ((load_RData 8 v_0 st_3));
        when v_19, st_5 == ((s2tte_is_unassigned_spec v_18 st_4));
        if v_19
        then (
          when v_24, st_7 == ((s2tte_create_ripas_spec v_2 st_5));
          when v_25, st_8 == ((load_RData 8 v_0 st_7));
          when st_9 == ((store_RData 8 v_0 (v_25 |' (v_24)) st_8));
          (Some (true, st_9)))
        else (
          when v_21, st_6 == ((load_RData 8 v_0 st_5));
          when v_22, st_7 == ((s2tte_is_assigned_spec v_21 v_1 st_6));
          if v_22
          then (
            when v_24, st_9 == ((s2tte_create_ripas_spec v_2 st_7));
            when v_25, st_10 == ((load_RData 8 v_0 st_9));
            when st_11 == ((store_RData 8 v_0 (v_25 |' (v_24)) st_10));
            (Some (true, st_11)))
          else (Some (false, st_7))))).

End Layer8_update_ripas_LowSpec.

#[global] Hint Unfold update_ripas_spec_low: spec.
