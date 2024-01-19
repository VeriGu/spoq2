Parameter psci_complete_request_spec_state_oracle : RData -> (option RData).

Definition psci_complete_request_spec_shadow (v_calling_rec: Ptr) (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_calling_rec.(pbase)) = ("slot_rec")) /\ (((v_calling_rec.(poffset)) = (0)))) /\
      ((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)));
  if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_psci_info)).(e_pending)) & (1)) =? (0))
  then (Some (1, st))
  else (
    rely (
      ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
        (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
        | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
        | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
        end)) /\
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))));
    if (
      (true &&
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) +
          (((- 1) * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)))))) =?
          (0)))))
    then (
      if (
        (((((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (4)) & (4080)) |'
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (15)))) |'
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (4)) & (1044480)))) |'
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (12)) & (267386880)))) -
          ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_rec_idx)))) =?
          (0)))
      then (
        if (
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 0) =? (2214592515)) ||
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 0) =? (3288334339)))))
        then (
          (Some (
            0  ,
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_psci_info].[e_pending] :< 0).[e_regs] :<
                    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) # 0 == (- 1)) # 1 == 0) # 2 == 0) # 3 == 0)))))
          )))
        else (
          when ret == ((complete_psci_affinity_info_spec' v_target_rec st));
          (Some (
            0  ,
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_psci_info].[e_pending] :< 0).[e_regs] :<
                    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) # 0 == ret) # 1 == 0) # 2 == 0) # 3 == 0)))))
          ))))
      else (Some (1, st)))
    else (Some (1, st))).

Definition psci_complete_request_spec (v_calling_rec: Ptr) (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      (((((v_calling_rec.(pbase)) = ("slot_rec")) /\ (((v_calling_rec.(poffset)) = (0)))) /\
        ((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      (((((v_calling_rec.(pbase)) = ("slot_rec")) /\ (((v_calling_rec.(poffset)) = (0)))) /\
        ((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_psci_info)).(e_pending)) & (1)) =? (0))
  then (
    when st' == ((psci_complete_request_spec_state_oracle st));
    (Some (1, st')))
  else (
    rely (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) =>
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true)))) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
            ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
              (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
      | None =>
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true)))) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
            ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
              (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0))))))))
      end);
    if (
      (true &&
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) +
          (((- 1) * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)))))) =?
          (0)))))
    then (
      if (
        (((((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (4)) & (4080)) |'
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (15)))) |'
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (4)) & (1044480)))) |'
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (12)) & (267386880)))) -
          ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_rec_idx)))) =?
          (0)))
      then (
        if (
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 0) =? (2214592515)) ||
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 0) =? (3288334339)))))
        then (
          when st' == ((psci_complete_request_spec_state_oracle st));
          (Some (
            0  ,
            (st'.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_psci_info].[e_pending] :< 0)))
          )))
        else (
          when ret == ((complete_psci_affinity_info_spec' v_target_rec st));
          when st' == ((psci_complete_request_spec_state_oracle st));
          (Some (
            0  ,
            (st'.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_psci_info].[e_pending] :< 0)))
          ))))
      else (
        when st' == ((psci_complete_request_spec_state_oracle st));
        (Some (1, st'))))
    else (
      when st' == ((psci_complete_request_spec_state_oracle st));
      (Some (1, st')))).

Definition system_off_reboot_spec (v_rec: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
      end)) /\
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
      ((("granules" = ("granules")) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  match ((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if (
      (((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
        (2)) =?
        (0)))
    then (
      rely (
        ((((match (
          ((((sh.(granules)) #
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
            (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
              (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_lock))
        ) with
        | (Some cid) =>
          ((((((sh.(granules)) #
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
            (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
              (Some CPU_ID))) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =?
            (0)) =
            (true))
        | None => (((((sh.(granules)) @ ((sh.(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
        end) /\
          ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
            (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
              ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))))) /\
          (((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
            (("granules" = ("granules")))) /\
            ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))) /\
          (match (
            ((((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
          ) with
          | (Some cid) => ((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))
          | _ => ((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))
          end)));
      match (
        ((((sh.(granules)) #
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
            (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
      ) with
      | (Some cid) =>
        (Some ((st.[log] :<
          ((EVT
            CPU_ID 
            (REL
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) 
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                (Some CPU_ID)))) ::
            (((EVT
              CPU_ID 
              (ACQ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))) ::
              ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
          (((sh.[granule_data] :<
            ((sh.(granule_data)) #
              (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4)) ==
              (((sh.(granule_data)) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).[g_rd].[e_rd_rd_state] :<
                2))).[granules] :<
            ((sh.(granules)) #
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
              (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
                None))).[slots] :<
            ((sh.(slots)) # SLOT_RD == (- 1)))))
      | _ => None
      end)
    else None
  | (Some cid) => None
  end.

