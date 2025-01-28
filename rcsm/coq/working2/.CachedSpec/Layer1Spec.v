Definition granule_addr_spec' (v_0: Ptr) : (option Z) :=
  rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
  if ((v_0.(poffset)) >? (8388592))
  then (Some (((v_0.(poffset)) * (256)) + (549755813888)))
  else (Some (((v_0.(poffset)) * (256)) + (2147483648))).

Definition buffer_map_spec (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
  rely (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - (4294967296)) < (0)))) /\ (((v_1 & (549755813888)) = (0)))));
  rely ((((((st.(share)).(granule_data)) @ (((- 2147483648) + (v_1)) / (4096))).(g_granule_state)) = (v_0)));
  (Some ((mkPtr "granule_data" ((- 2147483648) + (v_1))), st)).

Definition granule_addr_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
  when ret == ((granule_addr_spec' v_0));
  (Some (ret, st)).

