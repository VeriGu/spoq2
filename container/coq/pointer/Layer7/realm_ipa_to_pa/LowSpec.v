Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_realm_ipa_to_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_to_pa_spec_low (v_0: Ptr) (v_1: Z) (v_2: Ptr) (v_3: Ptr) (v_4: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_4.(pbase)) = ("stack_type_3")) /\ (((v_4.(poffset)) = (0)))));
    rely ((((v_3.(pbase)) = ("stack_type_4")) /\ (((v_3.(poffset)) = (0)))));
    rely ((((v_2.(pbase)) = ("stack_type_3__1")) /\ (((v_2.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    if ((v_1 & (4095)) =? (0))
    then (
      rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
      rely ((((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_1 mod (4096)) = (0)))));
      when v_7, st_3 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (48))) st));
      when v_8, st_4 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (64))) st_3));
      if (((v_1 - (v_7)) >=? (0)) && ((((v_8 + ((- 1))) - (v_1)) >=? (0))))
      then (
        when v_15_tmp, st_6 == ((load_RData 8 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (32))) st_4));
        when st_7 == ((granule_lock_spec (int_to_ptr v_15_tmp) 5 st_6));
        rely (((((((st_7.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
        when v_6, st_1 == ((load_RData 4 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (20))) st_7));
        rely (((((((st_1.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
        rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
        when v_10, st_5 == ((load_RData 4 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (16))) st_1));
        when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_15_tmp) v_6 v_10 v_1 3 st_5));
        rely ((((st_10.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
        when v__sroa_0_0_copyload_tmp, st_11 == ((load_RData 8 (mkPtr "stack_s_rtt_walk" 0) st_10));
        when v__sroa_4_0_copyload, st_12 == ((load_RData 8 (mkPtr "stack_s_rtt_walk" 8) st_11));
        when v__sroa_5_0_copyload, st_13 == ((load_RData 8 (mkPtr "stack_s_rtt_walk" 16) st_12));
        when st_15 == ((store_RData 8 v_3 v__sroa_0_0_copyload_tmp st_13));
        None)
      else (Some (1, st_4)))
    else (Some (1, st)).

End Layer7_realm_ipa_to_pa_LowSpec.

#[global] Hint Unfold realm_ipa_to_pa_spec_low: spec.
