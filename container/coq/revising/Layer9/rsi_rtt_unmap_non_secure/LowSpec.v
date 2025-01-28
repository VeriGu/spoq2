Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_unmap_non_secure_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_unmap_non_secure_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (1)) =? (0))
    then (
      when v_19, st_0 == ((map_unmap_ns_s1_spec v_0 v_1 v_2 0 1 st));
      (Some (v_19, st_0)))
    else (
      when v_7, st_0 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st));
      rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
      rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
      if (ptr_eqb v_7 (mkPtr "null" 0))
      then (
        when v_9, st_1 == ((pack_return_code_spec 1 1 st_0));
        (Some (v_9, st_1)))
      else (
        when v_12, st_1 == ((granule_map_spec v_7 3 st_0));
        when v_15_tmp, st_2 == ((load_RData 8 (ptr_offset v_12 1544) st_1));
        when v_16, st_3 == ((granule_addr_spec (int_to_ptr v_15_tmp) st_2));
        when v_17, st_4 == ((map_unmap_ns_s1_spec v_16 v_1 v_2 0 1 st_3));
        when st_5 == ((granule_unlock_spec v_7 st_4));
        (Some (v_17, st_5)))).

End Layer9_rsi_rtt_unmap_non_secure_LowSpec.

#[global] Hint Unfold rsi_rtt_unmap_non_secure_spec_low: spec.
