Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_realm_ipa_bits_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_bits_spec_low (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    let v_ipa_bits := (ptr_offset v_rd ((456 * (0)) + ((16 + ((0 + (0))))))) in
    when v_0, st == ((load_RData 4 v_ipa_bits st));
    let v_conv := v_0 in
    let __return__ := true in
    let __retval__ := v_conv in
    (Some (__retval__, st)).

End Helpers_realm_ipa_bits_LowSpec.

#[global] Hint Unfold realm_ipa_bits_spec_low: spec.
