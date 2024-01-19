Parameter complete_psci_cpu_on_spec_state_oracle : RData -> (option RData).

Definition complete_psci_cpu_on_spec_shadow (v_target_rec: Ptr) (v_entry_point_address: Z) (v_caller_sctlr_el1: Z) (st: RData) : (option (Z * RData)) :=
  rely (
    ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
      end)) /\
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
      (if (
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
        end))));
  if (
    (((((st.(share)).(granules)) @ (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_refcount)) =?
      (0)))
  then (
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_runnable)) & (1)) =? (0))
    then (
      when st' == ((psci_reset_rec_spec_state_oracle st));
      rely (
        match (((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
        | (Some cid) => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
        | None => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
        end);
      (Some (
        0  ,
        (st'.[share].[granule_data] :<
          (((st'.(share)).(granule_data)) #
            (((st'.(share)).(slots)) @ SLOT_REC2) ==
            ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).[g_rec] :<
              ((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(g_rec)).[e_pc] :< v_entry_point_address).[e_runnable] :< 1))))
      )))
    else (Some ((- 4), st)))
  else (Some ((- 4), st)).

Definition complete_psci_cpu_on_spec (v_target_rec: Ptr) (v_entry_point_address: Z) (v_caller_sctlr_el1: Z) (st: RData) : (option (Z * RData)) :=
  rely (
    if (
      ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) =>
        ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true)))) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
          (((("granules" = ("granules")) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
            ((true = (true))))))
      | None =>
        ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
          (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true)))) /\
          (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
            ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
          (((("granules" = ("granules")) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
            ((true = (true))))))
      end)
    else (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) =>
        match (((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) =>
          ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
            (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true)))) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
            (((("granules" = ("granules")) /\
              (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
              ((true = (true))))))
        | _ =>
          ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
            (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true)))) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
            (((("granules" = ("granules")) /\
              (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
              ((false = (true))))))
        end
      | None =>
        match (((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) =>
          ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
            (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true)))) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
            (((("granules" = ("granules")) /\
              (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
              ((true = (true))))))
        | _ =>
          ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
            (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true)))) /\
            (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
              ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
            (((("granules" = ("granules")) /\
              (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))) /\
              ((false = (true))))))
        end
      end));
  if (
    (((((st.(share)).(granules)) @ (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_refcount)) =?
      (0)))
  then (
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_runnable)) & (1)) =? (0))
    then (
      when st' == ((psci_reset_rec_spec_state_oracle st));
      rely (
        match (((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
        | (Some cid) => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
        | None => ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
        end);
      when st'' == ((complete_psci_cpu_on_spec_state_oracle st'));
      (Some (
        0  ,
        (st''.[share].[granule_data] :<
          (((st'.(share)).(granule_data)) #
            (((st'.(share)).(slots)) @ SLOT_REC2) ==
            ((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_REC2)).[g_rec].[e_runnable] :< 1)))
      )))
    else (
      when st' == ((complete_psci_cpu_on_spec_state_oracle st));
      (Some ((- 4), st'))))
  else (
    when st' == ((complete_psci_cpu_on_spec_state_oracle st));
    (Some ((- 4), st'))).

Definition complete_psci_affinity_info_spec' (v_target_rec: Ptr) (st: RData) : (option Z) :=
  rely (
    ((((((v_target_rec.(pbase)) = ("slot_rec2")) /\ (((v_target_rec.(poffset)) = (0)))) /\
      (match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0)) = (true))
      | None => ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1)) = (true))
      end)) /\
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) > (0)) /\
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) >= (0)))) /\
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - ((GRANULES_BASE + (16777216)))) < (0)))))) /\
      (if (
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
        end))));
  if (
    (((((st.(share)).(granules)) @ (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_g_rec)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_refcount)) =?
      (0)))
  then (
    if (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_runnable)) & (1)) =? (0))
    then (Some 1)
    else (Some 0))
  else (Some 0).

Definition complete_psci_affinity_info_spec (v_target_rec: Ptr) (st: RData) : (option (Z * RData)) :=
  when ret == ((complete_psci_affinity_info_spec' v_target_rec st));
  (Some (ret, st)).

