Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer6_s2tt_init_unassigned_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint s2tt_init_unassigned_loop759_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_3: Z) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_3, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_unassigned_loop759_low _N__0 __break__ v_0 v_3 v_indvars_iv st)) with
      | (Some (__break___0, v_1, v_4, v_indvars_iv_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_4, v_indvars_iv_0, st_0))
        else (
          when st_1 == ((store_RData 8 (ptr_offset v_1 (8 * (v_indvars_iv_0))) v_4 st_0));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (Some (false, v_1, v_4, (v_indvars_iv_0 + (1)), st_1))
          else (Some (true, v_1, v_4, v_indvars_iv_0, st_1)))
      | None => None
      end
    end.

  Fixpoint s2tt_init_unassigned_loop759_0_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_3: Z) (v_index: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_3, v_index, st))
    | (S _N__0) =>
      match ((s2tt_init_unassigned_loop759_0_low _N__0 __break__ v_0 v_3 v_index st)) with
      | (Some (__break___0, v_1, v_4, v_index_0, st_0)) =>
        if __break___0
        then (Some (true, v_1, v_4, v_index_0, st_0))
        else (
          when st_1 == ((store_RData 8 (ptr_offset v_1 (8 * (v_index_0))) v_4 st_0));
          when st_2 == ((store_RData 8 (ptr_offset v_1 (8 * ((v_index_0 + (1))))) v_4 st_1));
          if ((v_index_0 + (2)) =? (512))
          then (Some (true, v_1, v_4, v_index_0, st_2))
          else (Some (false, v_1, v_4, (v_index_0 + (2)), st_2)))
      | None => None
      end
    end.

  Definition s2tt_init_unassigned_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option RData) :=
    when v_3, st_0 == ((s2tte_create_unassigned_spec v_1 st));
    rely (((s2tt_init_unassigned_loop759_0_rank v_0 v_3 0) >= (0)));
    match (
      match ((s2tt_init_unassigned_loop759_0_low (z_to_nat (s2tt_init_unassigned_loop759_0_rank v_0 v_3 0)) false v_0 v_3 0 st_0)) with
      | (Some (__break__, v_2, v_4, v_index_0, st_1)) =>
        when st_2 == ((iasm_10_spec st_1));
        (Some (true, 0, st_2))
      | None => None
      end
    ) with
    | (Some (__return__, v_bc_resume_val, st_1)) =>
      if __return__
      then (Some st_1)
      else (
        rely (((s2tt_init_unassigned_loop759_rank v_0 v_3 v_bc_resume_val) >= (0)));
        match ((s2tt_init_unassigned_loop759_low (z_to_nat (s2tt_init_unassigned_loop759_rank v_0 v_3 v_bc_resume_val)) false v_0 v_3 v_bc_resume_val st_1)) with
        | (Some (__break__, v_2, v_4, v_indvars_iv_0, st_2)) =>
          when st_3 == ((iasm_10_spec st_2));
          (Some st_3)
        | None => None
        end)
    | None => None
    end.

End Layer6_s2tt_init_unassigned_LowSpec.

#[global] Hint Unfold s2tt_init_unassigned_loop759_low: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop759_0_low: spec.
#[global] Hint Unfold s2tt_init_unassigned_spec_low: spec.
