Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_rec_is_simd_allowed_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rec_is_simd_allowed_spec_low (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((rec_refcount_one st));
    rely ((rec_is_unlocked st));
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    let v_simd_allowed := (ptr_offset v_rec ((3272 * (0)) + ((1096 + ((16 + ((8 + (0))))))))) in
    when v_0, st == ((load_RData 1 v_simd_allowed st));
    let v_1 := (v_0 & (1)) in
    let v_tobool := (v_1 <>? (0)) in
    let __return__ := true in
    let __retval__ := v_tobool in
    (Some (__retval__, st)).

End Helpers_rec_is_simd_allowed_LowSpec.

#[global] Hint Unfold rec_is_simd_allowed_spec_low: spec.
