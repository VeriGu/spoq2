Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_ptr_is_err_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ptr_is_err_spec_low (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    let v_2 := (ptr_gtb v_0 (int_to_ptr 18446744073709547520)) in
    let __return__ := true in
    let __retval__ := v_2 in
    (Some (__retval__, st)).

End Layer12_ptr_is_err_LowSpec.

#[global] Hint Unfold ptr_is_err_spec_low: spec.
