Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_esr_is_write_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_is_write_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (64)) <>? (0)), st)).

End Layer8_esr_is_write_LowSpec.

#[global] Hint Unfold esr_is_write_spec_low: spec.
