Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_requested_ipa_bits_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition requested_ipa_bits_spec_low (v_p: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((v_p.(pbase)) = ("stack")));
    let v_features_0 := (ptr_offset v_p ((4096 * (0)) + ((0 + ((0 + (0))))))) in
    when v_0, st == ((load_RData 8 v_features_0 st));
    let v_1 := v_0 in
    let v_conv := (v_1 & (255)) in
    let __return__ := true in
    let __retval__ := v_conv in
    (Some (__retval__, st)).

End Helpers_requested_ipa_bits_LowSpec.

#[global] Hint Unfold requested_ipa_bits_spec_low: spec.
