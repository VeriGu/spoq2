Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import MemRW.Spec.
Require Import RealmCreate.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmCreate_free_sl_rtts_LowSpec.

  Context `{int_ptr: IntPtrCast}.

  Fixpoint free_sl_rtts_loop193_low (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((free_sl_rtts_loop193_low _N__0 __break__ v_g_rtt v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          when st_1 == ((granule_lock_spec (ptr_offset v_g_rtt_0 ((16 * (v_indvars_iv_0)) + (0))) 6 st_0));
          when st_2 == ((granule_memzero_spec (ptr_offset v_g_rtt_0 ((16 * (v_indvars_iv_0)) + (0))) 22 st_1));
          when st_3 == ((granule_unlock_transition_spec (ptr_offset v_g_rtt_0 ((16 * (v_indvars_iv_0)) + (0))) 1 st_2));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (Some (false, v_g_rtt_0, (v_indvars_iv_0 + (1)), v_wide_trip_count_0, st_3))
          else (Some (true, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_3)))
      | None => None
      end
    end.

  Definition free_sl_rtts_spec_low (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option RData) :=
    if ((0 - (v_num_rtts)) <? (0))
    then (
      rely (((free_sl_rtts_loop193_rank v_g_rtt 0 v_num_rtts) >= (0)));
      match ((free_sl_rtts_loop193_low (z_to_nat (free_sl_rtts_loop193_rank v_g_rtt 0 v_num_rtts)) false v_g_rtt 0 v_num_rtts st)) with
      | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
      | None => None
      end)
    else (Some st).

End RealmCreate_free_sl_rtts_LowSpec.

#[global] Hint Unfold free_sl_rtts_loop193_low: spec.
#[global] Hint Unfold free_sl_rtts_spec_low: spec.
