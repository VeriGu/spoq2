Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_atomic_granule_put_release_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition atomic_granule_put_release_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((atomic_load_add_release_64_spec (ptr_offset v_0 8) (- 1) st));
    (Some st_0).

End Layer12_atomic_granule_put_release_LowSpec.

#[global] Hint Unfold atomic_granule_put_release_spec_low: spec.
