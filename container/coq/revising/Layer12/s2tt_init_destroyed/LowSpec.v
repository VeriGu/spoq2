Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_s2tt_init_destroyed_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint s2tt_init_destroyed_loop776_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_indvars_iv: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_indvars_iv, st))
    | (S _N__0) =>
      match ((s2tt_init_destroyed_loop776_low _N__0 __break__ v_0 v_indvars_iv st)) with
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

  Definition s2tt_init_destroyed_loop776_rank (v_0: Ptr) (v_indvars_iv: Z) : Z :=
    0.

  Fixpoint s2tt_init_destroyed_loop776_0_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v_index: Z) (st: RData) : (option (bool * Ptr * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v_index, st))
    | (S _N__0) =>
      match ((s2tt_init_destroyed_loop776_0_low _N__0 __break__ v_0 v_index st)) with
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

  Definition s2tt_init_destroyed_loop776_0_rank (v_0: Ptr) (v_index: Z) : Z :=
    0.

  Definition s2tt_init_destroyed_spec_low (v_0: Ptr) (st: RData) : (option RData) :=
    rely (((s2tt_init_destroyed_loop776_0_rank v_0 0) >= (0)));
    match (
      match ((s2tt_init_destroyed_loop776_0_low (z_to_nat (s2tt_init_destroyed_loop776_0_rank v_0 0)) false v_0 0 st)) with
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
        match ((s2tt_init_destroyed_loop776_low (z_to_nat (s2tt_init_destroyed_loop776_rank v_0 v_bc_resume_val)) false v_0 v_bc_resume_val st_0)) with
        | (Some (__break__, v_1, v_indvars_iv_0, st_1)) =>
          when st_2 == ((iasm_10_spec st_1));
          (Some st_2)
        | None => None
        end)
    | None => None
    end.

End Layer12_s2tt_init_destroyed_LowSpec.

#[global] Hint Unfold s2tt_init_destroyed_loop776_low: spec.
#[global] Hint Unfold s2tt_init_destroyed_loop776_rank: spec.
#[global] Hint Unfold s2tt_init_destroyed_loop776_0_low: spec.
#[global] Hint Unfold s2tt_init_destroyed_loop776_0_rank: spec.
#[global] Hint Unfold s2tt_init_destroyed_spec_low: spec.
