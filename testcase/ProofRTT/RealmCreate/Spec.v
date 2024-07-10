Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section RealmCreate_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition free_sl_rtts_loop193_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Definition total_root_rtt_refcount_loop348_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_wide_trip_count: Z) : Z :=
    0.

  Definition vmid_free_spec (v_vmid: Z) (st: RData) : (option RData) :=
    rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
    (Some (lens 27 st)).

  Fixpoint free_sl_rtts_loop193 (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((free_sl_rtts_loop193 _N__0 __break__ v_g_rtt v_indvars_iv v_wide_trip_count st)) with
      | (Some (__break___0, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0))
        else (
          rely (((((((st_0.(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
          rely ((((v_g_rtt_0.(poffset)) mod (16)) = (0)));
          rely (((v_g_rtt_0.(pbase)) = ("granules")));
          when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (
            (Some (
              false  ,
              v_g_rtt_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_wide_trip_count_0  ,
              ((lens 30 st_0).[share].[slots] :< (((st_0.(share)).(slots)) # SLOT_RTT == (((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) >> (4))))
            )))
          else (
            (Some (
              true  ,
              v_g_rtt_0  ,
              v_indvars_iv_0  ,
              v_wide_trip_count_0  ,
              ((lens 30 st_0).[share].[slots] :< (((st_0.(share)).(slots)) # SLOT_RTT == (((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) >> (4))))
            ))))
      | None => None
      end
    end.

  Definition free_sl_rtts_spec (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option RData) :=
    if ((0 - (v_num_rtts)) <? (0))
    then (
      match ((free_sl_rtts_loop193 (z_to_nat 0) false v_g_rtt 0 v_num_rtts st)) with
      | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
      | None => None
      end)
    else (Some st).

  Fixpoint total_root_rtt_refcount_loop348 (_N_: nat) (__break__: bool) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_refcount_0_lcssa: Z) (v_wide_trip_count: Z) (st: RData) : (option (bool * Ptr * Z * Z * Z * Z * RData)) :=
    match (_N_) with
    | O => (Some (__break__, v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
    | (S _N__0) =>
      match ((total_root_rtt_refcount_loop348 _N__0 __break__ v_g_rtt v_indvars_iv v_refcount_08 v_refcount_0_lcssa v_wide_trip_count st)) with
      | (Some (__break___0, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) =>
        if __break___0
        then (Some (true, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0))
        else (
          rely (((((((st_0.(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE))).(e_state)) - (6)) = (0)));
          rely ((((v_g_rtt_0.(poffset)) mod (16)) = (0)));
          rely (((v_g_rtt_0.(pbase)) = ("granules")));
          when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (
            (Some (
              false  ,
              v_g_rtt_0  ,
              (v_indvars_iv_0 + (1))  ,
              ((((((lens 15 st_0).(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (8)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (v_refcount_9))  ,
              v_refcount_0_lcssa_0  ,
              v_wide_trip_count_0  ,
              (lens 31 st_0)
            )))
          else (
            (Some (
              true  ,
              v_g_rtt_0  ,
              v_indvars_iv_0  ,
              v_refcount_9  ,
              ((((((lens 15 st_0).(share)).(granules)) @ (((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (8)))) / (ST_GRANULE_SIZE))).(e_refcount)) + (v_refcount_9))  ,
              v_wide_trip_count_0  ,
              (lens 31 st_0)
            ))))
      | None => None
      end
    end.

  Definition total_root_rtt_refcount_spec (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option (Z * RData)) :=
    if ((0 - (v_num_rtts)) <? (0))
    then (
      match ((total_root_rtt_refcount_loop348 (z_to_nat 0) false v_g_rtt 0 0 0 v_num_rtts st)) with
      | (Some (__break__, v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) => (Some (v_refcount_0_lcssa_0, st_0))
      | None => None
      end)
    else (Some (0, st)).

End RealmCreate_Spec.

#[global] Hint Unfold free_sl_rtts_loop193_rank: spec.
#[global] Hint Unfold total_root_rtt_refcount_loop348_rank: spec.
#[global] Hint Unfold vmid_free_spec: spec.
#[global] Hint Unfold free_sl_rtts_loop193: spec.
#[global] Hint Unfold free_sl_rtts_spec: spec.
#[global] Hint Unfold total_root_rtt_refcount_loop348: spec.
#[global] Hint Unfold total_root_rtt_refcount_spec: spec.
