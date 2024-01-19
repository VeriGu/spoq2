Definition ns_granule_map_spec (v_slot: Z) (v_granule: Ptr) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((v_slot = (0)) /\ (((((v_granule.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_granule.(pbase)) = ("granules")))))) /\
      ((((0 <= (24)) /\ ((0 >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
  (Some ((mkPtr "slot_ns" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_granule.(poffset)) >> (4)))))).

Definition ns_buffer_unmap_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  rely (
    (((v_buf.(pbase)) = ("slot_ns")) /\
      (((((v_buf.(poffset)) = (0)) /\
        (((((((((("slot_ns" = ("slot_rd")) \/ (("slot_ns" = ("slot_rec")))) \/ (("slot_ns" = ("slot_rec2")))) \/ (("slot_ns" = ("slot_rec_target")))) \/
          (("slot_ns" = ("slot_rec_aux0")))) \/
          (("slot_ns" = ("slot_rtt")))) \/
          (("slot_ns" = ("slot_rtt2")))) \/
          (("slot_ns" = ("slot_rsi_call")))) \/
          (("slot_ns" = ("slot_ns")))))) /\
        ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
  (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (- 1)))).

Definition buffer_unmap_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  rely (
    ((((v_buf.(poffset)) = (0)) /\
      (((((((((((v_buf.(pbase)) = ("slot_rd")) \/ (((v_buf.(pbase)) = ("slot_rec")))) \/ (((v_buf.(pbase)) = ("slot_rec2")))) \/ (((v_buf.(pbase)) = ("slot_rec_target")))) \/
        (((v_buf.(pbase)) = ("slot_rec_aux0")))) \/
        (((v_buf.(pbase)) = ("slot_rtt")))) \/
        (((v_buf.(pbase)) = ("slot_rtt2")))) \/
        (((v_buf.(pbase)) = ("slot_rsi_call")))) \/
        (((v_buf.(pbase)) = ("slot_ns")))))) /\
      ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))));
  if ((v_buf.(pbase)) =s ("slot_ns"))
  then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (- 1))))
  else (
    if ((v_buf.(pbase)) =s ("slot_rd"))
    then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (- 1))))
    else (
      if ((v_buf.(pbase)) =s ("slot_rec"))
      then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == (- 1))))
      else (
        if ((v_buf.(pbase)) =s ("slot_rec2"))
        then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == (- 1))))
        else (
          if ((v_buf.(pbase)) =s ("slot_rec_target"))
          then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == (- 1))))
          else (
            if ((v_buf.(pbase)) =s ("slot_rec_aux0"))
            then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == (- 1))))
            else (
              if ((v_buf.(pbase)) =s ("slot_rtt"))
              then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))
              else (
                if ((v_buf.(pbase)) =s ("slot_rtt2"))
                then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == (- 1))))
                else (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == (- 1))))))))))).

Definition granule_map_spec (v_g: Ptr) (v_slot: Z) (st: RData) : (option (Ptr * RData)) :=
  rely (
    (((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)) /\ (((v_g.(pbase)) = ("granules")))) /\
      ((((v_slot <= (24)) /\ ((v_slot >= (0)))) /\ ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))))))));
  if (v_slot =? (0))
  then (Some ((mkPtr "slot_ns" v_slot), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_g.(poffset)) >> (4))))))
  else (
    if ((v_slot - (SLOT_DELEGATED)) =? (0))
    then None
    else (
      if ((v_slot - (SLOT_RD)) =? (0))
      then (Some ((mkPtr "slot_rd" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == ((v_g.(poffset)) >> (4))))))
      else (
        if ((v_slot - (SLOT_REC)) =? (0))
        then (Some ((mkPtr "slot_rec" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == ((v_g.(poffset)) >> (4))))))
        else (
          if ((v_slot - (SLOT_REC2)) =? (0))
          then (Some ((mkPtr "slot_rec2" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == ((v_g.(poffset)) >> (4))))))
          else (
            if ((v_slot - (SLOT_REC_TARGET)) =? (0))
            then (Some ((mkPtr "slot_rec_target" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == ((v_g.(poffset)) >> (4))))))
            else (
              if ((v_slot - (22)) <? (0))
              then (Some ((mkPtr "slot_rec_aux0" ((v_slot << (12)) mod (65536))), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == ((v_g.(poffset)) >> (4))))))
              else (
                if ((v_slot - (SLOT_RTT)) =? (0))
                then (Some ((mkPtr "slot_rtt" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g.(poffset)) >> (4))))))
                else (
                  if ((v_slot - (SLOT_RTT2)) =? (0))
                  then (Some ((mkPtr "slot_rtt2" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == ((v_g.(poffset)) >> (4))))))
                  else (Some ((mkPtr "slot_rsi_call" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == ((v_g.(poffset)) >> (4)))))))))))))).

