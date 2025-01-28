Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_rd_map_read_rec_count_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rd_map_read_rec_count_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_2, st_0 == ((granule_map_spec v_0 2 st));
    when v_4, st_1 == ((get_rd_rec_count_unlocked_spec v_2 st_0));
    (Some (v_4, st_1)).

End Layer6_rd_map_read_rec_count_LowSpec.

#[global] Hint Unfold rd_map_read_rec_count_spec_low: spec.
