Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Layer12_total_root_rtt_refcount_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint total_root_rtt_refcount_loop295_low (_N_: nat) (__break__: bool) (v_0: Ptr) (v__011: Z) (v__0_lcssa: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_0, v__011, v__0_lcssa, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((total_root_rtt_refcount_loop295_low _N__0 __break__ v_0 v__011 v__0_lcssa v_indvars_iv v_wide_trip_count st)) with
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

  Definition total_root_rtt_refcount_loop295_rank (v_0: Ptr) (v__011: Z) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Definition total_root_rtt_refcount_spec_low (v_0: Ptr) (v_1: Z) (st: RData) : (option (Z * RData)) :=
    if ((0 - (v_1)) <? (0))
    then (
      rely (((total_root_rtt_refcount_loop295_rank v_0 0 0 v_1) >= (0)));
      match ((total_root_rtt_refcount_loop295_low (z_to_nat (total_root_rtt_refcount_loop295_rank v_0 0 0 v_1)) false v_0 0 0 0 v_1 st)) with
      | (Some (__break__, v_2, v__12, v__0_lcssa_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some (v__0_lcssa_0, st_0))
      | None => None
      end)
    else (Some (0, st)).

End Layer12_total_root_rtt_refcount_LowSpec.

#[global] Hint Unfold total_root_rtt_refcount_loop295_low: spec.
#[global] Hint Unfold total_root_rtt_refcount_loop295_rank: spec.
#[global] Hint Unfold total_root_rtt_refcount_spec_low: spec.
