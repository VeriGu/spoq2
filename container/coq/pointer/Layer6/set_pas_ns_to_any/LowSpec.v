Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_set_pas_ns_to_any_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition set_pas_ns_to_any_spec_low (v_0: Z) (st: RData) : (option RData) :=
    when v_2, st_0 == ((monitor_call_spec 3288334592 v_0 0 0 0 0 0 st));
    (Some st_0).

End Layer6_set_pas_ns_to_any_LowSpec.

#[global] Hint Unfold set_pas_ns_to_any_spec_low: spec.
