Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_esr_sixty_four_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition esr_sixty_four_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (32768)) <>? (0)), st)).

End Layer11_esr_sixty_four_LowSpec.

#[global] Hint Unfold esr_sixty_four_spec_low: spec.
