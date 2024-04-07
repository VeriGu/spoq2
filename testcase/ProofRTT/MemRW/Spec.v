Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section MemRW_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition granule_memzero_mapped_spec (v_buf: Ptr) (st: RData) : (option RData) :=
    rely (((v_buf.(pbase)) = ("slot_rtt2")));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
    (Some (st.[share].[granule_data] :<
      (((st.(share)).(granule_data)) #
        (((st.(share)).(slots)) @ SLOT_RTT2) ==
        ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< zero_granule_data_normal)))).

  Definition granule_memzero_spec (v_g: Ptr) (v_slot: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(poffset)) mod (ST_GRANULE_SIZE)) = (0)));
    rely (((v_g.(pbase)) = ("granules")));
    rely ((v_slot <= (24)));
    rely ((v_slot >= (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    if (v_slot =? (0))
    then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_NS == ((v_g.(poffset)) >> (4))) # SLOT_NS == (- 1))))
    else (
      if (
        if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_DELEGATED)) =? (0))
        then true
        else false)
      then (
        when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) >> (4))).(e_lock)));
        (Some ((st.[share].[granule_data] :<
          (((st.(share)).(granule_data)) # ((v_g.(poffset)) >> (4)) == ((((st.(share)).(granule_data)) @ ((v_g.(poffset)) >> (4))).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
          ((((st.(share)).(slots)) # SLOT_DELEGATED == ((v_g.(poffset)) >> (4))) # SLOT_DELEGATED == (- 1)))))
      else (
        if (
          if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RD)) =? (0))
          then true
          else false)
        then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == ((v_g.(poffset)) >> (4))) # SLOT_RD == (- 1))))
        else (
          if (
            if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC)) =? (0))
            then true
            else false)
          then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC == ((v_g.(poffset)) >> (4))) # SLOT_REC == (- 1))))
          else (
            if (
              if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC2)) =? (0))
              then true
              else false)
            then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC2 == ((v_g.(poffset)) >> (4))) # SLOT_REC2 == (- 1))))
            else (
              if (
                if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_REC_TARGET)) =? (0))
                then true
                else false)
              then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC_TARGET == ((v_g.(poffset)) >> (4))) # SLOT_REC_TARGET == (- 1))))
              else (
                if (
                  if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (22)) <? (0))
                  then true
                  else false)
                then (
                  rely ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) mod (65536)) = (0)));
                  (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_REC_AUX0 == ((v_g.(poffset)) >> (4))) # SLOT_REC_AUX0 == (- 1)))))
                else (
                  if (
                    if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT)) =? (0))
                    then true
                    else false)
                  then (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RTT == ((v_g.(poffset)) >> (4))) # SLOT_RTT == (- 1))))
                  else (
                    if (
                      if ((((((v_slot << (12)) + (18446744073709420544)) - (SLOT_VIRT)) / (GRANULE_SIZE)) - (SLOT_RTT2)) =? (0))
                      then true
                      else false)
                    then (
                      when cid == (((((st.(share)).(granules)) @ ((v_g.(poffset)) >> (4))).(e_lock)));
                      (Some ((st.[share].[granule_data] :<
                        (((st.(share)).(granule_data)) # ((v_g.(poffset)) >> (4)) == ((((st.(share)).(granule_data)) @ ((v_g.(poffset)) >> (4))).[g_norm] :< zero_granule_data_normal))).[share].[slots] :<
                        ((((st.(share)).(slots)) # SLOT_RTT2 == ((v_g.(poffset)) >> (4))) # SLOT_RTT2 == (- 1)))))
                    else (Some (st.[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RSI_CALL == ((v_g.(poffset)) >> (4))) # SLOT_RSI_CALL == (- 1)))))))))))).

End MemRW_Spec.

#[global] Hint Unfold granule_memzero_mapped_spec: spec.
#[global] Hint Unfold granule_memzero_spec: spec.
