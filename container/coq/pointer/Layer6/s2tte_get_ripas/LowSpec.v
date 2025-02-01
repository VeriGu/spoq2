Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tte_get_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tte_get_ripas_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v__0, st_0 == (
        if ((v_0 & (64)) =? (0))
        then (Some (0, st))
        else (Some (1, st)));
    (Some (v__0, st_0)).

End Layer6_s2tte_get_ripas_LowSpec.

#[global] Hint Unfold s2tte_get_ripas_spec_low: spec.
