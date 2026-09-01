Definition granule_addr_spec (v_g: Ptr) (st: RData) : (option (Z * RData)) :=
  rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g.(pbase)) = ("granules")));
  (Some (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)), st)).

Definition buffer_unmap_internal_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if (
    if ((v_buf.(pbase)) =s ("slot_ns"))
    then ((SLOT_NS - (non_slot)) =? (0))
    else (
      if ((v_buf.(pbase)) =s ("slot_delegated"))
      then ((SLOT_DELEGATED - (non_slot)) =? (0))
      else (
        if ((v_buf.(pbase)) =s ("slot_rd"))
        then ((SLOT_RD - (non_slot)) =? (0))
        else (
          if ((v_buf.(pbase)) =s ("slot_rec"))
          then ((SLOT_REC - (non_slot)) =? (0))
          else (
            if ((v_buf.(pbase)) =s ("slot_rec2"))
            then ((SLOT_REC2 - (non_slot)) =? (0))
            else (
              if ((v_buf.(pbase)) =s ("slot_rec_target"))
              then ((SLOT_REC_TARGET - (non_slot)) =? (0))
              else (
                if ((v_buf.(pbase)) =s ("slot_rec_aux0"))
                then ((SLOT_REC_AUX0 - (non_slot)) =? (0))
                else (
                  if ((v_buf.(pbase)) =s ("slot_rtt"))
                  then ((SLOT_RTT - (non_slot)) =? (0))
                  else (
                    if ((v_buf.(pbase)) =s ("slot_rtt2"))
                    then ((SLOT_RTT2 - (non_slot)) =? (0))
                    else (
                      if ((v_buf.(pbase)) =s ("slot_rsi_call"))
                      then ((SLOT_RSI_CALL - (non_slot)) =? (0))
                      else (
                        if ((v_buf.(pbase)) =s ("stack_g0"))
                        then ((STACK_g0 - (non_slot)) =? (0))
                        else (
                          if ((v_buf.(pbase)) =s ("stack_g1"))
                          then ((STACK_g1 - (non_slot)) =? (0))
                          else ((non_slot - (non_slot)) =? (0))))))))))))))
  then (
    if ((v_buf.(pbase)) =s ("status"))
    then (Some st)
    else (
      if ((v_buf.(pbase)) =s ("granules"))
      then (Some st)
      else (
        if ((v_buf.(pbase)) =s ("null"))
        then (Some st)
        else (Some st))))
  else (
    if (
      if ((v_buf.(pbase)) =s ("slot_ns"))
      then (SLOT_NS <=? (24))
      else (
        if ((v_buf.(pbase)) =s ("slot_delegated"))
        then (SLOT_DELEGATED <=? (24))
        else (
          if ((v_buf.(pbase)) =s ("slot_rd"))
          then (SLOT_RD <=? (24))
          else (
            if ((v_buf.(pbase)) =s ("slot_rec"))
            then (SLOT_REC <=? (24))
            else (
              if ((v_buf.(pbase)) =s ("slot_rec2"))
              then (SLOT_REC2 <=? (24))
              else (
                if ((v_buf.(pbase)) =s ("slot_rec_target"))
                then (SLOT_REC_TARGET <=? (24))
                else (
                  if ((v_buf.(pbase)) =s ("slot_rec_aux0"))
                  then (SLOT_REC_AUX0 <=? (24))
                  else (
                    if ((v_buf.(pbase)) =s ("slot_rtt"))
                    then (SLOT_RTT <=? (24))
                    else (
                      if ((v_buf.(pbase)) =s ("slot_rtt2"))
                      then (SLOT_RTT2 <=? (24))
                      else (
                        if ((v_buf.(pbase)) =s ("slot_rsi_call"))
                        then (SLOT_RSI_CALL <=? (24))
                        else (
                          if ((v_buf.(pbase)) =s ("stack_g0"))
                          then (STACK_g0 <=? (24))
                          else (STACK_g1 <=? (24)))))))))))))
    then (
      if ((v_buf.(pbase)) =s ("slot_ns"))
      then (Some st)
      else (
        if ((v_buf.(pbase)) =s ("slot_delegated"))
        then (Some st)
        else (
          if ((v_buf.(pbase)) =s ("slot_rd"))
          then (Some st)
          else (
            if ((v_buf.(pbase)) =s ("slot_rec"))
            then (Some st)
            else (
              if ((v_buf.(pbase)) =s ("slot_rec2"))
              then (Some st)
              else (
                if ((v_buf.(pbase)) =s ("slot_rec_target"))
                then (Some st)
                else (
                  if ((v_buf.(pbase)) =s ("slot_rec_aux0"))
                  then (Some st)
                  else (
                    if ((v_buf.(pbase)) =s ("slot_rtt"))
                    then (Some st)
                    else (
                      if ((v_buf.(pbase)) =s ("slot_rtt2"))
                      then (Some st)
                      else (Some st))))))))))
    else (
      if ((v_buf.(pbase)) =s ("stack_g0"))
      then (Some st)
      else (Some st))).

