n (Z * RData)) :=
  if ((v_rec_params_addr & (4095)) =? (0))
  then (
    if ((v_rec_params_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rec_params_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rec_params_addr / (GRANULE_SIZE)) < (1048576)))));
      if (((((st.(share)).(granules)) @ (v_rec_params_addr / (GRANULE_SIZE))).(e_state)) =? (0))
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when v_call5, st_1 == ((memcpy_ns_read_spec_state_oracle (mkPtr "stack_rec_params" 0) (mkPtr "slot_ns" 0) 4096 (lens 169 st)));
        if v_call5
        then (
          if ((((((st_1.(stack)).(stack_rec_params)).(e_rmi_rec_params_4)).(e_union_anon_11_154_0)).(e_num_aux)) >? (16))
          then (Some (1, (lens 69 st_1)))
          else (
            match (
              match (
                match (
                  match (
                    (smc_rec_create_loop222
                      (z_to_nat 0)
                      false
                      0
                      false
                      0
                      (mkPtr "stack_rec_aux_granules" 0)
                      (mkPtr "stack_rec_params" 0)
                      (((((st_1.(stack)).(stack_rec_params)).(e_rmi_rec_params_4)).(e_union_anon_11_154_0)).(e_num_aux))
                      (lens 69 st_1))
                  ) with
                  | (Some (return___2, retval___2, __break__, v_indvars_iv_0, v_rec_aux_granules_0, v_rec_params_0, v_wide_trip_count_0, st_10)) => (Some (return___2, retval___2, st_10))
                  | None => None
                  end
                ) with
                | (Some (return___2, retval___2, st_10)) =>
                  (Some (
                    return___2  ,
                    retval___2  ,
                    (((((st_1.(stack)).(stack_rec_params)).(e_rmi_rec_params_4)).(e_union_anon_11_154_0)).(e_num_aux))  ,
                    (((((st_1.(stack)).(stack_rec_params)).(e_rmi_rec_params_4)).(e_union_anon_11_154_0)).(e_num_aux))  ,
                    st_10
                  ))
                | None => None
                end
              ) with
              | (Some (__return___0, __retval___0, v_3, v_conv_0, st_9)) => (Some (__return___0, __retval___0, v_3, v_conv_0, st_9))
              | None => None
              end
            ) with
            | (Some (__return__, __retval__, v_2, v_conv, st_9)) =>
              if __return__
              then (Some (__retval__, st_9))
              else (
                when v_call18, st_10 == ((find_lock_two_granules_spec v_rec_addr 1 (mkPtr "stack_g0" 0) v_rd_addr 2 (mkPtr "stack_g1" 0) st_9));
                if v_call18
                then (
                  rely (
                    (((((st_10.(stack)).(stack_g0)) > (0)) /\ (((((st_10.(stack)).(stack_g0)) - (GRANULES_BASE)) >= (0)))) /\
                      (((((st_10.(stack)).(stack_g0)) - (18446744073705226240)) < (0)))));
                  rely (((((st_10.(stack)).(stack_g0)) mod (16)) = (0)));
                  rely (
                    (((((st_10.(stack)).(stack_g1)) > (0)) /\ (((((st_10.(stack)).(stack_g1)) - (GRANULES_BASE)) >= (0)))) /\
                      (((((st_10.(stack)).(stack_g1)) - (18446744073705226240)) < (0)))));
                  rely (((((st_10.(stack)).(stack_g1)) mod (16)) = (0)));
                  if ((((((st_10.(share)).(granule_data)) @ (((st_10.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)) =? (0))
                  then (
                    if ((((((st_10.(stack)).(stack_rec_params)).(e_rmi_rec_params_1)).(e_union_anon_7_0)) & (18446742978476114160)) =? (0))
                    then (
                      if (
                        (((((((st_10.(share)).(granule_data)) @ (((st_10.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rec_count)) -
                          ((((((((((st_10.(stack)).(stack_rec_params)).(e_rmi_rec_params_1)).(e_union_anon_7_0)) >> (4)) & (4080)) |'
                            ((((((st_10.(stack)).(stack_rec_params)).(e_rmi_rec_params_1)).(e_union_anon_7_0)) & (15)))) |'
                            (((((((st_10.(stack)).(stack_rec_params)).(e_rmi_rec_params_1)).(e_union_anon_7_0)) >> (4)) & (1044480)))) |'
                            (((((((st_10.(stack)).(stack_rec_params)).(e_rmi_rec_params_1)).(e_union_anon_7_0)) >> (12)) & (267386880)))))) =?
                          (0)))
                      then (
                        rely (((((((((st_10.(share)).(granule_data)) @ (((st_10.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_num_rec_aux)) - (v_conv)) =? (0)) = (false)));
                        (Some (1, (lens 348 st_10))))
                      else (Some (1, (lens 352 st_10))))
                    else (Some (1, (lens 356 st_10))))
                  else (Some (2, (lens 360 st_10))))
                else (Some (1, st_10)))
            | None => None
            end))
        else (Some (1, (lens 69 st_1))))
      else (Some (1, st))))
  else (Some (1, st)).
