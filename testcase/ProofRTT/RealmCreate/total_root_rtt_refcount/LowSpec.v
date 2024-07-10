Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import RealmCreate.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmCreate_total_root_rtt_refcount_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint total_root_rtt_refcount_loop348_low (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_refcount_0_lcssa: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((total_root_rtt_refcount_loop348_low _N__0 __break__ v_g_rtt v_indvars_iv v_refcount_08 v_refcount_0_lcssa v_wide_trip_count st)) with
      | (Some (__break___0, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0))
        else (
          when st_1 == ((granule_lock_spec (ptr_offset v_g_rtt_0 ((16 * (v_indvars_iv_0)) + (0))) 6 st_0));
          when v_0, st_2 == ((load_RData 8 (ptr_offset v_g_rtt_0 ((16 * (v_indvars_iv_0)) + (8))) st_1));
          when st_3 == ((granule_unlock_spec (ptr_offset v_g_rtt_0 ((16 * (v_indvars_iv_0)) + (0))) st_2));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_g_rtt_0, (v_indvars_iv_0 + (1)), (v_0 + (v_refcount_9)), v_refcount_0_lcssa_0, v_wide_trip_count_0, st_3))
          else (Some (true, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, (v_0 + (v_refcount_9)), v_wide_trip_count_0, st_3)))
      | None => None
      end
    end.

  Definition total_root_rtt_refcount_spec_low (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option (Z * RData)) :=
    if ((0 - (v_num_rtts)) <? (0))
    then (
      rely (((total_root_rtt_refcount_loop348_rank v_g_rtt 0 0 v_num_rtts) >= (0)));
      match ((total_root_rtt_refcount_loop348_low (z_to_nat (total_root_rtt_refcount_loop348_rank v_g_rtt 0 0 v_num_rtts)) false v_g_rtt 0 0 0 v_num_rtts st)) with
      | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) => (Some (v_refcount_0_lcssa_0, st_0))
      | None => None
      end)
    else (Some (0, st)).

End RealmCreate_total_root_rtt_refcount_LowSpec.

#[global] Hint Unfold total_root_rtt_refcount_loop348_low: spec.
#[global] Hint Unfold total_root_rtt_refcount_spec_low: spec.
