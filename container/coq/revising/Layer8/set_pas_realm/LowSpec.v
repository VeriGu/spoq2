Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_set_pas_realm_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition set_pas_realm_spec_low (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((monitor_call_spec 3288334592 v_0 0 0 0 0 0 st));
    (Some (v_2, st_0)).

End Layer8_set_pas_realm_LowSpec.

#[global] Hint Unfold set_pas_realm_spec_low: spec.