Definition buffer_map_internal_spec (v_slot: Z) (v_addr: Z) (st: RData) : (option (Ptr * RData)) :=
  rely ((v_slot <= (24)));
  rely ((v_slot >= (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if (v_slot =? (0))
  then (
    (Some (
      (mkPtr "slot_ns" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_NS == (v_addr / (GRANULE_SIZE))))
    )))
  else (
    if (
      if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_DELEGATED)) =? (0))
      then true
      else (
        if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RD)) =? (0))
        then false
        else (
          if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
          then false
          else (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
            then false
            else (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
              then false
              else (
                if (
                  (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_AUX0)) >=? (0)) &&
                    (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))) <? (0)))))
                then false
                else (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then false
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false))))))))
    then (
      (Some (
        (mkPtr "slot_delegated" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
        (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_DELEGATED == (v_addr / (GRANULE_SIZE))))
      )))
    else (
      if (
        if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RD)) =? (0))
        then true
        else (
          if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
          then false
          else (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
            then false
            else (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
              then false
              else (
                if (
                  (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_AUX0)) >=? (0)) &&
                    (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))) <? (0)))))
                then false
                else (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then false
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false)))))))
      then (
        (Some (
          (mkPtr "slot_rd" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
          (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RD == (v_addr / (GRANULE_SIZE))))
        )))
      else (
        if (
          if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
          then true
          else (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
            then false
            else (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
              then false
              else (
                if (
                  (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_AUX0)) >=? (0)) &&
                    (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))) <? (0)))))
                then false
                else (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then false
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false))))))
        then (
          (Some (
            (mkPtr "slot_rec" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
            (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC == (v_addr / (GRANULE_SIZE))))
          )))
        else (
          if (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
            then true
            else (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
              then false
              else (
                if (
                  (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_AUX0)) >=? (0)) &&
                    (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))) <? (0)))))
                then false
                else (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then false
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false)))))
          then (
            (Some (
              (mkPtr "slot_rec2" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
              (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC2 == (v_addr / (GRANULE_SIZE))))
            )))
          else (
            if (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
              then true
              else (
                if (
                  (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_AUX0)) >=? (0)) &&
                    (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))) <? (0)))))
                then false
                else (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then false
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false))))
            then (
              (Some (
                (mkPtr "slot_rec_target" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
                (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_TARGET == (v_addr / (GRANULE_SIZE))))
              )))
            else (
              if (
                if (
                  (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_AUX0)) >=? (0)) &&
                    (((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - ((SLOT_REC_AUX0 + (MAX_REC_AUX_GRANULES)))) <? (0)))))
                then true
                else (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then false
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false)))
              then (
                (Some (
                  (mkPtr "slot_rec_aux0" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod ((GRANULE_SIZE * (MAX_REC_AUX_GRANULES)))))  ,
                  (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_REC_AUX0 == (v_addr / (GRANULE_SIZE))))
                )))
              else (
                if (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then true
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false))
                then (
                  (Some (
                    (mkPtr "slot_rtt" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
                    (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (v_addr / (GRANULE_SIZE))))
                  )))
                else (
                  if (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then true
                    else false)
                  then (
                    (Some (
                      (mkPtr "slot_rtt2" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT2 == (v_addr / (GRANULE_SIZE))))
                    )))
                  else (
                    (Some (
                      (mkPtr "slot_rsi_call" ((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (GRANULE_SIZE)))  ,
                      (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RSI_CALL == (v_addr / (GRANULE_SIZE))))
                    ))))))))))).

