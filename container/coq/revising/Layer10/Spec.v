Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.gic_save_state.LowSpec.
Require Import Layer10.stage2_tlbi_ipa.LowSpec.
(* Require Import Layer12.Spec. *)
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Layer9.Spec.
Require Import Layer9.gic_restore_state.LowSpec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition psci_reset_rec_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when st_0 == ((store_RData 8 (ptr_offset v_0 280) 965 st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 360) ((v_1 & (33554432)) |' (12912760)) st_0));
    (Some st_1).

  Definition granule_refcount_read_acquire_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((__sca_read64_acquire_spec (ptr_offset v_0 8) st));
    (Some ((v_3 & (4095)), st_0)).

  Definition va_to_s1tte_spec (v_0: Ptr) (st: RData) : (option (Ptr * RData)) :=
    rely ((((0 - ((((ptr_to_int v_0) + (2147483648)) >> (12)))) <= (0)) /\ (((((ptr_to_int v_0) + (2147483648)) >> (12)) < (512)))));
    (Some ((ptr_offset (mkPtr "tt_l3_buffer" 0) (8 * ((((ptr_to_int v_0) + (2147483648)) >> (12))))), st)).

  Definition timer_output_is_asserted_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((timer_is_masked_spec v_0 st));
    if v_2
    then (Some (false, st_0))
    else (
      when v_4, st_1 == ((timer_condition_met_spec v_0 st_0));
      (Some (v_4, st_1))).

  Fixpoint gic_save_state_loop235 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv, st))
    | (S _N__0) =>
      match ((gic_save_state_loop235 _N__0 __break__ v_0 v_indvars_iv st)) with
      | (Some (__break___0, v_1, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv_0, st_0))
        else (
          when v_19, st_1 == ((read_lr_spec v_indvars_iv_0 st_0));
          rely ((((0 - (v_indvars_iv_0)) <= (0)) /\ ((v_indvars_iv_0 < (16)))));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (80 + ((8 * (v_indvars_iv_0))))) v_19 st_1));
          when v_21, st_3 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_2));
          if (((v_indvars_iv_0 + (1)) - (v_21)) <? (0))
          then (Some (false, v_1, (v_indvars_iv_0 + (1)), st_3))
          else (Some (true, v_1, v_indvars_iv_0, st_3)))
      | None => None
      end
    end.

  Fixpoint gic_save_state_loop230 (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv27: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv27, st))
    | (S _N__0) =>
      match ((gic_save_state_loop230 _N__0 __break__ v_0 v_indvars_iv27 st)) with
      | (Some (__break___0, v_1, v_indvars_iv27_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_indvars_iv27_0, st_0))
        else (
          when v_6, st_1 == ((read_ap0r_spec v_indvars_iv27_0 st_0));
          rely ((((0 - (v_indvars_iv27_0)) <= (0)) /\ ((v_indvars_iv27_0 < (4)))));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv27_0))) v_6 st_1));
          when v_9, st_3 == ((read_ap1r_spec v_indvars_iv27_0 st_2));
          when st_4 == ((store_RData 8 (ptr_offset v_1 (32 + ((8 * (v_indvars_iv27_0))))) v_9 st_3));
          when v_11, st_5 == ((load_RData 4 (mkPtr "nr_aprs" 0) st_4));
          if (((v_indvars_iv27_0 + (1)) - (v_11)) <? (0))
          then (Some (false, v_1, (v_indvars_iv27_0 + (1)), st_5))
          else (Some (true, v_1, v_indvars_iv27_0, st_5)))
      | None => None
      end
    end.

  Definition gic_save_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((load_RData 4 (mkPtr "nr_aprs" 0) st));
    if ((0 - (v_2)) <? (0))
    then (
      rely (((gic_save_state_loop230_rank v_0 0) >= (0)));
      match ((gic_save_state_loop230 (z_to_nat (gic_save_state_loop230_rank v_0 0)) false v_0 0 st_0)) with
      | (Some (__break__, v_1, v_indvars_iv27_0, st_1)) =>
        when v_15, st_3 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_1));
        if ((0 - (v_15)) <? (0))
        then (gic_save_state_0_low st_3 v_0 v_15)
        else (
          when v_25, st_5 == ((iasm_37_spec st_3));
          when st_6 == ((store_RData 8 (ptr_offset v_0 64) v_25 st_5));
          when v_27, st_7 == ((iasm_38_spec st_6));
          when st_8 == ((store_RData 8 (ptr_offset v_0 72) v_27 st_7));
          when v_29, st_9 == ((iasm_39_spec st_8));
          when st_10 == ((store_RData 8 (ptr_offset v_0 208) v_29 st_9));
          when st_11 == ((gic_restore_state_spec (mkPtr "default_gicstate" 0) st_10));
          (Some st_11))
      | None => None
      end)
    else (
      when v_15, st_2 == ((load_RData 4 (mkPtr "nr_lrs" 0) st_0));
      if ((0 - (v_15)) <? (0))
      then (gic_save_state_1_low st_2 v_0 v_15)
      else (
        when v_25, st_4 == ((iasm_37_spec st_2));
        when st_5 == ((store_RData 8 (ptr_offset v_0 64) v_25 st_4));
        when v_27, st_6 == ((iasm_38_spec st_5));
        when st_7 == ((store_RData 8 (ptr_offset v_0 72) v_27 st_6));
        when v_29, st_8 == ((iasm_39_spec st_7));
        when st_9 == ((store_RData 8 (ptr_offset v_0 208) v_29 st_8));
        when st_10 == ((gic_restore_state_spec (mkPtr "default_gicstate" 0) st_9));
        (Some st_10))).

  Definition save_sysreg_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((iasm_get_sp_el0_spec st));
    when st_1 == ((store_RData 8 (ptr_offset v_0 0) v_2 st_0));
    when v_4, st_2 == ((iasm_get_sp_el1_spec st_1));
    when st_3 == ((store_RData 8 (ptr_offset v_0 8) v_4 st_2));
    when v_6, st_4 == ((iasm_212_spec st_3));
    when st_5 == ((store_RData 8 (ptr_offset v_0 16) v_6 st_4));
    when v_8, st_6 == ((iasm_213_spec st_5));
    when st_7 == ((store_RData 8 (ptr_offset v_0 24) v_8 st_6));
    when v_10, st_8 == ((iasm_get_pmcr_el0_spec st_7));
    when st_9 == ((store_RData 8 (ptr_offset v_0 32) v_10 st_8));
    when v_12, st_10 == ((iasm_get_pmuserenr_el0_spec st_9));
    when st_11 == ((store_RData 8 (ptr_offset v_0 40) v_12 st_10));
    when v_14, st_12 == ((iasm_get_tpidrro_el0_spec st_11));
    when st_13 == ((store_RData 8 (ptr_offset v_0 48) v_14 st_12));
    when v_16, st_14 == ((iasm_get_tpidr_el0_spec st_13));
    when st_15 == ((store_RData 8 (ptr_offset v_0 56) v_16 st_14));
    when v_18, st_16 == ((iasm_get_csselr_el1_spec st_15));
    when st_17 == ((store_RData 8 (ptr_offset v_0 64) v_18 st_16));
    when v_20, st_18 == ((iasm_219_spec st_17));
    when st_19 == ((store_RData 8 (ptr_offset v_0 72) v_20 st_18));
    when v_22, st_20 == ((iasm_get_actlr_el1_spec st_19));
    when st_21 == ((store_RData 8 (ptr_offset v_0 80) v_22 st_20));
    when v_24, st_22 == ((iasm_221_spec st_21));
    when st_23 == ((store_RData 8 (ptr_offset v_0 88) v_24 st_22));
    when v_26, st_24 == ((iasm_81_spec st_23));
    when st_25 == ((store_RData 8 (ptr_offset v_0 104) v_26 st_24));
    when v_28, st_26 == ((iasm_84_spec st_25));
    when st_27 == ((store_RData 8 (ptr_offset v_0 112) v_28 st_26));
    when v_30, st_28 == ((iasm_224_spec st_27));
    when st_29 == ((store_RData 8 (ptr_offset v_0 120) v_30 st_28));
    when v_32, st_30 == ((iasm_225_spec st_29));
    when st_31 == ((store_RData 8 (ptr_offset v_0 128) v_32 st_30));
    when v_34, st_32 == ((iasm_226_spec st_31));
    when st_33 == ((store_RData 8 (ptr_offset v_0 136) v_34 st_32));
    when v_36, st_34 == ((iasm_227_spec st_33));
    when st_35 == ((store_RData 8 (ptr_offset v_0 144) v_36 st_34));
    when v_38, st_36 == ((iasm_228_spec st_35));
    when st_37 == ((store_RData 8 (ptr_offset v_0 152) v_38 st_36));
    when v_40, st_38 == ((iasm_229_spec st_37));
    when st_39 == ((store_RData 8 (ptr_offset v_0 160) v_40 st_38));
    when v_42, st_40 == ((iasm_230_spec st_39));
    when st_41 == ((store_RData 8 (ptr_offset v_0 168) v_42 st_40));
    when v_44, st_42 == ((iasm_231_spec st_41));
    when st_43 == ((store_RData 8 (ptr_offset v_0 176) v_44 st_42));
    when v_46, st_44 == ((iasm_get_tpidr_el1_spec st_43));
    when st_45 == ((store_RData 8 (ptr_offset v_0 184) v_46 st_44));
    when v_48, st_46 == ((iasm_233_spec st_45));
    when st_47 == ((store_RData 8 (ptr_offset v_0 192) v_48 st_46));
    when v_50, st_48 == ((iasm_234_spec st_47));
    when st_49 == ((store_RData 8 (ptr_offset v_0 200) v_50 st_48));
    when v_52, st_50 == ((iasm_get_par_el1_spec st_49));
    when st_51 == ((store_RData 8 (ptr_offset v_0 208) v_52 st_50));
    when v_54, st_52 == ((iasm_get_mdscr_el1_spec st_51));
    when st_53 == ((store_RData 8 (ptr_offset v_0 216) v_54 st_52));
    when v_56, st_54 == ((iasm_get_mdccint_el1_spec st_53));
    when st_55 == ((store_RData 8 (ptr_offset v_0 224) v_56 st_54));
    when v_58, st_56 == ((iasm_get_disr_el1_spec st_55));
    when st_57 == ((store_RData 8 (ptr_offset v_0 232) v_58 st_56));
    when v_60, st_58 == ((iasm_get_cntvoff_el2_spec st_57));
    when st_59 == ((store_RData 8 (ptr_offset v_0 256) v_60 st_58));
    when v_62, st_60 == ((iasm_7_spec st_59));
    when st_61 == ((store_RData 8 (ptr_offset v_0 264) v_62 st_60));
    when v_64, st_62 == ((iasm_139_spec st_61));
    when st_63 == ((store_RData 8 (ptr_offset v_0 272) v_64 st_62));
    when v_66, st_64 == ((iasm_6_spec st_63));
    when st_65 == ((store_RData 8 (ptr_offset v_0 280) v_66 st_64));
    when v_68, st_66 == ((iasm_136_spec st_65));
    when st_67 == ((store_RData 8 (ptr_offset v_0 288) v_68 st_66));
    (Some st_67).

  Definition restore_sysreg_state_spec (v_0: Ptr) (st: RData) : (option RData) :=
    when v_3, st_0 == ((load_RData 8 (ptr_offset v_0 0) st));
    when st_1 == ((iasm_set_sp_el0_spec v_3 st_0));
    when v_5, st_2 == ((load_RData 8 (ptr_offset v_0 8) st_1));
    when st_3 == ((iasm_set_sp_el1_spec v_5 st_2));
    when v_7, st_4 == ((load_RData 8 (ptr_offset v_0 16) st_3));
    when st_5 == ((iasm_153_spec v_7 st_4));
    when v_9, st_6 == ((load_RData 8 (ptr_offset v_0 24) st_5));
    when st_7 == ((iasm_154_spec v_9 st_6));
    when v_11, st_8 == ((load_RData 8 (ptr_offset v_0 32) st_7));
    when st_9 == ((iasm_set_pmcr_el0_spec v_11 st_8));
    when v_13, st_10 == ((load_RData 8 (ptr_offset v_0 40) st_9));
    when st_11 == ((iasm_set_pmuserenr_el0_spec v_13 st_10));
    when v_15, st_12 == ((load_RData 8 (ptr_offset v_0 48) st_11));
    when st_13 == ((iasm_set_tpidrro_el0_spec v_15 st_12));
    when v_17, st_14 == ((load_RData 8 (ptr_offset v_0 56) st_13));
    when st_15 == ((iasm_set_tpidr_el0_spec v_17 st_14));
    when v_19, st_16 == ((load_RData 8 (ptr_offset v_0 64) st_15));
    when st_17 == ((iasm_set_csselr_el1_spec v_19 st_16));
    when v_21, st_18 == ((load_RData 8 (ptr_offset v_0 72) st_17));
    when st_19 == ((iasm_75_spec v_21 st_18));
    when v_23, st_20 == ((load_RData 8 (ptr_offset v_0 80) st_19));
    when st_21 == ((iasm_set_actlr_el1_spec v_23 st_20));
    when v_25, st_22 == ((load_RData 8 (ptr_offset v_0 88) st_21));
    when st_23 == ((iasm_162_spec v_25 st_22));
    when v_27, st_24 == ((load_RData 8 (ptr_offset v_0 104) st_23));
    when st_25 == ((iasm_82_spec v_27 st_24));
    when v_29, st_26 == ((load_RData 8 (ptr_offset v_0 112) st_25));
    when st_27 == ((iasm_88_spec v_29 st_26));
    when v_31, st_28 == ((load_RData 8 (ptr_offset v_0 120) st_27));
    when st_29 == ((iasm_76_spec v_31 st_28));
    when v_33, st_30 == ((load_RData 8 (ptr_offset v_0 128) st_29));
    when st_31 == ((iasm_166_spec v_33 st_30));
    when v_35, st_32 == ((load_RData 8 (ptr_offset v_0 136) st_31));
    when st_33 == ((iasm_167_spec v_35 st_32));
    when v_37, st_34 == ((load_RData 8 (ptr_offset v_0 144) st_33));
    when st_35 == ((iasm_168_spec v_37 st_34));
    when v_39, st_36 == ((load_RData 8 (ptr_offset v_0 152) st_35));
    when st_37 == ((iasm_169_spec v_39 st_36));
    when v_41, st_38 == ((load_RData 8 (ptr_offset v_0 160) st_37));
    when st_39 == ((iasm_170_spec v_41 st_38));
    when v_43, st_40 == ((load_RData 8 (ptr_offset v_0 168) st_39));
    when st_41 == ((iasm_77_spec v_43 st_40));
    when v_45, st_42 == ((load_RData 8 (ptr_offset v_0 176) st_41));
    when st_43 == ((iasm_172_spec v_45 st_42));
    when v_47, st_44 == ((load_RData 8 (ptr_offset v_0 184) st_43));
    when st_45 == ((iasm_set_tpidr_el1_spec v_47 st_44));
    when v_49, st_46 == ((load_RData 8 (ptr_offset v_0 192) st_45));
    when st_47 == ((iasm_174_spec v_49 st_46));
    when v_51, st_48 == ((load_RData 8 (ptr_offset v_0 200) st_47));
    when st_49 == ((iasm_175_spec v_51 st_48));
    when v_53, st_50 == ((load_RData 8 (ptr_offset v_0 208) st_49));
    when st_51 == ((iasm_set_par_el1_spec v_53 st_50));
    when v_55, st_52 == ((load_RData 8 (ptr_offset v_0 216) st_51));
    when st_53 == ((iasm_set_mdscr_el1_spec v_55 st_52));
    when v_57, st_54 == ((load_RData 8 (ptr_offset v_0 224) st_53));
    when st_55 == ((iasm_set_mdccint_el1_spec v_57 st_54));
    when v_59, st_56 == ((load_RData 8 (ptr_offset v_0 232) st_55));
    when st_57 == ((iasm_set_disr_el1_spec v_59 st_56));
    when v_61, st_58 == ((load_RData 8 (ptr_offset v_0 512) st_57));
    when st_59 == ((iasm_set_vmpidr_el2_spec v_61 st_58));
    when v_63, st_60 == ((load_RData 8 (ptr_offset v_0 256) st_59));
    when st_61 == ((iasm_set_cntvoff_el2_spec v_63 st_60));
    when v_65, st_62 == ((load_RData 8 (ptr_offset v_0 272) st_61));
    when st_63 == ((iasm_182_spec v_65 st_62));
    when v_67, st_64 == ((load_RData 8 (ptr_offset v_0 264) st_63));
    when st_65 == ((iasm_183_spec v_67 st_64));
    when v_69, st_66 == ((load_RData 8 (ptr_offset v_0 288) st_65));
    when st_67 == ((iasm_184_spec v_69 st_66));
    when v_71, st_68 == ((load_RData 8 (ptr_offset v_0 280) st_67));
    when st_69 == ((iasm_185_spec v_71 st_68));
    (Some st_69).

  Definition realm_vtcr_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_2, st_0 == ((feat_vmid16_spec st));
    if v_2
    then (
      when v_5, st_2 == ((realm_ipa_bits_spec v_0 st_0));
      when v_6, st_3 == ((realm_rtt_starting_level_spec v_0 st_2));
      if (((v_6 =? (1)) || ((v_6 =? (2)))) || ((v_6 =? (3))))
      then (
        if ((v_6 =? (1)) || ((v_6 =? (2))))
        then (
          if (v_6 =? (1))
          then (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (0)), st_3))
          else (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (64)), st_3)))
        else (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (0)), st_3)))
      else (Some (((((0 - (v_5)) & (63)) |' (3221894400)) |' (128)), st_3)))
    else (
      when v_5, st_2 == ((realm_ipa_bits_spec v_0 st_0));
      when v_6, st_3 == ((realm_rtt_starting_level_spec v_0 st_2));
      if (((v_6 =? (1)) || ((v_6 =? (2)))) || ((v_6 =? (3))))
      then (
        if ((v_6 =? (1)) || ((v_6 =? (2))))
        then (
          if (v_6 =? (1))
          then (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (0)), st_3))
          else (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (64)), st_3)))
        else (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (0)), st_3)))
      else (Some (((((0 - (v_5)) & (63)) |' (3221370112)) |' (128)), st_3))).

  Definition validate_data_create_unknown_spec (v_0: Z) (v_1: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((is_addr_in_par_spec v_1 v_0 st));
    if v_3
    then (
      when v_7, st_1 == ((validate_map_addr_spec v_0 3 v_1 st_0));
      if (v_7 =? (0))
      then (
        when v_11, st_2 == ((make_return_code_spec 0 0 st_1));
        (Some (v_11, st_2)))
      else (
        when v_9, st_2 == ((make_return_code_spec 1 3 st_1));
        (Some (v_9, st_2))))
    else (
      when v_5, st_1 == ((make_return_code_spec 1 3 st_0));
      (Some (v_5, st_1))).

  Definition get_rd_state_locked_spec (v_0: Ptr) (st: RData) : (option (Z * RData)) :=
    when v_3, st_0 == ((__sca_read64_spec (ptr_offset v_0 0) st));
    (Some (v_3, st_0)).

  Fixpoint stage2_tlbi_ipa_loop210 (_N_: nat) (__break__: bool) (v__012: Z) (v__0911: Z) (st: RData) : (option (bool * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v__012, v__0911, st))
    | (S _N__0) =>
      match ((stage2_tlbi_ipa_loop210 _N__0 __break__ v__012 v__0911 st)) with
      | (Some (__break___0, v__13, v__912, st_0)) =>
        if __break___0
        then (Some (true, v__13, v__912, st_0))
        else (
          when st_1 == ((iasm_270_spec (v__13 >> (12)) st_0));
          if ((v__912 + (18446744073709547520)) =? (0))
          then (Some (true, v__13, v__912, st_1))
          else (Some (false, (v__13 + (4096)), (v__912 + (18446744073709547520)), st_1)))
      | None => None
      end
    end.

  Definition stage2_tlbi_ipa_spec (v_0: Ptr) (v_1: Z) (v_2: Z) (st: RData) : (option RData) :=
    when v_4, st_0 == ((iasm_get_vttbr_el2_spec st));
    when v_6, st_1 == ((load_RData 4 (ptr_offset v_0 24) st_0));
    when st_2 == ((iasm_set_vttbr_el2_spec (v_6 << (48)) st_1));
    when st_3 == ((iasm_12_isb_spec st_2));
    if (v_2 =? (0))
    then (
      when st_5 == ((iasm_10_spec st_3));
      when st_6 == ((iasm_258_spec st_5));
      when st_7 == ((iasm_10_spec st_6));
      when st_8 == ((iasm_12_isb_spec st_7));
      when st_9 == ((iasm_set_vttbr_el2_spec v_4 st_8));
      when st_10 == ((iasm_12_isb_spec st_9));
      (Some st_10))
    else (
      rely (((stage2_tlbi_ipa_loop210_rank v_1 v_2) >= (0)));
      match ((stage2_tlbi_ipa_loop210 (z_to_nat (stage2_tlbi_ipa_loop210_rank v_1 v_2)) false v_1 v_2 st_3)) with
      | (Some (__break__, v__13, v__912, st_4)) =>
        when st_6 == ((iasm_10_spec st_4));
        when st_7 == ((iasm_258_spec st_6));
        when st_8 == ((iasm_10_spec st_7));
        when st_9 == ((iasm_12_isb_spec st_8));
        when st_10 == ((iasm_set_vttbr_el2_spec v_4 st_9));
        when st_11 == ((iasm_12_isb_spec st_10));
        (Some st_11)
      | None => None
      end).

  Definition bitmap_test_and_set_spec (v_0: Ptr) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    rely ((((0 - ((v_1 >> (6)))) <= (0)) /\ (((v_1 >> (6)) < (1024)))));
    when v_7, st_0 == ((load_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) st));
    when st_1 == ((store_RData 8 (ptr_offset (mkPtr "vmids" 0) (8 * ((v_1 >> (6))))) (v_7 |' ((v_1 & (63)))) st_0));
    (Some (false, st_1)).

  Definition validate_rmm_feature_register_0_value_spec (v_0: Z) (st: RData) : (option (bool * RData)) :=
    when v_2, st_0 == ((rmm_feature_register_0_value_spec st));
    if (((v_0 & (255)) - ((v_2 & (255)))) >? (0))
    then (Some (false, st_0))
    else (
      if ((v_0 & (256)) =? (0))
      then (Some (true, st_0))
      else (Some (false, st_0))).

  Definition s2_inconsistent_sl_spec (v_0: Z) (v_1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((((40 + (((- 9) * (v_1)))) - (v_0)) >? (0)) || ((((52 + (((- 9) * (v_1)))) - (v_0)) <? (0)))), st)).

End Layer10_Spec.

#[global] Hint Unfold psci_reset_rec_spec: spec.
#[global] Hint Unfold granule_refcount_read_acquire_spec: spec.
#[global] Hint Unfold va_to_s1tte_spec: spec.
#[global] Hint Unfold timer_output_is_asserted_spec: spec.
#[global] Hint Unfold gic_save_state_loop235: spec.
#[global] Hint Unfold gic_save_state_loop230: spec.
#[global] Hint Unfold gic_save_state_spec: spec.
#[global] Hint Unfold save_sysreg_state_spec: spec.
#[global] Hint Unfold restore_sysreg_state_spec: spec.
#[global] Hint Unfold realm_vtcr_spec: spec.
#[global] Hint Unfold validate_data_create_unknown_spec: spec.
#[global] Hint Unfold get_rd_state_locked_spec: spec.
#[global] Hint Unfold stage2_tlbi_ipa_loop210: spec.
#[global] Hint Unfold stage2_tlbi_ipa_spec: spec.
#[global] Hint Unfold bitmap_test_and_set_spec: spec.
#[global] Hint Unfold validate_rmm_feature_register_0_value_spec: spec.
#[global] Hint Unfold s2_inconsistent_sl_spec: spec.
