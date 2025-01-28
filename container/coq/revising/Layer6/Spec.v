Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_Spec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint rtt_walk_lock_unlock_loop467 (_N_: nat) (__return__: bool) (__break__: bool) (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * bool * Ptr * Z * Z * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __break__, v_0, v_4, v_5, v_7, v_indvars_iv, st))
    | (S _N__0) =>
      match ((rtt_walk_lock_unlock_loop467 _N__0 __return__ __break__ v_0 v_4 v_5 v_7 v_indvars_iv st)) with
      | (Some (return___9, break___9, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9)) =>
        if break___9
        then (Some (return___9, true, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9))
        else (
          if return___9
          then (Some (true, false, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_9))
          else (
            rely ((((0 - (v_indvars_iv_9)) <= (0)) /\ ((v_indvars_iv_9 < (4)))));
            when v_23_tmp, st_10 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_9));
            when v_38, st_11 == ((__find_lock_next_level_spec (int_to_ptr v_23_tmp) v_37 v_indvars_iv_9 st_10));
            rely ((((0 - ((v_indvars_iv_9 + (1)))) <= (0)) /\ (((v_indvars_iv_9 + (1)) < (4)))));
            when st_12 == ((store_RData 8 (ptr_offset v_36 (8 * ((v_indvars_iv_9 + (1))))) (ptr_to_int v_38) st_11));
            if (ptr_eqb v_38 (mkPtr "null" 0))
            then (
              when st_13 == ((store_RData 8 (ptr_offset v_13 16) v_indvars_iv_9 st_12));
              when v_37_tmp, st_16 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_13));
              when st_17 == ((store_RData 8 (ptr_offset v_13 0) v_37_tmp st_16));
              when v_40, st_18 == ((s2_addr_to_idx_spec v_37 v_indvars_iv_9 st_17));
              when st_20 == ((store_RData 8 (ptr_offset v_13 8) v_40 st_18));
              (Some (true, false, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_20)))
            else (
              when v_29_tmp, st_13 == ((load_RData 8 (ptr_offset v_36 (8 * (v_indvars_iv_9))) st_12));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_13));
              if (((v_indvars_iv_9 + (1)) - (v_31)) <? (0))
              then (Some (false, false, v_13, v_37, v_31, v_36, (v_indvars_iv_9 + (1)), st_16))
              else (Some (false, true, v_13, v_37, v_31, v_36, v_indvars_iv_9, st_16)))))
      | None => None
      end
    end.

  Definition rtt_walk_lock_unlock_loop467_rank (v_0: Ptr) (v_4: Z) (v_5: Z) (v_7: Ptr) (v_indvars_iv: Z) : Z :=
    0.

  Definition rtt_walk_lock_unlock_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    when st_0 == ((new_frame "rtt_walk_lock_unlock" st));
    rely (((((v_1.(pbase)) = ("granules")) /\ ((((v_1.(poffset)) mod (16)) = (0)))) /\ (((v_1.(poffset)) >= (0)))));
    rely (((((v_0.(pbase)) = ("stack_s_rtt_walk")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_1 == ((llvm_memset_p0i8_i64_spec (mkPtr "stack_type_5" 0) 0 32 false st_0));
    when st_2 == ((llvm_memset_p0i8_i64_spec v_0 0 24 false st_1));
    when v_10, st_3 == ((s2_sl_addr_to_idx_spec v_4 v_2 v_3 st_2));
    if (v_10 >? (511))
    then (
      when st_4 == ((granule_lock_spec (ptr_offset v_1 (16 * (((v_10 >> (9)) & (4294967295))))) 5 st_3));
      when st_5 == ((granule_unlock_spec v_1 st_4));
      rely ((((0 - (v_2)) <= (0)) /\ ((v_2 < (4)))));
      when st_7 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_2))) (ptr_to_int (ptr_offset v_1 (16 * (((v_10 >> (9)) & (4294967295)))))) st_5));
      if ((v_2 - (v_5)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop467
            (z_to_nat (rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2))
            false
            false
            v_0
            v_4
            v_5
            (mkPtr "stack_type_5" 0)
            v_2
            st_7)
        ) with
        | (Some (__return___0, __break__, v_14, v_13, v_6, v_12, v_indvars_iv_0, st_8)) =>
          if __return___0
          then (
            when st_10 == ((free_stack "rtt_walk_lock_unlock" st_0 st_8));
            (Some st_10))
          else (
            when st_10 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_8));
            rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
            when v_37_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_11));
            when v_39, st_13 == ((s2_addr_to_idx_spec v_4 v_5 st_12));
            when st_14 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_13));
            when st_15 == ((free_stack "rtt_walk_lock_unlock" st_0 st_14));
            (Some st_15))
        | None => None
        end)
      else (
        when st_9 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_7));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
        when v_37_tmp, st_10 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_10));
        when v_39, st_12 == ((s2_addr_to_idx_spec v_4 v_5 st_11));
        when st_13 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_12));
        when st_14 == ((free_stack "rtt_walk_lock_unlock" st_0 st_13));
        (Some st_14)))
    else (
      rely ((((0 - (v_2)) <= (0)) /\ ((v_2 < (4)))));
      when st_5 == ((store_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_2))) (ptr_to_int v_1) st_3));
      if ((v_2 - (v_5)) <? (0))
      then (
        rely (((rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2) >= (0)));
        match (
          (rtt_walk_lock_unlock_loop467
            (z_to_nat (rtt_walk_lock_unlock_loop467_rank v_0 v_4 v_5 (mkPtr "stack_type_5" 0) v_2))
            false
            false
            v_0
            v_4
            v_5
            (mkPtr "stack_type_5" 0)
            v_2
            st_5)
        ) with
        | (Some (__return___0, __break__, v_14, v_13, v_6, v_12, v_indvars_iv_0, st_6)) =>
          if __return___0
          then (
            when st_8 == ((free_stack "rtt_walk_lock_unlock" st_0 st_6));
            (Some st_8))
          else (
            when st_8 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_6));
            rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
            when v_37_tmp, st_9 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_8));
            when st_10 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_9));
            when v_39, st_11 == ((s2_addr_to_idx_spec v_4 v_5 st_10));
            when st_12 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_11));
            when st_13 == ((free_stack "rtt_walk_lock_unlock" st_0 st_12));
            (Some st_13))
        | None => None
        end)
      else (
        when st_7 == ((store_RData 8 (ptr_offset v_0 16) v_5 st_5));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (4)))));
        when v_37_tmp, st_8 == ((load_RData 8 (ptr_offset (mkPtr "stack_type_5" 0) (8 * (v_5))) st_7));
        when st_9 == ((store_RData 8 (ptr_offset v_0 0) v_37_tmp st_8));
        when v_39, st_10 == ((s2_addr_to_idx_spec v_4 v_5 st_9));
        when st_11 == ((store_RData 8 (ptr_offset v_0 8) v_39 st_10));
        when st_12 == ((free_stack "rtt_walk_lock_unlock" st_0 st_11));
        (Some st_12))).


  Definition s2tt_init_unassigned_loop759_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
    0.

  Definition s2tt_init_unassigned_loop759_0_rank (v: Ptr) (v_0: Z) (v_1: Z) : Z :=
    0.

  Definition esr_sysreg_rt_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (5)) & (31)), st)).

  Definition esr_sas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 >> (22)) & (3)), st)).

  Definition get_realm_identity_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("stack_s_q_useful_buf")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_1.(pbase)) = ("stack_s_q_useful_buf")) /\ (((v_1.(poffset)) >= (0)))))));
    when st_0 == ((store_RData 8 v_1 32 st));
    when st_1 == ((store_RData 8 v_0 (ptr_to_int (ptr_offset (mkPtr "get_realm_identity_identity" 0) 0)) st_0));
    (Some st_1).

  Definition s2tte_map_size_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((1 << ((39 + (((- 9) * (v_0)))))), st)).

  Definition s2tte_pa_spec' (v_0: Z) (v_1: Z) : (option Z) :=
    if ((v_1 <? (3)) && (((v_0 & (3)) =? (3))))
    then (Some ((v_0 & (281474976710655)) & (((- 1) << (12)))))
    else (Some ((v_0 & (281474976710655)) & (((- 1) << (((39 + (((- 9) * (v_1)))) & (4294967295))))))).

  Definition s2tte_pa_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_pa_spec' v_0 v_1));
    (Some (ret, st)).

  Definition s2tte_is_valid_spec' (v_0: Z) (v_1: Z) : (option bool) :=
    if ((v_0 & (36028797018963968)) =? (0))
    then (
      if ((v_1 =? (3)) && (((v_0 & (3)) =? (3))))
      then (Some true)
      else (
        if ((v_1 <>? (3)) && (((v_0 & (3)) =? (1))))
        then (Some true)
        else (Some false)))
    else (Some false).

  Definition s2tte_is_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when ret == ((s2tte_is_valid_spec' v_0 v_1));
    (Some (ret, st)).
  (* Definition s2tte_is_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_0 & (36028797018963968)) =? (0))
    then (
      if ((v_1 =? (3)) && (((v_0 & (3)) =? (3))))
      then (Some (true, st))
      else (
        if ((v_1 <>? (3)) && (((v_0 & (3)) =? (1))))
        then (Some (true, st))
        else (Some (false, st))))
    else (Some (false, st)). *)

  Definition realm_ipa_bits_spec' (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    if ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) =? (0))
    then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (16)) mod (4096))), st))
    else (
      if ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) =? (0))
      then (
        if ((((v_0.(poffset)) + (16)) mod (4096)) =? (0))
        then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rec)).(e_g_rec)), st))
        else (
          if ((((v_0.(poffset)) + (16)) mod (4096)) =? (8))
          then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rec)).(e_rec_idx)), st))
          else None))
      else (
        if ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) =? (0))
        then (
          if ((((v_0.(poffset)) + (16)) mod (4096)) =? (0))
          then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_state_s_rd)), st))
          else (
            if ((((v_0.(poffset)) + (16)) mod (4096)) =? (8))
            then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_rec_count)), st))
            else (
              if (((((v_0.(poffset)) + (16)) mod (4096)) >=? (16)) && (((((v_0.(poffset)) + (16)) mod (4096)) <? (48))))
              then (
                if (((((v_0.(poffset)) + (16)) mod (4096)) - (16)) =? (0))
                then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_ipa_bits)), st))
                else (
                  if (((((v_0.(poffset)) + (16)) mod (4096)) - (16)) =? (4))
                  then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_s2_starting_level)), st))
                  else (
                    if (((((v_0.(poffset)) + (16)) mod (4096)) - (16)) =? (8))
                    then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts)), st))
                    else (
                      if (((((v_0.(poffset)) + (16)) mod (4096)) - (16)) =? (16))
                      then (
                        rely (((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
                        (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)), st)))
                      else (
                        if (((((v_0.(poffset)) + (16)) mod (4096)) - (16)) =? (24))
                        then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_s2_ctx)).(e_vmid)), st))
                        else None)))))
              else (
                if ((((v_0.(poffset)) + (16)) mod (4096)) =? (48))
                then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_par_base_s_rd)), st))
                else (
                  if ((((v_0.(poffset)) + (16)) mod (4096)) =? (56))
                  then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_par_size_s_rd)), st))
                  else (
                    if ((((v_0.(poffset)) + (16)) mod (4096)) =? (64))
                    then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_par_end)), st))
                    else (
                      if (((((v_0.(poffset)) + (16)) mod (4096)) >=? (72)) && (((((v_0.(poffset)) + (16)) mod (4096)) <? (184))))
                      then (
                        if (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) <? (108))
                        then (
                          if (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) <? (8))
                          then (
                            (Some (
                              ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_total)) @ (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) / (4)))  ,
                              st
                            )))
                          else (
                            if (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) <? (40))
                            then (
                              (Some (
                                ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_state)) @ (((- 80) + ((((v_0.(poffset)) + (16)) mod (4096)))) / (4)))  ,
                                st
                              )))
                            else (
                              if (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) <? (104))
                              then (
                                (Some (
                                  ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_buffer)) @ ((- 112) + ((((v_0.(poffset)) + (16)) mod (4096)))))  ,
                                  st
                                )))
                              else (
                                if (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) =? (104))
                                then (Some ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_is224)), st))
                                else None))))
                        else (
                          if (((((v_0.(poffset)) + (16)) mod (4096)) - (72)) =? (108))
                          then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_ctx)).(e_measurement_algo_s_measurement_ctx)), st))
                          else None))
                      else (
                        if (((((v_0.(poffset)) + (16)) mod (4096)) >=? (184)) && (((((v_0.(poffset)) + (16)) mod (4096)) <? (408))))
                        then (
                          (Some (
                            (((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_measurement)) @ (((((v_0.(poffset)) + (16)) mod (4096)) - (184)) / (32))).(e_0)).(e_u_anon_0)) @ ((((((v_0.(poffset)) + (16)) mod (4096)) - (184)) mod (32)) / (8)))  ,
                            st
                          )))
                        else (
                          if ((((v_0.(poffset)) + (16)) mod (4096)) =? (408))
                          then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_rd)).(e_is_rc_s_rd)), st))
                          else None)))))))))
        else (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (16)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (16)) mod (4096))), st)))).
  
  Definition realm_ipa_bits_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((realm_ipa_bits_spec' v_0 st));
    (Some (ret, st)).
  (* Definition realm_ipa_bits_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 4 (ptr_offset v_0 16) st));
    (Some (v_3, st_0)). *)

  Definition realm_rtt_starting_level_spec' (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    if ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) =? (0))
    then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (20)) mod (4096))), st))
    else (
      if ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) =? (0))
      then (
        if ((((v_0.(poffset)) + (20)) mod (4096)) =? (0))
        then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rec)).(e_g_rec)), st))
        else (
          if ((((v_0.(poffset)) + (20)) mod (4096)) =? (8))
          then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rec)).(e_rec_idx)), st))
          else (
            if ((((v_0.(poffset)) + (20)) mod (4096)) =? (16))
            then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rec)).(e_runnable)), st))
            else None)))
      else (
        if ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) =? (0))
        then (
          if ((((v_0.(poffset)) + (20)) mod (4096)) =? (0))
          then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_state_s_rd)), st))
          else (
            if ((((v_0.(poffset)) + (20)) mod (4096)) =? (8))
            then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_rec_count)), st))
            else (
              if (((((v_0.(poffset)) + (20)) mod (4096)) >=? (16)) && (((((v_0.(poffset)) + (20)) mod (4096)) <? (48))))
              then (
                if (((((v_0.(poffset)) + (20)) mod (4096)) - (16)) =? (0))
                then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_ipa_bits)), st))
                else (
                  if (((((v_0.(poffset)) + (20)) mod (4096)) - (16)) =? (4))
                  then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_s2_starting_level)), st))
                  else (
                    if (((((v_0.(poffset)) + (20)) mod (4096)) - (16)) =? (8))
                    then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_num_root_rtts)), st))
                    else (
                      if (((((v_0.(poffset)) + (20)) mod (4096)) - (16)) =? (16))
                      then (
                        rely (((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
                        rely (((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
                        (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)), st)))
                      else (
                        if (((((v_0.(poffset)) + (20)) mod (4096)) - (16)) =? (24))
                        then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_s2_ctx)).(e_vmid)), st))
                        else None)))))
              else (
                if ((((v_0.(poffset)) + (20)) mod (4096)) =? (48))
                then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_par_base_s_rd)), st))
                else (
                  if ((((v_0.(poffset)) + (20)) mod (4096)) =? (56))
                  then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_par_size_s_rd)), st))
                  else (
                    if ((((v_0.(poffset)) + (20)) mod (4096)) =? (64))
                    then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_par_end)), st))
                    else (
                      if (((((v_0.(poffset)) + (20)) mod (4096)) >=? (72)) && (((((v_0.(poffset)) + (20)) mod (4096)) <? (184))))
                      then (
                        if (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) <? (108))
                        then (
                          if (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) <? (8))
                          then (
                            (Some (
                              ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_total)) @ (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) / (4)))  ,
                              st
                            )))
                          else (
                            if (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) <? (40))
                            then (
                              (Some (
                                ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_state)) @ (((- 80) + ((((v_0.(poffset)) + (20)) mod (4096)))) / (4)))  ,
                                st
                              )))
                            else (
                              if (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) <? (104))
                              then (
                                (Some (
                                  ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_buffer)) @ ((- 112) + ((((v_0.(poffset)) + (20)) mod (4096)))))  ,
                                  st
                                )))
                              else (
                                if (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) =? (104))
                                then (Some ((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_ctx)).(e_c)).(e_is224)), st))
                                else None))))
                        else (
                          if (((((v_0.(poffset)) + (20)) mod (4096)) - (72)) =? (108))
                          then (Some (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_ctx)).(e_measurement_algo_s_measurement_ctx)), st))
                          else None))
                      else (
                        if (((((v_0.(poffset)) + (20)) mod (4096)) >=? (184)) && (((((v_0.(poffset)) + (20)) mod (4096)) <? (408))))
                        then (
                          (Some (
                            (((((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_measurement)) @ (((((v_0.(poffset)) + (20)) mod (4096)) - (184)) / (32))).(e_0)).(e_u_anon_0)) @ ((((((v_0.(poffset)) + (20)) mod (4096)) - (184)) mod (32)) / (8)))  ,
                            st
                          )))
                        else (
                          if ((((v_0.(poffset)) + (20)) mod (4096)) =? (408))
                          then (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_rd)).(e_is_rc_s_rd)), st))
                          else None)))))))))
        else (Some ((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) + (20)) / (4096))).(g_norm)) @ (((v_0.(poffset)) + (20)) mod (4096))), st)))).
  
  Definition realm_rtt_starting_level_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((realm_rtt_starting_level_spec' v_0 st));
    (Some (ret, st)).

  (* Definition realm_rtt_starting_level_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 4 (ptr_offset v_0 20) st));
    (Some (v_3, st_0)). *)

  Definition is_addr_in_par_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely ((((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_1 mod (4096)) = (0)))));
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 48) st));
    when v_6, st_1 == ((load_RData 8 (ptr_offset v_0 64) st_0));
    when v_7, st_2 == ((addr_is_contained_spec v_4 v_6 v_1 st_1));
    (Some (v_7, st_2)).

  Definition system_off_reboot_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3_tmp, st_0 == ((load_RData 8 (ptr_offset v_0 944) st));
    when st_1 == ((granule_lock_spec (int_to_ptr v_3_tmp) 2 st_0));
    when v_4_tmp, st_2 == ((load_RData 8 (ptr_offset v_0 944) st_1));
    when v_5, st_3 == ((granule_map_spec (int_to_ptr v_4_tmp) 2 st_2));
    when st_4 == ((set_rd_state_spec v_5 2 st_3));
    when st_5 == ((granule_unlock_spec (int_to_ptr v_3_tmp) st_4));
    (Some st_5).

  Definition rd_map_read_rec_count_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_2, st_0 == ((granule_map_spec v_0 2 st));
    when v_4, st_1 == ((get_rd_rec_count_unlocked_spec v_2 st_0));
    (Some (v_4, st_1)).

  Definition vmpidr_to_rec_idx_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((((v_0 >> (4)) & (4080)) |' ((v_0 & (15)))) |' (((v_0 >> (4)) & (1044480)))) |' (((v_0 >> (12)) & (267386880)))), st)).

  Definition g_mapped_addr_set_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 8) st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 8) ((v_4 & (4095)) |' (v_1)) st_0));
    (Some st_1).

  Definition granule_set_state_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (6)))));
    when st_0 == ((store_RData 4 (ptr_offset v_0 4) v_1 st));
    (Some st_0).

  Definition set_pas_ns_to_any_spec (v_0: Z) (st: RData) : (option RData) :=
    when v_2, st_0 == ((monitor_call_spec 3288334592 v_0 0 0 0 0 0 st));
    (Some st_0).

  Definition pack_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((make_return_code_spec v_0 v_1 st));
    when v_4, st_1 == ((pack_struct_return_code_spec v_3 st_0));
    (Some (v_4, st_1)).

  Definition __granule_get_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_0 == ((atomic_granule_get_spec v_0 st));
    (Some st_0).

  Definition g_refcount_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 8) st));
    (Some ((v_3 & (4095)), st_0)).

  Definition __granule_put_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_0 == ((atomic_granule_put_spec v_0 st));
    (Some st_0).

  Definition set_pas_any_to_ns_spec (v_0: Z) (st: RData) : (option RData) :=
    when v_2, st_0 == ((monitor_call_spec 3288334593 v_0 0 0 0 0 0 st));
    (Some st_0).

  Definition s2tte_create_assigned_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_0 |' (4)), st)).

  Definition __tte_write_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when st_0 == ((__sca_write64_spec v_0 v_1 st));
    (Some st_0).

  Definition stage1_tlbi_all_spec (st: RData) : (option RData) :=
    when st_0 == ((iasm_258_spec st));
    when st_1 == ((iasm_10_spec st_0));
    when st_2 == ((iasm_12_isb_spec st_1));
    (Some st_2).

  Definition s1tte_pa_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((addr_level_mask_spec v_0 3 st));
    (Some (v_2, st_0)).

  Definition s2tte_is_unassigned_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (63)) =? (0)), st)).

  Definition s1tte_create_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if (v_1 =? (3))
    then (Some ((v_0 |' (1795)), st))
    else (Some ((v_0 |' (1793)), st)).

  Definition s2tte_get_ripas_spec' (v_0: Z) : (option Z) :=
    if ((v_0 & (64)) =? (0))
    then (Some 0)
    else (Some 1).

  Definition s2tte_get_ripas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_get_ripas_spec' v_0));
    (Some (ret, st)).
  (* Definition s2tte_get_ripas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 & (64)) =? (0))
    then (Some (0, st))
    else (Some (1, st)). *)

  Definition ns_buffer_unmap_spec (v_0: Z) (st: RData) : (option RData) :=
    when v_2, st_0 == ((slot_to_va_spec v_0 st));
    (Some st_0).

  Definition ns_buffer_read_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_5, st_0 == ((granule_pa_to_va_spec v_1 st));
    when v_6, st_1 == ((memcpy_ns_read_spec v_3 v_5 v_2 st_0));
    (Some (v_6, st_1)).

  Definition find_lock_granules_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    let v_4 := (ptr_offset v_0 ((40 * (0)) + ((0 + (0))))) in
    rely (((v_4.(pbase)) = ("stack_type_6")));
    rely (((v_4.(poffset)) = (0)));
    when st == ((store_RData 4 v_4 0 st));
    let v_5 := (ptr_offset v_0 ((40 * (1)) + ((0 + (0))))) in
    rely (((v_5.(pbase)) = ("stack_type_6")));
    rely (((v_5.(poffset)) = (40)));
    when st == ((store_RData 4 v_5 1 st));
    when st == ((sort_granules_spec v_0 2 st));
    match (
      let __retval__ := 0 in
      let __return__ := false in
      (Some (__return__, __retval__, st))
    ) with
    | (Some (__return__, __retval__, st)) =>
      if __return__
      then (Some (__retval__, st))
      else (
        let v_11 := (ptr_offset v_0 ((40 * (0)) + ((8 + (0))))) in
        rely (((v_11.(pbase)) = ("stack_type_6")));
        when v_12, st == ((load_RData 8 v_11 st));
        let v_13 := (ptr_offset v_0 ((40 * (0)) + ((16 + (0))))) in
        rely (((v_13.(pbase)) = ("stack_type_6")));
        when v_14, st == ((load_RData 4 v_13 st));
        when v_15, st == ((find_lock_granule_spec v_12 v_14 st));
        rely ((((v_15.(pbase)) = ("granules")) \/ (((v_15.(pbase)) = ("null")))));
        rely (((v_15.(poffset)) >= (0)));
        rely ((((v_15.(pbase)) = ("null")) \/ (((v_15.(poffset)) < ((GRANULE_SIZE * (NR_GRANULES)))))));
        let v_16 := (ptr_offset v_0 ((40 * (0)) + ((24 + (0))))) in
        rely (((v_16.(pbase)) = ("stack_type_6")));
        when st == ((store_RData 8 v_16 (ptr_to_int v_15) st));
        let v__not := (ptr_eqb v_15 (mkPtr "null" 0)) in
        match (
          let v__1_lcssa_wide := 0 in
          let v__1_lcssa47_wide := 0 in
          if v__not
          then (
            let v__1_lcssa_wide := 0 in
            let v__1_lcssa47_wide := 0 in
            (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
          else (
            match (
              if true
              then (
                let v_26 := (ptr_offset v_0 ((40 * (1)) + ((8 + (0))))) in
                rely (((v_26.(pbase)) = ("stack_type_6")));
                when v_27, st == ((load_RData 8 v_26 st));
                let v_28 := (ptr_offset v_0 ((40 * (0)) + ((8 + (0))))) in
                rely (((v_28.(pbase)) = ("stack_type_6")));
                when v_29, st == ((load_RData 8 v_28 st));
                let v_30 := (v_27 =? (v_29)) in
                match (
                  if v_30
                  then (
                    when v_9, st == ((make_return_code_spec 3 0 st));
                    let v__148 := 1 in
                    let v__sroa_02_0 := v_9 in
                    let v_49 := (v__148 >? (0)) in
                    when st == (
                        if v_49
                        then (
                          let v_50 := v__148 in
                          let v_51 := (v_50 + ((- 1))) in
                          let v_53 := (ptr_offset v_0 ((40 * (v_51)) + ((24 + (0))))) in
                          rely (((v_53.(pbase)) = ("stack_type_6")));
                          when v_54_tmp, st == ((load_RData 8 v_53 st));
                          rely ((v_54_tmp >= (GRANULES_BASE)));
                          rely ((v_54_tmp < (RMM_ATTEST_SIGNING_KEY_BASE)));
                          rely (((v_54_tmp mod (16)) = (0)));
                          let v_54 := (int_to_ptr v_54_tmp) in
                          rely (((v_54.(pbase)) = ("granules")));
                          when st == ((granule_unlock_spec v_54 st));
                          (Some st))
                        else (Some st));
                    let v__sroa_039_0_insert_insert := v__sroa_02_0 in
                    let __return__ := true in
                    let __retval__ := v__sroa_039_0_insert_insert in
                    (Some (__return__, __retval__, st)))
                  else (Some (__return__, __retval__, st))
                ) with
                | (Some (__return__, __retval__, st)) =>
                  if __return__
                  then (Some (__return__, __retval__, st))
                  else (Some (__return__, __retval__, st))
                | None => None
                end)
              else (Some (__return__, __retval__, st))
            ) with
            | (Some (__return__, __retval__, st)) =>
              if __return__
              then (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
              else (
                let v_32 := (ptr_offset v_0 ((40 * (1)) + ((8 + (0))))) in
                when v_33, st == ((load_RData 8 v_32 st));
                let v_34 := (ptr_offset v_0 ((40 * (1)) + ((16 + (0))))) in
                when v_35, st == ((load_RData 4 v_34 st));
                when v_36, st == ((find_lock_granule_spec v_33 v_35 st));
                rely ((((v_36.(pbase)) = ("granules")) \/ (((v_36.(pbase)) = ("null")))));
                rely (((v_36.(poffset)) >= (0)));
                rely ((((v_36.(pbase)) = ("null")) \/ (((v_36.(poffset)) < ((GRANULE_SIZE * (NR_GRANULES)))))));
                let v_37 := (ptr_offset v_0 ((40 * (1)) + ((24 + (0))))) in
                when st == ((store_RData 8 v_37 (ptr_to_int v_36) st));
                let v__not_1 := (ptr_eqb v_36 (mkPtr "null" 0)) in
                match (
                  let v__1_lcssa_wide := 0 in
                  let v__1_lcssa47_wide := 0 in
                  if v__not_1
                  then (
                    let v__1_lcssa_wide := 1 in
                    let v__1_lcssa47_wide := 1 in
                    (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
                  else (
                    let v_40 := (ptr_offset v_0 ((40 * (0)) + ((24 + (0))))) in
                    when v_41_tmp, st == ((load_RData 8 v_40 st));
                    let v_43 := (mkPtr "stack_type_4" 0) in
                    when st == ((store_RData 8 v_43 v_41_tmp st));
                    let v_44 := (ptr_offset v_0 ((40 * (1)) + ((24 + (0))))) in
                    when v_45_tmp, st == ((load_RData 8 v_44 st));
                    let v_47 := (mkPtr "stack_type_4__1" 0) in
                    when st == ((store_RData 8 v_47 v_45_tmp st));
                    let v__sroa_039_0_insert_insert := 0 in
                    let __return__ := true in
                    let __retval__ := v__sroa_039_0_insert_insert in
                    (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)))
                ) with
                | (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)) =>
                  if __return__
                  then (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
                  else (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st))
                | None => None
                end)
            | None => None
            end)
        ) with
        | (Some (__return__, __retval__, v__1_lcssa47_wide, v__1_lcssa_wide, st)) =>
          if __return__
          then (Some (__retval__, st))
          else (
            let v_18 := v__1_lcssa47_wide in
            let v_19 := v__1_lcssa_wide in
            let v_20 := v_19 in
            let v_21 := (ptr_offset v_0 ((40 * (v_20)) + ((0 + (0))))) in
            when v_22, st == ((load_RData 4 v_21 st));
            when v_23, st == ((make_return_code_spec 1 v_22 st));
            let v__148 := v_18 in
            let v__sroa_02_0 := v_23 in
            let v_49 := (v__148 >? (0)) in
            when st == (
                if v_49
                then (
                  let v_50 := v__148 in
                  let v_51 := (v_50 + ((- 1))) in
                  let v_53 := (ptr_offset v_0 ((40 * (v_51)) + ((24 + (0))))) in
                  rely (((v_53.(pbase)) = ("stack_type_6")));
                  when v_54_tmp, st == ((load_RData 8 v_53 st));
                  rely ((v_54_tmp >= (GRANULES_BASE)));
                  rely ((v_54_tmp < (RMM_ATTEST_SIGNING_KEY_BASE)));
                  rely (((v_54_tmp mod (16)) = (0)));
                  let v_54 := (int_to_ptr v_54_tmp) in
                  rely (((v_54.(pbase)) = ("granules")));
                  when st == ((granule_unlock_spec v_54 st));
                  (Some st))
                else (Some st));
            let v__sroa_039_0_insert_insert := v__sroa_02_0 in
            let __return__ := true in
            let __retval__ := v__sroa_039_0_insert_insert in
            (Some (__retval__, st)))
        | None => None
        end)
    | None => None
    end.

  Definition s2tte_create_table_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((v_0 |' (3)), st)).

  Fixpoint s2tt_init_unassigned_loop759 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_3: Z) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_3, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_unassigned_loop759 _N__0 __break__ v_0 v_3 v_indvars_iv st)) with
      | (Some (__break___0, v_1, v_4, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_4, v_indvars_iv_0, st_0))
        else (
          when st_1 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) v_4 st_0));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, v_4, (v_indvars_iv_0 + (1)), st_1))
          else (Some (true, v_1, v_4, v_indvars_iv_0, st_1)))
      | None => None
      end
    end.

  Fixpoint s2tt_init_unassigned_loop759_0 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_3: Z) (v_index: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_3, v_index, st))
    | (S _N__0) =>
      match ((s2tt_init_unassigned_loop759_0 _N__0 __break__ v_0 v_3 v_index st)) with
      | (Some (__break___0, v_1, v_4, v_index_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_4, v_index_0, st_0))
        else (
          when st_1 == ((store_RData 8 (ptr_offset v_1 (8 * (v_index_0))) v_4 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * ((v_index_0 + (1))))) v_4 st_1));
          if ((v_index_0 + (2)) =? (512))
          then (Some (true, v_1, v_4, v_index_0, st_2))
          else (Some (false, v_1, v_4, (v_index_0 + (2)), st_2)))
      | None => None
      end
    end.

  Definition s2tt_init_unassigned_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_3, st_0 == ((s2tte_create_unassigned_spec v_1 st));
    rely (((s2tt_init_unassigned_loop759_0_rank v_0 v_3 0) >= (0)));
    match (
      match ((s2tt_init_unassigned_loop759_0 (z_to_nat (s2tt_init_unassigned_loop759_0_rank v_0 v_3 0)) false v_0 v_3 0 st_0)) with
      | (Some (__break__, v_2, v_4, v_index_0, st_1)) =>
        when st_2 == ((iasm_10_spec st_1));
        (Some (true, 0, st_2))
      | None => None
      end
    ) with
    | (Some (__return__, v_bc_resume_val, st_1)) =>
      if __return__
      then (Some st_1)
      else (
        rely (((s2tt_init_unassigned_loop759_rank v_0 v_3 v_bc_resume_val) >= (0)));
        match ((s2tt_init_unassigned_loop759 (z_to_nat (s2tt_init_unassigned_loop759_rank v_0 v_3 v_bc_resume_val)) false v_0 v_3 v_bc_resume_val st_1)) with
        | (Some (__break__, v_2, v_4, v_indvars_iv_0, st_2)) =>
          when st_3 == ((iasm_10_spec st_2));
          (Some st_3)
        | None => None
        end)
    | None => None
    end.

