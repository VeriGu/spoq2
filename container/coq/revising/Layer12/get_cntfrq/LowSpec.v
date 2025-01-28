Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_get_cntfrq_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_cntfrq_spec_low (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((iasm_33_spec st));
    (Some (v_1, st_0)).

End Layer12_get_cntfrq_LowSpec.

#[global] Hint Unfold get_cntfrq_spec_low: spec.
