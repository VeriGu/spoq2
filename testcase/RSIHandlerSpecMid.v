Definition handle_rsi_host_call_spec_mid (v_agg_result: Ptr) (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option RData) :=
  rely (((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")));
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((24 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno ((((v_agg_result.(poffset)) + (0)) = ((v_agg_result.(poffset)))));
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 24 false st));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (1)) = (8)));
  (anno (((8 + (0)) = (8)));
  (anno (((24 + (8)) = (32)));
  (anno (((0 + (32)) = (32)));
  rely (
    match (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno ((((v_rec.(poffset)) + (32)) = (32)));
  (anno (((32 - (24)) = (8)));
  (anno (((8 / (8)) = (1)));
  if ((((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (255)) =? (0))
  then (
    (anno ((((v_rec.(poffset)) + (32)) = (32)));
    (anno (((32 - (24)) = (8)));
    (anno (((8 / (8)) = (1)));
    if (
      ((Z.lxor
        (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) + (255)) 
        ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1)) <?
        (4096)))
    then (
      (anno ((((v_rec.(poffset)) + (32)) = (32)));
      (anno (((32 - (24)) = (8)));
      (anno (((8 / (8)) = (1)));
      rely (
        (((((1 << (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
          (((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) >?
          (0)) =
          (false)));
      (anno (((24 * (0)) = (0)));
      (anno (((16 + (0)) = (16)));
      (anno (((0 + (16)) = (16)));
      (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 1))))))))))
    else (
      (anno (((24 * (0)) = (0)));
      (anno (((16 + (0)) = (16)));
      (anno (((0 + (16)) = (16)));
      (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 1)))))))))))
  else (
    (anno (((24 * (0)) = (0)));
    (anno (((16 + (0)) = (16)));
    (anno (((0 + (16)) = (16)));
    (Some (st_0.[stack].[handle_realm_rsi_stack] :< (((st_0.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 1)))))))))))))))))).

Definition handle_rsi_ipa_state_set_spec_mid (v_rec: Ptr) (v_rec_exit: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  rely (((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (1)) = (8)));
  (anno (((8 + (0)) = (8)));
  (anno (((24 + (8)) = (32)));
  (anno (((0 + (32)) = (32)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((8 * (2)) = (16)));
  (anno (((16 + (0)) = (16)));
  (anno (((24 + (16)) = (40)));
  (anno (((0 + (40)) = (40)));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (3)) = (24)));
  (anno (((24 + (0)) = (24)));
  (anno (((24 + (24)) = (48)));
  (anno (((0 + (48)) = (48)));
  (anno ((((v_rec.(poffset)) + (48)) = (48)));
  (anno (((48 - (24)) = (24)));
  (anno (((24 / (8)) = (3)));
  if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 3) >? (1))
  then (Some (true, st))
  else (
    (anno ((((v_rec.(poffset)) + (32)) = (32)));
    (anno (((32 - (24)) = (8)));
    (anno (((8 / (8)) = (1)));
    if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (4095)) =? (0))
    then (
      (anno ((((v_rec.(poffset)) + (40)) = (40)));
      (anno (((40 - (24)) = (16)));
      (anno (((16 / (8)) = (2)));
      if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) & (4095)) =? (0))
      then (
        (anno ((((v_rec.(poffset)) + (40)) = (40)));
        (anno (((40 - (24)) = (16)));
        (anno (((16 / (8)) = (2)));
        (anno ((((v_rec.(poffset)) + (32)) = (32)));
        (anno (((32 - (24)) = (8)));
        (anno (((8 / (8)) = (1)));
        (anno (
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) +
            (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) -
            (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) =
            (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2))));
        if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) >? (0))
        then (
          (anno ((((v_rec.(poffset)) + (40)) = (40)));
          (anno (((40 - (24)) = (16)));
          (anno (((16 / (8)) = (2)));
          (anno ((((v_rec.(poffset)) + (32)) = (32)));
          (anno (((32 - (24)) = (8)));
          (anno (((8 / (8)) = (1)));
          if (
            (region_is_contained_spec'
              0 
              ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) 
              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) 
              (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 2) +
                (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) 
              st))
          then (
            (anno (((848 + (0)) = (848)));
            (anno (((0 + (848)) = (848)));
            (anno (((848 + (8)) = (856)));
            (anno (((0 + (856)) = (856)));
            (anno (((848 + (16)) = (864)));
            (anno (((0 + (864)) = (864)));
            (anno (((3272 * (0)) = (0)));
            (anno (((24 + (0)) = (24)));
            (anno (((848 + (24)) = (872)));
            (anno (((0 + (872)) = (872)));
            (anno (((0 + (0)) = (0)));
            (anno (((1280 + (0)) = (1280)));
            (anno (((0 + (1280)) = (1280)));
            (anno (((8 + (0)) = (8)));
            (anno (((0 + (8)) = (8)));
            (anno (((1280 + (8)) = (1288)));
            (anno (((0 + (1288)) = (1288)));
            (anno (((2048 * (0)) = (0)));
            (anno (((16 + (0)) = (16)));
            (anno (((0 + (16)) = (16)));
            (anno (((1280 + (16)) = (1296)));
            (anno (((0 + (1296)) = (1296)));
            (anno ((((v_rec_exit.(poffset)) + (0)) = ((v_rec_exit.(poffset)))));
            (anno ((((v_rec.(poffset)) + (32)) = (32)));
            (anno (((32 - (24)) = (8)));
            (anno (((8 / (8)) = (1)));
            (anno ((((v_rec.(poffset)) + (40)) = (40)));
            (anno (((40 - (24)) = (16)));
            (anno (((16 / (8)) = (2)));
            (anno ((((v_rec.(poffset)) + (48)) = (48)));
            (anno (((48 - (24)) = (24)));
            (anno (((24 / (8)) = (3)));
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
            )))))))))))))))))))))))))))))))))))
          else (Some (true, st)))))))))
        else (Some (true, st))))))))))
      else (Some (true, st))))))
    else (Some (true, st))))))))))))))))))))))).

