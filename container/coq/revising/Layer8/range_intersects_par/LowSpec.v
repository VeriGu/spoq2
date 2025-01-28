Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_range_intersects_par_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition range_intersects_par_spec_low (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_5, st_0 == ((load_RData 8 (ptr_offset v_0 920) st));
    when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 928) st_0));
    when v_8, st_2 == ((ranges_intersect_spec v_5 v_7 v_1 v_2 st_1));
    (Some (v_8, st_2)).

End Layer8_range_intersects_par_LowSpec.

#[global] Hint Unfold range_intersects_par_spec_low: spec.
