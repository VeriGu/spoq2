Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEPA.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTEOps_s2tte_create_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_unassigned_spec_low (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
    when v_call, st == ((s2tte_create_ripas_spec v_ripas st));
    let __return__ := true in
    let __retval__ := v_call in
    (Some (__retval__, st)).

End S2TTEOps_s2tte_create_unassigned_LowSpec.

#[global] Hint Unfold s2tte_create_unassigned_spec_low: spec.
