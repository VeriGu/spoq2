Definition mpidr_to_rec_idx_spec_mid (v_mpidr: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((((v_mpidr >> (4)) & (4080)) |' ((v_mpidr & (15)))) |' (((v_mpidr >> (4)) & (1044480)))) |' (((v_mpidr >> (12)) & (267386880)))), st)).

Definition access_mask_spec_mid (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  if (((v_esr >> (22)) & (3)) =? (2))
  then (Some (4294967295, st))
  else (
    if (((v_esr >> (22)) & (3)) =? (0))
    then (Some (255, st))
    else (
      if (((v_esr >> (22)) & (3)) =? (1))
      then (Some (65535, st))
      else (Some ((- 1), st)))).

Definition region_is_contained_spec_mid (v_container_base: Z) (v_container_end: Z) (v_region_base: Z) (v_region_end: Z) (st: RData) : (option (bool * RData)) :=
  (anno (((- 1) = ((- 1))));
  (anno (((v_region_base - (0)) = (v_region_base)));
  if ((v_region_base >=? (0)) && ((((v_container_end + ((- 1))) - (v_region_base)) >=? (0))))
  then (
    (anno (((- 1) = ((- 1))));
    (anno ((((v_region_end + ((- 1))) - (0)) = ((v_region_end + ((- 1))))));
    (anno ((((v_container_end + ((- 1))) - ((v_region_end + ((- 1))))) = ((v_container_end + (((- 1) * (v_region_end)))))));
    (Some ((((v_region_end + ((- 1))) >=? (0)) && (((v_container_end + (((- 1) * (v_region_end)))) >=? (0)))), st))))))
  else (Some (false, st)))).

Definition rd_map_read_rec_count_spec_mid (v_g_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_g_rd.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_g_rd.(pbase)) = ("granules")))) /\
      ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
  match (((((st.(share)).(granules)) @ ((v_g_rd.(poffset)) >> (4))).(e_lock))) with
  | (Some cid) =>
    (anno (((- 1) = ((- 1))));
    (Some ((((((st.(share)).(granule_data)) @ ((v_g_rd.(poffset)) >> (4))).(g_rd)).(e_rd_rec_count)), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (- 1))))))
  | _ => None
  end.

