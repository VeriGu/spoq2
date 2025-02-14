Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Spec.
Require Import Layer11.Spec.
Require Import Layer12.complete_hvc_exit.LowSpec.
Require Import Layer12.complete_mmio_emulation.LowSpec.
Require Import Layer12.copy_gic_state_from_ns.LowSpec.
Require Import Layer12.copy_gic_state_to_ns.LowSpec.
Require Import Layer12.data_create.LowSpec.
Require Import Layer12.total_root_rtt_refcount.LowSpec.
Require Import Layer12.s2tt_init_valid.LowSpec.
Require Import Layer12.s2tt_init_valid_ns.LowSpec.
Require Import Layer12.s2tt_init_destroyed.LowSpec.
Require Import Layer12.s2tt_init_assigned.LowSpec.
Require Import Layer12.find_lock_transition_rtts.LowSpec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_Spec.

  Context `{int_ptr: IntPtrCast}.

  (* Definition  total_root_rtt_refcount_loop295_rank (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (v_6: Ptr) (v__027: Z) : Z :=
    0. *)

  Definition vmid_free_spec (v_0: Z) (st: RData) : (option RData) :=
    when st_0 == ((spinlock_acquire_spec (mkPtr "vmid_lock" 0) st));
    when st_1 == ((bitmap_clear_spec (ptr_offset (mkPtr "vmids" 0) 0) v_0 st_0));
    when st_2 == ((spinlock_release_spec (mkPtr "vmid_lock" 0) st_1));
    (Some st_2).
  
  Definition init_rec_regs_spec (v_rec: Ptr) (v_1: Z) (v_rec_params: Ptr) (v_rd: Ptr) (st: RData) : (option RData) :=
    None.

  Fixpoint total_root_rtt_refcount_loop295 (_N_: nat) (__break__: bool) (v_0: Ptr) (v__011: Z) (v__0_lcssa: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v__011, v__0_lcssa, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((total_root_rtt_refcount_loop295 _N__0 __break__ v_0 v__011 v__0_lcssa v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_1, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          when st_1 == ((granule_lock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) 5 st_0));
          when v_6, st_2 == ((g_refcount_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) st_1));
          when st_3 == ((granule_unlock_spec (ptr_offset v_1 (16 * (v_indvars_iv_0))) st_2));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_1, (v_6 + (v__12)), v__0_lcssa_0, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_3))
          else (Some (true, v_1, v__12, (v_6 + (v__12)), v_indvars_iv_0, v_wide_trip_count_0, st_3)))
      | None => None
      end
    end.

  Definition total_root_rtt_refcount_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((0 - (v_1)) <? (0))
    then (
      rely (((total_root_rtt_refcount_loop295_rank v_0 0 0 v_1) >= (0)));
      match ((total_root_rtt_refcount_loop295 (z_to_nat (total_root_rtt_refcount_loop295_rank v_0 0 0 v_1)) false v_0 0 0 0 v_1 st)) with
      | (Some (__break__, v_2, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some (v__0_lcssa_0, st_0))
      | None => None
      end)
    else (Some (0, st)).

  Definition measurement_finish_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition atomic_granule_put_release_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((atomic_load_add_release_64_spec (ptr_offset v_0 8) (- 1) st));
    (Some st_0).

  Definition ns_buffer_write_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_5, st_0 == ((granule_pa_to_va_spec v_1 st));
    when v_6, st_1 == ((memcpy_ns_write_spec v_5 v_3 v_2 st_0));
    (Some (v_6, st_1)).

  Definition get_rd_state_unlocked_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((__sca_read64_acquire_spec (ptr_offset v_0 0) st));
    (Some (v_3, st_0)).

  Fixpoint copy_gic_state_from_ns_loop48 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_1, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((copy_gic_state_from_ns_loop48 _N__0 __break__ v_0 v_1 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (16)))));
          when v_7, st_1 == ((load_RData 8 (ptr_offset v_2 (80 + ((8 * (v_indvars_iv_0))))) st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_3 (80 + ((8 * (v_indvars_iv_0))))) v_7 st_1));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_3, v_2, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_2))
          else (Some (true, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_2)))
      | None => None
      end
    end.

  Definition copy_gic_state_from_ns_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((load_RData 4 (mkPtr "nr_lrs" 0) st));
    if ((0 - (v_3)) <? (0))
    then (copy_gic_state_from_ns_0_low st_0 v_0 v_1 v_3)
    else (
      when v_11, st_2 == ((load_RData 8 (ptr_offset v_0 72) st_0));
      when st_3 == ((store_RData 8 (ptr_offset v_0 72) (v_11 & (18446744073709534977)) st_2));
      when v_14, st_4 == ((load_RData 8 (ptr_offset v_1 208) st_3));
      when st_5 == ((store_RData 8 (ptr_offset v_0 72) ((v_14 & (16638)) |' ((v_11 & (18446744073709534977)))) st_4));
      (Some st_5)).

  Fixpoint copy_gic_state_to_ns_loop59 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_1: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_1, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((copy_gic_state_to_ns_loop59 _N__0 __break__ v_0 v_1 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (16)))));
          when v_7, st_1 == ((load_RData 8 (ptr_offset v_3 (80 + ((8 * (v_indvars_iv_0))))) st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_2 (168 + ((8 * (v_indvars_iv_0))))) v_7 st_1));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_3, v_2, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_2))
          else (Some (true, v_3, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_2)))
      | None => None
      end
    end.

  Definition copy_gic_state_to_ns_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((load_RData 4 (mkPtr "nr_lrs" 0) st));
    if ((0 - (v_3)) <? (0))
    then (copy_gic_state_to_ns_0_low st_0 v_0 v_1 v_3)
    else (
      when v_11, st_2 == ((load_RData 8 (ptr_offset v_0 208) st_0));
      when st_3 == ((store_RData 8 (ptr_offset v_1 128) v_11 st_2));
      when v_14, st_4 == ((load_RData 8 (ptr_offset v_0 64) st_3));
      when st_5 == ((store_RData 8 (ptr_offset v_1 120) v_14 st_4));
      when v_17, st_6 == ((load_RData 8 (ptr_offset v_0 72) st_5));
      when st_7 == ((store_RData 8 (ptr_offset v_1 296) (v_17 & (4160766206)) st_6));
      (Some st_7)).

  Definition complete_sysreg_emulation_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 952) st));
    when v_5, st_1 == ((esr_sysreg_rt_spec v_4 st_0));
    if ((v_4 & (4227858432)) =? (1610612736))
    then (
      if (
        if ((v_4 & (1)) =? (0))
        then true
        else (v_5 =? (31)))
      then (Some st_1)
      else (
        when v_13, st_2 == ((load_RData 8 (ptr_offset v_1 64) st_1));
        rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
        when st_3 == ((store_RData 8 (ptr_offset v_0 (24 + ((8 * (v_5))))) v_13 st_2));
        (Some st_3)))
    else (Some st_1).

  Definition complete_hvc_exit_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 952) st));
    if ((v_4 & (4227858432)) =? (1476395008))
    then (complete_hvc_exit_0_low st_0 v_0 v_1 v_4)
    else (Some st_0).

  Definition process_disposed_info_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    when v_4, st_0 == ((load_RData 1 (ptr_offset v_0 896) st));
    if ((v_4 & (1)) =? (0))
    then (Some st_0)
    else (
      when st_1 == ((store_RData 8 (ptr_offset v_0 24) 0 st_0));
      when v_9, st_2 == ((load_RData 8 (ptr_offset v_1 72) st_1));
      if (v_9 =? (0))
      then (
        when st_3 == ((store_RData 8 (ptr_offset v_0 32) 0 st_2));
        when st_5 == ((store_RData 1 (ptr_offset v_0 896) 0 st_3));
        (Some st_5))
      else (
        when st_3 == ((store_RData 8 (ptr_offset v_0 32) 1 st_2));
        when st_5 == ((store_RData 1 (ptr_offset v_0 896) 0 st_3));
        (Some st_5))).

  Definition complete_mmio_emulation_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (bool * RData)) :=
    when v_4, st_0 == ((load_RData 8 (ptr_offset v_0 952) st));
    when v_5, st_1 == ((esr_srt_spec v_4 st_0));
    when v_7, st_2 == ((load_RData 8 (ptr_offset v_1 56) st_1));
    if (v_7 =? (0))
    then (Some (true, st_2))
    else (
      if ((v_4 & (4227858432)) =? (2415919104))
      then (
        if ((v_4 & (16777216)) =? (0))
        then (Some (false, st_2))
        else (
          when v_15, st_3 == ((esr_is_write_spec v_4 st_2));
          if (
            if (xorb v_15 true)
            then (v_5 <>? (31))
            else false)
          then (
            when v_19, st_4 == ((load_RData 8 (ptr_offset v_1 64) st_3));
            when v_20, st_5 == ((access_mask_spec v_4 st_4));
            when v_22, st_6 == ((esr_sign_extend_spec v_4 st_5));
            if v_22
            then (
              when v_24, st_7 == ((access_len_spec v_4 st_6));
              when v_31, st_8 == ((esr_sixty_four_spec v_4 st_7));
              if v_31
              then (complete_mmio_emulation_0_low st_8 v_0 v_19 v_20 v_24 v_31 v_5)
              else (
                rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
                when st_11 == (
                    (store_RData
                      8
                      (ptr_offset v_0 (24 + ((8 * (v_5)))))
                      (((Z.lxor (1 << (((v_24 * (8)) + ((- 1))))) (v_20 & (v_19))) - ((1 << (((v_24 * (8)) + ((- 1))))))) & (4294967295))
                      st_8));
                when v_39, st_13 == ((load_RData 8 (ptr_offset v_0 272) st_11));
                when st_14 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_13));
                (Some (true, st_14))))
            else (
              rely ((((0 - (v_5)) <= (0)) /\ ((v_5 < (31)))));
              when st_8 == ((store_RData 8 (ptr_offset v_0 (24 + ((8 * (v_5))))) (v_20 & (v_19)) st_6));
              when v_39, st_10 == ((load_RData 8 (ptr_offset v_0 272) st_8));
              when st_11 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_10));
              (Some (true, st_11))))
          else (
            when v_39, st_5 == ((load_RData 8 (ptr_offset v_0 272) st_3));
            when st_6 == ((store_RData 8 (ptr_offset v_0 272) (v_39 + (4)) st_5));
            (Some (true, st_6)))))
      else (Some (false, st_2))).

  Definition host_ns_s2tte_is_valid_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_3, st_0 == ((addr_level_mask_spec (- 1) v_1 st));
    if ((v_0 & (281474976706560)) =? (708837376))
    then (Some (true, st_0))
    else (
      if (((Z.lxor (v_3 |' (1020)) (- 1)) & (v_0)) =? (0))
      then (
        if ((v_0 & (60)) =? (16))
        then (Some (false, st_0))
        else (
          if ((v_0 & (768)) =? (256))
          then (Some (false, st_0))
          else (Some (true, st_0))))
      else (Some (false, st_0))).

  Definition __granule_refcount_dec_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((atomic_add_64_spec (ptr_offset v_0 8) 18446744073709551104 st));
    (Some st_0).

  Fixpoint s2tt_init_valid_loop820 (_N_: nat) (__return__: bool) (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_0, v_2, v_5, v__010, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_valid_loop820 _N__0 __return__ v_0 v_2 v_5 v__010 v_indvars_iv st)) with
      | (Some (__return___0, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0)) =>
        if __return___0
        then (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0))
        else (
          when v_7, st_1 == ((s2tte_create_valid_spec v__11 v_3 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) v_7 st_1));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, v_3, v_6, (v__11 + (v_6)), (v_indvars_iv_0 + (1)), st_2))
          else (
            when st_3 == ((iasm_10_spec st_2));
            (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_3))))
      | None => None
      end
    end.

  Definition s2tt_init_valid_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    when v_5, st_0 == ((s2tte_map_size_spec v_2 st));
    rely (((s2tt_init_valid_loop820_rank v_0 v_2 v_5 v_1 0) >= (0)));
    match ((s2tt_init_valid_loop820 (z_to_nat (s2tt_init_valid_loop820_rank v_0 v_2 v_5 v_1 0)) false v_0 v_2 v_5 v_1 0 st_0)) with
    | (Some (__return__, v_7, v_3, v_6, v__11, v_indvars_iv_0, st_1)) => (Some st_1)
    | None => None
    end.

  Definition __granule_refcount_inc_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((atomic_add_64_spec (ptr_offset v_0 8) 512 st));
    (Some st_0).

  Fixpoint s2tt_init_valid_ns_loop839 (_N_: nat) (__return__: bool) (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_0, v_2, v_5, v__010, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_valid_ns_loop839 _N__0 __return__ v_0 v_2 v_5 v__010 v_indvars_iv st)) with
      | (Some (__return___0, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0)) =>
        if __return___0
        then (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0))
        else (
          when v_7, st_1 == ((s2tte_create_valid_ns_spec v__11 v_3 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) v_7 st_1));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, v_3, v_6, (v__11 + (v_6)), (v_indvars_iv_0 + (1)), st_2))
          else (
            when st_3 == ((iasm_10_spec st_2));
            (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_3))))
      | None => None
      end
    end.

  Definition s2tt_init_valid_ns_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    when v_5, st_0 == ((s2tte_map_size_spec v_2 st));
    rely (((s2tt_init_valid_ns_loop839_rank v_0 v_2 v_5 v_1 0) >= (0)));
    match ((s2tt_init_valid_ns_loop839 (z_to_nat (s2tt_init_valid_ns_loop839_rank v_0 v_2 v_5 v_1 0)) false v_0 v_2 v_5 v_1 0 st_0)) with
    | (Some (__return__, v_7, v_3, v_6, v__11, v_indvars_iv_0, st_1)) => (Some st_1)
    | None => None
    end.

  Fixpoint s2tt_init_destroyed_loop776 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_destroyed_loop776 _N__0 __break__ v_0 v_indvars_iv st)) with
      | (Some (__break___0, v_1, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv_0, st_0))
        else (
          when st_1 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) 8 st_0));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, (v_indvars_iv_0 + (1)), st_1))
          else (Some (true, v_1, v_indvars_iv_0, st_1)))
      | None => None
      end
    end.

  Fixpoint s2tt_init_destroyed_loop776_0 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_index: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_index, st))
    | (S _N__0) =>
      match ((s2tt_init_destroyed_loop776_0 _N__0 __break__ v_0 v_index st)) with
      | (Some (__break___0, v_1, v_index_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_index_0, st_0))
        else (
          when st_1 == ((store_RData 8 (ptr_offset v_1 (8 * (v_index_0))) 8 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * ((v_index_0 + (1))))) 8 st_1));
          if ((v_index_0 + (2)) =? (512))
          then (Some (true, v_1, v_index_0, st_2))
          else (Some (false, v_1, (v_index_0 + (2)), st_2)))
      | None => None
      end
    end.

  Definition s2tt_init_destroyed_spec (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((s2tt_init_destroyed_loop776_0_rank v_0 0) >= (0)));
    match (
      match ((s2tt_init_destroyed_loop776_0 (z_to_nat (s2tt_init_destroyed_loop776_0_rank v_0 0)) false v_0 0 st)) with
      | (Some (__break__, v_1, v_index_0, st_0)) =>
        when st_1 == ((iasm_10_spec st_0));
        (Some (true, 0, st_1))
      | None => None
      end
    ) with
    | (Some (__return__, v_bc_resume_val, st_0)) =>
      if __return__
      then (Some st_0)
      else (
        rely (((s2tt_init_destroyed_loop776_rank v_0 v_bc_resume_val) >= (0)));
        match ((s2tt_init_destroyed_loop776 (z_to_nat (s2tt_init_destroyed_loop776_rank v_0 v_bc_resume_val)) false v_0 v_bc_resume_val st_0)) with
        | (Some (__break__, v_1, v_indvars_iv_0, st_1)) =>
          when st_2 == ((iasm_10_spec st_1));
          (Some st_2)
        | None => None
        end)
    | None => None
    end.

Definition validate_rtt_structure_cmds_spec' (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
  rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((((v_2.(poffset)) mod (4096)) = (0)))));
  when ret, st' == ((realm_rtt_starting_level_spec' v_2 st));
  if ((v_1 >? (3)) || ((((ret + (1)) - (v_1)) >? (0))))
  then (Some (4294967297, st))
  else (
    when ret_0, st'_0 == ((validate_map_addr_spec' v_0 v_1 v_2 st));
    (Some (ret_0, st))).

  Definition validate_rtt_structure_cmds_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((validate_rtt_structure_cmds_spec' v_0 v_1 v_2 st));
    (Some (ret, st)).
  (* Definition validate_rtt_structure_cmds_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((realm_rtt_starting_level_spec v_2 st));
    if ((v_1 >? (3)) || ((((v_4 + (1)) - (v_1)) >? (0))))
    then (
      when v_10, st_1 == ((make_return_code_spec 1 1 st_0));
      (Some (v_10, st_1)))
    else (
      when v_12, st_1 == ((validate_map_addr_spec v_0 v_1 v_2 st_0));
      (Some (v_12, st_1))). *)

  Fixpoint s2tt_init_assigned_loop801 (_N_: nat) (__return__: bool) (v_0: Ptr) (v_2: Z) (v_5: Z) (v__010: Z) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_0, v_2, v_5, v__010, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_assigned_loop801 _N__0 __return__ v_0 v_2 v_5 v__010 v_indvars_iv st)) with
      | (Some (__return___0, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0)) =>
        if __return___0
        then (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_0))
        else (
          when v_7, st_1 == ((s2tte_create_assigned_spec v__11 v_3 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) v_7 st_1));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, v_3, v_6, (v__11 + (v_6)), (v_indvars_iv_0 + (1)), st_2))
          else (
            when st_3 == ((iasm_10_spec st_2));
            (Some (true, v_1, v_3, v_6, v__11, v_indvars_iv_0, st_3))))
      | None => None
      end
    end.

  Definition s2tt_init_assigned_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    when v_5, st_0 == ((s2tte_map_size_spec v_2 st));
    rely (((s2tt_init_assigned_loop801_rank v_0 v_2 v_5 v_1 0) >= (0)));
    match ((s2tt_init_assigned_loop801 (z_to_nat (s2tt_init_assigned_loop801_rank v_0 v_2 v_5 v_1 0)) false v_0 v_2 v_5 v_1 0 st_0)) with
    | (Some (__return__, v_7, v_3, v_6, v__11, v_indvars_iv_0, st_1)) => (Some st_1)
    | None => None
    end.

  Definition get_cntfrq_spec (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((iasm_33_spec st));
    (Some (v_1, st_0)).

  Definition gic_cpu_state_init_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((memset_spec v_0 0 216 st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 72) 33025 st_0));
    (Some st_1).

  Definition vmpidr_is_valid_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (18446742978476114160)) =? (0)), st)).

  Definition get_rd_rec_count_locked_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((__sca_read64_spec (ptr_offset v_0 8) st));
    (Some (v_3, st_0)).

  Definition find_lock_unused_granule_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    when v_3, st_0 == ((find_lock_granule_spec v_0 v_1 st));
    rely (((((v_3.(poffset)) mod (16)) = (0)) /\ (((v_3.(poffset)) >= (0)))));
    rely ((((v_3.(pbase)) = ("granules")) \/ (((v_3.(pbase)) = ("null")))));
    if (ptr_eqb v_3 (mkPtr "null" 0))
    then (
      when v_5, st_1 == ((status_ptr_spec 1 st_0));
      (Some (v_5, st_1)))
    else (
      when v_8, st_1 == ((granule_refcount_read_acquire_spec v_3 st_0));
      if (v_8 =? (0))
      then (Some (v_3, st_1))
      else (
        when st_2 == ((granule_unlock_spec v_3 st_1));
        when v_10, st_3 == ((status_ptr_spec 4 st_2));
        (Some (v_10, st_3)))).

  Definition ptr_is_err_spec (v_0: Ptr) (st: RData) : (option (bool * RData)) :=
    (Some ((ptr_gtb v_0 (int_to_ptr 18446744073709547520)), st)).

  Definition ptr_status_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    (Some ((0 - ((ptr_to_int v_0))), st)).

  Definition data_create_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "data_create" st));
    when v_8, st_1 == ((find_lock_two_granules_spec v_0 1 (mkPtr "stack_type_4" 0) v_1 2 (mkPtr "stack_type_4__1" 0) st_0));
    if (v_8 =? (3))
    then (
      when v_11, st_2 == ((pack_return_code_spec 3 0 st_1));
      when st_4 == ((free_stack "data_create" st_0 st_2));
      (Some (v_11, st_4)))
    else (
      if (v_8 =? (0))
      then (
        when v_19_tmp, st_2 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_1));
        when v_24, st_3 == ((granule_map_spec (int_to_ptr v_19_tmp) 2 st_2));
        if (ptr_eqb v_3 (mkPtr "null" 0))
        then (
          when v_26, st_4 == ((validate_data_create_unknown_spec v_2 v_24 st_3));
          if (v_26 =? (0))
          then (
            when v_32_tmp, st_6 == ((load_RData 8 (ptr_offset v_24 32) st_4));
            when v_33, st_7 == ((realm_rtt_starting_level_spec v_24 st_6));
            when v_34, st_8 == ((realm_ipa_bits_spec v_24 st_7));
            when st_9 == ((granule_lock_spec (int_to_ptr v_32_tmp) 5 st_8));
            when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_32_tmp) v_33 v_34 v_2 3 st_9));
            rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
            when v__sroa_028_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
            when v__sroa_6_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
            if (v__sroa_6_0_copyload =? (3))
            then (
              when v__sroa_4_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
              when v_39, st_14 == ((granule_map_spec (int_to_ptr v__sroa_028_0_copyload_tmp) 6 st_13));
              when v_42, st_15 == ((__tte_read_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) st_14));
              when v_43, st_16 == ((s2tte_is_unassigned_spec v_42 st_15));
              if v_43
              then (
                when v_57, st_17 == ((s2tte_get_ripas_spec v_42 st_16));
                if (v_57 =? (0))
                then (data_create_0_low st_0 st_17 v_0 v_39 v_57 v__sroa_028_0_copyload_tmp v__sroa_4_0_copyload)
                else (
                  when v_62, st_18 == ((s2tte_create_valid_spec v_0 3 st_17));
                  when st_20 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_62 st_18));
                  when st_21 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_20));
                  when st_22 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_21));
                  when v_68_tmp, st_23 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_22));
                  when st_24 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_23));
                  when v_69_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_24));
                  when st_26 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_25));
                  when st_27 == ((free_stack "data_create" st_0 st_26));
                  (Some (0, st_27))))
              else (
                when v_45, st_17 == ((pack_return_code_spec 9 0 st_16));
                when st_18 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_17));
                when v_68_tmp, st_19 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_18));
                when st_20 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_19));
                when v_69_tmp, st_21 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_20));
                when st_22 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_21));
                when st_24 == ((free_stack "data_create" st_0 st_22));
                (Some (v_45, st_24))))
            else (
              when v_37, st_13 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_12));
              when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_13));
              when v_68_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_15));
              when v_69_tmp, st_17 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_16));
              when st_18 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_17));
              when st_20 == ((free_stack "data_create" st_0 st_18));
              (Some (v_37, st_20))))
          else (
            when v_28, st_6 == ((pack_struct_return_code_spec v_26 st_4));
            when v_68_tmp, st_7 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_6));
            when st_8 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_7));
            when v_69_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_8));
            when st_10 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_9));
            when st_12 == ((free_stack "data_create" st_0 st_10));
            (Some (v_28, st_12))))
        else (
          when v_26, st_4 == ((validate_data_create_spec v_2 v_24 st_3));
          if (v_26 =? (0))
          then (
            when v_32_tmp, st_6 == ((load_RData 8 (ptr_offset v_24 32) st_4));
            when v_33, st_7 == ((realm_rtt_starting_level_spec v_24 st_6));
            when v_34, st_8 == ((realm_ipa_bits_spec v_24 st_7));
            when st_9 == ((granule_lock_spec (int_to_ptr v_32_tmp) 5 st_8));
            when st_10 == ((rtt_walk_lock_unlock_spec (mkPtr "stack_s_rtt_walk" 0) (int_to_ptr v_32_tmp) v_33 v_34 v_2 3 st_9));
            rely ((((st_10.(share)).(granule_data)) = (((st_9.(share)).(granule_data)))));
            when v__sroa_028_0_copyload_tmp, st_11 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 0) st_10));
            when v__sroa_6_0_copyload, st_12 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 16) st_11));
            if (v__sroa_6_0_copyload =? (3))
            then (
              when v__sroa_4_0_copyload, st_13 == ((load_RData 8 (ptr_offset (mkPtr "stack_s_rtt_walk" 0) 8) st_12));
              when v_39, st_14 == ((granule_map_spec (int_to_ptr v__sroa_028_0_copyload_tmp) 6 st_13));
              when v_42, st_15 == ((__tte_read_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) st_14));
              when v_43, st_16 == ((s2tte_is_unassigned_spec v_42 st_15));
              if v_43
              then (
                when v_48_tmp, st_17 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_16));
                when v_49, st_18 == ((granule_map_spec (int_to_ptr v_48_tmp) 1 st_17));
                when v_50, st_19 == ((granule_addr_spec v_3 st_18));
                when v_51, st_20 == ((ns_buffer_read_spec 0 v_50 4096 v_49 st_19));
                when st_21 == ((ns_buffer_unmap_spec 0 st_20));
                if v_51
                then (
                  when v_57, st_23 == ((s2tte_get_ripas_spec v_42 st_21));
                  if (v_57 =? (0))
                  then (data_create_1_low st_0 st_23 v_0 v_39 v_57 v__sroa_028_0_copyload_tmp v__sroa_4_0_copyload)
                  else (
                    when v_62, st_24 == ((s2tte_create_valid_spec v_0 3 st_23));
                    when st_25 == ((__tte_write_spec (ptr_offset v_39 (8 * (v__sroa_4_0_copyload))) v_62 st_24));
                    when st_26 == ((__granule_get_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_25));
                    when st_27 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_26));
                    when v_68_tmp, st_28 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_27));
                    when st_29 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_28));
                    when v_69_tmp, st_30 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_29));
                    when st_31 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 4 st_30));
                    when st_32 == ((free_stack "data_create" st_0 st_31));
                    (Some (0, st_32))))
                else (
                  when v_53, st_22 == ((memset_spec v_49 0 4096 st_21));
                  when v_54, st_23 == ((pack_return_code_spec 1 4 st_22));
                  when st_24 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_23));
                  when v_68_tmp, st_25 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_24));
                  when st_26 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_25));
                  when v_69_tmp, st_27 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_26));
                  when st_28 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_27));
                  when st_30 == ((free_stack "data_create" st_0 st_28));
                  (Some (v_54, st_30))))
              else (
                when v_45, st_17 == ((pack_return_code_spec 9 0 st_16));
                when st_18 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_17));
                when v_68_tmp, st_19 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_18));
                when st_20 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_19));
                when v_69_tmp, st_21 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_20));
                when st_22 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_21));
                when st_24 == ((free_stack "data_create" st_0 st_22));
                (Some (v_45, st_24))))
            else (
              when v_37, st_13 == ((pack_return_code_spec 8 v__sroa_6_0_copyload st_12));
              when st_14 == ((granule_unlock_spec (int_to_ptr v__sroa_028_0_copyload_tmp) st_13));
              when v_68_tmp, st_15 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_14));
              when st_16 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_15));
              when v_69_tmp, st_17 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_16));
              when st_18 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_17));
              when st_20 == ((free_stack "data_create" st_0 st_18));
              (Some (v_37, st_20))))
          else (
            when v_28, st_6 == ((pack_struct_return_code_spec v_26 st_4));
            when v_68_tmp, st_7 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_6));
            when st_8 == ((granule_unlock_spec (int_to_ptr v_68_tmp) st_7));
            when v_69_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_8));
            when st_10 == ((granule_unlock_transition_spec (int_to_ptr v_69_tmp) 1 st_9));
            when st_12 == ((free_stack "data_create" st_0 st_10));
            (Some (v_28, st_12)))))
      else (
        when v_16, st_2 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_1));
        when st_4 == ((free_stack "data_create" st_0 st_2));
        (Some (v_16, st_4)))).

  Definition map_unmap_ns_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
    rely (
      (((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (4294967296)) < (0)))) \/ ((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))))) /\
        (((v_0 & (4095)) = (0)))));
    if ((v_0 - (MEM1_PHYS)) >=? (0))
    then (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_map_cmds_spec'
                v_1
                v_2
                ret_0
                ((st.[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((st.[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                        ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))));
            when ret_3, st'_1 == (
                (realm_ipa_bits_spec'
                  ret_0
                  ((st.[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                        ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))));
            if (v_4 =? (0))
            then (
              when ret_4, st'_2 == (
                  (addr_block_intersects_par_spec'
                    ret_0
                    v_1
                    v_2
                    ((st.[log] :< ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                      (sh.[globals].[g_granules] :<
                        (((sh.(globals)).(g_granules)) #
                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                          ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))))));
              if ret_4
              then (
                (Some (
                  8589935105  ,
                  ((st.[log] :<
                    ((EVT
                      CPU_ID
                      (REL
                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                        ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                      (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                        ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))
                )))
              else (
                when sh_0 == (
                    ((st.(repl))
                      ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                      (sh.[globals].[g_granules] :<
                        (((sh.(globals)).(g_granules)) #
                          ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                          ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
                match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
                | None =>
                  rely (
                    (((((((sh.(globals)).(g_granules)) #
                      ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                      ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                      (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                      (0)));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                      ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                  if (
                    ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                      (5)) =?
                      (0)))
                  then (
                    when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                    when st_12 == (
                        (rtt_walk_lock_unlock_spec
                          (mkPtr "stack_s_rtt_walk" 0)
                          (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                          ret_2
                          ret_3
                          v_1
                          v_2
                          ((st.[log] :<
                            ((EVT
                              CPU_ID
                              (REL ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                              (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                  (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))).[share] :<
                            (sh_0.[globals].[g_granules] :<
                              ((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))));
                    rely ((((st_12.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                    if (((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                    then (
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((6 >= (0)))) /\
                          ((6 <= (24)))));
                      when ret_5 == ((granule_addr_spec' (mkPtr "granules" ((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                      when ret_6 == ((buffer_map_spec' 6 ret_5 false));
                      rely ((((ret_6.(pbase)) = ("granule_data")) /\ (((ret_6.(poffset)) >= (0)))));
                      when v_42, st_17 == ((__tte_read_spec (mkPtr (ret_6.(pbase)) ((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_12));
                      rely ((((st_17.(share)).(granule_data)) = (((st_12.(share)).(granule_data)))));
                      if ((v_42 & (63)) =? (0))
                      then (
                        when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                        rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_17.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                              ((st_17.(log))))).[share].[globals].[g_granules] :<
                            ((((st_17.(share)).(globals)).(g_granules)) #
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_17.(share)).(granule_data)) #
                              (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        )))
                      else (
                        if ((v_42 & (63)) =? (8))
                        then (
                          when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                          rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              (((st_17.(share)).(granule_data)) #
                                (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7))))
                          )))
                        else (
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            9  ,
                            ((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          )))))
                    else (
                      when cid_0 == (((((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        ((((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                        ((st_12.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_12.(log))))).[share].[globals].[g_granules] :<
                          ((((st_12.(share)).(globals)).(g_granules)) #
                            (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                  else (
                    when cid == (
                        ((((((sh_0.(globals)).(g_granules)) #
                          (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                          ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                            None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                    when st_12 == (
                        (rtt_walk_lock_unlock_spec
                          (mkPtr "stack_s_rtt_walk" 0)
                          (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                          ret_2
                          ret_3
                          v_1
                          v_2
                          ((st.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                                ((((sh_0.(globals)).(g_granules)) #
                                  (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                  ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                                  ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID)))) ::
                                (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                  ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                    (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))))).[share] :<
                            (sh_0.[globals].[g_granules] :<
                              ((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) #
                                ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                                (((((sh_0.(globals)).(g_granules)) #
                                  (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                  ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                  None))))));
                    rely ((((st_12.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                    if (((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                    then (
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((6 >= (0)))) /\
                          ((6 <= (24)))));
                      when ret_5 == ((granule_addr_spec' (mkPtr "granules" ((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                      when ret_6 == ((buffer_map_spec' 6 ret_5 false));
                      rely ((((ret_6.(pbase)) = ("granule_data")) /\ (((ret_6.(poffset)) >= (0)))));
                      when v_42, st_17 == ((__tte_read_spec (mkPtr (ret_6.(pbase)) ((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_12));
                      rely ((((st_17.(share)).(granule_data)) = (((st_12.(share)).(granule_data)))));
                      if ((v_42 & (63)) =? (0))
                      then (
                        when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                        rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_17.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                              ((st_17.(log))))).[share].[globals].[g_granules] :<
                            ((((st_17.(share)).(globals)).(g_granules)) #
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_17.(share)).(granule_data)) #
                              (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        )))
                      else (
                        if ((v_42 & (63)) =? (8))
                        then (
                          when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                          rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              (((st_17.(share)).(granule_data)) #
                                (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7))))
                          )))
                        else (
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            9  ,
                            ((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          )))))
                    else (
                      when cid_0 == (((((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        ((((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                        ((st_12.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_12.(log))))).[share].[globals].[g_granules] :<
                          ((((st_12.(share)).(globals)).(g_granules)) #
                            (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                | (Some cid) => None
                end))
            else (
              when sh_0 == (
                  ((st.(repl))
                    ((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                        ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))))));
              match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
              | None =>
                rely (
                  (((((((sh.(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                    ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                    (0)));
                rely (
                  ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                    ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                if (
                  ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when cid == ((((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                  when st_11 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT
                            CPU_ID
                            (REL ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) (((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))).[share] :<
                          (sh_0.[globals].[g_granules] :<
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) #
                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))));
                  rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                    rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                    when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                    if ret_6
                    then (
                      when ret_7 == ((s2tte_create_ripas_spec' 1));
                      rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                      if (v_2 =? (3))
                      then (
                        match (
                          (stage2_tlbi_ipa_loop210
                            (z_to_nat 0)
                            false
                            v_1
                            4096
                            (((st_16.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< ((((st_16.(stack)).(stack_s_realm_s2_context)).(e_vmid)) << (48))).[share].[globals].[g_granules] :<
                              ((((st_16.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_16.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7)))))
                        ) with
                        | (Some (__break__, v__13, v__912, st_4)) =>
                          when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_4.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_4.(log))))).[priv].[pcpu_regs].[pcpu_vttbr_el2] :<
                              (((st_16.(priv)).(pcpu_regs)).(pcpu_vttbr_el2))).[share].[globals].[g_granules] :<
                              ((((st_4.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          ))
                        | None => None
                        end)
                      else (
                        when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_16.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                              ((st_16.(log))))).[share].[globals].[g_granules] :<
                            ((((st_16.(share)).(globals)).(g_granules)) #
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        ))))
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        9  ,
                        ((st_16.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_16.(log))))).[share].[globals].[g_granules] :<
                          ((((st_16.(share)).(globals)).(g_granules)) #
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                  else (
                    when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st_11.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_11.(log))))).[share].[globals].[g_granules] :<
                        ((((st_11.(share)).(globals)).(g_granules)) #
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
                else (
                  when cid == (
                      ((((((sh_0.(globals)).(g_granules)) #
                        (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                        ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).(e_lock)).(e_val)));
                  when st_11 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                              ((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID)))) ::
                              (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st.(oracle)) ((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                  (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))))).[share] :<
                          (sh_0.[globals].[g_granules] :<
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) #
                              ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                              (((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :<
                                None))))));
                  rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                    rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                    when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                    if ret_6
                    then (
                      when ret_7 == ((s2tte_create_ripas_spec' 1));
                      rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                      if (v_2 =? (3))
                      then (
                        match (
                          (stage2_tlbi_ipa_loop210
                            (z_to_nat 0)
                            false
                            v_1
                            4096
                            (((st_16.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< ((((st_16.(stack)).(stack_s_realm_s2_context)).(e_vmid)) << (48))).[share].[globals].[g_granules] :<
                              ((((st_16.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_16.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7)))))
                        ) with
                        | (Some (__break__, v__13, v__912, st_4)) =>
                          when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_4.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_4.(log))))).[priv].[pcpu_regs].[pcpu_vttbr_el2] :<
                              (((st_16.(priv)).(pcpu_regs)).(pcpu_vttbr_el2))).[share].[globals].[g_granules] :<
                              ((((st_4.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          ))
                        | None => None
                        end)
                      else (
                        when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_16.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                              ((st_16.(log))))).[share].[globals].[g_granules] :<
                            ((((st_16.(share)).(globals)).(g_granules)) #
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        ))))
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        9  ,
                        ((st_16.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_16.(log))))).[share].[globals].[g_granules] :<
                          ((((st_16.(share)).(globals)).(g_granules)) #
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                  else (
                    when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st_11.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_11.(log))))).[share].[globals].[g_granules] :<
                        ((((st_11.(share)).(globals)).(g_granules)) #
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
              | (Some cid) => None
              end))
          else (
            (Some (
              (((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1))))  ,
              ((st.[log] :<
                ((EVT
                  CPU_ID
                  (REL
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                    ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[globals].[g_granules] :<
                  (((sh.(globals)).(g_granules)) #
                    ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                    ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))
            ))))
        else (
          (Some (
            4294967553  ,
            ((st.[log] :<
              ((EVT
                CPU_ID
                (REL
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              (sh.[globals].[g_granules] :<
                (((sh.(globals)).(g_granules)) #
                  ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16)) ==
                  ((((sh.(globals)).(g_granules)) @ ((((v_0 + ((- MEM1_PHYS))) >> (524300)) * (16)) / (16))).[e_lock].[e_val] :< None))))
          )))
      | (Some cid) => None
      end)
    else (
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val))) with
      | None =>
        rely (
          (((((((st.(share)).(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) -
            (((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)))) =
            (0)));
        if ((((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_state_s_granule)) - (2)) =? (0))
        then (
          when ret == ((granule_addr_spec' (mkPtr "granules" (((v_0 + ((- MEM0_PHYS))) >> (12)) * (16)))));
          when ret_0 == ((buffer_map_spec' 2 ret false));
          rely ((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))));
          rely (((((ret_0.(pbase)) = ("granule_data")) /\ (((ret_0.(poffset)) >= (0)))) /\ ((((ret_0.(poffset)) mod (4096)) = (0)))));
          rely ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
          when ret_1, st' == (
              (validate_rtt_map_cmds_spec'
                v_1
                v_2
                ret_0
                ((st.[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                  (sh.[globals].[g_granules] :<
                    (((sh.(globals)).(g_granules)) #
                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))))));
          if (ret_1 =? (0))
          then (
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)));
            rely ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (MEM0_VIRT)) < (0)));
            when ret_2, st'_0 == (
                (realm_rtt_starting_level_spec'
                  ret_0
                  ((st.[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))))));
            when ret_3, st'_1 == (
                (realm_ipa_bits_spec'
                  ret_0
                  ((st.[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))))));
            if (v_4 =? (0))
            then (
              when ret_4, st'_2 == (
                  (addr_block_intersects_par_spec'
                    ret_0
                    v_1
                    v_2
                    ((st.[log] :< ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
                      (sh.[globals].[g_granules] :<
                        (((sh.(globals)).(g_granules)) #
                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                          ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))))));
              if ret_4
              then (
                (Some (
                  8589935105  ,
                  ((st.[log] :<
                    ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                      (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
                )))
              else (
                when sh_0 == (
                    ((st.(repl))
                      ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                      (sh.[globals].[g_granules] :<
                        (((sh.(globals)).(g_granules)) #
                          ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                          ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
                match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
                | None =>
                  rely (
                    (((((((sh.(globals)).(g_granules)) #
                      ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                      ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                      (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                      (0)));
                  rely (
                    ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                      ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                  if (
                    ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                      (5)) =?
                      (0)))
                  then (
                    when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                    when st_12 == (
                        (rtt_walk_lock_unlock_spec
                          (mkPtr "stack_s_rtt_walk" 0)
                          (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                          ret_2
                          ret_3
                          v_1
                          v_2
                          ((st.[log] :<
                            ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                              (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                  (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))).[share] :<
                            (sh_0.[globals].[g_granules] :<
                              ((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID))) #
                                ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                ((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))));
                    rely ((((st_12.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                    if (((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                    then (
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((6 >= (0)))) /\
                          ((6 <= (24)))));
                      when ret_5 == ((granule_addr_spec' (mkPtr "granules" ((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                      when ret_6 == ((buffer_map_spec' 6 ret_5 false));
                      rely ((((ret_6.(pbase)) = ("granule_data")) /\ (((ret_6.(poffset)) >= (0)))));
                      when v_42, st_17 == ((__tte_read_spec (mkPtr (ret_6.(pbase)) ((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_12));
                      rely ((((st_17.(share)).(granule_data)) = (((st_12.(share)).(granule_data)))));
                      if ((v_42 & (63)) =? (0))
                      then (
                        when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                        rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_17.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                              ((st_17.(log))))).[share].[globals].[g_granules] :<
                            ((((st_17.(share)).(globals)).(g_granules)) #
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_17.(share)).(granule_data)) #
                              (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        )))
                      else (
                        if ((v_42 & (63)) =? (8))
                        then (
                          when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                          rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              (((st_17.(share)).(granule_data)) #
                                (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7))))
                          )))
                        else (
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            9  ,
                            ((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          )))))
                    else (
                      when cid_0 == (((((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        ((((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                        ((st_12.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_12.(log))))).[share].[globals].[g_granules] :<
                          ((((st_12.(share)).(globals)).(g_granules)) #
                            (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                  else (
                    when cid == (
                        ((((((sh_0.(globals)).(g_granules)) #
                          (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                          ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                            None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                    when st_12 == (
                        (rtt_walk_lock_unlock_spec
                          (mkPtr "stack_s_rtt_walk" 0)
                          (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                          ret_2
                          ret_3
                          v_1
                          v_2
                          ((st.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                ((v_0 + ((- MEM0_PHYS))) >> (12))
                                ((((sh_0.(globals)).(g_granules)) #
                                  (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                  ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                              (((EVT
                                CPU_ID
                                (REL
                                  (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                                  ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    (Some CPU_ID)))) ::
                                (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                  ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                    (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))))).[share] :<
                            (sh_0.[globals].[g_granules] :<
                              ((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) #
                                ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                                (((((sh_0.(globals)).(g_granules)) #
                                  (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                  ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                    None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                  None))))));
                    rely ((((st_12.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                    rely ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                    if (((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                    then (
                      rely (
                        ((((("granules" = ("granules")) /\ ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                          ((6 >= (0)))) /\
                          ((6 <= (24)))));
                      when ret_5 == ((granule_addr_spec' (mkPtr "granules" ((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                      when ret_6 == ((buffer_map_spec' 6 ret_5 false));
                      rely ((((ret_6.(pbase)) = ("granule_data")) /\ (((ret_6.(poffset)) >= (0)))));
                      when v_42, st_17 == ((__tte_read_spec (mkPtr (ret_6.(pbase)) ((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_12));
                      rely ((((st_17.(share)).(granule_data)) = (((st_12.(share)).(granule_data)))));
                      if ((v_42 & (63)) =? (0))
                      then (
                        when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                        rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                        when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_17.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                              ((st_17.(log))))).[share].[globals].[g_granules] :<
                            ((((st_17.(share)).(globals)).(g_granules)) #
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_17.(share)).(granule_data)) #
                              (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        )))
                      else (
                        if ((v_42 & (63)) =? (8))
                        then (
                          when ret_7 == ((s2tte_create_valid_ns_spec' v_3 v_2));
                          rely ((((ret_6.(pbase)) = ("granule_data")) /\ ((((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                    ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                  ((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              (((st_17.(share)).(granule_data)) #
                                (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_17.(share)).(granule_data)) @ (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_6.(poffset)) + ((8 * ((((st_12.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7))))
                          )))
                        else (
                          when cid_0 == (((((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            9  ,
                            ((st_17.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_17.(log))))).[share].[globals].[g_granules] :<
                              ((((st_17.(share)).(globals)).(g_granules)) #
                                (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_17.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          )))))
                    else (
                      when cid_0 == (((((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        ((((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                          ((((((st_12.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                        ((st_12.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_12.(log))))).[share].[globals].[g_granules] :<
                          ((((st_12.(share)).(globals)).(g_granules)) #
                            (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_12.(share)).(globals)).(g_granules)) @ (((((st_12.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                | (Some cid) => None
                end))
            else (
              when sh_0 == (
                  ((st.(repl))
                    ((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log)))))))
                    (sh.[globals].[g_granules] :<
                      (((sh.(globals)).(g_granules)) #
                        ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                        ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))))));
              match ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val))) with
              | None =>
                rely (
                  (((((((sh.(globals)).(g_granules)) #
                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID))) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)))) =
                    (0)));
                rely (
                  ((("granules" = ("granules")) /\ ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) mod (16)) = (0)))) /\
                    ((((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                if (
                  ((((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).(e_state_s_granule)) -
                    (5)) =?
                    (0)))
                then (
                  when cid == ((((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                  when st_11 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) (((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                            (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                              ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))).[share] :<
                          (sh_0.[globals].[g_granules] :<
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                (Some CPU_ID))) #
                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                              ((((sh_0.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))));
                  rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                    rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                    when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                    if ret_6
                    then (
                      when ret_7 == ((s2tte_create_ripas_spec' 1));
                      rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                      if (v_2 =? (3))
                      then (
                        match (
                          (stage2_tlbi_ipa_loop210
                            (z_to_nat 0)
                            false
                            v_1
                            4096
                            (((st_16.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< ((((st_16.(stack)).(stack_s_realm_s2_context)).(e_vmid)) << (48))).[share].[globals].[g_granules] :<
                              ((((st_16.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_16.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7)))))
                        ) with
                        | (Some (__break__, v__13, v__912, st_4)) =>
                          when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_4.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_4.(log))))).[priv].[pcpu_regs].[pcpu_vttbr_el2] :<
                              (((st_16.(priv)).(pcpu_regs)).(pcpu_vttbr_el2))).[share].[globals].[g_granules] :<
                              ((((st_4.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          ))
                        | None => None
                        end)
                      else (
                        when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_16.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                              ((st_16.(log))))).[share].[globals].[g_granules] :<
                            ((((st_16.(share)).(globals)).(g_granules)) #
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        ))))
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        9  ,
                        ((st_16.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_16.(log))))).[share].[globals].[g_granules] :<
                          ((((st_16.(share)).(globals)).(g_granules)) #
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                  else (
                    when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st_11.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_11.(log))))).[share].[globals].[g_granules] :<
                        ((((st_11.(share)).(globals)).(g_granules)) #
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
                else (
                  when cid == (
                      ((((((sh_0.(globals)).(g_granules)) #
                        (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                        ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                          None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).(e_lock)).(e_val)));
                  when st_11 == (
                      (rtt_walk_lock_unlock_spec
                        (mkPtr "stack_s_rtt_walk" 0)
                        (mkPtr "granules" ((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)))
                        ret_2
                        ret_3
                        v_1
                        v_2
                        ((st.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              ((v_0 + ((- MEM0_PHYS))) >> (12))
                              ((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))))) ::
                            (((EVT
                              CPU_ID
                              (REL
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  (Some CPU_ID)))) ::
                              (((EVT CPU_ID (ACQ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)))) ::
                                ((((st.(oracle)) ((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))) ++
                                  (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))))))))).[share] :<
                          (sh_0.[globals].[g_granules] :<
                            ((((sh_0.(globals)).(g_granules)) #
                              (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                              ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                None)) #
                              ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                              (((((sh_0.(globals)).(g_granules)) #
                                (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16)) ==
                                ((((sh_0.(globals)).(g_granules)) @ (((((((sh.(granule_data)) @ ((ret_0.(poffset)) / (4096))).(g_rd)).(e_s2_ctx)).(e_g_rtt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :<
                                  None)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :<
                                None))))));
                  rely ((((st_11.(share)).(granule_data)) = ((sh_0.(granule_data)))));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)));
                  rely ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (MEM0_VIRT)) < (0)));
                  if (((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) - (v_2)) =? (0))
                  then (
                    rely (
                      ((((("granules" = ("granules")) /\ ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) mod (16)) = (0)))) /\
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))) /\
                        ((6 >= (0)))) /\
                        ((6 <= (24)))));
                    when ret_4 == ((granule_addr_spec' (mkPtr "granules" ((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)))));
                    when ret_5 == ((buffer_map_spec' 6 ret_4 false));
                    rely ((((ret_5.(pbase)) = ("granule_data")) /\ (((ret_5.(poffset)) >= (0)))));
                    when v_42, st_16 == ((__tte_read_spec (mkPtr (ret_5.(pbase)) ((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk))))))) st_11));
                    rely ((((st_16.(share)).(granule_data)) = (((st_11.(share)).(granule_data)))));
                    when ret_6 == ((s2tte_is_valid_ns_spec' v_42 v_2));
                    if ret_6
                    then (
                      when ret_7 == ((s2tte_create_ripas_spec' 1));
                      rely ((((ret_5.(pbase)) = ("granule_data")) /\ ((((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) >= (0)))));
                      if (v_2 =? (3))
                      then (
                        match (
                          (stage2_tlbi_ipa_loop210
                            (z_to_nat 0)
                            false
                            v_1
                            4096
                            (((st_16.[priv].[pcpu_regs].[pcpu_vttbr_el2] :< ((((st_16.(stack)).(stack_s_realm_s2_context)).(e_vmid)) << (48))).[share].[globals].[g_granules] :<
                              ((((st_16.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_16.(share)).(granule_data)) #
                                (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                                ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                  (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                    (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                    ret_7)))))
                        ) with
                        | (Some (__break__, v__13, v__912, st_4)) =>
                          when cid_0 == (((((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                          (Some (
                            0  ,
                            (((st_4.[log] :<
                              ((EVT
                                CPU_ID
                                (REL
                                  (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                  ((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                                ((st_4.(log))))).[priv].[pcpu_regs].[pcpu_vttbr_el2] :<
                              (((st_16.(priv)).(pcpu_regs)).(pcpu_vttbr_el2))).[share].[globals].[g_granules] :<
                              ((((st_4.(share)).(globals)).(g_granules)) #
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                                (((((st_4.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                          ))
                        | None => None
                        end)
                      else (
                        when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                        (Some (
                          0  ,
                          (((st_16.[log] :<
                            ((EVT
                              CPU_ID
                              (REL
                                (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                                (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_ref] :<
                                  ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))) ::
                              ((st_16.(log))))).[share].[globals].[g_granules] :<
                            ((((st_16.(share)).(globals)).(g_granules)) #
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                              ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None).[e_ref] :<
                                ((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_16.(share)).(granule_data)) #
                              (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096)) ==
                              ((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).[g_norm] :<
                                (((((st_16.(share)).(granule_data)) @ (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) / (4096))).(g_norm)) #
                                  (((ret_5.(poffset)) + ((8 * ((((st_11.(stack)).(stack_s_rtt_walk)).(e_index_s_rtt_walk)))))) mod (4096)) ==
                                  ret_7))))
                        ))))
                    else (
                      when cid_0 == (((((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                      (Some (
                        9  ,
                        ((st_16.[log] :<
                          ((EVT
                            CPU_ID
                            (REL
                              (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                              ((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                            ((st_16.(log))))).[share].[globals].[g_granules] :<
                          ((((st_16.(share)).(globals)).(g_granules)) #
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                            (((((st_16.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                      ))))
                  else (
                    when cid_0 == (((((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).(e_lock)).(e_val)));
                    (Some (
                      ((((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8)) >> (24)) & (4294967040)) |'
                        ((((((st_11.(stack)).(stack_s_rtt_walk)).(e_last_level)) << (32)) + (8))))  ,
                      ((st_11.[log] :<
                        ((EVT
                          CPU_ID
                          (REL
                            (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))
                            ((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))))) ::
                          ((st_11.(log))))).[share].[globals].[g_granules] :<
                        ((((st_11.(share)).(globals)).(g_granules)) #
                          (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16)) ==
                          (((((st_11.(share)).(globals)).(g_granules)) @ (((((st_11.(stack)).(stack_s_rtt_walk)).(e_g_llt)) - (GRANULES_BASE)) / (16))).[e_lock].[e_val] :< None)))
                    ))))
              | (Some cid) => None
              end))
          else (
            (Some (
              (((((((ret_1 >> (32)) + (2)) << (32)) + (ret_1)) >> (24)) & (4294967040)) |' (((((ret_1 >> (32)) + (2)) << (32)) + (ret_1))))  ,
              ((st.[log] :<
                ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
                (sh.[globals].[g_granules] :<
                  (((sh.(globals)).(g_granules)) #
                    ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                    ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
            ))))
        else (
          (Some (
            4294967553  ,
            ((st.[log] :<
              ((EVT CPU_ID (REL ((v_0 + ((- MEM0_PHYS))) >> (12)) ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((v_0 + ((- MEM0_PHYS))) >> (12)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              (sh.[globals].[g_granules] :<
                (((sh.(globals)).(g_granules)) #
                  ((v_0 + ((- MEM0_PHYS))) >> (12)) ==
                  ((((sh.(globals)).(g_granules)) @ ((v_0 + ((- MEM0_PHYS))) >> (12))).[e_lock].[e_val] :< None))))
          )))
      | (Some cid) => None
      end).

  Definition validate_rtt_entry_cmds_spec' (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_2.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_2.(pbase)) = ("granule_data")) /\ (((v_2.(poffset)) >= (0)))) /\ ((((v_2.(poffset)) mod (4096)) = (0)))));
    when ret, st' == ((realm_rtt_starting_level_spec' v_2 st));
    if ((v_1 >? (3)) || (((ret - (v_1)) >? (0))))
    then (Some (4294967297, st))
    else (
      when ret_0, st'_0 == ((validate_map_addr_spec' v_0 v_1 v_2 st));
      (Some (ret_0, st))).

  Definition validate_rtt_entry_cmds_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((validate_rtt_entry_cmds_spec' v_0 v_1 v_2 st));
    (Some (ret, st)).
  (* Definition validate_rtt_entry_cmds_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_4, st_0 == ((realm_rtt_starting_level_spec v_2 st));
    if ((v_1 >? (3)) || (((v_4 - (v_1)) >? (0))))
    then (
      when v_9, st_1 == ((make_return_code_spec 1 1 st_0));
      (Some (v_9, st_1)))
    else (
      when v_11, st_1 == ((validate_map_addr_spec v_0 v_1 v_2 st_0));
      (Some (v_11, st_1))). *)

  Definition host_ns_s2tte_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((addr_level_mask_spec (- 1) v_1 st));
    (Some (((v_3 |' (1020)) & (v_0)), st_0)).

  Definition validate_ns_struct_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Ptr * RData)) :=
    if ((v_0 & (15)) =? (0))
    then (
      when v_10, st_0 == ((find_granule_spec (v_0 & (18446744073709547520)) st));
      rely ((((v_10.(pbase)) = ("granules")) \/ (((v_10.(pbase)) = ("null")))));
      when v_12, st_1 == ((find_granule_spec (((v_0 + ((- 1))) + (v_1)) & (18446744073709547520)) st_0));
      rely ((((v_12.(pbase)) = ("granules")) \/ (((v_12.(pbase)) = ("null")))));
      if (ptr_eqb v_10 v_12)
      then (Some (v_10, st_1))
      else (Some ((mkPtr "null" 0), st_1)))
    else (Some ((mkPtr "null" 0), st)).

  Definition validate_realm_params_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 56) st));
    if (v_3 =? (0))
    then (
      when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 0) st_0));
      if ((v_7 & (4095)) =? (0))
      then (
        when v_12, st_2 == ((load_RData 8 (ptr_offset v_0 8) st_1));
        if ((v_12 & (4095)) =? (0))
        then (
          when v_19, st_3 == ((load_RData 8 (ptr_offset v_0 32) st_2));
          when v_20, st_4 == ((validate_rmm_feature_register_value_spec 0 v_19 st_3));
          if v_20
          then (
            when v_24, st_5 == ((requested_ipa_bits_spec v_0 st_4));
            when v_26, st_6 == ((load_RData 8 (ptr_offset v_0 40) st_5));
            when v_27, st_7 == ((validate_ipa_bits_and_sl_spec v_24 v_26 st_6));
            if (v_27 =? (0))
            then (
              when v_31, st_8 == ((requested_ipa_bits_spec v_0 st_7));
              when v_32, st_9 == ((load_RData 8 (ptr_offset v_0 40) st_8));
              when v_34, st_10 == ((s2_num_root_rtts_spec v_31 v_32 st_9));
              when v_36, st_11 == ((load_RData 4 (ptr_offset v_0 48) st_10));
              if ((v_34 - (v_36)) =? (0))
              then (
                when v_40, st_12 == ((requested_ipa_bits_spec v_0 st_11));
                when v_41, st_13 == ((load_RData 8 (ptr_offset v_0 0) st_12));
                when v_42, st_14 == ((load_RData 8 (ptr_offset v_0 8) st_13));
                if (((v_42 + (v_41)) - (v_41)) >? (0))
                then (
                  if (((v_42 + (v_41)) >> (v_40)) =? (0))
                  then (
                    when v_50, st_15 == ((load_RData 8 (ptr_offset v_0 24) st_14));
                    if ((v_50 =? (0)) || ((v_50 =? (1))))
                    then (
                      when v_55, st_17 == ((load_RData 4 (ptr_offset v_0 52) st_15));
                      when v_56, st_18 == ((vmid_reserve_spec v_55 st_17));
                      if v_56
                      then (Some (0, st_18))
                      else (
                        when v_58, st_19 == ((pack_return_code_spec 2 7 st_18));
                        (Some (v_58, st_19))))
                    else (
                      when v_52, st_16 == ((pack_return_code_spec 2 3 st_15));
                      (Some (v_52, st_16))))
                  else (
                    when v_47, st_16 == ((pack_return_code_spec 2 0 st_14));
                    (Some (v_47, st_16))))
                else (
                  when v_47, st_16 == ((pack_return_code_spec 2 0 st_14));
                  (Some (v_47, st_16))))
              else (
                when v_38, st_12 == ((pack_return_code_spec 2 6 st_11));
                (Some (v_38, st_12))))
            else (
              when v_29, st_8 == ((pack_struct_return_code_spec v_27 st_7));
              (Some (v_29, st_8))))
          else (
            when v_22, st_5 == ((pack_return_code_spec 2 0 st_4));
            (Some (v_22, st_5))))
        else (
          when v_16, st_4 == ((pack_return_code_spec 2 0 st_2));
          (Some (v_16, st_4))))
      else (
        when v_16, st_3 == ((pack_return_code_spec 2 0 st_1));
        (Some (v_16, st_3))))
    else (Some (0, st_0)).

  Fixpoint find_lock_transition_rtts_loop209 (_N_: nat) (__return__: bool) (__retval__: Z) (__break__: bool) (v_0: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Z * bool * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__return__, __retval__, __break__, v_0, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((find_lock_transition_rtts_loop209 _N__0 __return__ __retval__ __break__ v_0 v_indvars_iv v_wide_trip_count st)) with
      | (Some (__return___0, __retval___0, __break___0, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (__return___0, __retval___0, true, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          if __return___0
          then (Some (true, __retval___0, false, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_0))
          else (
            when v_7, st_1 == ((find_lock_granule_spec ((v_indvars_iv_0 * (4096)) + (v_1)) 1 st_0));
            rely (((((v_7.(poffset)) mod (16)) = (0)) /\ (((v_7.(poffset)) >= (0)))));
            rely ((((v_7.(pbase)) = ("granules")) \/ (((v_7.(pbase)) = ("null")))));
            if (ptr_eqb v_7 (mkPtr "null" 0))
            then (
              when v_10, st_2 == ((find_granule_spec v_1 st_1));
              rely ((((v_10.(pbase)) = ("granules")) \/ (((v_10.(pbase)) = ("null")))));
              when st_3 == ((free_sl_rtts_spec v_10 v_indvars_iv_0 false st_2));
              when v_11, st_4 == ((make_return_code_spec 2 1 st_3));
              (Some (true, v_11, false, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_4)))
            else (
              when v_13, st_3 == ((granule_map_spec v_7 1 st_1));
              when st_4 == ((s2tt_init_unassigned_spec v_13 1 st_3));
              when st_5 == ((granule_unlock_transition_spec v_7 5 st_4));
              if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
              then (Some (false, __retval___0, false, v_1, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_5))
              else (Some (false, __retval___0, true, v_1, v_indvars_iv_0, v_wide_trip_count_0, st_5)))))
      | None => None
      end
    end.

  Definition find_lock_transition_rtts_spec (v_0: Z) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((0 - (v_1)) <? (0))
    then (
      rely (((find_lock_transition_rtts_loop209_rank v_0 0 v_1) >= (0)));
      match (
        match ((find_lock_transition_rtts_loop209 (z_to_nat (find_lock_transition_rtts_loop209_rank v_0 0 v_1)) false 0 false v_0 0 v_1 st)) with
        | (Some (__return___0, __retval___0, __break__, v_2, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some (__return___0, __retval___0, st_0))
        | None => None
        end
      ) with
      | (Some (__return__, __retval__, st_0)) =>
        if __return__
        then (Some (__retval__, st_0))
        else (
          when v_16, st_1 == ((make_return_code_spec 0 0 st_0));
          (Some (v_16, st_1)))
      | None => None
      end)
    else (
      when v_16, st_1 == ((make_return_code_spec 0 0 st));
      (Some (v_16, st_1))).

  Definition get_realm_params_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_4, st_0 == ((find_granule_spec (v_1 & (18446744073709547520)) st));
    rely ((((v_4.(pbase)) = ("granules")) \/ (((v_4.(pbase)) = ("null")))));
    if (ptr_eqb v_4 (mkPtr "null" 0))
    then (Some (false, st_0))
    else (
      when v_8, st_1 == ((ns_buffer_read_spec 0 v_1 64 v_0 st_0));
      when st_2 == ((ns_buffer_unmap_spec 0 st_1));
      (Some (v_8, st_2))).

  Definition set_rd_rec_count_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((__sca_write64_release_spec (ptr_offset v_0 8) v_1 st));
    (Some st_0).

    Definition smc_rc_rtt_read_entry_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option RData) :=
      rely (((v_3.(pbase)) = ("stack_s_smc_result")));
      rely (((v_3.(poffset)) = (0)));
      when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st));
      if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (3)) =? (0))
      then (
        rely ((((((test_PA v_0).(meta_granule_offset)) mod (4096)) = (0)) /\ ((((test_PA v_0).(meta_granule_offset)) >= (0)))));
        if (check_ttbr01 (test_PA v_1))
        then (
          rely (
            (((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(pbase)) =
              ("granules")));
          rely (
            ((((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(poffset)) mod
              (4096)) =
              (0)));
          rely (
            (((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(poffset)) >=
              (0)));
          when st_2 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(pbase))
                  ((test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(poffset)))
                st_1));
          if (
            (((((((st_2.(share)).(globals)).(g_granules)) @
              (((test_Z_Ptr
                (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(poffset)) /
                (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            when rtt_ret, st_6 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "null" 0)
                  (test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096))))
                  0
                  64
                  v_1
                  v_2
                  st_2));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_5.[stack].[stack_s_smc_result] :< (((st_5.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_5.[stack].[stack_s_smc_result] :< (((st_5.(stack)).(stack_s_smc_result)).[e_x0] :< 0)))))
          else (
            when st_3 == (
                (spinlock_release_spec
                  (mkPtr
                    ((test_Z_Ptr
                      (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(pbase))
                    ((test_Z_Ptr
                      (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096)))).(poffset)))
                  st_2));
            when rtt_ret, st_6 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "null" 0)
                  (test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1536)) mod (4096))))
                  0
                  64
                  v_1
                  v_2
                  st_3));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_7 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_7.[stack].[stack_s_smc_result] :< (((st_7.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_7 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_7.[stack].[stack_s_smc_result] :< (((st_7.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))))
        else (
          rely (
            (((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(pbase)) =
              ("granules")));
          rely (
            ((((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)) mod
              (4096)) =
              (0)));
          rely (
            (((test_Z_Ptr
              (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)) >=
              (0)));
          when st_2 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(pbase))
                  ((test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)))
                st_1));
          if (
            (((((((st_2.(share)).(globals)).(g_granules)) @
              (((test_Z_Ptr
                (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)) /
                (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            when rtt_ret, st_6 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "null" 0)
                  (test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096))))
                  0
                  64
                  v_1
                  v_2
                  st_2));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_5.[stack].[stack_s_smc_result] :< (((st_5.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_5 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_5.[stack].[stack_s_smc_result] :< (((st_5.(stack)).(stack_s_smc_result)).[e_x0] :< 0)))))
          else (
            when st_3 == (
                (spinlock_release_spec
                  (mkPtr
                    ((test_Z_Ptr
                      (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(pbase))
                    ((test_Z_Ptr
                      (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096)))).(poffset)))
                  st_2));
            when rtt_ret, st_6 == (
                (rtt_walk_lock_unlock_spec_abs
                  (mkPtr "null" 0)
                  (test_Z_Ptr
                    (((((st_1.(share)).(granule_data)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) / (4096))).(g_norm)) @ ((((test_PA v_0).(meta_granule_offset)) + (1544)) mod (4096))))
                  0
                  64
                  v_1
                  v_2
                  st_3));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_7 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_7.[stack].[stack_s_smc_result] :< (((st_7.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_7 == (
                  (granule_unlock_spec
                    (mkPtr "granules" ((test_PA v_0).(meta_granule_offset)))
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_7.[stack].[stack_s_smc_result] :< (((st_7.(stack)).(stack_s_smc_result)).[e_x0] :< 0)))))))
      else (
        when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0).(meta_granule_offset))) st_1));
        if (check_ttbr01 (test_PA v_1))
        then (
          rely ((((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(pbase)) = ("granules")));
          rely (((((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(poffset)) mod (4096)) = (0)));
          rely ((((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(poffset)) >= (0)));
          when st_3 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(pbase))
                  ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(poffset)))
                (st_2.[stack].[stack_s_smc_result] :< (((st_2.(stack)).(stack_s_smc_result)).[e_x0] :< (pack_struct_return_code_para (make_return_code_para 1))))));
          if (
            (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(poffset)) / (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            when rtt_ret, st_6 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "null" 0) (test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)) 0 64 v_1 v_2 st_3));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0)))))
          else (
            when st_4 == (
                (spinlock_release_spec
                  (mkPtr
                    ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(pbase))
                    ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)).(poffset)))
                  st_3));
            when rtt_ret, st_6 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "null" 0) (test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1536)) 0 64 v_1 v_2 st_4));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))))
        else (
          rely ((((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(pbase)) = ("granules")));
          rely (((((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(poffset)) mod (4096)) = (0)));
          rely ((((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(poffset)) >= (0)));
          when st_3 == (
              (spinlock_acquire_spec
                (mkPtr
                  ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(pbase))
                  ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(poffset)))
                (st_2.[stack].[stack_s_smc_result] :< (((st_2.(stack)).(stack_s_smc_result)).[e_x0] :< (pack_struct_return_code_para (make_return_code_para 1))))));
          if (
            (((((((st_3.(share)).(globals)).(g_granules)) @ (((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(poffset)) / (4096))).(e_state_s_granule)) -
              (5)) =?
              (0)))
          then (
            when rtt_ret, st_6 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "null" 0) (test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)) 0 64 v_1 v_2 st_3));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0)))))
          else (
            when st_4 == (
                (spinlock_release_spec
                  (mkPtr
                    ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(pbase))
                    ((test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)).(poffset)))
                  st_3));
            when rtt_ret, st_6 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "null" 0) (test_Z_Ptr (((((st_2.(share)).(granule_data)) @ 0).(g_norm)) @ 1544)) 0 64 v_1 v_2 st_4));
            if (((rtt_ret.(e_1)) - (v_2)) =? (0))
            then (
              when st_13 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_13.[stack].[stack_s_smc_result] :<
                      (((st_13.(stack)).(stack_s_smc_result)).[e_x3] :<
                        (test_PTE_Z (abs_tte_read (mkPtr "granule_data" (((rtt_ret.(e_2)).(poffset)) + ((8 * ((rtt_ret.(e_3))))))) st_6))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))
            else (
              when st_11 == ((granule_unlock_spec (rtt_ret.(e_2)) st_6));
              when st_9 == (
                  (granule_unlock_spec
                    (mkPtr "null" 0)
                    (st_11.[stack].[stack_s_smc_result] :< (((st_11.(stack)).(stack_s_smc_result)).[e_x3] :< (pack_struct_return_code_para (make_return_code_para 8))))));
              (Some (st_9.[stack].[stack_s_smc_result] :< (((st_9.(stack)).(stack_s_smc_result)).[e_x0] :< 0))))))).

End Layer12_Spec.

(* #[global] Hint Unfold : spec. *)
#[global] Hint Unfold vmid_free_spec: spec.
#[global] Hint Unfold total_root_rtt_refcount_loop295: spec.
#[global] Hint Unfold total_root_rtt_refcount_spec: spec.
#[global] Hint Unfold measurement_finish_spec: spec.
#[global] Hint Unfold atomic_granule_put_release_spec: spec.
#[global] Hint Unfold ns_buffer_write_spec: spec.
#[global] Hint Unfold get_rd_state_unlocked_spec: spec.
#[global] Hint Unfold copy_gic_state_from_ns_loop48: spec.
#[global] Hint Unfold copy_gic_state_from_ns_spec: spec.
#[global] Hint Unfold copy_gic_state_to_ns_loop59: spec.
#[global] Hint Unfold copy_gic_state_to_ns_spec: spec.
#[global] Hint Unfold complete_sysreg_emulation_spec: spec.
#[global] Hint Unfold complete_hvc_exit_spec: spec.
#[global] Hint Unfold process_disposed_info_spec: spec.
#[global] Hint Unfold complete_mmio_emulation_spec: spec.
#[global] Hint Unfold host_ns_s2tte_is_valid_spec: spec.
#[global] Hint Unfold __granule_refcount_dec_spec: spec.
#[global] Hint Unfold s2tt_init_valid_loop820: spec.
#[global] Hint Unfold s2tt_init_valid_spec: spec.
#[global] Hint Unfold __granule_refcount_inc_spec: spec.
#[global] Hint Unfold s2tt_init_valid_ns_loop839: spec.
#[global] Hint Unfold s2tt_init_valid_ns_spec: spec.
#[global] Hint Unfold s2tt_init_destroyed_loop776: spec.
#[global] Hint Unfold s2tt_init_destroyed_loop776_0: spec.
#[global] Hint Unfold s2tt_init_destroyed_spec: spec.
#[global] Hint Unfold validate_rtt_structure_cmds_spec: spec.
#[global] Hint Unfold s2tt_init_assigned_loop801: spec.
#[global] Hint Unfold s2tt_init_assigned_spec: spec.
#[global] Hint Unfold get_cntfrq_spec: spec.
#[global] Hint Unfold gic_cpu_state_init_spec: spec.
#[global] Hint Unfold vmpidr_is_valid_spec: spec.
#[global] Hint Unfold get_rd_rec_count_locked_spec: spec.
#[global] Hint Unfold find_lock_unused_granule_spec: spec.
#[global] Hint Unfold ptr_is_err_spec: spec.
#[global] Hint Unfold ptr_status_spec: spec.
#[global] Hint Unfold data_create_spec: spec.
#[global] Hint Unfold map_unmap_ns_spec: spec.
#[global] Hint Unfold validate_rtt_entry_cmds_spec: spec.
#[global] Hint Unfold host_ns_s2tte_spec: spec.
#[global] Hint Unfold validate_ns_struct_spec: spec.
#[global] Hint Unfold validate_realm_params_spec: spec.
#[global] Hint Unfold find_lock_transition_rtts_loop209: spec.
#[global] Hint Unfold find_lock_transition_rtts_spec: spec.
#[global] Hint Unfold get_realm_params_spec: spec.
#[global] Hint Unfold set_rd_rec_count_spec: spec.
