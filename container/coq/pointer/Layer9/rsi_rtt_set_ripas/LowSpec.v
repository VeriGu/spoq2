Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer9_rsi_rtt_set_ripas_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition rsi_rtt_set_ripas_0_low (st_0: RData) (st_10: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload: Ptr) (v__sroa_3_0_copyload: Z) (tte_to_write: abs_PTE_t) : (option (Z * RData)) :=
    rely ((v_38 = (true)));
    when st_12 == ((__tte_write_spec_abs (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) tte_to_write st_10));
    when st_13 == ((iasm_8_spec st_12));
    when st_14 == ((stage1_tlbi_all_spec st_13));
    when st_16 == ((granule_unlock_spec v__sroa_0_0_copyload st_14));
    when st_15 == ((free_stack "rsi_rtt_set_ripas" st_0 st_16));
    (Some (0, st_15)).

  Definition rsi_rtt_set_ripas_1_low (st_0: RData) (st_14: RData) (v_34: Ptr) (v_38: bool) (v__sroa_0_0_copyload: Ptr) (v__sroa_3_0_copyload: Z) (tte_to_write: abs_PTE_t) : (option (Z * RData)) :=
    rely ((v_38 = (true)));
    when st_16 == ((__tte_write_spec_abs (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) tte_to_write st_14));
    when st_17 == ((iasm_8_spec st_16));
    when st_18 == ((stage1_tlbi_all_spec st_17));
    when st_19 == ((granule_unlock_spec v__sroa_0_0_copyload st_18));
    when st_20 == ((free_stack "rsi_rtt_set_ripas" st_0 st_19));
    (Some (0, st_20)).

  Definition rsi_rtt_set_ripas_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    let v_0_pa := (test_PA v_0) in
    when st_0 == ((new_frame "rsi_rtt_set_ripas" st));
    if (v_3 >? (1))
    then (
      when st_2 == ((free_stack "rsi_rtt_set_ripas" st_0 st_0));
      (Some (1, st_2)))
    else (
      if (check_rcsm_mask_para v_0_pa)
      then (
        when v_24, st_1 == ((find_lock_granule_spec_abs v_0_pa 5 st_0));
        rely (((((v_24.(poffset)) mod (16)) = (0)) /\ (((v_24.(poffset)) >= (0)))));
        rely ((((v_24.(pbase)) = ("granules")) \/ (((v_24.(pbase)) = ("null")))));
        if (ptr_eqb v_24 (mkPtr "null" 0))
        then (
          when v_26, st_2 == ((pack_return_code_spec 1 1 st_1));
          when st_4 == ((free_stack "rsi_rtt_set_ripas" st_0 st_2));
          (Some (v_26, st_4)))
        else (
          when rtt_ret, st_3 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_24 0 64 v_1 v_2 st_1));
          let v__sroa_0_0_copyload := (rtt_ret.(e_2)) in
          let v__sroa_5_0_copyload := (rtt_ret.(e_1)) in
          let st_5 := st_3 in
          if ((v__sroa_5_0_copyload - (v_2)) =? (0))
          then (
            let v__sroa_3_0_copyload := (rtt_ret.(e_3)) in
            when v_34, st_7 == ((granule_map_spec v__sroa_0_0_copyload 6 st_5));
            when v_37, st_8 == ((abs__tte_read_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) st_7));
            when v_38, pte_to_write == ((update_ripas_spec_abs v_37 v_2 v_3 st_8));
            let st_10 := st_8 in
            if v_38
            then (rsi_rtt_set_ripas_0_low st_0 st_10 v_34 v_38 v__sroa_0_0_copyload v__sroa_3_0_copyload pte_to_write)
            else (
              when v_41, st_11 == ((pack_return_code_spec 8 v_2 st_10));
              when st_13 == ((granule_unlock_spec v__sroa_0_0_copyload st_11));
              when st_12 == ((free_stack "rsi_rtt_set_ripas" st_0 st_13));
              (Some (v_41, st_12))))
          else (
            when v_31, st_6 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_5));
            when st_7 == ((granule_unlock_spec v__sroa_0_0_copyload st_6));
            when st_8 == ((free_stack "rsi_rtt_set_ripas" st_0 st_7));
            (Some (v_31, st_8)))))
      else (
        when v_14, st_1 == ((find_lock_granule_spec_abs v_0_pa 3 st_0));
        rely (((((v_14.(poffset)) mod (16)) = (0)) /\ (((v_14.(poffset)) >= (0)))));
        rely ((((v_14.(pbase)) = ("granules")) \/ (((v_14.(pbase)) = ("null")))));
        if (ptr_eqb v_14 (mkPtr "null" 0))
        then (
          when v_16, st_2 == ((pack_return_code_spec 1 1 st_1));
          when st_4 == ((free_stack "rsi_rtt_set_ripas" st_0 st_2));
          (Some (v_16, st_4)))
        else (
          when v_19, st_2 == ((granule_map_spec v_14 3 st_1));
          let v_22 := (rec_to_ttbr1_para v_19 st_2) in
          when st_4 == ((granule_lock_spec v_22 5 st_2));
          when st_5 == ((granule_unlock_spec v_14 st_4));
          when ret_rtt, st_7 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) v_22 0 64 v_1 v_2 st_5));
          rely ((((st_7.(share)).(granule_data)) = (((st_5.(share)).(granule_data)))));
          let v__sroa_0_0_copyload := (ret_rtt.(e_2)) in
          let v__sroa_5_0_copyload := (ret_rtt.(e_1)) in
          let st_9 := st_7 in
          if ((v__sroa_5_0_copyload - (v_2)) =? (0))
          then (
            let v__sroa_3_0_copyload := (ret_rtt.(e_3)) in
            when v_34, st_11 == ((granule_map_spec v__sroa_0_0_copyload 6 st_9));
            when v_37, st_12 == ((abs__tte_read_spec (ptr_offset v_34 (8 * (v__sroa_3_0_copyload))) st_11));
            when v_38, pte_to_write == ((update_ripas_spec_abs v_37 v_2 v_3 st_12));
            let st_10 := st_7 in
            if v_38
            then (rsi_rtt_set_ripas_1_low st_0 st_12 v_34 v_38 v__sroa_0_0_copyload v__sroa_3_0_copyload pte_to_write)
            else (
              when v_41, st_15 == ((pack_return_code_spec 8 v_2 st_12));
              when st_16 == ((granule_unlock_spec v__sroa_0_0_copyload st_15));
              when st_17 == ((free_stack "rsi_rtt_set_ripas" st_0 st_16));
              (Some (v_41, st_17))))
          else (
            when v_31, st_10 == ((pack_return_code_spec 8 v__sroa_5_0_copyload st_9));
            when st_11 == ((granule_unlock_spec v__sroa_0_0_copyload st_10));
            when st_12 == ((free_stack "rsi_rtt_set_ripas" st_0 st_11));
            (Some (v_31, st_12)))))).

End Layer9_rsi_rtt_set_ripas_LowSpec.

#[global] Hint Unfold rsi_rtt_set_ripas_0_low: spec.
#[global] Hint Unfold rsi_rtt_set_ripas_1_low: spec.
#[global] Hint Unfold rsi_rtt_set_ripas_spec_low: spec.
