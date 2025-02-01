Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s1tte_pa_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s1tte_pa_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 & (281474976710655)) & (((- 1) << (12)))), st)).

End Layer6_s1tte_pa_LowSpec.

#[global] Hint Unfold s1tte_pa_spec_low: spec.
