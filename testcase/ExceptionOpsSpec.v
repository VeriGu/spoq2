Definition ipa_is_empty_spec (v_ipa: Z) (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (
    ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\
      (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))))));
  if ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) - (v_ipa)) >? (0))
  then (
    rely (
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
        ((("granules" = ("granules")) /\
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      if (
        (((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
          (6)) =?
          (0)))
      then (
        rely (
          ((match (
            ((((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
          ) with
          | (Some cid) =>
            ((((((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (0)) =
              (true))
          | None => (((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
          end) /\
            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
              (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0)))))))));
        when st_8 == (
            (rtt_walk_lock_unlock_spec
              (mkPtr "granules" ((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE))) 
              (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level)) 
              (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)) 
              v_ipa 
              3 
              (mkPtr "ipa_is_empty_stack" 0) 
              ((st.[log] :<
                ((EVT
                  CPU_ID 
                  (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                  ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                (sh.[granules] :<
                  ((sh.(granules)) #
                    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                      (Some CPU_ID)))))));
        rely (
          ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) > (0)) /\
            (((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >= (0)) /\ ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
            (((((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
              ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
        when ret == (
            (__tte_read_spec'
              (mkPtr "slot_rtt" (8 * ((((st_8.(stack)).(ipa_is_empty_stack)) @ 8)))) 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))));
        if (
          (s2tte_has_hipas_spec'
            ret 
            8 
            (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))))
        then (
          when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            false  ,
            ((((st_8.[log] :<
              ((EVT
                CPU_ID 
                (REL
                  (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                  (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                ((st_8.(log))))).[share].[granules] :<
              (((st_8.(share)).(granules)) #
                (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
              (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
              ((st.(stack)).(ipa_is_empty_stack)))
          )))
        else (
          when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            ((s2tte_get_ripas_spec'
              ret 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))) =?
              (0))  ,
            ((((st_8.[log] :<
              ((EVT
                CPU_ID 
                (REL
                  (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                  (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                ((st_8.(log))))).[share].[granules] :<
              (((st_8.(share)).(granules)) #
                (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
              (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
              ((st.(stack)).(ipa_is_empty_stack)))
          ))))
      else (
        rely (
          ((match (
            ((((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None)) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
          ) with
          | (Some cid) =>
            ((((((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (0)) =
              (true))
          | None =>
            ((((((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
              (1)) =
              (true))
          end) /\
            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) > (0)) /\
              (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)) /\
                ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - ((GRANULES_BASE + (16777216)))) < (0)))))))));
        when st_8 == (
            (rtt_walk_lock_unlock_spec
              (mkPtr "granules" ((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE))) 
              (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level)) 
              (((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)) 
              v_ipa 
              3 
              (mkPtr "ipa_is_empty_stack" 0) 
              ((st.[log] :<
                ((EVT
                  CPU_ID 
                  (REL
                    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                    (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                      (Some CPU_ID)))) ::
                  (((EVT
                    CPU_ID 
                    (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                    ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[granules] :<
                  ((sh.(granules)) #
                    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                      None))))));
        rely (
          ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) > (0)) /\
            (((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >= (0)) /\ ((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
            (((((((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
              ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
        when ret == (
            (__tte_read_spec'
              (mkPtr "slot_rtt" (8 * ((((st_8.(stack)).(ipa_is_empty_stack)) @ 8)))) 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))));
        if (
          (s2tte_has_hipas_spec'
            ret 
            8 
            (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))))
        then (
          when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            false  ,
            ((((st_8.[log] :<
              ((EVT
                CPU_ID 
                (REL
                  (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                  (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                ((st_8.(log))))).[share].[granules] :<
              (((st_8.(share)).(granules)) #
                (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
              (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
              ((st.(stack)).(ipa_is_empty_stack)))
          )))
        else (
          when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
          (Some (
            ((s2tte_get_ripas_spec'
              ret 
              (st_8.[share].[slots] :< (((st_8.(share)).(slots)) # SLOT_RTT == (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) >> (4))))) =?
              (0))  ,
            ((((st_8.[log] :<
              ((EVT
                CPU_ID 
                (REL
                  (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                  (((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))))) ::
                ((st_8.(log))))).[share].[granules] :<
              (((st_8.(share)).(granules)) #
                (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                ((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(ipa_is_empty_stack)) @ 0) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :< None))).[share].[slots] :<
              (((st_8.(share)).(slots)) # SLOT_RTT == (- 1))).[stack].[ipa_is_empty_stack] :<
              ((st.(stack)).(ipa_is_empty_stack)))
          ))))
    | (Some cid) => None
    end)
  else (Some (false, st)).

Definition access_in_rec_par_spec (v_rec: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  (Some (((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) - (v_addr)) >? (0)), st)).

Definition fixup_aarch32_data_abort_spec (v_rec: Ptr) (v_esr: Ptr) (st: RData) : (option (bool * RData)) :=
  rely (((v_esr.(pbase)) = ("handle_data_abort_stack")));
  if (((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0))
  then (Some ((xorb (((((st.(priv)).(pcpu_regs)).(pcpu_spsr_el2)) & (16)) =? (0)) true), st))
  else (
    (Some (
      true  ,
      (st.[stack].[handle_data_abort_stack] :<
        (((st.(stack)).(handle_data_abort_stack)) # (v_esr.(poffset)) == ((((st.(stack)).(handle_data_abort_stack)) @ (v_esr.(poffset))) & (18446744073692774399))))
    ))).

Definition get_dabt_write_value_spec' (v_rec: Ptr) (v_esr: Z) (st: RData) : (option Z) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  if (((v_esr >> (16)) & (31)) =? (31))
  then (Some 0)
  else (
    rely (
      ((((0 - (((v_esr >> (16)) & (31)))) <= (0)) /\ ((((v_esr >> (16)) & (31)) < (31)))) /\
        (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
        | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
        | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
        end)));
    (Some ((access_mask_spec' v_esr st) & (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ ((v_esr >> (16)) & (31))))))).

Definition get_dabt_write_value_spec (v_rec: Ptr) (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  when ret == ((get_dabt_write_value_spec' v_rec v_esr st));
  (Some (ret, st)).

Definition handle_sync_external_abort_spec (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option (bool * RData)) :=
  rely (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ ((((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")) /\ (((v_rec_exit.(poffset)) = (0)))))));
  if (fsc_is_external_abort_spec' (v_esr & (63)) st)
  then (
    if ((v_esr & (6144)) =? (4096))
    then (Some ((fsc_is_external_abort_spec' (v_esr & (63)) st), st))
    else (
      when st' == ((inject_sync_idabort_spec_state_oracle st));
      (Some (
        (fsc_is_external_abort_spec' (v_esr & (63)) st)  ,
        (st'.[stack].[smc_rec_enter_stack] :< (((st'.(stack)).(smc_rec_enter_stack)) # 256 == (v_esr & (4227866175))))
      ))))
  else (Some ((fsc_is_external_abort_spec' (v_esr & (63)) st), st)).

Definition emulate_sysreg_access_ns_spec (v_rec: Ptr) (v_rec_exit: Ptr) (v_esr: Z) (st: RData) : (option RData) :=
  rely (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ ((((v_rec_exit.(pbase)) = ("smc_rec_enter_stack")) /\ (((v_rec_exit.(poffset)) = (0)))))));
  if ((v_esr & (1)) =? (0))
  then (
    when ret == ((get_sysreg_write_value_spec' v_rec v_esr st));
    (Some (st.[stack].[smc_rec_enter_stack] :< (((st.(stack)).(smc_rec_enter_stack)) # 512 == ret))))
  else (Some st).

Definition psci_rsi_spec (v_agg_result: Ptr) (v_rec: Ptr) (v_function_id: Z) (v_arg0: Z) (v_arg1: Z) (v_arg2: Z) (st: RData) : (option RData) :=
  rely (((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")));
  if (
    (((((((v_function_id =? (2214592512)) || ((v_function_id =? (2214592514)))) || ((v_function_id =? (2214592520)))) || ((v_function_id =? (2214592521)))) ||
      ((v_function_id =? (2214592522)))) ||
      (((v_function_id =? (2214592513)) || ((v_function_id =? (3288334337)))))) ||
      (((v_function_id =? (2214592515)) || ((v_function_id =? (3288334339)))))))
  then (
    if (
      ((((((v_function_id =? (2214592512)) || ((v_function_id =? (2214592514)))) || ((v_function_id =? (2214592520)))) || ((v_function_id =? (2214592521)))) ||
        ((v_function_id =? (2214592522)))) ||
        (((v_function_id =? (2214592513)) || ((v_function_id =? (3288334337)))))))
    then (
      if (
        (((((v_function_id =? (2214592512)) || ((v_function_id =? (2214592514)))) || ((v_function_id =? (2214592520)))) || ((v_function_id =? (2214592521)))) ||
          ((v_function_id =? (2214592522)))))
      then (
        if ((((v_function_id =? (2214592512)) || ((v_function_id =? (2214592514)))) || ((v_function_id =? (2214592520)))) || ((v_function_id =? (2214592521))))
        then (
          if (((v_function_id =? (2214592512)) || ((v_function_id =? (2214592514)))) || ((v_function_id =? (2214592520))))
          then (
            if ((v_function_id =? (2214592512)) || ((v_function_id =? (2214592514))))
            then (
              if (v_function_id =? (2214592512))
              then (
                (Some (st.[stack].[handle_realm_rsi_stack] :<
                  ((((st.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 1)) # (v_agg_result.(poffset)) == 0))))
              else (
                rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
                when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
                (Some (st_1.[stack].[handle_realm_rsi_stack] :< (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 65537)))))
            else (
              rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
              when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
              rely (
                match (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
                | (Some cid) => ((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
                | None => ((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
                end);
              (Some ((st_1.[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  (((st_1.(share)).(slots)) @ SLOT_REC) ==
                  ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_runnable] :< 0))).[stack].[handle_realm_rsi_stack] :<
                ((((st_1.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (32)) == 0)))))
          else (
            rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
            when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
            rely (
              match (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
              | (Some cid) =>
                ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                  (((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))) /\
                  (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                    ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                      (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                  ((("granules" = ("granules")) /\
                    ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
              | None =>
                ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                  (((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)))) /\
                  (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                    ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                      (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                  ((("granules" = ("granules")) /\
                    ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
              end);
            when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
            match ((((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
            | None =>
              if (
                (((((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
                  (2)) =?
                  (0)))
              then (
                rely (
                  match (
                    ((((sh.(granules)) #
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
                  ) with
                  | (Some cid) =>
                    match (
                      ((((sh.(granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
                    ) with
                    | (Some cid_0) =>
                      (((((((((sh.(granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                        (0)) =
                        (true)) /\
                        ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                          (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                        (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                          (("granules" = ("granules")))) /\
                          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                        (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
                    | _ =>
                      (((((((((sh.(granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                        (0)) =
                        (true)) /\
                        ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                          (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                        (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                          (("granules" = ("granules")))) /\
                          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                        (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
                    end
                  | None =>
                    match (
                      ((((sh.(granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
                    ) with
                    | (Some cid) =>
                      ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
                        ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                          (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                        (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                          (("granules" = ("granules")))) /\
                          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                        (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
                    | _ =>
                      ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
                        ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                          (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                        (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                          (("granules" = ("granules")))) /\
                          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                        (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
                    end
                  end);
                match (
                  ((((sh.(granules)) #
                    ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                      (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
                ) with
                | (Some cid) =>
                  (Some (((st_1.[log] :<
                    ((EVT
                      CPU_ID 
                      (REL
                        ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                        (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          (Some CPU_ID)))) ::
                      (((EVT
                        CPU_ID 
                        (ACQ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                        ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log))))))))).[share] :<
                    (((sh.[granule_data] :<
                      ((sh.(granule_data)) #
                        (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4)) ==
                        (((sh.(granule_data)) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).[g_rd].[e_rd_rd_state] :<
                          2))).[granules] :<
                      ((sh.(granules)) #
                        ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                        (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                          None))).[slots] :<
                      ((sh.(slots)) # SLOT_RD == (- 1)))).[stack].[handle_realm_rsi_stack] :<
                    (((st_1.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1)))
                | _ => None
                end)
              else None
            | (Some cid) => None
            end))
        else (
          rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
          when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
          rely (
            match (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
            | (Some cid) =>
              ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                (((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))) /\
                (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                  ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                    (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                ((("granules" = ("granules")) /\
                  ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
            | None =>
              ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
                (((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)))) /\
                (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                  ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                    (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                ((("granules" = ("granules")) /\
                  ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))))))
            end);
          when sh == (((st_1.(repl)) ((st_1.(oracle)) (st_1.(log))) (st_1.(share))));
          match ((((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
          | None =>
            if (
              (((((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
                (2)) =?
                (0)))
            then (
              rely (
                match (
                  ((((sh.(granules)) #
                    ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                    (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                      (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
                ) with
                | (Some cid) =>
                  match (
                    ((((sh.(granules)) #
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
                  ) with
                  | (Some cid_0) =>
                    (((((((((sh.(granules)) #
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                      (0)) =
                      (true)) /\
                      ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                        (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                          ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                      (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                        (("granules" = ("granules")))) /\
                        ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                      (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
                  | _ =>
                    (((((((((sh.(granules)) #
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
                      (0)) =
                      (true)) /\
                      ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                        (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                          ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                      (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                        (("granules" = ("granules")))) /\
                        ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                      (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
                  end
                | None =>
                  match (
                    ((((sh.(granules)) #
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
                  ) with
                  | (Some cid) =>
                    ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
                      ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                        (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                          ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                      (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                        (("granules" = ("granules")))) /\
                        ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                      (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))))
                  | _ =>
                    ((((((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
                      ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                        (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                          ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
                      (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                        (("granules" = ("granules")))) /\
                        ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
                      (((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))))
                  end
                end);
              match (
                ((((sh.(granules)) #
                  ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                  (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                    (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
              ) with
              | (Some cid) =>
                (Some (((st_1.[log] :<
                  ((EVT
                    CPU_ID 
                    (REL
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        (Some CPU_ID)))) ::
                    (((EVT
                      CPU_ID 
                      (ACQ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
                      ((((st_1.(oracle)) (st_1.(log))) ++ ((st_1.(log))))))))).[share] :<
                  (((sh.[granule_data] :<
                    ((sh.(granule_data)) #
                      (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4)) ==
                      (((sh.(granule_data)) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).[g_rd].[e_rd_rd_state] :<
                        2))).[granules] :<
                    ((sh.(granules)) #
                      ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
                      (((sh.(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                        None))).[slots] :<
                    ((sh.(slots)) # SLOT_RD == (- 1)))).[stack].[handle_realm_rsi_stack] :<
                  (((st_1.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1)))
              | _ => None
              end)
            else None
          | (Some cid) => None
          end))
      else (
        rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
        when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
        if (
          (((((((((((v_arg0 =? (2214592513)) || ((v_arg0 =? (3288334337)))) || ((v_arg0 =? (2214592514)))) || ((v_arg0 =? (2214592515)))) || ((v_arg0 =? (3288334339)))) ||
            ((v_arg0 =? (2214592516)))) ||
            ((v_arg0 =? (3288334340)))) ||
            ((v_arg0 =? (2214592520)))) ||
            ((v_arg0 =? (2214592521)))) ||
            ((v_arg0 =? (2214592522)))) ||
            ((v_arg0 =? (2147483648)))))
        then (Some (st_1.[stack].[handle_realm_rsi_stack] :< (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 0)))
        else (Some (st_1.[stack].[handle_realm_rsi_stack] :< (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 1))))))
    else (
      rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
      when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
      (Some (st_1.[stack].[handle_realm_rsi_stack] :<
        ((((st_1.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (32)) == 0)))))
  else (
    if ((v_function_id =? (2214592516)) || ((v_function_id =? (3288334340))))
    then (
      rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
      when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
      if ((v_arg1 & (4294967295)) =? (0))
      then (
        rely (
          match (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) =>
            ((((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
              (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              ((((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))))))))
          | None =>
            ((((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              ((((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))))))))
          end);
        match (((((st_1.(share)).(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))) with
        | (Some cid) =>
          if (
            ((((((((v_arg0 & (4294967295)) >> (4)) & (4080)) |' (((v_arg0 & (4294967295)) & (15)))) |' ((((v_arg0 & (4294967295)) >> (4)) & (1044480)))) |'
              ((((v_arg0 & (4294967295)) >> (12)) & (267386880)))) -
              ((((((st_1.(share)).(granule_data)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rec_count)))) <?
              (0)))
          then (
            if (
              ((((((((v_arg0 & (4294967295)) >> (4)) & (4080)) |' (((v_arg0 & (4294967295)) & (15)))) |' ((((v_arg0 & (4294967295)) >> (4)) & (1044480)))) |'
                ((((v_arg0 & (4294967295)) >> (12)) & (267386880)))) -
                ((((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).(g_rec)).(e_rec_idx)))) =?
                (0)))
            then (
              (Some ((st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
                (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 0))))
            else (
              (Some (((st_1.[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  ((((st_1.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC) ==
                  ((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).[g_rec].[e_psci_info].[e_pending] :< 1))).[share].[slots] :<
                (((st_1.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
                ((((st_1.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (8)) == (v_arg0 & (4294967295)))))))
          else (
            (Some ((st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
              (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))))
        | _ => None
        end)
      else (Some (st_1.[stack].[handle_realm_rsi_stack] :< (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))))
    else (
      rely ((("handle_realm_rsi_stack" = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))));
      when st_1 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 72 false st));
      if (v_arg1 =? (0))
      then (
        rely (
          match (((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
          | (Some cid) =>
            ((((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)) /\
              (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              ((((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))))))))
          | None =>
            ((((((((st_1.(share)).(granules)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true)) /\
              (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
                ((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
                  (((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
              ((((((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
                (("granules" = ("granules")))) /\
                ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))))))))
          end);
        match (((((st_1.(share)).(granules)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))) with
        | (Some cid) =>
          if (
            (((((((v_arg0 >> (4)) & (4080)) |' ((v_arg0 & (15)))) |' (((v_arg0 >> (4)) & (1044480)))) |' (((v_arg0 >> (12)) & (267386880)))) -
              ((((((st_1.(share)).(granule_data)) @ ((((((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rec_count)))) <?
              (0)))
          then (
            if (
              (((((((v_arg0 >> (4)) & (4080)) |' ((v_arg0 & (15)))) |' (((v_arg0 >> (4)) & (1044480)))) |' (((v_arg0 >> (12)) & (267386880)))) -
                ((((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).(g_rec)).(e_rec_idx)))) =?
                (0)))
            then (
              (Some ((st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
                (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == 0))))
            else (
              (Some (((st_1.[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  ((((st_1.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC) ==
                  ((((st_1.(share)).(granule_data)) @ ((((st_1.(share)).(slots)) # SLOT_RD == (- 1)) @ SLOT_REC)).[g_rec].[e_psci_info].[e_pending] :< 1))).[share].[slots] :<
                (((st_1.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
                ((((st_1.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) # ((v_agg_result.(poffset)) + (8)) == v_arg0)))))
          else (
            (Some ((st_1.[share].[slots] :< (((st_1.(share)).(slots)) # SLOT_RD == (- 1))).[stack].[handle_realm_rsi_stack] :<
              (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))))
        | _ => None
        end)
      else (Some (st_1.[stack].[handle_realm_rsi_stack] :< (((st_1.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (32)) == (- 2)))))).

Definition handle_rsi_ipa_state_get_spec (v_agg_result: Ptr) (v_rec: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((v_agg_result.(pbase)) = ("handle_realm_rsi_stack")) /\ ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))))));
  when st_3 == ((llvm_memset_p0i8_i64_spec_state_oracle (mkPtr "handle_realm_rsi_stack" (v_agg_result.(poffset))) 0 56 false (st.[func_sp].[handle_rsi_ipa_state_get_sp] :< 12)));
  rely (
    match (((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  if ((((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (4095)) =? (0))
  then (
    if (
      ((((1 << (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) -
        (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1))) >?
        (0)))
    then (
      when v_call2, st_7 == (
          (realm_ipa_get_ripas_spec
            v_rec 
            ((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) 
            (mkPtr "handle_rsi_ipa_state_get_stack" 8) 
            (mkPtr "handle_rsi_ipa_state_get_stack" 0) 
            (st_3.[stack].[handle_realm_rsi_stack] :< (((st_3.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 0))));
      if (v_call2 =? (0))
      then (
        (Some ((st_7.[stack].[handle_realm_rsi_stack] :<
          ((((st_7.(stack)).(handle_realm_rsi_stack)) # ((v_agg_result.(poffset)) + (16)) == 0) #
            ((v_agg_result.(poffset)) + (24)) ==
            (((st_7.(stack)).(handle_rsi_ipa_state_get_stack)) @ 8))).[stack].[handle_rsi_ipa_state_get_stack] :<
          ((st.(stack)).(handle_rsi_ipa_state_get_stack)))))
      else (
        (Some ((st_7.[stack].[handle_realm_rsi_stack] :<
          ((((st_7.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 1) #
            ((v_agg_result.(poffset)) + (8)) ==
            (((st_7.(stack)).(handle_rsi_ipa_state_get_stack)) @ 0))).[stack].[handle_rsi_ipa_state_get_stack] :<
          ((st.(stack)).(handle_rsi_ipa_state_get_stack))))))
    else (
      (Some ((st_3.[stack].[handle_realm_rsi_stack] :<
        ((((st_3.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 0) # ((v_agg_result.(poffset)) + (16)) == 1)).[stack].[handle_rsi_ipa_state_get_stack] :<
        ((st.(stack)).(handle_rsi_ipa_state_get_stack))))))
  else (
    (Some ((st_3.[stack].[handle_realm_rsi_stack] :<
      ((((st_3.(stack)).(handle_realm_rsi_stack)) # (v_agg_result.(poffset)) == 0) # ((v_agg_result.(poffset)) + (16)) == 1)).[stack].[handle_rsi_ipa_state_get_stack] :<
      ((st.(stack)).(handle_rsi_ipa_state_get_stack))))).
