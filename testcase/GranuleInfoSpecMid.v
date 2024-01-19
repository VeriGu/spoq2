Definition get_cached_llt_info_spec_mid (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  (anno (((24 * (16)) = (384)));
  (anno (((384 * (0)) = (0)));
  (anno ((((24 * (CPU_ID)) + (0)) = ((24 * (CPU_ID)))));
  (anno (((0 + ((24 * (CPU_ID)))) = ((24 * (CPU_ID)))));
  (Some ((mkPtr "llt_info_cache" (24 * (CPU_ID))), st)))))).

Definition slot_to_va_spec_mid (v_slot: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_slot << (12)) + (18446744073709420544)), st)).

Definition granule_unlock_transition_spec_mid (v_g: Ptr) (v_new_state: Z) (st: RData) : (option RData) :=
  rely (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\ ((true = (true))))
    | _ => ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))) /\ ((false = (true))))
    end);
  match (
    match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid) => (Some ((((st.(share)).(granules)) @ (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE))).[e_state] :< v_new_state))
    | _ => None
    end
  ) with
  | (Some ret) =>
    match (
      match ((((((st.(share)).(granules)) # (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) == ret) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
      | (Some cid) =>
        (Some ((st.[log] :<
          ((EVT
            CPU_ID 
            (REL
              ((v_g.(poffset)) / (ST_GRANULE_SIZE)) 
              ((((st.(share)).(granules)) # (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) == ret) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))))) ::
            ((st.(log))))).[share].[granules] :<
          (((st.(share)).(granules)) #
            (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) ==
            (((((st.(share)).(granules)) # (((v_g.(poffset)) + (4)) / (ST_GRANULE_SIZE)) == ret) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
      | _ => None
      end
    ) with
    | (Some st_1) => (Some st_1)
    | _ => None
    end
  | _ => None
  end.

Fixpoint find_lock_granules_loop197_mid (_N_: nat) (__break__: bool) (v_cmp235: bool) (v_granules: Ptr) (v_i_241: Z) (st: RData) : (option (bool * bool * Ptr * Z * RData)) :=
  match (_N_) with
  | O => (Some (__break__, v_cmp235, v_granules, v_i_241, st))
  | (S _N_) =>
    match ((find_lock_granules_loop197_mid _N_ __break__ v_cmp235 v_granules v_i_241 st)) with
    | (Some (__break__, v_cmp235, v_granules, v_i_241, st)) =>
      let v_g30 := (ptr_offset v_granules ((40 * (v_i_241)) + ((24 + (0))))) in
      when v_6_tmp, st == ((load_RData 8 v_g30 st));
      let v_6 := (int_to_ptr v_6_tmp) in
      let v_g_ret := (ptr_offset v_granules ((40 * (v_i_241)) + ((32 + (0))))) in
      when v_7_tmp, st == ((load_RData 8 v_g_ret st));
      let v_7 := (int_to_ptr v_7_tmp) in
      when st == ((store_RData 8 v_7 (ptr_to_int v_6) st));
      let v_inc33 := (v_i_241 + (1)) in
      let v_exitcond := (v_inc33 <>? (2)) in
      match (
        let __continue__ := false in
        if v_exitcond
        then (
          let v_i_241 := v_inc33 in
          let __continue__ := true in
          (Some (__continue__, __break__, v_cmp235, v_i_241, st)))
        else (
          let v_cmp235 := false in
          let __break__ := true in
          (Some (__continue__, __break__, v_cmp235, v_i_241, st)))
      ) with
      | (Some (__continue__, __break__, v_cmp235, v_i_241, st)) =>
        if __break__
        then (Some (__break__, v_cmp235, v_granules, v_i_241, st))
        else (
          if __continue__
          then (Some (__break__, v_cmp235, v_granules, v_i_241, st))
          else (Some (__break__, v_cmp235, v_granules, v_i_241, st)))
      | None => None
      end
    | None => None
    end
  end.

Fixpoint find_lock_granules_loop0_mid (_N_: nat) (__return__: bool) (__retval__: bool) (v_granules: Ptr) (v_i_143: Z) (st: RData) : (option (bool * bool * Ptr * Z * RData)) :=
  match (_N_) with
  | O => (Some (__return__, __retval__, v_granules, v_i_143, st))
  | (S _N_) =>
    match ((find_lock_granules_loop0_mid _N_ __return__ __retval__ v_granules v_i_143 st)) with
    | (Some (__return__, __retval__, v_granules, v_i_143, st)) =>
      let v_cmp5_not := (v_i_143 =? (0)) in
      when __break__, st == (
          let __break__ := false in
          if v_cmp5_not
          then (Some (__break__, st))
          else (
            let v_addr := (ptr_offset v_granules ((40 * (1)) + ((8 + (0))))) in
            when v_2, st == ((load_RData 8 v_addr st));
            let v_addr9 := (ptr_offset v_granules ((40 * (0)) + ((8 + (0))))) in
            when v_3, st == ((load_RData 8 v_addr9 st));
            let v_cmp10 := (v_2 =? (v_3)) in
            when __break__, st == (
                let __break__ := false in
                if v_cmp10
                then (
                  let __break__ := true in
                  (Some (__break__, st)))
                else (Some (__break__, st)));
            if __break__
            then (Some (__break__, st))
            else (Some (__break__, st))));
      if __break__
      then (Some (__return__, __retval__, v_granules, v_i_143, st))
      else (
        let v_addr13 := (ptr_offset v_granules ((40 * (v_i_143)) + ((8 + (0))))) in
        when v_4, st == ((load_RData 8 v_addr13 st));
        let v_state := (ptr_offset v_granules ((40 * (v_i_143)) + ((16 + (0))))) in
        when v_5, st == ((load_RData 4 v_state st));
        when v_call, st == ((find_lock_granule_spec v_4 v_5 st));
        let v_g := (ptr_offset v_granules ((40 * (v_i_143)) + ((24 + (0))))) in
        when st == ((store_RData 8 v_g (ptr_to_int v_call) st));
        let v_cmp18 := (ptr_eqb v_call (mkPtr "null" 0)) in
        match (
          let __continue__ := false in
          if v_cmp18
          then (
            let __break__ := true in
            (Some (__break__, __continue__, __return__, __retval__, v_i_143, st)))
          else (
            let v_inc23 := (v_i_143 + (1)) in
            let v_cmp2 := (v_inc23 <? (2)) in
            match (
              let __continue__ := false in
              if v_cmp2
              then (
                let v_i_143 := 1 in
                (Some (__break__, __continue__, __return__, __retval__, v_i_143, st)))
              else (
                let v_i_241 := 0 in
                rely (((find_lock_granules_loop197_rank v_granules v_i_241) >= (0)));
                match ((find_lock_granules_loop197_mid (z_to_nat (find_lock_granules_loop197_rank v_granules v_i_241)) false false v_granules v_i_241 st)) with
                | (Some (__break__, v_cmp235, v_granules, v_i_241, st)) =>
                  if __break__
                  then (
                    let v_9 := (xorb v_cmp235 true) in
                    let __return__ := true in
                    let __retval__ := v_9 in
                    (Some (__break__, __continue__, __return__, __retval__, v_i_143, st)))
                  else None
                | None => None
                end)
            ) with
            | (Some (__break__, __continue__, __return__, __retval__, v_i_143, st)) =>
              if __return__
              then (Some (__break__, __continue__, __return__, __retval__, v_i_143, st))
              else (
                if __break__
                then (Some (__break__, __continue__, __return__, __retval__, v_i_143, st))
                else (
                  if __continue__
                  then (Some (__break__, __continue__, __return__, __retval__, v_i_143, st))
                  else (
                    let __continue__ := true in
                    (Some (__break__, __continue__, __return__, __retval__, v_i_143, st)))))
            | None => None
            end)
        ) with
        | (Some (__break__, __continue__, __return__, __retval__, v_i_143, st)) =>
          if __return__
          then (Some (__return__, __retval__, v_granules, v_i_143, st))
          else (
            if __break__
            then (Some (__return__, __retval__, v_granules, v_i_143, st))
            else (
              if __continue__
              then (Some (__return__, __retval__, v_granules, v_i_143, st))
              else (Some (__return__, __retval__, v_granules, v_i_143, st))))
        | None => None
        end)
    | None => None
    end
  end.

Definition find_lock_granules_spec_mid (v_granules: Ptr) (v_n: Z) (st: RData) : (option (bool * RData)) :=
  rely (((v_granules.(pbase)) = ("find_lock_two_granules_stack")));
  let v_0 := (ptr_offset v_granules ((40 * (0)) + ((0 + (0))))) in
  let v_1 := (ptr_offset v_granules ((40 * (1)) + ((0 + (0))))) in
  when st == ((store_RData 4 v_0 0 st));
  when st == ((store_RData 4 v_1 1 st));
  when st == ((sort_granules_spec v_granules 2 st));
  let v_i_143 := 0 in
  rely (((find_lock_granules_loop0_rank v_granules v_i_143) >= (0)));
  match ((find_lock_granules_loop0_mid (z_to_nat (find_lock_granules_loop0_rank v_granules v_i_143)) false false v_granules v_i_143 st)) with
  | (Some (__return__, __retval__, v_granules, v_i_143, st)) =>
    if __return__
    then (Some (__retval__, st))
    else (
      let v_i_337 := (v_i_143 + ((- 1))) in
      let v_cmp3738 := (v_i_143 >? (0)) in
      when st == (
          if v_cmp3738
          then (
            let v_g41 := (ptr_offset v_granules ((40 * (v_i_337)) + ((24 + (0))))) in
            when v_8_tmp, st == ((load_RData 8 v_g41 st));
            let v_8 := (int_to_ptr v_8_tmp) in
            when st == ((granule_unlock_spec v_8 st));
            let v_i_3 := (v_i_337 + ((- 1))) in
            (Some st))
          else (Some st));
      let v_cmp235 := true in
      let v_9 := (xorb v_cmp235 true) in
      let __return__ := true in
      let __retval__ := v_9 in
      (Some (__retval__, st)))
  | None => None
  end.

