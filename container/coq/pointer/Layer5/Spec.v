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

  Definition granule_pa_to_va_spec' (v_0: Z) : (option Ptr) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))));
    if ((v_0 & (549755813888)) =? (0))
    then (Some (int_to_ptr (v_0 + (18446744004990074880))))
    else (Some (int_to_ptr (v_0 + (18446743457381744640)))).

  Definition s2tte_create_unassigned_spec_abs (v_0: Z) (st: RData) : (option (abs_PTE_t * RData)) :=
    (Some ((mkabs_PTE_t (mkabs_PA_t (- 1)) 0 v_0 0), st)).

  Definition s2tte_create_destroyed_abs  : abs_PTE_t :=
    (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 0 2).

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
      when st_1 == (
          (spinlock_acquire_spec
            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))
            st));
      if (
        (((((((st_1.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)) / (16))).(e_state_s_granule)) -
          (5)) =?
          (0)))
      then (
        (Some (
          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))  ,
          st_1
        )))
      else (
        when st_2 == (
            (spinlock_release_spec
              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))
              st_1));
        (Some (
          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" ((v_0.(poffset)) + ((8 * ((s2_addr_to_idx_para v_1 v_2)))))) st).(meta_PA)).(meta_granule_offset)))  ,
          st_2
        ))))
    else (Some ((mkPtr "null" 0), st)).

  Definition set_rd_state_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        ((v_0.(poffset)) / (4096)) ==
        ((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).[g_norm] :<
          (((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_norm)) # ((v_0.(poffset)) mod (4096)) == v_1))))).

  Definition pack_struct_return_code_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((pack_struct_return_code_para v_0), st)).

  Definition make_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((make_return_code_para v_0), st)).

  Definition atomic_granule_get_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((v_0.(pbase)) =s ("granules")));
    rely (((((v_0.(poffset)) + (8)) mod (16)) = (8)));
    (Some (st.[share].[globals].[g_granules] :<
      ((((st.(share)).(globals)).(g_granules)) #
        (((v_0.(poffset)) + (8)) / (16)) ==
        (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_ref] :<
          ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
            (((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1))))))).

  Definition atomic_granule_put_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((v_0.(pbase)) =s ("granules")));
    rely (((((v_0.(poffset)) + (8)) mod (16)) = (8)));
    (Some (st.[share].[globals].[g_granules] :<
      ((((st.(share)).(globals)).(g_granules)) #
        (((v_0.(poffset)) + (8)) / (16)) ==
        (((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).[e_ref] :<
          ((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).[e_u_anon_3_0] :<
            (((((((st.(share)).(globals)).(g_granules)) @ (((v_0.(poffset)) + (8)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1)))))))).

  Definition slot_to_va_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    (Some ((mkPtr ((int_to_ptr 18446744071562067968).(pbase)) (((int_to_ptr 18446744071562067968).(poffset)) + ((1 * ((((CPU_ID * (9)) + (v_0)) << (12))))))), st)).

  Definition granule_pa_to_va_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when ret == ((granule_pa_to_va_spec' v_0));
    (Some (ret, st)).

  Definition find_lock_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    None.

  Definition s2tte_create_unassigned_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when ret == ((s2tte_create_ripas_spec' v_0));
    (Some (ret, st)).

End Layer5_Spec.

Opaque granule_pa_to_va_spec'.
#[global] Hint Unfold s2tte_create_unassigned_spec_abs: spec.
#[global] Hint Unfold s2tte_create_destroyed_abs: spec.
#[global] Hint Unfold llvm_memset_p0i8_i64_spec: spec.
#[global] Hint Unfold memcpy_ns_write_spec: spec.
Opaque memcpy_ns_read_spec.
#[global] Hint Unfold monitor_call_spec: spec.
#[global] Hint Unfold sort_granules_spec: spec.
#[global] Hint Unfold __find_lock_next_level_spec_low_abs: spec.
#[global] Hint Unfold find_lock_granule_spec_abs: spec.
#[global] Hint Unfold atomic_add_64: spec.
#[global] Hint Unfold s2tte_is_table_spec: spec.
Opaque granule_unlock_spec.
#[global] Hint Unfold s2_sl_addr_to_idx_spec: spec.
#[global] Hint Unfold __find_lock_next_level_spec: spec.
#[global] Hint Unfold set_rd_state_spec: spec.
#[global] Hint Unfold pack_struct_return_code_spec: spec.
#[global] Hint Unfold make_return_code_spec: spec.
#[global] Hint Unfold atomic_granule_get_spec: spec.
#[global] Hint Unfold atomic_granule_put_spec: spec.
#[global] Hint Unfold slot_to_va_spec: spec.
#[global] Hint Unfold granule_pa_to_va_spec: spec.
#[global] Hint Unfold find_lock_granule_spec: spec.
#[global] Hint Unfold s2tte_create_unassigned_spec: spec.
