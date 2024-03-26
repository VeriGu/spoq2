Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_rec_simd_type_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rec_simd_type_spec_low (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((rec_refcount_one st));
    rely ((rec_is_unlocked st));
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    let v_sve_enabled := (ptr_offset v_rec ((3272 * (0)) + ((880 + ((40 + (0))))))) in
    when v_0, st == ((load_RData 1 v_sve_enabled st));
    let v_1 := (v_0 & (1)) in
    let v_tobool_not := (v_1 =? (0)) in
    when v_retval_0, st == (
        let v_retval_0 := 0 in
        if v_tobool_not
        then (
          let v_retval_0 := 1 in
          (Some (v_retval_0, st)))
        else (
          let v_retval_0 := 2 in
          (Some (v_retval_0, st))));
    let __return__ := true in
    let __retval__ := v_retval_0 in
    (Some (__retval__, st)).

End Helpers_rec_simd_type_LowSpec.

#[global] Hint Unfold rec_simd_type_spec_low: spec.
