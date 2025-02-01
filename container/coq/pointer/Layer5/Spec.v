Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter llvm_memset_p0i8_i64_spec_state_oracle : Ptr -> (Z -> (Z -> (bool -> (RData -> (option RData))))).

Parameter memcpy_ns_write_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter memcpy_ns_read_spec_state_oracle : Ptr -> (Ptr -> (Z -> (RData -> (option (bool * RData))))).

Parameter monitor_call_state_oracle : Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (Z -> (RData -> (option (Z * RData))))))))).

Section Layer5_Spec.

  Context `{int_ptr: IntPtrCast}.

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
    when st_0 == (
        if ((v_0.(pbase)) =s ("granules"))
        then (
          when cid == (((((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).(e_lock)).(e_val)));
          (Some ((st.[log] :< ((EVT CPU_ID (REL ((v_0.(poffset)) / (16)) ((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))))) :: ((st.(log))))).[share].[globals].[g_granules] :<
            ((((st.(share)).(globals)).(g_granules)) #
              ((v_0.(poffset)) / (16)) ==
              (((((st.(share)).(globals)).(g_granules)) @ ((v_0.(poffset)) / (16))).[e_lock].[e_val] :< None)))))
        else (
          if ((v_0.(pbase)) =s ("vmid_lock"))
          then (
            when cid == (
                if ((v_0.(poffset)) =? (0))
                then ((((st.(share)).(globals)).(g_vmid_lock)).(e_val))
                else None);
            (Some ((st.[log] :< ((EVT CPU_ID (REL vmid_lock_idx vmid_lock_g)) :: ((st.(log))))).[share].[globals].[g_vmid_lock].[e_val] :< None)))
          else None));
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

  Definition atomic_granule_get_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == (
        rely (((v_0.(pbase)) =s ("granules")));
        rely (((((v_0.(poffset)) + (8)) mod (16)) = (8)));
        when v, st_1 == (
            when ret == (
                if (((((v_0.(poffset)) + (8)) mod (16)) >=? (0)) && (((((v_0.(poffset)) + (8)) mod (16)) <? (4))))
                then (
                  if ((((v_0.(poffset)) + (8)) mod (16)) =? (0))
                  then ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_lock)).(e_val))
                  else None)
                else (
                  if ((((v_0.(poffset)) + (8)) mod (16)) =? (4))
                  then (Some (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_state_s_granule)))
                  else (
                    if (((((v_0.(poffset)) + (8)) mod (16)) >=? (8)) && (((((v_0.(poffset)) + (8)) mod (16)) <? (16))))
                    then (
                      if (((((v_0.(poffset)) + (8)) mod (16)) - (8)) =? (0))
                      then (Some ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)))
                      else None)
                    else None)));
            (Some (ret, st)));
        when st_2 == (
            when ret == (
                if (((((v_0.(poffset)) + (8)) mod (16)) >=? (0)) && (((((v_0.(poffset)) + (8)) mod (16)) <? (4))))
                then (
                  when ret == (
                      if ((((v_0.(poffset)) + (8)) mod (16)) =? (0))
                      then (Some ((((((st_1.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_lock)).[e_val] :< (Some (v + (1)))))
                      else None);
                  (Some (((((st_1.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_lock] :< ret)))
                else (
                  if ((((v_0.(poffset)) + (8)) mod (16)) =? (4))
                  then (Some (((((st_1.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_state_s_granule] :< (v + (1))))
                  else (
                    if (((((v_0.(poffset)) + (8)) mod (16)) >=? (8)) && (((((v_0.(poffset)) + (8)) mod (16)) <? (16))))
                    then (
                      when ret == (
                          if (((((v_0.(poffset)) + (8)) mod (16)) - (8)) =? (0))
                          then (Some ((((((st_1.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :< (v + (1))))
                          else None);
                      (Some (((((st_1.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_ref] :< ret)))
                    else None)));
            (Some (st_1.[share].[globals].[g_granules] :< ((((st_1.(share)).(globals)).(g_granules)) # (((v_0.(poffset)) + (8)) / (16)) == ret))));
        (Some st_2));
    (Some st_0).

  Definition find_lock_granule_spec (v_0: abs_PA_t) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    None.

  Definition s2tte_create_unassigned_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == (
        when v__0, st_1 == (
            if (v_0 =? (0))
            then (Some (0, st))
            else (Some (64, st)));
        (Some (v__0, st_1)));
    (Some (v_2, st_0)).

End Layer5_Spec.

#[global] Hint Unfold llvm_memset_p0i8_i64_spec: spec.
#[global] Hint Unfold memcpy_ns_write_spec: spec.
#[global] Hint Unfold memcpy_ns_read_spec: spec.
#[global] Hint Unfold monitor_call_spec: spec.
#[global] Hint Unfold sort_granules_spec: spec.
#[global] Hint Unfold __find_lock_next_level_spec_low_abs: spec.
#[global] Hint Unfold find_lock_granule_spec_abs: spec.
#[global] Hint Unfold atomic_add_64: spec.
#[global] Hint Unfold s2tte_is_table_spec: spec.
Opaque granule_unlock_spec.
#[global] Hint Unfold s2_sl_addr_to_idx_spec: spec.
#[global] Hint Unfold __find_lock_next_level_spec: spec.
#[global] Hint Unfold pack_struct_return_code_spec: spec.
#[global] Hint Unfold make_return_code_spec: spec.
#[global] Hint Unfold atomic_granule_get_spec: spec.
#[global] Hint Unfold find_lock_granule_spec: spec.
#[global] Hint Unfold s2tte_create_unassigned_spec: spec.
