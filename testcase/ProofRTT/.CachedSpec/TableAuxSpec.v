Definition validate_data_create_spec (v_map_addr: Z) (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
  when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  if ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_rd_state)) =? (0))
  then (
    rely (((Some cid) = ((Some CPU_ID))));
    if ((((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
    then (
      if ((((v_map_addr & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) - (v_map_addr)) =? (0))
      then (Some (0, st))
      else (Some (1, st)))
    else (Some (1, st)))
  else (Some (2, st)).

Definition __find_lock_next_level_spec (v_g_tbl: Ptr) (v_map_addr: Z) (v_level: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g_tbl.(pbase)) = ("granules")));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  when cid == (((((st.(share)).(granules)) @ ((v_g_tbl.(poffset)) >> (4))).(e_lock)));
  if (
    (((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))) &
      (3)) =?
      (3)))
  then (
    rely (
      (((0 -
        (((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))) &
          (281474976710655)) &
          (((- 1) << ((66 & (4294967295)))))) /
          (GRANULE_SIZE)))) <=
        (0)) /\
        ((((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))) &
          (281474976710655)) &
          (((- 1) << ((66 & (4294967295)))))) /
          (GRANULE_SIZE)) <
          (1048576)))));
    rely (
      ((((((st.(share)).(granules)) @
        ((16 *
          (((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))) &
            (281474976710655)) &
            (((- 1) << ((66 & (4294967295)))))) /
            (GRANULE_SIZE)))) mod
          (ST_GRANULE_SIZE))).(e_state)) -
        (6)) =
        (0)));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) ((st.(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))) # SLOT_RTT == (- 1)))));
    match (
      ((((st.(share)).(granules)) @
        ((16 *
          (((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))) &
            (281474976710655)) &
            (((- 1) << ((66 & (4294967295)))))) /
            (GRANULE_SIZE)))) /
          (ST_GRANULE_SIZE))).(e_lock))
    ) with
    | None =>
      (Some (
        (mkPtr
          "granules"
          (16 *
            (((((((((st.(share)).(granule_data)) @ ((v_g_tbl.(poffset)) >> (4))).(g_norm)) @ (8 * (((v_map_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511))))) &
              (281474976710655)) &
              (((- 1) << ((66 & (4294967295)))))) /
              (GRANULE_SIZE)))))  ,
        (lens 1126 (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))) # SLOT_RTT == (- 1))))
      ))
    | (Some cid_0) => None
    end)
  else (Some ((mkPtr "null" 0), (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))) # SLOT_RTT == (- 1))))).

