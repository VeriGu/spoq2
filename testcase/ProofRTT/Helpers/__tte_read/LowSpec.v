Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers___tte_read_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __tte_read_spec_low (v_ttep: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
    when v_call, st == ((__sca_read64_spec v_ttep st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End Helpers___tte_read_LowSpec.

#[global] Hint Unfold __tte_read_spec_low: spec.
