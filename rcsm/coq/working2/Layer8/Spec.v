Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_size_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when ret, st' == ((realm_ipa_bits_spec v_0 st));
    if (ret =? (64))
    then (Some ((1 << (64)), st))
    else (Some ((1 << (ret)), st)).

  Definition data_create_s1_el1_0_low (st_0: RData) (st_7: RData) (v_25: Z) : (option (Z * RData)) :=
    rely (((v_25 =? (0)) = (true)));
    when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
    when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
    when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
    when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 4 st_11));
    when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
    (Some (((v_25 << (32)) >> (32)), st_15)).

  Definition granule_memzero_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (24)))));
    rely ((((v_0.(poffset)) >? (8388592)) = (false)));
    rely (
      (((((v_0.(poffset)) * (256)) >= (0)) /\ ((((- 2147483648) + (((v_0.(poffset)) * (256)))) < (0)))) /\
        ((((((v_0.(poffset)) * (256)) + (2147483648)) & (549755813888)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) * (256)) / (4096))).(g_granule_state)) - (v_1)) = (0)));
    (Some st).

End Layer8_Spec.

#[global] Hint Unfold realm_ipa_size_spec: spec.
#[global] Hint Unfold data_create_s1_el1_0_low: spec.
Opaque granule_memzero_spec.
