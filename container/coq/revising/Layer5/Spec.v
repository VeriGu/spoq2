Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.

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

  Definition find_lock_granule_spec' (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when ret, st' == ((granule_try_lock_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))) v_1 st));
      if ret
      then (Some ((mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16))), st))
      else (Some ((mkPtr "null" 0), st)))
    else (
      when ret, st' == ((granule_try_lock_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))) v_1 st));
      if ret
      then (Some ((mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16))), st))
      else (Some ((mkPtr "null" 0), st))).

  Definition s2tte_is_table_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_1 <? (3)) && (((v_0 & (3)) =? (3)))), st)).

  Definition granule_unlock_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when st_0 == ((spinlock_release_spec (ptr_offset v_0 0) st));
    (Some st_0).

  Definition s2_sl_addr_to_idx_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((Z.lxor ((- 1) << ((v_2 & (4294967295)))) (- 1)) & (v_0)) >> ((39 + (((- 9) * (v_1)))))), st)).

  Definition __find_lock_next_level_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((s2_addr_to_idx_spec v_1 v_2 st));
    when v_5, st_1 == ((__find_next_level_idx_spec v_0 v_4 st_0));
    rely (((((v_5.(pbase)) = ("granules")) /\ ((((v_5.(poffset)) mod (16)) = (0)))) /\ (((v_5.(poffset)) >= (0)))));
    if (ptr_eqb v_5 (mkPtr "null" 0))
    then (Some (v_5, st_1))
    else (
      when st_2 == ((granule_lock_spec v_5 5 st_1));
      (Some (v_5, st_2))).

  Definition addr_is_contained_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    (Some ((((v_2 - (v_0)) >=? (0)) && ((((v_1 + ((- 1))) - (v_2)) >=? (0)))), st)).

  Definition set_rd_state_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((v_0.(pbase)) = ("granule_data")));
    when st_0 == ((__sca_write64_release_spec (ptr_offset v_0 0) v_1 st));
    (Some st_0).

  Definition get_rd_rec_count_unlocked_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((v_0.(pbase)) = ("granule_data")));
    when v_3, st_0 == ((__sca_read64_acquire_spec (ptr_offset v_0 8) st));
    (Some (v_3, st_0)).

  Definition pack_struct_return_code_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((v_0 >> (24)) & (4294967040)) |' (v_0)), st)).

  Definition make_return_code_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_1 << (32)) + (v_0)), st)).

  Definition atomic_granule_get_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_0 == ((atomic_add_64_spec (ptr_offset v_0 8) 1 st));
    (Some st_0).

  Definition atomic_granule_put_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (16)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when st_0 == ((atomic_add_64_spec (ptr_offset v_0 8) (- 1) st));
    (Some st_0).

  Definition slot_to_va_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_2, st_0 == ((cpuid_spec st));
    (Some ((ptr_offset (int_to_ptr 18446744071562067968) (1 * ((((v_2 * (9)) + (v_0)) << (12))))), st_0)).

  Definition granule_pa_to_va_spec (v_0: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))));
    if ((v_0 & (549755813888)) =? (0))
    then (Some ((int_to_ptr (v_0 + (18446744004990074880))), st))
    else (Some ((int_to_ptr (v_0 + (18446743457381744640))), st)).

  Definition find_lock_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    when v_3, st_0 == ((find_granule_spec v_0 st));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (Some ((mkPtr "null" 0), st_0))
    else (
      when v_6, st_1 == ((granule_try_lock_spec v_3 v_1 st_0));
      if v_6
      then (Some (v_3, st_1))
      else (Some ((mkPtr "null" 0), st_1))).

  Definition s2tte_create_unassigned_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((s2tte_create_ripas_spec v_0 st));
    (Some (v_2, st_0)).

End Layer5_Spec.

#[global] Hint Unfold llvm_memset_p0i8_i64_spec: spec.
#[global] Hint Unfold memcpy_ns_write_spec: spec.
#[global] Hint Unfold memcpy_ns_read_spec: spec.
#[global] Hint Unfold monitor_call_spec: spec.
#[global] Hint Unfold sort_granules_spec: spec.
#[global] Hint Unfold find_lock_granule_spec': spec.
#[global] Hint Unfold s2tte_is_table_spec: spec.
#[global] Hint Unfold granule_unlock_spec: spec.
#[global] Hint Unfold s2_sl_addr_to_idx_spec: spec.
#[global] Hint Unfold __find_lock_next_level_spec: spec.
#[global] Hint Unfold addr_is_contained_spec: spec.
#[global] Hint Unfold set_rd_state_spec: spec.
#[global] Hint Unfold get_rd_rec_count_unlocked_spec: spec.
#[global] Hint Unfold pack_struct_return_code_spec: spec.
#[global] Hint Unfold make_return_code_spec: spec.
#[global] Hint Unfold atomic_granule_get_spec: spec.
#[global] Hint Unfold atomic_granule_put_spec: spec.
#[global] Hint Unfold slot_to_va_spec: spec.
#[global] Hint Unfold granule_pa_to_va_spec: spec.
#[global] Hint Unfold find_lock_granule_spec: spec.
#[global] Hint Unfold s2tte_create_unassigned_spec: spec.
