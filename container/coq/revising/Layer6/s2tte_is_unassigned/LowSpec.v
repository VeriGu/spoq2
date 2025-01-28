Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_is_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_is_unassigned_spec_low (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (0)), st)).

End Layer6_s2tte_is_unassigned_LowSpec.

#[global] Hint Unfold s2tte_is_unassigned_spec_low: spec.
