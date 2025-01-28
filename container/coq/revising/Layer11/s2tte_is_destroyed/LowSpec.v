Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer11_s2tte_is_destroyed_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_destroyed_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (8)), st)).

End Layer11_s2tte_is_destroyed_LowSpec.

#[global] Hint Unfold s2tte_is_destroyed_spec_low: spec.
