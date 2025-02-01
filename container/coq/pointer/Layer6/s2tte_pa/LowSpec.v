Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_pa_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_1 <? (3)) && (((v_0 & (3)) =? (3))))
    then (Some (((v_0 & (281474976710655)) & (((- 1) << (12)))), st))
    else (Some (((v_0 & (281474976710655)) & (((- 1) << (((((3 - (v_1)) * (9)) + (12)) & (4294967295)))))), st)).

End Layer6_s2tte_pa_LowSpec.

#[global] Hint Unfold s2tte_pa_spec_low: spec.
