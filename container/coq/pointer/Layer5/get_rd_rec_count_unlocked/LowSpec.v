Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer5_get_rd_rec_count_unlocked_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition get_rd_rec_count_unlocked_spec_low (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((v_0.(pbase)) = ("granule_data")));
    when v_3, st_0 == ((load_RData 64 (mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))) st));
    (Some (v_3, st_0)).

End Layer5_get_rd_rec_count_unlocked_LowSpec.

#[global] Hint Unfold get_rd_rec_count_unlocked_spec_low: spec.
