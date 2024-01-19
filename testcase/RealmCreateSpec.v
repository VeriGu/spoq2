Definition free_sl_rtts_loop193_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) : Z :=
  (v_wide_trip_count - (v_indvars_iv)).

Definition total_root_rtt_refcount_loop348_rank (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_wide_trip_count: Z) : Z :=
  (v_wide_trip_count - (v_indvars_iv)).

Definition vmid_reserve_spec (v_vmid: Z) (st: RData) : (option (bool * RData)) :=
  if (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
    then ((65536 - (v_vmid)) >? (0))
    else ((256 - (v_vmid)) >? (0)))
  then (
    rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
    (Some (
      (xorb (Z.testbit (((st.(share)).(gv_vmids)) @ (v_vmid >> (6))) (v_vmid & (63))) true)  ,
      (st.[share].[gv_vmids] :< (((st.(share)).(gv_vmids)) # (v_vmid >> (6)) == (Z.setbit (((st.(share)).(gv_vmids)) @ (v_vmid >> (6))) (v_vmid & (63)))))
    )))
  else (Some (false, st)).

Definition vmid_free_spec (v_vmid: Z) (st: RData) : (option RData) :=
  rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
  (Some (st.[share].[gv_vmids] :< (((st.(share)).(gv_vmids)) # (v_vmid >> (6)) == (Z.clearbit (((st.(share)).(gv_vmids)) @ (v_vmid >> (6))) (v_vmid & (63)))))).

Definition validate_ipa_bits_and_sl_spec' (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option bool) :=
  if ((v_ipa_bits + ((- 49))) <? ((- 17)))
  then (Some false)
  else (
    if (v_sl >? (3))
    then (Some false)
    else (
      if (v_sl =? (0))
      then (
        when ret == ((arch_feat_get_pa_width_spec' st));
        if (ret <? (44))
        then (Some false)
        else (Some (xorb (((40 - (v_ipa_bits)) >? (0)) || (((52 - (v_ipa_bits)) <? (0)))) true)))
      else (Some (xorb ((((40 + (((- 9) * (v_sl)))) - (v_ipa_bits)) >? (0)) || ((((52 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0)))) true)))).

Definition validate_ipa_bits_and_sl_spec (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (bool * RData)) :=
  when ret == ((validate_ipa_bits_and_sl_spec' v_ipa_bits v_sl st));
  (Some (ret, st)).

Definition validate_feature_register_spec' (v_index: Z) (v_value: Z) (st: RData) : (option bool) :=
  if (v_index =? (0))
  then (
    when ret == ((validate_feature_register_0_spec' v_value st));
    (Some ret))
  else (Some false).

Definition validate_feature_register_spec (v_index: Z) (v_value: Z) (st: RData) : (option (bool * RData)) :=
  when ret == ((validate_feature_register_spec' v_index v_value st));
  (Some (ret, st)).

Fixpoint free_sl_rtts_loop193 (_N_: nat) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (Ptr * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((free_sl_rtts_loop193 _N__0 v_g_rtt v_indvars_iv v_wide_trip_count st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
      rely (((v_g_rtt_0.(pbase)) = ("granules")));
      rely ((("granules" = ("granules")) /\ (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)))));
      when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
      match ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_lock))) with
      | None =>
        rely (((((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_state)) - (6)) =? (0)) = (true)));
        rely (
          ((((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
            ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
        rely (
          if ((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) + (4)) =? (4))
          then ((("granules" = ("granules")) /\ ((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) = (0)))) /\ ((true = (true))))
          else ((("granules" = ("granules")) /\ (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)))) /\ ((false = (true)))));
        if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
        then (
          (Some (
            v_g_rtt_0  ,
            (v_indvars_iv_0 + (1))  ,
            v_wide_trip_count_0  ,
            ((st_0.[log] :<
              ((EVT
                CPU_ID 
                (REL
                  ((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) 
                  ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
              ((sh.[granules] :<
                ((sh.(granules)) #
                  (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)) ==
                  ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< None).[e_state] :< 1))).[slots] :<
                ((sh.(slots)) # SLOT_RTT == (- 1))))
          )))
        else (
          (Some (
            v_g_rtt_0  ,
            v_indvars_iv_0  ,
            v_wide_trip_count_0  ,
            ((st_0.[log] :<
              ((EVT
                CPU_ID 
                (REL
                  ((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) 
                  ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< (Some CPU_ID)).[e_state] :< 1))) ::
                (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
              ((sh.[granules] :<
                ((sh.(granules)) #
                  (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)) ==
                  ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< None).[e_state] :< 1))).[slots] :<
                ((sh.(slots)) # SLOT_RTT == (- 1))))
          )))
      | (Some cid) => None
      end
    | None => None
    end
  end.

Definition free_sl_rtts_spec (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option RData) :=
  rely (((v_g_rtt.(pbase)) = ("granules")));
  if ((0 - (v_num_rtts)) <? (0))
  then (
    match ((free_sl_rtts_loop193 (z_to_nat v_num_rtts) v_g_rtt 0 v_num_rtts st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
    | None => None
    end)
  else (Some st).

Fixpoint total_root_rtt_refcount_loop348 (_N_: nat) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_refcount_0_lcssa: Z) (v_wide_trip_count: Z) (st: RData) : (option (Ptr * Z * Z * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((total_root_rtt_refcount_loop348 _N__0 v_g_rtt v_indvars_iv v_refcount_08 v_refcount_0_lcssa v_wide_trip_count st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) =>
      rely (((v_g_rtt_0.(pbase)) = ("granules")));
      rely ((("granules" = ("granules")) /\ (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)))));
      when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
      match ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_lock))) with
      | None =>
        if (((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_state)) - (6)) =? (0))
        then (
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (
            (Some (
              v_g_rtt_0  ,
              (v_indvars_iv_0 + (1))  ,
              ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_refcount)) + (v_refcount_9))  ,
              v_refcount_0_lcssa_0  ,
              v_wide_trip_count_0  ,
              ((st_0.[log] :<
                ((EVT
                  CPU_ID 
                  (REL
                    (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)) 
                    (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
                (sh.[granules] :<
                  ((sh.(granules)) #
                    (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)) ==
                    (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< None))))
            )))
          else (
            (Some (
              v_g_rtt_0  ,
              v_indvars_iv_0  ,
              v_refcount_9  ,
              ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_refcount)) + (v_refcount_9))  ,
              v_wide_trip_count_0  ,
              ((st_0.[log] :<
                ((EVT
                  CPU_ID 
                  (REL
                    (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)) 
                    (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< (Some CPU_ID)))) ::
                  (((EVT CPU_ID (ACQ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)))) :: ((((st_0.(oracle)) (st_0.(log))) ++ ((st_0.(log))))))))).[share] :<
                (sh.[granules] :<
                  ((sh.(granules)) #
                    (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0)) ==
                    (((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).[e_lock] :< None))))
            ))))
        else None
      | (Some cid) => None
      end
    | None => None
    end
  end.

Definition total_root_rtt_refcount_spec (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option (Z * RData)) :=
  rely (((v_g_rtt.(pbase)) = ("granules")));
  if ((0 - (v_num_rtts)) <? (0))
  then (
    match ((total_root_rtt_refcount_loop348 (z_to_nat v_num_rtts) v_g_rtt 0 0 0 v_num_rtts st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) => (Some (v_refcount_0_lcssa_0, st_0))
    | None => None
    end)
  else (Some (0, st)).

