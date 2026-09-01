Definition granule_memzero_spec (v_g: Ptr) (v_slot: Z) (st: RData) : (option RData) :=
  rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
  rely (((v_g.(pbase)) = ("granules")));
  rely ((v_slot <= (24)));
  rely ((v_slot >= (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  if (v_slot =? (0))
  then (
    (Some (st.[share].[slots] :<
      (((st.(share)).(slots)) # SLOT_NS == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
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
      when cid == (
          ((((st.(share)).(granules)) @
            ((((st.(share)).(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED)).(e_lock)));
      (Some ((st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) #
          ((((st.(share)).(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED) ==
          ((((((st.(share)).(granule_data)) @
            ((((st.(share)).(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_DELEGATED)).[g_norm] :<
            zero_granule_data_normal).[g_rd] :<
            empty_rd).[g_rec] :<
            empty_rec))).[share].[slots] :<
        (((st.(share)).(slots)) # SLOT_DELEGATED == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
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
        when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_RD == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).(e_lock)));
        (Some ((st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) #
            ((((st.(share)).(slots)) # SLOT_RD == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD) ==
            ((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RD == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RD)).[g_norm] :<
              zero_granule_data_normal).[g_rd] :<
              empty_rd).[g_rec] :<
              empty_rec))).[share].[slots] :<
          (((st.(share)).(slots)) # SLOT_RD == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
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
          when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_REC == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).(e_lock)));
          (Some ((st.[share].[granule_data] :<
            (((st.(share)).(granule_data)) #
              ((((st.(share)).(slots)) # SLOT_REC == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC) ==
              ((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_REC == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_REC)).[g_norm] :<
                zero_granule_data_normal).[g_rd] :<
                empty_rd).[g_rec] :<
                empty_rec))).[share].[slots] :<
            (((st.(share)).(slots)) # SLOT_REC == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
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
            (Some (st.[share].[slots] :<
              (((st.(share)).(slots)) # SLOT_REC2 == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
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
              (Some (st.[share].[slots] :<
                (((st.(share)).(slots)) # SLOT_REC_TARGET == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
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
                (Some (st.[share].[slots] :<
                  (((st.(share)).(slots)) # SLOT_REC_AUX0 == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
              else (
                if (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                  then true
                  else (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then false
                    else false))
                then (
                  when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).(e_lock)));
                  (Some ((st.[share].[granule_data] :<
                    (((st.(share)).(granule_data)) #
                      ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT) ==
                      ((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT)).[g_norm] :<
                        zero_granule_data_normal).[g_rd] :<
                        empty_rd).[g_rec] :<
                        empty_rec))).[share].[slots] :<
                    (((st.(share)).(slots)) # SLOT_RTT == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
                else (
                  if (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                    then true
                    else false)
                  then (
                    when cid == (((((st.(share)).(granules)) @ ((((st.(share)).(slots)) # SLOT_RTT2 == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT2)).(e_lock)));
                    (Some ((st.[share].[granule_data] :<
                      (((st.(share)).(granule_data)) #
                        ((((st.(share)).(slots)) # SLOT_RTT2 == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT2) ==
                        ((((((st.(share)).(granule_data)) @ ((((st.(share)).(slots)) # SLOT_RTT2 == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))) @ SLOT_RTT2)).[g_norm] :<
                          zero_granule_data_normal).[g_rd] :<
                          empty_rd).[g_rec] :<
                          empty_rec))).[share].[slots] :<
                      (((st.(share)).(slots)) # SLOT_RTT2 == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE))))))
                  else (
                    (Some (st.[share].[slots] :<
                      (((st.(share)).(slots)) # SLOT_RSI_CALL == (((((GRANULES_BASE + ((v_g.(poffset)))) - (GRANULES_BASE)) >> (4)) * (GRANULE_SIZE)) / (GRANULE_SIZE)))))))))))))).

Definition granule_memzero_mapped_spec (v_buf: Ptr) (st: RData) : (option RData) :=
  rely ((((v_buf.(pbase)) = ("slot_rtt2")) \/ (((v_buf.(pbase)) = ("slot_rec")))));
  match (
    if ((v_buf.(pbase)) =s ("slot_rtt2"))
    then (Some (((st.(share)).(slots)) @ SLOT_RTT2))
    else (Some (((st.(share)).(slots)) @ SLOT_REC))
  ) with
  | None => (Some st)
  | (Some idx) =>
    when cid == (((((st.(share)).(granules)) @ idx).(e_lock)));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        idx ==
        ((((((st.(share)).(granule_data)) @ idx).[g_norm] :< zero_granule_data_normal).[g_rd] :< empty_rd).[g_rec] :< empty_rec))))
  end.

