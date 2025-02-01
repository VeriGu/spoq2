Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_granule_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_map_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_3, st_0 == ((granule_addr_spec_abs v_0 st));
    when v_4, st_1 == ((buffer_map_spec_abs v_1 v_3 false st_0));
    (Some (v_4, st_1)).

End Layer2_granule_map_LowSpec.

#[global] Hint Unfold granule_map_spec_low: spec.
