Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter set_tte_ns_abs : Z -> (RData -> (option RData)).

Parameter create_realm_token_para : Ptr -> (Ptr -> (Ptr -> (Ptr -> (RData -> Z)))).

Section Layer8_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_size_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when ret, st' == ((realm_ipa_bits_spec v_0 st));
    if (ret =? (64))
    then (Some ((1 << (64)), st))
    else (Some ((1 << (ret)), st)).

  Definition set_tte_ns_spec (v_0: Z) (st: RData) : (option RData) :=
    (Some st).

  Definition create_realm_token_spec (v_0: Ptr) (v_1: Ptr) (v_2: Ptr) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some ((create_realm_token_para v_0 v_1 v_2 v_3 st), st)).

  Definition granule_memzero_mapped_spec (v_0: Ptr) (st: RData) : (option RData) :=
    if ((((v_0.(pbase)) =s ("granule_data")) /\ (true)) /\ (((4096 - (GRANULE_SIZE)) =? (0))))
    then (
      (Some (st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) # ((v_0.(poffset)) / (4096)) == ((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).[g_norm] :< zero_granule_data)))))
    else (Some st).

End Layer8_Spec.

#[global] Hint Unfold realm_ipa_size_spec: spec.
#[global] Hint Unfold set_tte_ns_spec: spec.
#[global] Hint Unfold create_realm_token_spec: spec.
#[global] Hint Unfold granule_memzero_mapped_spec: spec.
