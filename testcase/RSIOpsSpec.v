Parameter do_host_call_spec_state_oracle : RData -> (option RData).

Definition do_host_call_spec (v_rec: Ptr) (v_rec_exit: Ptr) (v_rec_entry: Ptr) (v_rsi_walk_result: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ ((((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")) \/ (((v_rec_exit.(pbase)) = ("null")))))) /\
      ((((v_rec_entry.(pbase)) = ("smc_rec_enter_stack")) \/ (((v_rec_entry.(pbase)) = ("null")))))) /\
      ((((v_rsi_walk_result.(pbase)) = ("handle_rsi_host_call_stack")) \/ (((v_rsi_walk_result.(pbase)) = ("complete_rsi_host_call_stack")))))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)) /\
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
      ((((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
        (("granules" = ("granules")))) /\
        ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
  when v_call1, st_5 == (
      (realm_ipa_to_pa_spec
        (mkPtr "slot_rd" 0) 
        (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (18446744073709547520)) 
        (mkPtr "do_host_call_stack" 0) 
        (st.[share].[slots] :<
          (((st.(share)).(slots)) #
            SLOT_RD ==
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))))));
  if (v_call1 =? (2))
  then (
    when ret == ((s2_walk_result_match_ripas_spec' (mkPtr "do_host_call_stack" 0) 0 st_5));
    if ret
    then (Some (1, ((st_5.[share].[slots] :< (((st_5.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[do_host_call_stack] :< ((st.(stack)).(do_host_call_stack)))))
    else (
      if ((v_rsi_walk_result.(pbase)) =s ("complete_rsi_host_call_stack"))
      then (
        (Some (
          0  ,
          (((st_5.[share].[slots] :< (((st_5.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[complete_rsi_host_call_stack] :<
            ((((st_5.(stack)).(complete_rsi_host_call_stack)) # (v_rsi_walk_result.(poffset)) == 1) #
              ((v_rsi_walk_result.(poffset)) + (8)) ==
              (((st_5.(stack)).(do_host_call_stack)) @ 8))).[stack].[do_host_call_stack] :<
            ((st.(stack)).(do_host_call_stack)))
        )))
      else None))
  else (
    rely ((((0 - (((((st_5.(stack)).(do_host_call_stack)) @ 0) / (GRANULE_SIZE)))) <= (0)) /\ ((((((st_5.(stack)).(do_host_call_stack)) @ 0) / (GRANULE_SIZE)) < (1048576)))));
    when st_9 == (
        (do_host_call_spec_state_oracle
          (st_5.[share].[slots] :< (((st_5.(share)).(slots)) # SLOT_RSI_CALL == ((((st_5.(stack)).(do_host_call_stack)) @ 0) / (GRANULE_SIZE))))));
    rely (
      (((((st_9.(stack)).(do_host_call_stack)) @ 24) > (0)) /\
        (((((((st_9.(stack)).(do_host_call_stack)) @ 24) - (GRANULES_BASE)) >= (0)) /\
          ((((((st_9.(stack)).(do_host_call_stack)) @ 24) - ((GRANULES_BASE + (16777216)))) < (0)))))));
    when cid == (((((st_9.(share)).(granules)) @ (((((st_9.(stack)).(do_host_call_stack)) @ 24) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (
      0  ,
      ((((st_9.[log] :<
        ((EVT
          CPU_ID 
          (REL
            (((((st_9.(stack)).(do_host_call_stack)) @ 24) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
            (((st_9.(share)).(granules)) @ (((((st_9.(stack)).(do_host_call_stack)) @ 24) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
          ((st_9.(log))))).[share].[granules] :<
        (((st_9.(share)).(granules)) #
          (((((st_9.(stack)).(do_host_call_stack)) @ 24) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          ((((st_9.(share)).(granules)) @ (((((st_9.(stack)).(do_host_call_stack)) @ 24) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
        ((((st_9.(share)).(slots)) # SLOT_RSI_CALL == (- 1)) # SLOT_RD == (- 1))).[stack].[do_host_call_stack] :<
        ((st.(stack)).(do_host_call_stack)))
    ))).

Definition region_in_rec_par_spec (v_rec: Ptr) (v_base: Z) (v_end: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  (Some (
    (region_is_contained_spec'
      0 
      ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) 
      v_base 
      v_end 
      st)  ,
    st
  )).

