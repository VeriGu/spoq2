Definition granule_lock_spec (v_g: Ptr) (v_expected_state: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(pbase)) = ("granules")) /\ ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
  match ((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    if (((((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
    then (
      (Some ((st.[log] :< ((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
        (sh.[granules] :<
          ((sh.(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))))
    else (
      (Some ((st.[log] :<
        ((EVT CPU_ID (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
          (((EVT CPU_ID (ACQ ((v_g.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
        (sh.[granules] :< ((sh.(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))))
  | (Some cid) => None
  end.

Definition granule_unlock_spec (v_g: Ptr) (st: RData) : (option RData) :=
  if ((v_g.(pbase)) =s ("granules"))
  then (
    when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some ((st.[log] :< ((EVT CPU_ID (REL ((v_g.(poffset)) / (ST_GRANULE_SIZE)) (((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))))) :: ((st.(log))))).[share].[granules] :<
      (((st.(share)).(granules)) # ((v_g.(poffset)) / (ST_GRANULE_SIZE)) == ((((st.(share)).(granules)) @ ((v_g.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None)))))
  else None.

Definition find_lock_granule_spec (v_addr: Z) (v_expected_state: Z) (st: RData) : (option (Ptr * RData)) :=
  when ret == ((find_granule_spec' v_addr st));
  if (((ret.(pbase)) =s ("null")) && (((ret.(poffset)) =? (0))))
  then (Some ((mkPtr "null" 0), st))
  else (
    rely ((((ret.(pbase)) = ("granules")) /\ ((((ret.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match ((((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      if (((((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).(e_state)) - (v_expected_state)) =? (0))
      then (
        (Some (
          ret  ,
          ((st.[log] :< ((EVT CPU_ID (ACQ ((ret.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
            (sh.[granules] :<
              ((sh.(granules)) # ((ret.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))
        )))
      else (
        (Some (
          (mkPtr "null" 0)  ,
          ((st.[log] :<
            ((EVT CPU_ID (REL ((ret.(poffset)) / (ST_GRANULE_SIZE)) (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ ((ret.(poffset)) / (ST_GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
            (sh.[granules] :< ((sh.(granules)) # ((ret.(poffset)) / (ST_GRANULE_SIZE)) == (((sh.(granules)) @ ((ret.(poffset)) / (ST_GRANULE_SIZE))).[e_lock] :< None))))
        )))
    | (Some cid) => None
    end).

