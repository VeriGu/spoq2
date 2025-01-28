Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_realm_ipa_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_size_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_2, st_0 == ((realm_ipa_bits_spec v_0 st));
    if (v_2 =? (64))
    then (Some ((- 1), st_0))
    else (
      when v_6, st_1 == ((realm_ipa_bits_spec v_0 st_0));
      (Some ((1 << (v_6)), st_1))).

End Layer8_realm_ipa_size_LowSpec.

#[global] Hint Unfold realm_ipa_size_spec_low: spec.
