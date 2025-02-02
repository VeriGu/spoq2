Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))).

Parameter memcpy_ns_write_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).

Definition s2tte_create_unassigned_spec_abs (v_0: Z) (st: RData) : (option (abs_PTE_t * RData)) :=
  (Some ((mkabs_PTE_t (mkabs_PA_t (- 1)) 0 v_0 0), st)).

Definition llvm_memset_p0i8_i64_spec (v_0: Ptr) (arg1: Z) (arg2: Z) (arg3: bool) (st: RData) : (option RData) :=
  when st_0 == ((llvm_memset_p0i8_i64_spec_state_oracle v_0 arg1 arg2 arg3 st));
  rely ((((st_0.(share)).(granule_data)) = (((st.(share)).(granule_data)))));
  (Some st_0).

Definition memcpy_ns_write_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : (option (bool * RData)) :=
  rely ((((v_src.(pbase)) = ("granule_data")) /\ (((v_src.(poffset)) >= (0)))));
  (memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st).

Definition memcpy_ns_read_spec (v_dest: Ptr) (v_src: Ptr) (v_conv: Z) (st: RData) : (option (bool * RData)) :=
  rely ((((v_src.(pbase)) = ("granule_data")) /\ (((v_src.(poffset)) >= (0)))));
  (memcpy_ns_read_spec_state_oracle v_dest v_src v_conv st).

Definition monitor_call_spec (id: Z) (arg0: Z) (arg1: Z) (arg2: Z) (arg3: Z) (arg4: Z) (arg5: Z) (st: RData) : (option (Z * RData)) :=
  (monitor_call_state_oracle id arg0 arg1 arg2 arg3 arg4 arg5 st).

Definition sort_granules_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
  (Some st).

Definition __find_lock_next_level_spec_low_abs (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
  when v_4, st_0 == ((s2_addr_to_idx_spec v_1 v_2 st));
  when v_5, st_1 == ((__find_next_level_idx_spec v_0 v_4 st_0));
  if (ptr_eqb v_5 (mkPtr "null" 0))
  then (Some (v_5, st_1))
  else (
    when st_2 == ((granule_lock_spec v_5 5 st_1));
    (Some (v_5, st_2))).

Definition find_lock_granule_spec_abs (v_0: abs_PA_t) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  let v_ptr := (mkPtr "granules" (v_0.(meta_granule_offset))) in
  when ret, st' == ((granule_try_lock_spec v_ptr v_1 st));
  if ret
  then (Some (v_ptr, st'))
  else (Some ((mkPtr "null" 0), st')).

Definition atomic_add_64 (loc: Ptr) (val: Z) (st: RData) : (option RData) :=
  rely (((loc.(pbase)) =s ("granules")));
  rely ((((loc.(poffset)) mod (16)) = (8)));
  when v, st_1 == ((load_RData_granules 64 loc st));
  when st_2 == ((store_RData_granules 64 loc (v + (val)) st_1));
  (Some st_2).

Definition s2tte_is_table_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
  (Some (((v_1 <? (3)) && (((v_0 & (3)) =? (3)))), st)).

Definition granule_unlock_spec (v_0: Ptr) (st: RData) : (option RData) :=
  when st_0 == ((spinlock_release_spec (mkPtr (v_0.(pbase)) (v_0.(poffset))) st));
  (Some st_0).

Definition s2_sl_addr_to_idx_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((Z.lxor ((- 1) << ((v_2 & (4294967295)))) (- 1)) & (v_0)) >> ((39 + (((- 9) * (v_1)))))), st)).

Definition __find_lock_next_level_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
  if (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_desc_type)) =? (3))
  then (
    when st_4 == (
        (granule_lock_spec
          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))
          5
          st));
    (Some (
      (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))  ,
      st_4
    )))
  else (Some ((mkPtr "null" 0), st)).

Definition pack_struct_return_code_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((pack_struct_return_code_para v_0), st)).

Definition make_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((make_return_code_para v_0), st)).

Definition atomic_granule_put_spec (v_0: Ptr) (st: RData) : (option RData) :=
  rely (((v_0.(pbase)) =s ("granules")));
  rely (((((v_0.(poffset)) + (8)) mod (16)) = (8)));
  (Some (st.[share].[globals].[g_granules] :<
    ((((st.(share)).(globals)).(g_granules)) #
      (((v_0.(poffset)) + (8)) / (16)) ==
      (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_ref] :<
        ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
          (((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))).

Definition find_lock_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  None.

Definition s2tte_create_unassigned_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  if (v_0 =? (0))
  then (Some (0, st))
  else (Some (64, st)).