End Layer6_Spec.

#[global] Hint Unfold rtt_walk_lock_unlock_loop467_rank: spec.
Opaque rtt_walk_lock_unlock_spec.
#[global] Hint Unfold rtt_walk_lock_unlock_loop467: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_rank: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_0_rank: spec.
#[global] Hint Unfold esr_sysreg_rt_spec: spec.
#[global] Hint Unfold esr_sas_spec: spec.
#[global] Hint Unfold get_realm_identity_spec: spec.
#[global] Hint Unfold s2tte_map_size_spec: spec.
#[global] Hint Unfold s2tte_pa_spec: spec.
#[global] Hint Unfold s2tte_is_valid_spec: spec.
#[global] Hint Unfold realm_ipa_bits_spec: spec.
#[global] Hint Unfold realm_rtt_starting_level_spec: spec.
#[global] Hint Unfold is_addr_in_par_spec: spec.
#[global] Hint Unfold system_off_reboot_spec: spec.
#[global] Hint Unfold rd_map_read_rec_count_spec: spec.
#[global] Hint Unfold vmpidr_to_rec_idx_spec: spec.
#[global] Hint Unfold g_mapped_addr_set_spec: spec.
#[global] Hint Unfold granule_set_state_spec: spec.
#[global] Hint Unfold set_pas_ns_to_any_spec: spec.
#[global] Hint Unfold pack_return_code_spec: spec.
#[global] Hint Unfold __granule_get_spec: spec.
#[global] Hint Unfold g_refcount_spec: spec.
#[global] Hint Unfold __granule_put_spec: spec.
#[global] Hint Unfold set_pas_any_to_ns_spec: spec.
#[global] Hint Unfold s2tte_create_assigned_spec: spec.
#[global] Hint Unfold __tte_write_spec: spec.
#[global] Hint Unfold stage1_tlbi_all_spec: spec.
#[global] Hint Unfold s1tte_pa_spec: spec.
#[global] Hint Unfold s2tte_is_unassigned_spec: spec.
#[global] Hint Unfold s1tte_create_valid_spec: spec.
#[global] Hint Unfold s2tte_get_ripas_spec: spec.
#[global] Hint Unfold ns_buffer_unmap_spec: spec.
#[global] Hint Unfold ns_buffer_read_spec: spec.
#[global] Hint Unfold find_lock_granules_spec: spec.
#[global] Hint Unfold s2tte_create_table_spec: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_0: spec.
#[global] Hint Unfold s2tt_init_unassigned_spec: spec.
