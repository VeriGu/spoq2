Definition addr_level_mask_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
  (Some (((v_addr & (281474976710655)) & (((- 1) << (((39 + ((38654705655 * (v_level)))) & (4294967295)))))), st)).

Definition s2tte_check_spec' (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : bool :=
  if (((v_s2tte & (36028797018963968)) - (v_ns)) =? (0))
  then (
    if ((v_level =? (3)) && (((v_s2tte & (3)) =? (3))))
    then true
    else (
      if ((v_level =? (2)) && (((v_s2tte & (3)) =? (1))))
      then true
      else false))
  else false.

Definition s2tte_check_spec (v_s2tte: Z) (v_level: Z) (v_ns: Z) (st: RData) : (option (bool * RData)) :=
  let ret := (s2tte_check_spec' v_s2tte v_level v_ns st) in
  (Some (ret, st)).

Definition s2tte_has_hipas_spec' (v_s2tte: Z) (v_hipas: Z) (st: RData) : bool :=
  if ((v_s2tte & (3)) =? (0))
  then (
    if (((v_s2tte & (60)) - (v_hipas)) =? (0))
    then true
    else false)
  else false.

Definition s2tte_has_hipas_spec (v_s2tte: Z) (v_hipas: Z) (st: RData) : (option (bool * RData)) :=
  let ret := (s2tte_has_hipas_spec' v_s2tte v_hipas st) in
  (Some (ret, st)).

Definition __table_get_entry_spec (v_g_tbl: Ptr) (v_idx: Z) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_g_tbl.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_g_tbl.(pbase)) = ("granules")))) /\
      ((((0 = (0)) /\ (("granules" = ("granules")))) /\ ((((22 <= (24)) /\ ((22 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))))));
  when ret == ((__tte_read_spec' (mkPtr "slot_rtt" (8 * (v_idx))) (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g_tbl.(poffset)) >> (4))))));
  (Some (ret, (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))).

