Definition __find_lock_next_level_spec (v_g_tbl: Ptr) (v_map_addr: Z) (v_level: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_g_tbl.(pbase)) = ("granules")))) /\
      ((((0 = (0)) /\ (("granules" = ("granules")))) /\ ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
  when ret == (
      (__tte_read_spec'
        (mkPtr "slot_rtt" (8 * (((v_map_addr >> (((39 + ((38654705655 * (v_level)))) & (4294967295)))) & (511))))) 
        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))))));
  if ((ret & (3)) =? (3))
  then (
    rely ((((0 - ((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)))) <= (0)) /\ (((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)) < (1048576)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) ((st.(share)).[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1)))));
    match ((((sh.(granules)) @ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE))).(e_lock))) with
    | None =>
      if (((((sh.(granules)) @ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE))).(e_state)) - (6)) =? (0))
      then (
        (Some (
          (mkPtr "granules" (16 * ((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)))))  ,
          ((st.[log] :< ((EVT CPU_ID (ACQ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))).[share] :<
            (sh.[granules] :<
              ((sh.(granules)) #
                (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)) ==
                (((sh.(granules)) @ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))))
        )))
      else (
        (Some (
          (mkPtr "granules" (16 * ((((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)))))  ,
          ((st.[log] :<
            ((EVT
              CPU_ID 
              (REL
                (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)) 
                (((sh.(granules)) @ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE))).[e_lock] :< (Some CPU_ID)))) ::
              (((EVT CPU_ID (ACQ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)))) :: ((((st.(oracle)) (st.(log))) ++ ((st.(log))))))))).[share] :<
            (sh.[granules] :<
              ((sh.(granules)) #
                (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE)) ==
                (((sh.(granules)) @ (((ret & (281474976710655)) & ((- 4096))) / (GRANULE_SIZE))).[e_lock] :< None))))
        )))
    | (Some cid) => None
    end)
  else (Some ((mkPtr "null" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))).

Definition validate_data_create_spec' (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option Z) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock))) with
  | (Some cid) =>
    if ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)) =? (0))
    then (
      when ret == ((validate_data_create_unknown_spec' v_map_addr v_rd st));
      (Some ret))
    else (Some 2)
  | _ => None
  end.

Definition validate_data_create_spec (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  when ret == ((validate_data_create_spec' v_map_addr v_rd st));
  (Some (ret, st)).

