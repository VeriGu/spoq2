Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_esr_sign_extend_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_sign_extend_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (2097152)) <>? (0)), st)).

End Layer11_esr_sign_extend_LowSpec.

#[global] Hint Unfold esr_sign_extend_spec_low: spec.
