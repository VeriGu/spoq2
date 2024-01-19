Parameter return_result_to_realm_spec_state_oracle : RData -> (option RData).

Parameter complete_mmio_emulation_spec_state_oracle : RData -> (option RData).

Definition handle_rsi_host_call_spec (v_agg_result: Ptr) (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) :=
  rely ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 24 false st));
  rely (
    match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  if ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (255)) =? (0))
  then (
    if (
      ((Z.lxor
        (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) + (255)) 
        ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1)) <?
        (4096)))
    then (
      rely (
        (((((1 << (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
          (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) >?
          (0)) =
          (false)));
      (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 1))))
    else (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 1))))
  else (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 1))).

Definition handle_rsi_ipa_state_set_spec (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 3) >? (1))
  then (Some (true, st))
  else (
    if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (4095)) =? (0))
    then (
      if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) & (4095)) =? (0))
      then (
        if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) >? (0))
        then (
          if (
            (region_is_contained_spec'
              0 
              ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) 
              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) 
              (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) +
                (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) 
              st))
          then (
            (Some (
              false  ,
              ((st.[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  (((st.(share)).(slots)) @ SLOT_REC) ==
                  ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_set_ripas] :<
                    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1)).[e_end] :<
                      (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) +
                        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1)))).[e_ripas] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 3)).[e_start] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))))).[stack].[smc_rec_enter_stack] :<
                ((((((st.(stack)).(smc_rec_enter_stack)) # (v_rec_exit.(poffset)) == 4) #
                  ((v_rec_exit.(poffset)) + (1280)) ==
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1)) #
                  ((v_rec_exit.(poffset)) + (1288)) ==
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2)) #
                  ((v_rec_exit.(poffset)) + (1296)) ==
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 3)))
            )))
          else (Some (true, st)))
        else (Some (true, st)))
      else (Some (true, st)))
    else (Some (true, st))).

Definition check_pending_irq_spec (st: RData) : (option (bool * RData)) :=
  (Some (((((st.(priv)).(pcpu_regs)).(pcpu_isr_el1)) <>? (0)), st)).

Definition emulate_stage2_data_abort_spec (v_rec: Ptr) (v_rec_exit: Ptr) (v_rtt_level: Z) (st: RData) : (option RData) :=
  rely (
    (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  (Some (st.[stack].[smc_rec_enter_stack] :<
    ((((((st.(stack)).(smc_rec_enter_stack)) # ((v_rec_exit.(poffset)) + (256)) == ((v_rtt_level + (4)) |' (2415919104))) # ((v_rec_exit.(poffset)) + (264)) == 0) #
      ((v_rec_exit.(poffset)) + (272)) ==
      (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (8))) #
      (v_rec_exit.(poffset)) ==
      0))).

Definition return_result_to_realm_spec_shadow (v_rec: Ptr) (v_result: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_result.(pbase)) = ("handle_realm_rsi_stack")))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_regs] :<
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) #
          0 ==
          (((st.(stack)).(handle_realm_rsi_stack)) @ (v_result.(poffset)))) #
          1 ==
          (((st.(stack)).(handle_realm_rsi_stack)) @ ((v_result.(poffset)) + (8)))) #
          2 ==
          (((st.(stack)).(handle_realm_rsi_stack)) @ ((v_result.(poffset)) + (16)))) #
          3 ==
          (((st.(stack)).(handle_realm_rsi_stack)) @ ((v_result.(poffset)) + (24)))))))).

