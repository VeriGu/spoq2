Definition psci_complete_request_spec_mid (v_calling_rec: Ptr) (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_calling_rec.(pbase)) = ("slot_rec")) /\ (((v_calling_rec.(poffset)) = (0)))));
  rely ((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))));
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
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((960 + (0)) = (960)));
  (anno (((0 + (960)) = (960)));
  if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_psci_info)).(e_pending)) & (1)) =? (0))
  then (Some (1, st))
  else (
    (anno (((3272 * (0)) = (0)));
    (anno (((24 + (0)) = (24)));
    (anno (((880 + (24)) = (904)));
    (anno (((0 + (904)) = (904)));
    (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
    rely (
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))));
    (anno (((3272 * (0)) = (0)));
    (anno (((24 + (0)) = (24)));
    (anno (((880 + (24)) = (904)));
    (anno (((0 + (904)) = (904)));
    rely (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
      end);
    (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
    rely (
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))));
    (anno (
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) -
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)))) =
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) +
          (((- 1) * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)))))))));
    if (
      (true &&
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) +
          (((- 1) * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_realm_info)).(e_g_rd)))))) =?
          (0)))))
    then (
      (anno (((3272 * (0)) = (0)));
      (anno (((8 + (0)) = (8)));
      (anno (((0 + (8)) = (8)));
      (anno ((((v_calling_rec.(poffset)) + (32)) = (32)));
      (anno (((32 - (24)) = (8)));
      (anno (((8 / (8)) = (1)));
      if (
        (((((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (4)) & (4080)) |'
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) & (15)))) |'
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (4)) & (1044480)))) |'
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 1) >> (12)) & (267386880)))) -
          ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_rec_idx)))) =?
          (0)))
      then (
        (anno (((3272 * (0)) = (0)));
        (anno (((8 * (0)) = (0)));
        (anno (((0 + (0)) = (0)));
        (anno (((24 + (0)) = (24)));
        (anno (((0 + (24)) = (24)));
        (anno ((((v_calling_rec.(poffset)) + (24)) = (24)));
        (anno (((24 - (24)) = (0)));
        (anno (((0 / (8)) = (0)));
        if (
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 0) =? (2214592515)) ||
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ 0) =? (3288334339)))))
        then (
          (anno (((- 1) = ((- 1))));
          (anno (((8 * (0)) = (0)));
          (anno (((0 + (24)) = (24)));
          (anno (((8 * (1)) = (8)));
          (anno (((8 + (0)) = (8)));
          (anno (((24 + (8)) = (32)));
          (anno (((0 + (32)) = (32)));
          (anno (((8 * (2)) = (16)));
          (anno (((16 + (0)) = (16)));
          (anno (((24 + (16)) = (40)));
          (anno (((0 + (40)) = (40)));
          (anno (((8 * (3)) = (24)));
          (anno (((24 + (0)) = (24)));
          (anno (((24 + (24)) = (48)));
          (anno (((0 + (48)) = (48)));
          (anno (((3272 * (0)) = (0)));
          (anno (((0 + (0)) = (0)));
          (anno (((960 + (0)) = (960)));
          (anno (((0 + (960)) = (960)));
          (anno ((((v_calling_rec.(poffset)) + (24)) = (24)));
          (anno (((24 - (24)) = (0)));
          (anno (((0 / (8)) = (0)));
          (anno ((((v_calling_rec.(poffset)) + (32)) = (32)));
          (anno (((32 - (24)) = (8)));
          (anno (((8 / (8)) = (1)));
          (anno ((((v_calling_rec.(poffset)) + (40)) = (40)));
          (anno (((40 - (24)) = (16)));
          (anno (((16 / (8)) = (2)));
          (anno ((((v_calling_rec.(poffset)) + (48)) = (48)));
          (anno (((48 - (24)) = (24)));
          (anno (((24 / (8)) = (3)));
          (Some (
            0  ,
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_psci_info].[e_pending] :< 0).[e_regs] :<
                    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) # 0 == (- 1)) # 1 == 0) # 2 == 0) # 3 == 0)))))
          ))))))))))))))))))))))))))))))))))
        else (
          when ret == ((complete_psci_affinity_info_spec' v_target_rec st));
          (anno (((8 * (0)) = (0)));
          (anno (((0 + (24)) = (24)));
          (anno (((8 * (1)) = (8)));
          (anno (((8 + (0)) = (8)));
          (anno (((24 + (8)) = (32)));
          (anno (((0 + (32)) = (32)));
          (anno (((8 * (2)) = (16)));
          (anno (((16 + (0)) = (16)));
          (anno (((24 + (16)) = (40)));
          (anno (((0 + (40)) = (40)));
          (anno (((8 * (3)) = (24)));
          (anno (((24 + (0)) = (24)));
          (anno (((24 + (24)) = (48)));
          (anno (((0 + (48)) = (48)));
          (anno (((3272 * (0)) = (0)));
          (anno (((0 + (0)) = (0)));
          (anno (((960 + (0)) = (960)));
          (anno (((0 + (960)) = (960)));
          (anno ((((v_calling_rec.(poffset)) + (24)) = (24)));
          (anno (((24 - (24)) = (0)));
          (anno (((0 / (8)) = (0)));
          (anno ((((v_calling_rec.(poffset)) + (32)) = (32)));
          (anno (((32 - (24)) = (8)));
          (anno (((8 / (8)) = (1)));
          (anno ((((v_calling_rec.(poffset)) + (40)) = (40)));
          (anno (((40 - (24)) = (16)));
          (anno (((16 / (8)) = (2)));
          (anno ((((v_calling_rec.(poffset)) + (48)) = (48)));
          (anno (((48 - (24)) = (24)));
          (anno (((24 / (8)) = (3)));
          (Some (
            0  ,
            (st.[share].[granule_data] :<
              (((st.(share)).(granule_data)) #
                (((st.(share)).(slots)) @ SLOT_REC) ==
                ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
                  ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_psci_info].[e_pending] :< 0).[e_regs] :<
                    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) # 0 == ret) # 1 == 0) # 2 == 0) # 3 == 0)))))
          ))))))))))))))))))))))))))))))))))))))))))
      else (Some (1, st)))))))))
    else (Some (1, st))))))))))))))))))))))).

