Definition ns_buffer_unmap_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  rely (((v_buf.(pbase)) = ("slot_ns")));
  rely (((v_buf.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (- 1)))).

Definition ns_granule_map_spec (v_slot: Z) (v_granule: Ptr) (st: RData) : (option (Ptr * RData)) :=
  rely ((v_slot = (0)));
  rely ((((v_granule.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_granule.(pbase)) = ("granules")));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  (Some ((mkPtr "slot_ns" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_granule.(poffset)) >> (4)))))).

Definition buffer_unmap_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  rely (((v_buf.(poffset)) = (0)));
  rely (
    ((((((((((((v_buf.(pbase)) = ("slot_rd")) \/ (((v_buf.(pbase)) = ("slot_ns")))) \/ (((v_buf.(pbase)) = ("slot_delegated")))) \/ (((v_buf.(pbase)) = ("slot_rec")))) \/
      (((v_buf.(pbase)) = ("slot_rec2")))) \/
      (((v_buf.(pbase)) = ("slot_rec_target")))) \/
      (((v_buf.(pbase)) = ("slot_rec_aux0")))) \/
      (((v_buf.(pbase)) = ("slot_rtt")))) \/
      (((v_buf.(pbase)) = ("slot_rtt2")))) \/
      (((v_buf.(pbase)) = ("slot_rsi_call")))) \/
      (((v_buf.(pbase)) = ("slot_ns")))));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if ((v_buf.(pbase)) =s ("slot_ns"))
  then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (- 1))))
  else (
    if ((v_buf.(pbase)) =s ("slot_delegated"))
    then (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_DELEGATED == (- 1))))
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
                  else (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == (- 1)))))))))))).

Definition granule_map_spec (v_g: Ptr) (v_slot: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g.(pbase)) = ("granules")));
  rely ((v_slot <= (24)));
  rely ((v_slot >= (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if (v_slot =? (0))
  then (Some ((mkPtr "slot_ns" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == ((v_g.(poffset)) >> (4))))))
  else (
    if (
      if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_DELEGATED)) =? (0))
      then true
      else false)
    then (Some ((mkPtr "slot_delegated" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_DELEGATED == ((v_g.(poffset)) >> (4))))))
    else (
      if (
        if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RD)) =? (0))
        then true
        else false)
      then (Some ((mkPtr "slot_rd" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == ((v_g.(poffset)) >> (4))))))
      else (
        if (
          if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
          then true
          else false)
        then (Some ((mkPtr "slot_rec" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == ((v_g.(poffset)) >> (4))))))
        else (
          if (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
            then true
            else false)
          then (Some ((mkPtr "slot_rec2" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == ((v_g.(poffset)) >> (4))))))
          else (
            if (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
              then true
              else false)
            then (Some ((mkPtr "slot_rec_target" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == ((v_g.(poffset)) >> (4))))))
            else (
              if (
                if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (22)) <? (0))
                then true
                else false)
              then (
                (Some (
                  (mkPtr "slot_rec_aux0" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (65536)))  ,
                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == ((v_g.(poffset)) >> (4))))
                )))
              else (
                if (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then true
                  else false)
                then (Some ((mkPtr "slot_rtt" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == ((v_g.(poffset)) >> (4))))))
                else (
                  if (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then true
                    else false)
                  then (Some ((mkPtr "slot_rtt2" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == ((v_g.(poffset)) >> (4))))))
                  else (Some ((mkPtr "slot_rsi_call" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == ((v_g.(poffset)) >> (4)))))))))))))).

