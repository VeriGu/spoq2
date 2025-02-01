Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer7_data_create_internal_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition data_create_internal_0_low (st_0: RData) (st_14: RData) (v_18: Ptr) (v_2: Z) (v_41: abs_PTE_t) (v_5: Z) (v_9: Ptr) (v__sroa_0_0_copyload: Ptr) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_5 =? (0)) = (true)));
    when st_17 == ((stage1_tlbi_all_spec st_14));
    when st_18 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_41 st_17));
    when st_19 == ((iasm_8_spec st_18));
    when st_20 == ((iasm_12_isb_spec st_19));
    when st_21 == ((__granule_get_spec v__sroa_0_0_copyload st_20));
    when st_22 == ((g_mapped_addr_set_spec v_9 v_2 st_21));
    when st_23 == ((__granule_get_spec v_9 st_22));
    when st_24 == ((granule_unlock_spec v__sroa_0_0_copyload st_23));
    when st_15 == ((free_stack "data_create_internal" st_0 st_24));
    (Some (0, st_15)).

  Definition data_create_internal_1_low (st_0: RData) (st_13: RData) (v_0: abs_PTE_t) (v_18: Ptr) (v_2: Z) (v_5: Z) (v_9: Ptr) (v__sroa_0_0_copyload: Ptr) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_5 =? (0)) = (true)));
    when st_16 == ((stage1_tlbi_all_spec st_13));
    when st_17 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_0 st_16));
    when st_18 == ((iasm_8_spec st_17));
    when st_19 == ((iasm_12_isb_spec st_18));
    when st_20 == ((__granule_get_spec v__sroa_0_0_copyload st_19));
    when st_21 == ((g_mapped_addr_set_spec v_9 v_2 st_20));
    when st_22 == ((__granule_get_spec v_9 st_21));
    when st_23 == ((granule_unlock_spec v__sroa_0_0_copyload st_22));
    when st_14 == ((free_stack "data_create_internal" st_0 st_23));
    (Some (0, st_14)).

  Definition data_create_internal_2_low (st_0: RData) (st_21: RData) (v_18: Ptr) (v_2: Z) (v_41: abs_PTE_t) (v_5: Z) (v_9: Ptr) (v__sroa_0_0_copyload: Ptr) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_5 =? (0)) = (true)));
    when st_22 == ((stage1_tlbi_all_spec st_21));
    when st_23 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_41 st_22));
    when st_24 == ((iasm_8_spec st_23));
    when st_25 == ((iasm_12_isb_spec st_24));
    when st_26 == ((__granule_get_spec v__sroa_0_0_copyload st_25));
    when st_27 == ((g_mapped_addr_set_spec v_9 v_2 st_26));
    when st_28 == ((__granule_get_spec v_9 st_27));
    when st_29 == ((granule_unlock_spec v__sroa_0_0_copyload st_28));
    when st_30 == ((free_stack "data_create_internal" st_0 st_29));
    (Some (0, st_30)).

  Definition data_create_internal_3_low (st_0: RData) (st_20: RData) (v_0: abs_PTE_t) (v_18: Ptr) (v_2: Z) (v_5: Z) (v_9: Ptr) (v__sroa_0_0_copyload: Ptr) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely (((v_5 =? (0)) = (true)));
    when st_21 == ((stage1_tlbi_all_spec st_20));
    when st_22 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_0 st_21));
    when st_23 == ((iasm_8_spec st_22));
    when st_24 == ((iasm_12_isb_spec st_23));
    when st_25 == ((__granule_get_spec v__sroa_0_0_copyload st_24));
    when st_26 == ((g_mapped_addr_set_spec v_9 v_2 st_25));
    when st_27 == ((__granule_get_spec v_9 st_26));
    when st_28 == ((granule_unlock_spec v__sroa_0_0_copyload st_27));
    when st_29 == ((free_stack "data_create_internal" st_0 st_28));
    (Some (0, st_29)).

  Definition data_create_internal_spec_low (v_0: Z) (v_1: Ptr) (v_2: Z) (v_3: Ptr) (v_4: Ptr) (v_5: Z) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "data_create_internal" st));
    let v_0_pte := (test_Z_PTE v_0) in
    rely (((((((st_0.(share)).(granule_data)) @ ((v_4.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_4.(pbase)) = ("granule_data")) /\ ((((v_4.(poffset)) mod (4096)) = (0)))) /\ (((v_4.(poffset)) >= (0)))));
    rely (((((v_3.(pbase)) = ("granules")) /\ ((((v_3.(poffset)) mod (16)) = (0)))) /\ (((v_3.(poffset)) >= (0)))));
    when v_8, st_1 == ((s1tte_pa_spec_abs v_0_pte st_0));
    when v_9, st_2 == ((find_granule_spec_abs v_8 st_1));
    rely ((((v_9.(pbase)) = ("granules")) \/ (((v_9.(pbase)) = ("null")))));
    if (ptr_eqb v_9 (mkPtr "null" 0))
    then (
      when v_11, st_3 == ((pack_return_code_spec 1 1 st_2));
      when st_5 == ((free_stack "data_create_internal" st_0 st_3));
      (Some (v_11, st_5)))
    else (
      when rtt_ret, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_1 0 64 v_2 3 st_2));
      rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
      let v__sroa_0_0_copyload := (rtt_ret.(e_2)) in
      let v__sroa_6_0_copyload := (rtt_ret.(e_1)) in
      let st_6 := st_4 in
      if (v__sroa_6_0_copyload =? (3))
      then (
        let v__sroa_4_0_copyload := (rtt_ret.(e_3)) in
        when v_18, st_9 == ((granule_map_spec v__sroa_0_0_copyload 6 st_6));
        when v_21, st_10 == ((abs__tte_read_spec (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) st_9));
        when v_22, st_11 == ((s2tte_is_unassigned_spec_abs v_21 st_10));
        if v_22
        then (
          if (ptr_eqb v_3 (mkPtr "null" 0))
          then (
            when v_37, st_13 == ((s2tte_get_ripas_spec_abs v_21 st_11));
            if (v_37 =? (0))
            then (
              when v_41, st_14 == ((s2tte_create_assigned_spec_abs v_8 3 st_13));
              if (v_5 =? (0))
              then (data_create_internal_0_low st_0 st_14 v_18 v_2 v_41 v_5 v_9 v__sroa_0_0_copyload v__sroa_4_0_copyload)
              else (
                when v_46, st_16 == ((s1tte_create_valid_spec_abs v_8 3 st_14));
                when st_18 == ((stage1_tlbi_all_spec st_16));
                when st_19 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_46 st_18));
                when st_20 == ((iasm_8_spec st_19));
                when st_21 == ((iasm_12_isb_spec st_20));
                when st_22 == ((__granule_get_spec v__sroa_0_0_copyload st_21));
                when st_23 == ((g_mapped_addr_set_spec v_9 v_2 st_22));
                when st_24 == ((__granule_get_spec v_9 st_23));
                when st_25 == ((granule_unlock_spec v__sroa_0_0_copyload st_24));
                when st_15 == ((free_stack "data_create_internal" st_0 st_25));
                (Some (0, st_15))))
            else (
              if (v_5 =? (0))
              then (data_create_internal_1_low st_0 st_13 v_0_pte v_18 v_2 v_5 v_9 v__sroa_0_0_copyload v__sroa_4_0_copyload)
              else (
                when v_46, st_15 == ((s1tte_create_valid_spec_abs v_8 3 st_13));
                when st_17 == ((stage1_tlbi_all_spec st_15));
                when st_18 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_46 st_17));
                when st_19 == ((iasm_8_spec st_18));
                when st_20 == ((iasm_12_isb_spec st_19));
                when st_21 == ((__granule_get_spec v__sroa_0_0_copyload st_20));
                when st_22 == ((g_mapped_addr_set_spec v_9 v_2 st_21));
                when st_23 == ((__granule_get_spec v_9 st_22));
                when st_24 == ((granule_unlock_spec v__sroa_0_0_copyload st_23));
                when st_14 == ((free_stack "data_create_internal" st_0 st_24));
                (Some (0, st_14)))))
          else (
            let v_28 := (rec_to_rd_para v_4 st_11) in
            when st_13 == ((granule_lock_spec v_28 2 st_11));
            when v_29, st_14 == ((granule_map_spec v_9 1 st_13));
            when v_30, st_15 == ((granule_addr_spec_abs v_3 st_14));
            when v_31, st_16 == ((ns_buffer_read_spec_abs 0 v_30 4096 v_29 st_15));
            when st_17 == ((ns_buffer_unmap_spec 0 st_16));
            if v_31
            then (
              when st_18 == ((granule_unlock_spec v_28 st_17));
              when v_37, st_20 == ((s2tte_get_ripas_spec_abs v_21 st_18));
              if (v_37 =? (0))
              then (
                when v_41, st_21 == ((s2tte_create_assigned_spec_abs v_8 3 st_20));
                if (v_5 =? (0))
                then (data_create_internal_2_low st_0 st_21 v_18 v_2 v_41 v_5 v_9 v__sroa_0_0_copyload v__sroa_4_0_copyload)
                else (
                  when v_46, st_22 == ((s1tte_create_valid_spec_abs v_8 3 st_21));
                  when st_23 == ((stage1_tlbi_all_spec st_22));
                  when st_24 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_46 st_23));
                  when st_25 == ((iasm_8_spec st_24));
                  when st_26 == ((iasm_12_isb_spec st_25));
                  when st_27 == ((__granule_get_spec v__sroa_0_0_copyload st_26));
                  when st_28 == ((g_mapped_addr_set_spec v_9 v_2 st_27));
                  when st_29 == ((__granule_get_spec v_9 st_28));
                  when st_30 == ((granule_unlock_spec v__sroa_0_0_copyload st_29));
                  when st_31 == ((free_stack "data_create_internal" st_0 st_30));
                  (Some (0, st_31))))
              else (
                if (v_5 =? (0))
                then (data_create_internal_3_low st_0 st_20 v_0_pte v_18 v_2 v_5 v_9 v__sroa_0_0_copyload v__sroa_4_0_copyload)
                else (
                  when v_46, st_21 == ((s1tte_create_valid_spec_abs v_8 3 st_20));
                  when st_22 == ((stage1_tlbi_all_spec st_21));
                  when st_23 == ((__tte_write_spec_abs (ptr_offset v_18 (8 * (v__sroa_4_0_copyload))) v_46 st_22));
                  when st_24 == ((iasm_8_spec st_23));
                  when st_25 == ((iasm_12_isb_spec st_24));
                  when st_26 == ((__granule_get_spec v__sroa_0_0_copyload st_25));
                  when st_27 == ((g_mapped_addr_set_spec v_9 v_2 st_26));
                  when st_28 == ((__granule_get_spec v_9 st_27));
                  when st_29 == ((granule_unlock_spec v__sroa_0_0_copyload st_28));
                  when st_30 == ((free_stack "data_create_internal" st_0 st_29));
                  (Some (0, st_30)))))
            else (
              when v_33, st_18 == ((memset_spec v_29 0 4096 st_17));
              when st_19 == ((granule_unlock_spec v_28 st_18));
              when v_34, st_20 == ((pack_return_code_spec 1 4 st_19));
              when st_21 == ((granule_unlock_spec v__sroa_0_0_copyload st_20));
              when st_23 == ((free_stack "data_create_internal" st_0 st_21));
              (Some (v_34, st_23)))))
        else (
          when v_24, st_12 == ((pack_return_code_spec 9 0 st_11));
          when st_13 == ((granule_unlock_spec v__sroa_0_0_copyload st_12));
          when st_15 == ((free_stack "data_create_internal" st_0 st_13));
          (Some (v_24, st_15))))
      else (
        when v_16, st_7 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_6));
        when st_8 == ((granule_unlock_spec v__sroa_0_0_copyload st_7));
        when st_10 == ((free_stack "data_create_internal" st_0 st_8));
        (Some (v_16, st_10)))).

End Layer7_data_create_internal_LowSpec.

#[global] Hint Unfold data_create_internal_0_low: spec.
#[global] Hint Unfold data_create_internal_1_low: spec.
#[global] Hint Unfold data_create_internal_2_low: spec.
#[global] Hint Unfold data_create_internal_3_low: spec.
#[global] Hint Unfold data_create_internal_spec_low: spec.
