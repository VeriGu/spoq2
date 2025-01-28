Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_set_ttbr0_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_set_ttbr0_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((find_lock_granule_spec (v_1 & (281474976710654)) 5 st));
    rely (((((v_4.(poffset)) mod (16)) = (0)) /\ (((v_4.(poffset)) >= (0)))));
    rely ((((v_4.(pbase)) = ("granules")) \/ (((v_4.(pbase)) = ("null")))));
    if (ptr_eqb v_4 (mkPtr "null" 0))
    then (
      when v_6, st_1 == ((pack_return_code_spec 1 2 st_0));
      (Some (v_6, st_1)))
    else (
      when st_1 == ((store_RData 8 (ptr_offset v_0 1536) (ptr_to_int v_4) st_0));
      when st_2 == ((store_RData 8 (ptr_offset v_0 392) v_1 st_1));
      when st_3 == ((iasm_82_spec v_1 st_2));
      when st_4 == ((iasm_12_isb_spec st_3));
      when st_5 == ((granule_unlock_spec v_4 st_4));
      (Some (0, st_5))).

End Layer9_rsi_set_ttbr0_LowSpec.

#[global] Hint Unfold rsi_set_ttbr0_spec_low: spec.
