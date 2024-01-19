Definition granule_addr_spec_mid (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g.(pbase)) = ("granules")));
  (anno (((GRANULES_BASE + (0)) = (GRANULES_BASE)));
  (anno ((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) = ((v_g.(poffset)))));
  (Some ((((v_g.(poffset)) >> (4)) * (GRANULE_SIZE)), st)))).

Definition buffer_unmap_internal_spec_mid (v_buf: Ptr) (st: RData) : (option RData) :=
  rely (((v_buf.(poffset)) = (0)));
  rely (
    ((((((((((v_buf.(pbase)) = ("slot_rd")) \/ (((v_buf.(pbase)) = ("slot_rec")))) \/ (((v_buf.(pbase)) = ("slot_rec2")))) \/ (((v_buf.(pbase)) = ("slot_rec_target")))) \/
      (((v_buf.(pbase)) = ("slot_rec_aux0")))) \/
      (((v_buf.(pbase)) = ("slot_rtt")))) \/
      (((v_buf.(pbase)) = ("slot_rtt2")))) \/
      (((v_buf.(pbase)) = ("slot_rsi_call")))) \/
      (((v_buf.(pbase)) = ("slot_ns")))));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if ((v_buf.(pbase)) =s ("slot_ns"))
  then (
    (anno (((- 1) = ((- 1))));
    (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (- 1))))))
  else (
    if ((v_buf.(pbase)) =s ("slot_rd"))
    then (
      (anno (((- 1) = ((- 1))));
      (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (- 1))))))
    else (
      if ((v_buf.(pbase)) =s ("slot_rec"))
      then (
        (anno (((- 1) = ((- 1))));
        (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == (- 1))))))
      else (
        if ((v_buf.(pbase)) =s ("slot_rec2"))
        then (
          (anno (((- 1) = ((- 1))));
          (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == (- 1))))))
        else (
          if ((v_buf.(pbase)) =s ("slot_rec_target"))
          then (
            (anno (((- 1) = ((- 1))));
            (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == (- 1))))))
          else (
            if ((v_buf.(pbase)) =s ("slot_rec_aux0"))
            then (
              (anno (((- 1) = ((- 1))));
              (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == (- 1))))))
            else (
              if ((v_buf.(pbase)) =s ("slot_rtt"))
              then (
                (anno (((- 1) = ((- 1))));
                (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1))))))
              else (
                if ((v_buf.(pbase)) =s ("slot_rtt2"))
                then (
                  (anno (((- 1) = ((- 1))));
                  (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == (- 1))))))
                else (
                  (anno (((- 1) = ((- 1))));
                  (Some (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == (- 1))))))))))))).

Definition buffer_map_internal_spec_mid (v_slot: Z) (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((v_slot <= (24)));
  rely ((v_slot >= (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if (v_slot =? (0))
  then (
    (anno (((0 - (0)) = (0)));
    (anno (((v_slot << (12)) = (v_slot)));
    (anno ((((v_slot + (18446744073709420544)) - (SLOT_VIRT)) = (v_slot)));
    (anno (((v_slot mod (GRANULE_SIZE)) = (v_slot)));
    (Some ((mkPtr "slot_ns" v_slot), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (v_addr / (GRANULE_SIZE)))))))))))
  else (
    (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
    (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
    if ((v_slot - (SLOT_DELEGATED)) =? (0))
    then None
    else (
      (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
      (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
      if ((v_slot - (SLOT_RD)) =? (0))
      then (
        (anno (((0 - (0)) = (0)));
        (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
        (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
        (Some ((mkPtr "slot_rd" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_addr / (GRANULE_SIZE))))))))))
      else (
        (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
        (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
        if ((v_slot - (SLOT_REC)) =? (0))
        then (
          (anno (((0 - (0)) = (0)));
          (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
          (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
          (Some ((mkPtr "slot_rec" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == (v_addr / (GRANULE_SIZE))))))))))
        else (
          (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
          (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
          if ((v_slot - (SLOT_REC2)) =? (0))
          then (
            (anno (((0 - (0)) = (0)));
            (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
            (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
            (Some ((mkPtr "slot_rec2" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == (v_addr / (GRANULE_SIZE))))))))))
          else (
            (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
            (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
            if ((v_slot - (SLOT_REC_TARGET)) =? (0))
            then (
              (anno (((0 - (0)) = (0)));
              (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
              (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
              (Some ((mkPtr "slot_rec_target" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == (v_addr / (GRANULE_SIZE))))))))))
            else (
              (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
              (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
              (anno (((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)) = (22)));
              if ((v_slot - (22)) <? (0))
              then (
                (anno (((0 - (0)) = (0)));
                (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
                (anno (((GRANULE_SIZE * (MAX_REC_AUX_GRANULES)) = (65536)));
                (Some ((mkPtr "slot_rec_aux0" ((v_slot << (12)) mod (65536))), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == (v_addr / (GRANULE_SIZE))))))))))
              else (
                (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
                (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
                if ((v_slot - (SLOT_RTT)) =? (0))
                then (
                  (anno (((0 - (0)) = (0)));
                  (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
                  (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
                  (Some ((mkPtr "slot_rtt" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (v_addr / (GRANULE_SIZE))))))))))
                else (
                  (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
                  (anno ((((v_slot << (12)) / (GRANULE_SIZE)) = (v_slot)));
                  if ((v_slot - (SLOT_RTT2)) =? (0))
                  then (
                    (anno (((0 - (0)) = (0)));
                    (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
                    (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
                    (Some ((mkPtr "slot_rtt2" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == (v_addr / (GRANULE_SIZE))))))))))
                  else (
                    (anno (((0 - (0)) = (0)));
                    (anno (((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) = ((v_slot << (12)))));
                    (anno ((((v_slot << (12)) mod (GRANULE_SIZE)) = (0)));
                    (Some ((mkPtr "slot_rsi_call" 0), (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == (v_addr / (GRANULE_SIZE))))))))))))))))))))))))))))))))))).

Definition get_slot_buf_xlat_ctx_spec_mid (st: RData) : (option (Ptr * RData)) :=
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  (anno (((16 * (16)) = (256)));
  (anno (((256 * (0)) = (0)));
  (anno ((((16 * (CPU_ID)) + (0)) = ((16 * (CPU_ID)))));
  (anno (((0 + ((16 * (CPU_ID)))) = ((16 * (CPU_ID)))));
  (Some ((mkPtr "slot_buf_xlat_ctx" (16 * (CPU_ID))), st)))))).

