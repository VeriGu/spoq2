Definition update_ripas_spec (v_s2tte: Ptr) (v_level: Z) (v_ripas: Z) (st: RData) : (option (bool * RData)) :=
  rely (((v_s2tte.(pbase)) = ("smc_rtt_set_ripas_stack")));
  if ((v_level <? (3)) && ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (3)) =? (3))))
  then (Some (false, st))
  else (
    if (s2tte_check_spec' (((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) v_level 0 st)
    then (
      if (v_ripas =? (0))
      then (
        (Some (
          true  ,
          (st.[stack].[smc_rtt_set_ripas_stack] :<
            (((st.(stack)).(smc_rtt_set_ripas_stack)) #
              (v_s2tte.(poffset)) ==
              ((((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))) |' (4))))
        )))
      else (Some (true, st)))
    else (
      if (s2tte_has_hipas_spec' (((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) 0 st)
      then (
        (Some (
          true  ,
          (st.[stack].[smc_rtt_set_ripas_stack] :<
            (((st.(stack)).(smc_rtt_set_ripas_stack)) #
              (v_s2tte.(poffset)) ==
              ((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) |' ((s2tte_create_ripas_spec' v_ripas st)))))
        )))
      else (
        if (s2tte_has_hipas_spec' (((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) 4 st)
        then (
          (Some (
            true  ,
            (st.[stack].[smc_rtt_set_ripas_stack] :<
              (((st.(stack)).(smc_rtt_set_ripas_stack)) #
                (v_s2tte.(poffset)) ==
                ((((st.(stack)).(smc_rtt_set_ripas_stack)) @ (v_s2tte.(poffset))) |' ((s2tte_create_ripas_spec' v_ripas st)))))
          )))
        else (Some (false, st))))).

Definition s2tte_create_unassigned_spec (v_ripas: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((s2tte_create_ripas_spec' v_ripas st), st)).

Definition realm_ipa_size_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))), st))
  | _ => None
  end.

Definition __find_next_level_idx_spec (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_g_tbl.(pbase)) = ("granules")))) /\
      ((((0 = (0)) /\ (("granules" = ("granules")))) /\ ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
  when ret == ((__tte_read_spec' (mkPtr "slot_rtt" (8 * (v_idx))) (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))))));
  if ((ret & (3)) =? (3))
  then (
    rely ((((0 - ((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)))) <= (0)) /\ (((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)) < (1048576)))));
    (Some ((mkPtr "granules" (16 * ((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE))))), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))))
  else (Some ((mkPtr "null" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))).

Definition s2_walk_result_match_ripas_spec' (v_res: Ptr) (v_ripas: Z) (st: RData) : (option bool) :=
  rely (
    ((((v_res.(pbase)) = ("handle_rsi_realm_config_stack")) \/ (((v_res.(pbase)) = ("do_host_call_stack")))) \/
      (((v_res.(pbase)) = ("attest_token_continue_write_state_stack")))));
  if ((v_res.(pbase)) =s ("attest_token_continue_write_state_stack"))
  then (
    if (((((st.(stack)).(attest_token_continue_write_state_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
    then (Some ((((st.(stack)).(attest_token_continue_write_state_stack)) @ ((v_res.(poffset)) + (16))) =? (0)))
    else (Some false))
  else (
    if ((v_res.(pbase)) =s ("do_host_call_stack"))
    then (
      if (((((st.(stack)).(do_host_call_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
      then (Some ((((st.(stack)).(do_host_call_stack)) @ ((v_res.(poffset)) + (16))) =? (0)))
      else (Some false))
    else (
      if (((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (20))) & (1)) =? (0))
      then (Some ((((st.(stack)).(handle_rsi_realm_config_stack)) @ ((v_res.(poffset)) + (16))) =? (0)))
      else (Some false))).

Definition s2_walk_result_match_ripas_spec (v_res: Ptr) (v_ripas: Z) (st: RData) : (option (bool * RData)) :=
  when ret == ((s2_walk_result_match_ripas_spec' v_res v_ripas st));
  (Some (ret, st)).

Definition rec_par_size_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  (Some (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)), st)).

