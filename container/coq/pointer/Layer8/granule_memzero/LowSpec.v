Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_granule_memzero_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_memzero_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_3, st_0 == ((granule_map_spec v_0 v_1 st));
    when v_4, st_1 == ((memset_spec v_3 0 4096 st_0));
    (Some st_1).

End Layer8_granule_memzero_LowSpec.

#[global] Hint Unfold granule_memzero_spec_low: spec.
