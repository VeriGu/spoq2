Parameter s2_addr_to_idx_para : Z -> Z -> Z).

Definition cpuid_spec (st: RData) : (option (Z * RData)) :=
  (Some (CPU_ID, st)).

Definition find_granule_spec_abs (v_0: abs_PA_t) (st: RData) : (option (Ptr * RData)) :=
  (Some ((mkPtr "granules" (v_0.(meta_granule_offset))), st)).

Definition __find_next_level_idx_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  if (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * (v_1))))) st).(meta_desc_type)) =? (3))
  then (Some ((mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * (v_1))))) st).(meta_PA)).(meta_granule_offset))), st))
  else (Some ((mkPtr "null" 0), st)).

Definition s2_addr_to_idx_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((s2_addr_to_idx_para v_0 v_1), st)).

Definition find_granule_spec (v_0: Z) (st: Z) : (option (Ptr * RData)) :=
  None.

Definition granule_lock_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
  when v_3, st_0 == ((granule_try_lock_spec v_0 v_1 st));
  (Some st_0).

Definition s2tte_create_ripas_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  when v__0, st_0 == (
      if (v_0 =? (0))
      then (Some (0, st))
      else (Some (64, st)));
  (Some (v__0, st_0)).

