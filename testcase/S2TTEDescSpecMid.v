Definition addr_level_mask_spec_mid (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (anno (
    (((((12884901888 * (((v_level * (1431655765)) + (1)))) >> (32)) * (9)) + (12)) =
      ((3 * (((((12884901888 * (((v_level * (1431655765)) + (1)))) >> (32)) * (3)) + (4)))))));
  (anno ((((v_level * (18446744069414584320)) + (12884901888)) = ((12884901888 * (((v_level * (1431655765)) + (1)))))));
  (anno (((12884901888 * (((v_level * (1431655765)) + (1)))) = ((12884901888 + ((18446744069414584320 * (v_level)))))));
  (anno ((((12884901888 + ((18446744069414584320 * (v_level)))) >> (32)) = ((3 + ((4294967295 * (v_level)))))));
  (anno ((((3 + ((4294967295 * (v_level)))) * (3)) = ((9 + ((12884901885 * (v_level)))))));
  (anno ((((9 + ((12884901885 * (v_level)))) + (4)) = ((13 + ((12884901885 * (v_level)))))));
  (anno (((39 + ((38654705655 * (v_level)))) = ((3 * ((13 + ((12884901885 * (v_level)))))))));
  (anno (((3 * ((13 + ((12884901885 * (v_level)))))) = ((39 + ((38654705655 * (v_level)))))));
  (Some (((v_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))), st)))))))))).

Definition s2tte_check_spec_mid (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : (option (bool * RData)) :=
  if (((v_s2tte & (36028797018963968)) - (v_ns)) =? (0))
  then (
    if ((v_level =? (3)) && (((v_s2tte & (3)) =? (3))))
    then (Some (true, st))
    else (
      if ((v_level =? (2)) && (((v_s2tte & (3)) =? (1))))
      then (Some (true, st))
      else (Some (false, st))))
  else (Some (false, st)).

Definition s2tte_has_hipas_spec_mid (v_s2tte: Z) (v_hipas: Z) (st: RData) : (option (bool * RData)) :=
  if ((v_s2tte & (3)) =? (0))
  then (
    if (((v_s2tte & (60)) - (v_hipas)) =? (0))
    then (Some (true, st))
    else (Some (false, st)))
  else (Some (false, st)).

Definition __table_get_entry_spec_mid (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g_tbl.(pbase)) = ("granules")));
  rely ((((0 = (0)) /\ (("granules" = ("granules")))) /\ ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
  (anno (((22 - (22)) = (0)));
  (anno ((((8 * (v_idx)) + (0)) = ((8 * (v_idx)))));
  (anno (((0 + ((8 * (v_idx)))) = ((8 * (v_idx)))));
  when ret == ((__tte_read_spec' (mkPtr "slot_rtt" (8 * (v_idx))) (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))))));
  (anno (((- 1) = ((- 1))));
  (Some (ret, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))))))).

