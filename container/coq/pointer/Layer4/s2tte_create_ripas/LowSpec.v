Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer4_s2tte_create_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_create_ripas_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (Some (0, st))
    else (Some (64, st)).

End Layer4_s2tte_create_ripas_LowSpec.

#[global] Hint Unfold s2tte_create_ripas_spec_low: spec.
