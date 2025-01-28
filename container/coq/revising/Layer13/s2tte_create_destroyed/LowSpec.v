Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_s2tte_create_destroyed_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_destroyed_spec_low (st: RData) : (option (Z * RData)) :=
    (Some (8, st)).

End Layer13_s2tte_create_destroyed_LowSpec.

#[global] Hint Unfold s2tte_create_destroyed_spec_low: spec.