Definition system_off_reboot_spec_mid (v_rec: Ptr) (st: RData) : (option RData) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((24 + (0)) = (24)));
  (anno (((880 + (24)) = (904)));
  (anno (((0 + (904)) = (904)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
  rely (
    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
      ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))));
  rely (
    (("granules" = ("granules")) /\
      ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  match ((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if (
      (((((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_state)) -
        (2)) =?
        (0)))
    then (
      (anno (((3272 * (0)) = (0)));
      (anno (((24 + (0)) = (24)));
      (anno (((880 + (24)) = (904)));
      (anno (((0 + (904)) = (904)));
      rely (
        match (
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
        end);
      (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
      rely (
        (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) > (0)) /\
          (((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >= (0)) /\
            ((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - ((GRANULES_BASE + (16777216)))) < (0)))))));
      rely (
        ((((((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)) /\
          (("granules" = ("granules")))) /\
          ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
      rely (
        match (
          ((((sh.(granules)) #
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
            (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
              (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
        ) with
        | (Some cid) => ((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((true = (true))))
        | _ => ((("slot_rd" = ("slot_rd")) /\ ((0 = (0)))) /\ ((false = (true))))
        end);
      match (
        ((((sh.(granules)) #
          ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) ==
          (((sh.(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).[e_lock] :<
            (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((sh.(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rd)) - (GRANULES_BASE)) >> (4))).(e_lock))
      ) with
      | (Some cid) =>
        (anno (((- 1) = ((- 1))));
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
            ((sh.(slots)) # SLOT_RD == (- 1))))))
      | _ => None
      end))))))
    else None
  | (Some cid) => None
  end))))).