Definition check_pending_irq_spec_mid (st: RData) : (option (bool * RData)) :=
  (Some (((((st.(priv)).(pcpu_regs)).(pcpu_isr_el1)) <>? (0)), st)).

Definition emulate_stage2_data_abort_spec_mid (v_rec: Ptr) (v_rec_exit: Ptr) (v_rtt_level: Z) (st: RData) : (option RData) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  rely (((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (1)) = (8)));
  (anno (((8 + (0)) = (8)));
  (anno (((24 + (8)) = (32)));
  (anno (((0 + (32)) = (32)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((256 + (0)) = (256)));
  (anno (((0 + (256)) = (256)));
  (anno (((8 + (0)) = (8)));
  (anno (((0 + (8)) = (8)));
  (anno (((256 + (8)) = (264)));
  (anno (((0 + (264)) = (264)));
  (anno (((16 + (0)) = (16)));
  (anno (((0 + (16)) = (16)));
  (anno (((256 + (16)) = (272)));
  (anno (((0 + (272)) = (272)));
  (anno (((2048 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno ((((v_rec.(poffset)) + (32)) = (32)));
  (anno (((32 - (24)) = (8)));
  (anno (((8 / (8)) = (1)));
  (anno ((((v_rec_exit.(poffset)) + (0)) = ((v_rec_exit.(poffset)))));
  (Some (st.[stack].[smc_rec_enter_stack] :<
    ((((((st.(stack)).(smc_rec_enter_stack)) # ((v_rec_exit.(poffset)) + (256)) == ((v_rtt_level + (4)) |' (2415919104))) # ((v_rec_exit.(poffset)) + (264)) == 0) #
      ((v_rec_exit.(poffset)) + (272)) ==
      (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (8))) #
      (v_rec_exit.(poffset)) ==
      0)))))))))))))))))))))))).

Definition return_result_to_realm_spec_mid (v_rec: Ptr) (v_result: Ptr) (st: RData) : (option RData) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  rely (((v_result.(pbase)) = ("handle_realm_rsi_stack")));
  (anno (((40 * (0)) = (0)));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((24 + (0)) = (24)));
  (anno (((0 + (24)) = (24)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((0 + (8)) = (8)));
  (anno (((8 * (1)) = (8)));
  (anno (((8 + (0)) = (8)));
  (anno (((24 + (8)) = (32)));
  (anno (((0 + (32)) = (32)));
  (anno (((0 + (16)) = (16)));
  (anno (((8 * (2)) = (16)));
  (anno (((16 + (0)) = (16)));
  (anno (((24 + (16)) = (40)));
  (anno (((0 + (40)) = (40)));
  (anno (((40 * (0)) = (0)));
  (anno (((0 + (24)) = (24)));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (3)) = (24)));
  (anno (((24 + (0)) = (24)));
  (anno (((24 + (24)) = (48)));
  (anno (((0 + (48)) = (48)));
  (anno ((((v_rec.(poffset)) + (24)) = (24)));
  (anno (((24 - (24)) = (0)));
  (anno (((0 / (8)) = (0)));
  (anno ((((v_result.(poffset)) + (0)) = ((v_result.(poffset)))));
  (anno ((((v_rec.(poffset)) + (32)) = (32)));
  (anno (((32 - (24)) = (8)));
  (anno (((8 / (8)) = (1)));
  (anno ((((v_rec.(poffset)) + (40)) = (40)));
  (anno (((40 - (24)) = (16)));
  (anno (((16 / (8)) = (2)));
  (anno ((((v_rec.(poffset)) + (48)) = (48)));
  (anno (((48 - (24)) = (24)));
  (anno (((24 / (8)) = (3)));
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
          (((st.(stack)).(handle_realm_rsi_stack)) @ ((v_result.(poffset)) + (24)))))))))))))))))))))))))))))))))))))))))))).

