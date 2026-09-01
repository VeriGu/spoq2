Definition granule_addr_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
  if (((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) >? (8388592))
  then (Some (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (549755813888)), st))
  else (Some (((((GRANULES_BASE + ((v_0.(poffset)))) - (GRANULES_BASE)) * (256)) + (2147483648)), st)).

Definition buffer_map_spec (v_0: Z) (v_1: Z) (v_2: bool) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((((v_1 - (MEM0_PHYS)) >= (0)) /\ (((v_1 - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) /\ (((v_1 & (549755813888)) = (0)))) \/
      (((((v_1 - (MEM1_PHYS)) >= (0)) /\ (((v_1 - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))) /\ (((v_1 & (549755813888)) = (1)))))));
  if ((v_1 & (549755813888)) =? (0))
  then (Some ((int_to_ptr (v_1 + (18446744004990074880))), st))
  else (Some ((int_to_ptr (v_1 + (18446743457381744640))), st)).

