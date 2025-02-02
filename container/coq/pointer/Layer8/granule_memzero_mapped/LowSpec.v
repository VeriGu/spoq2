Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_granule_memzero_mapped_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_memzero_mapped_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((memset_spec v_0 0 4096 st));
    (Some st_0).

End Layer8_granule_memzero_mapped_LowSpec.

#[global] Hint Unfold granule_memzero_mapped_spec_low: spec.
