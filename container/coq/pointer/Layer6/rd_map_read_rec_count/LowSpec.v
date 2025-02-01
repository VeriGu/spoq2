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
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (("granule_data" = ("granule_data")));
    when v_5, st_3 == ((load_RData 64 (mkPtr "granule_data" ((v_0.(poffset)) + (8))) st));
    (Some (v_5, st_3)).

End Layer6_rd_map_read_rec_count_LowSpec.

#[global] Hint Unfold rd_map_read_rec_count_spec_low: spec.
