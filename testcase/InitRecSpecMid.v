Definition gic_cpu_state_init_spec_mid (v_gicstate: Ptr) (st: RData) : (option RData) :=
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_gicstate.(poffset)) = (584)));
  rely (((v_gicstate.(pbase)) = ("slot_rec")));
  (anno (((216 * (0)) = (0)));
  (anno (((72 + (0)) = (72)));
  (anno (((0 + (72)) = (72)));
  rely (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)));
  (anno (((584 + (72)) = (656)));
  (anno (((656 - (288)) = (368)));
  (anno (((368 - (296)) = (72)));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_hcr_el2] :< 33025)))))))))).

Definition init_rec_regs_spec_mid (v_rec: Ptr) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely (((v_rd.(poffset)) = (0)));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_rd.(pbase)) = ("slot_rd")));
  rely (((v_rec_params.(pbase)) = ("smc_rec_create_stack")));
  rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))));
  rely (((v_rec.(poffset)) = (0)));
  rely (((v_rec.(pbase)) = ("slot_rec")));
  (anno (((4096 * (0)) = (0)));
  (anno (((768 + (0)) = (768)));
  (anno (((0 + (768)) = (768)));
  (anno (((3272 * (0)) = (0)));
  (anno (((8 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((24 + (0)) = (24)));
  (anno (((0 + (24)) = (24)));
  rely (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)));
  (anno (((24 - (24)) = (0)));
  (anno (((0 / (8)) = (0)));
  (anno (((0 + (8)) = (8)));
  (anno (((768 + (8)) = (776)));
  (anno (((0 + (776)) = (776)));
  (anno (((8 * (1)) = (8)));
  (anno (((8 + (0)) = (8)));
  (anno (((24 + (8)) = (32)));
  (anno (((32 - (24)) = (8)));
  (anno (((8 / (8)) = (1)));
  (anno (((0 + (16)) = (16)));
  (anno (((768 + (16)) = (784)));
  (anno (((0 + (784)) = (784)));
  (anno (((8 * (2)) = (16)));
  (anno (((16 + (0)) = (16)));
  (anno (((24 + (16)) = (40)));
  (anno (((40 - (24)) = (16)));
  (anno (((16 / (8)) = (2)));
  (anno (((0 + (24)) = (24)));
  (anno (((768 + (24)) = (792)));
  (anno (((0 + (792)) = (792)));
  (anno (((8 * (3)) = (24)));
  (anno (((24 + (0)) = (24)));
  (anno (((24 + (24)) = (48)));
  (anno (((48 - (24)) = (24)));
  (anno (((24 / (8)) = (3)));
  (anno (((0 + (32)) = (32)));
  (anno (((768 + (32)) = (800)));
  (anno (((0 + (800)) = (800)));
  (anno (((8 * (4)) = (32)));
  (anno (((32 + (0)) = (32)));
  (anno (((24 + (32)) = (56)));
  (anno (((56 - (24)) = (32)));
  (anno (((32 / (8)) = (4)));
  (anno (((0 + (40)) = (40)));
  (anno (((768 + (40)) = (808)));
  (anno (((0 + (808)) = (808)));
  (anno (((8 * (5)) = (40)));
  (anno (((40 + (0)) = (40)));
  (anno (((24 + (40)) = (64)));
  (anno (((0 + (64)) = (64)));
  (anno (((64 - (24)) = (40)));
  (anno (((40 / (8)) = (5)));
  (anno (((0 + (48)) = (48)));
  (anno (((768 + (48)) = (816)));
  (anno (((0 + (816)) = (816)));
  (anno (((8 * (6)) = (48)));
  (anno (((48 + (0)) = (48)));
  (anno (((24 + (48)) = (72)));
  (anno (((0 + (72)) = (72)));
  (anno (((72 - (24)) = (48)));
  (anno (((48 / (8)) = (6)));
  (anno (((0 + (56)) = (56)));
  (anno (((768 + (56)) = (824)));
  (anno (((0 + (824)) = (824)));
  (anno (((8 * (7)) = (56)));
  (anno (((56 + (0)) = (56)));
  (anno (((24 + (56)) = (80)));
  (anno (((0 + (80)) = (80)));
  (anno (((80 - (24)) = (56)));
  (anno (((56 / (8)) = (7)));
  (anno (((512 + (0)) = (512)));
  (anno (((0 + (512)) = (512)));
  (anno (((272 + (0)) = (272)));
  (anno (((0 + (272)) = (272)));
  (anno (((3272 * (0)) = (0)));
  (anno (((280 + (0)) = (280)));
  (anno (((0 + (280)) = (280)));
  (anno (((4096 * (0)) = (0)));
  (anno (((0 + (0)) = (0)));
  (anno (((256 + (0)) = (256)));
  (anno (((0 + (256)) = (256)));
  when st' == (
      (init_rec_sysregs_spec_state_oracle
        (st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            (((st.(share)).(slots)) @ SLOT_REC) ==
            ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
              (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_pc] :<
                (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (512)))).[e_pstate] :<
                965).[e_regs] :<
                (((((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) #
                  0 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (768)))) #
                  1 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (776)))) #
                  2 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (784)))) #
                  3 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (792)))) #
                  4 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (800)))) #
                  5 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (808)))) #
                  6 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (816)))) #
                  7 ==
                  (((st.(stack)).(smc_rec_create_stack)) @ ((v_rec_params.(poffset)) + (824))))))))));
  rely (
    (((((((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))) /\
      ((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))))) /\
      ((0 = (0)))) /\
      (("slot_rd" = ("slot_rd")))) /\
      ((0 = (0)))) /\
      (("slot_rec" = ("slot_rec")))) /\
      (((((((st'.(share)).(granules)) @ (((st'.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  when ret == ((realm_vtcr_spec' v_rd st'));
  rely (
    ((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) >? (0)) = (true)) /\
      (((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >? (0)) &&
        (((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - ((GRANULES_BASE + (16777216)))) <? (0)))) =
        (true)))) /\
      (((((((((((st'.(share)).(granule_data)) @ (((st'.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) =
        (0)) /\
        (("granules" = ("granules")))))));
  when st'_0 == ((init_common_sysregs_spec_state_oracle st'));
  (Some st'_0))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))).

Fixpoint free_rec_aux_granules_loop176_mid (_N_: nat) (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) (st: RData) : (option (Z * Ptr * bool * Z * RData)) :=
  match (_N_) with
  | O => (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
  | (S _N_) =>
    match ((free_rec_aux_granules_loop176_mid _N_ v_indvars_iv v_rec_aux v_scrub v_wide_trip_count st)) with
    | (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st)) =>
      let v_arrayidx := (ptr_offset v_rec_aux ((8 * (v_indvars_iv)) + (0))) in
      when v_0_tmp, st == ((load_RData 8 v_arrayidx st));
      let v_0 := (int_to_ptr v_0_tmp) in
      when st == ((granule_lock_spec v_0 4 st));
      when st == (
          if v_scrub
          then (
            let v_1 := v_indvars_iv in
            let v_add := (v_1 + (6)) in
            when st == ((granule_memzero_spec v_0 v_add st));
            (Some st))
          else (Some st));
      when st == ((granule_unlock_transition_spec v_0 1 st));
      let v_indvars_iv_next := (v_indvars_iv + (1)) in
      let v_exitcond := (v_indvars_iv_next <>? (v_wide_trip_count)) in
      match (
        let __continue__ := false in
        let __break__ := false in
        if v_exitcond
        then (
          let v_indvars_iv := v_indvars_iv_next in
          let __continue__ := true in
          (Some (__break__, __continue__, v_indvars_iv, st)))
        else (
          let __break__ := true in
          (Some (__break__, __continue__, v_indvars_iv, st)))
      ) with
      | (Some (__break__, __continue__, v_indvars_iv, st)) =>
        if __break__
        then (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
        else (
          if __continue__
          then (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
          else (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st)))
      | None => None
      end
    | None => None
    end
  end.

Definition free_rec_aux_granules_spec_mid (v_rec_aux: Ptr) (v_cnt: Z) (v_scrub: bool) (st: RData) : (option RData) :=
  let v_cmp6 := (0 <? (v_cnt)) in
  when st == (
      if v_cmp6
      then (
        let v_wide_trip_count := v_cnt in
        let v_indvars_iv := 0 in
        rely (((free_rec_aux_granules_loop176_rank v_indvars_iv v_rec_aux v_scrub v_wide_trip_count) >= (0)));
        match (
          (free_rec_aux_granules_loop176_mid
            (z_to_nat (free_rec_aux_granules_loop176_rank v_indvars_iv v_rec_aux v_scrub v_wide_trip_count)) 
            v_indvars_iv 
            v_rec_aux 
            v_scrub 
            v_wide_trip_count 
            st)
        ) with
        | (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st)) => (Some st)
        | None => None
        end)
      else (Some st));
  let __return__ := true in
  (Some st).

