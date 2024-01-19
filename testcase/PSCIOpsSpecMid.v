Definition complete_psci_cpu_on_spec_mid (v_target_rec: Ptr) (v_entry_point_address: Z) (v_caller_sctlr_el1: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
  rely (
    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))));
  rely (
    if (
      ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then (
      ((("granules" = ("granules")) /\
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
        ((true = (true)))))
    else (
      match (((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) =>
        ((("granules" = ("granules")) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
          ((true = (true))))
      | _ =>
        ((("granules" = ("granules")) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
          ((false = (true))))
      end));
  (anno (
    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) =
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno (
    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (0)) =
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))));
  if (
    (((((st.(share)).(granules)) @ (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_refcount)) =?
      (0)))
  then (
    (anno (((3272 * (0)) = (0)));
    (anno (((16 + (0)) = (16)));
    (anno (((0 + (16)) = (16)));
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_runnable)) & (1)) =? (0))
    then (
      when st' == ((psci_reset_rec_spec_state_oracle st));
      (anno (((3272 * (0)) = (0)));
      (anno (((272 + (0)) = (272)));
      (anno (((0 + (272)) = (272)));
      rely (
        match (((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
        | (Some cid) => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
        | None => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
        end);
      (anno (((3272 * (0)) = (0)));
      (anno (((16 + (0)) = (16)));
      (anno (((0 + (16)) = (16)));
      (Some (
        0  ,
        (st'.[share].[granule_data] :<
          (((st'.(share)).(granule_data)) #
            (((st'.(share)).(slots)) @ SLOT_REC2) ==
            ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).[g_rec] :<
              ((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(g_rec)).[e_pc] :< v_entry_point_address).[e_runnable] :< 1))))
      )))))))))
    else (
      (anno (((- 4) = ((- 4))));
      (Some ((- 4), st))))))))
  else (
    (anno (((- 4) = ((- 4))));
    (Some ((- 4), st)))))))))).

Definition complete_psci_affinity_info_spec_mid (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))));
  (anno (((3272 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
    | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
    | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
    end);
  (anno (((RMM_MAX_GRANULES * (ST_GRANULE_SIZE)) = (16777216)));
  rely (
    ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))));
  rely (
    if (
      ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then (
      ((("granules" = ("granules")) /\
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
        ((true = (true)))))
    else (
      match (((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) =>
        ((("granules" = ("granules")) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
          ((true = (true))))
      | _ =>
        ((("granules" = ("granules")) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
          ((false = (true))))
      end));
  (anno (
    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE)) =
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + ((8 / (ST_GRANULE_SIZE)))))));
  (anno (((8 / (ST_GRANULE_SIZE)) = (0)));
  (anno (
    (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (0)) =
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)))));
  if (
    (((((st.(share)).(granules)) @ (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_refcount)) =?
      (0)))
  then (
    (anno (((3272 * (0)) = (0)));
    (anno (((16 + (0)) = (16)));
    (anno (((0 + (16)) = (16)));
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_runnable)) & (1)) =? (0))
    then (Some (1, st))
    else (Some (0, st))))))
  else (Some (0, st)))))))).

