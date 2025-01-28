Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer12.Spec.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_smc_rtt_map_non_secure_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_rtt_map_non_secure_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (1)) =? (0))
    then (
      when v_20, st_0 == ((host_ns_s2tte_is_valid_spec v_3 v_2 st));
      if v_20
      then (
        when v_25, st_1 == ((map_unmap_ns_spec v_0 v_1 v_2 v_3 0 st_0));
        (Some (v_25, st_1)))
      else (
        when v_22, st_1 == ((pack_return_code_spec 1 4 st_0));
        (Some (v_22, st_1))))
    else (
      when v_8, st_0 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st));
      rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
      rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
      if (ptr_eqb v_8 (mkPtr "null" 0))
      then (
        when v_10, st_1 == ((pack_return_code_spec 1 1 st_0));
        (Some (v_10, st_1)))
      else (
        when v_13, st_1 == ((granule_map_spec v_8 3 st_0));
        when v_16_tmp, st_2 == ((load_RData 8 (ptr_offset v_13 1544) st_1));
        when v_17, st_3 == ((granule_addr_spec (int_to_ptr v_16_tmp) st_2));
        when v_18, st_4 == ((map_unmap_ns_s1_spec v_17 v_1 v_2 v_3 0 st_3));
        when st_5 == ((granule_unlock_spec v_8 st_4));
        (Some (v_18, st_5)))).

End Layer13_smc_rtt_map_non_secure_LowSpec.

#[global] Hint Unfold smc_rtt_map_non_secure_spec_low: spec.
