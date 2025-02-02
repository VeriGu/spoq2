Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_destroy_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_rtt_destroy" st));
    let v_1_pa := (test_PA v_1) in
    let v_0_pa := (test_PA v_0) in
    when v_6, st_1 == ((find_lock_granule_spec_abs v_1_pa 5 st_0));
    rely (((((v_6.(poffset)) mod (16)) = (0)) /\ (((v_6.(poffset)) >= (0)))));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 2 st_1));
      when st_4 == ((free_stack "rsi_rtt_destroy" st_0 st_2));
      (Some (v_8, st_4)))
    else (
      when ret_rtt, st_2 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_6 0 64 v_2 (v_3 + ((- 1))) st_1));
      let v__sroa_0_0_copyload := (ret_rtt.(e_2)) in
      let v__sroa_7_0_copyload := (ret_rtt.(e_1)) in
      let st_4 := st_2 in
      if ((v__sroa_7_0_copyload - ((v_3 + ((- 1))))) =? (0))
      then (
        let v__sroa_4_0_copyload := (ret_rtt.(e_3)) in
        when v_16, st_6 == ((granule_map_spec v__sroa_0_0_copyload 6 st_4));
        rely (((v__sroa_4_0_copyload < (512)) /\ ((v__sroa_4_0_copyload >= (0)))));
        when v_19, st_7 == ((abs__tte_read_spec (ptr_offset v_16 (8 * (v__sroa_4_0_copyload))) st_6));
        when v_20, st_8 == ((s2tte_is_table_spec_abs v_19 (v_3 + ((- 1))) st_7));
        if v_20
        then (
          when v_25, st_9 == ((s2tte_pa_spec_abs v_19 (v_3 + ((- 1))) st_8));
          if (((v_25.(meta_granule_offset)) - ((v_0_pa.(meta_granule_offset)))) =? (0))
          then (
            when v_29, st_10 == ((find_lock_granule_spec_abs v_0_pa 5 st_9));
            rely (((((v_29.(poffset)) mod (16)) = (0)) /\ (((v_29.(poffset)) >= (0)))));
            rely (((v_29.(pbase)) = ("granules")));
            let v_30 := (g_refcount_para v_29 st_10) in
            let st_11 := st_10 in
            if (v_30 =? (0))
            then (
              when v_34, st_12 == ((granule_map_spec v_29 7 st_11));
              when v_35, st_13 == ((s2tte_create_unassigned_spec_abs 1 st_12));
              when st_14 == ((__granule_put_spec v__sroa_0_0_copyload st_13));
              when st_15 == ((__tte_write_spec_abs (ptr_offset v_16 (8 * (v__sroa_4_0_copyload))) (test_Z_PTE 0) st_14));
              when st_16 == ((iasm_8_spec st_15));
              when st_17 == ((stage1_tlbi_all_spec st_16));
              when st_18 == ((__tte_write_spec_abs (ptr_offset v_16 (8 * (v__sroa_4_0_copyload))) v_35 st_17));
              when st_19 == ((iasm_8_spec st_18));
              when st_20 == ((iasm_12_isb_spec st_19));
              when st_21 == ((granule_memzero_mapped_spec v_34 st_20));
              when st_22 == ((granule_set_state_spec v_29 1 st_21));
              when st_24 == ((granule_unlock_spec v_29 st_22));
              when st_28 == ((granule_unlock_spec v__sroa_0_0_copyload st_24));
              when st_30 == ((free_stack "rsi_rtt_destroy" st_0 st_28));
              (Some (0, st_30)))
            else (
              when v_32, st_12 == ((pack_return_code_spec 4 0 st_11));
              when st_14 == ((granule_unlock_spec v_29 st_12));
              when st_18 == ((granule_unlock_spec v__sroa_0_0_copyload st_14));
              when st_20 == ((free_stack "rsi_rtt_destroy" st_0 st_18));
              (Some (v_32, st_20))))
          else (
            when v_27, st_10 == ((pack_return_code_spec 1 1 st_9));
            when st_14 == ((granule_unlock_spec v__sroa_0_0_copyload st_10));
            when st_16 == ((free_stack "rsi_rtt_destroy" st_0 st_14));
            (Some (v_27, st_16))))
        else (
          when v_23, st_9 == ((pack_return_code_spec 8 (v_3 + ((- 1))) st_8));
          when st_12 == ((granule_unlock_spec v__sroa_0_0_copyload st_9));
          when st_14 == ((free_stack "rsi_rtt_destroy" st_0 st_12));
          (Some (v_23, st_14))))
      else (
        when v_14, st_5 == ((pack_return_code_spec 8 v__sroa_7_0_copyload st_4));
        when st_7 == ((granule_unlock_spec v__sroa_0_0_copyload st_5));
        when st_9 == ((free_stack "rsi_rtt_destroy" st_0 st_7));
        (Some (v_14, st_9)))).

End Layer9_rsi_rtt_destroy_LowSpec.

#[global] Hint Unfold rsi_rtt_destroy_spec_low: spec.
