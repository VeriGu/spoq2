Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer2_granule_map_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_map_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (24)))));
    when v_3, st_0 == ((granule_addr_spec v_0 st));
    when v_4, st_1 == ((buffer_map_spec v_1 v_3 false st_0));
    rely ((((v_4.(pbase)) = ("granule_data")) /\ (((v_4.(poffset)) >= (0)))));
    (Some (v_4, st_1)).

End Layer2_granule_map_LowSpec.

#[global] Hint Unfold granule_map_spec_low: spec.
