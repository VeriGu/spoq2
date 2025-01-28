Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_map_non_secure_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_map_non_secure_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (1)) =? (0))
    then (
      when v_20, st_0 == ((map_unmap_ns_s1_spec v_0 v_1 v_2 v_3 0 st));
      (Some (v_20, st_0)))
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
        rely (((((v_13.(pbase)) = ("granule_data")) /\ ((((v_13.(poffset)) mod (4096)) = (0)))) /\ (((v_13.(poffset)) >= (0)))));
        rely ((((((st_1.(share)).(granule_data)) @ ((v_13.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_REC)));
        when v_16_tmp, st_2 == ((load_RData 8 (ptr_offset v_13 1544) st_1));
        when v_17, st_3 == ((granule_addr_spec (int_to_ptr v_16_tmp) st_2));
        when v_18, st_4 == ((map_unmap_ns_s1_spec v_17 v_1 v_2 v_3 0 st_3));
        when st_5 == ((granule_unlock_spec v_8 st_4));
        (Some (v_18, st_5)))).

End Layer9_rsi_rtt_map_non_secure_LowSpec.

#[global] Hint Unfold rsi_rtt_map_non_secure_spec_low: spec.
