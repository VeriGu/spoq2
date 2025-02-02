Definition find_lock_unused_granule_spec_abs (v_0_pa: abs_PA_t) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  when v_3, st_1 == ((find_lock_granule_spec_abs v_0_pa v_1 st));
  if (ptr_eqb v_3 (mkPtr "null" 0))
  then (Some ((mkPtr "null" 0), st_1))
  else (
    let v_8 := (g_refcount_para v_3 st_1) in
    if (v_8 =? (0))
    then (Some (v_3, st_1))
    else (
      when st_2 == ((granule_unlock_spec v_3 st_1));
      (Some ((mkPtr "null" 0), st_2)))).

Definition smc_rec_destroy_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
  if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).(e_state_s_granule)) - (3)) =? (0))
  then (
    if ((g_refcount_para (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1) =? (0))
    then (
      when v_2, st_2 == ((memset_spec (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) 0 4096 st_1));
      rely (((("granules" = ("granules")) /\ (((((test_PA v_0).(meta_granule_offset)) mod (16)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
      when st_3 == (
          (granule_unlock_spec
            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
            (st_2.[share].[globals].[g_granules] :<
              ((((st_2.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (16)) ==
                (((((st_2.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (16))).[e_state_s_granule] :< 1)))));
      rely (
        (((((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(pbase)) = ("granules")) /\
          (((((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) mod (16)) = (0)))) /\
          ((((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) >= (0)))));
      (Some (
        0  ,
        (st_3.[share].[globals].[g_granules] :<
          ((((st_3.(share)).(globals)).(g_granules)) #
            (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16)) ==
            (((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16))).[e_ref] :<
              ((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                (((((((st_3.(share)).(globals)).(g_granules)) @ (((rec_to_rd_para (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset))) st_1).(poffset)) / (16))).(e_ref)).(e_u_anon_3_0)) +
                  ((- 1)))))))
      )))
    else (
      when st_2 == ((granule_unlock_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
  else (
    when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
    (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))).

