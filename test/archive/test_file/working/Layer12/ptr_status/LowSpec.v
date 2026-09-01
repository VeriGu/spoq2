Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_ptr_status_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition ptr_status_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    let v_2 := (ptr_to_int v_0) in
    let v_3 := v_2 in
    let v_4 := (0 - (v_3)) in
    let __return__ := true in
    let __retval__ := v_4 in
    (Some (__retval__, st)).

End Layer12_ptr_status_LowSpec.

#[global] Hint Unfold ptr_status_spec_low: spec.
