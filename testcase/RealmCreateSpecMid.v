Definition vmid_reserve_spec_mid (v_vmid: Z) (st: RData) : (option (bool * RData)) :=
  if (
    if (((((st.(priv)).(pcpu_regs)).(pcpu_id_aa64mmfr1_el1)) & (240)) =? (32))
    then ((65536 - (v_vmid)) >? (0))
    else ((256 - (v_vmid)) >? (0)))
  then (
    rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
    (anno (((8 * (1024)) = (8192)));
    (anno (((8192 * (0)) = (0)));
    (anno ((((0 + ((0 + (((8 * ((v_vmid >> (6)))) + (0)))))) / (8)) = (((0 / (8)) + (((0 + (((8 * ((v_vmid >> (6)))) + (0)))) / (8)))))));
    (anno ((((0 + (((8 * ((v_vmid >> (6)))) + (0)))) / (8)) = (((0 / (8)) + ((((8 * ((v_vmid >> (6)))) + (0)) / (8)))))));
    (anno (((((8 * ((v_vmid >> (6)))) + (0)) / (8)) = ((((8 * ((v_vmid >> (6)))) / (8)) + ((0 / (8)))))));
    (anno (((0 / (8)) = (0)));
    (anno ((((8 * ((v_vmid >> (6)))) / (8)) = ((v_vmid >> (6)))));
    (anno ((((v_vmid >> (6)) + (0)) = ((v_vmid >> (6)))));
    (anno (((0 + ((v_vmid >> (6)))) = ((v_vmid >> (6)))));
    (Some (
      (xorb (Z.testbit (((st.(share)).(gv_vmids)) @ (v_vmid >> (6))) (v_vmid & (63))) true)  ,
      (st.[share].[gv_vmids] :< (((st.(share)).(gv_vmids)) # (v_vmid >> (6)) == (Z.setbit (((st.(share)).(gv_vmids)) @ (v_vmid >> (6))) (v_vmid & (63)))))
    ))))))))))))
  else (Some (false, st)).

Definition vmid_free_spec_mid (v_vmid: Z) (st: RData) : (option RData) :=
  rely ((((0 - ((v_vmid >> (6)))) <= (0)) /\ (((v_vmid >> (6)) < (1024)))));
  (anno (((8 * (1024)) = (8192)));
  (anno (((8192 * (0)) = (0)));
  (anno ((((0 + ((0 + (((8 * ((v_vmid >> (6)))) + (0)))))) / (8)) = (((0 / (8)) + (((0 + (((8 * ((v_vmid >> (6)))) + (0)))) / (8)))))));
  (anno ((((0 + (((8 * ((v_vmid >> (6)))) + (0)))) / (8)) = (((0 / (8)) + ((((8 * ((v_vmid >> (6)))) + (0)) / (8)))))));
  (anno (((((8 * ((v_vmid >> (6)))) + (0)) / (8)) = ((((8 * ((v_vmid >> (6)))) / (8)) + ((0 / (8)))))));
  (anno (((0 / (8)) = (0)));
  (anno ((((8 * ((v_vmid >> (6)))) / (8)) = ((v_vmid >> (6)))));
  (anno ((((v_vmid >> (6)) + (0)) = ((v_vmid >> (6)))));
  (anno (((0 + ((v_vmid >> (6)))) = ((v_vmid >> (6)))));
  (Some (st.[share].[gv_vmids] :< (((st.(share)).(gv_vmids)) # (v_vmid >> (6)) == (Z.clearbit (((st.(share)).(gv_vmids)) @ (v_vmid >> (6))) (v_vmid & (63))))))))))))))).

Definition validate_ipa_bits_and_sl_spec_mid (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (bool * RData)) :=
  if ((v_ipa_bits + ((- 49))) <? ((- 17)))
  then (Some (false, st))
  else (
    if (v_sl >? (3))
    then (Some (false, st))
    else (
      if (v_sl =? (0))
      then (
        when ret == ((arch_feat_get_pa_width_spec' st));
        if (ret <? (44))
        then (Some (false, st))
        else (
          (anno (((- 9) = ((- 9))));
          (anno (((40 + (v_sl)) = (40)));
          (anno ((((- 9) * (v_sl)) = (v_sl)));
          (anno (((52 + (v_sl)) = (52)));
          (Some ((xorb (((40 - (v_ipa_bits)) >? (0)) || (((52 - (v_ipa_bits)) <? (0)))) true), st))))))))
      else (
        (anno (((- 9) = ((- 9))));
        (Some ((xorb ((((40 + (((- 9) * (v_sl)))) - (v_ipa_bits)) >? (0)) || ((((52 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0)))) true), st)))))).

Definition validate_feature_register_spec_mid (v_index: Z) (v_value: Z) (st: RData) : (option (bool * RData)) :=
  if (v_index =? (0))
  then (
    when ret == ((validate_feature_register_0_spec' v_value st));
    (Some (ret, st)))
  else (Some (false, st)).

Fixpoint free_sl_rtts_loop193_mid (_N_: nat) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_wide_trip_count: Z) (st: RData) : (option (Ptr * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (v_g_rtt, v_indvars_iv, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((free_sl_rtts_loop193_mid _N__0 v_g_rtt v_indvars_iv v_wide_trip_count st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) =>
      rely (((v_g_rtt_0.(pbase)) = ("granules")));
      (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
      rely ((("granules" = ("granules")) /\ (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)))));
      when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
      (anno (
        ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE)) =
          ((((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + ((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)))))));
      (anno (((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)) = ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
      (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
      (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
      (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
      match ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_lock))) with
      | None =>
        (anno (
          ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE)) =
            ((((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + ((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)))))));
        (anno (((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)) = ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
        (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
        (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
        (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
        rely (((((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_state)) - (6)) =? (0)) = (true)));
        (anno (
          ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE)) =
            ((((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + ((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)))))));
        (anno (((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)) = ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
        (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
        rely (
          ((((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)) /\ (("granules" = ("granules")))) /\
            ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
        (anno (((22 - (22)) = (0)));
        (anno (((- 1) = ((- 1))));
        (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
        rely (
          if ((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) + (4)) =? (4))
          then (
            (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
            (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
            (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
            (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
            ((("granules" = ("granules")) /\ ((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) = (0)))) /\ ((true = (true)))))))))
          else (
            (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
            ((("granules" = ("granules")) /\ (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)))) /\ ((false = (true)))))));
        (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
        (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
        (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
        (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
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
          ))))))))))))))))))
      | (Some cid) => None
      end))))))
    | None => None
    end
  end.

Definition free_sl_rtts_spec_mid (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option RData) :=
  rely (((v_g_rtt.(pbase)) = ("granules")));
  if ((0 - (v_num_rtts)) <? (0))
  then (
    (anno (((v_num_rtts - (0)) = (v_num_rtts)));
    match ((free_sl_rtts_loop193_mid (z_to_nat v_num_rtts) v_g_rtt 0 v_num_rtts st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_wide_trip_count_0, st_0)) => (Some st_0)
    | None => None
    end))
  else (Some st).

Fixpoint total_root_rtt_refcount_loop348_mid (_N_: nat) (v_g_rtt: Ptr) (v_indvars_iv: Z) (v_refcount_08: Z) (v_refcount_0_lcssa: Z) (v_wide_trip_count: Z) (st: RData) : (option (Ptr * Z * Z * Z * Z * RData)) :=
  match (_N_) with
  | O => (Some (v_g_rtt, v_indvars_iv, v_refcount_08, v_refcount_0_lcssa, v_wide_trip_count, st))
  | (S _N__0) =>
    match ((total_root_rtt_refcount_loop348_mid _N__0 v_g_rtt v_indvars_iv v_refcount_08 v_refcount_0_lcssa v_wide_trip_count st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) =>
      rely (((v_g_rtt_0.(pbase)) = ("granules")));
      (anno ((((16 * (v_indvars_iv_0)) + (0)) = ((16 * (v_indvars_iv_0)))));
      rely ((("granules" = ("granules")) /\ (((((v_g_rtt_0.(poffset)) + ((16 * (v_indvars_iv_0)))) mod (ST_GRANULE_SIZE)) = (0)))));
      when sh == (((st_0.(repl)) ((st_0.(oracle)) (st_0.(log))) (st_0.(share))));
      (anno (
        ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE)) =
          ((((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + ((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)))))));
      (anno (((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)) = ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
      (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
      (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
      (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
      match ((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_lock))) with
      | None =>
        (anno (
          ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE)) =
            ((((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + ((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)))))));
        (anno (((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)) = ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
        (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
        (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
        (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
        if (((((sh.(granules)) @ (((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + (v_indvars_iv_0))).(e_state)) - (6)) =? (0))
        then (
          (anno (((8 + (0)) = (8)));
          (anno ((((16 * (v_indvars_iv_0)) + (8)) = ((8 * (((2 * (v_indvars_iv_0)) + (1)))))));
          (anno (
            ((((v_g_rtt_0.(poffset)) + (((16 * (v_indvars_iv_0)) + (0)))) / (ST_GRANULE_SIZE)) =
              ((((v_g_rtt_0.(poffset)) / (ST_GRANULE_SIZE)) + ((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)))))));
          (anno (((((16 * (v_indvars_iv_0)) + (0)) / (ST_GRANULE_SIZE)) = ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) + ((0 / (ST_GRANULE_SIZE)))))));
          if (((v_indvars_iv_0 + (1)) - (v_wide_trip_count_0)) <>? (0))
          then (
            (anno (((8 * (((2 * (v_indvars_iv_0)) + (1)))) = ((8 + ((16 * (v_indvars_iv_0)))))));
            (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
            (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
            (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
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
            )))))))
          else (
            (anno (((8 * (((2 * (v_indvars_iv_0)) + (1)))) = ((8 + ((16 * (v_indvars_iv_0)))))));
            (anno ((((16 * (v_indvars_iv_0)) / (ST_GRANULE_SIZE)) = (v_indvars_iv_0)));
            (anno (((0 / (ST_GRANULE_SIZE)) = (0)));
            (anno (((v_indvars_iv_0 + (0)) = (v_indvars_iv_0)));
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
            ))))))))))))
        else None)))))
      | (Some cid) => None
      end))))))
    | None => None
    end
  end.

Definition total_root_rtt_refcount_spec_mid (v_g_rtt: Ptr) (v_num_rtts: Z) (st: RData) : (option (Z * RData)) :=
  rely (((v_g_rtt.(pbase)) = ("granules")));
  if ((0 - (v_num_rtts)) <? (0))
  then (
    (anno (((v_num_rtts - (0)) = (v_num_rtts)));
    match ((total_root_rtt_refcount_loop348_mid (z_to_nat v_num_rtts) v_g_rtt 0 0 0 v_num_rtts st)) with
    | (Some (v_g_rtt_0, v_indvars_iv_0, v_refcount_9, v_refcount_0_lcssa_0, v_wide_trip_count_0, st_0)) => (Some (v_refcount_0_lcssa_0, st_0))
    | None => None
    end))
  else (Some (0, st)).

