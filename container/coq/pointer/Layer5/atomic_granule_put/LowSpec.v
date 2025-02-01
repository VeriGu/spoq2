Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_atomic_granule_put_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_granule_put_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((atomic_add_64 (ptr_offset v_0 8) (- 1) st));
    (Some st_0).

End Layer5_atomic_granule_put_LowSpec.

#[global] Hint Unfold atomic_granule_put_spec_low: spec.
