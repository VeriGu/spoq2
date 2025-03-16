Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))).

Parameter memcpy_ns_write_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).

Definition granule_unlock_spec (v_0: Ptr) (st: RData) : (option RData) :=
  when st_0 == ((spinlock_release_spec (ptr_offset v_0 0) st));
  (Some st_0).

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

Definition pack_struct_return_code_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
  (Some ((((v_0 >> (24)) & (4294967040)) |' (v_0)), st)).

Definition make_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_1 << (32)) + (v_0)), st)).

Definition atomic_granule_put_spec (v_0: Ptr) (st: RData) : (option RData) :=
  rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
  let (loc, val, st_0) := ((mkPtr (v_0.(pbase)) ((v_0.(poffset)) + (8))), (- 1), st) in
  when v, st_1 == ((load_RData 64 loc st_0));
  when st_2 == ((store_RData 64 loc (v + (val)) st_1));
  let st_0 := st_2 in
  (Some st_0).

Definition find_lock_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - ((MEM0_PHYS + (MEM0_SIZE)))) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - ((MEM1_PHYS + (MEM1_SIZE)))) < (0)))))) /\
      (((v_0 & (4095)) = (0)))));
  when st_1 == ((query_oracle st));
  rely (((((st_1.(share)).(globals)).(g_granules)) = ((((st.(share)).(globals)).(g_granules)))));
  if ((v_0 - (MEM1_PHYS)) >=? (0))
  then (
    if (((GRANULES_BASE + (((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))).(poffset)))) - ((ptr_to_int (mkPtr "null" 0)))) =? (0))
    then (Some ((mkPtr "null" 0), st))
    else (
      when v_6, st_2 == ((granule_try_lock_spec (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))) v_1 st));
      if v_6
      then (Some ((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))), st_2))
      else (Some ((mkPtr "null" 0), st_2))))
  else (
    if (ptr_eqb (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) (mkPtr "null" 0))
    then (Some ((mkPtr "null" 0), st_1))
    else (
      when v_6, st_2 == ((granule_try_lock_spec (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) v_1 st_1));
      if v_6
      then (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), st_2))
      else (Some ((mkPtr "null" 0), st_2)))).

