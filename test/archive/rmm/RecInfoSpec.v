Definition mpidr_to_rec_idx_spec (v_mpidr: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((((v_mpidr >> (4)) & (4080)) |' ((v_mpidr & (15)))) |' (((v_mpidr >> (4)) & (1044480)))) |' (((v_mpidr >> (12)) & (267386880)))), st)).

Definition access_mask_spec' (v_esr: Z) (st: RData) : Z :=
  if (((v_esr >> (22)) & (3)) =? (2))
  then 4294967295
  else (
    if (((v_esr >> (22)) & (3)) =? (0))
    then 255
    else (
      if (((v_esr >> (22)) & (3)) =? (1))
      then 65535
      else (- 1))).

Definition access_mask_spec (v_esr: Z) (st: RData) : (option (Z * RData)) :=
  let ret := (access_mask_spec' v_esr st) in
  (Some (ret, st)).

Definition region_is_contained_spec' (v_container_base: Z) (v_container_end: Z) (v_region_base: Z) (v_region_end: Z) (st: RData) : bool :=
  if ((v_region_base >=? (0)) && ((((v_container_end + ((- 1))) - (v_region_base)) >=? (0))))
  then (((v_region_end + ((- 1))) >=? (0)) && (((v_container_end + (((- 1) * (v_region_end)))) >=? (0))))
  else false.

Definition region_is_contained_spec (v_container_base: Z) (v_container_end: Z) (v_region_base: Z) (v_region_end: Z) (st: RData) : (option (bool * RData)) :=
  let ret := (region_is_contained_spec' v_container_base v_container_end v_region_base v_region_end st) in
  (Some (ret, st)).

Definition rd_map_read_rec_count_spec (v_g_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_g_rd.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_g_rd.(pbase)) = ("granules")))) /\
      ((((2 <= (24)) /\ ((2 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
  match (((((st.(share)).(granules)) @ ((v_g_rd.(poffset)) >> (4))).(e_lock))) with
  | (Some cid) => (Some ((((((st.(share)).(granule_data)) @ ((v_g_rd.(poffset)) >> (4))).(g_rd)).(e_rd_rec_count)), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (- 1)))))
  | _ => None
  end.

