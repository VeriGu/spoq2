Definition update_ripas_spec (v_s2tte: Ptr) (v_level: Z) (v_ripas: Z) (st: RData) : (option (bool * RData)) :=
  rely (((v_s2tte.(pbase)) = ("smc_rtt_set_ripas_stack")));
  if ((v_level <? (3)) && ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (3)) =? (3))))
  then (Some (false, st))
  else (
    if (((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (36028797018963968)) =? (0))
    then (
      if ((v_level =? (3)) && ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (3)) =? (3))))
      then (
        if (v_ripas =? (0))
        then (Some (true, (lens 1184 st)))
        else (Some (true, st)))
      else (
        if ((v_level =? (2)) && ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (3)) =? (1))))
        then (
          if (v_ripas =? (0))
          then (Some (true, (lens 1241 st)))
          else (Some (true, st)))
        else (
          if (((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (3)) =? (0))
          then (
            if (((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (60)) =? (0))
            then (
              if (v_ripas =? (0))
              then (Some (true, (lens 1298 st)))
              else (Some (true, (lens 1355 st))))
            else (
              if ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (60)) - (4)) =? (0))
              then (
                if (v_ripas =? (0))
                then (Some (true, (lens 1412 st)))
                else (Some (true, (lens 1469 st))))
              else (Some (false, st))))
          else (Some (false, st)))))
    else (
      if (((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (3)) =? (0))
      then (
        if (((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (60)) =? (0))
        then (
          if (v_ripas =? (0))
          then (Some (true, (lens 1526 st)))
          else (Some (true, (lens 1583 st))))
        else (
          if ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (60)) - (4)) =? (0))
          then (
            if (v_ripas =? (0))
            then (Some (true, (lens 1640 st)))
            else (Some (true, (lens 1697 st))))
          else (Some (false, st))))
      else (Some (false, st)))).

Definition s2tte_create_unassigned_spec (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
  if (v_ripas =? (0))
  then (Some (0, st))
  else (Some (64, st)).

Definition realm_ipa_size_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  (Some ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))), st)).

Definition __find_next_level_idx_spec (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g_tbl.(pbase)) = ("granules")));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (((((st.(share)).(granules)) @ ((v_g_tbl.(poffset)) >> (4))).(e_lock)));
  if (((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (v_idx))) & (3)) =? (3))
  then (
    rely (
      (((0 -
        (((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (v_idx))) & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) /
          (GRANULE_SIZE)))) <=
        (0)) /\
        ((((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (v_idx))) & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) /
          (GRANULE_SIZE)) <
          (1048576)))));
    (Some (
      (mkPtr
        "granules"
        (16 *
          (((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (v_idx))) & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) /
            (GRANULE_SIZE)))))  ,
      (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))) # SLOT_RTT == (- 1)))
    )))
  else (Some ((mkPtr "null" 0), (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))) # SLOT_RTT == (- 1))))).

Definition s2_walk_result_match_ripas_spec (v_res: Ptr) (v_ripas: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    ((((v_res.(pbase)) = ("handle_rsi_realm_config_stack")) \/ (((v_res.(pbase)) = ("do_host_call_stack")))) \/
      (((v_res.(pbase)) = ("attest_token_continue_write_state_stack")))));
  if ((v_res.(pbase)) =s ("attest_token_continue_write_state_stack"))
  then (
    if (((((st.(stack)).(attest_token_continue_write_state_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
    then (Some (((((st.(stack)).(attest_token_continue_write_state_stack)) @ ((v_res.(poffset)) + (16))) =? (0)), st))
    else (Some (false, st)))
  else (
    if ((v_res.(pbase)) =s ("do_host_call_stack"))
    then (
      if (((((st.(stack)).(do_host_call_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
      then (Some (((((st.(stack)).(do_host_call_stack)) @ ((v_res.(poffset)) + (16))) =? (0)), st))
      else (Some (false, st)))
    else (
      if (((v_res.(poffset)) + (20)) =? (24))
      then (
        rely (
          ((((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (20))) > (0)) /\
            ((((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (20))) - (GRANULES_BASE)) >= (0)))) /\
            ((((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (20))) - (18446744073705226240)) < (0)))));
        if (((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
        then (Some (((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) =? (0)), st))
        else (Some (false, st)))
      else (
        if (((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
        then (
          if (((v_res.(poffset)) + (16)) =? (24))
          then (
            rely (
              ((((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) > (0)) /\
                ((((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) - (GRANULES_BASE)) >= (0)))) /\
                ((((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) - (18446744073705226240)) < (0)))));
            (Some (((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) =? (0)), st)))
          else (Some (((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) =? (0)), st)))
        else (Some (false, st))))).

Definition rec_par_size_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  if (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (Some (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)), st))
  else None.

