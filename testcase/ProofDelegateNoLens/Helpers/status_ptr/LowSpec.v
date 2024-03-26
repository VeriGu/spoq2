Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_status_ptr_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition status_ptr_spec_low (v_status: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((v_status >= (0)) /\ ((GRANULES_BASE > (0)))));
    let v_conv := v_status in
    let v_mul := (0 - (v_conv)) in
    let v_0 := (int_to_ptr v_mul) in
    let __return__ := true in
    let __retval__ := v_0 in
    (Some (__retval__, st)).

End Helpers_status_ptr_LowSpec.

#[global] Hint Unfold status_ptr_spec_low: spec.
