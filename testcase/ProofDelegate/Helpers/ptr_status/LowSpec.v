Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_ptr_status_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ptr_status_spec_low (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_ptr.(pbase)) = ("status")) \/ (((v_ptr.(pbase)) = ("null")))));
    let v_0 := (ptr_to_int v_ptr) in
    let v_1 := v_0 in
    let v_conv := (0 - (v_1)) in
    let __return__ := true in
    let __retval__ := v_conv in
    (Some (__retval__, st)).

End Helpers_ptr_status_LowSpec.

#[global] Hint Unfold ptr_status_spec_low: spec.
