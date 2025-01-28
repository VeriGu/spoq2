Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer10_gic_save_state_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint gic_save_state_loop235_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv, st))
    | (S _N__0) =>
      match ((gic_save_state_loop235_low _N__0 __break__ v_0 v_indvars_iv st)) with
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

  Definition gic_save_state_loop235_rank (v_0: Ptr) (v_indvars_iv: Z) : Z :=
    0.

  Fixpoint gic_save_state_loop230_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv27: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv27, st))
    | (S _N__0) =>
      match ((gic_save_state_loop230_low _N__0 __break__ v_0 v_indvars_iv27 st)) with
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

  Definition gic_save_state_loop230_rank (v_0: Ptr) (v_indvars_iv27: Z) : Z :=
    0.

  Definition gic_save_state_0_low (st_3: RData) (v_0: Ptr) (v_15: Z) : (option RData) :=
    rely ((((0 - (v_15)) <? (0)) = (true)));
    rely (((gic_save_state_loop235_rank v_0 0) >= (0)));
    match ((gic_save_state_loop235_low (z_to_nat (gic_save_state_loop235_rank v_0 0)) false v_0 0 st_3)) with
    | (Some (__break___0, v_3, v_indvars_iv_0, st_4)) =>
      when v_25, st_6 == ((iasm_37_spec st_4));
      when st_7 == ((store_RData 8 (ptr_offset v_0 64) v_25 st_6));
      when v_27, st_8 == ((iasm_38_spec st_7));
      when st_9 == ((store_RData 8 (ptr_offset v_0 72) v_27 st_8));
      when v_29, st_10 == ((iasm_39_spec st_9));
      when st_11 == ((store_RData 8 (ptr_offset v_0 208) v_29 st_10));
      when st_12 == ((gic_restore_state_spec (mkPtr "default_gicstate" 0) st_11));
      (Some st_12)
    | None => None
    end.

  Definition gic_save_state_1_low (st_2: RData) (v_0: Ptr) (v_15: Z) : (option RData) :=
    rely ((((0 - (v_15)) <? (0)) = (true)));
    rely (((gic_save_state_loop235_rank v_0 0) >= (0)));
    match ((gic_save_state_loop235_low (z_to_nat (gic_save_state_loop235_rank v_0 0)) false v_0 0 st_2)) with
    | (Some (__break__, v_1, v_indvars_iv_0, st_3)) =>
      when v_25, st_5 == ((iasm_37_spec st_3));
      when st_6 == ((store_RData 8 (ptr_offset v_0 64) v_25 st_5));
      when v_27, st_7 == ((iasm_38_spec st_6));
      when st_8 == ((store_RData 8 (ptr_offset v_0 72) v_27 st_7));
      when v_29, st_9 == ((iasm_39_spec st_8));
      when st_10 == ((store_RData 8 (ptr_offset v_0 208) v_29 st_9));
      when st_11 == ((gic_restore_state_spec (mkPtr "default_gicstate" 0) st_10));
      (Some st_11)
    | None => None
    end.

  Definition gic_save_state_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    when v_2, st_0 == ((load_RData 4 (mkPtr "nr_aprs" 0) st));
    if ((0 - (v_2)) <? (0))
    then (
      rely (((gic_save_state_loop230_rank v_0 0) >= (0)));
      match ((gic_save_state_loop230_low (z_to_nat (gic_save_state_loop230_rank v_0 0)) false v_0 0 st_0)) with
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



End Layer10_gic_save_state_LowSpec.

#[global] Hint Unfold gic_save_state_loop235_low: spec.
#[global] Hint Unfold gic_save_state_loop235_rank: spec.
#[global] Hint Unfold gic_save_state_loop230_low: spec.
#[global] Hint Unfold gic_save_state_loop230_rank: spec.
#[global] Hint Unfold gic_save_state_spec_low: spec.
#[global] Hint Unfold gic_save_state_0_low: spec.
#[global] Hint Unfold gic_save_state_1_low: spec.
