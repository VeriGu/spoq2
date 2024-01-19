Definition find_lock_unused_granule_spec_mid (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
  when ret == ((find_granule_spec' v_addr st));
  if (((ret.(pbase)) =s ("null")) && (((ret.(poffset)) =? (0))))
  then (
    (anno (((0 - (0)) = (0)));
    (anno (((0 - (1)) = ((- 1))));
    (Some ((mkPtr "status" 1), st)))))
  else (
    rely ((((ret.(pbase)) = ("granules")) /\ ((((ret.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      if (((((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
      then (
        if ((((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).(e_refcount)) =? (0))
        then (
          (Some (
            ret  ,
            ((st.[log] :< ((EVT CPU_ID (ACQ ((ret.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
              (sh.[granules] :<
                ((sh.(granules)) # ((ret.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))
          )))
        else (
          (anno (((0 - (5)) = ((- 5))));
          (Some (
            (mkPtr "status" 5)  ,
            ((st.[log] :<
              ((EVT CPU_ID (REL ((ret.(poffset)) / (ST_GRANULE_SIZE)) (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
                (((EVT CPU_ID (ACQ ((ret.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
              (sh.[granules] :< ((sh.(granules)) # ((ret.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
          )))))
      else (
        (anno (((0 - (0)) = (0)));
        (anno (((0 - (1)) = ((- 1))));
        (Some (
          (mkPtr "status" 1)  ,
          ((st.[log] :<
            ((EVT CPU_ID (REL ((ret.(poffset)) / (ST_GRANULE_SIZE)) (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((ret.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
            (sh.[granules] :< ((sh.(granules)) # ((ret.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
        )))))
    | (Some cid) => None
    end).

Definition find_lock_two_granules_spec_mid (v_addr1: Z) (v_expected_state1: Z) (v_g1: Ptr) (v_addr2: Z) (v_expected_state2: Z) (v_g2: Ptr) (st: RData) : (option (bool * RData)) :=
  when st == ((new_frame "find_lock_two_granules" st));
  let init_st := st in
  when v_gs, st == ((alloc_stack "find_lock_two_granules" 80 8 st));
  rely (((0 <= (0)) /\ ((0 < (2)))));
  let v_arrayinit_begin := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (0)) + (0))))) in
  rely (((0 <= (0)) /\ ((0 < (2)))));
  let v_idx := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (0)) + ((0 + (0))))))) in
  when st == ((store_RData 4 v_idx 0 st));
  rely (((0 <= (0)) /\ ((0 < (2)))));
  let v_addr := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (0)) + ((8 + (0))))))) in
  when st == ((store_RData 8 v_addr v_addr1 st));
  rely (((0 <= (0)) /\ ((0 < (2)))));
  let v_state := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (0)) + ((16 + (0))))))) in
  when st == ((store_RData 4 v_state v_expected_state1 st));
  rely (((0 <= (0)) /\ ((0 < (2)))));
  let v_g := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (0)) + ((24 + (0))))))) in
  when st == ((store_RData 8 v_g (ptr_to_int (mkPtr "null" 0)) st));
  rely (((0 <= (0)) /\ ((0 < (2)))));
  let v_g_ret := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (0)) + ((32 + (0))))))) in
  when st == ((store_RData 8 v_g_ret (ptr_to_int v_g1) st));
  rely (((0 <= (1)) /\ ((1 < (2)))));
  let v_idx1 := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (1)) + ((0 + (0))))))) in
  when st == ((store_RData 4 v_idx1 1 st));
  rely (((0 <= (1)) /\ ((1 < (2)))));
  let v_addr3 := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (1)) + ((8 + (0))))))) in
  when st == ((store_RData 8 v_addr3 v_addr2 st));
  rely (((0 <= (1)) /\ ((1 < (2)))));
  let v_state4 := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (1)) + ((16 + (0))))))) in
  when st == ((store_RData 4 v_state4 v_expected_state2 st));
  rely (((0 <= (1)) /\ ((1 < (2)))));
  let v_g5 := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (1)) + ((24 + (0))))))) in
  when st == ((store_RData 8 v_g5 (ptr_to_int (mkPtr "null" 0)) st));
  rely (((0 <= (1)) /\ ((1 < (2)))));
  let v_g_ret6 := (ptr_offset v_gs (((40 * (2)) * (0)) + (((40 * (1)) + ((32 + (0))))))) in
  when st == ((store_RData 8 v_g_ret6 (ptr_to_int v_g2) st));
  when v_call, st == ((find_lock_granules_spec v_arrayinit_begin 2 st));
  let __return__ := true in
  let __retval__ := v_call in
  when st == ((free_stack "find_lock_two_granules" init_st st));
  (Some (__retval__, st)).

