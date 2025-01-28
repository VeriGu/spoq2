Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer13_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition smc_data_dispose_0_low (st_0: RData) (st_26: RData) (v_70: Ptr) (v_74: bool) (v__sroa_032_0_copyload_tmp: Z) (v__sroa_3_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_74 = (true)));
    when v_78, st_27 == ((s2tte_create_unassigned_spec 1 st_26));
    when st_28 == ((__tte_write_spec (ptr_offset v_70 (8 * (v__sroa_3_0_copyload))) v_78 st_27));
    when st_31 == ((granule_unlock_spec (int_to_ptr v__sroa_032_0_copyload_tmp) st_28));
    when v_83_tmp, st_37 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_31));
    when st_38 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_37));
    when v_84_tmp, st_39 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_38));
    when st_40 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_39));
    when st_43 == ((free_stack "smc_data_dispose" st_0 st_40));
    (Some (0, st_43)).

  Definition smc_data_dispose_1_low (st_0: RData) (st_8: RData) (v_34: Z) : (option (Z * RData)) :=
    rely ((((v_34 & (1)) =? (0)) = (true)));
    when v_37, st_9 == ((pack_return_code_spec 7 0 st_8));
    when v_83_tmp, st_13 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_9));
    when st_14 == ((granule_unlock_spec (int_to_ptr v_83_tmp) st_13));
    when v_84_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_14));
    when st_16 == ((granule_unlock_spec (int_to_ptr v_84_tmp) st_15));
    when st_19 == ((free_stack "smc_data_dispose" st_0 st_16));
    (Some (v_37, st_19)).

  Definition smc_data_destroy_0_low (st_0: RData) (st_15: RData) (v_25: Ptr) (v_28: Z) (v_29: bool) (v__sroa_016_0_copyload_tmp: Z) (v__sroa_4_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_29 = (true)));
    when v_33, st_16 == ((s2tte_pa_spec v_28 3 st_15));
    when st_17 == ((__tte_write_spec (ptr_offset v_25 (8 * (v__sroa_4_0_copyload))) 8 st_16));
    when st_18 == ((__granule_put_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_17));
    when v_34, st_19 == ((find_lock_granule_spec v_33 4 st_18));
    rely (((((v_34.(poffset)) mod (16)) = (0)) /\ (((v_34.(poffset)) >= (0)))));
    rely ((((v_34.(pbase)) = ("granules")) \/ (((v_34.(pbase)) = ("null")))));
    when st_20 == ((granule_memzero_spec v_34 1 st_19));
    when st_21 == ((granule_unlock_transition_spec v_34 1 st_20));
    when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_016_0_copyload_tmp) st_21));
    when st_27 == ((free_stack "smc_data_destroy" st_0 st_24));
    (Some (0, st_27)).

  Definition smc_rtt_map_protected_0_low (st_0: RData) (st_15: RData) (v_2: Z) (v_26: Ptr) (v_29: Z) (v_30: bool) (v__sroa_018_0_copyload_tmp: Z) (v__sroa_320_0_copyload: Z) : (option (Z * RData)) :=
    rely ((v_30 = (true)));
    when v_34, st_16 == ((s2tte_pa_spec v_29 v_2 st_15));
    when v_35, st_17 == ((s2tte_create_valid_spec v_34 v_2 st_16));
    when st_18 == ((__tte_write_spec (ptr_offset v_26 (8 * (v__sroa_320_0_copyload))) v_35 st_17));
    when st_21 == ((granule_unlock_spec (int_to_ptr v__sroa_018_0_copyload_tmp) st_18));
    when st_20 == ((free_stack "smc_rtt_map_protected" st_0 st_21));
    (Some (0, st_20)).

  Definition smc_realm_destroy_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) /\ (((v_0 & (4095)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    rely (
      (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
        (((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
        (0)));
    rely ((((((((((lens 2 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0)) = (true)));
    rely (((((((((((lens 28 st).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_ref)).(e_u_anon_3_0)) & (4095)) =? (0)) = (true)));
    rely (
      ((((4096 * (((v_0 + ((- MEM0_PHYS))) >> (12)))) >= (0)) /\ ((((- 2147483648) + ((4096 * (((v_0 + ((- MEM0_PHYS))) >> (12)))))) < (0)))) /\
        (((((4096 * (((v_0 + ((- MEM0_PHYS))) >> (12)))) + (2147483648)) & (549755813888)) = (0)))));
    rely ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_granule_state)) - (2)) = (0)));
    rely ((((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
    rely ((((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
    when sh_0 == ((((lens 28 st).(repl)) (((lens 28 st).(oracle)) ((lens 28 st).(log))) ((lens 28 st).(share))));
    rely (
      (((0 - (((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_vmid)) >> (6)))) <= (0)) /\
        ((((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_vmid)) >> (6)) < (1024)))));
    when sh_1 == ((((lens 143 st).(repl)) (((lens 139 st).(oracle)) ((lens 137 st).(log))) ((lens 141 st).(share))));
    if ((0 - ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts)))) <? (0))
    then (
      match (
        (total_root_rtt_refcount_loop295
          (z_to_nat (((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts)))
          false
          (mkPtr "granules" ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
          0
          0
          0
          (((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts))
          ((lens 150 st).[halt] :< false))
      ) with
      | (Some (__break__, v_3, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_1)) =>
        if (v__0_lcssa_0 =? (0))
        then (
          match (
            (free_sl_rtts_loop194
              (z_to_nat 0)
              false
              (mkPtr "granules" ((((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
              true
              0
              (((((((lens 28 st).(share)).(granule_data)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts))
              st_1)
          ) with
          | (Some (__break___0, v_5, v_6, v_indvars_iv_1, v_wide_trip_count_1, st_2)) =>
            when st_9 == ((granule_memzero_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) 2 st_2));
            (Some (0, ((lens 101 st_9).[halt] :< false)))
          | None => None
          end)
        else (
          when cid == (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
          (Some (4, ((lens 155 st_1).[halt] :< false))))
      | None => None
      end)
    else (
      when st_9 == ((granule_memzero_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) 2 ((lens 150 st).[halt] :< false)));
      (Some (0, ((lens 101 st_9).[halt] :< false)))).


  Definition smc_realm_create_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((GRANULES_BASE + (((((v_1 & (18446744073709547520)) + ((- MEM0_PHYS))) >> (12)) * (16)))) =? (0))
    then (Some (8589935105, st))
    else (
      when ret == ((granule_pa_to_va_spec' v_1));
      rely ((((ret.(pbase)) = ("granule_data")) /\ (((ret.(poffset)) >= (0)))));
      when v_6, st_1 == ((memcpy_ns_read_spec_state_oracle (mkPtr "stack_s_realm_params" 0) ret 64 st));
      if v_6
      then (
        rely (((((st_1.(stack)).(stack_s_realm_params)).(e_is_rc)) = (1)));
        if ((0 - ((((st_1.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
        then (
          match (
            match (
              (find_lock_transition_rtts_loop209
                (z_to_nat (((st_1.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))
                false
                0
                false
                (((st_1.(stack)).(stack_s_realm_params)).(e_rtt_addr))
                0
                (((st_1.(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts))
                st_1)
            ) with
            | (Some (__return___0, __retval___0, __break__, v_4, v_indvars_iv_0, v_wide_trip_count_0, st_2)) => (Some (__return___0, __retval___0, st_2))
            | None => None
            end
          ) with
          | (Some (__return__, __retval__, st_2)) =>
            if __return__
            then (
              if (__retval__ =? (0))
              then (
                rely (
                  (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                    (((v_0 & (4095)) = (0)))));
                when sh == (((st_2.(repl)) ((st_2.(oracle)) (st_2.(log))) (st_2.(share))));
                rely (
                  (((((((st_2.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                    (((((((lens 2 st_2).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                    (0)));
                if ((((((((lens 2 st_2).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (1)) =? (0))
                then (
                  when ret_0 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                  when ret_1 == ((buffer_map_spec' 2 ret_0 false));
                  rely ((((ret_1.(pbase)) = ("granule_data")) /\ (((ret_1.(poffset)) >= (0)))));
                  rely ((((((((lens 89 st_2).(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                  rely ((((((((lens 250 st_2).(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                  rely (((((ret_1.(pbase)) = ("granule_data")) /\ (((ret_1.(poffset)) >= (0)))) /\ ((((ret_1.(poffset)) mod (4096)) = (0)))));
                  rely ((((((lens 1716 st_2).(stack)).(stack_s_realm_params)).(e_is_rc)) = (1)));
                  if (((((lens 1899 st_2).(stack)).(stack_s_realm_params)).(e_measurement_algo)) =? (1))
                  then (Some (0, ((lens 2084 st_2).[halt] :< false)))
                  else (
                    if (((((lens 1899 st_2).(stack)).(stack_s_realm_params)).(e_measurement_algo)) =? (0))
                    then (Some (0, ((lens 2269 st_2).[halt] :< false)))
                    else (Some (0, ((lens 2271 st_2).[halt] :< false)))))
                else (
                  if ((0 - (((((lens 93 st_2).(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
                  then (
                    match (
                      (free_sl_rtts_loop194
                        (z_to_nat 0)
                        false
                        (mkPtr "granules" (((((((lens 93 st_2).(stack)).(stack_s_realm_params)).(e_rtt_addr)) + ((- MEM0_PHYS))) >> (12)) * (16)))
                        false
                        0
                        ((((lens 93 st_2).(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts))
                        ((lens 93 st_2).[halt] :< false))
                    ) with
                    | (Some (__break__, v_5, v_7, v_indvars_iv_0, v_wide_trip_count_0, st_3)) => (Some (4294967553, st_3))
                    | None => None
                    end)
                  else (Some (4294967553, ((lens 93 st_2).[halt] :< false)))))
              else (Some ((((__retval__ >> (24)) & (4294967040)) |' (__retval__)), st_2)))
            else (
              rely (
                (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
                  (((v_0 & (4095)) = (0)))));
              when sh == (((st_2.(repl)) ((st_2.(oracle)) (st_2.(log))) (st_2.(share))));
              rely (
                (((((((st_2.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
                  (((((((lens 2 st_2).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
                  (0)));
              if ((((((((lens 2 st_2).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (1)) =? (0))
              then (
                when ret_0 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
                when ret_1 == ((buffer_map_spec' 2 ret_0 false));
                rely ((((ret_1.(pbase)) = ("granule_data")) /\ (((ret_1.(poffset)) >= (0)))));
                rely ((((((((lens 89 st_2).(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                rely ((((((((lens 2273 st_2).(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                rely (((((ret_1.(pbase)) = ("granule_data")) /\ (((ret_1.(poffset)) >= (0)))) /\ ((((ret_1.(poffset)) mod (4096)) = (0)))));
                rely ((((((lens 3739 st_2).(stack)).(stack_s_realm_params)).(e_is_rc)) = (1)));
                if (((((lens 3922 st_2).(stack)).(stack_s_realm_params)).(e_measurement_algo)) =? (1))
                then (Some (0, ((lens 4107 st_2).[halt] :< false)))
                else (
                  if (((((lens 3922 st_2).(stack)).(stack_s_realm_params)).(e_measurement_algo)) =? (0))
                  then (Some (0, ((lens 4292 st_2).[halt] :< false)))
                  else (Some (0, ((lens 4294 st_2).[halt] :< false)))))
              else (
                if ((0 - (((((lens 93 st_2).(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
                then (
                  match (
                    (free_sl_rtts_loop194
                      (z_to_nat 0)
                      false
                      (mkPtr "granules" (((((((lens 93 st_2).(stack)).(stack_s_realm_params)).(e_rtt_addr)) + ((- MEM0_PHYS))) >> (12)) * (16)))
                      false
                      0
                      ((((lens 93 st_2).(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts))
                      ((lens 93 st_2).[halt] :< false))
                  ) with
                  | (Some (__break__, v_5, v_7, v_indvars_iv_0, v_wide_trip_count_0, st_3)) => (Some (4294967553, st_3))
                  | None => None
                  end)
                else (Some (4294967553, ((lens 93 st_2).[halt] :< false)))))
          | None => None
          end)
        else (
          rely (
            (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
              (((v_0 & (4095)) = (0)))));
          when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
          rely (
            (((((((st_1.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
              (((((((lens 2 st_1).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
              (0)));
          if ((((((((lens 2 st_1).(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (1)) =? (0))
          then (
            when ret_0 == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
            when ret_1 == ((buffer_map_spec' 2 ret_0 false));
            rely ((((ret_1.(pbase)) = ("granule_data")) /\ (((ret_1.(poffset)) >= (0)))));
            rely ((((((((lens 89 st_1).(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            rely ((((((((lens 4296 st_1).(share)).(granule_data)) @ ((ret_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
            rely (((((ret_1.(pbase)) = ("granule_data")) /\ (((ret_1.(poffset)) >= (0)))) /\ ((((ret_1.(poffset)) mod (4096)) = (0)))));
            rely ((((((lens 5762 st_1).(stack)).(stack_s_realm_params)).(e_is_rc)) = (1)));
            if (((((lens 5945 st_1).(stack)).(stack_s_realm_params)).(e_measurement_algo)) =? (1))
            then (Some (0, ((lens 6130 st_1).[halt] :< false)))
            else (
              if (((((lens 5945 st_1).(stack)).(stack_s_realm_params)).(e_measurement_algo)) =? (0))
              then (Some (0, ((lens 6315 st_1).[halt] :< false)))
              else (Some (0, ((lens 6317 st_1).[halt] :< false)))))
          else (
            if ((0 - (((((lens 93 st_1).(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts)))) <? (0))
            then (
              match (
                (free_sl_rtts_loop194
                  (z_to_nat 0)
                  false
                  (mkPtr "granules" (((((((lens 93 st_1).(stack)).(stack_s_realm_params)).(e_rtt_addr)) + ((- MEM0_PHYS))) >> (12)) * (16)))
                  false
                  0
                  ((((lens 93 st_1).(stack)).(stack_s_realm_params)).(e_num_s2_sl_rtts))
                  ((lens 93 st_1).[halt] :< false))
              ) with
              | (Some (__break__, v_5, v_7, v_indvars_iv_0, v_wide_trip_count_0, st_2)) => (Some (4294967553, st_2))
              | None => None
              end)
            else (Some (4294967553, ((lens 93 st_1).[halt] :< false))))))
      else (Some (8589935105, st_1))).
End Layer13_Spec.

#[global] Hint Unfold smc_data_dispose_0_low: spec.
#[global] Hint Unfold smc_data_dispose_1_low: spec.
#[global] Hint Unfold smc_data_destroy_0_low: spec.
#[global] Hint Unfold smc_rtt_map_protected_0_low: spec.
#[global] Hint Unfold smc_realm_destroy_spec: spec.
