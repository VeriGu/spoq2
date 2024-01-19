Definition realm_par_size_spec_mid (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) => (Some (((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)), st))
  | _ => None
  end.

Definition realm_vtcr_spec_mid (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) =>
    rely (
      (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) <= (0)) /\
        ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) < (4)))));
    (anno (((8 * (4)) = (32)));
    (anno (((32 * (0)) = (0)));
    (anno (
      (((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) + (0)) =
        ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))));
    (anno (
      ((0 + ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))) =
        ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))));
    if ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) =? (0))
    then (
      if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
      then (
        (anno (((0 |' (3221894400)) = (3221894400)));
        (Some ((3221894400 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st))))
      else (
        (anno (((0 |' (3221370112)) = (3221370112)));
        (Some ((3221370112 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st)))))
    else (
      (anno (
        (((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) + (0)) =
          ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))));
      (anno (
        ((0 + ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))) =
          ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))));
      if ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) =? (8))
      then (
        if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
        then (
          (anno (((64 |' (3221894400)) = (3221894464)));
          (Some ((3221894464 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st))))
        else (
          (anno (((64 |' (3221370112)) = (3221370176)));
          (Some ((3221370176 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st)))))
      else (
        (anno (
          (((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) + (0)) =
            ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))));
        (anno (
          ((0 + ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))) =
            ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))))));
        if ((8 * (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)))) =? (16))
        then (
          if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
          then (
            (anno (((128 |' (3221894400)) = (3221894528)));
            (Some ((3221894528 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st))))
          else (
            (anno (((128 |' (3221370112)) = (3221370240)));
            (Some ((3221370240 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st)))))
        else (
          if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
          then (
            (anno (((192 |' (3221894400)) = (3221894592)));
            (Some ((3221894592 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st))))
          else (
            (anno (((192 |' (3221370112)) = (3221370304)));
            (Some ((3221370304 |' (((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) & (63)))), st)))))))))))))))
  | _ => None
  end.

Definition max_ipa_size_spec_mid (st: RData) : (option (Z * RData)) :=
  when ret == ((arch_feat_get_pa_width_spec' st));
  (Some (ret, st)).

Definition addr_in_rec_par_spec_mid (v_rec: Ptr) (v_addr: Z) (st: RData) : (option (bool * RData)) :=
  rely (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true))))
    | None =>
      ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\
        (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1)) = (true))))
    end);
  (Some (((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))) >> (1)) - (v_addr)) >? (0)), st)).

