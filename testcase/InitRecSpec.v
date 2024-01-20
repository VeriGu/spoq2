Parameter gic_cpu_state_init_spec_state_oracle : RData -> (option RData).

Parameter init_rec_regs_spec_state_oracle : RData -> (option RData).

Definition free_rec_aux_granules_loop176_rank (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) : Z :=
  0.

Definition gic_cpu_state_init_spec_shadow (v_gicstate: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\ (((v_gicstate.(poffset)) = (584)))) /\
      (((v_gicstate.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  (Some (st.[share].[granule_data] :<
    (((st.(share)).(granule_data)) #
      (((st.(share)).(slots)) @ SLOT_REC) ==
      ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).[g_rec].[e_sysregs].[e_sysreg_gicstate].[e_ich_hcr_el2] :< 33025)))).

Definition gic_cpu_state_init_spec (v_gicstate: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))) /\ (((v_gicstate.(poffset)) = (584)))) /\
      (((v_gicstate.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  when st' == ((gic_cpu_state_init_spec_state_oracle st));
  (Some st').

Definition init_rec_regs_spec_shadow (v_rec: Ptr) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((((((v_rd.(poffset)) = (0)) /\ ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))))) /\ (((v_rd.(pbase)) = ("slot_rd")))) /\
      (((v_rec_params.(pbase)) = ("smc_rec_create_stack")))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))))) /\
      (((v_rec.(poffset)) = (0)))) /\
      (((v_rec.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
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
  (Some st'_0).

Definition init_rec_regs_spec (v_rec: Ptr) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
  rely (
    (((((((((v_rd.(poffset)) = (0)) /\ ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)) = ((Some CPU_ID))))) /\ (((v_rd.(pbase)) = ("slot_rd")))) /\
      (((v_rec_params.(pbase)) = ("smc_rec_create_stack")))) /\
      ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = ((Some CPU_ID))))) /\
      (((v_rec.(poffset)) = (0)))) /\
      (((v_rec.(pbase)) = ("slot_rec")))) /\
      (((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0)) = (true)))));
  when st' == ((init_rec_sysregs_spec_state_oracle st));
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
  when st'_0' == ((init_rec_regs_spec_state_oracle st'_0));
  (Some st'_0').

Fixpoint free_rec_aux_granules_loop176 (_N_: nat) (v_indvars_iv: Z) (v_rec_aux: Ptr) (v_scrub: bool) (v_wide_trip_count: Z) (st: RData) : (option (Z * Ptr * bool * Z * RData)) :=
  match (_N_) with
  | O => (Some (v_indvars_iv, v_rec_aux, v_scrub, v_wide_trip_count, st))
  | (S _N_) =>
    match ((free_rec_aux_granules_loop176 _N_ v_indvars_iv v_rec_aux v_scrub v_wide_trip_count st)) with
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

Definition free_rec_aux_granules_spec (v_rec_aux: Ptr) (v_cnt: Z) (v_scrub: bool) (st: RData) : (option RData) :=
  let v_cmp6 := (0 <? (v_cnt)) in
  when st == (
      if v_cmp6
      then (
        let v_wide_trip_count := v_cnt in
        let v_indvars_iv := 0 in
        rely (((free_rec_aux_granules_loop176_rank v_indvars_iv v_rec_aux v_scrub v_wide_trip_count) >= (0)));
        match (
          (free_rec_aux_granules_loop176
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

