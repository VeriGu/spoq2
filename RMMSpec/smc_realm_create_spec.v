Definition smc_realm_create_spec (v_rd_addr: Z) (v_realm_params_addr: Z) (st: RData) : (option (Z * RData)) :=
  if (
    (((v_rd_addr - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)))) >=? (0)) &&
      (((((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)) << (12)) +
        ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)))) +
        ((- 1))) -
        (v_rd_addr)) >=?
        (0)))))
  then (
    rely (
      (((0 - (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)))) <= (0)) /\
        ((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)) < (1024)))));
    (Some (1, ((lens 304 st).[stack].[stack_realm_params] :< rmi_realm_params))))
  else (
    if ((v_rd_addr & (4095)) =? (0))
    then (
      if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
      then (
        rely (
          (((0 - (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)))) <= (0)) /\
            ((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)) < (1024)))));
        (Some (1, ((lens 312 st).[stack].[stack_realm_params] :< rmi_realm_params))))
      else (
        rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
        rely (((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_DELEGATED)) = (0)));
        when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
        if (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) & (4095)) =? (0))
        then (
          if (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)) >? (1048575))
          then (
            rely (
              (((0 - (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)))) <= (0)) /\
                ((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)) < (1024)))));
            (Some (1, ((lens 314 st).[stack].[stack_realm_params] :< rmi_realm_params))))
          else (
            rely (
              (((0 - (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))) <= (0)) /\
                ((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)) < (1048576)))));
            rely (
              ((((((st.(share)).(granules)) @ ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))).(e_state)) -
                (GRANULE_STATE_DELEGATED)) =
                (0)));
            when sh_0 == ((((lens 309 st).(repl)) (((lens 307 st).(oracle)) ((lens 306 st).(log))) ((lens 308 st).(share))));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            if ((((rmi_realm_params.(e_rmi_realm_params_0)).(e_union_anon_7_0)) & (512)) =? (0))
            then (
              if ((((rmi_realm_params.(e_rmi_realm_params_1)).(e_union_anon_0_95_0)) @ 0) =? (1))
              then (
                if ((0 - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)))) <? (0))
                then (
                  match (
                    (smc_realm_create_loop335
                      (z_to_nat 0)
                      false
                      (mkPtr "granules" (16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))))
                      0
                      (mkPtr "stack_realm_params" 2072)
                      ((((lens 727 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                        (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                        rmi_realm_params))
                  ) with
                  | (Some (__break__, v_39, v_indvars_iv_0, v_rtt_num_start_0, st_47)) => (Some (0, st_47))
                  | None => None
                  end)
                else (
                  (Some (
                    0  ,
                    ((((lens 727 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                      (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                      rmi_realm_params)
                  ))))
              else (
                if ((((rmi_realm_params.(e_rmi_realm_params_1)).(e_union_anon_0_95_0)) @ 0) =? (0))
                then (
                  if ((0 - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)))) <? (0))
                  then (
                    match (
                      (smc_realm_create_loop335
                        (z_to_nat 0)
                        false
                        (mkPtr "granules" (16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))))
                        0
                        (mkPtr "stack_realm_params" 2072)
                        ((((lens 831 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                          (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                          rmi_realm_params))
                    ) with
                    | (Some (__break__, v_39, v_indvars_iv_0, v_rtt_num_start_0, st_48)) => (Some (0, st_48))
                    | None => None
                    end)
                  else (
                    (Some (
                      0  ,
                      ((((lens 831 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                        (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                        rmi_realm_params)
                    ))))
                else (
                  if ((0 - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)))) <? (0))
                  then (
                    match (
                      (smc_realm_create_loop335
                        (z_to_nat 0)
                        false
                        (mkPtr "granules" (16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))))
                        0
                        (mkPtr "stack_realm_params" 2072)
                        ((((lens 903 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                          (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                          rmi_realm_params))
                    ) with
                    | (Some (__break__, v_39, v_indvars_iv_0, v_rtt_num_start_0, st_47)) => (Some (0, st_47))
                    | None => None
                    end)
                  else (
                    (Some (
                      0  ,
                      ((((lens 903 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                        (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                        rmi_realm_params)
                    ))))))
            else (
              if ((((rmi_realm_params.(e_rmi_realm_params_1)).(e_union_anon_0_95_0)) @ 0) =? (1))
              then (
                if ((0 - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)))) <? (0))
                then (
                  match (
                    (smc_realm_create_loop335
                      (z_to_nat 0)
                      false
                      (mkPtr "granules" (16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))))
                      0
                      (mkPtr "stack_realm_params" 2072)
                      ((((lens 1071 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                        (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                        rmi_realm_params))
                  ) with
                  | (Some (__break__, v_39, v_indvars_iv_0, v_rtt_num_start_0, st_49)) => (Some (0, st_49))
                  | None => None
                  end)
                else (
                  (Some (
                    0  ,
                    ((((lens 1071 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                      (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                      rmi_realm_params)
                  ))))
              else (
                if ((((rmi_realm_params.(e_rmi_realm_params_1)).(e_union_anon_0_95_0)) @ 0) =? (0))
                then (
                  if ((0 - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)))) <? (0))
                  then (
                    match (
                      (smc_realm_create_loop335
                        (z_to_nat 0)
                        false
                        (mkPtr "granules" (16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))))
                        0
                        (mkPtr "stack_realm_params" 2072)
                        ((((lens 1175 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                          (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                          rmi_realm_params))
                    ) with
                    | (Some (__break__, v_39, v_indvars_iv_0, v_rtt_num_start_0, st_50)) => (Some (0, st_50))
                    | None => None
                    end)
                  else (
                    (Some (
                      0  ,
                      ((((lens 1175 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                        (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                        rmi_realm_params)
                    ))))
                else (
                  if ((0 - ((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)))) <? (0))
                  then (
                    match (
                      (smc_realm_create_loop335
                        (z_to_nat 0)
                        false
                        (mkPtr "granules" (16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE)))))
                        0
                        (mkPtr "stack_realm_params" 2072)
                        ((((lens 1247 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                          (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                          rmi_realm_params))
                    ) with
                    | (Some (__break__, v_39, v_indvars_iv_0, v_rtt_num_start_0, st_49)) => (Some (0, st_49))
                    | None => None
                    end)
                  else (
                    (Some (
                      0  ,
                      ((((lens 1247 st).[stack].[stack_g0] :< (GRANULES_BASE + ((16 * ((v_rd_addr / (GRANULE_SIZE))))))).[stack].[stack_g1] :<
                        (GRANULES_BASE + ((16 * (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) / (GRANULE_SIZE))))))).[stack].[stack_realm_params] :<
                        rmi_realm_params)
                    ))))))))
        else (
          rely (
            (((0 - (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)))) <= (0)) /\
              ((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)) < (1024)))));
          (Some (1, ((lens 1249 st).[stack].[stack_realm_params] :< rmi_realm_params))))))
    else (
      rely (
        (((0 - (((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)))) <= (0)) /\
          ((((((rmi_realm_params.(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) >> (6)) < (1024)))));
      (Some (1, ((lens 1250 st).[stack].[stack_realm_params] :< rmi_realm_params))))).
