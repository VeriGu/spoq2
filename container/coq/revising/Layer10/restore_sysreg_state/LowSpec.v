Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_restore_sysreg_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Definition restore_sysreg_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
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

End Layer10_restore_sysreg_state_LowSpec.

#[global] Hint Unfold restore_sysreg_state_spec_low: spec.
