Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
(* Require Import Layer12.Spec. *)
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Layer8.Spec.
Require Import Layer8.map_unmap_ns_s1.LowSpec.
Require Import Layer9.gic_restore_state.LowSpec.
Require Import Layer9.rsi_data_set_attrs.LowSpec.
Require Import Layer9.rsi_rtt_set_ripas.LowSpec.
Require Import Layer9.rsi_data_read.LowSpec.
Require Import Layer9.rsi_data_write.LowSpec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_Spec.

  Context `{int_ptr: IntPtrCast}.


  Definition rsi_rtt_set_ripas_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_rtt_set_ripas" st));
    if (v_3 >? (1))
    then (
      when st_2 == ((free_stack "rsi_rtt_set_ripas" st_0 st_0));
      (Some (1, st_2)))
    else (
      if ((v_0 & (1)) =? (0))
      then (
        when v_24, st_1 == ((find_lock_granule_spec v_0 5 st_0));
        rely (((((v_24.(poffset)) mod (16)) = (0)) /\ (((v_24.(poffset)) >= (0)))));
        rely ((((v_24.(pbase)) = ("granules")) \/ (((v_24.(pbase)) = ("null")))));
        if (ptr_eqb v_24 (mkPtr "null" 0))
        then (
          when v_26, st_2 == ((pack_return_code_spec 1 1 st_1));
          when st_4 == ((free_stack "rsi_rtt_set_ripas" st_0 st_2));
          (Some (v_26, st_4)))
        else (
          when st_3 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_24 0 64 v_1 v_2 st_1));
          rely ((((st_3.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
          when v__sroa_0_0_copyload_tmp, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_3));
          when v__sroa_5_0_copyload, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_4));
          if ((v__sroa_5_0_copyload - (v_2)) =? (0))
          then (
            when v__sroa_3_0_copyload, st_6 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_5));
            when v_34, st_7 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_6));
            when v_37, st_8 == ((__tte_read_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) st_7));
            when st_9 == ((store_RData 8 (mkPtr "stack_type_3" 0) v_37 st_8));
            when v_38, st_10 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 st_9));
            if v_38
            then (rsi_rtt_set_ripas_0_low st_0 st_10 v_34 v_38 v__sroa_0_0_copyload_tmp v__sroa_3_0_copyload)
            else (
              when v_41, st_11 == ((pack_return_code_spec 8 v_2 st_10));
              when st_13 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_11));
              when st_12 == ((free_stack "rsi_rtt_set_ripas" st_0 st_13));
              (Some (v_41, st_12))))
          else (
            when v_31, st_6 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_5));
            when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_6));
            when st_8 == ((free_stack "rsi_rtt_set_ripas" st_0 st_7));
            (Some (v_31, st_8)))))
      else (
        when v_14, st_1 == ((find_lock_granule_spec (v_0 & ((- 2))) 3 st_0));
        rely (((((v_14.(poffset)) mod (16)) = (0)) /\ (((v_14.(poffset)) >= (0)))));
        rely ((((v_14.(pbase)) = ("granules")) \/ (((v_14.(pbase)) = ("null")))));
        if (ptr_eqb v_14 (mkPtr "null" 0))
        then (
          when v_16, st_2 == ((pack_return_code_spec 1 1 st_1));
          when st_4 == ((free_stack "rsi_rtt_set_ripas" st_0 st_2));
          (Some (v_16, st_4)))
        else (
          when v_19, st_2 == ((granule_map_spec v_14 3 st_1));
          when v_22_tmp, st_3 == ((load_RData 8 (ptr_offset v_19 1544) st_2));
          when st_4 == ((granule_lock_spec (int_to_ptr v_22_tmp) 5 st_3));
          when st_5 == ((granule_unlock_spec v_14 st_4));
          when st_7 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_22_tmp) 0 64 v_1 v_2 st_5));
          rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
          when v__sroa_0_0_copyload_tmp, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_7));
          when v__sroa_5_0_copyload, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_8));
          if ((v__sroa_5_0_copyload - (v_2)) =? (0))
          then (
            when v__sroa_3_0_copyload, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_9));
            when v_34, st_11 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_10));
            when v_37, st_12 == ((__tte_read_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) st_11));
            when st_13 == ((store_RData 8 (mkPtr "stack_type_3" 0) v_37 st_12));
            when v_38, st_14 == ((update_ripas_spec (mkPtr "stack_type_3" 0) v_2 v_3 st_13));
            if v_38
            then (rsi_rtt_set_ripas_1_low st_0 st_14 v_34 v_38 v__sroa_0_0_copyload_tmp v__sroa_3_0_copyload)
            else (
              when v_41, st_15 == ((pack_return_code_spec 8 v_2 st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_15));
              when st_17 == ((free_stack "rsi_rtt_set_ripas" st_0 st_16));
              (Some (v_41, st_17))))
          else (
            when v_31, st_10 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_9));
            when st_11 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_10));
            when st_12 == ((free_stack "rsi_rtt_set_ripas" st_0 st_11));
            (Some (v_31, st_12)))))).

  Definition rsi_rtt_unmap_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
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

  Definition rsi_rtt_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_1 & (1)) =? (0))
    then (
      when v_18, st_0 == ((find_lock_granule_spec v_1 5 st));
      rely (((((v_18.(poffset)) mod (16)) = (0)) /\ (((v_18.(poffset)) >= (0)))));
      rely ((((v_18.(pbase)) = ("granules")) \/ (((v_18.(pbase)) = ("null")))));
      if (ptr_eqb v_18 (mkPtr "null" 0))
      then (
        when v_20, st_1 == ((pack_return_code_spec 1 1 st_0));
        (Some (v_20, st_1)))
      else (
        when v_23, st_1 == ((rtt_create_internal_spec v_18 v_0 v_2 v_3 0 st_0));
        (Some (((v_23 << (32)) >> (32)), st_1))))
    else (
      when v_8, st_0 == ((find_lock_granule_spec (v_1 & ((- 2))) 3 st));
      rely (((((v_8.(poffset)) mod (16)) = (0)) /\ (((v_8.(poffset)) >= (0)))));
      rely ((((v_8.(pbase)) = ("granules")) \/ (((v_8.(pbase)) = ("null")))));
      if (ptr_eqb v_8 (mkPtr "null" 0))
      then (
        when v_10, st_1 == ((pack_return_code_spec 1 2 st_0));
        (Some (v_10, st_1)))
      else (
        when v_13, st_1 == ((granule_map_spec v_8 3 st_0));
        when v_15, st_2 == ((rtt_create_s1_el1_spec v_13 v_0 v_2 v_3 st_1));
        when st_3 == ((granule_unlock_spec v_8 st_2));
        (Some (((v_15 << (32)) >> (32)), st_3)))).

  Definition rsi_data_destroy_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_data_destroy" st));
    if ((v_0 & (1)) =? (0))
    then (
      when v_17, st_1 == ((find_lock_granule_spec v_0 5 st_0));
      rely (((((v_17.(poffset)) mod (16)) = (0)) /\ (((v_17.(poffset)) >= (0)))));
      rely ((((v_17.(pbase)) = ("granules")) \/ (((v_17.(pbase)) = ("null")))));
      if (ptr_eqb v_17 (mkPtr "null" 0))
      then (
        when v_19, st_2 == ((pack_return_code_spec 1 1 st_1));
        when st_4 == ((free_stack "rsi_data_destroy" st_0 st_2));
        (Some (v_19, st_4)))
      else (
        when st_3 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_17 0 64 v_1 3 st_1));
        when v__sroa_0_0_copyload_tmp, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_3));
        rely (((v__sroa_0_0_copyload_tmp >= (GRANULES_BASE)) /\ ((v__sroa_0_0_copyload_tmp < ((GRANULES_BASE + ((NR_GRANULES * (16)))))))));
        when v__sroa_6_0_copyload, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_4));
        if (v__sroa_6_0_copyload =? (3))
        then (
          when v__sroa_4_0_copyload, st_7 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_5));
          rely (((v__sroa_4_0_copyload < (512)) /\ ((v__sroa_4_0_copyload >= (0)))));
          when v_26, st_8 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_7));
          when v_29, st_9 == ((__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) st_8));
          when v_30, st_10 == ((s1tte_is_valid_spec v_29 3 st_9));
          if v_30
          then (
            when v_36, st_12 == ((s2tte_pa_spec v_29 3 st_10));
            when st_13 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) 8 st_12));
            when st_14 == ((iasm_8_spec st_13));
            when st_15 == ((stage1_tlbi_all_spec st_14));
            when st_16 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_15));
            when v_42, st_17 == ((find_lock_granule_spec v_36 4 st_16));
            rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
            rely ((((v_42.(pbase)) = ("granules")) \/ (((v_42.(pbase)) = ("null")))));
            when st_18 == ((__granule_put_spec v_42 st_17));
            when v_43, st_19 == ((g_refcount_spec v_42 st_18));
            if (v_43 =? (0))
            then (
              when st_20 == ((granule_memzero_spec v_42 0 st_19));
              when st_21 == ((granule_unlock_transition_spec v_42 1 st_20));
              when st_23 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_21));
              when st_24 == ((free_stack "rsi_data_destroy" st_0 st_23));
              (Some (0, st_24)))
            else (
              when st_20 == ((granule_unlock_spec v_42 st_19));
              when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_20));
              when st_23 == ((free_stack "rsi_data_destroy" st_0 st_22));
              (Some (0, st_23))))
          else (
            when v_32, st_11 == ((s2tte_is_assigned_spec v_29 3 st_10));
            if v_32
            then (
              when v_36, st_13 == ((s2tte_pa_spec v_29 3 st_11));
              when v_39, st_14 == ((s2tte_create_unassigned_spec 0 st_13));
              when st_15 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) v_39 st_14));
              when st_16 == ((iasm_8_spec st_15));
              when st_17 == ((stage1_tlbi_all_spec st_16));
              when st_18 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_17));
              when v_42, st_19 == ((find_lock_granule_spec v_36 4 st_18));
              rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
              rely ((((v_42.(pbase)) = ("granules")) \/ (((v_42.(pbase)) = ("null")))));
              when st_20 == ((__granule_put_spec v_42 st_19));
              when v_43, st_21 == ((g_refcount_spec v_42 st_20));
              if (v_43 =? (0))
              then (
                when st_22 == ((granule_memzero_spec v_42 0 st_21));
                when st_23 == ((granule_unlock_transition_spec v_42 1 st_22));
                when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_23));
                when st_25 == ((free_stack "rsi_data_destroy" st_0 st_24));
                (Some (0, st_25)))
              else (
                when st_22 == ((granule_unlock_spec v_42 st_21));
                when st_23 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_22));
                when st_24 == ((free_stack "rsi_data_destroy" st_0 st_23));
                (Some (0, st_24))))
            else (
              when v_34, st_12 == ((pack_return_code_spec 9 0 st_11));
              when st_13 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_12));
              when st_15 == ((free_stack "rsi_data_destroy" st_0 st_13));
              (Some (v_34, st_15)))))
        else (
          when v_24, st_6 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_5));
          when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_6));
          when st_9 == ((free_stack "rsi_data_destroy" st_0 st_7));
          (Some (v_24, st_9)))))
    else (
      when v_7, st_1 == ((find_lock_granule_spec (v_0 & ((-2))) 3 st_0));
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
        when v_15_tmp, st_3 == ((load_RData 8 (ptr_offset v_12 1544) st_2));
        rely ((((v_15_tmp >= (MEM0_PHYS)) /\ ((v_15_tmp < ((MEM0_PHYS + (MEM0_SIZE)))))) \/ (((v_15_tmp >= (MEM1_PHYS)) /\ ((v_15_tmp < ((MEM1_PHYS + (MEM1_SIZE)))))))));
        when st_4 == ((granule_lock_spec (int_to_ptr v_15_tmp) 5 st_3));
        when st_5 == ((granule_unlock_spec v_7 st_4));
        when st_7 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_15_tmp) 0 64 v_1 3 st_5));
        when v__sroa_0_0_copyload_tmp, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_7));
        rely (((v__sroa_0_0_copyload_tmp >= (GRANULES_BASE)) /\ ((v__sroa_0_0_copyload_tmp < ((GRANULES_BASE + ((NR_GRANULES * (16)))))))));
        when v__sroa_6_0_copyload, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_8));
        if (v__sroa_6_0_copyload =? (3))
        then (
          when v__sroa_4_0_copyload, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_9));
          rely (((v__sroa_4_0_copyload < (512)) /\ ((v__sroa_4_0_copyload >= (0)))));
          when v_26, st_11 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_10));
          rely ((((v_26.(pbase)) = ("granule_data")) /\ (((v_26.(poffset)) >= (0)))));
          rely ((((v_26.(poffset)) mod (4096)) = (0)));
          rely ((((((st.(share)).(granule_data)) @ ((v_26.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_RTT)));
          when v_29, st_12 == ((__tte_read_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) st_11));
          when v_30, st_13 == ((s1tte_is_valid_spec v_29 3 st_12));
          if v_30
          then (
            when v_36, st_14 == ((s2tte_pa_spec v_29 3 st_13));
            when st_15 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) 8 st_14));
            when st_16 == ((iasm_8_spec st_15));
            when st_17 == ((stage1_tlbi_all_spec st_16));
            when st_18 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_17));
            when v_42, st_19 == ((find_lock_granule_spec v_36 4 st_18));
            rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
            rely ((((v_42.(pbase)) = ("granules")) \/ (((v_42.(pbase)) = ("null")))));
            when st_20 == ((__granule_put_spec v_42 st_19));
            when v_43, st_21 == ((g_refcount_spec v_42 st_20));
            if (v_43 =? (0))
            then (
              when st_22 == ((granule_memzero_spec v_42 0 st_21));
              when st_23 == ((granule_unlock_transition_spec v_42 1 st_22));
              when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_23));
              when st_25 == ((free_stack "rsi_data_destroy" st_0 st_24));
              (Some (0, st_25)))
            else (
              when st_22 == ((granule_unlock_spec v_42 st_21));
              when st_23 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_22));
              when st_24 == ((free_stack "rsi_data_destroy" st_0 st_23));
              (Some (0, st_24))))
          else (
            when v_32, st_14 == ((s2tte_is_assigned_spec v_29 3 st_13));
            if v_32
            then (
              when v_36, st_15 == ((s2tte_pa_spec v_29 3 st_14));
              when v_39, st_16 == ((s2tte_create_unassigned_spec 0 st_15));
              when st_17 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_4_0_copyload))) v_39 st_16));
              when st_18 == ((iasm_8_spec st_17));
              when st_19 == ((stage1_tlbi_all_spec st_18));
              when st_20 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_19));
              when v_42, st_21 == ((find_lock_granule_spec v_36 4 st_20));
              rely (((((v_42.(poffset)) mod (16)) = (0)) /\ (((v_42.(poffset)) >= (0)))));
              rely ((((v_42.(pbase)) = ("granules")) \/ (((v_42.(pbase)) = ("null")))));
              when st_22 == ((__granule_put_spec v_42 st_21));
              when v_43, st_23 == ((g_refcount_spec v_42 st_22));
              if (v_43 =? (0))
              then (
                when st_24 == ((granule_memzero_spec v_42 0 st_23));
                when st_25 == ((granule_unlock_transition_spec v_42 1 st_24));
                when st_26 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_25));
                when st_27 == ((free_stack "rsi_data_destroy" st_0 st_26));
                (Some (0, st_27)))
              else (
                when st_24 == ((granule_unlock_spec v_42 st_23));
                when st_25 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_24));
                when st_26 == ((free_stack "rsi_data_destroy" st_0 st_25));
                (Some (0, st_26))))
            else (
              when v_34, st_15 == ((pack_return_code_spec 9 0 st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_15));
              when st_17 == ((free_stack "rsi_data_destroy" st_0 st_16));
              (Some (v_34, st_17)))))
        else (
          when v_24, st_10 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_9));
          when st_11 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_10));
          when st_12 == ((free_stack "rsi_data_destroy" st_0 st_11));
          (Some (v_24, st_12))))).

  Definition rsi_rtt_destroy_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_rtt_destroy" st));
    when v_6, st_1 == ((find_lock_granule_spec v_1 5 st_0));
    rely (((((v_6.(poffset)) mod (16)) = (0)) /\ (((v_6.(poffset)) >= (0)))));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 2 st_1));
      when st_4 == ((free_stack "rsi_rtt_destroy" st_0 st_2));
      (Some (v_8, st_4)))
    else (
      when st_2 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_6 0 64 v_2 (v_3 + ((- 1))) st_1));
      when v__sroa_0_0_copyload_tmp, st_3 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_2));
      when v__sroa_7_0_copyload, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_3));
      if ((v__sroa_7_0_copyload - ((v_3 + ((- 1))))) =? (0))
      then (
        when v__sroa_4_0_copyload, st_5 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_4));
        rely (((v__sroa_0_0_copyload_tmp >= (GRANULES_BASE)) /\ ((v__sroa_0_0_copyload_tmp < ((GRANULES_BASE + ((NR_GRANULES * (16)))))))));
        when v_16, st_6 == ((granule_map_spec (int_to_ptr v__sroa_0_0_copyload_tmp) 6 st_5));
        rely (((v__sroa_4_0_copyload < (512)) /\ ((v__sroa_4_0_copyload >= (0)))));
        when v_19, st_7 == ((__tte_read_spec (ptr_offset v_16 (8 * (v__sroa_4_0_copyload))) st_6));
        when v_20, st_8 == ((s2tte_is_table_spec v_19 (v_3 + ((- 1))) st_7));
        if v_20
        then (
          when v_25, st_9 == ((s2tte_pa_spec v_19 (v_3 + ((- 1))) st_8));
          if ((v_25 - (v_0)) =? (0))
          then (
            when v_29, st_10 == ((find_lock_granule_spec v_0 5 st_9));
            rely (((((v_29.(poffset)) mod (16)) = (0)) /\ (((v_29.(poffset)) >= (0)))));
            rely ((((v_29.(pbase)) = ("granules")) \/ (((v_29.(pbase)) = ("null")))));
            when v_30, st_11 == ((g_refcount_spec v_29 st_10));
            if (v_30 =? (0))
            then (
              when v_34, st_12 == ((granule_map_spec v_29 7 st_11));
              when v_35, st_13 == ((s2tte_create_unassigned_spec 1 st_12));
              when st_14 == ((__granule_put_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_13));
              when st_15 == ((__tte_write_spec (ptr_offset v_16 (8 * (v__sroa_4_0_copyload))) 0 st_14));
              when st_16 == ((iasm_8_spec st_15));
              when st_17 == ((stage1_tlbi_all_spec st_16));
              when st_18 == ((__tte_write_spec (ptr_offset v_16 (8 * (v__sroa_4_0_copyload))) v_35 st_17));
              when st_19 == ((iasm_8_spec st_18));
              when st_20 == ((iasm_12_isb_spec st_19));
              when st_21 == ((granule_memzero_mapped_spec v_34 st_20));
              when st_22 == ((granule_set_state_spec v_29 1 st_21));
              when st_24 == ((granule_unlock_spec v_29 st_22));
              when st_28 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_24));
              when st_30 == ((free_stack "rsi_rtt_destroy" st_0 st_28));
              (Some (0, st_30)))
            else (
              when v_32, st_12 == ((pack_return_code_spec 4 0 st_11));
              when st_14 == ((granule_unlock_spec v_29 st_12));
              when st_18 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_14));
              when st_20 == ((free_stack "rsi_rtt_destroy" st_0 st_18));
              (Some (v_32, st_20))))
          else (
            when v_27, st_10 == ((pack_return_code_spec 1 1 st_9));
            when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_10));
            when st_16 == ((free_stack "rsi_rtt_destroy" st_0 st_14));
            (Some (v_27, st_16))))
        else (
          when v_23, st_9 == ((pack_return_code_spec 8 (v_3 + ((- 1))) st_8));
          when st_12 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_9));
          when st_14 == ((free_stack "rsi_rtt_destroy" st_0 st_12));
          (Some (v_23, st_14))))
      else (
        when v_14, st_5 == ((pack_return_code_spec 8 v__sroa_7_0_copyload st_4));
        when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_5));
        when st_9 == ((free_stack "rsi_rtt_destroy" st_0 st_7));
        (Some (v_14, st_9)))).

  Definition rsi_data_map_extra_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((s1tte_pa_spec v_2 st));
    when v_5, st_1 == ((find_lock_granule_spec v_4 4 st_0));
    rely (((((v_5.(poffset)) mod (16)) = (0)) /\ (((v_5.(poffset)) >= (0)))));
    rely ((((v_5.(pbase)) = ("granules")) \/ (((v_5.(pbase)) = ("null")))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (
      when v_7, st_2 == ((pack_return_code_spec 1 3 st_1));
      (Some (v_7, st_2)))
    else (
      when v_11, st_2 == ((find_lock_granule_spec v_0 5 st_1));
      rely (((((v_11.(poffset)) mod (16)) = (0)) /\ (((v_11.(poffset)) >= (0)))));
      rely ((((v_11.(pbase)) = ("granules")) \/ (((v_11.(pbase)) = ("null")))));
      if (ptr_eqb v_11 (mkPtr "null" 0))
      then (
        when v_13, st_3 == ((pack_return_code_spec 1 2 st_2));
        (Some (v_13, st_3)))
      else (
        when v_16, st_3 == ((data_create_internal_spec v_2 v_11 v_1 (mkPtr "null" 0) (mkPtr "null" 0) 0 st_2));
        when st_4 == ((granule_unlock_spec v_5 st_3));
        (Some (((v_16 << (32)) >> (32)), st_4)))).

  Definition rsi_data_create_s1_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when v_5, st_0 == ((s1tte_pa_spec v_0 st));
    when v_6, st_1 == ((find_granule_spec v_3 st_0));
    rely ((((v_6.(pbase)) = ("granules")) \/ (((v_6.(pbase)) = ("null")))));
    if (ptr_eqb v_6 (mkPtr "null" 0))
    then (
      when v_8, st_2 == ((pack_return_code_spec 1 4 st_1));
      (Some (v_8, st_2)))
    else (
      if ((v_1 & (1)) =? (0))
      then (
        when v_16, st_2 == ((find_lock_granule_spec v_1 5 st_1));
        rely (((((v_16.(poffset)) mod (16)) = (0)) /\ (((v_16.(poffset)) >= (0)))));
        rely ((((v_16.(pbase)) = ("granules")) \/ (((v_16.(pbase)) = ("null")))));
        if (ptr_eqb v_16 (mkPtr "null" 0))
        then (
          when v_18, st_3 == ((pack_return_code_spec 1 2 st_2));
          (Some (v_18, st_3)))
        else (
          when v_21, st_3 == ((find_lock_granule_spec v_5 1 st_2));
          rely (((((v_21.(poffset)) mod (16)) = (0)) /\ (((v_21.(poffset)) >= (0)))));
          rely ((((v_21.(pbase)) = ("granules")) \/ (((v_21.(pbase)) = ("null")))));
          if (ptr_eqb v_21 (mkPtr "null" 0))
          then (
            when v_23, st_4 == ((pack_return_code_spec 1 1 st_3));
            (Some (v_23, st_4)))
          else (
            when v_26, st_4 == ((data_create_internal_spec v_0 v_16 v_2 v_6 (mkPtr "null" 0) 0 st_3));
            if (v_26 =? (0))
            then (
              when st_6 == ((granule_unlock_transition_spec v_21 4 st_4));
              (Some (((v_26 << (32)) >> (32)), st_6)))
            else (
              when st_6 == ((granule_unlock_transition_spec v_21 1 st_4));
              (Some (((v_26 << (32)) >> (32)), st_6))))))
      else (
        when v_14, st_2 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 v_6 st_1));
        (Some (v_14, st_2)))).

  Definition rsi_data_create_unknown_s1_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((s1tte_pa_spec v_0 st));
    if ((v_1 & (1)) =? (0))
    then (
      when v_10, st_1 == ((find_lock_granule_spec v_4 1 st_0));
      rely (((((v_10.(poffset)) mod (16)) = (0)) /\ (((v_10.(poffset)) >= (0)))));
      rely ((((v_10.(pbase)) = ("granules")) \/ (((v_10.(pbase)) = ("null")))));
      if (ptr_eqb v_10 (mkPtr "null" 0))
      then (
        when v_12, st_2 == ((pack_return_code_spec 1 1 st_1));
        (Some (v_12, st_2)))
      else (
        when v_15, st_2 == ((find_lock_granule_spec v_1 5 st_1));
        rely (((((v_15.(poffset)) mod (16)) = (0)) /\ (((v_15.(poffset)) >= (0)))));
        rely ((((v_15.(pbase)) = ("granules")) \/ (((v_15.(pbase)) = ("null")))));
        if (ptr_eqb v_15 (mkPtr "null" 0))
        then (
          when v_17, st_3 == ((pack_return_code_spec 1 2 st_2));
          (Some (v_17, st_3)))
        else (
          when v_20, st_3 == ((data_create_internal_spec v_0 v_15 v_2 (mkPtr "null" 0) (mkPtr "null" 0) 0 st_2));
          if (v_20 =? (0))
          then (
            when st_5 == ((granule_unlock_transition_spec v_10 4 st_3));
            (Some (((v_20 << (32)) >> (32)), st_5)))
          else (
            when st_5 == ((granule_unlock_transition_spec v_10 1 st_3));
            (Some (((v_20 << (32)) >> (32)), st_5))))))
    else (
      when v_8, st_1 == ((data_create_s1_el1_spec v_0 (v_1 & ((- 2))) v_2 (mkPtr "null" 0) st_0));
      (Some (v_8, st_1))).

  Fixpoint rsi_data_read_loop175 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_1, v_2, v_3, v_4, v_6, v__027, st))
    | (S _N__0) =>
      match ((rsi_data_read_loop175 _N__0 __return__ __break__ v_0 v_1 v_2 v_3 v_4 v_6 v__027 st)) with
      | (Some (__return___0, __break___0, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
        else (
          if __return___0
          then (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
          else (
            when v_13, st_1 == ((virt_to_phys_spec (v__28 + (v_8)) 0 v_7 v_9 st_0));
            if (v_13 =? (0))
            then (
              when v_14, st_2 == ((pack_return_code_spec 8 0 st_1));
              when st_3 == ((store_RData 8 (ptr_offset v_11 0) v_14 st_2));
              when st_4 == ((store_RData 8 (ptr_offset v_11 8) 2516582400 st_3));
              when v_18, st_5 == ((load_RData 8 v_7 st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_11 8) (((v_18 >> (1)) & (63)) |' (2516582400)) st_5));
              when st_7 == ((store_RData 8 (ptr_offset v_11 16) (v__28 + (v_8)) st_6));
              (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7)))
            else (
              when v_26, st_2 == ((next_granule_spec v_13 st_1));
              when v_28, st_3 == ((next_granule_spec (v__28 + (v_10)) st_2));
              when v_30, st_4 == ((min_spec (v_5 - (v__28)) (v_26 - (v_13)) (v_28 - ((v__28 + (v_10)))) st_3));
              when v_31, st_5 == ((ns_buffer_write_byte_spec (v__28 + (v_10)) v_30 v_13 st_4));
              if v_31
              then (
                if (((v_30 + (v__28)) - (v_5)) <? (0))
                then (Some (false, false, v_11, v_8, v_10, v_5, v_9, v_7, (v_30 + (v__28)), st_5))
                else (Some (false, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_5)))
              else (
                when v_34, st_6 == ((pack_return_code_spec 1 208 st_5));
                when st_7 == ((store_RData 8 (ptr_offset v_11 0) v_34 st_6));
                (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7))))))
      | None => None
      end
    end.

  Definition rsi_data_read_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rsi_data_read" st));
    when st_1 == ((rc_update_ttbr0_el12_spec v_4 st_0));
    if ((0 - (v_3)) <? (0))
    then (
      rely (((rsi_data_read_loop175_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0) >= (0)));
      match ((rsi_data_read_loop175 (z_to_nat (rsi_data_read_loop175_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0)) false false v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0 st_1)) with
      | (Some (__return___0, __break__, v_12, v_9, v_11, v_5, v_10, v_8, v__28, st_2)) =>
        if __return___0
        then (
          when st_4 == ((free_stack "rsi_data_read" st_0 st_2));
          (Some st_4))
        else (
          when st_4 == ((store_RData 8 (ptr_offset v_0 0) 0 st_2));
          when st_5 == ((free_stack "rsi_data_read" st_0 st_4));
          (Some st_5))
      | None => None
      end)
    else (
      when st_3 == ((store_RData 8 (ptr_offset v_0 0) 0 st_1));
      when st_4 == ((free_stack "rsi_data_read" st_0 st_3));
      (Some st_4)).

  Definition rsi_rtt_map_non_secure_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
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

  Fixpoint rsi_data_write_loop104 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_1, v_2, v_3, v_4, v_6, v__027, st))
    | (S _N__0) =>
      match ((rsi_data_write_loop104 _N__0 __return__ __break__ v_0 v_1 v_2 v_3 v_4 v_6 v__027 st)) with
      | (Some (__return___0, __break___0, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0)) =>
        if __break___0
        then (Some (__return___0, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
        else (
          if __return___0
          then (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_0))
          else (
            when v_13, st_1 == ((virt_to_phys_spec (v__28 + (v_8)) 1 v_7 v_9 st_0));
            if (v_13 =? (0))
            then (
              when v_14, st_2 == ((pack_return_code_spec 8 0 st_1));
              when st_3 == ((store_RData 8 (ptr_offset v_11 0) v_14 st_2));
              when st_4 == ((store_RData 8 (ptr_offset v_11 8) 2516582464 st_3));
              when v_18, st_5 == ((load_RData 8 v_7 st_4));
              when st_6 == ((store_RData 8 (ptr_offset v_11 8) (((v_18 >> (1)) & (63)) |' (2516582464)) st_5));
              when st_7 == ((store_RData 8 (ptr_offset v_11 16) (v__28 + (v_8)) st_6));
              (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7)))
            else (
              when v_26, st_2 == ((next_granule_spec (v__28 + (v_10)) st_1));
              when v_28, st_3 == ((next_granule_spec v_13 st_2));
              when v_30, st_4 == ((min_spec (v_5 - (v__28)) (v_26 - ((v__28 + (v_10)))) (v_28 - (v_13)) st_3));
              when v_31, st_5 == ((ns_buffer_read_byte_spec (v__28 + (v_10)) v_30 v_13 st_4));
              if v_31
              then (
                if (((v_30 + (v__28)) - (v_5)) <? (0))
                then (Some (false, false, v_11, v_8, v_10, v_5, v_9, v_7, (v_30 + (v__28)), st_5))
                else (Some (false, true, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_5)))
              else (
                when v_34, st_6 == ((pack_return_code_spec 1 139 st_5));
                when st_7 == ((store_RData 8 (ptr_offset v_11 0) v_34 st_6));
                (Some (true, false, v_11, v_8, v_10, v_5, v_9, v_7, v__28, st_7))))))
      | None => None
      end
    end.
  
  Definition rsi_data_write_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rsi_data_write" st));
    when st_1 == ((rc_update_ttbr0_el12_spec v_4 st_0));
    if ((0 - (v_3)) <? (0))
    then (
      rely (((rsi_data_write_loop104_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0) >= (0)));
      match ((rsi_data_write_loop104 (z_to_nat (rsi_data_write_loop104_rank v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0)) false false v_0 v_1 v_2 v_3 v_4 (mkPtr "stack_type_3" 0) 0 st_1)) with
      | (Some (__return___0, __break__, v_12, v_9, v_11, v_5, v_10, v_8, v__28, st_2)) =>
        if __return___0
        then (
          when st_4 == ((free_stack "rsi_data_write" st_0 st_2));
          (Some st_4))
        else (
          when st_4 == ((store_RData 8 (ptr_offset v_0 0) 0 st_2));
          when st_5 == ((free_stack "rsi_data_write" st_0 st_4));
          (Some st_5))
      | None => None
      end)
    else (
      when st_3 == ((store_RData 8 (ptr_offset v_0 0) 0 st_1));
      when st_4 == ((free_stack "rsi_data_write" st_0 st_3));
      (Some st_4)).

  Definition rsi_set_ttbr0_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
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

  Definition rsi_data_make_root_rtt_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((find_granule_spec v_0 st));
    rely ((((v_2.(pbase)) = ("granules")) \/ (((v_2.(pbase)) = ("null")))));
    if (ptr_eqb v_2 (mkPtr "null" 0))
    then (
      when v_4, st_1 == ((pack_return_code_spec 1 22 st_0));
      (Some (v_4, st_1)))
    else (
      when v_7, st_1 == ((granule_try_lock_spec v_2 1 st_0));
      if v_7
      then (
        when v_9, st_2 == ((granule_map_spec v_2 1 st_1));
        when st_3 == ((s2tt_init_unassigned_spec v_9 1 st_2));
        when st_4 == ((granule_unlock_transition_spec v_2 5 st_3));
        (Some (0, st_4)))
      else (Some (0, st_1))).

  Definition rsi_expected_result_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0 =? (3221225482)) || ((v_0 =? (3221225491))))
    then (
      if (v_0 =? (3221225482))
      then (Some (false, st))
      else (
        when v_4, st_0 == ((pack_return_code_spec 9 1234 st));
        (Some (((v_4 - (v_1)) =? (0)), st_0))))
    else (
      when v_8, st_1 == ((pack_return_code_spec 8 0 st));
      (Some (((v_8 - (v_1)) =? (0)), st_1))).

  Definition smc_granule_delegate_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 0 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      when st_1 == ((granule_set_state_spec v_3 1 st_0));
      when v_7, st_2 == ((set_pas_realm_spec v_0 st_1));
      when st_3 == ((clear_tte_ns_spec v_0 st_2));
      if (v_7 =? (0))
      then (
        when st_4 == ((granule_memzero_spec v_3 1 st_3));
        when st_6 == ((granule_unlock_spec v_3 st_4));
        (Some (0, st_6)))
      else (
        when st_5 == ((granule_unlock_spec v_3 st_3));
        when v_12, st_6 == ((pack_return_code_spec 1 1 st_5));
        (Some (v_12, st_6)))).

  Definition smc_granule_undelegate_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 1 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((pack_return_code_spec 1 1 st_0));
      (Some (v_5, st_1)))
    else (
      when st_1 == ((set_pas_ns_spec v_0 st_0));
      when st_2 == ((granule_set_state_spec v_3 0 st_1));
      when st_3 == ((set_tte_ns_spec v_0 st_2));
      when st_4 == ((granule_unlock_spec v_3 st_3));
      (Some (0, st_4))).

  Definition rsi_data_set_attrs_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "rsi_data_set_attrs" st));
    when v_7, st_1 == ((find_lock_granule_spec v_0 5 st_0));
    rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
    rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
    if (ptr_eqb v_7 (mkPtr "null" 0))
    then (
      when v_9, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_4 == ((free_stack "rsi_data_set_attrs" st_0 st_2));
      (Some (v_9, st_4)))
    else (
      when st_2 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) v_7 0 64 v_1 3 st_1));
      rely ((((st_2.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
      when v__sroa_0_0_copyload_tmp, st_3 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_2));
      when v__sroa_6_0_copyload, st_4 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_3));
      if (v__sroa_6_0_copyload =? (3))
      then (rsi_data_set_attrs_0_low st_0 st_4 v_2 v__sroa_0_0_copyload_tmp v__sroa_6_0_copyload)
      else (
        when v_14, st_5 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_4));
        when st_7 == ((granule_unlock_spec (int_to_ptr v__sroa_0_0_copyload_tmp) st_5));
        when st_9 == ((free_stack "rsi_data_set_attrs" st_0 st_7));
        (Some (v_14, st_9)))).

  Definition timer_condition_met_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (5)) =? (5)), st)).

  Definition timer_is_masked_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (2)) <>? (0)), st)).

  Definition read_ap0r_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_9, st_0 == ((iasm_98_spec st));
      (Some (v_9, st_0)))
    else (
      if (v_0 =? (3))
      then (
        when v_3, st_0 == ((iasm_99_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (2))
        then (
          when v_5, st_0 == ((iasm_100_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (1))
          then (
            when v_7, st_0 == ((iasm_101_spec st));
            (Some (v_7, st_0)))
          else (Some (0, st))))).

  Definition read_ap1r_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_9, st_0 == ((iasm_102_spec st));
      (Some (v_9, st_0)))
    else (
      if (v_0 =? (3))
      then (
        when v_3, st_0 == ((iasm_103_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (2))
        then (
          when v_5, st_0 == ((iasm_104_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (1))
          then (
            when v_7, st_0 == ((iasm_105_spec st));
            (Some (v_7, st_0)))
          else (Some (0, st))))).

  Definition read_lr_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if (v_0 =? (0))
    then (
      when v_33, st_0 == ((iasm_117_spec st));
      (Some (v_33, st_0)))
    else (
      if (v_0 =? (15))
      then (
        when v_3, st_0 == ((iasm_118_spec st));
        (Some (v_3, st_0)))
      else (
        if (v_0 =? (14))
        then (
          when v_5, st_0 == ((iasm_119_spec st));
          (Some (v_5, st_0)))
        else (
          if (v_0 =? (13))
          then (
            when v_7, st_0 == ((iasm_120_spec st));
            (Some (v_7, st_0)))
          else (
            if (v_0 =? (12))
            then (
              when v_9, st_0 == ((iasm_121_spec st));
              (Some (v_9, st_0)))
            else (
              if (v_0 =? (11))
              then (
                when v_11, st_0 == ((iasm_122_spec st));
                (Some (v_11, st_0)))
              else (
                if (v_0 =? (10))
                then (
                  when v_13, st_0 == ((iasm_123_spec st));
                  (Some (v_13, st_0)))
                else (
                  if (v_0 =? (9))
                  then (
                    when v_15, st_0 == ((iasm_124_spec st));
                    (Some (v_15, st_0)))
                  else (
                    if (v_0 =? (8))
                    then (
                      when v_17, st_0 == ((iasm_125_spec st));
                      (Some (v_17, st_0)))
                    else (
                      if (v_0 =? (7))
                      then (
                        when v_19, st_0 == ((iasm_126_spec st));
                        (Some (v_19, st_0)))
                      else (
                        if (v_0 =? (6))
                        then (
                          when v_21, st_0 == ((iasm_127_spec st));
                          (Some (v_21, st_0)))
                        else (
                          if (v_0 =? (5))
                          then (
                            when v_23, st_0 == ((iasm_128_spec st));
                            (Some (v_23, st_0)))
                          else (
                            if (v_0 =? (4))
                            then (
                              when v_25, st_0 == ((iasm_129_spec st));
                              (Some (v_25, st_0)))
                            else (
                              if (v_0 =? (3))
                              then (
                                when v_27, st_0 == ((iasm_130_spec st));
                                (Some (v_27, st_0)))
                              else (
                                if (v_0 =? (2))
                                then (
                                  when v_29, st_0 == ((iasm_131_spec st));
                                  (Some (v_29, st_0)))
                                else (
                                  if (v_0 =? (1))
                                  then (
                                    when v_31, st_0 == ((iasm_132_spec st));
                                    (Some (v_31, st_0)))
                                  else (Some (0, st))))))))))))))))).

  Fixpoint gic_restore_state_loop219 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv, st))
    | (S _N__0) =>
      match ((gic_restore_state_loop219 _N__0 __break__ v_0 v_indvars_iv st)) with
      | (Some (__break___0, v_1, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (16)))));
          when v_19, st_1 == ((load_RData 8 (ptr_offset v_1 (80 + ((8 * (v_indvars_iv_0))))) st_0));
          when st_2 == ((write_lr_spec v_indvars_iv_0 v_19 st_1));
          when v_21, st_3 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_2));
          if (((v_indvars_iv_0 + (1)) - (v_21)) <? (0))
          then (Some (false, v_1, (v_indvars_iv_0 + (1)), st_3))
          else (Some (true, v_1, v_indvars_iv_0, st_3)))
      | None => None
      end
    end.

  Fixpoint gic_restore_state_loop214 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv22: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv22, st))
    | (S _N__0) =>
      match ((gic_restore_state_loop214 _N__0 __break__ v_0 v_indvars_iv22 st)) with
      | (Some (__break___0, v_1, v_indvars_iv22_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv22_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv22_0)) <= (0)) /\ ((v_indvars_iv22_0 < (4)))));
          when v_6, st_1 == ((load_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv22_0))) st_0));
          when st_2 == ((write_ap0r_spec v_indvars_iv22_0 v_6 st_1));
          when v_9, st_3 == ((load_RData 8 (ptr_offset v_1 (32 + ((8 * (v_indvars_iv22_0))))) st_2));
          when st_4 == ((write_ap1r_spec v_indvars_iv22_0 v_9 st_3));
          when v_11, st_5 == ((load_RData 4 (mkPtr "nr_aprs" 0) st_4));
          if (((v_indvars_iv22_0 + (1)) - (v_11)) <? (0))
          then (Some (false, v_1, (v_indvars_iv22_0 + (1)), st_5))
          else (Some (true, v_1, v_indvars_iv22_0, st_5)))
      | None => None
      end
    end.

  Definition gic_restore_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((load_RData 4 (mkPtr "nr_aprs" 0) st));
    if ((0 - (v_2)) <? (0))
    then (
      rely (((gic_restore_state_loop214_rank v_0 0) >= (0)));
      match ((gic_restore_state_loop214 (z_to_nat (gic_restore_state_loop214_rank v_0 0)) false v_0 0 st_0)) with
      | (Some (__break__, v_1, v_indvars_iv22_0, st_1)) =>
        when v_15, st_3 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_1));
        if ((0 - (v_15)) <? (0))
        then (gic_restore_state_0_low st_3 v_0 v_15)
        else (
          when v_26, st_5 == ((load_RData 8 (ptr_offset v_0 64) st_3));
          when st_6 == ((iasm_35_spec v_26 st_5));
          when v_28, st_7 == ((load_RData 8 (ptr_offset v_0 72) st_6));
          when st_8 == ((iasm_36_spec v_28 st_7));
          (Some st_8))
      | None => None
      end)
    else (
      when v_15, st_2 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_0));
      if ((0 - (v_15)) <? (0))
      then (gic_restore_state_1_low st_2 v_0 v_15)
      else (
        when v_26, st_4 == ((load_RData 8 (ptr_offset v_0 64) st_2));
        when st_5 == ((iasm_35_spec v_26 st_4));
        when v_28, st_6 == ((load_RData 8 (ptr_offset v_0 72) st_5));
        when st_7 == ((iasm_36_spec v_28 st_6));
        (Some st_7))).

  Definition feat_vmid16_spec (st: RData) : (option (bool * RData)) :=
    when v_1, st_0 == ((iasm_31_spec st));
    (Some (((v_1 & (240)) <>? (0)), st_0)).

  Definition validate_map_addr_spec' (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ (((0 - (((v_2.(poffset)) mod (4096)))) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    when ret, st' == ((realm_ipa_bits_spec' v_2 st));
    if (ret =? (64))
    then (
      if ((1 - (v_0)) >? (0))
      then (
        if ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_rd)).(e_is_rc_s_rd)) =? (0))
        then (
          if ((((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))))) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st)))
        else (
          if (((((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (v_0)) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st))))
      else (Some (1, st)))
    else (
      if (((1 << (ret)) - (v_0)) >? (0))
      then (
        if ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_rd)).(e_is_rc_s_rd)) =? (0))
        then (
          if ((((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))))) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st)))
        else (
          if (((((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295)))) & (v_0)) - (v_0)) =? (0))
          then (Some (0, st))
          else (Some (1, st))))
      else (Some (1, st))).

  Definition validate_map_addr_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((validate_map_addr_spec' v_0 v_1 v_2 st));
    (Some (ret, st)).
(* 
  Definition validate_map_addr_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((0 = (((v_2.(poffset)) mod (4096)))))));
    rely ((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_RD)));
    when v_4, st == ((realm_ipa_size_spec v_2 st));
    let v__not := (v_4 >? (v_0)) in
    when v__sroa_0_0, st == (
        let v__sroa_0_0 := 0 in
        if v__not
        then (
          let v_8 := (ptr_offset v_2 ((416 * (0)) + ((408 + (0))))) in
          rely ((408 = (((v_8.(poffset)) mod (4096)))));
          when v_9, st == ((load_RData 8 v_8 st));
          let v__not8 := (v_9 =? (0)) in
          when v__0_in, st == (
              let v__0_in := false in
              if v__not8
              then (
                when v_13, st == ((addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_13 in
                (Some (v__0_in, st)))
              else (
                when v_11, st == ((s1addr_is_level_aligned_spec v_0 v_1 st));
                let v__0_in := v_11 in
                (Some (v__0_in, st))));
          when v__sroa_0_0, st == (
              let v__sroa_0_0 := 0 in
              if v__0_in
              then (
                when v_18, st == ((make_return_code_spec 0 0 st));
                let v__sroa_0_0 := v_18 in
                (Some (v__sroa_0_0, st)))
              else (
                when v_16, st == ((make_return_code_spec 1 0 st));
                let v__sroa_0_0 := v_16 in
                (Some (v__sroa_0_0, st))));
          (Some (v__sroa_0_0, st)))
        else (
          when v_6, st == ((make_return_code_spec 1 0 st));
          let v__sroa_0_0 := v_6 in
          (Some (v__sroa_0_0, st))));
    let __return__ := true in
    let __retval__ := v__sroa_0_0 in
    (Some (__retval__, st)). *)

  Definition rmm_feature_register_0_value_spec (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((max_pa_size_spec st));
    (Some (v_1, st_0)).

End Layer9_Spec.

#[global] Hint Unfold gic_restore_state_loop214_rank: spec.
#[global] Hint Unfold gic_restore_state_loop219_rank: spec.
#[global] Hint Unfold rsi_rtt_set_ripas_spec: spec.
#[global] Hint Unfold rsi_rtt_unmap_non_secure_spec: spec.
#[global] Hint Unfold rsi_rtt_create_spec: spec.
#[global] Hint Unfold rsi_data_destroy_spec: spec.
#[global] Hint Unfold rsi_rtt_destroy_spec: spec.
#[global] Hint Unfold rsi_data_map_extra_spec: spec.
#[global] Hint Unfold rsi_data_create_s1_spec: spec.
#[global] Hint Unfold rsi_data_create_unknown_s1_spec: spec.
#[global] Hint Unfold rsi_data_read_loop175: spec.
#[global] Hint Unfold rsi_data_read_spec: spec.
#[global] Hint Unfold rsi_rtt_map_non_secure_spec: spec.
#[global] Hint Unfold rsi_data_write_loop104: spec.
#[global] Hint Unfold rsi_data_write_spec: spec.
#[global] Hint Unfold rsi_set_ttbr0_spec: spec.
#[global] Hint Unfold rsi_data_make_root_rtt_spec: spec.
#[global] Hint Unfold rsi_expected_result_spec: spec.
#[global] Hint Unfold smc_granule_delegate_spec: spec.
#[global] Hint Unfold smc_granule_undelegate_spec: spec.
#[global] Hint Unfold rsi_data_set_attrs_spec: spec.
#[global] Hint Unfold timer_condition_met_spec: spec.
#[global] Hint Unfold timer_is_masked_spec: spec.
#[global] Hint Unfold read_ap0r_spec: spec.
#[global] Hint Unfold read_ap1r_spec: spec.
#[global] Hint Unfold read_lr_spec: spec.
#[global] Hint Unfold gic_restore_state_loop219: spec.
#[global] Hint Unfold gic_restore_state_loop214: spec.
#[global] Hint Unfold gic_restore_state_spec: spec.
#[global] Hint Unfold feat_vmid16_spec: spec.
#[global] Hint Unfold validate_map_addr_spec: spec.
#[global] Hint Unfold rmm_feature_register_0_value_spec: spec.
