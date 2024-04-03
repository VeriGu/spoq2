Definition realm_ipa_get_ripas_1 (v_call: Ptr) (v_g_llt: Ptr) (v_ws_0: Z) (init_st: RData) (st: RData) : (option (Z * RData)) :=
  rely (((v_call.(pbase)) = ("slot_rtt")));
  rely (((v_g_llt.(pbase)) = ("realm_ipa_get_ripas_stack")));
  rely (((v_call.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st.(stack)).(realm_ipa_get_ripas_stack)) @ (v_g_llt.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st.(stack)).(realm_ipa_get_ripas_stack)) @ (v_g_llt.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st.(share)).(granules)) @ (((((st.(stack)).(realm_ipa_get_ripas_stack)) @ (v_g_llt.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  (Some (v_ws_0, (lens 6377 (st.[share].[slots] :< (((st.(share)).(slots)) # SLOT_RTT == (- 1)))))).

Definition realm_ipa_get_ripas_spec (v_rec: Ptr) (v_ipa: Z) (v_ripas_ptr: Ptr) (v_rtt_level: Ptr) (st: RData) : (option (Z * RData)) :=
  rely (
    (((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))) /\ (((v_ripas_ptr.(pbase)) = ("handle_rsi_ipa_state_get_stack")))) /\
      (((v_rtt_level.(pbase)) = ("handle_rsi_ipa_state_get_stack")))));
  if (
    match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (
      (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (STACK_VIRT)) < (0)) /\
        (((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) >= (0)))));
    rely (
      (("granules" = ("granules")) /\
        ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
    when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
    match (((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | None =>
      if (
        match ((((((lens 6468 st).(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
        | (Some cid) => ((((((lens 6468 st).(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
        | None => ((((((lens 6468 st).(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
        end)
      then (
        when st_7 == (
            (rtt_walk_lock_unlock_spec
              (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_g_rtt)) - (GRANULES_BASE)))
              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_s2_starting_level))
              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits))
              v_ipa
              3
              (mkPtr "realm_ipa_get_ripas_stack" 0)
              (lens 6468 st)));
        rely (((((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (STACK_VIRT)) < (0)) /\ ((((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >= (0)))));
        rely (((((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == (((((st_7.(share)).(granules)) @ (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))).(e_lock)));
        if (
          (((((((st_7.(share)).(granule_data)) @ (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 8)))) &
            (3)) =?
            (0)))
        then (
          if (
            ((((((((st_7.(share)).(granule_data)) @ (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 8)))) &
              (60)) -
              (8)) =?
              (0)))
          then (
            rely (
              (((((((lens 6506 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                (STACK_VIRT)) <
                (0)) /\
                (((((((lens 6506 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                  (GRANULES_BASE)) >=
                  (0)))));
            (Some (
              2  ,
              ((lens 6529 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).[share].[slots] :<
                ((((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
            )))
          else (
            if (
              (((((((st_7.(share)).(granule_data)) @ (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 8)))) &
                (64)) =?
                (0)))
            then (
              rely (
                (((((((lens 6565 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                  (STACK_VIRT)) <
                  (0)) /\
                  (((((((lens 6565 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                    (GRANULES_BASE)) >=
                    (0)))));
              (Some (
                0  ,
                ((lens 6588 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).[share].[slots] :<
                  ((((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
              )))
            else (
              rely (
                (((((((lens 6624 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                  (STACK_VIRT)) <
                  (0)) /\
                  (((((((lens 6624 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                    (GRANULES_BASE)) >=
                    (0)))));
              (Some (
                0  ,
                ((lens 6647 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).[share].[slots] :<
                  ((((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
              )))))
        else (
          if (
            (((((((st_7.(share)).(granule_data)) @ (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 8)))) &
              (64)) =?
              (0)))
          then (
            rely (
              (((((((lens 6683 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                (STACK_VIRT)) <
                (0)) /\
                (((((((lens 6683 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                  (GRANULES_BASE)) >=
                  (0)))));
            (Some (
              0  ,
              ((lens 6706 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).[share].[slots] :<
                ((((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
            )))
          else (
            rely (
              (((((((lens 6742 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                (STACK_VIRT)) <
                (0)) /\
                (((((((lens 6742 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).(stack)).(realm_ipa_get_ripas_stack)) @ 0) -
                  (GRANULES_BASE)) >=
                  (0)))));
            (Some (
              0  ,
              ((lens 6765 (st_7.[share].[slots] :< (((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))))).[share].[slots] :<
                ((((st_7.(share)).(slots)) # SLOT_RTT == (((((st_7.(stack)).(realm_ipa_get_ripas_stack)) @ 0) - (GRANULES_BASE)) >> (4))) # SLOT_RTT == (- 1)))
            )))))
      else None
    | (Some cid) => None
    end)
  else None.

Fixpoint s2tt_init_unassigned_loop0 (_N_: nat) (__return__: bool) (v_call: Z) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_index, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_unassigned_loop0 _N__0 __return__ v_call v_index v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_index_0, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_index_0, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
        if ((v_index_0 + (2)) =? (512))
        then (
          (Some (
            true  ,
            v_call_0  ,
            v_index_0  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == v_call_0) #
                    ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                    v_call_0))))
          )))
        else (
          (Some (
            false  ,
            v_call_0  ,
            (v_index_0 + (2))  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == v_call_0) #
                    ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                    v_call_0))))
          ))))
    | None => None
    end
  end.

Fixpoint s2tt_init_assigned_empty_loop700 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_assigned_empty_loop700 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
        if ((v_indvars_iv_0 + (1)) <>? (512))
        then (
          (Some (
            false  ,
            v_call_0  ,
            (v_indvars_iv_0 + (1))  ,
            v_level_0  ,
            (v_pa_addr_6 + (v_call_0))  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                    ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                    (v_pa_addr_6 |' (4))))))
          )))
        else (
          (Some (
            true  ,
            v_call_0  ,
            v_indvars_iv_0  ,
            v_level_0  ,
            v_pa_addr_6  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                    ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                    (v_pa_addr_6 |' (4))))))
          ))))
    | None => None
    end
  end.

Fixpoint s2tt_init_valid_loop719 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_valid_loop719 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        if (v_level_0 =? (3))
        then (
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (2011))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (2011))))))
            ))))
        else (
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (2009))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (2009))))))
            )))))
    | None => None
    end
  end.

Fixpoint s2tt_init_destroyed_loop0 (_N_: nat) (__return__: bool) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_index, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_destroyed_loop0 _N__0 __return__ v_index v_s2tt st)) with
    | (Some (__return___0, v_index_0, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_index_0, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
        if ((v_index_0 + (2)) =? (512))
        then (
          (Some (
            true  ,
            v_index_0  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == 8) #
                    ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                    8))))
          )))
        else (
          (Some (
            false  ,
            (v_index_0 + (2))  ,
            v_s2tt_0  ,
            (st_0.[share].[granule_data] :<
              (((st_0.(share)).(granule_data)) #
                (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                  ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == 8) #
                    ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                    8))))
          ))))
    | None => None
    end
  end.

Definition realm_ipa_to_pa_spec (v_rd: Ptr) (v_ipa: Z) (v_s2_walk: Ptr) (st: RData) : (option (Z * RData)) :=
  when st == ((new_frame "realm_ipa_to_pa" st));
  let init_st := st in
  rely (
    (((v_rd.(pbase)) = ("slot_rd")) /\
      (((((v_s2_walk.(pbase)) = ("rsi_walk_smc_result_stack")) \/ (((v_s2_walk.(pbase)) = ("do_host_call_stack")))) \/
        (((v_s2_walk.(pbase)) = ("attest_token_continue_write_state_stack")))))));
  when v_wi, st == ((alloc_stack "realm_ipa_to_pa" 24 8 st));
  let v_rem := (v_ipa & (4095)) in
  let v_cmp := (v_rem =? (0)) in
  match (
    let __retval__ := 0 in
    let __return__ := false in
    if v_cmp
    then (
      when v_call, st == ((addr_in_par_spec v_rd v_ipa st));
      match (
        let __retval__ := 0 in
        let __return__ := false in
        if v_call
        then (
          let v_g_rtt := (ptr_offset v_rd ((456 * (0)) + ((16 + ((16 + (0))))))) in
          when v_0_tmp, st == ((load_RData 8 v_g_rtt st));
          let v_0 := (int_to_ptr v_0_tmp) in
          when st == ((granule_lock_spec v_0 6 st));
          when v_call1, st == ((realm_rtt_starting_level_spec v_rd st));
          when v_call2, st == ((realm_ipa_bits_spec v_rd st));
          when st == ((rtt_walk_lock_unlock_spec v_0 v_call1 v_call2 v_ipa 3 v_wi st));
          let v_g_llt := (ptr_offset v_wi ((24 * (0)) + ((0 + (0))))) in
          when v_1_tmp, st == ((load_RData 8 v_g_llt st));
          let v_1 := (int_to_ptr v_1_tmp) in
          when v_call3, st == ((granule_map_spec v_1 22 st));
          let v_2 := v_call3 in
          when v_3_tmp, st == ((load_RData 8 v_g_llt st));
          let v_3 := (int_to_ptr v_3_tmp) in
          let v_llt := (ptr_offset v_s2_walk ((32 * (0)) + ((24 + (0))))) in
          when st == ((store_RData 8 v_llt (ptr_to_int v_3) st));
          let v_index := (ptr_offset v_wi ((24 * (0)) + ((8 + (0))))) in
          when v_4, st == ((load_RData 8 v_index st));
          let v_arrayidx := (ptr_offset v_2 ((8 * (v_4)) + (0))) in
          when v_call5, st == ((__tte_read_spec v_arrayidx st));
          let v_last_level := (ptr_offset v_wi ((24 * (0)) + ((16 + (0))))) in
          when v_5, st == ((load_RData 8 v_last_level st));
          when v_call6, st == ((s2tte_is_valid_spec v_call5 v_5 st));
          when v_walk_status_0, st == (
              let v_walk_status_0 := 0 in
              if v_call6
              then (
                when v_8, st == ((load_RData 8 v_last_level st));
                when v_call16, st == ((s2tte_pa_spec v_call5 v_8 st));
                let v_pa := (ptr_offset v_s2_walk ((32 * (0)) + ((0 + (0))))) in
                when st == ((store_RData 8 v_pa v_call16 st));
                when v_9, st == ((load_RData 8 v_last_level st));
                let v_conv := v_9 in
                when v_call18, st == ((s2tte_map_size_spec v_conv st));
                let v_sub := (v_call18 + ((- 1))) in
                let v_and := (v_sub & (v_ipa)) in
                when v_10, st == ((load_RData 8 v_pa st));
                let v_add := (v_and + (v_10)) in
                when st == ((store_RData 8 v_pa v_add st));
                let v_ripas20 := (ptr_offset v_s2_walk ((32 * (0)) + ((16 + (0))))) in
                when st == ((store_RData 4 v_ripas20 1 st));
                let v_walk_status_0 := 0 in
                (Some (v_walk_status_0, st)))
              else (
                when v_6, st == ((load_RData 8 v_last_level st));
                let v_rtt_level := (ptr_offset v_s2_walk ((32 * (0)) + ((8 + (0))))) in
                when st == ((store_RData 8 v_rtt_level v_6 st));
                when v_call9, st == ((s2tte_is_destroyed_spec v_call5 st));
                when st == (
                    if v_call9
                    then (
                      let v_destroyed := (ptr_offset v_s2_walk ((32 * (0)) + ((20 + (0))))) in
                      when st == ((store_RData 1 v_destroyed 1 st));
                      (Some st))
                    else (
                      when v_call11, st == ((s2tte_get_ripas_spec v_call5 st));
                      let v_ripas := (ptr_offset v_s2_walk ((32 * (0)) + ((16 + (0))))) in
                      when st == ((store_RData 4 v_ripas v_call11 st));
                      (Some st)));
                when v_7_tmp, st == ((load_RData 8 v_g_llt st));
                let v_7 := (int_to_ptr v_7_tmp) in
                when st == ((granule_unlock_spec v_7 st));
                let v_walk_status_0 := 2 in
                (Some (v_walk_status_0, st))));
          when st == ((buffer_unmap_spec v_call3 st));
          let v_retval_0 := v_walk_status_0 in
          let __return__ := true in
          let __retval__ := v_retval_0 in
          (Some (__return__, __retval__, st)))
        else (Some (__return__, __retval__, st))
      ) with
      | (Some (__return__, __retval__, st)) =>
        if __return__
        then (Some (__return__, __retval__, st))
        else (Some (__return__, __retval__, st))
      | None => None
      end)
    else (Some (__return__, __retval__, st))
  ) with
  | (Some (__return__, __retval__, st)) =>
    if __return__
    then (
      when st == ((free_stack "realm_ipa_to_pa" init_st st));
      (Some (__retval__, st)))
    else (
      let v_retval_0 := 1 in
      let __return__ := true in
      let __retval__ := v_retval_0 in
      when st == ((free_stack "realm_ipa_to_pa" init_st st));
      (Some (__retval__, st)))
  | None => None
  end.

Fixpoint s2tt_init_valid_ns_loop738 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
  match (_N_) with
  | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
  | (S _N__0) =>
    match ((s2tt_init_valid_ns_loop738 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
    | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
      if __return___0
      then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
      else (
        rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
        if (v_level_0 =? (3))
        then (
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446979))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446979))))))
            ))))
        else (
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446977))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (54043195528446977))))))
            )))))
    | None => None
    end
  end.

Definition s2tt_init_unassigned_spec (v_s2tt: Ptr) (v_ripas: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  if (v_ripas =? (0))
  then (
    match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false 0 0 v_s2tt st)) with
    | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) => (Some st_1)
    | None => None
    end)
  else (
    match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false 64 0 v_s2tt st)) with
    | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) => (Some st_1)
    | None => None
    end).

Definition s2tt_init_valid_ns_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_valid_ns_loop738 (z_to_nat 512) false (1 << ((((3 - (v_level)) * (9)) + (12)))) 0 v_level v_pa v_s2tt st)) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Definition s2tt_init_assigned_empty_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_assigned_empty_loop700 (z_to_nat 512) false (1 << ((((3 - (v_level)) * (9)) + (12)))) 0 v_level v_pa v_s2tt st)) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Definition s2tt_init_destroyed_spec (v_s2tt: Ptr) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_destroyed_loop0 (z_to_nat 256) false 0 v_s2tt st)) with
  | (Some (__return__, v_index_0, v_s2tt_0, st_0)) => (Some st_0)
  | None => None
  end.

Definition s2tt_init_valid_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
  rely (((v_s2tt.(pbase)) = ("slot_delegated")));
  match ((s2tt_init_valid_loop719 (z_to_nat 512) false (1 << ((((3 - (v_level)) * (9)) + (12)))) 0 v_level v_pa v_s2tt st)) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) => (Some st_1)
  | None => None
  end.

Definition s2tt_init_valid_ns_loop738_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition s2tt_init_assigned_empty_loop700_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition s2tt_init_destroyed_loop0_rank (v_index: Z) (v_s2tt: Ptr) : Z :=
  (256 - ((v_index / (2)))).

Definition s2tt_init_valid_loop719_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
  (512 - (v_indvars_iv)).

Definition s2tt_init_unassigned_loop0_rank (v_call: Z) (v_index: Z) (v_s2tt: Ptr) : Z :=
  (256 - ((v_index / (2)))).

