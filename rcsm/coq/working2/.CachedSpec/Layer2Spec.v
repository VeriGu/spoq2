Definition addr_to_idx_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  let mem0_id := ((v_0 + ((- MEM0_PHYS))) >> (12)) in
  (Some ((mem0_id * (16)), st)).

Definition granule_from_idx_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((v_0 - (NR_GRANULES)) < (0)) /\ ((v_0 >= (0)))));
  (Some ((mkPtr "granules" (16 * (v_0))), st)).

Definition granule_map_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (((((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))) /\ ((v_1 >= (0)))) /\ ((v_1 <= (24)))));
  rely ((((v_0.(poffset)) >? (8388592)) = (false)));
  rely (
    (((((v_0.(poffset)) * (256)) >= (0)) /\ ((((- 2147483648) + (((v_0.(poffset)) * (256)))) < (0)))) /\
      ((((((v_0.(poffset)) * (256)) + (2147483648)) & (549755813888)) = (0)))));
  rely (((((((st.(share)).(granule_data)) @ (((v_0.(poffset)) * (256)) / (4096))).(g_granule_state)) - (v_1)) = (0)));
  (Some ((mkPtr "granule_data" ((v_0.(poffset)) * (256))), st)).

Definition granule_get_state_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
  (Some ((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_state_s_granule)), st)).

