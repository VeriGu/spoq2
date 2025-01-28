Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_save_sysreg_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition save_sysreg_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
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

End Layer10_save_sysreg_state_LowSpec.

#[global] Hint Unfold save_sysreg_state_spec_low: spec.
