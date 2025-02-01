Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_s2tte_is_assigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_assigned_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (4)), st)).

End Layer7_s2tte_is_assigned_LowSpec.

#[global] Hint Unfold s2tte_is_assigned_spec_low: spec.
