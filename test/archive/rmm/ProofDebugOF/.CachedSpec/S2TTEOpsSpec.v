Definition realm_ipa_size_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  (Some ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))), st)).

Definition __find_next_level_idx_spec (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g_tbl.(pbase)) = ("granules")));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(e_lock)));
  if (
    (((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * (v_idx))))) &
      (3)) =?
      (3)))
  then (
    rely (
      (((0 -
        ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * (v_idx))))) &
          (281474976710655)) /
          (GRANULE_SIZE)))) <=
        (0)) /\
        (((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * (v_idx))))) &
          (281474976710655)) /
          (GRANULE_SIZE)) <
          (1048576)))));
    (Some (
      (mkPtr
        "granules"
        (16 *
          ((((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(g_norm)) @ (((18446744073709510656 - (SLOT_VIRT)) mod (GRANULE_SIZE)) + ((8 * (v_idx))))) &
            (281474976710655)) /
            (GRANULE_SIZE)))))  ,
      (st.[share].[slots] :<
        (((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
    )))
  else (
    (Some (
      (mkPtr "null" 0)  ,
      (st.[share].[slots] :<
        (((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g_tbl.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))
    ))).

