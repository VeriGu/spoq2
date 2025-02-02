Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_data_destroy_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_data_destroy_spec_low (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_data_destroy" st));
    let v_0_pa := (test_PA v_0) in
    if (check_rcsm_mask_para v_0_pa)
    then (
      when v_17, st_1 == ((find_lock_granule_spec_abs v_0_pa 5 st_0));
      rely (((((v_17.(poffset)) mod (16)) = (0)) /\ (((v_17.(poffset)) >= (0)))));
      rely ((((v_17.(pbase)) = ("granules")) \/ (((v_17.(pbase)) = ("null")))));
      if (ptr_eqb v_17 (mkPtr "null" 0))
      then (
        when v_19, st_2 == ((pack_return_code_spec 1 1 st_1));
        when st_4 == ((free_stack "rsi_data_destroy" st_0 st_2));
        (Some (v_19, st_4)))
      else (
        when ret_rtt, st_3 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_17 0 64 v_1 3 st_1));
        let v__sroa_0_0_copyload := (ret_rtt.(e_2)) in
        let v__sroa_6_0_copyload := (ret_rtt.(e_1)) in
        let st_5 := st_3 in
        if (v__sroa_6_0_copyload =? (3))
        then (
          let v__sroa_4_0_copyload := (ret_rtt.(e_3)) in
          when v_26, st_8 == ((granule_map_spec v__sroa_0_0_copyload 6 st_5));
          when v_29, st_9 == ((abs__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) st_8));
          when v_30, st_10 == ((s1tte_is_valid_spec_abs v_29 3 st_9));
          if v_30
          then (
            when v_36, st_12 == ((s2tte_pa_spec_abs v_29 3 st_10));
            when st_13 == ((__tte_write_spec_abs (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) s2tte_create_destroyed_abs st_12));
            when st_14 == ((iasm_8_spec st_13));
            when st_15 == ((stage1_tlbi_all_spec st_14));
            when st_16 == ((__granule_put_spec v__sroa_0_0_copyload st_15));
            when v_42, st_17 == ((find_lock_granule_spec_abs v_36 4 st_16));
            rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
            rely (((v_42.(pbase)) = ("granules")));
            when st_18 == ((__granule_put_spec v_42 st_17));
            let v_43 := (g_refcount_para v_42 st_18) in
            let st_19 := st_18 in
            if (v_43 =? (0))
            then (
              when st_20 == ((granule_memzero_spec v_42 0 st_19));
              when st_21 == ((granule_unlock_transition_spec v_42 1 st_20));
              when st_23 == ((granule_unlock_spec v__sroa_0_0_copyload st_21));
              when st_24 == ((free_stack "rsi_data_destroy" st_0 st_23));
              (Some (0, st_24)))
            else (
              when st_20 == ((granule_unlock_spec v_42 st_19));
              when st_22 == ((granule_unlock_spec v__sroa_0_0_copyload st_20));
              when st_23 == ((free_stack "rsi_data_destroy" st_0 st_22));
              (Some (0, st_23))))
          else (
            when v_32, st_11 == ((s2tte_is_assigned_spec_abs v_29 3 st_10));
            if v_32
            then (
              when v_36, st_13 == ((s2tte_pa_spec_abs v_29 3 st_11));
              when v_39, st_14 == ((s2tte_create_unassigned_spec_abs 0 st_13));
              when st_15 == ((__tte_write_spec_abs (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) v_39 st_14));
              when st_16 == ((iasm_8_spec st_15));
              when st_17 == ((stage1_tlbi_all_spec st_16));
              when st_18 == ((__granule_put_spec v__sroa_0_0_copyload st_17));
              when v_42, st_19 == ((find_lock_granule_spec_abs v_36 4 st_18));
              rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
              rely ((((v_42.(pbase)) = ("granules")) \/ (((v_42.(pbase)) = ("null")))));
              when st_20 == ((__granule_put_spec v_42 st_19));
              let v_43 := (g_refcount_para v_42 st_20) in
              let st_21 := st_20 in
              if (v_43 =? (0))
              then (
                when st_22 == ((granule_memzero_spec v_42 0 st_21));
                when st_23 == ((granule_unlock_transition_spec v_42 1 st_22));
                when st_24 == ((granule_unlock_spec v__sroa_0_0_copyload st_23));
                when st_25 == ((free_stack "rsi_data_destroy" st_0 st_24));
                (Some (0, st_25)))
              else (
                when st_22 == ((granule_unlock_spec v_42 st_21));
                when st_23 == ((granule_unlock_spec v__sroa_0_0_copyload st_22));
                when st_24 == ((free_stack "rsi_data_destroy" st_0 st_23));
                (Some (0, st_24))))
            else (
              when v_34, st_12 == ((pack_return_code_spec 9 0 st_11));
              when st_13 == ((granule_unlock_spec v__sroa_0_0_copyload st_12));
              when st_15 == ((free_stack "rsi_data_destroy" st_0 st_13));
              (Some (v_34, st_15)))))
        else (
          when v_24, st_6 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_5));
          when st_7 == ((granule_unlock_spec v__sroa_0_0_copyload st_6));
          when st_9 == ((free_stack "rsi_data_destroy" st_0 st_7));
          (Some (v_24, st_9)))))
    else (
      when v_7, st_1 == ((find_lock_granule_spec_abs v_0_pa 3 st_0));
      rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
      rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
      if (ptr_eqb v_7 (mkPtr "null" 0))
      then (
        when v_9, st_2 == ((pack_return_code_spec 1 1 st_1));
        when st_4 == ((free_stack "rsi_data_destroy" st_0 st_2));
        (Some (v_9, st_4)))
      else (
        when v_12, st_2 == ((granule_map_spec v_7 3 st_1));
        rely ((((v_12.(pbase)) = ("granule_data")) /\ (((v_12.(poffset)) >= (0)))));
        rely ((((v_12.(poffset)) mod (4096)) = (0)));
        rely ((((((st.(share)).(granule_data)) @ ((v_12.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_REC)));
        let v_15 := (rec_to_ttbr1_para v_12 st_2) in
        when st_4 == ((granule_lock_spec v_15 5 st_2));
        when st_5 == ((granule_unlock_spec v_7 st_4));
        when ret_rtt, st_7 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_15 0 64 v_1 3 st_5));
        let v__sroa_0_0_copyload := (ret_rtt.(e_2)) in
        let v__sroa_6_0_copyload := (ret_rtt.(e_1)) in
        let st_9 := st_7 in
        if (v__sroa_6_0_copyload =? (3))
        then (
          let v__sroa_4_0_copyload := (ret_rtt.(e_3)) in
          when v_26, st_11 == ((granule_map_spec v__sroa_0_0_copyload 6 st_9));
          rely ((((v_26.(pbase)) = ("granule_data")) /\ (((v_26.(poffset)) >= (0)))));
          rely ((((v_26.(poffset)) mod (4096)) = (0)));
          when v_29, st_12 == ((abs__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) st_11));
          when v_30, st_13 == ((s1tte_is_valid_spec_abs v_29 3 st_12));
          if v_30
          then (
            when v_36, st_14 == ((s2tte_pa_spec_abs v_29 3 st_13));
            when st_15 == ((__tte_write_spec_abs (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) s2tte_create_destroyed_abs st_14));
            when st_16 == ((iasm_8_spec st_15));
            when st_17 == ((stage1_tlbi_all_spec st_16));
            when st_18 == ((__granule_put_spec v__sroa_0_0_copyload st_17));
            when v_42, st_19 == ((find_lock_granule_spec_abs v_36 4 st_18));
            rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
            rely (((v_42.(pbase)) = ("granules")));
            when st_20 == ((__granule_put_spec v_42 st_19));
            let v_43 := (g_refcount_para v_42 st_20) in
            let st_21 := st_20 in
            if (v_43 =? (0))
            then (
              when st_22 == ((granule_memzero_spec v_42 0 st_21));
              when st_23 == ((granule_unlock_transition_spec v_42 1 st_22));
              when st_24 == ((granule_unlock_spec v__sroa_0_0_copyload st_23));
              when st_25 == ((free_stack "rsi_data_destroy" st_0 st_24));
              (Some (0, st_25)))
            else (
              when st_22 == ((granule_unlock_spec v_42 st_21));
              when st_23 == ((granule_unlock_spec v__sroa_0_0_copyload st_22));
              when st_24 == ((free_stack "rsi_data_destroy" st_0 st_23));
              (Some (0, st_24))))
          else (
            when v_32, st_14 == ((s2tte_is_assigned_spec_abs v_29 3 st_13));
            if v_32
            then (
              when v_36, st_15 == ((s2tte_pa_spec_abs v_29 3 st_14));
              when v_39, st_16 == ((s2tte_create_unassigned_spec_abs 0 st_15));
              when st_17 == ((__tte_write_spec_abs (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) v_39 st_16));
              when st_18 == ((iasm_8_spec st_17));
              when st_19 == ((stage1_tlbi_all_spec st_18));
              when st_20 == ((__granule_put_spec v__sroa_0_0_copyload st_19));
              when v_42, st_21 == ((find_lock_granule_spec_abs v_36 4 st_20));
              rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
              rely (((v_42.(pbase)) = ("granules")));
              when st_22 == ((__granule_put_spec v_42 st_21));
              let v_43 := (g_refcount_para v_42 st_22) in
              let st_23 := st_22 in
              if (v_43 =? (0))
              then (
                when st_24 == ((granule_memzero_spec v_42 0 st_23));
                when st_25 == ((granule_unlock_transition_spec v_42 1 st_24));
                when st_26 == ((granule_unlock_spec v__sroa_0_0_copyload st_25));
                when st_27 == ((free_stack "rsi_data_destroy" st_0 st_26));
                (Some (0, st_27)))
              else (
                when st_24 == ((granule_unlock_spec v_42 st_23));
                when st_25 == ((granule_unlock_spec v__sroa_0_0_copyload st_24));
                when st_26 == ((free_stack "rsi_data_destroy" st_0 st_25));
                (Some (0, st_26))))
            else (
              when v_34, st_15 == ((pack_return_code_spec 9 0 st_14));
              when st_16 == ((granule_unlock_spec v__sroa_0_0_copyload st_15));
              when st_17 == ((free_stack "rsi_data_destroy" st_0 st_16));
              (Some (v_34, st_17)))))
        else (
          when v_24, st_10 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_9));
          when st_11 == ((granule_unlock_spec v__sroa_0_0_copyload st_10));
          when st_12 == ((free_stack "rsi_data_destroy" st_0 st_11));
          (Some (v_24, st_12))))).

End Layer9_rsi_data_destroy_LowSpec.

#[global] Hint Unfold rsi_data_destroy_spec_low: spec.
