Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_vmpidr_is_valid_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition vmpidr_is_valid_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (18446742978476114160)) =? (0)), st)).

End Layer12_vmpidr_is_valid_LowSpec.

#[global] Hint Unfold vmpidr_is_valid_spec_low: spec.
