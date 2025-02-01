Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6___granule_get_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition __granule_get_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((atomic_granule_get_spec v_0 st));
    (Some st_0).

End Layer6___granule_get_LowSpec.

#[global] Hint Unfold __granule_get_spec_low: spec.
