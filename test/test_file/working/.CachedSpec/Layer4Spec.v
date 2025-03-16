Definition atomic_add_64_spec (loc: Ptr) (val: Z) (st: RData) : (option RData) :=
  when v, st == ((load_RData 64 loc st));
  when st == ((store_RData 64 loc (v + (val)) st));
  (Some st).

Definition cpuid_spec (st: RData) : (option (Z * RData)) :=
  (Some (CPU_ID, st)).

Definition find_granule_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
  when st_1 == ((query_oracle st));
  rely (((((st_1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
  if ((v_0 - (MEM1_PHYS)) >=? (0))
  then (Some ((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))), st))
  else (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), st_1)).

