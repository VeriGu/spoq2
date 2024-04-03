Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_rec_ipa_size_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rec_ipa_size_spec_low (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    let v_ipa_bits := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((0 + (0))))))) in
    when v_0, st == ((load_RData 8 v_ipa_bits st));
    let v_shl := (1 << (v_0)) in
    let __return__ := true in
    let __retval__ := v_shl in
    (Some (__retval__, st)).

End Helpers_rec_ipa_size_LowSpec.

#[global] Hint Unfold rec_ipa_size_spec_low: spec.
