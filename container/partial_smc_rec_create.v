Definition smc_rec_create_spec_low (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
when v_9, st_2 == ((memcpy_ns_read_spec (mkPtr "stack_s_rec_params" 0) (mkPtr "granule_data" ((test_PA v_3).(meta_granule_offset))) 288 st));
if v_9
then (
  if ((((test_PA v_0).(meta_granule_offset)) - (((test_PA v_1).(meta_granule_offset)))) =? (0))
  then (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_2))
  else (
    when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_2));
    if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
    then (
      when st_3 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_1));
      if (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (2)) =? (0))
      then (
        if (
          ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (408)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (408)) mod (4096))) =?
            (0)))
        then (
          rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)))));
          rely (((((((st_3.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          if ((((((st_3.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_norm)) @ (((test_PA v_1).(meta_granule_offset)) mod (4096))) =? (0))
          then (
            if (vmpidr_is_valid_para v_2)
            then (
              if (
                (((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) -
                  ((vmpidr_to_rec_idx_para v_2))) =?
                  (0)))
              then (
                if ((((st_3.(stack)).(stack_s_rec_params)).(e_is_pico)) =? (0))
                then (
                  when st_19 == (
                      (init_rec_regs_spec
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        v_2
                        (mkPtr "stack_s_rec_params" 0)
                        (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                        (st_3.[share].[granule_data] :<
                          (((((st_3.(share)).(granule_data)) #
                            (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                            ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                              (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) #
                            ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096)) ==
                            (((((st_3.(share)).(granule_data)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                  (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                  (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                              ((((((st_3.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                    (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                (((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)))))) #
                            ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096)) ==
                            ((((((st_3.(share)).(granule_data)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                  (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                  (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) #
                              ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096)) ==
                              (((((st_3.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                    (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                ((((((st_3.(share)).(granule_data)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                      (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                  ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                  (((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096))).[g_norm] :<
                              (((((((st_3.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                    (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) #
                                ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_3.(share)).(granule_data)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                      (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  ((((((st_3.(share)).(granule_data)) #
                                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                    ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                        (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                        (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    (((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096))).(g_norm)) #
                                ((((test_PA v_0).(meta_granule_offset)) + (1520)) mod (4096)) ==
                                (((st_3.(stack)).(stack_s_rec_params)).(e_is_pico))))))));
                  when st_20 == (
                      (store_RData
                        8
                        (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                        (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                        st_19));
                  if (
                    ((((((st_20.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1520)) mod (4096))) =?
                      (0)))
                  then (
                    when v_6, st_5 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_20));
                    rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                    if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                    then (
                      when st_31 == (
                          (store_RData_granule_data
                            1
                            (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16)))
                            ((((st_5.(stack)).(stack_s_rec_params)).(e_flags)) & (1))
                            ((st_5.[share].[globals].[g_granules] :<
                              ((((st_5.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              ((((((st_5.(share)).(granule_data)) #
                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                  (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                    33025))) #
                                ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                (((((st_5.(share)).(granule_data)) #
                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                      33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                  ((((((st_5.(share)).(granule_data)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                        33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                    ((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) #
                                ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096)) ==
                                ((((((st_5.(share)).(granule_data)) #
                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                      33025))) #
                                  ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                  (((((st_5.(share)).(granule_data)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                        33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                    ((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                      ((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).[g_norm] :<
                                  (((((((st_5.(share)).(granule_data)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                        33025))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                    (((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                      ((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).(g_norm)) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (928)) mod (4096)) ==
                                    (((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                      (((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) mod (4096)))))) #
                                ((((test_PA v_0).(meta_granule_offset)) + (936)) / (4096)) ==
                                (((((((st_5.(share)).(granule_data)) #
                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                      33025))) #
                                  ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                  (((((st_5.(share)).(granule_data)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                        33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                    ((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                      ((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) #
                                  ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096)) ==
                                  ((((((st_5.(share)).(granule_data)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                        33025))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                    (((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                      ((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).[g_norm] :<
                                    (((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                      (((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).(g_norm)) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (928)) mod (4096)) ==
                                      (((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                        (((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                            ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                            ((((((st_5.(share)).(granule_data)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                              ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                  33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (936)) / (4096))).[g_norm] :<
                                  ((((((((st_5.(share)).(granule_data)) #
                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                        33025))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                    (((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                      ((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096)) ==
                                    ((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                      (((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).[g_norm] :<
                                      (((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                        (((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                            ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                            ((((((st_5.(share)).(granule_data)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                              ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                  33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).(g_norm)) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (928)) mod (4096)) ==
                                        (((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                          (((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                            ((((((st_5.(share)).(granule_data)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                              ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                  33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                              ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                              ((((((st_5.(share)).(granule_data)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                                ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                  (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                    33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (936)) / (4096))).(g_norm)) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (936)) mod (4096)) ==
                                    ((((((((st_5.(share)).(granule_data)) #
                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                      ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                        (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                          33025))) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                      (((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                        ((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) #
                                      ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096)) ==
                                      ((((((st_5.(share)).(granule_data)) #
                                        (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                        ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                          (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                            33025))) #
                                        ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                        (((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                          ((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                            ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                            ((((((st_5.(share)).(granule_data)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                              ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                  33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).[g_norm] :<
                                        (((((((st_5.(share)).(granule_data)) #
                                          (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                          ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                            (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                              33025))) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                          (((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                            ((((((st_5.(share)).(granule_data)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                              ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                  33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                              ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                              ((((((st_5.(share)).(granule_data)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                                ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                  (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                    33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (928)) / (4096))).(g_norm)) #
                                          ((((test_PA v_0).(meta_granule_offset)) + (928)) mod (4096)) ==
                                          (((((((st_5.(share)).(granule_data)) #
                                            (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                            ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                              (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                33025))) #
                                            ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096)) ==
                                            (((((st_5.(share)).(granule_data)) #
                                              (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                              ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                  33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).[g_norm] :<
                                              ((((((st_5.(share)).(granule_data)) #
                                                (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                                ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                  (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                    (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                    33025))) @ ((((test_PA v_0).(meta_granule_offset)) + (920)) / (4096))).(g_norm)) #
                                                ((((test_PA v_0).(meta_granule_offset)) + (920)) mod (4096)) ==
                                                ((((((st_5.(share)).(granule_data)) #
                                                  (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096)) ==
                                                  ((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).[g_norm] :<
                                                    (((((st_5.(share)).(granule_data)) @ (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) / (4096))).(g_norm)) #
                                                      (((((test_PA v_0).(meta_granule_offset)) + (584)) + (72)) mod (4096)) ==
                                                      33025))) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (48)) mod (4096)))))) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (56)) mod (4096)))))) @ ((((test_PA v_1).(meta_granule_offset)) + (64)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (64)) mod (4096)))))))));
                      rely (((((((st_31.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                      when st_33 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                            (st_31.[share].[granule_data] :<
                              (((st_31.(share)).(granule_data)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                ((((st_31.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  (((((st_31.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) +
                                      (1))))))));
                      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                            (st_33.[share].[globals].[g_granules] :<
                              ((((st_33.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                (((((st_33.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                      (Some (v_0, st_7)))
                    else None)
                  else (
                    rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                    if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                    then (
                      when v_111, st_23 == (
                          (load_RData_s_rec_params_256
                            8
                            (mkPtr "stack_s_rec_params" 256)
                            (st_20.[share].[globals].[g_granules] :<
                              ((((st_20.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_20.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_20.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_20.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      when st_24 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_23));
                      rely (((((((st_24.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                      when st_26 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                            (st_24.[share].[granule_data] :<
                              (((st_24.(share)).(granule_data)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                ((((st_24.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  (((((st_24.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) +
                                      (1))))))));
                      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                      when st_5 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                            (st_26.[share].[globals].[g_granules] :<
                              ((((st_26.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                (((((st_26.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                      (Some (v_0, st_5)))
                    else None))
                else (
                  when v_65, st_19 == (
                      (load_RData_s_rec_params_272
                        8
                        (mkPtr "stack_s_rec_params" 272)
                        (st_3.[share].[granule_data] :<
                          (((((st_3.(share)).(granule_data)) #
                            (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                            ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                              (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) #
                            ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096)) ==
                            (((((st_3.(share)).(granule_data)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                  (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                  (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                              ((((((st_3.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                    (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                (((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)))))) #
                            ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096)) ==
                            ((((((st_3.(share)).(granule_data)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                  (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                  (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) #
                              ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096)) ==
                              (((((st_3.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                    (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                ((((((st_3.(share)).(granule_data)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                      (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                  ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                  (((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096))).[g_norm] :<
                              (((((((st_3.(share)).(granule_data)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                  (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                    (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) #
                                ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_3.(share)).(granule_data)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                    (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                      (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  ((((((st_3.(share)).(granule_data)) #
                                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                    ((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :<
                                      (((((st_3.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(g_norm)) #
                                        (((test_PA v_0).(meta_granule_offset)) mod (4096)) ==
                                        (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))))) @ ((((test_PA v_0).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_0).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    (((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)))))) @ ((((test_PA v_0).(meta_granule_offset)) + (1520)) / (4096))).(g_norm)) #
                                ((((test_PA v_0).(meta_granule_offset)) + (1520)) mod (4096)) ==
                                (((st_3.(stack)).(stack_s_rec_params)).(e_is_pico))))))));
                  when st_5 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_19));
                  if (((((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
                  then (
                    when st_23 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA v_65).(meta_granule_offset))) 1 st_5));
                    rely (((("granules" = ("granules")) /\ (((((test_PA v_65).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_65).(meta_granule_offset)) >= (0)))));
                    when st_6 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_65).(meta_granule_offset)))
                          (st_23.[share].[globals].[g_granules] :<
                            ((((st_23.(share)).(globals)).(g_granules)) #
                              (((test_PA v_65).(meta_granule_offset)) / (4096)) ==
                              (((((st_23.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5)))));
                    when st_25 == (
                        (store_RData
                          8
                          (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1544)))
                          (test_Ptr_Z (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))))
                          st_6));
                    when st_27 == (
                        (init_rec_regs_spec
                          (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                          v_2
                          (mkPtr "stack_s_rec_params" 0)
                          (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                          st_25));
                    when st_28 == (
                        (store_RData
                          8
                          (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                          (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                          st_27));
                    when v_89, st_29 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_28));
                    if (v_89 =? (0))
                    then (
                      when v_6, st_7 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_29));
                      when st_9 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_7));
                      when v_96, st_31 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_9));
                      when st_32 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_31));
                      when v_100, st_33 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_32));
                      when st_34 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_33));
                      when v_105, st_35 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_34));
                      when st_36 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_35));
                      rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                      if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                      then (
                        when v_111, st_38 == (
                            (load_RData_s_rec_params_256
                              8
                              (mkPtr "stack_s_rec_params" 256)
                              (st_36.[share].[globals].[g_granules] :<
                                ((((st_36.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  (((((st_36.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_36.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_36.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                        when st_39 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_38));
                        rely (((((((st_39.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                        when st_41 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                              (st_39.[share].[granule_data] :<
                                (((st_39.(share)).(granule_data)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  ((((st_39.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                    (((((st_39.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                      ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                      ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) +
                                        (1))))))));
                        rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                        when st_10 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                              (st_41.[share].[globals].[g_granules] :<
                                ((((st_41.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  (((((st_41.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                        (Some (v_0, st_10)))
                      else None)
                    else (
                      rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                      if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                      then (
                        when v_111, st_31 == (
                            (load_RData_s_rec_params_256
                              8
                              (mkPtr "stack_s_rec_params" 256)
                              (st_29.[share].[globals].[g_granules] :<
                                ((((st_29.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  (((((st_29.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_29.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_29.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                        when st_32 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_31));
                        rely (((((((st_32.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                        when st_34 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                              (st_32.[share].[granule_data] :<
                                (((st_32.(share)).(granule_data)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  ((((st_32.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                    (((((st_32.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                      ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                      ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) +
                                        (1))))))));
                        rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                        when st_7 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                              (st_34.[share].[globals].[g_granules] :<
                                ((((st_34.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  (((((st_34.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                        (Some (v_0, st_7)))
                      else None))
                  else (
                    when st_6 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_5));
                    when st_7 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_6));
                    if (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
                    then (
                      when st_23 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_7));
                      when st_24 == (
                          (store_RData
                            8
                            (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1544)))
                            (test_Ptr_Z (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))))
                            st_23));
                      when st_26 == (
                          (init_rec_regs_spec
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            v_2
                            (mkPtr "stack_s_rec_params" 0)
                            (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                            st_24));
                      when st_27 == (
                          (store_RData
                            8
                            (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                            (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                            st_26));
                      when v_89, st_28 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_27));
                      if (v_89 =? (0))
                      then (
                        when v_6, st_9 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_28));
                        when st_10 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_9));
                        when v_96, st_30 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_10));
                        when st_31 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_30));
                        when v_100, st_32 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_31));
                        when st_33 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_32));
                        when v_105, st_34 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_33));
                        when st_35 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_34));
                        rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                        if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                        then (
                          when v_111, st_37 == (
                              (load_RData_s_rec_params_256
                                8
                                (mkPtr "stack_s_rec_params" 256)
                                (st_35.[share].[globals].[g_granules] :<
                                  ((((st_35.(share)).(globals)).(g_granules)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    (((((st_35.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_35.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_35.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                          when st_38 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_37));
                          rely (((((((st_38.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                          when st_40 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                                (st_38.[share].[granule_data] :<
                                  (((st_38.(share)).(granule_data)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    ((((st_38.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                      (((((st_38.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                        ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                        ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) +
                                          (1))))))));
                          rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                          when st_12 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                                (st_40.[share].[globals].[g_granules] :<
                                  ((((st_40.(share)).(globals)).(g_granules)) #
                                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                    (((((st_40.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                          (Some (v_0, st_12)))
                        else None)
                      else (
                        rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                        if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                        then (
                          when v_111, st_30 == (
                              (load_RData_s_rec_params_256
                                8
                                (mkPtr "stack_s_rec_params" 256)
                                (st_28.[share].[globals].[g_granules] :<
                                  ((((st_28.(share)).(globals)).(g_granules)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    (((((st_28.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_28.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_28.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                          when st_31 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_30));
                          rely (((((((st_31.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                          when st_33 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                                (st_31.[share].[granule_data] :<
                                  (((st_31.(share)).(granule_data)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    ((((st_31.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                      (((((st_31.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                        ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                        ((((((st_3.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096))) +
                                          (1))))))));
                          rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                          when st_9 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                                (st_33.[share].[globals].[g_granules] :<
                                  ((((st_33.(share)).(globals)).(g_granules)) #
                                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                    (((((st_33.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                          (Some (v_0, st_9)))
                        else None))
                    else (
                      when st_9 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_7));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9))))))
              else (
                when st_15 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_3));
                rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                when st_5 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                      (st_15.[share].[globals].[g_granules] :<
                        ((((st_15.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                          (((((st_15.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
            else (
              when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_3));
              rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_14.[share].[globals].[g_granules] :<
                      ((((st_14.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                        (((((st_14.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
              (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
          else (
            when st_11 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_3));
            rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
            when st_4 == (
                (granule_unlock_spec
                  (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                  (st_11.[share].[globals].[g_granules] :<
                    ((((st_11.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      (((((st_11.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
            (Some ((pack_struct_return_code_para (make_return_code_para 5)), st_4))))
        else (
          rely (((((((st_3.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          rely (((("granule_data" = ("granule_data")) /\ ((((test_PA v_1).(meta_granule_offset)) >= (0)))) /\ (((((test_PA v_1).(meta_granule_offset)) mod (4096)) = (0)))));
          when v_5, st_4 == ((load_RData_granule_data 64 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (8))) st_3));
          when v_46, st_10 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (408))) st_4));
          if (v_46 =? (0))
          then (
            if (vmpidr_is_valid_para v_2)
            then (
              if ((v_5 - ((vmpidr_to_rec_idx_para v_2))) =? (0))
              then (
                when st_14 == (
                    (store_RData_granule_data
                      8
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))
                      st_10));
                when st_15 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (8))) v_5 st_14));
                when v_60, st_16 == ((load_RData_s_rec_params_264 8 (mkPtr "stack_s_rec_params" 264) st_15));
                when st_17 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) v_60 st_16));
                if (v_60 =? (0))
                then (
                  when st_18 == (
                      (init_rec_regs_spec
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        v_2
                        (mkPtr "stack_s_rec_params" 0)
                        (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                        st_17));
                  when st_19 == (
                      (store_RData
                        8
                        (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                        (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                        st_18));
                  when v_89, st_20 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_19));
                  if (v_89 =? (0))
                  then (
                    when v_6, st_5 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_20));
                    when st_6 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_5));
                    when v_96, st_22 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_6));
                    when st_23 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_22));
                    when v_100, st_24 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_23));
                    when st_25 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_24));
                    when v_105, st_26 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_25));
                    when st_27 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_26));
                    rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                    if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                    then (
                      when v_111, st_29 == (
                          (load_RData_s_rec_params_256
                            8
                            (mkPtr "stack_s_rec_params" 256)
                            (st_27.[share].[globals].[g_granules] :<
                              ((((st_27.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_27.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_27.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_27.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      when st_30 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_29));
                      rely (((((((st_30.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                      when st_32 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                            (st_30.[share].[granule_data] :<
                              (((st_30.(share)).(granule_data)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                ((((st_30.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  (((((st_30.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    (v_5 + (1))))))));
                      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                            (st_32.[share].[globals].[g_granules] :<
                              ((((st_32.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                (((((st_32.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                      (Some (v_0, st_7)))
                    else None)
                  else (
                    rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                    if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                    then (
                      when v_111, st_22 == (
                          (load_RData_s_rec_params_256
                            8
                            (mkPtr "stack_s_rec_params" 256)
                            (st_20.[share].[globals].[g_granules] :<
                              ((((st_20.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_20.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_20.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_20.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      when st_23 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_22));
                      rely (((((((st_23.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                      when st_25 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                            (st_23.[share].[granule_data] :<
                              (((st_23.(share)).(granule_data)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                ((((st_23.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  (((((st_23.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    (v_5 + (1))))))));
                      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                      when st_5 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                            (st_25.[share].[globals].[g_granules] :<
                              ((((st_25.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                (((((st_25.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                      (Some (v_0, st_5)))
                    else None))
                else (
                  when v_65, st_18 == ((load_RData_s_rec_params_272 8 (mkPtr "stack_s_rec_params" 272) st_17));
                  when st_5 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_18));
                  if (((((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
                  then (
                    when st_22 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA v_65).(meta_granule_offset))) 1 st_5));
                    rely (((("granules" = ("granules")) /\ (((((test_PA v_65).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_65).(meta_granule_offset)) >= (0)))));
                    when st_6 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_65).(meta_granule_offset)))
                          (st_22.[share].[globals].[g_granules] :<
                            ((((st_22.(share)).(globals)).(g_granules)) #
                              (((test_PA v_65).(meta_granule_offset)) / (4096)) ==
                              (((((st_22.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5)))));
                    when st_24 == (
                        (store_RData
                          8
                          (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1544)))
                          (test_Ptr_Z (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))))
                          st_6));
                    when st_26 == (
                        (init_rec_regs_spec
                          (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                          v_2
                          (mkPtr "stack_s_rec_params" 0)
                          (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                          st_24));
                    when st_27 == (
                        (store_RData
                          8
                          (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                          (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                          st_26));
                    when v_89, st_28 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_27));
                    if (v_89 =? (0))
                    then (
                      when v_6, st_7 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_28));
                      when st_9 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_7));
                      when v_96, st_30 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_9));
                      when st_31 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_30));
                      when v_100, st_32 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_31));
                      when st_33 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_32));
                      when v_105, st_34 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_33));
                      when st_35 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_34));
                      rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                      if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                      then (
                        when v_111, st_37 == (
                            (load_RData_s_rec_params_256
                              8
                              (mkPtr "stack_s_rec_params" 256)
                              (st_35.[share].[globals].[g_granules] :<
                                ((((st_35.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  (((((st_35.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_35.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_35.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                        when st_38 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_37));
                        rely (((((((st_38.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                        when st_40 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                              (st_38.[share].[granule_data] :<
                                (((st_38.(share)).(granule_data)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  ((((st_38.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                    (((((st_38.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                      ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                      (v_5 + (1))))))));
                        rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                        when st_11 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                              (st_40.[share].[globals].[g_granules] :<
                                ((((st_40.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  (((((st_40.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                        (Some (v_0, st_11)))
                      else None)
                    else (
                      rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                      if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                      then (
                        when v_111, st_30 == (
                            (load_RData_s_rec_params_256
                              8
                              (mkPtr "stack_s_rec_params" 256)
                              (st_28.[share].[globals].[g_granules] :<
                                ((((st_28.(share)).(globals)).(g_granules)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  (((((st_28.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_28.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_28.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                        when st_31 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_30));
                        rely (((((((st_31.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                        when st_33 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                              (st_31.[share].[granule_data] :<
                                (((st_31.(share)).(granule_data)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                  ((((st_31.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                    (((((st_31.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                      ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                      (v_5 + (1))))))));
                        rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                        when st_7 == (
                            (granule_unlock_spec
                              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                              (st_33.[share].[globals].[g_granules] :<
                                ((((st_33.(share)).(globals)).(g_granules)) #
                                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                  (((((st_33.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                        (Some (v_0, st_7)))
                      else None))
                  else (
                    when st_6 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_5));
                    when st_7 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_6));
                    if (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
                    then (
                      when st_22 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_7));
                      when st_23 == (
                          (store_RData
                            8
                            (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1544)))
                            (test_Ptr_Z (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))))
                            st_22));
                      when st_25 == (
                          (init_rec_regs_spec
                            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                            v_2
                            (mkPtr "stack_s_rec_params" 0)
                            (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                            st_23));
                      when st_26 == (
                          (store_RData
                            8
                            (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                            (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                            st_25));
                      when v_89, st_27 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_26));
                      if (v_89 =? (0))
                      then (
                        when v_6, st_9 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_27));
                        when st_11 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_9));
                        when v_96, st_29 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_11));
                        when st_30 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_29));
                        when v_100, st_31 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_30));
                        when st_32 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_31));
                        when v_105, st_33 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_32));
                        when st_34 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_33));
                        rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                        if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                        then (
                          when v_111, st_36 == (
                              (load_RData_s_rec_params_256
                                8
                                (mkPtr "stack_s_rec_params" 256)
                                (st_34.[share].[globals].[g_granules] :<
                                  ((((st_34.(share)).(globals)).(g_granules)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    (((((st_34.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_34.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_34.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                          when st_37 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_36));
                          rely (((((((st_37.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                          when st_39 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                                (st_37.[share].[granule_data] :<
                                  (((st_37.(share)).(granule_data)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    ((((st_37.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                      (((((st_37.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                        ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                        (v_5 + (1))))))));
                          rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                          when st_12 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                                (st_39.[share].[globals].[g_granules] :<
                                  ((((st_39.(share)).(globals)).(g_granules)) #
                                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                    (((((st_39.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                          (Some (v_0, st_12)))
                        else None)
                      else (
                        rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                        if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                        then (
                          when v_111, st_29 == (
                              (load_RData_s_rec_params_256
                                8
                                (mkPtr "stack_s_rec_params" 256)
                                (st_27.[share].[globals].[g_granules] :<
                                  ((((st_27.(share)).(globals)).(g_granules)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    (((((st_27.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_27.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_27.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                          when st_30 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_29));
                          rely (((((((st_30.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                          when st_32 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                                (st_30.[share].[granule_data] :<
                                  (((st_30.(share)).(granule_data)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                    ((((st_30.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                      (((((st_30.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                        ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                        (v_5 + (1))))))));
                          rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                          when st_9 == (
                              (granule_unlock_spec
                                (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                                (st_32.[share].[globals].[g_granules] :<
                                  ((((st_32.(share)).(globals)).(g_granules)) #
                                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                    (((((st_32.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                          (Some (v_0, st_9)))
                        else None))
                    else (
                      when st_9 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_7));
                      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9))))))
              else (
                when st_14 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_10));
                rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                when st_5 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                      (st_14.[share].[globals].[g_granules] :<
                        ((((st_14.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                          (((((st_14.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
                (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
            else (
              when st_13 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_10));
              rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_13.[share].[globals].[g_granules] :<
                      ((((st_13.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                        (((((st_13.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 1)))));
              (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_5))))
          else (
            when st_11 == (
                (store_RData_granule_data
                  8
                  (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                  (test_Ptr_Z (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))))
                  st_10));
            when st_12 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (8))) v_5 st_11));
            when v_60, st_13 == ((load_RData_s_rec_params_264 8 (mkPtr "stack_s_rec_params" 264) st_12));
            when st_14 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) v_60 st_13));
            if (v_60 =? (0))
            then (
              when st_16 == (
                  (init_rec_regs_spec
                    (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                    v_2
                    (mkPtr "stack_s_rec_params" 0)
                    (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                    st_14));
              when st_17 == (
                  (store_RData
                    8
                    (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                    (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                    st_16));
              when v_89, st_18 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_17));
              if (v_89 =? (0))
              then (
                when v_6, st_5 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_18));
                when st_6 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_5));
                when v_96, st_20 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_6));
                when st_21 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_20));
                when v_100, st_22 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_21));
                when st_23 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_22));
                when v_105, st_24 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_23));
                when st_25 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_24));
                rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                then (
                  when v_111, st_27 == (
                      (load_RData_s_rec_params_256
                        8
                        (mkPtr "stack_s_rec_params" 256)
                        (st_25.[share].[globals].[g_granules] :<
                          ((((st_25.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                            (((((st_25.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_25.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_25.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                  when st_28 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_27));
                  rely (((((((st_28.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                  when st_30 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                        (st_28.[share].[granule_data] :<
                          (((st_28.(share)).(granule_data)) #
                            ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                            ((((st_28.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                              (((((st_28.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                (v_5 + (1))))))));
                  rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                  when st_7 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                        (st_30.[share].[globals].[g_granules] :<
                          ((((st_30.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                            (((((st_30.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                  (Some (v_0, st_7)))
                else None)
              else (
                rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                then (
                  when v_111, st_20 == (
                      (load_RData_s_rec_params_256
                        8
                        (mkPtr "stack_s_rec_params" 256)
                        (st_18.[share].[globals].[g_granules] :<
                          ((((st_18.(share)).(globals)).(g_granules)) #
                            ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                            (((((st_18.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_18.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_18.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                  when st_21 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_20));
                  rely (((((((st_21.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                  when st_23 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                        (st_21.[share].[granule_data] :<
                          (((st_21.(share)).(granule_data)) #
                            ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                            ((((st_21.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                              (((((st_21.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                (v_5 + (1))))))));
                  rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                  when st_5 == (
                      (granule_unlock_spec
                        (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                        (st_23.[share].[globals].[g_granules] :<
                          ((((st_23.(share)).(globals)).(g_granules)) #
                            (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                            (((((st_23.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                  (Some (v_0, st_5)))
                else None))
            else (
              when v_65, st_15 == ((load_RData_s_rec_params_272 8 (mkPtr "stack_s_rec_params" 272) st_14));
              when st_5 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_15));
              if (((((((st_5.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (1)) =? (0))
              then (
                when st_19 == ((s2tt_init_unassigned_spec (mkPtr "granule_data" ((test_PA v_65).(meta_granule_offset))) 1 st_5));
                rely (((("granules" = ("granules")) /\ (((((test_PA v_65).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_65).(meta_granule_offset)) >= (0)))));
                when st_6 == (
                    (granule_unlock_spec
                      (mkPtr "granules" ((test_PA v_65).(meta_granule_offset)))
                      (st_19.[share].[globals].[g_granules] :<
                        ((((st_19.(share)).(globals)).(g_granules)) #
                          (((test_PA v_65).(meta_granule_offset)) / (4096)) ==
                          (((((st_19.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 5)))));
                when st_21 == (
                    (store_RData
                      8
                      (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1544)))
                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))))
                      st_6));
                when st_23 == (
                    (init_rec_regs_spec
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      v_2
                      (mkPtr "stack_s_rec_params" 0)
                      (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                      st_21));
                when st_24 == (
                    (store_RData
                      8
                      (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                      (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                      st_23));
                when v_89, st_25 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_24));
                if (v_89 =? (0))
                then (
                  when v_6, st_7 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_25));
                  when st_9 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_7));
                  when v_96, st_27 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_9));
                  when st_28 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_27));
                  when v_100, st_29 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_28));
                  when st_30 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_29));
                  when v_105, st_31 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_30));
                  when st_32 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_31));
                  rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                  if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                  then (
                    when v_111, st_34 == (
                        (load_RData_s_rec_params_256
                          8
                          (mkPtr "stack_s_rec_params" 256)
                          (st_32.[share].[globals].[g_granules] :<
                            ((((st_32.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                              (((((st_32.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_32.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_32.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                    when st_35 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_34));
                    rely (((((((st_35.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                    when st_37 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                          (st_35.[share].[granule_data] :<
                            (((st_35.(share)).(granule_data)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                              ((((st_35.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                (((((st_35.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                  (v_5 + (1))))))));
                    rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                    when st_16 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                          (st_37.[share].[globals].[g_granules] :<
                            ((((st_37.(share)).(globals)).(g_granules)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              (((((st_37.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                    (Some (v_0, st_16)))
                  else None)
                else (
                  rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                  if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                  then (
                    when v_111, st_27 == (
                        (load_RData_s_rec_params_256
                          8
                          (mkPtr "stack_s_rec_params" 256)
                          (st_25.[share].[globals].[g_granules] :<
                            ((((st_25.(share)).(globals)).(g_granules)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                              (((((st_25.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_25.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_25.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                    when st_28 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_27));
                    rely (((((((st_28.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                    when st_30 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                          (st_28.[share].[granule_data] :<
                            (((st_28.(share)).(granule_data)) #
                              ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                              ((((st_28.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                (((((st_28.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                  ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                  (v_5 + (1))))))));
                    rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                    when st_7 == (
                        (granule_unlock_spec
                          (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                          (st_30.[share].[globals].[g_granules] :<
                            ((((st_30.(share)).(globals)).(g_granules)) #
                              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                              (((((st_30.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                    (Some (v_0, st_7)))
                  else None))
              else (
                when st_6 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_5));
                when st_7 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_6));
                if (((((((st_7.(share)).(globals)).(g_granules)) @ (((test_PA v_65).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
                then (
                  when st_19 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_7));
                  when st_20 == (
                      (store_RData
                        8
                        (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1544)))
                        (test_Ptr_Z (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))))
                        st_19));
                  when st_22 == (
                      (init_rec_regs_spec
                        (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                        v_2
                        (mkPtr "stack_s_rec_params" 0)
                        (mkPtr "granule_data" ((test_PA v_1).(meta_granule_offset)))
                        st_20));
                  when st_23 == (
                      (store_RData
                        8
                        (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (944)))
                        (test_Ptr_Z (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))))
                        st_22));
                  when v_89, st_24 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (1520))) st_23));
                  if (v_89 =? (0))
                  then (
                    when v_6, st_9 == ((memset_spec (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (584))) 0 216 st_24));
                    when st_16 == ((store_RData_granule_data 8 (mkPtr "granule_data" ((((test_PA v_0).(meta_granule_offset)) + (584)) + (72))) 33025 st_9));
                    when v_96, st_26 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (48))) st_16));
                    when st_27 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (920))) v_96 st_26));
                    when v_100, st_28 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (56))) st_27));
                    when st_29 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (928))) v_100 st_28));
                    when v_105, st_30 == ((load_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_1).(meta_granule_offset)) + (64))) st_29));
                    when st_31 == ((store_RData_granule_data 8 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (936))) v_105 st_30));
                    rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                    if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                    then (
                      when v_111, st_33 == (
                          (load_RData_s_rec_params_256
                            8
                            (mkPtr "stack_s_rec_params" 256)
                            (st_31.[share].[globals].[g_granules] :<
                              ((((st_31.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_31.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_31.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_31.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      when st_34 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_33));
                      rely (((((((st_34.(share)).(granule_data)) @ (((test_PA v_1).(meta_granule_offset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
                      when st_36 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                            (st_34.[share].[granule_data] :<
                              (((st_34.(share)).(granule_data)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                ((((st_34.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  (((((st_34.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    (v_5 + (1))))))));
                      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                      when st_17 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                            (st_36.[share].[globals].[g_granules] :<
                              ((((st_36.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                (((((st_36.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                      (Some (v_0, st_17)))
                    else None)
                  else (
                    rely ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (16)) = (8)));
                    if ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) >=? (8)) && ((((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) <? (16))))
                    then (
                      when v_111, st_26 == (
                          (load_RData_s_rec_params_256
                            8
                            (mkPtr "stack_s_rec_params" 256)
                            (st_24.[share].[globals].[g_granules] :<
                              ((((st_24.(share)).(globals)).(g_granules)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                (((((st_24.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_24.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_24.(share)).(globals)).(g_granules)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      when st_27 == ((store_RData_granule_data 1 (mkPtr "granule_data" (((test_PA v_0).(meta_granule_offset)) + (16))) (v_111 & (1)) st_26));
                      when st_29 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_1).(meta_granule_offset)))
                            (st_27.[share].[granule_data] :<
                              (((st_27.(share)).(granule_data)) #
                                ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096)) ==
                                ((((st_27.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).[g_norm] :<
                                  (((((st_27.(share)).(granule_data)) @ ((((test_PA v_1).(meta_granule_offset)) + (8)) / (4096))).(g_norm)) #
                                    ((((test_PA v_1).(meta_granule_offset)) + (8)) mod (4096)) ==
                                    (v_5 + (1))))))));
                      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
                      when st_9 == (
                          (granule_unlock_spec
                            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                            (st_29.[share].[globals].[g_granules] :<
                              ((((st_29.(share)).(globals)).(g_granules)) #
                                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                                (((((st_29.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_state_s_granule] :< 3)))));
                      (Some (v_0, st_9)))
                    else None))
                else (
                  when st_9 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_65).(meta_granule_offset))) st_7));
                  (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_9))))))))
      else (
        when st_4 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_1).(meta_granule_offset))) st_3));
        when st_5 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_4));
        (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_5))))
    else (
      when st_3 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 3)), st_3)))))
else (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))