Definition complete_mmio_emulation_spec_mid (v_rec: Ptr) (v_rec_entry: Ptr) (st: RData) : (option (bool * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  rely (((v_rec_entry.(pbase)) = ("smc_rec_enter_stack")));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((928 + (0)) = (928)));
  (anno (((0 + (928)) = (928)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((2048 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno ((((v_rec_entry.(poffset)) + (0)) = ((v_rec_entry.(poffset)))));
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
          (anno (((2048 * (0)) = (0)));
          (anno (((8 * (0)) = (0)));
          (anno (((0 + (0)) = (0)));
          (anno (((512 + (0)) = (512)));
          (anno (((0 + (512)) = (512)));
          if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (2097152)) <>? (0))
          then (
            if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) & (32768)) <>? (0))
            then (
              (anno (((- 1) = ((- 1))));
              rely (
                (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
                  ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
              (anno (((3272 * (0)) = (0)));
              (anno (((272 + (0)) = (272)));
              (anno (((0 + (272)) = (272)));
              (anno (
                (((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) + (0)) =
                  ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))));
              (anno (
                ((0 + ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))) =
                  ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))));
              (anno (
                (((v_rec.(poffset)) +
                  ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))) =
                  ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))));
              (anno (
                (((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))) - (24)) =
                  ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))));
              (anno (
                (((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) / (8)) =
                  (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))));
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
              ))))))))))))
            else (
              (anno (((- 1) = ((- 1))));
              rely (
                (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
                  ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
              (anno (((3272 * (0)) = (0)));
              (anno (((272 + (0)) = (272)));
              (anno (((0 + (272)) = (272)));
              (anno (
                (((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) + (0)) =
                  ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))));
              (anno (
                ((0 + ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))) =
                  ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))));
              (anno (
                (((v_rec.(poffset)) +
                  ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))) =
                  ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))));
              (anno (
                (((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))) - (24)) =
                  ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))));
              (anno (
                (((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) / (8)) =
                  (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))));
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
              )))))))))))))
          else (
            rely (
              (((0 - (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) <= (0)) /\
                ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)) < (31)))));
            (anno (((3272 * (0)) = (0)));
            (anno (((272 + (0)) = (272)));
            (anno (((0 + (272)) = (272)));
            (anno (
              (((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) + (0)) =
                ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))));
            (anno (
              ((0 + ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))) =
                ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))));
            (anno (
              (((v_rec.(poffset)) +
                ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))) =
                ((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))))));
            (anno (
              (((24 + ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))) - (24)) =
                ((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))))));
            (anno (
              (((8 * (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))) / (8)) =
                (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_last_run_info)).(e_esr)) >> (16)) & (31)))));
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
            )))))))))))))))))
        else (
          (anno (((3272 * (0)) = (0)));
          (anno (((272 + (0)) = (272)));
          (anno (((0 + (272)) = (272)));
          (Some (
            true  ,
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_pc] :<
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_pc)) + (4)))))
          ))))))))
    else (Some (false, st)))))))))).

