Parameter s2_addr_to_idx_para : Z -> Z -> Z).

Definition cpuid_spec (st: RData) : (option (Z * RData)) :=
  (Some (CPU_ID, st)).

Definition find_granule_spec_abs (v_0: abs_PA_t) (st: RData) : (option (Ptr * RData)) :=
  (Some ((mkPtr "granules" (v_0.(meta_granule_offset))), st)).

Definition find_granule_spec (v_0: Z) (st: Z) : (option (Ptr * RData)) :=
  None.

