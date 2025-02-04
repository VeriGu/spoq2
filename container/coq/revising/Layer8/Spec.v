Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Layer8.map_unmap_ns_s1.LowSpec.
Require Import Layer8.rsi_memory_dispose.LowSpec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer8_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition realm_ipa_size_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_RD)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when ret, st' == ((realm_ipa_bits_spec v_0 st));
    if (ret =? (64))
    then (Some ((1 << (64)), st))
    else (Some ((1 << (ret)), st)).

  Definition max_pa_size_spec' (st: RData) : (option (Z * RData)) :=
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (6))
    then (Some (48, st))
    else (
      if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (0))
      then (Some (32, st))
      else (
        if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (1))
        then (Some (36, st))
        else (
          if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (2))
          then (Some (40, st))
          else (
            if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (3))
            then (Some (42, st))
            else (
              if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (4))
              then (Some (44, st))
              else (
                if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr0_el1)) & (15)) =? (5))
                then (Some (48, st))
                else (Some (0, st)))))))).
  Definition max_pa_size_spec (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((max_pa_size_spec' st));
    (Some (ret, st)).
  (* Definition max_pa_size_spec (st: RData) : (option (Z * RData)) :=
    when v_1, st_0 == ((iasm_74_spec st));
    if ((v_1 & (15)) =? (6))
    then (Some (48, st_0))
    else (
      if ((v_1 & (15)) =? (0))
      then (Some (32, st_0))
      else (
        if ((v_1 & (15)) =? (1))
        then (Some (36, st_0))
        else (
          if ((v_1 & (15)) =? (2))
          then (Some (40, st_0))
          else (
            if ((v_1 & (15)) =? (3))
            then (Some (42, st_0))
            else (
              if ((v_1 & (15)) =? (4))
              then (Some (44, st_0))
              else (
                if ((v_1 & (15)) =? (5))
                then (Some (48, st_0))
                else (Some (0, st_0)))))))). *)

  Definition addr_is_level_aligned_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_3, st_0 == ((addr_level_mask_spec v_0 v_1 st));
    (Some (((v_3 - (v_0)) =? (0)), st_0)).

  Definition s1addr_is_level_aligned_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    when v_3, st_0 == ((s1addr_level_mask_spec v_0 v_1 st));
    (Some (((v_3 - (v_0)) =? (0)), st_0)).

  Definition range_intersects_par_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_5, st_0 == ((load_RData 8 (ptr_offset v_0 920) st));
    when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 928) st_0));
    when v_8, st_2 == ((ranges_intersect_spec v_5 v_7 v_1 v_2 st_1));
    (Some (v_8, st_2)).

  Definition emulate_sysreg_access_ns_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_s_rec_exit")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    if ((v_2 & (1)) =? (0))
    then (
      when v_6, st_0 == ((get_sysreg_write_value_spec v_0 v_2 st));
      when st_1 == ((store_RData 8 (ptr_offset v_1 32) v_6 st_0));
      (Some st_1))
    else (Some st).

  Definition esr_is_write_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_0 & (64)) <>? (0)), st)).

  Definition access_len_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((esr_sas_spec v_0 st));
    if (v_2 =? (3))
    then (Some (8, st_0))
    else (
      if (v_2 =? (0))
      then (Some (1, st_0))
      else (
        if (v_2 =? (1))
        then (Some (2, st_0))
        else (
          if (v_2 =? (2))
          then (Some (4, st_0))
          else (Some (0, st_0))))).

  Definition fixup_aarch32_data_abort_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_type_3")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3, st_0 == ((iasm_get_spsr_el2_spec st));
    if ((v_3 & (16)) =? (0))
    then (Some st_0)
    else (
      when v_6, st_1 == ((load_RData 8 v_1 st_0));
      when st_2 == ((store_RData 8 v_1 (v_6 & (18446744073692774399)) st_1));
      (Some st_2)).

  Definition get_dabt_write_value_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_3, st_0 == ((esr_srt_spec v_1 st));
    if (v_3 =? (31))
    then (Some (0, st_0))
    else (
      rely ((((0 - (v_3)) <= (0)) /\ ((v_3 < (31)))));
      when v_9, st_1 == ((load_RData 8 (ptr_offset v_0 (24 + ((8 * (v_3))))) st_0));
      when v_10, st_2 == ((access_mask_spec v_1 st_1));
      (Some ((v_10 & (v_9)), st_2))).

  Definition emulate_stage2_data_abort_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (st: RData) : (option RData) :=
    rely ((((v_1.(pbase)) = ("stack_s_rec_exit")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_5, st_0 == ((load_RData 8 (ptr_offset v_0 32) st));
    when st_1 == ((store_RData 8 (ptr_offset v_1 8) ((v_2 + (4)) |' (2415919104)) st_0));
    when st_2 == ((store_RData 8 (ptr_offset v_1 16) 0 st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_1 24) (v_5 >> (8)) st_2));
    when st_4 == ((store_RData 8 (ptr_offset v_1 32) 0 st_3));
    when v_13, st_5 == ((iasm_get_elr_el2_spec st_4));
    when st_6 == ((iasm_set_elr_el2_spec (v_13 + ((- 4))) st_5));
    (Some st_6).

  Definition psci_rsi_spec (v_0: Ptr) (v_1: Ptr) (v_2: Z) (v_3: Z) (v_4: Z) (v_5: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_1.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_1.(pbase)) = ("granule_data")) /\ (((v_1.(poffset)) >= (0)))) /\ ((((v_1.(poffset)) mod (4096)) = (0)))));
    rely ((((v_0.(pbase)) = ("stack_s_psci_result")) /\ (((v_0.(poffset)) = (0)))));
    if (
      (((((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522)))) ||
        (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))))) ||
        (((v_2 =? (2214592515)) || ((v_2 =? (3288334339)))))))
    then (
      if (
        ((((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522)))) ||
          (((v_2 =? (2214592513)) || ((v_2 =? (3288334337)))))))
      then (
        if (((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521)))) || ((v_2 =? (2214592522))))
        then (
          if ((((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520)))) || ((v_2 =? (2214592521))))
          then (
            if (((v_2 =? (2214592512)) || ((v_2 =? (2214592514)))) || ((v_2 =? (2214592520))))
            then (
              if ((v_2 =? (2214592512)) || ((v_2 =? (2214592514))))
              then (
                if (v_2 =? (2214592512))
                then (
                  when st_0 == ((store_RData 8 (ptr_offset v_0 32) (- 1) st));
                  when st_1 == ((store_RData 1 (ptr_offset v_0 0) 0 st_0));
                  (Some st_1))
                else (
                  when st_0 == ((psci_version_spec v_0 v_1 st));
                  (Some st_0)))
              else (
                when st_0 == ((psci_cpu_off_spec v_0 v_1 st));
                (Some st_0)))
            else (
              when st_0 == ((psci_system_off_spec v_0 v_1 st));
              (Some st_0)))
          else (
            when st_0 == ((psci_system_reset_spec v_0 v_1 st));
            (Some st_0)))
        else (
          when st_0 == ((psci_features_spec v_0 v_1 v_3 st));
          (Some st_0)))
      else (
        when st_1 == ((psci_cpu_suspend_spec v_0 v_1 v_3 v_4 st));
        (Some st_1)))
    else (
      if ((v_2 =? (2214592516)) || ((v_2 =? (3288334340))))
      then (
        when st_1 == ((psci_affinity_info_spec v_0 v_1 (v_3 & (4294967295)) (v_4 & (4294967295)) st));
        (Some st_1))
      else (
        when st_1 == ((psci_affinity_info_spec v_0 v_1 v_3 v_4 st));
        (Some st_1))).

  Definition handle_rsi_realm_extend_measurement_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "handle_rsi_realm_extend_measurement" st));
    rely (((((((st_0.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_4_tmp, st_1 == ((load_RData 8 (ptr_offset v_0 944) st_0));
    when st_2 == ((granule_lock_spec (int_to_ptr v_4_tmp) 2 st_1));
    when v_5_tmp, st_3 == ((load_RData 8 (ptr_offset v_0 944) st_2));
    when v_6, st_4 == ((granule_map_spec (int_to_ptr v_5_tmp) 2 st_3));
    when v_8, st_5 == ((load_RData 8 (ptr_offset v_0 32) st_4));
    if (((v_8 + ((- 7))) - ((- 6))) <? (0))
    then (
      when v_13, st_6 == ((pack_return_code_spec 1 1 st_5));
      when v_33_tmp, st_8 == ((load_RData 8 (ptr_offset v_0 944) st_6));
      when st_9 == ((granule_unlock_spec (int_to_ptr v_33_tmp) st_8));
      when st_10 == ((free_stack "handle_rsi_realm_extend_measurement" st_0 st_9));
      (Some (v_13, st_10)))
    else (
      when v_16, st_6 == ((load_RData 8 (ptr_offset v_0 40) st_5));
      if (v_16 >? (64))
      then (
        when v_19, st_7 == ((pack_return_code_spec 1 2 st_6));
        when v_33_tmp, st_10 == ((load_RData 8 (ptr_offset v_0 944) st_7));
        when st_11 == ((granule_unlock_spec (int_to_ptr v_33_tmp) st_10));
        when st_12 == ((free_stack "handle_rsi_realm_extend_measurement" st_0 st_11));
        (Some (v_19, st_12)))
      else (
        rely ((((0 - ((v_8 & (4294967295)))) <= (0)) /\ (((v_8 & (4294967295)) < (7)))));
        when v_29, st_7 == ((memcpy_spec (ptr_offset (mkPtr "stack_type_8" 0) 0) (ptr_offset (ptr_offset v_6 184) (32 * ((v_8 & (4294967295))))) 32 st_6));
        when v_31, st_8 == ((memcpy_spec (ptr_offset (mkPtr "stack_type_8" 0) 32) (ptr_offset v_0 48) v_16 st_7));
        when v_33_tmp, st_11 == ((load_RData 8 (ptr_offset v_0 944) st_8));
        when st_12 == ((granule_unlock_spec (int_to_ptr v_33_tmp) st_11));
        when st_13 == ((free_stack "handle_rsi_realm_extend_measurement" st_0 st_12));
        (Some (0, st_13)))).

  Definition rsi_memory_dispose_spec (v_0: Ptr) (v_1: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((((v_1.(pbase)) = ("stack_s_rec_exit")) /\ (((v_1.(poffset)) = (0)))));
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_5, st_0 == ((load_RData 8 (ptr_offset v_0 32) st));
    when v_7, st_1 == ((load_RData 8 (ptr_offset v_0 40) st_0));
    if ((v_5 & (4095)) =? (0))
    then (
      if ((v_7 & (4095)) =? (0))
      then (
        if ((v_5 - ((v_7 + (v_5)))) <? (0))
        then (
          when v_29, st_2 == ((load_RData 8 (ptr_offset v_0 920) st_1));
          when v_31, st_3 == ((load_RData 8 (ptr_offset v_0 936) st_2));
          when v_32, st_4 == ((region_is_contained_spec v_29 v_31 v_5 (v_7 + (v_5)) st_3));
          if v_32
          then (rsi_memory_dispose_0_low st_4 v_0 v_1 v_32 v_5 v_7)
          else (
            when v_34, st_5 == ((pack_return_code_spec 1 1 st_4));
            when st_6 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_34 st_5));
            (Some (true, st_6))))
        else (
          when v_24, st_2 == ((pack_return_code_spec 1 2 st_1));
          when st_3 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_24 st_2));
          (Some (true, st_3))))
      else (
        when v_19, st_2 == ((pack_return_code_spec 1 2 st_1));
        when st_3 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_19 st_2));
        (Some (true, st_3))))
    else (
      when v_12, st_2 == ((pack_return_code_spec 1 1 st_1));
      when st_3 == ((store_RData 8 (ptr_offset (ptr_offset v_0 24) 0) v_12 st_2));
      (Some (true, st_3))).

  Definition write_lr_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when st_0 == ((iasm_289_spec v_1 st));
      (Some st_0))
    else (
      if (v_0 =? (15))
      then (
        when st_0 == ((iasm_290_spec v_1 st));
        (Some st_0))
      else (
        if (v_0 =? (14))
        then (
          when st_0 == ((iasm_291_spec v_1 st));
          (Some st_0))
        else (
          if (v_0 =? (13))
          then (
            when st_0 == ((iasm_292_spec v_1 st));
            (Some st_0))
          else (
            if (v_0 =? (12))
            then (
              when st_0 == ((iasm_293_spec v_1 st));
              (Some st_0))
            else (
              if (v_0 =? (11))
              then (
                when st_0 == ((iasm_294_spec v_1 st));
                (Some st_0))
              else (
                if (v_0 =? (10))
                then (
                  when st_0 == ((iasm_295_spec v_1 st));
                  (Some st_0))
                else (
                  if (v_0 =? (9))
                  then (
                    when st_0 == ((iasm_296_spec v_1 st));
                    (Some st_0))
                  else (
                    if (v_0 =? (8))
                    then (
                      when st_0 == ((iasm_297_spec v_1 st));
                      (Some st_0))
                    else (
                      if (v_0 =? (7))
                      then (
                        when st_0 == ((iasm_298_spec v_1 st));
                        (Some st_0))
                      else (
                        if (v_0 =? (6))
                        then (
                          when st_0 == ((iasm_299_spec v_1 st));
                          (Some st_0))
                        else (
                          if (v_0 =? (5))
                          then (
                            when st_0 == ((iasm_300_spec v_1 st));
                            (Some st_0))
                          else (
                            if (v_0 =? (4))
                            then (
                              when st_0 == ((iasm_301_spec v_1 st));
                              (Some st_0))
                            else (
                              if (v_0 =? (3))
                              then (
                                when st_0 == ((iasm_302_spec v_1 st));
                                (Some st_0))
                              else (
                                if (v_0 =? (2))
                                then (
                                  when st_0 == ((iasm_303_spec v_1 st));
                                  (Some st_0))
                                else (
                                  if (v_0 =? (1))
                                  then (
                                    when st_0 == ((iasm_304_spec v_1 st));
                                    (Some st_0))
                                  else (Some st)))))))))))))))).

  Definition write_ap1r_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when st_0 == ((iasm_285_spec v_1 st));
      (Some st_0))
    else (
      if (v_0 =? (3))
      then (
        when st_0 == ((iasm_286_spec v_1 st));
        (Some st_0))
      else (
        if (v_0 =? (2))
        then (
          when st_0 == ((iasm_287_spec v_1 st));
          (Some st_0))
        else (
          if (v_0 =? (1))
          then (
            when st_0 == ((iasm_288_spec v_1 st));
            (Some st_0))
          else (Some st)))).

  Definition write_ap0r_spec (v_0: Z) (v_1: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (
      when st_0 == ((iasm_281_spec v_1 st));
      (Some st_0))
    else (
      if (v_0 =? (3))
      then (
        when st_0 == ((iasm_282_spec v_1 st));
        (Some st_0))
      else (
        if (v_0 =? (2))
        then (
          when st_0 == ((iasm_283_spec v_1 st));
          (Some st_0))
        else (
          if (v_0 =? (1))
          then (
            when st_0 == ((iasm_284_spec v_1 st));
            (Some st_0))
          else (Some st)))).

  Definition masked_assign_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData 8 v_0 st));
    when st_1 == ((store_RData 8 v_0 ((v_4 & ((Z.lxor v_2 (- 1)))) |' ((v_2 & (v_1)))) st_0));
    (Some st_1).

  Definition set_tte_ns_spec (v_0: Z) (st: RData) : (option RData) :=
    rely (((((v_0 - (MEM1_PHYS)) >= (0)) /\ (((v_0 - (556198264832)) < (0)))) \/ ((((v_0 - (MEM0_PHYS)) >= (0)) /\ (((v_0 - (MEM0_SIZE)) < (0)))))));
    if ((v_0 & (549755813888)) =? (0))
    then (
      when v_8, st_1 == ((get_tte_spec (v_0 + (18446744004990074880)) st));
      when v_9, st_2 == ((__tte_read_spec v_8 st_1));
      when st_3 == ((iasm_12_spec st_2));
      when st_4 == ((__tte_write_spec v_8 (v_9 |' (32)) st_3));
      when st_5 == ((iasm_8_spec st_4));
      when st_6 == ((iasm_9_spec ((v_0 + (18446744004990074880)) >> (12)) st_5));
      when st_7 == ((iasm_10_spec st_6));
      when st_8 == ((iasm_12_isb_spec st_7));
      (Some st_8))
    else (
      when v_8, st_1 == ((get_tte_spec (v_0 + (18446743457381744640)) st));
      when v_9, st_2 == ((__tte_read_spec v_8 st_1));
      when st_3 == ((iasm_12_spec st_2));
      when st_4 == ((__tte_write_spec v_8 (v_9 |' (32)) st_3));
      when st_5 == ((iasm_8_spec st_4));
      when st_6 == ((iasm_9_spec ((v_0 + (18446743457381744640)) >> (12)) st_5));
      when st_7 == ((iasm_10_spec st_6));
      when st_8 == ((iasm_12_isb_spec st_7));
      (Some st_8)).

  Definition set_pas_ns_spec (v_0: Z) (st: RData) : (option RData) :=
    when v_2, st_0 == ((monitor_call_spec 3288334593 v_0 0 0 0 0 0 st));
    (Some st_0).

  Definition granule_memzero_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    rely (((((v_0.(pbase)) = ("granules")) /\ ((((v_0.(poffset)) mod (4096)) = (0)))) /\ (((v_0.(poffset)) >= (0)))));
    when v_3, st_0 == ((granule_map_spec v_0 v_1 st));
    when v_4, st_1 == ((memset_spec v_3 0 4096 st_0));
    (Some st_1).

  Definition clear_tte_ns_spec (v_0: Z) (st: RData) : (option RData) :=
    if ((v_0 & (549755813888)) =? (0))
    then (
      when v_8, st_1 == ((get_tte_spec (v_0 + (18446744004990074880)) st));
      when v_9, st_2 == ((__tte_read_spec v_8 st_1));
      when st_3 == ((__tte_write_spec v_8 (v_9 & ((- 33))) st_2));
      when st_4 == ((iasm_8_spec st_3));
      when st_5 == ((iasm_9_spec ((v_0 + (18446744004990074880)) >> (12)) st_4));
      when st_6 == ((iasm_10_spec st_5));
      when st_7 == ((iasm_12_isb_spec st_6));
      when st_8 == ((iasm_12_spec st_7));
      (Some st_8))
    else (
      when v_8, st_1 == ((get_tte_spec (v_0 + (18446743457381744640)) st));
      when v_9, st_2 == ((__tte_read_spec v_8 st_1));
      when st_3 == ((__tte_write_spec v_8 (v_9 & ((- 33))) st_2));
      when st_4 == ((iasm_8_spec st_3));
      when st_5 == ((iasm_9_spec ((v_0 + (18446743457381744640)) >> (12)) st_4));
      when st_6 == ((iasm_10_spec st_5));
      when st_7 == ((iasm_12_isb_spec st_6));
      when st_8 == ((iasm_12_spec st_7));
      (Some st_8)).

  Definition set_pas_realm_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((monitor_call_spec 3288334592 v_0 0 0 0 0 0 st));
    (Some (v_2, st_0)).

  Definition min_spec (v_0: Z) (v_1: Z) (v_2: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_0 - (v_1)) <? (0))
    then (
      if ((v_0 - (v_2)) <? (0))
      then (Some (v_0, st))
      else (Some (v_2, st)))
    else (
      if ((v_1 - (v_2)) <? (0))
      then (Some (v_1, st))
      else (Some (v_2, st))).

  Definition next_granule_spec (v_0: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_0 + (4096)) & (18446744073709547520)), st)).

  Definition rc_update_ttbr0_el12_spec (v_0: Z) (st: RData) : (option RData) :=
    if (v_0 =? (0))
    then (Some st)
    else (
      when v_3, st_0 == ((iasm_81_spec st));
      if ((v_3 - (v_0)) =? (0))
      then (Some st_0)
      else (
        when st_1 == ((iasm_82_spec v_0 st_0));
        when st_2 == ((iasm_12_isb_spec st_1));
        (Some st_2))).

  Definition virt_to_phys_spec (v_0: Z) (v_1: Z) (v_2: Ptr) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (((v_2.(pbase)) = ("stack_type_3")));
    if (v_1 =? (0))
    then (
      when st_0 == ((iasm_277_spec v_0 st));
      when st_2 == ((iasm_12_isb_spec st_0));
      when v_8, st_3 == ((iasm_get_par_el1_spec st_2));
      when st_4 == ((store_RData 8 v_2 v_8 st_3));
      if ((v_8 & (1)) =? (0))
      then (Some (((v_8 & (281474976706560)) |' ((v_0 & (4095)))), st_4))
      else (Some (0, st_4)))
    else (
      when st_0 == ((iasm_278_spec v_0 st));
      when st_2 == ((iasm_12_isb_spec st_0));
      when v_8, st_3 == ((iasm_get_par_el1_spec st_2));
      when st_4 == ((store_RData 8 v_2 v_8 st_3));
      if ((v_8 & (1)) =? (0))
      then (Some (((v_8 & (281474976706560)) |' ((v_0 & (4095)))), st_4))
      else (Some (0, st_4))).

      Definition map_unmap_ns_s1_spec (v_0_Zptr: Z) (v_1: Z) (v_2: Z) (v_3: Z) (v_4: Z) (st: RData) : (option (Z * RData)) :=
        rely ((("granules" = ("granules")) \/ (("granules" = ("null")))));
        when st_1 == ((spinlock_acquire_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st));
        if (((((((st_1.(share)).(globals)).(g_granules)) @ (((test_PA v_0_Zptr).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (5)) =? (0))
        then (
          when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st_1));
          rely ((((st_4.(share)).(granule_data)) = (((st_1.(share)).(granule_data)))));
          if (((ret_rtt.(e_1)) - (v_2)) =? (0))
          then (
            if (v_4 =? (0))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
              then (
                if (uart0_phys_para (test_Z_PTE v_3))
                then (
                  rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                  when st_18 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_4.[share].[globals].[g_granules] :<
                          ((((st_4.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))));
                  (Some (0, st_18)))
                else (
                  when st_2 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_4));
                  if ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) =? (0))
                  then (
                    rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    when st_6 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                          (st_2.[share].[globals].[g_granules] :<
                            ((((st_2.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  ((g_mapped_addr_set_para
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                    v_1) +
                                    (1)))).[e_state_s_granule] :<
                                6)))));
                    rely ((true = (true)));
                    rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_6.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (test_Z_PTE v_3))))))));
                    (Some (0, st_19)))
                  else (
                    when st_3 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_2));
                    when st_5 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_3));
                    if (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (6)) =? (0))
                    then (
                      rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) = (8)));
                      when st_6 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                            (st_5.[share].[globals].[g_granules] :<
                              ((((st_5.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  ((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_5.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      rely ((true = (true)));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_6.[share].[globals].[g_granules] :<
                              ((((st_6.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              (((st_6.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (test_Z_PTE v_3))))))));
                      (Some (0, st_19)))
                    else (
                      when st_6 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_5));
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely ((true = (true)));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_19 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_6.[share].[globals].[g_granules] :<
                                ((((st_6.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                                (((st_6.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (test_Z_PTE v_3))))))));
                        (Some (0, st_19)))
                      else (
                        when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_6));
                        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14)))))))
              else (
                when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13))))
            else (
              if (v_4 =? (1))
              then (
                if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
                then (
                  if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_4.[share].[globals].[g_granules] :<
                            ((((st_4.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_4.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_19)))
                  else (
                    when st_2 == (
                        (spinlock_acquire_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          st_4));
                    if (
                      (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                        (6)) =?
                        (0)))
                    then (
                      rely (
                        ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (
                        ((g_refcount_para
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_2.[share].[globals].[g_granules] :<
                            ((((st_2.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))))))) =?
                          (0)))
                      then (
                        when st_7 == (
                            (granule_unlock_spec
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              (st_2.[share].[globals].[g_granules] :<
                                ((((st_2.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (g_mapped_addr_set_para
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))
                                        0))).[e_state_s_granule] :<
                                    0)))));
                        rely ((true = (true)));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_20 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_7.[share].[globals].[g_granules] :<
                                ((((st_7.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                        (Some (0, st_20)))
                      else (
                        when st_5 == (
                            (granule_unlock_spec
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              (st_2.[share].[globals].[g_granules] :<
                                ((((st_2.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (g_mapped_addr_set_para
                                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))
                                        0)))))));
                        rely ((true = (true)));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_20 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_5.[share].[globals].[g_granules] :<
                                ((((st_5.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_5.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                        (Some (0, st_20))))
                    else (
                      when st_3 == (
                          (spinlock_release_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            st_2));
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely ((true = (true)));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_20 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_3.[share].[globals].[g_granules] :<
                                ((((st_3.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_3.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                        (Some (0, st_20)))
                      else (
                        when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_3));
                        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
                else (
                  if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
                  then (
                    if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_4.[share].[globals].[g_granules] :<
                              ((((st_4.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_19)))
                    else (
                      when st_2 == (
                          (spinlock_acquire_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            st_4));
                      if (
                        (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                          (6)) =?
                          (0)))
                      then (
                        rely (
                          ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        if (
                          ((g_refcount_para
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            (st_2.[share].[globals].[g_granules] :<
                              ((((st_2.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))))))) =?
                            (0)))
                        then (
                          when st_7 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                                (st_2.[share].[globals].[g_granules] :<
                                  ((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (g_mapped_addr_set_para
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))
                                          0))).[e_state_s_granule] :<
                                      0)))));
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          when st_20 == (
                              (granule_unlock_spec
                                (ret_rtt.(e_2))
                                ((st_7.[share].[globals].[g_granules] :<
                                  ((((st_7.(share)).(globals)).(g_granules)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                    (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                          (Some (0, st_20)))
                        else (
                          when st_5 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                                (st_2.[share].[globals].[g_granules] :<
                                  ((((st_2.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      ((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (g_mapped_addr_set_para
                                          (((((((st_2.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))
                                          0)))))));
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          when st_20 == (
                              (granule_unlock_spec
                                (ret_rtt.(e_2))
                                ((st_5.[share].[globals].[g_granules] :<
                                  ((((st_5.(share)).(globals)).(g_granules)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                    (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_5.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                          (Some (0, st_20))))
                      else (
                        when st_3 == (
                            (spinlock_release_spec
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              st_2));
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          when st_20 == (
                              (granule_unlock_spec
                                (ret_rtt.(e_2))
                                ((st_3.[share].[globals].[g_granules] :<
                                  ((((st_3.(share)).(globals)).(g_granules)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_3.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_3.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                          (Some (0, st_20)))
                        else (
                          when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_3));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
                  else (
                    when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                    (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13)))))
              else (
                when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                (Some (0, st_12)))))
          else (
            when st_8 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8))))
        else (
          when st_2 == ((spinlock_release_spec (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) st_1));
          when ret_rtt, st_4 == ((rtt_walk_lock_unlock_spec_abs (mkPtr "stack_s_rtt_walk" 0) (mkPtr "granules" ((test_PA v_0_Zptr).(meta_granule_offset))) 0 64 v_1 v_2 st_2));
          rely ((((st_4.(share)).(granule_data)) = (((st_2.(share)).(granule_data)))));
          if (((ret_rtt.(e_1)) - (v_2)) =? (0))
          then (
            if (v_4 =? (0))
            then (
              if (
                (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (0)) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_ripas)) =? (0)))) &&
                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_mem_attr)) =? (0)))))
              then (
                if (uart0_phys_para (test_Z_PTE v_3))
                then (
                  rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                  rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                  when st_18 == (
                      (granule_unlock_spec
                        (ret_rtt.(e_2))
                        ((st_4.[share].[globals].[g_granules] :<
                          ((((st_4.(share)).(globals)).(g_granules)) #
                            ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                            (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                              ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                          (((st_4.(share)).(granule_data)) #
                            ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                            ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                              (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                (test_PTE_Z (test_Z_PTE v_3))))))));
                  (Some (0, st_18)))
                else (
                  when st_3 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_4));
                  if ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) =? (0))
                  then (
                    rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                    when st_6 == (
                        (granule_unlock_spec
                          (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                          (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  ((g_mapped_addr_set_para
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0))
                                    v_1) +
                                    (1)))).[e_state_s_granule] :<
                                6)))));
                    rely ((true = (true)));
                    rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_6.[share].[globals].[g_granules] :<
                            ((((st_6.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_6.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                            (((st_6.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_6.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (test_Z_PTE v_3))))))));
                    (Some (0, st_19)))
                  else (
                    when st_5 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_3));
                    when st_6 == ((spinlock_acquire_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_5));
                    if (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) - (6)) =? (0))
                    then (
                      rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\ (((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      rely (((((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) + (8)) mod (4096)) = (8)));
                      when st_7 == (
                          (granule_unlock_spec
                            (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)))
                            (st_6.[share].[globals].[g_granules] :<
                              ((((st_6.(share)).(globals)).(g_granules)) #
                                ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  ((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_6.(share)).(globals)).(g_granules)) @ ((((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1))))))));
                      rely ((true = (true)));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_7.[share].[globals].[g_granules] :<
                              ((((st_7.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                              (((st_7.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (test_Z_PTE v_3))))))));
                      (Some (0, st_19)))
                    else (
                      when st_7 == ((spinlock_release_spec (mkPtr "granules" (((test_Z_PTE v_3).(meta_PA)).(meta_granule_offset))) st_6));
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely ((true = (true)));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_19 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_7.[share].[globals].[g_granules] :<
                                ((((st_7.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + (1)))))).[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (test_Z_PTE v_3))))))));
                        (Some (0, st_19)))
                      else (
                        when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_7));
                        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14)))))))
              else (
                when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13))))
            else (
              if (v_4 =? (1))
              then (
                if ((v_2 =? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (3))))
                then (
                  if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                  then (
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                    rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                    rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                    when st_19 == (
                        (granule_unlock_spec
                          (ret_rtt.(e_2))
                          ((st_4.[share].[globals].[g_granules] :<
                            ((((st_4.(share)).(globals)).(g_granules)) #
                              ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                              (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                            (((st_4.(share)).(granule_data)) #
                              ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                              ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                  (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                    (Some (0, st_19)))
                  else (
                    when st_3 == (
                        (spinlock_acquire_spec
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          st_4));
                    if (
                      (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                        (6)) =?
                        (0)))
                    then (
                      rely (
                        ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                          (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                      if (
                        ((g_refcount_para
                          (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                          (st_3.[share].[globals].[g_granules] :<
                            ((((st_3.(share)).(globals)).(g_granules)) #
                              ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                              (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                  (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                    ((- 1)))))))) =?
                          (0)))
                      then (
                        when st_7 == (
                            (granule_unlock_spec
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              (st_3.[share].[globals].[g_granules] :<
                                ((((st_3.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (g_mapped_addr_set_para
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))
                                        0))).[e_state_s_granule] :<
                                    0)))));
                        rely ((true = (true)));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_20 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_7.[share].[globals].[g_granules] :<
                                ((((st_7.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_7.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                        (Some (0, st_20)))
                      else (
                        when st_5 == (
                            (granule_unlock_spec
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              (st_3.[share].[globals].[g_granules] :<
                                ((((st_3.(share)).(globals)).(g_granules)) #
                                  ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                  (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (g_mapped_addr_set_para
                                        (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                          ((- 1)))
                                        0)))))));
                        rely ((true = (true)));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_20 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_5.[share].[globals].[g_granules] :<
                                ((((st_5.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_5.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                        (Some (0, st_20))))
                    else (
                      when st_5 == (
                          (spinlock_release_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            st_3));
                      if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                      then (
                        rely ((true = (true)));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                        rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                        rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                        when st_20 == (
                            (granule_unlock_spec
                              (ret_rtt.(e_2))
                              ((st_5.[share].[globals].[g_granules] :<
                                ((((st_5.(share)).(globals)).(g_granules)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                  (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                    ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                      (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                (((st_5.(share)).(granule_data)) #
                                  ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                  ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                    (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                      ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                      (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                        (Some (0, st_20)))
                      else (
                        when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_5));
                        (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
                else (
                  if ((v_2 <>? (3)) && ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_desc_type)) =? (1))))
                  then (
                    if (uart0_phys_para (abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4))
                    then (
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                      rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                      rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                      when st_19 == (
                          (granule_unlock_spec
                            (ret_rtt.(e_2))
                            ((st_4.[share].[globals].[g_granules] :<
                              ((((st_4.(share)).(globals)).(g_granules)) #
                                ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                (((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                  ((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_4.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                              (((st_4.(share)).(granule_data)) #
                                ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                ((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                  (((((st_4.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                    (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                      (Some (0, st_19)))
                    else (
                      when st_3 == (
                          (spinlock_acquire_spec
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            st_4));
                      if (
                        (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_state_s_granule)) -
                          (6)) =?
                          (0)))
                      then (
                        rely (
                          ((((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) mod (4096)) = (0)) /\
                            (((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) >= (0)))));
                        if (
                          ((g_refcount_para
                            (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                            (st_3.[share].[globals].[g_granules] :<
                              ((((st_3.(share)).(globals)).(g_granules)) #
                                ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                  ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                    (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                      ((- 1)))))))) =?
                            (0)))
                        then (
                          when st_7 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                                (st_3.[share].[globals].[g_granules] :<
                                  ((((st_3.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (g_mapped_addr_set_para
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))
                                          0))).[e_state_s_granule] :<
                                      0)))));
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          when st_20 == (
                              (granule_unlock_spec
                                (ret_rtt.(e_2))
                                ((st_7.[share].[globals].[g_granules] :<
                                  ((((st_7.(share)).(globals)).(g_granules)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                    (((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_7.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_7.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_7.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                          (Some (0, st_20)))
                        else (
                          when st_5 == (
                              (granule_unlock_spec
                                (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                                (st_3.[share].[globals].[g_granules] :<
                                  ((((st_3.(share)).(globals)).(g_granules)) #
                                    ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096)) ==
                                    (((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).[e_ref] :<
                                      ((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (g_mapped_addr_set_para
                                          (((((((st_3.(share)).(globals)).(g_granules)) @ ((((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)) / (4096))).(e_ref)).(e_u_anon_3_0)) +
                                            ((- 1)))
                                          0)))))));
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          when st_20 == (
                              (granule_unlock_spec
                                (ret_rtt.(e_2))
                                ((st_5.[share].[globals].[g_granules] :<
                                  ((((st_5.(share)).(globals)).(g_granules)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                    (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_5.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                          (Some (0, st_20))))
                      else (
                        when st_5 == (
                            (spinlock_release_spec
                              (mkPtr "granules" (((abs_tte_read (mkPtr "granule_data" (((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3))))))) st_4).(meta_PA)).(meta_granule_offset)))
                              st_3));
                        if ((pack_struct_return_code_para (make_return_code_para 1)) =? (0))
                        then (
                          rely ((true = (true)));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((((ret_rtt.(e_2)).(pbase)) = ("granules")) /\ (((((ret_rtt.(e_2)).(poffset)) mod (4096)) = (0)))) /\ ((((ret_rtt.(e_2)).(poffset)) >= (0)))));
                          rely ((((ret_rtt.(e_2)).(pbase)) = ("granules")));
                          rely ((((((ret_rtt.(e_2)).(poffset)) + (8)) mod (4096)) = (8)));
                          when st_20 == (
                              (granule_unlock_spec
                                (ret_rtt.(e_2))
                                ((st_5.[share].[globals].[g_granules] :<
                                  ((((st_5.(share)).(globals)).(g_granules)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096)) ==
                                    (((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).[e_ref] :<
                                      ((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).[e_u_anon_3_0] :<
                                        (((((((st_5.(share)).(globals)).(g_granules)) @ ((((ret_rtt.(e_2)).(poffset)) + (8)) / (4096))).(e_ref)).(e_u_anon_3_0)) + ((- 1))))))).[share].[granule_data] :<
                                  (((st_5.(share)).(granule_data)) #
                                    ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096)) ==
                                    ((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).[g_norm] :<
                                      (((((st_5.(share)).(granule_data)) @ ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) / (4096))).(g_norm)) #
                                        ((((ret_rtt.(e_2)).(poffset)) + ((8 * ((ret_rtt.(e_3)))))) mod (4096)) ==
                                        (test_PTE_Z (mkabs_PTE_t (mkabs_PA_t (- 1)) 0 1 0))))))));
                          (Some (0, st_20)))
                        else (
                          when st_14 == ((granule_unlock_spec (ret_rtt.(e_2)) st_5));
                          (Some ((pack_struct_return_code_para (make_return_code_para 1)), st_14))))))
                  else (
                    when st_13 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                    (Some ((pack_struct_return_code_para (make_return_code_para 9)), st_13)))))
              else (
                when st_12 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
                (Some (0, st_12)))))
          else (
            when st_8 == ((granule_unlock_spec (ret_rtt.(e_2)) st_4));
            (Some ((pack_struct_return_code_para (make_return_code_para 8)), st_8)))).
    



   Definition data_create_s1_el1_0 (st_0: RData) (st_7: RData) (v_25: Z) : (option (Z * RData)) :=
    rely (((v_25 =? (0)) = (true)));
    when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
    when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
    when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
    when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 4 st_11));
    when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
    (Some (((v_25 << (32)) >> (32)), st_15)).

  Definition data_create_s1_el1_spec (v_0: Z) (v_1: Z) (v_2: Z) (v_3: Ptr) (st: RData) : (option (Z * RData)) :=
    when st_0 == ((new_frame "data_create_s1_el1" st));
    rely (((((v_3.(pbase)) = ("granules")) /\ ((((v_3.(poffset)) mod (4096)) = (0)))) /\ (((v_3.(poffset)) >= (0)))));
    when v_7, st_1 == ((s1tte_pa_spec v_0 st_0));
    when v_8, st_2 == ((find_lock_two_granules_spec v_7 1 (mkPtr "stack_type_4" 0) v_1 3 (mkPtr "stack_type_4__1" 0) st_1));
    if (v_8 =? (3))
    then (
      when v_11, st_3 == ((pack_return_code_spec 3 0 st_2));
      when st_5 == ((free_stack "data_create_s1_el1" st_0 st_3));
      (Some (v_11, st_5)))
    else (
      if (v_8 =? (0))
      then (
        when v_19_tmp, st_3 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_2));
        when v_20, st_4 == ((granule_map_spec (int_to_ptr v_19_tmp) 3 st_3));
        rely (((((v_20.(pbase)) = ("granule_data")) /\ (((v_20.(poffset)) >= (0)))) /\ ((((v_20.(poffset)) mod (4096)) = (0)))));
        rely ((((((st_4.(share)).(granule_data)) @ ((v_20.(poffset)) / (4096))).(g_granule_state)) = (GRANULE_STATE_REC)));
        when v_24_tmp, st_5 == ((load_RData 8 (ptr_offset v_20 1544) st_4));
        when st_6 == ((granule_lock_spec (int_to_ptr v_24_tmp) 5 st_5));
        when v_25, st_7 == ((data_create_internal_spec v_0 (int_to_ptr v_24_tmp) v_2 v_3 v_20 1 st_6));
        if (v_25 =? (0))
        then (data_create_s1_el1_0 st_0 st_7 v_25)
        else (
          when v_29_tmp, st_9 == ((load_RData 8 (mkPtr "stack_type_4__1" 0) st_7));
          when st_10 == ((granule_unlock_spec (int_to_ptr v_29_tmp) st_9));
          when v_30_tmp, st_11 == ((load_RData 8 (mkPtr "stack_type_4" 0) st_10));
          when st_12 == ((granule_unlock_transition_spec (int_to_ptr v_30_tmp) 1 st_11));
          when st_15 == ((free_stack "data_create_s1_el1" st_0 st_12));
          (Some (((v_25 << (32)) >> (32)), st_15))))
      else (
        when v_16, st_3 == ((pack_return_code_spec 1 ((v_8 >> (32)) + (1)) st_2));
        when st_6 == ((free_stack "data_create_s1_el1" st_0 st_3));
        (Some (v_16, st_6)))).

  Definition granule_memzero_mapped_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((memset_spec v_0 0 4096 st));
    (Some st_0).

  Definition rtt_create_s1_el1_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (v_3: Z) (st: RData) : (option (Z * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_REC)) = (0)));
    rely (((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))) /\ ((((v_0.(poffset)) mod (4096)) = (0)))));
    when v_6_tmp, st_0 == ((load_RData 8 (ptr_offset v_0 1544) st));
    when st_1 == ((granule_lock_spec (int_to_ptr v_6_tmp) 5 st_0));
    when v_7, st_2 == ((rtt_create_internal_spec (int_to_ptr v_6_tmp) v_1 v_2 v_3 1 st_1));
    (Some (((v_7 << (32)) >> (32)), st_2)).

  Definition update_ripas_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option (bool * RData)) :=
    rely (((((((st.(share)).(granule_data)) @ ((v_0.(poffset)) / (4096))).(g_granule_state)) - (GRANULE_STATE_DATA)) = (0)));
    rely ((((v_0.(pbase)) = ("granule_data")) /\ (((v_0.(poffset)) >= (0)))));
    when v_4, st_0 == ((load_RData 8 v_0 st));
    when v_5, st_1 == ((s2tte_is_table_spec v_4 v_1 st_0));
    if v_5
    then (Some (false, st_1))
    else (
      when v_8, st_2 == ((load_RData 8 v_0 st_1));
      when v_9, st_3 == ((s1tte_is_valid_spec v_8 v_1 st_2));
      if v_9
      then (
        if (v_2 =? (0))
        then (
          when v_13, st_4 == ((load_RData 8 v_0 st_3));
          when v_14, st_5 == ((s2tte_pa_spec v_13 v_1 st_4));
          when v_15, st_6 == ((s2tte_create_assigned_spec v_14 v_1 st_5));
          when st_7 == ((store_RData 8 v_0 v_15 st_6));
          (Some (true, st_7)))
        else (Some (true, st_3)))
      else (
        when v_18, st_4 == ((load_RData 8 v_0 st_3));
        when v_19, st_5 == ((s2tte_is_unassigned_spec v_18 st_4));
        if v_19
        then (
          when v_24, st_7 == ((s2tte_create_ripas_spec v_2 st_5));
          when v_25, st_8 == ((load_RData 8 v_0 st_7));
          when st_9 == ((store_RData 8 v_0 (v_25 |' (v_24)) st_8));
          (Some (true, st_9)))
        else (
          when v_21, st_6 == ((load_RData 8 v_0 st_5));
          when v_22, st_7 == ((s2tte_is_assigned_spec v_21 v_1 st_6));
          if v_22
          then (
            when v_24, st_9 == ((s2tte_create_ripas_spec v_2 st_7));
            when v_25, st_10 == ((load_RData 8 v_0 st_9));
            when st_11 == ((store_RData 8 v_0 (v_25 |' (v_24)) st_10));
            (Some (true, st_11)))
          else (Some (false, st_7))))).

End Layer8_Spec.

#[global] Hint Unfold realm_ipa_size_spec: spec.
#[global] Hint Unfold max_pa_size_spec: spec.
#[global] Hint Unfold addr_is_level_aligned_spec: spec.
#[global] Hint Unfold s1addr_is_level_aligned_spec: spec.
#[global] Hint Unfold range_intersects_par_spec: spec.
#[global] Hint Unfold emulate_sysreg_access_ns_spec: spec.
#[global] Hint Unfold esr_is_write_spec: spec.
#[global] Hint Unfold access_len_spec: spec.
#[global] Hint Unfold fixup_aarch32_data_abort_spec: spec.
#[global] Hint Unfold get_dabt_write_value_spec: spec.
#[global] Hint Unfold emulate_stage2_data_abort_spec: spec.
#[global] Hint Unfold psci_rsi_spec: spec.
#[global] Hint Unfold handle_rsi_realm_extend_measurement_spec: spec.
#[global] Hint Unfold rsi_memory_dispose_spec: spec.
#[global] Hint Unfold write_lr_spec: spec.
#[global] Hint Unfold write_ap1r_spec: spec.
#[global] Hint Unfold write_ap0r_spec: spec.
#[global] Hint Unfold masked_assign_spec: spec.
#[global] Hint Unfold set_tte_ns_spec: spec.
#[global] Hint Unfold set_pas_ns_spec: spec.
Opaque granule_memzero_spec.
#[global] Hint Unfold clear_tte_ns_spec: spec.
#[global] Hint Unfold set_pas_realm_spec: spec.
#[global] Hint Unfold min_spec: spec.
#[global] Hint Unfold next_granule_spec: spec.
#[global] Hint Unfold rc_update_ttbr0_el12_spec: spec.
#[global] Hint Unfold virt_to_phys_spec: spec.
#[global] Hint Unfold map_unmap_ns_s1_spec: spec.
#[global] Hint Unfold data_create_s1_el1_0: spec.
#[global] Hint Unfold data_create_s1_el1_spec: spec.
#[global] Hint Unfold granule_memzero_mapped_spec: spec.
#[global] Hint Unfold rtt_create_s1_el1_spec: spec.
#[global] Hint Unfold update_ripas_spec: spec.
