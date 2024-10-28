Definition smc_realm_destroy_spec (v_rd_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
      if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
          rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
          rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) = (0)));
          when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
          if ((((((lens 26 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_refcount)) =? (0))
          then (
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              rely (
                  (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) > (0)) /\
                      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))) /\
                     (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (18446744073705226240)) < (0)))));
              rely (
                  (((0 - ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_vmid)) >> (6)))) <= (0)) /\
                     (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_vmid)) >> (6)) < (1024)))));
              if ((0 - (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_num_root_rtts)))) <? (0))
              then (
                  match (
                      (total_root_rtt_refcount_loop348
                         (z_to_nat 0)
                         false
                         (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                         0
                         0
                         0
                         ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_num_root_rtts))
                         (lens 274 st))
                    ) with
                  | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_1)) =>
                      if (v_refcount_0_lcssa_0 =? (0))
                      then (
                          match (
                              (free_sl_rtts_loop193
                                 (z_to_nat 0)
                                 false
                                 (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                                 0
                                 ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_num_root_rtts))
                                 st_1)
                            ) with
                          | (Some (__break___0, v_g_rtt_1, v_indvars_iv_1, v_wide_trip_count_1, st_2)) => (Some (0, (lens 275 st_2)))
                          | None => None
                          end)
                      else (
                          when cid == (((((st_1.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
                          (Some (5, (lens 29 st_1))))
                  | None => None
                  end)
              else (Some (0, (lens 277 st))))
          else (Some (5, (lens 31 st)))))
           else (Some (1, st)).
