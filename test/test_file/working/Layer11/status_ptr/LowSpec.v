Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_status_ptr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition status_ptr_spec_low (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    let v_2 := v_0 in
    let v_3 := (0 - (v_2)) in
    let v_4 := (int_to_ptr v_3) in
    let __return__ := true in
    let __retval__ := v_4 in
    (Some (__retval__, st)).

End Layer11_status_ptr_LowSpec.

#[global] Hint Unfold status_ptr_spec_low: spec.
