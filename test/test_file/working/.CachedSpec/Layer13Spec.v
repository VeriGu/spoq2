Parameter test_Ptr_Z : Ptr -> Z.

Parameter wrap_180_para : Z -> (RData -> Z).

Parameter read_entry_para : abs_PTE_t -> (Z -> (RData -> Z)).

Parameter table_maps_assigned_block_s1_para : Ptr -> (Z -> (RData -> bool)).

Parameter check_ttbr01 : abs_PA_t -> bool.

Parameter load_r_granule_data_abs : Z -> (r_granule_data -> (option Z)).

Definition vmid_free_spec (v_0: Z) (st: RData) : (option RData) :=
  (Some st).

Definition s1tte_is_writable_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_0 & (128)) =? (0)), st)).

Definition stage1_tlbi_va_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
  when st_0 == ((iasm_261_spec (((v_0 >> (12)) & (17592186044415)) + ((v_1 << (48)))) st));
  when st_1 == ((iasm_10_spec st_0));
  when st_2 == ((iasm_12_isb_spec st_1));
  (Some st_2).

Definition stage1_tlbi_val_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
  when st_0 == ((iasm_264_spec (((v_0 >> (12)) & (17592186044415)) + ((v_1 << (48)))) st));
  when st_1 == ((iasm_10_spec st_0));
  when st_2 == ((iasm_12_isb_spec st_1));
  (Some st_2).

Definition handle_pico_rec_exit_spec (v_0: Ptr) (V_1: Ptr) (st: RData) : (option (bool * RData)) :=
  (Some (false, st)).

Definition rcsm_save_pico_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
  (Some st).

Definition rcsm_restore_pico_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
  (Some st).

Definition smc_rec_destroy_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  when st1 == ((query_oracle st));
  rely (((((st1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
  match (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_lock)).(e_val))) with
  | None =>
    if (((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
    then (
      if (
        ((g_refcount_para
          (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
          (st1.[share].[globals].[g_granules] :<
            ((((st1.(share)).(globals)).(g_granules)) #
              (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
              (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))) =?
          (0)))
      then (
        rely (((true /\ (((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)))) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        when st_1 == (
            (spinlock_release_spec
              let (_ptr, _offs) := ((mkPtr "granules" ((test_PA v_0).(meta_granule_offset))), 0) in
              (mkPtr (_ptr.(pbase)) ((_ptr.(poffset)) + (_offs)))
              ((st1.[share].[globals].[g_granules] :<
                ((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  ((((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID)).[e_state_s_granule] :< 1))).[share].[granule_data] :<
                (((st1.(share)).(granule_data)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  ((((st1.(share)).(granule_data)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[g_norm] :< zero_granule_data)))));
        rely (
          (((((rec_to_rd_para
            (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
            (st1.[share].[globals].[g_granules] :<
              ((((st1.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(pbase)) =
            ("granules")) /\
            (((((rec_to_rd_para
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (st1.[share].[globals].[g_granules] :<
                ((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) mod
              (4096)) =
              (0)))) /\
            ((((rec_to_rd_para
              (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
              (st1.[share].[globals].[g_granules] :<
                ((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) >=
              (0)))));
        (Some (
          0  ,
          (st_1.[share].[globals].[g_granules] :<
            ((((st_1.(share)).(globals)).(g_granules)) #
              (((rec_to_rd_para
                (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                (st1.[share].[globals].[g_granules] :<
                  ((((st1.(share)).(globals)).(g_granules)) #
                    (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                    (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                (4096)) ==
              (((((st_1.(share)).(globals)).(g_granules)) @
                (((rec_to_rd_para
                  (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                  (st1.[share].[globals].[g_granules] :<
                    ((((st1.(share)).(globals)).(g_granules)) #
                      (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                      (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                  (4096))).[e_ref] :<
                ((((((st_1.(share)).(globals)).(g_granules)) @
                  (((rec_to_rd_para
                    (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                    (st1.[share].[globals].[g_granules] :<
                      ((((st1.(share)).(globals)).(g_granules)) #
                        (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                        (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                    (4096))).(e_ref)).[e_u_anon_3_0] :<
                  (((((((st_1.(share)).(globals)).(g_granules)) @
                    (((rec_to_rd_para
                      (mkPtr "granule_data" ((test_PA v_0).(meta_granule_offset)))
                      (st1.[share].[globals].[g_granules] :<
                        ((((st1.(share)).(globals)).(g_granules)) #
                          (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                          (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))).(poffset)) /
                      (4096))).(e_ref)).(e_u_anon_3_0)) +
                    ((- 1)))))))
        )))
      else (
        when st_2 == (
            (granule_unlock_spec
              (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
              (st1.[share].[globals].[g_granules] :<
                ((((st1.(share)).(globals)).(g_granules)) #
                  (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                  (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))));
        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2))))
    else (
      when st_2 == (
          (spinlock_release_spec
            (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
            (st1.[share].[globals].[g_granules] :<
              ((((st1.(share)).(globals)).(g_granules)) #
                (((test_PA v_0).(meta_granule_offset)) / (4096)) ==
                (((((st1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).[e_lock].[e_val] :< (Some CPU_ID))))));
      (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_2)))
  | (Some cid) => None
  end.