Definition return_result_to_realm_spec (v_rec: Ptr) (v_result: Ptr) (st: RData) : (option RData) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_result.(pbase)) = ("handle_realm_rsi_stack")))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_result.(pbase)) = ("handle_realm_rsi_stack")))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  when st' == ((return_result_to_realm_spec_state_oracle st));
  (Some st').

Definition complete_mmio_emulation_spec_shadow (v_rec: Ptr) (v_rec_entry: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_rec_entry.(pbase)) = ("smc_rec_enter_stack")))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  if (((((st.(stack)).(smc_rec_enter_stack)) @ (v_rec_entry.(poffset))) & (1)) =? (0))
  then (Some (true, st))
  else (
    if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (4227858432)) =? (2415919104))
    then (
      if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (16777216)) =? (0))
      then (Some (false, st))
      else (
        if (
          if (xorb ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (64)) <>? (0)) true)
          then (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) <>? (31))
          else false)
        then (
          if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (2097152)) <>? (0))
          then (
            if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (32768)) <>? (0))
            then (
              rely (
                (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
                  ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
              (Some (
                true  ,
                (st.[share].[granule_data] :<
                  (((st.(share)).(granule_data)) #
                    (((st.(share)).(slots)) @ SLOT_REC) ==
                    ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_pc] :<
                        ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc)) + (4))).[e_regs] :<
                        ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) #
                          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) ==
                          ((Z.lxor
                            (1 << ((((access_len_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) * (8)) + ((- 1))))) 
                            ((access_mask_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) &
                              ((((st.(stack)).(smc_rec_enter_stack)) @ ((v_rec_entry.(poffset)) + (512)))))) -
                            ((1 << ((((access_len_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) * (8)) + ((- 1))))))))))))
              )))
            else (
              rely (
                (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
                  ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
              (Some (
                true  ,
                (st.[share].[granule_data] :<
                  (((st.(share)).(granule_data)) #
                    (((st.(share)).(slots)) @ SLOT_REC) ==
                    ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_pc] :<
                        ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc)) + (4))).[e_regs] :<
                        ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) #
                          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) ==
                          (((Z.lxor
                            (1 << ((((access_len_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) * (8)) + ((- 1))))) 
                            ((access_mask_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) &
                              ((((st.(stack)).(smc_rec_enter_stack)) @ ((v_rec_entry.(poffset)) + (512)))))) -
                            ((1 << ((((access_len_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) * (8)) + ((- 1))))))) &
                            (4294967295)))))))
              ))))
          else (
            rely (
              (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
                ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
            (Some (
              true  ,
              (st.[share].[granule_data] :<
                (((st.(share)).(granule_data)) #
                  (((st.(share)).(slots)) @ SLOT_REC) ==
                  ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                    ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_pc] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc)) + (4))).[e_regs] :<
                      ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) #
                        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) ==
                        ((access_mask_spec' ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) st) &
                          ((((st.(stack)).(smc_rec_enter_stack)) @ ((v_rec_entry.(poffset)) + (512))))))))))
            ))))
        else (
          (Some (
            true  ,
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_pc] :<
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc)) + (4)))))
          )))))
    else (Some (false, st))).

Definition complete_mmio_emulation_spec (v_rec: Ptr) (v_rec_entry: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_rec_entry.(pbase)) = ("smc_rec_enter_stack")))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_rec_entry.(pbase)) = ("smc_rec_enter_stack")))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  if (((((st.(stack)).(smc_rec_enter_stack)) @ (v_rec_entry.(poffset))) & (1)) =? (0))
  then (
    when st' == ((complete_mmio_emulation_spec_state_oracle st));
    (Some (true, st')))
  else (
    if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (4227858432)) =? (2415919104))
    then (
      if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (16777216)) =? (0))
      then (
        when st' == ((complete_mmio_emulation_spec_state_oracle st));
        (Some (false, st')))
      else (
        if (
          if (xorb ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (64)) <>? (0)) true)
          then (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) <>? (31))
          else false)
        then (
          rely (
            (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
              ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
          when st' == ((complete_mmio_emulation_spec_state_oracle st));
          (Some (true, st')))
        else (
          when st' == ((complete_mmio_emulation_spec_state_oracle st));
          (Some (true, st')))))
    else (
      when st' == ((complete_mmio_emulation_spec_state_oracle st));
      (Some (false, st')))).

