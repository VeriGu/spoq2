Definition realm_par_size_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  (Some (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)), st)).

Definition realm_vtcr_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  rely (
    (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) <= (0)) /\
      ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) < (4)))));
  if ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) =? (0))
  then (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
    then (
      (Some (
        ((0 |' (3221894400)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
        st
      )))
    else (
      (Some (
        ((0 |' (3221370112)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
        st
      ))))
  else (
    if ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) =? (8))
    then (
      if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
      then (
        (Some (
          ((64 |' (3221894400)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
          st
        )))
      else (
        (Some (
          ((64 |' (3221370112)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
          st
        ))))
    else (
      if ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) =? (16))
      then (
        if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
        then (
          (Some (
            ((128 |' (3221894400)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
            st
          )))
        else (
          (Some (
            ((128 |' (3221370112)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
            st
          ))))
      else (
        if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
        then (
          (Some (
            ((192 |' (3221894400)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
            st
          )))
        else (
          (Some (
            ((192 |' (3221370112)) |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63))))  ,
            st
          )))))).

Definition max_ipa_size_spec (st: RData) : (option (Z * RData)) :=
  rely ((((0 - (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) <= (0)) /\ ((((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) < (7)))));
  if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (0))
  then (Some (32, st))
  else (
    if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (4))
    then (Some (36, st))
    else (
      if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (8))
      then (Some (40, st))
      else (
        if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (12))
        then (Some (42, st))
        else (
          if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (16))
          then (Some (44, st))
          else (
            if ((4 * (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)))) =? (20))
            then (Some (48, st))
            else (Some (52, st))))))).

Definition addr_in_rec_par_spec (v_rec: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
  if (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (Some (((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) - (v_addr)) >? (0)), st))
  else None.

