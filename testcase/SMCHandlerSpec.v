(* Definition smc_rtt_fold_1 (v_call1_0: Ptr) (v_s2_ctx: Ptr) (v_call: Ptr) (v_map_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (st_6: RData) : (option (Z * RData)) := *)
(*   rely (((v_call1_0.(pbase)) = ("slot_rd"))); *)
(*   rely (((v_call1_0.(poffset)) = (0))); *)
(*   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call.(pbase)) = ("granules"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   when cid == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(e_lock))); *)
(*   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*   rely ( *)
(*     (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\ *)
(*       (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0))))); *)
(*   rely ( *)
(*     ((((((st_6.(share)).(granules)) @ *)
(*       ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) - *)
(*       (6)) = *)
(*       (0))); *)
(*   rely ( *)
(*     (("granules" = ("granules")) /\ *)
(*       ((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = *)
(*         (0))))); *)
(*   when sh == (((st_6.(repl)) ((st_6.(oracle)) (st_6.(log))) ((st_6.(share)).[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1))))); *)
(*   match (((((st_6.(share)).(granules)) @ ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*   | None => *)
(*     when st_15 == ( *)
(*         (rtt_walk_lock_unlock_spec *)
(*           (mkPtr "granules" (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE))) *)
(*           ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) *)
(*           ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)) *)
(*           v_map_addr *)
(*           (v_ulevel + ((- 1))) *)
(*           v_wi *)
(*           ((lens 13418 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1))))); *)
(*     (Some ((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (16))), st_15)) *)
(*   | (Some cid_0) => None *)
(*   end. *)

(* Definition smc_rtt_fold_2 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_33: RData) : (option (Z * RData)) := *)
(*   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*   rely (((v_call33.(pbase)) = ("granules"))); *)
(*   when cid == (((((st_33.(share)).(granules)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(e_lock))); *)
(*   when cid_0 == (((((st_33.(share)).(granules)) @ (((st_33.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*   if ( *)
(*     match (((((st_33.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*     | (Some cid_1) => true *)
(*     | None => false *)
(*     end) *)
(*   then ( *)
(*     when cid_1 == (((((st_33.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*     rely (((v_call34.(poffset)) = (0))); *)
(*     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*     rely (((v_call15.(poffset)) = (0))); *)
(*     rely ( *)
(*       (((((((lens 13422 st_33).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*         (((((((lens 13422 st_33).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*     (Some ( *)
(*       0  , *)
(*       (((lens 13589 st_33).[share].[granule_data] :< *)
(*         ((((st_33.(share)).(granule_data)) # *)
(*           (((st_33.(share)).(slots)) @ SLOT_RTT) == *)
(*           ((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*             (((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*               ((v_call15.(poffset)) + ((8 * ((((st_33.(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*               v_call44))) # *)
(*           (((st_33.(share)).(slots)) @ SLOT_RTT2) == *)
(*           (((((st_33.(share)).(granule_data)) # *)
(*             (((st_33.(share)).(slots)) @ SLOT_RTT) == *)
(*             ((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*               (((((st_33.(share)).(granule_data)) @ (((st_33.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                 ((v_call15.(poffset)) + ((8 * ((((st_33.(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                 v_call44))) @ (((st_33.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*             zero_granule_data_normal))).[share].[slots] :< *)
(*         ((((st_33.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*     ))) *)
(*   else None. *)

(* Definition smc_rtt_fold_3 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_34: RData) : (option (Z * RData)) := *)
(*   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*   rely (((v_call33.(pbase)) = ("granules"))); *)
(*   when cid == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(e_lock))); *)
(*   when cid_0 == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*   if ( *)
(*     match (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*     | (Some cid_1) => true *)
(*     | None => false *)
(*     end) *)
(*   then ( *)
(*     when cid_1 == (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*     rely (((v_call34.(poffset)) = (0))); *)
(*     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*     rely (((v_call15.(poffset)) = (0))); *)
(*     rely ( *)
(*       (((((((lens 13621 st_34).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*         (((((((lens 13621 st_34).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*     (Some ( *)
(*       0  , *)
(*       (((lens 13788 st_34).[share].[granule_data] :< *)
(*         ((((st_34.(share)).(granule_data)) # *)
(*           (((st_34.(share)).(slots)) @ SLOT_RTT) == *)
(*           ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*             (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*               ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*               v_call44))) # *)
(*           (((st_34.(share)).(slots)) @ SLOT_RTT2) == *)
(*           (((((st_34.(share)).(granule_data)) # *)
(*             (((st_34.(share)).(slots)) @ SLOT_RTT) == *)
(*             ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*               (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                 ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                 v_call44))) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*             zero_granule_data_normal))).[share].[slots] :< *)
(*         ((((st_34.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*     ))) *)
(*   else None. *)

(* Definition smc_rtt_fold_4 (v_ripas: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call44: Z) (v_ulevel: Z) (st_28: RData) : (option (bool * RData)) := *)
(*   rely (((v_ripas.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   if ((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_ripas.(poffset))) =? (0)) *)
(*   then ( *)
(*     rely ( *)
(*       ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*         ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*     rely ((("granules" = ("granules")) /\ ((((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*     if ( *)
(*       if ( *)
(*         ((((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) - *)
(*           (GRANULE_STATE_RD)) =? *)
(*           (0))) *)
(*       then true *)
(*       else ( *)
(*         match (((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with *)
(*         | (Some cid) => true *)
(*         | None => false *)
(*         end)) *)
(*     then ( *)
(*       when cid == (((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))); *)
(*       if ( *)
(*         ((((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) + *)
(*           ((- 1))) <? *)
(*           (0))) *)
(*       then None *)
(*       else ( *)
(*         if ((0 & (36028797018963968)) =? (0)) *)
(*         then ( *)
(*           if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*           then ( *)
(*             (Some ( *)
(*               true  , *)
(*               ((lens 113 st_28).[share].[granule_data] :< *)
(*                 (((st_28.(share)).(granule_data)) # *)
(*                   (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                   ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                     (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                       0)))) *)
(*             ))) *)
(*           else ( *)
(*             if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*             then ( *)
(*               (Some ( *)
(*                 true  , *)
(*                 ((lens 113 st_28).[share].[granule_data] :< *)
(*                   (((st_28.(share)).(granule_data)) # *)
(*                     (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         0)))) *)
(*               ))) *)
(*             else ( *)
(*               (Some ( *)
(*                 false  , *)
(*                 ((lens 113 st_28).[share].[granule_data] :< *)
(*                   (((st_28.(share)).(granule_data)) # *)
(*                     (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         0)))) *)
(*               ))))) *)
(*         else ( *)
(*           (Some ( *)
(*             false  , *)
(*             ((lens 113 st_28).[share].[granule_data] :< *)
(*               (((st_28.(share)).(granule_data)) # *)
(*                 (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                 ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                   (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                     0)))) *)
(*           ))))) *)
(*     else None) *)
(*   else ( *)
(*     rely ( *)
(*       ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*         ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*     rely ((("granules" = ("granules")) /\ ((((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*     if ( *)
(*       if ( *)
(*         ((((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*           (GRANULE_STATE_RD)) =? *)
(*           (0))) *)
(*       then true *)
(*       else ( *)
(*         match (((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*         | (Some cid) => true *)
(*         | None => false *)
(*         end)) *)
(*     then ( *)
(*       when cid == (((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))); *)
(*       if ( *)
(*         ((((((st_28.(share)).(granules)) @ ((((((st_28.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) + *)
(*           ((- 1))) <? *)
(*           (0))) *)
(*       then None *)
(*       else ( *)
(*         if ((64 & (36028797018963968)) =? (0)) *)
(*         then ( *)
(*           if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*           then ( *)
(*             (Some ( *)
(*               true  , *)
(*               ((lens 113 st_28).[share].[granule_data] :< *)
(*                 (((st_28.(share)).(granule_data)) # *)
(*                   (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                   ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                     (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                       0)))) *)
(*             ))) *)
(*           else ( *)
(*             if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*             then ( *)
(*               (Some ( *)
(*                 true  , *)
(*                 ((lens 113 st_28).[share].[granule_data] :< *)
(*                   (((st_28.(share)).(granule_data)) # *)
(*                     (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         0)))) *)
(*               ))) *)
(*             else ( *)
(*               (Some ( *)
(*                 false  , *)
(*                 ((lens 113 st_28).[share].[granule_data] :< *)
(*                   (((st_28.(share)).(granule_data)) # *)
(*                     (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         0)))) *)
(*               ))))) *)
(*         else ( *)
(*           (Some ( *)
(*             false  , *)
(*             ((lens 113 st_28).[share].[granule_data] :< *)
(*               (((st_28.(share)).(granule_data)) # *)
(*                 (((st_28.(share)).(slots)) @ SLOT_RTT) == *)
(*                 ((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                   (((((st_28.(share)).(granule_data)) @ (((st_28.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_28).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                     0)))) *)
(*           ))))) *)
(*     else None). *)

(* Definition smc_rtt_fold_5 (v_call34: Ptr) (v_call33: Ptr) (v_call15: Ptr) (v_wi: Ptr) (st_0: RData) (st_28: RData) : (option (Z * RData)) := *)
(*   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*   rely (((v_call33.(pbase)) = ("granules"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call34.(poffset)) = (0))); *)
(*   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*   when cid == (((((st_28.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*   rely (((v_call15.(poffset)) = (0))); *)
(*   rely ( *)
(*     (((((((lens 13817 st_28).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*       (((((((lens 13817 st_28).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*   (Some (5, ((lens 13935 st_28).[share].[slots] :< ((((st_28.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))). *)

Definition smc_rtt_set_ripas_1 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  if (
    match (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (((v_call47.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call25.(poffset)) = (0)));
    rely (
      (((((((lens 12493 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 12493 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely (
      (((((((lens 12496 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 12496 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 12647 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30))))))).[share].[slots] :<
        (((((st_35.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
    )))
  else None.

Definition smc_rtt_set_ripas_2 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  if (
    match (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (((v_call47.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call25.(poffset)) = (0)));
    rely (
      (((((((lens 12750 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 12750 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely (
      (((((((lens 12753 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 12753 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 12904 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30))))))).[share].[slots] :<
        (((((st_35.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
    )))
  else None.

Definition smc_rtt_set_ripas_3 (v_call9: Ptr) (v_call30: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_35: RData) : (option (Z * RData)) :=
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_call9.(poffset)) = (0)));
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  if (
    match (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
    | (Some cid) => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
    | None => (((((st_35.(share)).(granules)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
    end)
  then (
    rely (((v_call47.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_35.(share)).(granules)) @ (((((st_35.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call25.(poffset)) = (0)));
    rely (
      (((((((lens 13007 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 13007 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely (
      (((((((lens 13010 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 13010 st_35).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 13161 st_35).[share].[granule_data] :<
        (((st_35.(share)).(granule_data)) #
          (((st_35.(share)).(slots)) @ SLOT_REC) ==
          ((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).[g_rec] :<
            (((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).[e_set_ripas] :<
              ((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).[e_addr] :<
                (((((((st_35.(share)).(granule_data)) @ (((st_35.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_set_ripas)).(e_addr)) + (v_call30))))))).[share].[slots] :<
        (((((st_35.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
    )))
  else None.

Definition smc_rtt_set_ripas_4 (v_ulevel: Z) (v_call47: Ptr) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_32: RData) : (option (Z * RData)) :=
  rely (((v_call47.(pbase)) = ("slot_rtt")));
  rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call47.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st_32.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_32.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_32.(share)).(granules)) @ (((((st_32.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call25.(poffset)) = (0)));
  rely (((v_call9.(poffset)) = (0)));
  rely (
    (((((((lens 13162 st_32).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 13162 st_32).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely (
    (((((((lens 13164 st_32).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 13164 st_32).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  (Some (
    (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
    ((lens 13266 st_32).[share].[slots] :< (((((st_32.(share)).(slots)) # SLOT_RTT == (- 1)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
  )).

Definition smc_rtt_set_ripas_5 (v_15: Z) (v_wi: Ptr) (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_25: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (
    ((((((st_25.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_25.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_25.(share)).(granules)) @ (((((st_25.(stack)).(smc_rtt_set_ripas_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (((v_call25.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call9.(poffset)) = (0)));
  rely (
    (((((((lens 1131 st_25).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 1131 st_25).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely (
    (((((((lens 13312 st_25).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 13312 st_25).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  (Some (
    (((((v_15 << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_15 << (32)) + (4)) & (4294967295))))  ,
    ((lens 13414 st_25).[share].[slots] :< ((((st_25.(share)).(slots)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1)))
  )).

Definition smc_rtt_set_ripas_6 (v_call25: Ptr) (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_18: RData) : (option (Z * RData)) :=
  rely (((v_call25.(pbase)) = ("slot_rd")));
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call25.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call9.(poffset)) = (0)));
  rely (
    ((((((st_18.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_18.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((((lens 17028 st_18).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 17028 st_18).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  (Some (1, ((lens 17130 st_18).[share].[slots] :< ((((st_18.(share)).(slots)) # SLOT_RD == (- 1)) # SLOT_REC == (- 1))))).

Definition smc_rtt_set_ripas_7 (v_call9: Ptr) (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_13: RData) : (option (Z * RData)) :=
  rely (((v_call9.(pbase)) = ("slot_rec")));
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_call9.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    ((((((st_13.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_13.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((((lens 17175 st_13).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 17175 st_13).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  (Some (1, ((lens 17277 st_13).[share].[slots] :< (((st_13.(share)).(slots)) # SLOT_REC == (- 1))))).

Definition smc_rtt_set_ripas_8 (v_g_rec: Ptr) (v_g_rd: Ptr) (st_0: RData) (st_8: RData) : (option (Z * RData)) :=
  rely (((v_g_rec.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (((v_g_rd.(pbase)) = ("smc_rtt_set_ripas_stack")));
  rely (
    ((((((st_8.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_8.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_8.(share)).(granules)) @ (((((st_8.(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rec.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((((lens 1131 st_8).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (STACK_VIRT)) < (0)) /\
      (((((((lens 1131 st_8).(stack)).(smc_rtt_set_ripas_stack)) @ (v_g_rd.(poffset))) - (GRANULES_BASE)) >= (0)))));
  (Some (5, (lens 17371 st_8))).

Definition smc_data_create_unknown_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (st: RData) : (option (Z * RData)) :=
  when v_call, st_0 == (
      match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 12173 st))) with
      | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
        rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
        if __return__
        then (
          if __retval__
          then (
            rely (
              (((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
            rely ((((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (
              ((((((lens 5901 st_3).(share)).(granules)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)) =
                ((Some CPU_ID))));
            if (
              ((((1 <<
                (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >>
                (1)) -
                (v_map_addr)) >?
                (0)))
            then (
              if ((((v_map_addr & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) - (v_map_addr)) =? (0))
              then (
                rely (
                  (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                    (STACK_VIRT)) <
                    (0)) /\
                    (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) >=
                      (0)))));
                rely (
                  ((((((st_3.(share)).(granules)) @
                    ((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) mod
                      (ST_GRANULE_SIZE))).(e_state)) -
                    (6)) =
                    (0)));
                rely (
                  (("granules" = ("granules")) /\
                    ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                      (GRANULES_BASE)) mod
                      (ST_GRANULE_SIZE)) =
                      (0)))));
                when sh == (
                    (((lens 5901 st_3).(repl))
                      (((lens 5901 st_3).(oracle)) ((lens 5901 st_3).(log)))
                      (((lens 5901 st_3).(share)).[slots] :<
                        (((st_3.(share)).(slots)) #
                          SLOT_RD ==
                          ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
                when st_13 == (
                    (rtt_walk_lock_unlock_spec
                      (mkPtr
                        "granules"
                        (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                          (GRANULES_BASE)))
                      ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                      ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                      v_map_addr
                      3
                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                      ((lens 12175 st_3).[share].[slots] :<
                        (((st_3.(share)).(slots)) #
                          SLOT_RD ==
                          ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
                if ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16))) =? (3))
                then (
                  rely (
                    ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                      ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                  rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                  when cid == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                  if (
                    (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                      (3)) =?
                      (0)))
                  then (
                    if (
                      (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                        (60)) =?
                        (0)))
                    then (
                      if (
                        (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                          (64)) =?
                          (0)))
                      then (
                        (data_create_1
                          v_data_addr
                          (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                          (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                          (lens 12047 st)
                          (st_13.[share].[slots] :<
                            (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))))
                      else (
                        (data_create_2
                          v_data_addr
                          (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                          (mkPtr "slot_rtt" 0)
                          (mkPtr "slot_rd" 0)
                          (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                          (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                          (lens 12047 st)
                          (st_13.[share].[slots] :<
                            (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                    else (
                      (data_create_3
                        (mkPtr "slot_rtt" 0)
                        (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                        (mkPtr "slot_rd" 0)
                        (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                        (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                        (lens 12047 st)
                        (st_13.[share].[slots] :<
                          (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                  else (
                    (data_create_3
                      (mkPtr "slot_rtt" 0)
                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                      (mkPtr "slot_rd" 0)
                      (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                      (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                      (lens 12047 st)
                      (st_13.[share].[slots] :<
                        (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                else (
                  (data_create_4
                    (((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16)))
                    (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                    (mkPtr "slot_rd" 0)
                    (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                    (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                    (lens 12047 st)
                    st_13)))
              else (
                (data_create_5
                  (mkPtr "slot_rd" 0)
                  (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                  (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                  1
                  (lens 12047 st)
                  ((lens 5901 st_3).[share].[slots] :<
                    (((st_3.(share)).(slots)) #
                      SLOT_RD ==
                      ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
            else (
              (data_create_5
                (mkPtr "slot_rd" 0)
                (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                1
                (lens 12047 st)
                ((lens 5901 st_3).[share].[slots] :<
                  (((st_3.(share)).(slots)) #
                    SLOT_RD ==
                    ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
          else (Some (1, (lens 12242 st_3))))
        else (
          if (v_i_144 >? (0))
          then (
            rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
            rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
            when cid == (
                ((((st_3.(share)).(granules)) @
                  (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
            (Some (1, (lens 12338 st_3))))
          else (Some (1, (lens 12434 st_3))))
      | None => None
      end);
  (Some (v_call, st_0)).

(* Definition smc_rtt_fold_6 (v_call34: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_ulevel: Z) (v_s2_ctx: Ptr) (v_map_addr: Z) (v_call33: Ptr) (v_ripas: Ptr) (st_0: RData) (st_26: RData) : (option (Z * RData)) := *)
(*   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   rely (((v_call33.(pbase)) = ("granules"))); *)
(*   rely (((v_ripas.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   when cid == (((((st_26.(share)).(granules)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*   if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (0)) *)
(*   then ( *)
(*     if ((((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) - (8)) =? (0)) *)
(*     then ( *)
(*       match ((__table_is_uniform_block_loop777 (z_to_nat 511) false true 1 false 0 (mkPtr "null" 0) v_call34 (mkPtr "s2tte_is_destroyed" 0) st_26)) with *)
(*       | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) => *)
(*         if v_retval_1 *)
(*         then ( *)
(*           rely ( *)
(*             ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*               ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*           rely ((("granules" = ("granules")) /\ ((((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*           if ( *)
(*             if ( *)
(*               ((((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) - *)
(*                 (GRANULE_STATE_RD)) =? *)
(*                 (0))) *)
(*             then true *)
(*             else ( *)
(*               match (((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*               | (Some cid_0) => true *)
(*               | None => false *)
(*               end)) *)
(*           then ( *)
(*             when cid_0 == (((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*             if ( *)
(*               ((((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                 ((- 1))) <? *)
(*                 (0))) *)
(*             then None *)
(*             else ( *)
(*               if ((8 & (36028797018963968)) =? (0)) *)
(*               then ( *)
(*                 if (((v_ulevel + ((- 1))) =? (3)) && (((8 & (3)) =? (3)))) *)
(*                 then ( *)
(*                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                   if ( *)
(*                     match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_3) => true *)
(*                     | None => false *)
(*                     end) *)
(*                   then ( *)
(*                     rely (((v_call34.(poffset)) = (0))); *)
(*                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                     rely (((v_call15.(poffset)) = (0))); *)
(*                     rely ( *)
(*                       (((((((lens 13937 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                         (((((((lens 13939 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                     (Some ( *)
(*                       0  , *)
(*                       (((lens 13941 st_3).[share].[granule_data] :< *)
(*                         ((((st_3.(share)).(granule_data)) # *)
(*                           (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                           ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                             (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                               8))) # *)
(*                           (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                           (((((st_3.(share)).(granule_data)) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                             zero_granule_data_normal))).[share].[slots] :< *)
(*                         ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                     ))) *)
(*                   else None) *)
(*                 else ( *)
(*                   if (((v_ulevel + ((- 1))) =? (2)) && (((8 & (3)) =? (1)))) *)
(*                   then ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                     if ( *)
(*                       match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 13943 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 13945 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 13947 st_3).[share].[granule_data] :< *)
(*                           ((((st_3.(share)).(granule_data)) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 8))) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_3.(share)).(granule_data)) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None) *)
(*                   else ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                     if ( *)
(*                       match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 13949 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 13951 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 13953 st_3).[share].[granule_data] :< *)
(*                           ((((st_3.(share)).(granule_data)) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 8))) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_3.(share)).(granule_data)) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None))) *)
(*               else ( *)
(*                 if (((8 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                 then ( *)
(*                   if (((v_ulevel + ((- 1))) =? (3)) && (((8 & (3)) =? (3)))) *)
(*                   then ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                     if ( *)
(*                       match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 13955 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 13957 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 13959 st_3).[share].[granule_data] :< *)
(*                           ((((st_3.(share)).(granule_data)) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 8))) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_3.(share)).(granule_data)) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None) *)
(*                   else ( *)
(*                     if (((v_ulevel + ((- 1))) =? (2)) && (((8 & (3)) =? (1)))) *)
(*                     then ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                       if ( *)
(*                         match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 13961 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 13963 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 13965 st_3).[share].[granule_data] :< *)
(*                             ((((st_3.(share)).(granule_data)) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   8))) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_3.(share)).(granule_data)) # *)
(*                                 (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None) *)
(*                     else ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                       if ( *)
(*                         match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 13967 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 13969 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 13971 st_3).[share].[granule_data] :< *)
(*                             ((((st_3.(share)).(granule_data)) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   8))) # *)
(*                               (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_3.(share)).(granule_data)) # *)
(*                                 (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None))) *)
(*                 else ( *)
(*                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                   if ( *)
(*                     match ((((((lens 113 st_3).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_3) => true *)
(*                     | None => false *)
(*                     end) *)
(*                   then ( *)
(*                     rely (((v_call34.(poffset)) = (0))); *)
(*                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                     rely (((v_call15.(poffset)) = (0))); *)
(*                     rely ( *)
(*                       (((((((lens 13973 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                         (((((((lens 13975 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                     (Some ( *)
(*                       0  , *)
(*                       (((lens 13977 st_3).[share].[granule_data] :< *)
(*                         ((((st_3.(share)).(granule_data)) # *)
(*                           (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                           ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                             (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                               8))) # *)
(*                           (((st_3.(share)).(slots)) @ SLOT_RTT2) == *)
(*                           (((((st_3.(share)).(granule_data)) # *)
(*                             (((st_3.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                             zero_granule_data_normal))).[share].[slots] :< *)
(*                         ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                     ))) *)
(*                   else None)))) *)
(*           else None) *)
(*         else ( *)
(*           when cid_0 == (((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*           if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (0)) *)
(*           then ( *)
(*             if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) =? (0)) *)
(*             then ( *)
(*               if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (64)) =? (0)) *)
(*               then ( *)
(*                 match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_3)) with *)
(*                 | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_1, v_s2tte_is_x_1, st_5)) => *)
(*                   if v_retval_2 *)
(*                   then ( *)
(*                     if ((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_ripas.(poffset))) =? (0)) *)
(*                     then ( *)
(*                       rely ( *)
(*                         ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       rely ((("granules" = ("granules")) /\ ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                       if ( *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                             (GRANULE_STATE_RD)) =? *)
(*                             (0))) *)
(*                         then true *)
(*                         else ( *)
(*                           match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_1) => true *)
(*                           | None => false *)
(*                           end)) *)
(*                       then ( *)
(*                         when cid_1 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                             ((- 1))) <? *)
(*                             (0))) *)
(*                         then None *)
(*                         else ( *)
(*                           if ((0 & (36028797018963968)) =? (0)) *)
(*                           then ( *)
(*                             if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                             then ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 13979 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 13981 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 13983 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None) *)
(*                             else ( *)
(*                               if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 13985 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 13987 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 13989 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 13991 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 13993 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 13995 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None))) *)
(*                           else ( *)
(*                             if (((0 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                             then ( *)
(*                               if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 13997 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 13999 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14001 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                                 then ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14003 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14005 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14007 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None) *)
(*                                 else ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14009 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14011 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14013 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None))) *)
(*                             else ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14015 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14017 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14019 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None)))) *)
(*                       else None) *)
(*                     else ( *)
(*                       rely ( *)
(*                         ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       rely ((("granules" = ("granules")) /\ ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                       if ( *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                             (GRANULE_STATE_RD)) =? *)
(*                             (0))) *)
(*                         then true *)
(*                         else ( *)
(*                           match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_1) => true *)
(*                           | None => false *)
(*                           end)) *)
(*                       then ( *)
(*                         when cid_1 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                             ((- 1))) <? *)
(*                             (0))) *)
(*                         then None *)
(*                         else ( *)
(*                           if ((64 & (36028797018963968)) =? (0)) *)
(*                           then ( *)
(*                             if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                             then ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14021 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14023 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14025 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None) *)
(*                             else ( *)
(*                               if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14027 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14029 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14031 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14033 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14035 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14037 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None))) *)
(*                           else ( *)
(*                             if (((64 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                             then ( *)
(*                               if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14039 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14041 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14043 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                                 then ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14045 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14047 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14049 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None) *)
(*                                 else ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14051 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14053 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14055 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None))) *)
(*                             else ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14057 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14059 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14061 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None)))) *)
(*                       else None)) *)
(*                   else ( *)
(*                     rely (((v_call34.(poffset)) = (0))); *)
(*                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                     when cid_1 == (((((st_5.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                     rely (((v_call15.(poffset)) = (0))); *)
(*                     rely ( *)
(*                       (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                         (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                     (Some (5, ((lens 13935 st_5).[share].[slots] :< ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))) *)
(*                 | None => None *)
(*                 end) *)
(*               else ( *)
(*                 match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_3)) with *)
(*                 | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_1, v_s2tte_is_x_1, st_5)) => *)
(*                   if v_retval_2 *)
(*                   then ( *)
(*                     if ((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_ripas.(poffset))) =? (0)) *)
(*                     then ( *)
(*                       rely ( *)
(*                         ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       rely ((("granules" = ("granules")) /\ ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                       if ( *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                             (GRANULE_STATE_RD)) =? *)
(*                             (0))) *)
(*                         then true *)
(*                         else ( *)
(*                           match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_1) => true *)
(*                           | None => false *)
(*                           end)) *)
(*                       then ( *)
(*                         when cid_1 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                             ((- 1))) <? *)
(*                             (0))) *)
(*                         then None *)
(*                         else ( *)
(*                           if ((0 & (36028797018963968)) =? (0)) *)
(*                           then ( *)
(*                             if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                             then ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14063 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14065 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14067 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None) *)
(*                             else ( *)
(*                               if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14069 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14071 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14073 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14075 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14077 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14079 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None))) *)
(*                           else ( *)
(*                             if (((0 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                             then ( *)
(*                               if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14081 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14083 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14085 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                                 then ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14087 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14089 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14091 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None) *)
(*                                 else ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14093 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14095 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14097 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               0))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None))) *)
(*                             else ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14099 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14101 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14103 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None)))) *)
(*                       else None) *)
(*                     else ( *)
(*                       rely ( *)
(*                         ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       rely ((("granules" = ("granules")) /\ ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                       if ( *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                             (GRANULE_STATE_RD)) =? *)
(*                             (0))) *)
(*                         then true *)
(*                         else ( *)
(*                           match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_1) => true *)
(*                           | None => false *)
(*                           end)) *)
(*                       then ( *)
(*                         when cid_1 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                         if ( *)
(*                           ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                             ((- 1))) <? *)
(*                             (0))) *)
(*                         then None *)
(*                         else ( *)
(*                           if ((64 & (36028797018963968)) =? (0)) *)
(*                           then ( *)
(*                             if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                             then ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14105 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14107 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14109 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None) *)
(*                             else ( *)
(*                               if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14111 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14113 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14115 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14117 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14119 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14121 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None))) *)
(*                           else ( *)
(*                             if (((64 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                             then ( *)
(*                               if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                 if ( *)
(*                                   match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14123 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14125 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14127 st_5).[share].[granule_data] :< *)
(*                                       ((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                                 then ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14129 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14131 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14133 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None) *)
(*                                 else ( *)
(*                                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                                   if ( *)
(*                                     match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                     | (Some cid_4) => true *)
(*                                     | None => false *)
(*                                     end) *)
(*                                   then ( *)
(*                                     rely (((v_call34.(poffset)) = (0))); *)
(*                                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                     rely (((v_call15.(poffset)) = (0))); *)
(*                                     rely ( *)
(*                                       (((((((lens 14135 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                         (((((((lens 14137 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                     (Some ( *)
(*                                       0  , *)
(*                                       (((lens 14139 st_5).[share].[granule_data] :< *)
(*                                         ((((st_5.(share)).(granule_data)) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               64))) # *)
(*                                           (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                           (((((st_5.(share)).(granule_data)) # *)
(*                                             (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                             ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                               (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                                 ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                                 64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                             zero_granule_data_normal))).[share].[slots] :< *)
(*                                         ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                     ))) *)
(*                                   else None))) *)
(*                             else ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                               if ( *)
(*                                 match ((((((lens 113 st_5).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14141 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14143 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14145 st_5).[share].[granule_data] :< *)
(*                                     ((((st_5.(share)).(granule_data)) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) # *)
(*                                       (((st_5.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_5.(share)).(granule_data)) # *)
(*                                         (((st_5.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None)))) *)
(*                       else None)) *)
(*                   else ( *)
(*                     rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*                     rely (((v_call33.(pbase)) = ("granules"))); *)
(*                     rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*                     rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     rely (((v_call34.(poffset)) = (0))); *)
(*                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                     when cid_1 == (((((st_5.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                     rely (((v_call15.(poffset)) = (0))); *)
(*                     rely ( *)
(*                       (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                         (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                     (Some (5, ((lens 13935 st_5).[share].[slots] :< ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))) *)
(*                 | None => None *)
(*                 end)) *)
(*             else ( *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               when cid_1 == (((((st_3.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some (5, ((lens 13935 st_3).[share].[slots] :< ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))))) *)
(*           else ( *)
(*             rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*             rely (((v_call33.(pbase)) = ("granules"))); *)
(*             rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*             rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*             rely (((v_call34.(poffset)) = (0))); *)
(*             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*             when cid_1 == (((((st_3.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*             rely (((v_call15.(poffset)) = (0))); *)
(*             rely ( *)
(*               (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                 (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*             (Some (5, ((lens 13935 st_3).[share].[slots] :< ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))))) *)
(*       | None => None *)
(*       end) *)
(*     else ( *)
(*       if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (60)) =? (0)) *)
(*       then ( *)
(*         if (((((((st_26.(share)).(granule_data)) @ (((st_26.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (64)) =? (0)) *)
(*         then ( *)
(*           match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 0 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_26)) with *)
(*           | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) => *)
(*             if v_retval_1 *)
(*             then ( *)
(*               if ((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_ripas.(poffset))) =? (0)) *)
(*               then ( *)
(*                 rely ( *)
(*                   ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 rely ((("granules" = ("granules")) /\ ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                 if ( *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) - *)
(*                       (GRANULE_STATE_RD)) =? *)
(*                       (0))) *)
(*                   then true *)
(*                   else ( *)
(*                     match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_0) => true *)
(*                     | None => false *)
(*                     end)) *)
(*                 then ( *)
(*                   when cid_0 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                       ((- 1))) <? *)
(*                       (0))) *)
(*                   then None *)
(*                   else ( *)
(*                     if ((0 & (36028797018963968)) =? (0)) *)
(*                     then ( *)
(*                       if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                       then ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14147 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14149 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14151 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     0))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None) *)
(*                       else ( *)
(*                         if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14153 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14155 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14157 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14159 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14161 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14163 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None))) *)
(*                     else ( *)
(*                       if (((0 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                       then ( *)
(*                         if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14165 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14167 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14169 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                           then ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14171 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14173 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14175 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None) *)
(*                           else ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14177 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14179 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14181 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None))) *)
(*                       else ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14183 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14185 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14187 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     0))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None)))) *)
(*                 else None) *)
(*               else ( *)
(*                 rely ( *)
(*                   ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 rely ((("granules" = ("granules")) /\ ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                 if ( *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                       (GRANULE_STATE_RD)) =? *)
(*                       (0))) *)
(*                   then true *)
(*                   else ( *)
(*                     match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_0) => true *)
(*                     | None => false *)
(*                     end)) *)
(*                 then ( *)
(*                   when cid_0 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                       ((- 1))) <? *)
(*                       (0))) *)
(*                   then None *)
(*                   else ( *)
(*                     if ((64 & (36028797018963968)) =? (0)) *)
(*                     then ( *)
(*                       if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                       then ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14189 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14191 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14193 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     64))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None) *)
(*                       else ( *)
(*                         if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14195 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14197 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14199 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14201 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14203 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14205 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None))) *)
(*                     else ( *)
(*                       if (((64 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                       then ( *)
(*                         if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14207 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14209 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14211 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                           then ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14213 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14215 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14217 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None) *)
(*                           else ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14219 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14221 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14223 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None))) *)
(*                       else ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14225 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14227 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14229 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     64))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None)))) *)
(*                 else None)) *)
(*             else ( *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               when cid_0 == (((((st_4.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some (5, ((lens 13935 st_4).[share].[slots] :< ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))) *)
(*           | None => None *)
(*           end) *)
(*         else ( *)
(*           match ((__table_is_uniform_block_loop777 (z_to_nat 511) false false 1 false 1 v_ripas v_call34 (mkPtr "s2tte_is_unassigned" 0) st_26)) with *)
(*           | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) => *)
(*             if v_retval_1 *)
(*             then ( *)
(*               if ((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_ripas.(poffset))) =? (0)) *)
(*               then ( *)
(*                 rely ( *)
(*                   ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 rely ((("granules" = ("granules")) /\ ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                 if ( *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                       (GRANULE_STATE_RD)) =? *)
(*                       (0))) *)
(*                   then true *)
(*                   else ( *)
(*                     match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_0) => true *)
(*                     | None => false *)
(*                     end)) *)
(*                 then ( *)
(*                   when cid_0 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                       ((- 1))) <? *)
(*                       (0))) *)
(*                   then None *)
(*                   else ( *)
(*                     if ((0 & (36028797018963968)) =? (0)) *)
(*                     then ( *)
(*                       if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                       then ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14231 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14233 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14235 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     0))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None) *)
(*                       else ( *)
(*                         if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14237 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14239 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14241 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14243 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14245 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14247 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None))) *)
(*                     else ( *)
(*                       if (((0 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                       then ( *)
(*                         if (((v_ulevel + ((- 1))) =? (3)) && (((0 & (3)) =? (3)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14249 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14251 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14253 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1)))) *)
(*                           then ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14255 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14257 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14259 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None) *)
(*                           else ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14261 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14263 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14265 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         0))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None))) *)
(*                       else ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14267 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14269 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14271 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     0))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None)))) *)
(*                 else None) *)
(*               else ( *)
(*                 rely ( *)
(*                   ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 rely ((("granules" = ("granules")) /\ ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                 if ( *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - *)
(*                       (GRANULE_STATE_RD)) =? *)
(*                       (0))) *)
(*                   then true *)
(*                   else ( *)
(*                     match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_0) => true *)
(*                     | None => false *)
(*                     end)) *)
(*                 then ( *)
(*                   when cid_0 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   if ( *)
(*                     ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + *)
(*                       ((- 1))) <? *)
(*                       (0))) *)
(*                   then None *)
(*                   else ( *)
(*                     if ((64 & (36028797018963968)) =? (0)) *)
(*                     then ( *)
(*                       if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                       then ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14273 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14275 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14277 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     64))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None) *)
(*                       else ( *)
(*                         if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14279 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14281 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14283 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14285 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14287 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14289 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None))) *)
(*                     else ( *)
(*                       if (((64 & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                       then ( *)
(*                         if (((v_ulevel + ((- 1))) =? (3)) && (((64 & (3)) =? (3)))) *)
(*                         then ( *)
(*                           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                           rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                           if ( *)
(*                             match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_3) => true *)
(*                             | None => false *)
(*                             end) *)
(*                           then ( *)
(*                             rely (((v_call34.(poffset)) = (0))); *)
(*                             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                             rely (((v_call15.(poffset)) = (0))); *)
(*                             rely ( *)
(*                               (((((((lens 14291 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                 (((((((lens 14293 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                             (Some ( *)
(*                               0  , *)
(*                               (((lens 14295 st_4).[share].[granule_data] :< *)
(*                                 ((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                   (((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                     zero_granule_data_normal))).[share].[slots] :< *)
(*                                 ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                             ))) *)
(*                           else None) *)
(*                         else ( *)
(*                           if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1)))) *)
(*                           then ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14297 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14299 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14301 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None) *)
(*                           else ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                             if ( *)
(*                               match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_3) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14303 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14305 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14307 st_4).[share].[granule_data] :< *)
(*                                   ((((st_4.(share)).(granule_data)) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         64))) # *)
(*                                     (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_4.(share)).(granule_data)) # *)
(*                                       (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None))) *)
(*                       else ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                         if ( *)
(*                           match ((((((lens 113 st_4).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14309 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14311 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14313 st_4).[share].[granule_data] :< *)
(*                               ((((st_4.(share)).(granule_data)) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     64))) # *)
(*                                 (((st_4.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_4.(share)).(granule_data)) # *)
(*                                   (((st_4.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None)))) *)
(*                 else None)) *)
(*             else ( *)
(*               rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*               rely (((v_call33.(pbase)) = ("granules"))); *)
(*               rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*               rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               when cid_0 == (((((st_4.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some (5, ((lens 13935 st_4).[share].[slots] :< ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))) *)
(*           | None => None *)
(*           end)) *)
(*       else ( *)
(*         rely (((v_call34.(poffset)) = (0))); *)
(*         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*         when cid_0 == (((((st_26.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*         rely (((v_call15.(poffset)) = (0))); *)
(*         rely ( *)
(*           (((((((lens 13817 st_26).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*             (((((((lens 13817 st_26).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*         (Some (5, ((lens 13935 st_26).[share].[slots] :< ((((st_26.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))))) *)
(*   else ( *)
(*     rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*     rely (((v_call33.(pbase)) = ("granules"))); *)
(*     rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*     rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*     rely (((v_call34.(poffset)) = (0))); *)
(*     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*     when cid_0 == (((((st_26.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*     rely (((v_call15.(poffset)) = (0))); *)
(*     rely ( *)
(*       (((((((lens 13817 st_26).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*         (((((((lens 13817 st_26).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*     (Some (5, ((lens 13935 st_26).[share].[slots] :< ((((st_26.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))). *)

(* Definition smc_rtt_fold_7 (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) := *)
(*   rely (((v_call33.(pbase)) = ("granules"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*   rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*   if ( *)
(*     if ((((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*     then true *)
(*     else ( *)
(*       match (((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*       | (Some cid) => true *)
(*       | None => false *)
(*       end)) *)
(*   then ( *)
(*     when cid == (((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*     if ((((((st_29.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*     then None *)
(*     else ( *)
(*       if (((v_call60 |' (4)) & (36028797018963968)) =? (0)) *)
(*       then ( *)
(*         if (((v_ulevel + ((- 1))) =? (3)) && ((((v_call60 |' (4)) & (3)) =? (3)))) *)
(*         then ( *)
(*           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*           if ( *)
(*             match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*             | (Some cid_2) => true *)
(*             | None => false *)
(*             end) *)
(*           then ( *)
(*             rely (((v_call34.(poffset)) = (0))); *)
(*             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*             rely (((v_call15.(poffset)) = (0))); *)
(*             rely ( *)
(*               (((((((lens 14315 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                 (((((((lens 14317 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*             (Some ( *)
(*               0  , *)
(*               (((lens 14319 st_29).[share].[granule_data] :< *)
(*                 ((((st_29.(share)).(granule_data)) # *)
(*                   (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                   ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                     (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                       ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                       (v_call60 |' (4))))) # *)
(*                   (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                   (((((st_29.(share)).(granule_data)) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                     zero_granule_data_normal))).[share].[slots] :< *)
(*                 ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*             ))) *)
(*           else None) *)
(*         else ( *)
(*           if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (4)) & (3)) =? (1)))) *)
(*           then ( *)
(*             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*             if ( *)
(*               match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*               | (Some cid_2) => true *)
(*               | None => false *)
(*               end) *)
(*             then ( *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 14321 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 14323 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some ( *)
(*                 0  , *)
(*                 (((lens 14325 st_29).[share].[granule_data] :< *)
(*                   ((((st_29.(share)).(granule_data)) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         (v_call60 |' (4))))) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                     (((((st_29.(share)).(granule_data)) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                       ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                         (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                           (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                       zero_granule_data_normal))).[share].[slots] :< *)
(*                   ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*               ))) *)
(*             else None) *)
(*           else ( *)
(*             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*             if ( *)
(*               match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*               | (Some cid_2) => true *)
(*               | None => false *)
(*               end) *)
(*             then ( *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 14327 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 14329 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some ( *)
(*                 0  , *)
(*                 (((lens 14331 st_29).[share].[granule_data] :< *)
(*                   ((((st_29.(share)).(granule_data)) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         (v_call60 |' (4))))) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                     (((((st_29.(share)).(granule_data)) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                       ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                         (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                           (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                       zero_granule_data_normal))).[share].[slots] :< *)
(*                   ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*               ))) *)
(*             else None))) *)
(*       else ( *)
(*         if ((((v_call60 |' (4)) & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*         then ( *)
(*           if (((v_ulevel + ((- 1))) =? (3)) && ((((v_call60 |' (4)) & (3)) =? (3)))) *)
(*           then ( *)
(*             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*             if ( *)
(*               match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*               | (Some cid_2) => true *)
(*               | None => false *)
(*               end) *)
(*             then ( *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 14333 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 14335 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some ( *)
(*                 0  , *)
(*                 (((lens 14337 st_29).[share].[granule_data] :< *)
(*                   ((((st_29.(share)).(granule_data)) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         (v_call60 |' (4))))) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                     (((((st_29.(share)).(granule_data)) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                       ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                         (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                           (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                       zero_granule_data_normal))).[share].[slots] :< *)
(*                   ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*               ))) *)
(*             else None) *)
(*           else ( *)
(*             if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (4)) & (3)) =? (1)))) *)
(*             then ( *)
(*               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*               if ( *)
(*                 match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                 | (Some cid_2) => true *)
(*                 | None => false *)
(*                 end) *)
(*               then ( *)
(*                 rely (((v_call34.(poffset)) = (0))); *)
(*                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                 rely (((v_call15.(poffset)) = (0))); *)
(*                 rely ( *)
(*                   (((((((lens 14339 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 14341 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 (Some ( *)
(*                   0  , *)
(*                   (((lens 14343 st_29).[share].[granule_data] :< *)
(*                     ((((st_29.(share)).(granule_data)) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                       ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                         (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                           (v_call60 |' (4))))) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                       (((((st_29.(share)).(granule_data)) # *)
(*                         (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                         ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                           (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                             (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                         zero_granule_data_normal))).[share].[slots] :< *)
(*                     ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                 ))) *)
(*               else None) *)
(*             else ( *)
(*               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*               if ( *)
(*                 match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                 | (Some cid_2) => true *)
(*                 | None => false *)
(*                 end) *)
(*               then ( *)
(*                 rely (((v_call34.(poffset)) = (0))); *)
(*                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                 rely (((v_call15.(poffset)) = (0))); *)
(*                 rely ( *)
(*                   (((((((lens 14345 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 14347 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 (Some ( *)
(*                   0  , *)
(*                   (((lens 14349 st_29).[share].[granule_data] :< *)
(*                     ((((st_29.(share)).(granule_data)) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                       ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                         (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                           (v_call60 |' (4))))) # *)
(*                       (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                       (((((st_29.(share)).(granule_data)) # *)
(*                         (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                         ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                           (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                             (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                         zero_granule_data_normal))).[share].[slots] :< *)
(*                     ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                 ))) *)
(*               else None))) *)
(*         else ( *)
(*           rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*           if ( *)
(*             match ((((((lens 56 st_29).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*             | (Some cid_2) => true *)
(*             | None => false *)
(*             end) *)
(*           then ( *)
(*             rely (((v_call34.(poffset)) = (0))); *)
(*             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*             rely (((v_call15.(poffset)) = (0))); *)
(*             rely ( *)
(*               (((((((lens 14351 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                 (((((((lens 14353 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*             (Some ( *)
(*               0  , *)
(*               (((lens 14355 st_29).[share].[granule_data] :< *)
(*                 ((((st_29.(share)).(granule_data)) # *)
(*                   (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                   ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                     (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                       ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                       (v_call60 |' (4))))) # *)
(*                   (((st_29.(share)).(slots)) @ SLOT_RTT2) == *)
(*                   (((((st_29.(share)).(granule_data)) # *)
(*                     (((st_29.(share)).(slots)) @ SLOT_RTT) == *)
(*                     ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                       (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                         ((v_call15.(poffset)) + ((8 * (((((lens 56 st_29).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                         (v_call60 |' (4))))) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                     zero_granule_data_normal))).[share].[slots] :< *)
(*                 ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*             ))) *)
(*           else None)))) *)
(*   else None. *)

(* Definition smc_rtt_fold_8 (v_call34: Ptr) (v_ulevel: Z) (v_call60: Z) (v_call33: Ptr) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_s2_ctx: Ptr) (v_map_addr: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) := *)
(*   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*   rely (((v_call33.(pbase)) = ("granules"))); *)
(*   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*   when cid == (((((st_29.(share)).(granules)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*   if (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) =? (0)) *)
(*   then ( *)
(*     if ((v_ulevel =? (3)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3)))) *)
(*     then ( *)
(*       if ( *)
(*         (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*           (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) & *)
(*           (281474976710655)) & *)
(*           (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*           ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*             (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =? *)
(*           (0))) *)
(*       then ( *)
(*         match ( *)
(*           (__table_maps_block_loop840 *)
(*             (z_to_nat 511) *)
(*             false *)
(*             (1 << ((((3 - (v_ulevel)) * (9)) + (12)))) *)
(*             (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*               (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) *)
(*             1 *)
(*             v_ulevel *)
(*             false *)
(*             v_call34 *)
(*             (mkPtr "s2tte_is_valid" 0) *)
(*             st_29) *)
(*         ) with *)
(*         | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) => *)
(*           if v_retval_2 *)
(*           then ( *)
(*             rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*             if ( *)
(*               if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*               then true *)
(*               else ( *)
(*                 match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                 | (Some cid_0) => true *)
(*                 | None => false *)
(*                 end)) *)
(*             then ( *)
(*               when cid_0 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*               if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*               then None *)
(*               else ( *)
(*                 if (((v_call60 |' (2009)) & (36028797018963968)) =? (0)) *)
(*                 then ( *)
(*                   if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (2009)) & (3)) =? (1)))) *)
(*                   then ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     if ( *)
(*                       match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 14357 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 14359 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 14361 st_6).[share].[granule_data] :< *)
(*                           ((((st_6.(share)).(granule_data)) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 (v_call60 |' (2009))))) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None) *)
(*                   else ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     if ( *)
(*                       match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 14363 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 14365 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 14367 st_6).[share].[granule_data] :< *)
(*                           ((((st_6.(share)).(granule_data)) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 (v_call60 |' (2009))))) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None)) *)
(*                 else ( *)
(*                   if ((((v_call60 |' (2009)) & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                   then ( *)
(*                     if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (2009)) & (3)) =? (1)))) *)
(*                     then ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       if ( *)
(*                         match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 14369 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 14371 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 14373 st_6).[share].[granule_data] :< *)
(*                             ((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (2009))))) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None) *)
(*                     else ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       if ( *)
(*                         match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 14375 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 14377 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 14379 st_6).[share].[granule_data] :< *)
(*                             ((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (2009))))) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None)) *)
(*                   else ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     if ( *)
(*                       match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 14381 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 14383 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 14385 st_6).[share].[granule_data] :< *)
(*                           ((((st_6.(share)).(granule_data)) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 (v_call60 |' (2009))))) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None)))) *)
(*             else None) *)
(*           else ( *)
(*             when cid_0 == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*             if ( *)
(*               ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =? *)
(*                 (0))) *)
(*             then ( *)
(*               if (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3)) *)
(*               then ( *)
(*                 if ( *)
(*                   (((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                     (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) & *)
(*                     (281474976710655)) & *)
(*                     (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*                     ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                       (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =? *)
(*                     (0))) *)
(*                 then ( *)
(*                   match ( *)
(*                     (__table_maps_block_loop840 *)
(*                       (z_to_nat 511) *)
(*                       false *)
(*                       (1 << ((((3 - (v_ulevel)) * (9)) + (12)))) *)
(*                       (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                         (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) *)
(*                       1 *)
(*                       v_ulevel *)
(*                       false *)
(*                       v_call34 *)
(*                       (mkPtr "s2tte_is_valid_ns" 0) *)
(*                       st_6) *)
(*                   ) with *)
(*                   | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_1, v_retval_3, v_table_1, v_s2tte_is_x_1, st_7)) => *)
(*                     if v_retval_3 *)
(*                     then ( *)
(*                       rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                       if ( *)
(*                         if ((((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*                         then true *)
(*                         else ( *)
(*                           match (((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_1) => true *)
(*                           | None => false *)
(*                           end)) *)
(*                       then ( *)
(*                         when cid_1 == (((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                         if ((((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*                         then None *)
(*                         else ( *)
(*                           if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0)) *)
(*                           then ( *)
(*                             if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1)))) *)
(*                             then ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               if ( *)
(*                                 match ((((((lens 56 st_7).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14387 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14389 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14391 st_7).[share].[granule_data] :< *)
(*                                     ((((st_7.(share)).(granule_data)) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           (v_call60 |' (54043195528446977))))) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_7.(share)).(granule_data)) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             (v_call60 |' (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None) *)
(*                             else ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               if ( *)
(*                                 match ((((((lens 56 st_7).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14393 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14395 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14397 st_7).[share].[granule_data] :< *)
(*                                     ((((st_7.(share)).(granule_data)) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           (v_call60 |' (54043195528446977))))) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_7.(share)).(granule_data)) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             (v_call60 |' (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None)) *)
(*                           else ( *)
(*                             if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                             then ( *)
(*                               if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1)))) *)
(*                               then ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 if ( *)
(*                                   match ((((((lens 56 st_7).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14399 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14401 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14403 st_7).[share].[granule_data] :< *)
(*                                       ((((st_7.(share)).(granule_data)) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             (v_call60 |' (54043195528446977))))) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_7.(share)).(granule_data)) # *)
(*                                           (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               (v_call60 |' (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None) *)
(*                               else ( *)
(*                                 rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                                 if ( *)
(*                                   match ((((((lens 56 st_7).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                   | (Some cid_4) => true *)
(*                                   | None => false *)
(*                                   end) *)
(*                                 then ( *)
(*                                   rely (((v_call34.(poffset)) = (0))); *)
(*                                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                   rely (((v_call15.(poffset)) = (0))); *)
(*                                   rely ( *)
(*                                     (((((((lens 14405 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                       (((((((lens 14407 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                   (Some ( *)
(*                                     0  , *)
(*                                     (((lens 14409 st_7).[share].[granule_data] :< *)
(*                                       ((((st_7.(share)).(granule_data)) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             (v_call60 |' (54043195528446977))))) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                         (((((st_7.(share)).(granule_data)) # *)
(*                                           (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                           ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                             (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                               ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                               (v_call60 |' (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                           zero_granule_data_normal))).[share].[slots] :< *)
(*                                       ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                   ))) *)
(*                                 else None)) *)
(*                             else ( *)
(*                               rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                               if ( *)
(*                                 match ((((((lens 56 st_7).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                                 | (Some cid_4) => true *)
(*                                 | None => false *)
(*                                 end) *)
(*                               then ( *)
(*                                 rely (((v_call34.(poffset)) = (0))); *)
(*                                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                                 rely (((v_call15.(poffset)) = (0))); *)
(*                                 rely ( *)
(*                                   (((((((lens 14411 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                     (((((((lens 14413 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                                 (Some ( *)
(*                                   0  , *)
(*                                   (((lens 14415 st_7).[share].[granule_data] :< *)
(*                                     ((((st_7.(share)).(granule_data)) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           (v_call60 |' (54043195528446977))))) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                       (((((st_7.(share)).(granule_data)) # *)
(*                                         (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                         ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                           (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                             ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                             (v_call60 |' (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                         zero_granule_data_normal))).[share].[slots] :< *)
(*                                     ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                                 ))) *)
(*                               else None)))) *)
(*                       else None) *)
(*                     else ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       when cid_1 == (((((st_7.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                         ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                   | None => None *)
(*                   end) *)
(*                 else ( *)
(*                   rely (((v_call34.(poffset)) = (0))); *)
(*                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                   when cid_1 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   rely (((v_call15.(poffset)) = (0))); *)
(*                   rely ( *)
(*                     (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                       (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                   (Some ( *)
(*                     (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                     ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                   )))) *)
(*               else ( *)
(*                 rely (((v_call34.(poffset)) = (0))); *)
(*                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                 when cid_1 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                 rely (((v_call15.(poffset)) = (0))); *)
(*                 rely ( *)
(*                   (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 (Some ( *)
(*                   (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                   ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                 )))) *)
(*             else ( *)
(*               rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*               rely (((v_call33.(pbase)) = ("granules"))); *)
(*               rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*               rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               when cid_1 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some ( *)
(*                 (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                 ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*               )))) *)
(*         | None => None *)
(*         end) *)
(*       else ( *)
(*         rely (((v_call34.(poffset)) = (0))); *)
(*         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*         when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*         rely (((v_call15.(poffset)) = (0))); *)
(*         rely ( *)
(*           (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*             (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*         (Some ( *)
(*           (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*           ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*         )))) *)
(*     else ( *)
(*       if ((v_ulevel =? (2)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1)))) *)
(*       then ( *)
(*         if ( *)
(*           (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*             (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) & *)
(*             (281474976710655)) & *)
(*             (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*             ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*               (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =? *)
(*             (0))) *)
(*         then ( *)
(*           match ( *)
(*             (__table_maps_block_loop840 *)
(*               (z_to_nat 511) *)
(*               false *)
(*               (1 << ((((3 - (v_ulevel)) * (9)) + (12)))) *)
(*               (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                 (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) *)
(*               1 *)
(*               v_ulevel *)
(*               false *)
(*               v_call34 *)
(*               (mkPtr "s2tte_is_valid" 0) *)
(*               st_29) *)
(*           ) with *)
(*           | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) => *)
(*             if v_retval_2 *)
(*             then ( *)
(*               rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*               if ( *)
(*                 if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*                 then true *)
(*                 else ( *)
(*                   match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                   | (Some cid_0) => true *)
(*                   | None => false *)
(*                   end)) *)
(*               then ( *)
(*                 when cid_0 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                 if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*                 then None *)
(*                 else ( *)
(*                   rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                   rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0))))); *)
(*                   if ( *)
(*                     match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_3) => true *)
(*                     | None => false *)
(*                     end) *)
(*                   then ( *)
(*                     rely (((v_call34.(poffset)) = (0))); *)
(*                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                     rely (((v_call15.(poffset)) = (0))); *)
(*                     rely ( *)
(*                       (((((((lens 14429 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                         (((((((lens 14431 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                     (Some ( *)
(*                       0  , *)
(*                       (((lens 14433 st_6).[share].[granule_data] :< *)
(*                         ((((st_6.(share)).(granule_data)) # *)
(*                           (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                           ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                             (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                               ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                               (v_call60 |' (2009))))) # *)
(*                           (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                           (((((st_6.(share)).(granule_data)) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 (v_call60 |' (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                             zero_granule_data_normal))).[share].[slots] :< *)
(*                         ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                     ))) *)
(*                   else None)) *)
(*               else None) *)
(*             else ( *)
(*               when cid_0 == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(e_lock))); *)
(*               if ( *)
(*                 ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =? *)
(*                   (0))) *)
(*               then ( *)
(*                 if ((v_ulevel =? (2)) && ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1)))) *)
(*                 then ( *)
(*                   if ( *)
(*                     (((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                       (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) & *)
(*                       (281474976710655)) & *)
(*                       (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*                       ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                         (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =? *)
(*                       (0))) *)
(*                   then ( *)
(*                     match ( *)
(*                       (__table_maps_block_loop840 *)
(*                         (z_to_nat 511) *)
(*                         false *)
(*                         (1 << ((((3 - (v_ulevel)) * (9)) + (12)))) *)
(*                         (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                           (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) *)
(*                         1 *)
(*                         v_ulevel *)
(*                         false *)
(*                         v_call34 *)
(*                         (mkPtr "s2tte_is_valid_ns" 0) *)
(*                         st_6) *)
(*                     ) with *)
(*                     | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_1, v_retval_3, v_table_1, v_s2tte_is_x_1, st_7)) => *)
(*                       if v_retval_3 *)
(*                       then ( *)
(*                         rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                         if ( *)
(*                           if ((((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*                           then true *)
(*                           else ( *)
(*                             match (((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                             | (Some cid_1) => true *)
(*                             | None => false *)
(*                             end)) *)
(*                         then ( *)
(*                           when cid_1 == (((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                           if ((((((st_7.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*                           then None *)
(*                           else ( *)
(*                             rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                             if ( *)
(*                               match ((((((lens 56 st_7).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                               | (Some cid_4) => true *)
(*                               | None => false *)
(*                               end) *)
(*                             then ( *)
(*                               rely (((v_call34.(poffset)) = (0))); *)
(*                               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                               rely (((v_call15.(poffset)) = (0))); *)
(*                               rely ( *)
(*                                 (((((((lens 14447 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                                   (((((((lens 14449 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                               (Some ( *)
(*                                 0  , *)
(*                                 (((lens 14451 st_7).[share].[granule_data] :< *)
(*                                   ((((st_7.(share)).(granule_data)) # *)
(*                                     (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                     ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                       (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                         ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                         (v_call60 |' (54043195528446977))))) # *)
(*                                     (((st_7.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                     (((((st_7.(share)).(granule_data)) # *)
(*                                       (((st_7.(share)).(slots)) @ SLOT_RTT) == *)
(*                                       ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                         (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                           ((v_call15.(poffset)) + ((8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                           (v_call60 |' (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                       zero_granule_data_normal))).[share].[slots] :< *)
(*                                   ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                               ))) *)
(*                             else None)) *)
(*                         else None) *)
(*                       else ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         when cid_1 == (((((st_7.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                           ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                     | None => None *)
(*                     end) *)
(*                   else ( *)
(*                     rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*                     rely (((v_call33.(pbase)) = ("granules"))); *)
(*                     rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*                     rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     rely (((v_call34.(poffset)) = (0))); *)
(*                     rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                     when cid_1 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                     rely (((v_call15.(poffset)) = (0))); *)
(*                     rely ( *)
(*                       (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                         (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                     (Some ( *)
(*                       (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                       ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                     )))) *)
(*                 else ( *)
(*                   rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*                   rely (((v_call33.(pbase)) = ("granules"))); *)
(*                   rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*                   rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                   rely (((v_call34.(poffset)) = (0))); *)
(*                   rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                   when cid_1 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   rely (((v_call15.(poffset)) = (0))); *)
(*                   rely ( *)
(*                     (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                       (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                   (Some ( *)
(*                     (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                     ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                   )))) *)
(*               else ( *)
(*                 rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*                 rely (((v_call33.(pbase)) = ("granules"))); *)
(*                 rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*                 rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                 rely (((v_call34.(poffset)) = (0))); *)
(*                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                 when cid_1 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                 rely (((v_call15.(poffset)) = (0))); *)
(*                 rely ( *)
(*                   (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 (Some ( *)
(*                   (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                   ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                 )))) *)
(*           | None => None *)
(*           end) *)
(*         else ( *)
(*           rely (((v_call34.(poffset)) = (0))); *)
(*           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*           when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*           rely (((v_call15.(poffset)) = (0))); *)
(*           rely ( *)
(*             (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*               (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*           (Some ( *)
(*             (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*             ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*           )))) *)
(*       else ( *)
(*         rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*         rely (((v_call33.(pbase)) = ("granules"))); *)
(*         rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*         rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*         rely (((v_call34.(poffset)) = (0))); *)
(*         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*         when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*         rely (((v_call15.(poffset)) = (0))); *)
(*         rely ( *)
(*           (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*             (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*         (Some ( *)
(*           (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*           ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*         ))))) *)
(*   else ( *)
(*     if ( *)
(*       ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (36028797018963968)) - (36028797018963968)) =? *)
(*         (0))) *)
(*     then ( *)
(*       if ((v_ulevel =? (3)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (3)))) *)
(*       then ( *)
(*         if ( *)
(*           (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*             (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) & *)
(*             (281474976710655)) & *)
(*             (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*             ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*               (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =? *)
(*             (0))) *)
(*         then ( *)
(*           match ( *)
(*             (__table_maps_block_loop840 *)
(*               (z_to_nat 511) *)
(*               false *)
(*               (1 << ((((3 - (v_ulevel)) * (9)) + (12)))) *)
(*               (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                 (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) *)
(*               1 *)
(*               v_ulevel *)
(*               false *)
(*               v_call34 *)
(*               (mkPtr "s2tte_is_valid_ns" 0) *)
(*               st_29) *)
(*           ) with *)
(*           | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) => *)
(*             if v_retval_2 *)
(*             then ( *)
(*               rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*               if ( *)
(*                 if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*                 then true *)
(*                 else ( *)
(*                   match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                   | (Some cid_0) => true *)
(*                   | None => false *)
(*                   end)) *)
(*               then ( *)
(*                 when cid_0 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                 if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*                 then None *)
(*                 else ( *)
(*                   if (((v_call60 |' (54043195528446977)) & (36028797018963968)) =? (0)) *)
(*                   then ( *)
(*                     if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1)))) *)
(*                     then ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       if ( *)
(*                         match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 14453 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 14455 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 14457 st_6).[share].[granule_data] :< *)
(*                             ((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (54043195528446977))))) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None) *)
(*                     else ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       if ( *)
(*                         match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 14459 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 14461 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 14463 st_6).[share].[granule_data] :< *)
(*                             ((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (54043195528446977))))) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None)) *)
(*                   else ( *)
(*                     if ((((v_call60 |' (54043195528446977)) & (36028797018963968)) - (36028797018963968)) =? (0)) *)
(*                     then ( *)
(*                       if (((v_ulevel + ((- 1))) =? (2)) && ((((v_call60 |' (54043195528446977)) & (3)) =? (1)))) *)
(*                       then ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         if ( *)
(*                           match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14465 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14467 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14469 st_6).[share].[granule_data] :< *)
(*                               ((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (54043195528446977))))) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_6.(share)).(granule_data)) # *)
(*                                   (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       (v_call60 |' (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None) *)
(*                       else ( *)
(*                         rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                         if ( *)
(*                           match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                           | (Some cid_3) => true *)
(*                           | None => false *)
(*                           end) *)
(*                         then ( *)
(*                           rely (((v_call34.(poffset)) = (0))); *)
(*                           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                           rely (((v_call15.(poffset)) = (0))); *)
(*                           rely ( *)
(*                             (((((((lens 14471 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                               (((((((lens 14473 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                           (Some ( *)
(*                             0  , *)
(*                             (((lens 14475 st_6).[share].[granule_data] :< *)
(*                               ((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (54043195528446977))))) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                                 (((((st_6.(share)).(granule_data)) # *)
(*                                   (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                   ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                     (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                       ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                       (v_call60 |' (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                   zero_granule_data_normal))).[share].[slots] :< *)
(*                               ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                           ))) *)
(*                         else None)) *)
(*                     else ( *)
(*                       rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                       if ( *)
(*                         match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                         | (Some cid_3) => true *)
(*                         | None => false *)
(*                         end) *)
(*                       then ( *)
(*                         rely (((v_call34.(poffset)) = (0))); *)
(*                         rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                         rely (((v_call15.(poffset)) = (0))); *)
(*                         rely ( *)
(*                           (((((((lens 14477 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                             (((((((lens 14479 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                         (Some ( *)
(*                           0  , *)
(*                           (((lens 14481 st_6).[share].[granule_data] :< *)
(*                             ((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (54043195528446977))))) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                               (((((st_6.(share)).(granule_data)) # *)
(*                                 (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                                 ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                   (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                     ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                     (v_call60 |' (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                                 zero_granule_data_normal))).[share].[slots] :< *)
(*                             ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                         ))) *)
(*                       else None)))) *)
(*               else None) *)
(*             else ( *)
(*               rely (((v_call34.(poffset)) = (0))); *)
(*               rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*               when cid_0 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*               rely (((v_call15.(poffset)) = (0))); *)
(*               rely ( *)
(*                 (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some ( *)
(*                 (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                 ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*               ))) *)
(*           | None => None *)
(*           end) *)
(*         else ( *)
(*           rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*           rely (((v_call33.(pbase)) = ("granules"))); *)
(*           rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*           rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*           rely (((v_call34.(poffset)) = (0))); *)
(*           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*           when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*           rely (((v_call15.(poffset)) = (0))); *)
(*           rely ( *)
(*             (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*               (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*           (Some ( *)
(*             (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*             ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*           )))) *)
(*       else ( *)
(*         if ((v_ulevel =? (2)) && ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (3)) =? (1)))) *)
(*         then ( *)
(*           if ( *)
(*             (((((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*               (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) & *)
(*               (281474976710655)) & *)
(*               (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*               ((((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                 (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =? *)
(*               (0))) *)
(*           then ( *)
(*             match ( *)
(*               (__table_maps_block_loop840 *)
(*                 (z_to_nat 511) *)
(*                 false *)
(*                 (1 << ((((3 - (v_ulevel)) * (9)) + (12)))) *)
(*                 (((((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_call34.(poffset))) & (281474976710655)) & *)
(*                   (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) *)
(*                 1 *)
(*                 v_ulevel *)
(*                 false *)
(*                 v_call34 *)
(*                 (mkPtr "s2tte_is_valid_ns" 0) *)
(*                 st_29) *)
(*             ) with *)
(*             | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) => *)
(*               if v_retval_2 *)
(*               then ( *)
(*                 rely ((((v_call33.(pbase)) = ("granules")) /\ (((((v_call33.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8))))); *)
(*                 if ( *)
(*                   if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0)) *)
(*                   then true *)
(*                   else ( *)
(*                     match (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                     | (Some cid_0) => true *)
(*                     | None => false *)
(*                     end)) *)
(*                 then ( *)
(*                   when cid_0 == (((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   if ((((((st_6.(share)).(granules)) @ (((v_call33.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0)) *)
(*                   then None *)
(*                   else ( *)
(*                     rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*                     if ( *)
(*                       match ((((((lens 56 st_6).(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with *)
(*                       | (Some cid_3) => true *)
(*                       | None => false *)
(*                       end) *)
(*                     then ( *)
(*                       rely (((v_call34.(poffset)) = (0))); *)
(*                       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                       rely (((v_call15.(poffset)) = (0))); *)
(*                       rely ( *)
(*                         (((((((lens 14495 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                           (((((((lens 14497 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                       (Some ( *)
(*                         0  , *)
(*                         (((lens 14499 st_6).[share].[granule_data] :< *)
(*                           ((((st_6.(share)).(granule_data)) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                             ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                               (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                 ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                 (v_call60 |' (54043195528446977))))) # *)
(*                             (((st_6.(share)).(slots)) @ SLOT_RTT2) == *)
(*                             (((((st_6.(share)).(granule_data)) # *)
(*                               (((st_6.(share)).(slots)) @ SLOT_RTT) == *)
(*                               ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :< *)
(*                                 (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # *)
(*                                   ((v_call15.(poffset)) + ((8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (8))))))) == *)
(*                                   (v_call60 |' (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :< *)
(*                               zero_granule_data_normal))).[share].[slots] :< *)
(*                           ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                       ))) *)
(*                     else None)) *)
(*                 else None) *)
(*               else ( *)
(*                 rely (((v_call34.(poffset)) = (0))); *)
(*                 rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*                 when cid_0 == (((((st_6.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                 rely (((v_call15.(poffset)) = (0))); *)
(*                 rely ( *)
(*                   (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*                 (Some ( *)
(*                   (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*                   ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*                 ))) *)
(*             | None => None *)
(*             end) *)
(*           else ( *)
(*             rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*             rely (((v_call33.(pbase)) = ("granules"))); *)
(*             rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*             rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*             rely (((v_call34.(poffset)) = (0))); *)
(*             rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*             when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*             rely (((v_call15.(poffset)) = (0))); *)
(*             rely ( *)
(*               (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*                 (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*             (Some ( *)
(*               (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*               ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*             )))) *)
(*         else ( *)
(*           rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*           rely (((v_call33.(pbase)) = ("granules"))); *)
(*           rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*           rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*           rely (((v_call34.(poffset)) = (0))); *)
(*           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*           when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*           rely (((v_call15.(poffset)) = (0))); *)
(*           rely ( *)
(*             (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*               (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*           (Some ( *)
(*             (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*             ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*           ))))) *)
(*     else ( *)
(*       rely (((v_call34.(pbase)) = ("slot_rtt2"))); *)
(*       rely (((v_call33.(pbase)) = ("granules"))); *)
(*       rely (((v_call15.(pbase)) = ("slot_rtt"))); *)
(*       rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack"))); *)
(*       rely (((v_call34.(poffset)) = (0))); *)
(*       rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*       when cid_0 == (((((st_29.(share)).(granules)) @ ((v_call33.(poffset)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*       rely (((v_call15.(poffset)) = (0))); *)
(*       rely ( *)
(*         (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\ *)
(*           (((((((lens 13817 st_29).(stack)).(smc_rtt_fold_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))))); *)
(*       (Some ( *)
(*         (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  , *)
(*         ((lens 13935 st_29).[share].[slots] :< ((((st_29.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))) *)
(*       )))). *)

(* Definition smc_rtt_fold_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) := *)
(*   when st_0 == ((new_frame "smc_rtt_fold" st)); *)
(*   when v_wi, st_1 == ((alloc_stack "smc_rtt_fold" 24 8 st_0)); *)
(*   when v_s2_ctx, st_2 == ((alloc_stack "smc_rtt_fold" 32 8 st_1)); *)
(*   when v_ripas, st_3 == ((alloc_stack "smc_rtt_fold" 4 4 st_2)); *)
(*   when v_call, st_4 == ((find_lock_granule_spec v_rd_addr 2 st_3)); *)
(*   if (ptr_eqb v_call (mkPtr "null" 0)) *)
(*   then ( *)
(*     when st_6 == ((free_stack "smc_rtt_fold" st_0 st_4)); *)
(*     (Some (1, st_6))) *)
(*   else ( *)
(*     when v_call1_0, st_5 == ((granule_map_spec v_call 2 st_4)); *)
(*     when v_call2, st_6 == ((validate_rtt_structure_cmds_spec v_map_addr v_ulevel v_call1_0 st_5)); *)
(*     if v_call2 *)
(*     then ( *)
(*       when v_4, st_16 == ((smc_rtt_fold_1 v_call1_0 v_s2_ctx v_call v_map_addr v_ulevel v_wi st_6)); *)
(*       if ((v_4 - ((v_ulevel + ((- 1))))) =? (0)) *)
(*       then ( *)
(*         when v_5_tmp, st_17 == ((load_RData 8 (ptr_offset v_wi 0) st_16)); *)
(*         rely (((v_5_tmp < (STACK_VIRT)) /\ ((v_5_tmp >= (GRANULES_BASE))))); *)
(*         when v_call15, st_18 == ((granule_map_spec (int_to_ptr v_5_tmp) 22 st_17)); *)
(*         when v_7, st_19 == ((load_RData 8 (ptr_offset v_wi 8) st_18)); *)
(*         when v_call16, st_20 == ((__tte_read_spec (ptr_offset v_call15 (8 * (v_7))) st_19)); *)
(*         when v_call18, st_21 == ((s2tte_is_table_spec v_call16 (v_ulevel + ((- 1))) st_20)); *)
(*         if v_call18 *)
(*         then ( *)
(*           when v_call25, st_22 == ((s2tte_pa_table_spec v_call16 (v_ulevel + ((- 1))) st_21)); *)
(*           if ((v_call25 - (v_rtt_addr)) =? (0)) *)
(*           then ( *)
(*             when v_call33, st_24 == ((find_lock_granule_spec v_rtt_addr 6 st_22)); *)
(*             when v_call34, st_25 == ((granule_map_spec v_call33 23 st_24)); *)
(*             when v_9, st_26 == ((load_RData 8 (ptr_offset v_call33 8) st_25)); *)
(*             if (v_9 =? (0)) *)
(*             then ( *)
(*               when v_call38, st_27 == ((table_is_destroyed_block_spec v_call34 st_26)); *)
(*               if v_call38 *)
(*               then ( *)
(*                 when v_10_tmp, st_28 == ((load_RData 8 (ptr_offset v_wi 0) st_27)); *)
(*                 rely (((v_10_tmp < (STACK_VIRT)) /\ ((v_10_tmp >= (GRANULES_BASE))))); *)
(*                 when st_29 == ((__granule_put_spec (int_to_ptr v_10_tmp) st_28)); *)
(*                 when v_13, st_31 == ((load_RData 8 (ptr_offset v_wi 8) st_29)); *)
(*                 when st_32 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_31)); *)
(*                 when v_call87, st_33 == ((s2tte_is_valid_spec 8 (v_ulevel + ((- 1))) st_32)); *)
(*                 if v_call87 *)
(*                 then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_33) *)
(*                 else ( *)
(*                   when v_call90, st_34 == ((s2tte_is_valid_ns_spec 8 (v_ulevel + ((- 1))) st_33)); *)
(*                   if v_call90 *)
(*                   then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_34) *)
(*                   else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 8 v_call33 st_0 st_34))) *)
(*               else ( *)
(*                 when v_call42, st_28 == ((table_is_unassigned_block_spec v_call34 v_ripas st_27)); *)
(*                 if v_call42 *)
(*                 then ( *)
(*                   when v_11, st_29 == ((load_RData 4 v_ripas st_28)); *)
(*                   when v_call44, st_30 == ((s2tte_create_unassigned_spec v_11 st_29)); *)
(*                   when v_12_tmp, st_31 == ((load_RData 8 (ptr_offset v_wi 0) st_30)); *)
(*                   rely (((v_12_tmp < (STACK_VIRT)) /\ ((v_12_tmp >= (GRANULES_BASE))))); *)
(*                   when st_32 == ((__granule_put_spec (int_to_ptr v_12_tmp) st_31)); *)
(*                   when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_32)); *)
(*                   when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34)); *)
(*                   when v_call87, st_36 == ((s2tte_is_valid_spec v_call44 (v_ulevel + ((- 1))) st_35)); *)
(*                   if v_call87 *)
(*                   then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_36) *)
(*                   else ( *)
(*                     when v_call90, st_37 == ((s2tte_is_valid_ns_spec v_call44 (v_ulevel + ((- 1))) st_36)); *)
(*                     if v_call90 *)
(*                     then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_37) *)
(*                     else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call44 v_call33 st_0 st_37))) *)
(*                 else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_28))) *)
(*             else ( *)
(*               if (v_9 =? (512)) *)
(*               then ( *)
(*                 if (v_ulevel <? (3)) *)
(*                 then ( *)
(*                   when st_27 == ((buffer_unmap_spec v_call34 st_26)); *)
(*                   when st_28 == ((granule_unlock_spec v_call33 st_27)); *)
(*                   when st_29 == ((buffer_unmap_spec v_call15 st_28)); *)
(*                   when v_15_tmp, st_30 == ((load_RData 8 (ptr_offset v_wi 0) st_29)); *)
(*                   rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE))))); *)
(*                   when st_31 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_30)); *)
(*                   when st_33 == ((free_stack "smc_rtt_fold" st_0 st_31)); *)
(*                   (Some (5, st_33))) *)
(*                 else ( *)
(*                   when v_call59, st_27 == ((__tte_read_spec v_call34 st_26)); *)
(*                   when v_call60, st_28 == ((s2tte_pa_spec v_call59 v_ulevel st_27)); *)
(*                   when v_call61, st_29 == ((table_maps_assigned_block_spec v_call34 v_ulevel st_28)); *)
(*                   if v_call61 *)
(*                   then ( *)
(*                     when v_call64, st_30 == ((s2tte_create_assigned_empty_spec v_call60 (v_ulevel + ((- 1))) st_29)); *)
(*                     when st_32 == ((__granule_refcount_dec_spec v_call33 512 st_30)); *)
(*                     when v_13, st_33 == ((load_RData 8 (ptr_offset v_wi 8) st_32)); *)
(*                     when st_34 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_33)); *)
(*                     when v_call87, st_35 == ((s2tte_is_valid_spec v_call64 (v_ulevel + ((- 1))) st_34)); *)
(*                     if v_call87 *)
(*                     then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_35) *)
(*                     else ( *)
(*                       when v_call90, st_36 == ((s2tte_is_valid_ns_spec v_call64 (v_ulevel + ((- 1))) st_35)); *)
(*                       if v_call90 *)
(*                       then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_36) *)
(*                       else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call64 v_call33 st_0 st_36))) *)
(*                   else ( *)
(*                     when v_call66, st_30 == ((table_maps_valid_block_spec v_call34 v_ulevel st_29)); *)
(*                     if v_call66 *)
(*                     then ( *)
(*                       when v_call69, st_31 == ((s2tte_create_valid_spec v_call60 (v_ulevel + ((- 1))) st_30)); *)
(*                       when st_33 == ((__granule_refcount_dec_spec v_call33 512 st_31)); *)
(*                       when v_13, st_34 == ((load_RData 8 (ptr_offset v_wi 8) st_33)); *)
(*                       when st_35 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_34)); *)
(*                       when v_call87, st_36 == ((s2tte_is_valid_spec v_call69 (v_ulevel + ((- 1))) st_35)); *)
(*                       if v_call87 *)
(*                       then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_36) *)
(*                       else ( *)
(*                         when v_call90, st_37 == ((s2tte_is_valid_ns_spec v_call69 (v_ulevel + ((- 1))) st_36)); *)
(*                         if v_call90 *)
(*                         then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_37) *)
(*                         else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call69 v_call33 st_0 st_37))) *)
(*                     else ( *)
(*                       when v_call71, st_31 == ((table_maps_valid_ns_block_spec v_call34 v_ulevel st_30)); *)
(*                       if v_call71 *)
(*                       then ( *)
(*                         when v_call74, st_32 == ((s2tte_create_valid_ns_spec v_call60 (v_ulevel + ((- 1))) st_31)); *)
(*                         when st_34 == ((__granule_refcount_dec_spec v_call33 512 st_32)); *)
(*                         when v_13, st_35 == ((load_RData 8 (ptr_offset v_wi 8) st_34)); *)
(*                         when st_36 == ((__tte_write_spec (ptr_offset v_call15 (8 * (v_13))) 0 st_35)); *)
(*                         when v_call87, st_37 == ((s2tte_is_valid_spec v_call74 (v_ulevel + ((- 1))) st_36)); *)
(*                         if v_call87 *)
(*                         then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_37) *)
(*                         else ( *)
(*                           when v_call90, st_38 == ((s2tte_is_valid_ns_spec v_call74 (v_ulevel + ((- 1))) st_37)); *)
(*                           if v_call90 *)
(*                           then (smc_rtt_fold_2 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_38) *)
(*                           else (smc_rtt_fold_3 v_s2_ctx v_map_addr v_wi v_call15 v_call34 v_call74 v_call33 st_0 st_38))) *)
(*                       else ( *)
(*                         when v_call77, st_32 == ((pack_return_code_spec 4 v_ulevel st_31)); *)
(*                         when v_call78, st_39 == ((smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_32)); *)
(*                         (Some (v_call77, st_39))))))) *)
(*               else (smc_rtt_fold_5 v_call34 v_call33 v_call15 v_wi st_0 st_26))) *)
(*           else ( *)
(*             when v_call31, st_23 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_22)); *)
(*             when st_24 == ((buffer_unmap_spec v_call15 st_23)); *)
(*             when v_15_tmp, st_25 == ((load_RData 8 (ptr_offset v_wi 0) st_24)); *)
(*             rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE))))); *)
(*             when st_26 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_25)); *)
(*             when st_28 == ((free_stack "smc_rtt_fold" st_0 st_26)); *)
(*             (Some (v_call31, st_28)))) *)
(*         else ( *)
(*           when v_call22, st_22 == ((pack_return_code_spec 4 (v_ulevel + ((- 1))) st_21)); *)
(*           when st_23 == ((buffer_unmap_spec v_call15 st_22)); *)
(*           when v_15_tmp, st_24 == ((load_RData 8 (ptr_offset v_wi 0) st_23)); *)
(*           rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE))))); *)
(*           when st_25 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_24)); *)
(*           when st_27 == ((free_stack "smc_rtt_fold" st_0 st_25)); *)
(*           (Some (v_call22, st_27)))) *)
(*       else ( *)
(*         when v_call13, st_17 == ((pack_return_code_spec 4 v_4 st_16)); *)
(*         when v_15_tmp, st_18 == ((load_RData 8 (ptr_offset v_wi 0) st_17)); *)
(*         rely (((v_15_tmp < (STACK_VIRT)) /\ ((v_15_tmp >= (GRANULES_BASE))))); *)
(*         when st_19 == ((granule_unlock_spec (int_to_ptr v_15_tmp) st_18)); *)
(*         when st_21 == ((free_stack "smc_rtt_fold" st_0 st_19)); *)
(*         (Some (v_call13, st_21)))) *)
(*     else ( *)
(*       when st_7 == ((buffer_unmap_spec v_call1_0 st_6)); *)
(*       when st_8 == ((granule_unlock_spec v_call st_7)); *)
(*       when st_10 == ((free_stack "smc_rtt_fold" st_0 st_8)); *)
(*       (Some (1, st_10)))). *)

Definition smc_rtt_fold_1 (v_call1_0: Ptr) (v_s2_ctx: Ptr) (v_call: Ptr) (v_map_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (st_6: RData) : (option (Z * RData)) :=
  rely (((v_call1_0.(pbase)) = ("slot_rd")));
  rely (((v_call1_0.(poffset)) = (0)));
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_fold_stack")));
  rely (((v_call.(pbase)) = ("granules")));
  rely (((v_wi.(pbase)) = ("smc_rtt_fold_stack")));
  when cid == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(e_lock)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (
    (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
      (((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
  rely (
    ((((((st_6.(share)).(granules)) @
      ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) -
      (6)) =
      (0)));
  rely (
    (("granules" = ("granules")) /\
      ((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) =
        (0)))));
  when sh == (((st_6.(repl)) ((st_6.(oracle)) (st_6.(log))) ((st_6.(share)).[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1)))));
  match (((((st_6.(share)).(granules)) @ ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))) with
  | None =>
    when st_15 == (
        (rtt_walk_lock_unlock_spec
          (mkPtr "granules" (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
          ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
          ((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
          v_map_addr
          (v_ulevel + ((- 1)))
          v_wi
          ((lens 13418 st_6).[share].[slots] :< (((st_6.(share)).(slots)) # SLOT_RD == (- 1)))));
    (Some ((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((v_wi.(poffset)) + (16))), st_15))
  | (Some cid_0) => None
  end.

Definition smc_rtt_fold_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, (lens 14690 st)))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == ((((lens 14635 st).(repl)) (((lens 14635 st).(oracle)) ((lens 14635 st).(log))) ((lens 14635 st).(share))));
      if ((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0))
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == ((((((lens 14640 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
        if (
          ((v_ulevel >? (3)) ||
            ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_ulevel)) >? (0)))))
        then (Some (1, ((lens 14855 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
        else (
          rely (((Some cid) = ((Some CPU_ID))));
          if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
          then (
            if (
              ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                (v_map_addr)) =?
                (0)))
            then (
              rely (
                (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                  (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              rely (
                ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) -
                  (6)) =
                  (0)));
              rely (
                (("granules" = ("granules")) /\
                  ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
              when sh_0 == (
                  (((lens 14640 st).(repl))
                    (((lens 14640 st).(oracle)) ((lens 14640 st).(log)))
                    (((lens 14640 st).(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              when st_15 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                    v_map_addr
                    (v_ulevel + ((- 1)))
                    (mkPtr "smc_rtt_fold_stack" (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)))
                    ((lens 14885 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              if (((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (16))) - ((v_ulevel + ((- 1))))) =? (0))
              then (
                rely (
                  ((((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                    ((((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                rely (((((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (
                  (((v_ulevel + ((- 1))) <? (3)) &&
                    ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8)))))) &
                      (3)) =?
                      (3)))))
                then (
                  if (
                    (((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8)))))) &
                      (281474976710655)) &
                      (((- 1) << ((66 & (4294967295)))))) -
                      (v_rtt_addr)) =?
                      (0)))
                  then (
                    rely ((((v_rtt_addr & (4095)) =? (0)) = (true)));
                    rely ((((v_rtt_addr / (GRANULE_SIZE)) >? (1048575)) = (false)));
                    rely ((((0 - ((v_rtt_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rtt_addr / (GRANULE_SIZE)) < (1048576)))));
                    when sh_1 == (
                        ((st_15.(repl))
                          ((st_15.(oracle)) (st_15.(log)))
                          ((st_15.(share)).[slots] :<
                            (((st_15.(share)).(slots)) #
                              SLOT_RTT ==
                              (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))))));
                    match (((((st_15.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
                    | None =>
                      rely ((((((((st_15.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_state)) - (6)) =? (0)) = (true)));
                      if (
                        if ((((((st_15.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                        then true
                        else (
                          match ((((((lens 14886 st_15).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                          | (Some cid_1) => true
                          | None => false
                          end))
                      then (
                        if ((((((lens 14886 st_15).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) =? (0))
                        then (
                          if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (3)) =? (0))
                          then (
                            if ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (60)) - (8)) =? (0))
                            then (
                              match (
                                (__table_is_uniform_block_loop777
                                  (z_to_nat 511)
                                  false
                                  true
                                  1
                                  false
                                  0
                                  (mkPtr "null" 0)
                                  (mkPtr "slot_rtt2" 0)
                                  (mkPtr "s2tte_is_destroyed" 0)
                                  ((lens 14886 st_15).[share].[slots] :<
                                    ((((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                      SLOT_RTT2 ==
                                      (v_rtt_addr / (GRANULE_SIZE)))))
                              ) with
                              | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_3)) =>
                                if v_retval_1
                                then (
                                  rely (
                                    ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                      ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                  rely (
                                    (("granules" = ("granules")) /\
                                      ((((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                  if (
                                    if (
                                      ((((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                        (GRANULE_STATE_RD)) =?
                                        (0)))
                                    then true
                                    else (
                                      match (((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                      | (Some cid_2) => true
                                      | None => false
                                      end))
                                  then (
                                    when cid_2 == (((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                    if (
                                      ((((((st_3.(share)).(granules)) @ ((((((st_3.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                        ((- 1))) <?
                                        (0)))
                                    then None
                                    else (
                                      if ((8 & (36028797018963968)) =? (0))
                                      then (
                                        if (((v_ulevel + ((- 1))) =? (2)) && (((8 & (3)) =? (1))))
                                        then (
                                          if (
                                            match ((((((lens 113 st_3).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                            | (Some cid_3) => true
                                            | None => false
                                            end)
                                          then (
                                            rely (
                                              (((((((lens 13943 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13945 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              0  ,
                                              (((lens 13947 st_3).[share].[granule_data] :<
                                                ((((st_3.(share)).(granule_data)) #
                                                  (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                  ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                    (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                      (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                      8))) #
                                                  (((st_3.(share)).(slots)) @ SLOT_RTT2) ==
                                                  (((((st_3.(share)).(granule_data)) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                        (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                        8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                    zero_granule_data_normal))).[share].[slots] :<
                                                ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            )))
                                          else None)
                                        else (
                                          if (
                                            match ((((((lens 113 st_3).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                            | (Some cid_3) => true
                                            | None => false
                                            end)
                                          then (
                                            rely (
                                              (((((((lens 13949 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13951 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              0  ,
                                              (((lens 13953 st_3).[share].[granule_data] :<
                                                ((((st_3.(share)).(granule_data)) #
                                                  (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                  ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                    (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                      (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                      8))) #
                                                  (((st_3.(share)).(slots)) @ SLOT_RTT2) ==
                                                  (((((st_3.(share)).(granule_data)) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                        (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                        8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                    zero_granule_data_normal))).[share].[slots] :<
                                                ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            )))
                                          else None))
                                      else (
                                        if (((8 & (36028797018963968)) - (36028797018963968)) =? (0))
                                        then (
                                          if (((v_ulevel + ((- 1))) =? (2)) && (((8 & (3)) =? (1))))
                                          then (
                                            if (
                                              match ((((((lens 113 st_3).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                              | (Some cid_3) => true
                                              | None => false
                                              end)
                                            then (
                                              rely (
                                                (((((((lens 13961 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  (((((((lens 13963 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              (Some (
                                                0  ,
                                                (((lens 13965 st_3).[share].[granule_data] :<
                                                  ((((st_3.(share)).(granule_data)) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                        (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                        8))) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT2) ==
                                                    (((((st_3.(share)).(granule_data)) #
                                                      (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                      ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                        (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                          (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                          8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                      zero_granule_data_normal))).[share].[slots] :<
                                                  ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                              )))
                                            else None)
                                          else (
                                            if (
                                              match ((((((lens 113 st_3).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                              | (Some cid_3) => true
                                              | None => false
                                              end)
                                            then (
                                              rely (
                                                (((((((lens 13967 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  (((((((lens 13969 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              (Some (
                                                0  ,
                                                (((lens 13971 st_3).[share].[granule_data] :<
                                                  ((((st_3.(share)).(granule_data)) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                        (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                        8))) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT2) ==
                                                    (((((st_3.(share)).(granule_data)) #
                                                      (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                      ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                        (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                          (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                          8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                      zero_granule_data_normal))).[share].[slots] :<
                                                  ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                              )))
                                            else None))
                                        else (
                                          if (
                                            match ((((((lens 113 st_3).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                            | (Some cid_3) => true
                                            | None => false
                                            end)
                                          then (
                                            rely (
                                              (((((((lens 13973 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13975 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              0  ,
                                              (((lens 13977 st_3).[share].[granule_data] :<
                                                ((((st_3.(share)).(granule_data)) #
                                                  (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                  ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                    (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                      (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                      8))) #
                                                  (((st_3.(share)).(slots)) @ SLOT_RTT2) ==
                                                  (((((st_3.(share)).(granule_data)) #
                                                    (((st_3.(share)).(slots)) @ SLOT_RTT) ==
                                                    ((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                      (((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                        (8 * (((((lens 113 st_3).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                        8))) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                    zero_granule_data_normal))).[share].[slots] :<
                                                ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            )))
                                          else None))))
                                  else None)
                                else (
                                  when cid_2 == (((((st_3.(share)).(granules)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
                                  if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (3)) =? (0))
                                  then (
                                    if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (60)) =? (0))
                                    then (
                                      if (((((((st_3.(share)).(granule_data)) @ (((st_3.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (64)) =? (0))
                                      then (
                                        match (
                                          (__table_is_uniform_block_loop777
                                            (z_to_nat 511)
                                            false
                                            false
                                            1
                                            false
                                            0
                                            (mkPtr "smc_rtt_fold_stack" (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp)))
                                            (mkPtr "slot_rtt2" 0)
                                            (mkPtr "s2tte_is_unassigned" 0)
                                            st_3)
                                        ) with
                                        | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_1, v_s2tte_is_x_1, st_5)) =>
                                          if v_retval_2
                                          then (
                                            if ((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp))) =? (0))
                                            then (
                                              rely (
                                                ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              rely (
                                                (("granules" = ("granules")) /\
                                                  ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                              if (
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                                    (GRANULE_STATE_RD)) =?
                                                    (0)))
                                                then true
                                                else (
                                                  match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end))
                                              then (
                                                when cid_3 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                                    ((- 1))) <?
                                                    (0)))
                                                then None
                                                else (
                                                  if ((0 & (36028797018963968)) =? (0))
                                                  then (
                                                    if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                                    then (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 13985 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 13987 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 13989 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  0))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None)
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 13991 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 13993 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 13995 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  0))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))
                                                  else (
                                                    if (((0 & (36028797018963968)) - (36028797018963968)) =? (0))
                                                    then (
                                                      if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                                      then (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14003 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14005 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14007 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None)
                                                      else (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14009 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14011 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14013 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None))
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14015 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14017 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14019 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  0))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))))
                                              else None)
                                            else (
                                              rely (
                                                ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              rely (
                                                (("granules" = ("granules")) /\
                                                  ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                              if (
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                                    (GRANULE_STATE_RD)) =?
                                                    (0)))
                                                then true
                                                else (
                                                  match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end))
                                              then (
                                                when cid_3 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                                    ((- 1))) <?
                                                    (0)))
                                                then None
                                                else (
                                                  if ((64 & (36028797018963968)) =? (0))
                                                  then (
                                                    if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                                    then (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14027 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14029 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14031 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  64))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None)
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14033 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14035 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14037 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  64))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))
                                                  else (
                                                    if (((64 & (36028797018963968)) - (36028797018963968)) =? (0))
                                                    then (
                                                      if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                                      then (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14045 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14047 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14049 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None)
                                                      else (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14051 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14053 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14055 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None))
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14057 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14059 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14061 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  64))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))))
                                              else None))
                                          else (
                                            when cid_3 == (((((st_5.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                            rely (
                                              (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (5, ((lens 13935 st_5).[share].[slots] :< ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))))
                                        | None => None
                                        end)
                                      else (
                                        match (
                                          (__table_is_uniform_block_loop777
                                            (z_to_nat 511)
                                            false
                                            false
                                            1
                                            false
                                            1
                                            (mkPtr "smc_rtt_fold_stack" (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp)))
                                            (mkPtr "slot_rtt2" 0)
                                            (mkPtr "s2tte_is_unassigned" 0)
                                            st_3)
                                        ) with
                                        | (Some (__break___0, v_cmp_not_1, v_indvars_iv_1, v_retval_2, v_ripas_2, v_ripas_ptr_1, v_table_1, v_s2tte_is_x_1, st_5)) =>
                                          if v_retval_2
                                          then (
                                            if ((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp))) =? (0))
                                            then (
                                              rely (
                                                ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              rely (
                                                (("granules" = ("granules")) /\
                                                  ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                              if (
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                                    (GRANULE_STATE_RD)) =?
                                                    (0)))
                                                then true
                                                else (
                                                  match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end))
                                              then (
                                                when cid_3 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                                    ((- 1))) <?
                                                    (0)))
                                                then None
                                                else (
                                                  if ((0 & (36028797018963968)) =? (0))
                                                  then (
                                                    if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                                    then (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14069 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14071 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14073 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  0))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None)
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14075 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14077 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14079 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  0))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))
                                                  else (
                                                    if (((0 & (36028797018963968)) - (36028797018963968)) =? (0))
                                                    then (
                                                      if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                                      then (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14087 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14089 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14091 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None)
                                                      else (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14093 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14095 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14097 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None))
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14099 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14101 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14103 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  0))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    0))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))))
                                              else None)
                                            else (
                                              rely (
                                                ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              rely (
                                                (("granules" = ("granules")) /\
                                                  ((((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                              if (
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                                    (GRANULE_STATE_RD)) =?
                                                    (0)))
                                                then true
                                                else (
                                                  match (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end))
                                              then (
                                                when cid_3 == (((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                                if (
                                                  ((((((st_5.(share)).(granules)) @ ((((((st_5.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                                    ((- 1))) <?
                                                    (0)))
                                                then None
                                                else (
                                                  if ((64 & (36028797018963968)) =? (0))
                                                  then (
                                                    if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                                    then (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14111 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14113 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14115 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  64))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None)
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14117 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14119 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14121 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  64))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))
                                                  else (
                                                    if (((64 & (36028797018963968)) - (36028797018963968)) =? (0))
                                                    then (
                                                      if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                                      then (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14129 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14131 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14133 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None)
                                                      else (
                                                        if (
                                                          match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                          | (Some cid_4) => true
                                                          | None => false
                                                          end)
                                                        then (
                                                          rely (
                                                            (((((((lens 14135 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                              (((((((lens 14137 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                          (Some (
                                                            0  ,
                                                            (((lens 14139 st_5).[share].[granule_data] :<
                                                              ((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                                (((((st_5.(share)).(granule_data)) #
                                                                  (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                  zero_granule_data_normal))).[share].[slots] :<
                                                              ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                          )))
                                                        else None))
                                                    else (
                                                      if (
                                                        match ((((((lens 113 st_5).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_4) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14141 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14143 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14145 st_5).[share].[granule_data] :<
                                                            ((((st_5.(share)).(granule_data)) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  64))) #
                                                              (((st_5.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_5.(share)).(granule_data)) #
                                                                (((st_5.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_5.(share)).(granule_data)) @ (((st_5.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 113 st_5).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    64))) @ (((st_5.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))))
                                              else None))
                                          else (
                                            rely ((0 = (0)));
                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                            when cid_3 == (((((st_5.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                            rely ((0 = (0)));
                                            rely (
                                              (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13817 st_5).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (5, ((lens 13935 st_5).[share].[slots] :< ((((st_5.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))))
                                        | None => None
                                        end))
                                    else (
                                      when cid_3 == (((((st_3.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                      rely (
                                        (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (5, ((lens 13935 st_3).[share].[slots] :< ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))))
                                  else (
                                    rely ((0 = (0)));
                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                    when cid_3 == (((((st_3.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                    rely ((0 = (0)));
                                    rely (
                                      (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 13817 st_3).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (5, ((lens 13935 st_3).[share].[slots] :< ((((st_3.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))))))
                              | None => None
                              end)
                            else (
                              if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (60)) =? (0))
                              then (
                                if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (64)) =? (0))
                                then (
                                  match (
                                    (__table_is_uniform_block_loop777
                                      (z_to_nat 511)
                                      false
                                      false
                                      1
                                      false
                                      0
                                      (mkPtr "smc_rtt_fold_stack" (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp)))
                                      (mkPtr "slot_rtt2" 0)
                                      (mkPtr "s2tte_is_unassigned" 0)
                                      ((lens 14886 st_15).[share].[slots] :<
                                        ((((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT2 ==
                                          (v_rtt_addr / (GRANULE_SIZE)))))
                                  ) with
                                  | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) =>
                                    if v_retval_1
                                    then (
                                      if ((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp))) =? (0))
                                      then (
                                        rely (
                                          ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        rely (
                                          (("granules" = ("granules")) /\
                                            ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                        if (
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                              (GRANULE_STATE_RD)) =?
                                              (0)))
                                          then true
                                          else (
                                            match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                            | (Some cid_2) => true
                                            | None => false
                                            end))
                                        then (
                                          when cid_2 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                              ((- 1))) <?
                                              (0)))
                                          then None
                                          else (
                                            if ((0 & (36028797018963968)) =? (0))
                                            then (
                                              if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                              then (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14153 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14155 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14157 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            0))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None)
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14159 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14161 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14163 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            0))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))
                                            else (
                                              if (((0 & (36028797018963968)) - (36028797018963968)) =? (0))
                                              then (
                                                if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                                then (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14171 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14173 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14175 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None)
                                                else (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14177 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14179 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14181 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14183 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14185 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14187 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            0))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))))
                                        else None)
                                      else (
                                        rely (
                                          ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        rely (
                                          (("granules" = ("granules")) /\
                                            ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                        if (
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                              (GRANULE_STATE_RD)) =?
                                              (0)))
                                          then true
                                          else (
                                            match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                            | (Some cid_2) => true
                                            | None => false
                                            end))
                                        then (
                                          when cid_2 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                              ((- 1))) <?
                                              (0)))
                                          then None
                                          else (
                                            if ((64 & (36028797018963968)) =? (0))
                                            then (
                                              if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                              then (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14195 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14197 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14199 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            64))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None)
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14201 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14203 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14205 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            64))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))
                                            else (
                                              if (((64 & (36028797018963968)) - (36028797018963968)) =? (0))
                                              then (
                                                if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                                then (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14213 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14215 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14217 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None)
                                                else (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14219 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14221 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14223 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14225 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14227 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14229 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            64))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))))
                                        else None))
                                    else (
                                      when cid_2 == (((((st_4.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                      rely (
                                        (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (5, ((lens 13935 st_4).[share].[slots] :< ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))))
                                  | None => None
                                  end)
                                else (
                                  match (
                                    (__table_is_uniform_block_loop777
                                      (z_to_nat 511)
                                      false
                                      false
                                      1
                                      false
                                      1
                                      (mkPtr "smc_rtt_fold_stack" (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp)))
                                      (mkPtr "slot_rtt2" 0)
                                      (mkPtr "s2tte_is_unassigned" 0)
                                      ((lens 14886 st_15).[share].[slots] :<
                                        ((((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT2 ==
                                          (v_rtt_addr / (GRANULE_SIZE)))))
                                  ) with
                                  | (Some (__break__, v_cmp_not_0, v_indvars_iv_0, v_retval_1, v_ripas_1, v_ripas_ptr_0, v_table_0, v_s2tte_is_x_0, st_4)) =>
                                    if v_retval_1
                                    then (
                                      if ((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14595 st).(func_sp)).(smc_rtt_fold_sp))) =? (0))
                                      then (
                                        rely (
                                          ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        rely (
                                          (("granules" = ("granules")) /\
                                            ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                        if (
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                              (GRANULE_STATE_RD)) =?
                                              (0)))
                                          then true
                                          else (
                                            match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                            | (Some cid_2) => true
                                            | None => false
                                            end))
                                        then (
                                          when cid_2 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                              ((- 1))) <?
                                              (0)))
                                          then None
                                          else (
                                            if ((0 & (36028797018963968)) =? (0))
                                            then (
                                              if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                              then (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14237 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14239 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14241 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            0))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None)
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14243 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14245 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14247 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            0))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))
                                            else (
                                              if (((0 & (36028797018963968)) - (36028797018963968)) =? (0))
                                              then (
                                                if (((v_ulevel + ((- 1))) =? (2)) && (((0 & (3)) =? (1))))
                                                then (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14255 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14257 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14259 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None)
                                                else (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14261 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14263 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14265 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14267 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14269 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14271 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            0))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              0))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))))
                                        else None)
                                      else (
                                        rely (
                                          ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        rely (
                                          (("granules" = ("granules")) /\
                                            ((((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                                        if (
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
                                              (GRANULE_STATE_RD)) =?
                                              (0)))
                                          then true
                                          else (
                                            match (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                            | (Some cid_2) => true
                                            | None => false
                                            end))
                                        then (
                                          when cid_2 == (((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
                                          if (
                                            ((((((st_4.(share)).(granules)) @ ((((((st_4.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
                                              ((- 1))) <?
                                              (0)))
                                          then None
                                          else (
                                            if ((64 & (36028797018963968)) =? (0))
                                            then (
                                              if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                              then (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14279 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14281 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14283 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            64))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None)
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14285 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14287 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14289 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            64))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))
                                            else (
                                              if (((64 & (36028797018963968)) - (36028797018963968)) =? (0))
                                              then (
                                                if (((v_ulevel + ((- 1))) =? (2)) && (((64 & (3)) =? (1))))
                                                then (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14297 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14299 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14301 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None)
                                                else (
                                                  if (
                                                    match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14303 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14305 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14307 st_4).[share].[granule_data] :<
                                                        ((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_4.(share)).(granule_data)) #
                                                            (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))
                                              else (
                                                if (
                                                  match ((((((lens 113 st_4).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_3) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14309 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14311 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14313 st_4).[share].[granule_data] :<
                                                      ((((st_4.(share)).(granule_data)) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            64))) #
                                                        (((st_4.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_4.(share)).(granule_data)) #
                                                          (((st_4.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_4.(share)).(granule_data)) @ (((st_4.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 113 st_4).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              64))) @ (((st_4.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))))
                                        else None))
                                    else (
                                      rely ((0 = (0)));
                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                      when cid_2 == (((((st_4.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                      rely ((0 = (0)));
                                      rely (
                                        (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 13817 st_4).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (5, ((lens 13935 st_4).[share].[slots] :< ((((st_4.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1))))))
                                  | None => None
                                  end))
                              else (
                                rely (
                                  (((((((lens 14889 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                    (((((((lens 14891 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                (Some (
                                  5  ,
                                  ((lens 14893 st_15).[share].[slots] :<
                                    ((((((st_15.(share)).(slots)) #
                                      SLOT_RTT ==
                                      (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                      SLOT_RTT2 ==
                                      (v_rtt_addr / (GRANULE_SIZE))) #
                                      SLOT_RTT2 ==
                                      (- 1)) #
                                      SLOT_RTT ==
                                      (- 1)))
                                )))))
                          else (
                            rely (
                              (((((((lens 14895 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                (((((((lens 14897 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                            (Some (
                              5  ,
                              ((lens 14899 st_15).[share].[slots] :<
                                ((((((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_RTT2 ==
                                  (v_rtt_addr / (GRANULE_SIZE))) #
                                  SLOT_RTT2 ==
                                  (- 1)) #
                                  SLOT_RTT ==
                                  (- 1)))
                            ))))
                        else (
                          if ((((((lens 14886 st_15).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) =? (512))
                          then (
                            if (v_ulevel <? (3))
                            then (
                              rely (
                                (((((((lens 14901 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                  (((((((lens 14901 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                              (Some (
                                5  ,
                                ((lens 15019 st_15).[share].[slots] :<
                                  ((((((st_15.(share)).(slots)) #
                                    SLOT_RTT ==
                                    (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                    SLOT_RTT2 ==
                                    (v_rtt_addr / (GRANULE_SIZE))) #
                                    SLOT_RTT2 ==
                                    (- 1)) #
                                    SLOT_RTT ==
                                    (- 1)))
                              )))
                            else (
                              if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (3)) =? (0))
                              then (
                                if ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (60)) - (4)) =? (0))
                                then (
                                  if (
                                    (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                      (281474976710655)) &
                                      (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                      ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                      (0)))
                                  then (
                                    match (
                                      (__table_maps_block_loop840
                                        (z_to_nat 511)
                                        false
                                        (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                        (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                        1
                                        v_ulevel
                                        false
                                        (mkPtr "slot_rtt2" 0)
                                        (mkPtr "s2tte_is_assigned" 0)
                                        ((lens 14886 st_15).[share].[slots] :<
                                          ((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                            SLOT_RTT2 ==
                                            (v_rtt_addr / (GRANULE_SIZE)))))
                                    ) with
                                    | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) =>
                                      if v_retval_2
                                      then (
                                        if (
                                          if ((((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                          then true
                                          else (
                                            match (((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                                            | (Some cid_1) => true
                                            | None => false
                                            end))
                                        then (
                                          when cid_1 == (((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                          if ((((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                          then None
                                          else (
                                            if (
                                              ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                (4)) &
                                                (36028797018963968)) =?
                                                (0)))
                                            then (
                                              if (
                                                (((v_ulevel + ((- 1))) =? (2)) &&
                                                  (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                    (4)) &
                                                    (3)) =?
                                                    (1)))))
                                              then (
                                                if (
                                                  match ((((((lens 56 st_6).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                  | (Some cid_2) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14321 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14323 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14325 st_6).[share].[granule_data] :<
                                                      ((((st_6.(share)).(granule_data)) #
                                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                              (4))))) #
                                                        (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (4))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None)
                                              else (
                                                if (
                                                  match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_2) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14327 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14329 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14331 st_6).[share].[granule_data] :<
                                                      ((((st_6.(share)).(granule_data)) #
                                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                              (4))))) #
                                                        (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (4))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))
                                            else (
                                              if (
                                                (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                  (4)) &
                                                  (36028797018963968)) -
                                                  (36028797018963968)) =?
                                                  (0)))
                                              then (
                                                if (
                                                  (((v_ulevel + ((- 1))) =? (2)) &&
                                                    (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                      (4)) &
                                                      (3)) =?
                                                      (1)))))
                                                then (
                                                  if (
                                                    match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_2) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14339 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14341 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14343 st_6).[share].[granule_data] :<
                                                        ((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (4))))) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (4))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None)
                                                else (
                                                  if (
                                                    match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_2) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14345 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14347 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14349 st_6).[share].[granule_data] :<
                                                        ((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (4))))) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (4))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))
                                              else (
                                                if (
                                                  match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                  | (Some cid_2) => true
                                                  | None => false
                                                  end)
                                                then (
                                                  rely (
                                                    (((((((lens 14351 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                      (((((((lens 14353 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                  (Some (
                                                    0  ,
                                                    (((lens 14355 st_6).[share].[granule_data] :<
                                                      ((((st_6.(share)).(granule_data)) #
                                                        (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                        ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                          (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                            (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                              (4))))) #
                                                        (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                        (((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (4))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                          zero_granule_data_normal))).[share].[slots] :<
                                                      ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                  )))
                                                else None))))
                                        else None)
                                      else (
                                        when cid_1 == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
                                        if (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (36028797018963968)) =? (0))
                                        then (
                                          if (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (3)) =? (3))
                                          then (
                                            if (
                                              (((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                                (281474976710655)) &
                                                (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                                ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                                (0)))
                                            then (
                                              match (
                                                (__table_maps_block_loop840
                                                  (z_to_nat 511)
                                                  false
                                                  (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                                  (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                                  1
                                                  v_ulevel
                                                  false
                                                  (mkPtr "slot_rtt2" 0)
                                                  (mkPtr "s2tte_is_valid" 0)
                                                  st_6)
                                              ) with
                                              | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_1, v_retval_3, v_table_1, v_s2tte_is_x_1, st_7)) =>
                                                if v_retval_3
                                                then (
                                                  if (
                                                    if ((((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                                    then true
                                                    else (
                                                      match (((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                                                      | (Some cid_2) => true
                                                      | None => false
                                                      end))
                                                  then (
                                                    when cid_2 == (((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                                    if ((((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                                    then None
                                                    else (
                                                      if (
                                                        ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                          (2009)) &
                                                          (36028797018963968)) =?
                                                          (0)))
                                                      then (
                                                        if (
                                                          (((v_ulevel + ((- 1))) =? (2)) &&
                                                            (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                              (2009)) &
                                                              (3)) =?
                                                              (1)))))
                                                        then (
                                                          if (
                                                            match ((((((lens 56 st_7).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                            | (Some cid_3) => true
                                                            | None => false
                                                            end)
                                                          then (
                                                            rely (
                                                              (((((((lens 14357 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                (((((((lens 14359 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                            (Some (
                                                              0  ,
                                                              (((lens 14361 st_7).[share].[granule_data] :<
                                                                ((((st_7.(share)).(granule_data)) #
                                                                  (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                        (2009))))) #
                                                                  (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                  (((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (2009))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                    zero_granule_data_normal))).[share].[slots] :<
                                                                ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                            )))
                                                          else None)
                                                        else (
                                                          if (
                                                            match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                            | (Some cid_3) => true
                                                            | None => false
                                                            end)
                                                          then (
                                                            rely (
                                                              (((((((lens 14363 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                (((((((lens 14365 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                            (Some (
                                                              0  ,
                                                              (((lens 14367 st_7).[share].[granule_data] :<
                                                                ((((st_7.(share)).(granule_data)) #
                                                                  (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                        (2009))))) #
                                                                  (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                  (((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (2009))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                    zero_granule_data_normal))).[share].[slots] :<
                                                                ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                            )))
                                                          else None))
                                                      else (
                                                        if (
                                                          (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                            (2009)) &
                                                            (36028797018963968)) -
                                                            (36028797018963968)) =?
                                                            (0)))
                                                        then (
                                                          if (
                                                            (((v_ulevel + ((- 1))) =? (2)) &&
                                                              (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (2009)) &
                                                                (3)) =?
                                                                (1)))))
                                                          then (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_3) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14369 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14371 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14373 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (2009))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (2009))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None)
                                                          else (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_3) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14375 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14377 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14379 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (2009))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (2009))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None))
                                                        else (
                                                          if (
                                                            match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                            | (Some cid_3) => true
                                                            | None => false
                                                            end)
                                                          then (
                                                            rely (
                                                              (((((((lens 14381 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                (((((((lens 14383 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                            (Some (
                                                              0  ,
                                                              (((lens 14385 st_7).[share].[granule_data] :<
                                                                ((((st_7.(share)).(granule_data)) #
                                                                  (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                  ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                    (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                      (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                      ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                        (2009))))) #
                                                                  (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                  (((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (2009))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                    zero_granule_data_normal))).[share].[slots] :<
                                                                ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                            )))
                                                          else None))))
                                                  else None)
                                                else (
                                                  when cid_2 == (((((st_7.(share)).(granules)) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
                                                  if ((((((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (36028797018963968)) - (36028797018963968)) =? (0))
                                                  then (
                                                    if (((((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (3)) =? (3))
                                                    then (
                                                      if (
                                                        (((((((((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                                          (281474976710655)) &
                                                          (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                                          ((((((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                                          (0)))
                                                      then (
                                                        match (
                                                          (__table_maps_block_loop840
                                                            (z_to_nat 511)
                                                            false
                                                            (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                                            (((((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                                            1
                                                            v_ulevel
                                                            false
                                                            (mkPtr "slot_rtt2" 0)
                                                            (mkPtr "s2tte_is_valid_ns" 0)
                                                            st_7)
                                                        ) with
                                                        | (Some (break___1, v_call_2, v_call3_2, v_i_18, v_level_2, v_retval_4, v_table_2, v_s2tte_is_x_2, st_8)) =>
                                                          if v_retval_4
                                                          then (
                                                            if (
                                                              if ((((((st_8.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                                              then true
                                                              else (
                                                                match (((((st_8.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                                                                | (Some cid_3) => true
                                                                | None => false
                                                                end))
                                                            then (
                                                              when cid_3 == (((((st_8.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                                              if ((((((st_8.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                                              then None
                                                              else (
                                                                if (
                                                                  ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (54043195528446977)) &
                                                                    (36028797018963968)) =?
                                                                    (0)))
                                                                then (
                                                                  if (
                                                                    (((v_ulevel + ((- 1))) =? (2)) &&
                                                                      (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                        (54043195528446977)) &
                                                                        (3)) =?
                                                                        (1)))))
                                                                  then (
                                                                    if (
                                                                      match ((((((lens 56 st_8).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                                      | (Some cid_4) => true
                                                                      | None => false
                                                                      end)
                                                                    then (
                                                                      rely (
                                                                        (((((((lens 14387 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                          (((((((lens 14389 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                      (Some (
                                                                        0  ,
                                                                        (((lens 14391 st_8).[share].[granule_data] :<
                                                                          ((((st_8.(share)).(granule_data)) #
                                                                            (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                            ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                              (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                  (54043195528446977))))) #
                                                                            (((st_8.(share)).(slots)) @ SLOT_RTT2) ==
                                                                            (((((st_8.(share)).(granule_data)) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                              ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                  (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                    (54043195528446977))))) @ (((st_8.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                              zero_granule_data_normal))).[share].[slots] :<
                                                                          ((((st_8.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                      )))
                                                                    else None)
                                                                  else (
                                                                    if (
                                                                      match ((((((lens 56 st_8).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                      | (Some cid_4) => true
                                                                      | None => false
                                                                      end)
                                                                    then (
                                                                      rely (
                                                                        (((((((lens 14393 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                          (((((((lens 14395 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                      (Some (
                                                                        0  ,
                                                                        (((lens 14397 st_8).[share].[granule_data] :<
                                                                          ((((st_8.(share)).(granule_data)) #
                                                                            (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                            ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                              (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                  (54043195528446977))))) #
                                                                            (((st_8.(share)).(slots)) @ SLOT_RTT2) ==
                                                                            (((((st_8.(share)).(granule_data)) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                              ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                  (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                    (54043195528446977))))) @ (((st_8.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                              zero_granule_data_normal))).[share].[slots] :<
                                                                          ((((st_8.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                      )))
                                                                    else None))
                                                                else (
                                                                  if (
                                                                    (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                      (54043195528446977)) &
                                                                      (36028797018963968)) -
                                                                      (36028797018963968)) =?
                                                                      (0)))
                                                                  then (
                                                                    if (
                                                                      (((v_ulevel + ((- 1))) =? (2)) &&
                                                                        (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977)) &
                                                                          (3)) =?
                                                                          (1)))))
                                                                    then (
                                                                      if (
                                                                        match ((((((lens 56 st_8).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                        | (Some cid_4) => true
                                                                        | None => false
                                                                        end)
                                                                      then (
                                                                        rely (
                                                                          (((((((lens 14399 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                            (((((((lens 14401 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                        (Some (
                                                                          0  ,
                                                                          (((lens 14403 st_8).[share].[granule_data] :<
                                                                            ((((st_8.(share)).(granule_data)) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                              ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                  (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                    (54043195528446977))))) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT2) ==
                                                                              (((((st_8.(share)).(granule_data)) #
                                                                                (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                                ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                  (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                    (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                    ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                      (54043195528446977))))) @ (((st_8.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                                zero_granule_data_normal))).[share].[slots] :<
                                                                            ((((st_8.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                        )))
                                                                      else None)
                                                                    else (
                                                                      if (
                                                                        match ((((((lens 56 st_8).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                        | (Some cid_4) => true
                                                                        | None => false
                                                                        end)
                                                                      then (
                                                                        rely (
                                                                          (((((((lens 14405 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                            (((((((lens 14407 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                        (Some (
                                                                          0  ,
                                                                          (((lens 14409 st_8).[share].[granule_data] :<
                                                                            ((((st_8.(share)).(granule_data)) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                              ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                  (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                    (54043195528446977))))) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT2) ==
                                                                              (((((st_8.(share)).(granule_data)) #
                                                                                (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                                ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                  (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                    (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                    ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                      (54043195528446977))))) @ (((st_8.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                                zero_granule_data_normal))).[share].[slots] :<
                                                                            ((((st_8.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                        )))
                                                                      else None))
                                                                  else (
                                                                    if (
                                                                      match ((((((lens 56 st_8).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                      | (Some cid_4) => true
                                                                      | None => false
                                                                      end)
                                                                    then (
                                                                      rely (
                                                                        (((((((lens 14411 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                          (((((((lens 14413 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                      (Some (
                                                                        0  ,
                                                                        (((lens 14415 st_8).[share].[granule_data] :<
                                                                          ((((st_8.(share)).(granule_data)) #
                                                                            (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                            ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                              (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                  (54043195528446977))))) #
                                                                            (((st_8.(share)).(slots)) @ SLOT_RTT2) ==
                                                                            (((((st_8.(share)).(granule_data)) #
                                                                              (((st_8.(share)).(slots)) @ SLOT_RTT) ==
                                                                              ((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                                (((((st_8.(share)).(granule_data)) @ (((st_8.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                                  (8 * (((((lens 56 st_8).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                                    (54043195528446977))))) @ (((st_8.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                              zero_granule_data_normal))).[share].[slots] :<
                                                                          ((((st_8.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                      )))
                                                                    else None))))
                                                            else None)
                                                          else (
                                                            when cid_3 == (((((st_8.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                                            rely (
                                                              (((((((lens 13817 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                (((((((lens 13817 st_8).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                            (Some (
                                                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                              ((lens 13935 st_8).[share].[slots] :< ((((st_8.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                            )))
                                                        | None => None
                                                        end)
                                                      else (
                                                        when cid_3 == (((((st_7.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                                        rely (
                                                          (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                          ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        ))))
                                                    else (
                                                      rely ((0 = (0)));
                                                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                      when cid_3 == (((((st_7.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                                      rely ((0 = (0)));
                                                      rely (
                                                        (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                          (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                      (Some (
                                                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                        ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                      ))))
                                                  else (
                                                    rely ((0 = (0)));
                                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                    when cid_3 == (((((st_7.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                                    rely ((0 = (0)));
                                                    rely (
                                                      (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                      ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    ))))
                                              | None => None
                                              end)
                                            else (
                                              when cid_2 == (((((st_6.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                              rely (
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              (Some (
                                                (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                              ))))
                                          else (
                                            rely ((0 = (0)));
                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                            when cid_2 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                            rely ((0 = (0)));
                                            rely (
                                              (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                              ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            ))))
                                        else (
                                          if ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (36028797018963968)) - (36028797018963968)) =? (0))
                                          then (
                                            if (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (3)) =? (3))
                                            then (
                                              if (
                                                (((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                                  (281474976710655)) &
                                                  (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                                  ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                                  (0)))
                                              then (
                                                match (
                                                  (__table_maps_block_loop840
                                                    (z_to_nat 511)
                                                    false
                                                    (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                                    (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                                    1
                                                    v_ulevel
                                                    false
                                                    (mkPtr "slot_rtt2" 0)
                                                    (mkPtr "s2tte_is_valid_ns" 0)
                                                    st_6)
                                                ) with
                                                | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_1, v_retval_3, v_table_1, v_s2tte_is_x_1, st_7)) =>
                                                  if v_retval_3
                                                  then (
                                                    if (
                                                      if ((((((st_7.(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                                      then true
                                                      else (
                                                        match (((((st_7.(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_2) => true
                                                        | None => false
                                                        end))
                                                    then (
                                                      when cid_2 == (((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                                      if ((((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                                      then None
                                                      else (
                                                        if (
                                                          ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                            (54043195528446977)) &
                                                            (36028797018963968)) =?
                                                            (0)))
                                                        then (
                                                          if (
                                                            (((v_ulevel + ((- 1))) =? (2)) &&
                                                              (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (54043195528446977)) &
                                                                (3)) =?
                                                                (1)))))
                                                          then (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_3) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14453 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14455 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14457 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None)
                                                          else (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_3) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14459 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14461 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14463 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None))
                                                        else (
                                                          if (
                                                            (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                              (54043195528446977)) &
                                                              (36028797018963968)) -
                                                              (36028797018963968)) =?
                                                              (0)))
                                                          then (
                                                            if (
                                                              (((v_ulevel + ((- 1))) =? (2)) &&
                                                                (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (54043195528446977)) &
                                                                  (3)) =?
                                                                  (1)))))
                                                            then (
                                                              if (
                                                                match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                | (Some cid_3) => true
                                                                | None => false
                                                                end)
                                                              then (
                                                                rely (
                                                                  (((((((lens 14465 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                    (((((((lens 14467 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                (Some (
                                                                  0  ,
                                                                  (((lens 14469 st_7).[share].[granule_data] :<
                                                                    ((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                      (((((st_7.(share)).(granule_data)) #
                                                                        (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                        ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                          (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                            (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                              (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                        zero_granule_data_normal))).[share].[slots] :<
                                                                    ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                )))
                                                              else None)
                                                            else (
                                                              if (
                                                                match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                | (Some cid_3) => true
                                                                | None => false
                                                                end)
                                                              then (
                                                                rely (
                                                                  (((((((lens 14471 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                    (((((((lens 14473 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                (Some (
                                                                  0  ,
                                                                  (((lens 14475 st_7).[share].[granule_data] :<
                                                                    ((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                      (((((st_7.(share)).(granule_data)) #
                                                                        (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                        ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                          (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                            (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                              (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                        zero_granule_data_normal))).[share].[slots] :<
                                                                    ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                )))
                                                              else None))
                                                          else (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_3) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14477 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14479 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14481 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None))))
                                                    else None)
                                                  else (
                                                    when cid_2 == (((((st_7.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                                    rely ((0 = (0)));
                                                    rely (
                                                      (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                      ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                | None => None
                                                end)
                                              else (
                                                rely (("slot_rtt2" = ("slot_rtt2")));
                                                rely (("granules" = ("granules")));
                                                rely (("slot_rtt" = ("slot_rtt")));
                                                rely (("smc_rtt_fold_stack" = ("smc_rtt_fold_stack")));
                                                rely ((0 = (0)));
                                                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                when cid_2 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                                rely ((0 = (0)));
                                                rely (
                                                  (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                    (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                (Some (
                                                  (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                  ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                ))))
                                            else (
                                              rely (("slot_rtt2" = ("slot_rtt2")));
                                              rely (("granules" = ("granules")));
                                              rely (("slot_rtt" = ("slot_rtt")));
                                              rely (("smc_rtt_fold_stack" = ("smc_rtt_fold_stack")));
                                              rely ((0 = (0)));
                                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                              when cid_2 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                              rely ((0 = (0)));
                                              rely (
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              (Some (
                                                (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                              ))))
                                          else (
                                            rely (("slot_rtt2" = ("slot_rtt2")));
                                            rely (("granules" = ("granules")));
                                            rely (("slot_rtt" = ("slot_rtt")));
                                            rely (("smc_rtt_fold_stack" = ("smc_rtt_fold_stack")));
                                            rely ((0 = (0)));
                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                            when cid_2 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                            rely ((0 = (0)));
                                            rely (
                                              (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                              ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            )))))
                                    | None => None
                                    end)
                                  else (
                                    if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (36028797018963968)) =? (0))
                                    then (
                                      rely (
                                        (((((((lens 15061 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 15063 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (
                                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                        ((lens 15065 st_15).[share].[slots] :<
                                          ((((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                            SLOT_RTT2 ==
                                            (v_rtt_addr / (GRANULE_SIZE))) #
                                            SLOT_RTT2 ==
                                            (- 1)) #
                                            SLOT_RTT ==
                                            (- 1)))
                                      )))
                                    else (
                                      if ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (36028797018963968)) - (36028797018963968)) =? (0))
                                      then (
                                        rely (
                                          (((((((lens 15079 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            (((((((lens 15081 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        (Some (
                                          (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                          ((lens 15083 st_15).[share].[slots] :<
                                            ((((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_RTT2 ==
                                              (v_rtt_addr / (GRANULE_SIZE))) #
                                              SLOT_RTT2 ==
                                              (- 1)) #
                                              SLOT_RTT ==
                                              (- 1)))
                                        )))
                                      else (
                                        rely (
                                          (((((((lens 15085 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            (((((((lens 15087 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        (Some (
                                          (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                          ((lens 15089 st_15).[share].[slots] :<
                                            ((((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_RTT2 ==
                                              (v_rtt_addr / (GRANULE_SIZE))) #
                                              SLOT_RTT2 ==
                                              (- 1)) #
                                              SLOT_RTT ==
                                              (- 1)))
                                        ))))))
                                else (
                                  if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (36028797018963968)) =? (0))
                                  then (
                                    rely (
                                      (((((((lens 15103 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 15105 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                      ((lens 15107 st_15).[share].[slots] :<
                                        ((((((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT2 ==
                                          (v_rtt_addr / (GRANULE_SIZE))) #
                                          SLOT_RTT2 ==
                                          (- 1)) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    )))
                                  else (
                                    if ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (36028797018963968)) - (36028797018963968)) =? (0))
                                    then (
                                      rely (
                                        (((((((lens 15121 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 15123 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (
                                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                        ((lens 15125 st_15).[share].[slots] :<
                                          ((((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                            SLOT_RTT2 ==
                                            (v_rtt_addr / (GRANULE_SIZE))) #
                                            SLOT_RTT2 ==
                                            (- 1)) #
                                            SLOT_RTT ==
                                            (- 1)))
                                      )))
                                    else (
                                      rely (
                                        (((((((lens 15127 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 15129 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (
                                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                        ((lens 15131 st_15).[share].[slots] :<
                                          ((((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                            SLOT_RTT2 ==
                                            (v_rtt_addr / (GRANULE_SIZE))) #
                                            SLOT_RTT2 ==
                                            (- 1)) #
                                            SLOT_RTT ==
                                            (- 1)))
                                      ))))))
                              else (
                                if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (36028797018963968)) =? (0))
                                then (
                                  if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (3)) =? (3))
                                  then (
                                    if (
                                      (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                        (281474976710655)) &
                                        (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                        (0)))
                                    then (
                                      match (
                                        (__table_maps_block_loop840
                                          (z_to_nat 511)
                                          false
                                          (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                          (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                          1
                                          v_ulevel
                                          false
                                          (mkPtr "slot_rtt2" 0)
                                          (mkPtr "s2tte_is_valid" 0)
                                          ((lens 14886 st_15).[share].[slots] :<
                                            ((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_RTT2 ==
                                              (v_rtt_addr / (GRANULE_SIZE)))))
                                      ) with
                                      | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) =>
                                        if v_retval_2
                                        then (
                                          if (
                                            if ((((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                            then true
                                            else (
                                              match (((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                                              | (Some cid_2) => true
                                              | None => false
                                              end))
                                          then (
                                            when cid_2 == (((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                            if ((((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                            then None
                                            else (
                                              if (
                                                ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                  (2009)) &
                                                  (36028797018963968)) =?
                                                  (0)))
                                              then (
                                                if (
                                                  (((v_ulevel + ((- 1))) =? (2)) &&
                                                    (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                      (2009)) &
                                                      (3)) =?
                                                      (1)))))
                                                then (
                                                  if (
                                                    match ((((((lens 56 st_6).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14357 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14359 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14361 st_6).[share].[granule_data] :<
                                                        ((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (2009))))) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None)
                                                else (
                                                  if (
                                                    match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14363 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14365 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14367 st_6).[share].[granule_data] :<
                                                        ((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (2009))))) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))
                                              else (
                                                if (
                                                  (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                    (2009)) &
                                                    (36028797018963968)) -
                                                    (36028797018963968)) =?
                                                    (0)))
                                                then (
                                                  if (
                                                    (((v_ulevel + ((- 1))) =? (2)) &&
                                                      (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                        (2009)) &
                                                        (3)) =?
                                                        (1)))))
                                                  then (
                                                    if (
                                                      match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                      | (Some cid_3) => true
                                                      | None => false
                                                      end)
                                                    then (
                                                      rely (
                                                        (((((((lens 14369 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                          (((((((lens 14371 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                      (Some (
                                                        0  ,
                                                        (((lens 14373 st_6).[share].[granule_data] :<
                                                          ((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (2009))))) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                            (((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                              zero_granule_data_normal))).[share].[slots] :<
                                                          ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                      )))
                                                    else None)
                                                  else (
                                                    if (
                                                      match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                      | (Some cid_3) => true
                                                      | None => false
                                                      end)
                                                    then (
                                                      rely (
                                                        (((((((lens 14375 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                          (((((((lens 14377 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                      (Some (
                                                        0  ,
                                                        (((lens 14379 st_6).[share].[granule_data] :<
                                                          ((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (2009))))) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                            (((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                              zero_granule_data_normal))).[share].[slots] :<
                                                          ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                      )))
                                                    else None))
                                                else (
                                                  if (
                                                    match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                    | (Some cid_3) => true
                                                    | None => false
                                                    end)
                                                  then (
                                                    rely (
                                                      (((((((lens 14381 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 14383 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      0  ,
                                                      (((lens 14385 st_6).[share].[granule_data] :<
                                                        ((((st_6.(share)).(granule_data)) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                          ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                            (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                              (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                              ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (2009))))) #
                                                          (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                          (((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (2009))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                            zero_granule_data_normal))).[share].[slots] :<
                                                        ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                  else None))))
                                          else None)
                                        else (
                                          when cid_2 == (((((st_6.(share)).(granules)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
                                          if ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (36028797018963968)) - (36028797018963968)) =? (0))
                                          then (
                                            if (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (3)) =? (3))
                                            then (
                                              if (
                                                (((((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                                  (281474976710655)) &
                                                  (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                                  ((((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                                  (0)))
                                              then (
                                                match (
                                                  (__table_maps_block_loop840
                                                    (z_to_nat 511)
                                                    false
                                                    (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                                    (((((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ 0) & (281474976710655)) &
                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                                    1
                                                    v_ulevel
                                                    false
                                                    (mkPtr "slot_rtt2" 0)
                                                    (mkPtr "s2tte_is_valid_ns" 0)
                                                    st_6)
                                                ) with
                                                | (Some (__break___0, v_call_1, v_call3_1, v_i_17, v_level_1, v_retval_3, v_table_1, v_s2tte_is_x_1, st_7)) =>
                                                  if v_retval_3
                                                  then (
                                                    if (
                                                      if ((((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                                      then true
                                                      else (
                                                        match (((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                                                        | (Some cid_3) => true
                                                        | None => false
                                                        end))
                                                    then (
                                                      when cid_3 == (((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                                      if ((((((st_7.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                                      then None
                                                      else (
                                                        if (
                                                          ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                            (54043195528446977)) &
                                                            (36028797018963968)) =?
                                                            (0)))
                                                        then (
                                                          if (
                                                            (((v_ulevel + ((- 1))) =? (2)) &&
                                                              (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                (54043195528446977)) &
                                                                (3)) =?
                                                                (1)))))
                                                          then (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
                                                              | (Some cid_4) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14387 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14389 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14391 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None)
                                                          else (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_4) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14393 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14395 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14397 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None))
                                                        else (
                                                          if (
                                                            (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                              (54043195528446977)) &
                                                              (36028797018963968)) -
                                                              (36028797018963968)) =?
                                                              (0)))
                                                          then (
                                                            if (
                                                              (((v_ulevel + ((- 1))) =? (2)) &&
                                                                (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (54043195528446977)) &
                                                                  (3)) =?
                                                                  (1)))))
                                                            then (
                                                              if (
                                                                match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                | (Some cid_4) => true
                                                                | None => false
                                                                end)
                                                              then (
                                                                rely (
                                                                  (((((((lens 14399 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                    (((((((lens 14401 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                (Some (
                                                                  0  ,
                                                                  (((lens 14403 st_7).[share].[granule_data] :<
                                                                    ((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                      (((((st_7.(share)).(granule_data)) #
                                                                        (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                        ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                          (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                            (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                              (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                        zero_granule_data_normal))).[share].[slots] :<
                                                                    ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                )))
                                                              else None)
                                                            else (
                                                              if (
                                                                match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                                | (Some cid_4) => true
                                                                | None => false
                                                                end)
                                                              then (
                                                                rely (
                                                                  (((((((lens 14405 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                    (((((((lens 14407 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                                (Some (
                                                                  0  ,
                                                                  (((lens 14409 st_7).[share].[granule_data] :<
                                                                    ((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                      (((((st_7.(share)).(granule_data)) #
                                                                        (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                        ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                          (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                            (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                            ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                              (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                        zero_granule_data_normal))).[share].[slots] :<
                                                                    ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                                )))
                                                              else None))
                                                          else (
                                                            if (
                                                              match ((((((lens 56 st_7).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                              | (Some cid_4) => true
                                                              | None => false
                                                              end)
                                                            then (
                                                              rely (
                                                                (((((((lens 14411 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                                  (((((((lens 14413 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                              (Some (
                                                                0  ,
                                                                (((lens 14415 st_7).[share].[granule_data] :<
                                                                  ((((st_7.(share)).(granule_data)) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                    ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                      (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                        (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                        ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                          (54043195528446977))))) #
                                                                    (((st_7.(share)).(slots)) @ SLOT_RTT2) ==
                                                                    (((((st_7.(share)).(granule_data)) #
                                                                      (((st_7.(share)).(slots)) @ SLOT_RTT) ==
                                                                      ((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                        (((((st_7.(share)).(granule_data)) @ (((st_7.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                          (8 * (((((lens 56 st_7).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                            (54043195528446977))))) @ (((st_7.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                      zero_granule_data_normal))).[share].[slots] :<
                                                                  ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                              )))
                                                            else None))))
                                                    else None)
                                                  else (
                                                    rely ((0 = (0)));
                                                    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                                    when cid_3 == (((((st_7.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                                    rely ((0 = (0)));
                                                    rely (
                                                      (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                        (((((((lens 13817 st_7).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                    (Some (
                                                      (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                      ((lens 13935 st_7).[share].[slots] :< ((((st_7.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                    )))
                                                | None => None
                                                end)
                                              else (
                                                when cid_3 == (((((st_6.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock)));
                                                rely ((0 = (0)));
                                                rely (
                                                  (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                    (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                (Some (
                                                  (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                  ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                ))))
                                            else (
                                              rely ((0 = (0)));
                                              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                              when cid_3 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                              rely ((0 = (0)));
                                              rely (
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                  (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                              (Some (
                                                (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                                ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                              ))))
                                          else (
                                            rely ((0 = (0)));
                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                            when cid_3 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                            rely ((0 = (0)));
                                            rely (
                                              (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                              ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            ))))
                                      | None => None
                                      end)
                                    else (
                                      rely (
                                        (((((((lens 15133 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 15135 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (
                                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                        ((lens 15137 st_15).[share].[slots] :<
                                          ((((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                            SLOT_RTT2 ==
                                            (v_rtt_addr / (GRANULE_SIZE))) #
                                            SLOT_RTT2 ==
                                            (- 1)) #
                                            SLOT_RTT ==
                                            (- 1)))
                                      ))))
                                  else (
                                    rely (
                                      (((((((lens 15145 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 15147 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                      ((lens 15149 st_15).[share].[slots] :<
                                        ((((((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT2 ==
                                          (v_rtt_addr / (GRANULE_SIZE))) #
                                          SLOT_RTT2 ==
                                          (- 1)) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    ))))
                                else (
                                  if ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (36028797018963968)) - (36028797018963968)) =? (0))
                                  then (
                                    if (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (3)) =? (3))
                                    then (
                                      if (
                                        (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) &
                                          (281474976710655)) &
                                          (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                                          ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                            (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))))) =?
                                          (0)))
                                      then (
                                        match (
                                          (__table_maps_block_loop840
                                            (z_to_nat 511)
                                            false
                                            (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
                                            (((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                              (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
                                            1
                                            v_ulevel
                                            false
                                            (mkPtr "slot_rtt2" 0)
                                            (mkPtr "s2tte_is_valid_ns" 0)
                                            ((lens 14886 st_15).[share].[slots] :<
                                              ((((st_15.(share)).(slots)) #
                                                SLOT_RTT ==
                                                (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                                SLOT_RTT2 ==
                                                (v_rtt_addr / (GRANULE_SIZE)))))
                                        ) with
                                        | (Some (__break__, v_call_0, v_call3_0, v_i_16, v_level_0, v_retval_2, v_table_0, v_s2tte_is_x_0, st_6)) =>
                                          if v_retval_2
                                          then (
                                            if (
                                              if ((((((st_6.(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
                                              then true
                                              else (
                                                match (((((st_6.(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                | (Some cid_2) => true
                                                | None => false
                                                end))
                                            then (
                                              when cid_2 == (((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock)));
                                              if ((((((st_6.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) - (512)) <? (0))
                                              then None
                                              else (
                                                if (
                                                  ((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                    (54043195528446977)) &
                                                    (36028797018963968)) =?
                                                    (0)))
                                                then (
                                                  if (
                                                    (((v_ulevel + ((- 1))) =? (2)) &&
                                                      (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                        (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                        (54043195528446977)) &
                                                        (3)) =?
                                                        (1)))))
                                                  then (
                                                    if (
                                                      match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                      | (Some cid_3) => true
                                                      | None => false
                                                      end)
                                                    then (
                                                      rely (
                                                        (((((((lens 14453 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                          (((((((lens 14455 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                      (Some (
                                                        0  ,
                                                        (((lens 14457 st_6).[share].[granule_data] :<
                                                          ((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (54043195528446977))))) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                            (((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                              zero_granule_data_normal))).[share].[slots] :<
                                                          ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                      )))
                                                    else None)
                                                  else (
                                                    if (
                                                      match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                      | (Some cid_3) => true
                                                      | None => false
                                                      end)
                                                    then (
                                                      rely (
                                                        (((((((lens 14459 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                          (((((((lens 14461 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                      (Some (
                                                        0  ,
                                                        (((lens 14463 st_6).[share].[granule_data] :<
                                                          ((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (54043195528446977))))) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                            (((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                              zero_granule_data_normal))).[share].[slots] :<
                                                          ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                      )))
                                                    else None))
                                                else (
                                                  if (
                                                    (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                      (54043195528446977)) &
                                                      (36028797018963968)) -
                                                      (36028797018963968)) =?
                                                      (0)))
                                                  then (
                                                    if (
                                                      (((v_ulevel + ((- 1))) =? (2)) &&
                                                        (((((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                          (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                          (54043195528446977)) &
                                                          (3)) =?
                                                          (1)))))
                                                    then (
                                                      if (
                                                        match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_3) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14465 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14467 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14469 st_6).[share].[granule_data] :<
                                                            ((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (54043195528446977))))) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_6.(share)).(granule_data)) #
                                                                (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                      (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None)
                                                    else (
                                                      if (
                                                        match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                        | (Some cid_3) => true
                                                        | None => false
                                                        end)
                                                      then (
                                                        rely (
                                                          (((((((lens 14471 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                            (((((((lens 14473 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                        (Some (
                                                          0  ,
                                                          (((lens 14475 st_6).[share].[granule_data] :<
                                                            ((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (54043195528446977))))) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                              (((((st_6.(share)).(granule_data)) #
                                                                (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                                ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                  (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                    (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                    ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                      (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                      (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                                zero_granule_data_normal))).[share].[slots] :<
                                                            ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                        )))
                                                      else None))
                                                  else (
                                                    if (
                                                      match ((((((lens 56 st_6).(share)).(granules)) @ (((16 * ((v_rtt_addr / (GRANULE_SIZE)))) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
                                                      | (Some cid_3) => true
                                                      | None => false
                                                      end)
                                                    then (
                                                      rely (
                                                        (((((((lens 14477 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                          (((((((lens 14479 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                                      (Some (
                                                        0  ,
                                                        (((lens 14481 st_6).[share].[granule_data] :<
                                                          ((((st_6.(share)).(granule_data)) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                            ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                              (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                  (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                  (54043195528446977))))) #
                                                            (((st_6.(share)).(slots)) @ SLOT_RTT2) ==
                                                            (((((st_6.(share)).(granule_data)) #
                                                              (((st_6.(share)).(slots)) @ SLOT_RTT) ==
                                                              ((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                                                (((((st_6.(share)).(granule_data)) @ (((st_6.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                                                  (8 * (((((lens 56 st_6).(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (8))))) ==
                                                                  ((((((((st_15.(share)).(granule_data)) @ (v_rtt_addr / (GRANULE_SIZE))).(g_norm)) @ 0) & (281474976710655)) &
                                                                    (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |'
                                                                    (54043195528446977))))) @ (((st_6.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                                                              zero_granule_data_normal))).[share].[slots] :<
                                                          ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                                      )))
                                                    else None))))
                                            else None)
                                          else (
                                            rely ((0 = (0)));
                                            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                                            when cid_2 == (((((st_6.(share)).(granules)) @ ((16 * ((v_rtt_addr / (GRANULE_SIZE)))) / (ST_GRANULE_SIZE))).(e_lock)));
                                            rely ((0 = (0)));
                                            rely (
                                              (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                                (((((((lens 13817 st_6).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                            (Some (
                                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                              ((lens 13935 st_6).[share].[slots] :< ((((st_6.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
                                            )))
                                        | None => None
                                        end)
                                      else (
                                        rely (
                                          (((((((lens 15151 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                            (((((((lens 15153 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                        (Some (
                                          (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                          ((lens 15155 st_15).[share].[slots] :<
                                            ((((((st_15.(share)).(slots)) #
                                              SLOT_RTT ==
                                              (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_RTT2 ==
                                              (v_rtt_addr / (GRANULE_SIZE))) #
                                              SLOT_RTT2 ==
                                              (- 1)) #
                                              SLOT_RTT ==
                                              (- 1)))
                                        ))))
                                    else (
                                      rely (
                                        (((((((lens 15163 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                          (((((((lens 15165 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                      (Some (
                                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                        ((lens 15167 st_15).[share].[slots] :<
                                          ((((((st_15.(share)).(slots)) #
                                            SLOT_RTT ==
                                            (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                            SLOT_RTT2 ==
                                            (v_rtt_addr / (GRANULE_SIZE))) #
                                            SLOT_RTT2 ==
                                            (- 1)) #
                                            SLOT_RTT ==
                                            (- 1)))
                                      ))))
                                  else (
                                    rely (
                                      (((((((lens 15169 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 15171 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                                      ((lens 15173 st_15).[share].[slots] :<
                                        ((((((st_15.(share)).(slots)) #
                                          SLOT_RTT ==
                                          (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT2 ==
                                          (v_rtt_addr / (GRANULE_SIZE))) #
                                          SLOT_RTT2 ==
                                          (- 1)) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    )))))))
                          else (
                            rely (
                              (((((((lens 15175 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                                (((((((lens 15177 st_15).(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                            (Some (
                              5  ,
                              ((lens 15179 st_15).[share].[slots] :<
                                ((((((st_15.(share)).(slots)) #
                                  SLOT_RTT ==
                                  (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_RTT2 ==
                                  (v_rtt_addr / (GRANULE_SIZE))) #
                                  SLOT_RTT2 ==
                                  (- 1)) #
                                  SLOT_RTT ==
                                  (- 1)))
                            )))))
                      else None
                    | (Some cid_1) => None
                    end)
                  else (
                    when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                    (Some (
                      ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                      ((lens 15296 st_15).[share].[slots] :<
                        ((((st_15.(share)).(slots)) #
                          SLOT_RTT ==
                          (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RTT ==
                          (- 1)))
                    ))))
                else (
                  when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                    ((lens 15441 st_15).[share].[slots] :<
                      ((((st_15.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >> (4))) #
                        SLOT_RTT ==
                        (- 1)))
                  ))))
              else (
                rely (
                  ((((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (STACK_VIRT)) < (0)) /\
                    ((((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) >= (0)))));
                when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(smc_rtt_fold_stack)) @ (((lens 14515 st).(func_sp)).(smc_rtt_fold_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (
                  ((((((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
                    (((((((st_15.(stack)).(smc_rtt_fold_stack)) @ ((((lens 14515 st).(func_sp)).(smc_rtt_fold_sp)) + (16))) << (32)) + (4)) & (4294967295))))  ,
                  (lens 15518 st_15)
                ))))
            else (Some (1, ((lens 15683 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, ((lens 15829 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
      else (Some (1, (lens 15906 st)))))
  else (Some (1, (lens 16002 st))).

Definition smc_data_create_spec (v_data_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_src_addr: Z) (v_flags: Z) (st: RData) : (option (Z * RData)) :=
  if (v_flags <? (2))
  then (
    if ((v_src_addr & (4095)) =? (0))
    then (
      if ((v_src_addr / (GRANULE_SIZE)) >? (1048575))
      then (Some (1, st))
      else (
        rely ((((0 - ((v_src_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_src_addr / (GRANULE_SIZE)) < (1048576)))));
        if (
          match (((((st.(share)).(granules)) @ ((v_src_addr / (GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end)
        then (
          if (((((st.(share)).(granules)) @ ((v_src_addr / (GRANULE_SIZE)) + (20))).(e_state)) =? (0))
          then (
            when v_call6, st_2 == (
                match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 12173 st))) with
                | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) =>
                  rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack")));
                  if __return__
                  then (
                    if __retval__
                    then (
                      rely (
                        (((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                          (((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                      rely ((((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                      rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                      when cid == ((((((lens 5901 st_3).(share)).(granules)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                      if (
                        ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_rd_state)) =?
                          (0)))
                      then (
                        rely (((Some cid) = ((Some CPU_ID))));
                        if (
                          ((((1 <<
                            (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >>
                            (1)) -
                            (v_map_addr)) >?
                            (0)))
                        then (
                          if ((((v_map_addr & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) - (v_map_addr)) =? (0))
                          then (
                            rely (
                              (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                (STACK_VIRT)) <
                                (0)) /\
                                (((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                  (GRANULES_BASE)) >=
                                  (0)))));
                            rely (
                              ((((((st_3.(share)).(granules)) @
                                ((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                  (GRANULES_BASE)) mod
                                  (ST_GRANULE_SIZE))).(e_state)) -
                                (6)) =
                                (0)));
                            rely (
                              (("granules" = ("granules")) /\
                                ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                  (GRANULES_BASE)) mod
                                  (ST_GRANULE_SIZE)) =
                                  (0)))));
                            when sh == (
                                (((lens 5901 st_3).(repl))
                                  (((lens 5901 st_3).(oracle)) ((lens 5901 st_3).(log)))
                                  (((lens 5901 st_3).(share)).[slots] :<
                                    (((st_3.(share)).(slots)) #
                                      SLOT_RD ==
                                      ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
                            when st_13 == (
                                (rtt_walk_lock_unlock_spec
                                  (mkPtr
                                    "granules"
                                    (((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) -
                                      (GRANULES_BASE)))
                                  ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                                  ((((((st_3.(share)).(granule_data)) @ ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                                  v_map_addr
                                  3
                                  (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                                  ((lens 12177 st_3).[share].[slots] :<
                                    (((st_3.(share)).(slots)) #
                                      SLOT_RD ==
                                      ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))))));
                            if ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16))) =? (3))
                            then (
                              rely (
                                ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                                  ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                              rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                              when cid_0 == (((((st_13.(share)).(granules)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                              if (
                                (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                                  (3)) =?
                                  (0)))
                              then (
                                if (
                                  (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                                    (60)) =?
                                    (0)))
                                then (
                                  if (
                                    (((((((st_13.(share)).(granule_data)) @ (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (8)))))) &
                                      (64)) =?
                                      (0)))
                                  then (
                                    rely (
                                      ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                                        ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                                    rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                                    rely ((((18446744073709420544 + ((0 & (4095)))) >? (0)) = (true)));
                                    rely (((((18446744073709420544 + ((0 & (4095)))) - (MAX_ERR)) >=? (0)) = (false)));
                                    rely ((((0 & (4095)) >=? (0)) = (true)));
                                    rely (((((0 & (4095)) / (GRANULE_SIZE)) =? (0)) = (true)));
                                    when v_call5, st_1 == (
                                        (memcpy_ns_read_spec_state_oracle
                                          (mkPtr "slot_delegated" 0)
                                          (mkPtr "slot_ns" (0 & (4095)))
                                          4096
                                          (st_13.[share].[slots] :<
                                            (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_DELEGATED ==
                                              (((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_NS ==
                                              (v_src_addr / (GRANULE_SIZE))))));
                                    rely ((v_call5 = (true)));
                                    (data_create_1
                                      v_data_addr
                                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                                      (mkPtr "slot_rtt" 0)
                                      (mkPtr "slot_rd" 0)
                                      (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                                      (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                                      (lens 12047 st)
                                      (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1)))))
                                  else (
                                    rely (
                                      ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (STACK_VIRT)) < (0)) /\
                                        ((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >= (0)))));
                                    rely (((((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                                    rely ((((18446744073709420544 + ((0 & (4095)))) >? (0)) = (true)));
                                    rely (((((18446744073709420544 + ((0 & (4095)))) - (MAX_ERR)) >=? (0)) = (false)));
                                    rely ((((0 & (4095)) >=? (0)) = (true)));
                                    rely (((((0 & (4095)) / (GRANULE_SIZE)) =? (0)) = (true)));
                                    when v_call5, st_1 == (
                                        (memcpy_ns_read_spec_state_oracle
                                          (mkPtr "slot_delegated" 0)
                                          (mkPtr "slot_ns" (0 & (4095)))
                                          4096
                                          (st_13.[share].[slots] :<
                                            (((((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_DELEGATED ==
                                              (((((st_13.(stack)).(data_create_stack)) @ (((lens 12047 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4))) #
                                              SLOT_NS ==
                                              (v_src_addr / (GRANULE_SIZE))))));
                                    rely ((v_call5 = (true)));
                                    (data_create_2
                                      v_data_addr
                                      (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                                      (mkPtr "slot_rtt" 0)
                                      (mkPtr "slot_rd" 0)
                                      (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                                      (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                                      (lens 12047 st)
                                      (st_1.[share].[slots] :< ((((st_1.(share)).(slots)) # SLOT_NS == (- 1)) # SLOT_DELEGATED == (- 1))))))
                                else (
                                  (data_create_3
                                    (mkPtr "slot_rtt" 0)
                                    (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                                    (mkPtr "slot_rd" 0)
                                    (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                                    (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                                    (lens 12047 st)
                                    (st_13.[share].[slots] :<
                                      (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                              else (
                                (data_create_3
                                  (mkPtr "slot_rtt" 0)
                                  (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                                  (mkPtr "slot_rd" 0)
                                  (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                                  (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                                  (lens 12047 st)
                                  (st_13.[share].[slots] :<
                                    (((st_13.(share)).(slots)) # SLOT_RTT == (((((st_13.(stack)).(data_create_stack)) @ (((lens 12127 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                            else (
                              (data_create_4
                                (((st_13.(stack)).(data_create_stack)) @ ((((lens 12127 st).(func_sp)).(data_create_sp)) + (16)))
                                (mkPtr "data_create_stack" (((lens 12127 st).(func_sp)).(data_create_sp)))
                                (mkPtr "slot_rd" 0)
                                (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                                (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                                (lens 12047 st)
                                st_13)))
                          else (
                            (data_create_5
                              (mkPtr "slot_rd" 0)
                              (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                              (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                              1
                              (lens 12047 st)
                              ((lens 5901 st_3).[share].[slots] :<
                                (((st_3.(share)).(slots)) #
                                  SLOT_RD ==
                                  ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                        else (
                          (data_create_5
                            (mkPtr "slot_rd" 0)
                            (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                            (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                            1
                            (lens 12047 st)
                            ((lens 5901 st_3).[share].[slots] :<
                              (((st_3.(share)).(slots)) #
                                SLOT_RD ==
                                ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                      else (
                        (data_create_5
                          (mkPtr "slot_rd" 0)
                          (mkPtr "data_create_stack" (((lens 12087 st).(func_sp)).(data_create_sp)))
                          (mkPtr "data_create_stack" (((lens 12047 st).(func_sp)).(data_create_sp)))
                          2
                          (lens 12047 st)
                          ((lens 5901 st_3).[share].[slots] :<
                            (((st_3.(share)).(slots)) #
                              SLOT_RD ==
                              ((((((lens 5901 st_3).(stack)).(data_create_stack)) @ (((lens 12087 st).(func_sp)).(data_create_sp))) - (GRANULES_BASE)) >> (4)))))))
                    else (Some (1, (lens 12242 st_3))))
                  else (
                    if (v_i_144 >? (0))
                    then (
                      rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0)));
                      rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0)));
                      when cid == (
                          ((((st_3.(share)).(granules)) @
                            (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (1, (lens 12338 st_3))))
                    else (Some (1, (lens 12434 st_3))))
                | None => None
                end);
            (Some (v_call6, st_2)))
          else (Some (1, st)))
        else None))
    else (Some (1, st)))
  else (Some (1, st)).

Definition smc_rtt_destroy_2 (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")));
  rely (((v_call16.(pbase)) = ("slot_rtt")));
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_destroy_stack")));
  rely (((v_call36.(pbase)) = ("slot_rtt2")));
  rely (((v_call31.(pbase)) = ("granules")));
  rely (
    ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if (
      ((((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then true
    else (
      match (((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
    if (
      ((((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
        ((- 1))) <?
        (0)))
    then None
    else (
      rely ((((v_call31.(pbase)) = ("granules")) /\ ((((v_call31.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
      if (
        match ((((((lens 113 st_24).(share)).(granules)) @ (((v_call31.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end)
      then (
        rely (((v_call36.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (((v_call16.(poffset)) = (0)));
        rely (
          (((((((lens 9269 st_24).(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 9269 st_24).(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        (Some (
          0  ,
          (((lens 9424 st_24).[share].[granule_data] :<
            ((((st_24.(share)).(granule_data)) #
              (((st_24.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call16.(poffset)) + ((8 * (((((lens 113 st_24).(stack)).(smc_rtt_destroy_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                  8))) #
              (((st_24.(share)).(slots)) @ SLOT_RTT2) ==
              (((((st_24.(share)).(granule_data)) #
                (((st_24.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call16.(poffset)) + ((8 * (((((lens 113 st_24).(stack)).(smc_rtt_destroy_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    8))) @ (((st_24.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                zero_granule_data_normal))).[share].[slots] :<
            ((((st_24.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
        )))
      else None))
  else None.

Definition smc_rtt_destroy_1 (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (v_call36: Ptr) (v_call31: Ptr) (st_0: RData) (st_24: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")));
  rely (((v_call16.(pbase)) = ("slot_rtt")));
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_destroy_stack")));
  rely (((v_call36.(pbase)) = ("slot_rtt2")));
  rely (((v_call31.(pbase)) = ("granules")));
  rely (
    ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ ((((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
  if (
    if (
      ((((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
        (GRANULE_STATE_RD)) =?
        (0)))
    then true
    else (
      match (((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
      | (Some cid) => true
      | None => false
      end))
  then (
    when cid == (((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
    if (
      ((((((st_24.(share)).(granules)) @ ((((((st_24.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
        ((- 1))) <?
        (0)))
    then None
    else (
      rely ((((v_call31.(pbase)) = ("granules")) /\ ((((v_call31.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
      if (
        match ((((((lens 113 st_24).(share)).(granules)) @ (((v_call31.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end)
      then (
        rely (((v_call36.(poffset)) = (0)));
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        rely (((v_call16.(poffset)) = (0)));
        rely (
          (((((((lens 9269 st_24).(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 9269 st_24).(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
        (Some (
          0  ,
          (((lens 9424 st_24).[share].[granule_data] :<
            ((((st_24.(share)).(granule_data)) #
              (((st_24.(share)).(slots)) @ SLOT_RTT) ==
              ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                  ((v_call16.(poffset)) + ((8 * (((((lens 113 st_24).(stack)).(smc_rtt_destroy_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                  0))) #
              (((st_24.(share)).(slots)) @ SLOT_RTT2) ==
              (((((st_24.(share)).(granule_data)) #
                (((st_24.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_24.(share)).(granule_data)) @ (((st_24.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    ((v_call16.(poffset)) + ((8 * (((((lens 113 st_24).(stack)).(smc_rtt_destroy_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                    0))) @ (((st_24.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
                zero_granule_data_normal))).[share].[slots] :<
            ((((st_24.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
        )))
      else None))
  else None.

Definition smc_rtt_destroy_3 (v_call17: Z) (v_ulevel: Z) (v_rtt_addr: Z) (v_call9: bool) (v_wi: Ptr) (v_call16: Ptr) (v_map_addr: Z) (v_s2_ctx: Ptr) (st_0: RData) (st_20: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_destroy_stack")));
  rely (((v_call16.(pbase)) = ("slot_rtt")));
  if ((((v_call17 & (281474976710655)) & (((- 1) << ((66 & (4294967295)))))) - (v_rtt_addr)) =? (0))
  then (
    if ((v_rtt_addr & (4095)) =? (0))
    then (
      if ((v_rtt_addr / (GRANULE_SIZE)) >? (1048575))
      then None
      else (
        rely ((((0 - ((v_rtt_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rtt_addr / (GRANULE_SIZE)) < (1048576)))));
        when sh == (((st_20.(repl)) ((st_20.(oracle)) (st_20.(log))) (st_20.(share))));
        match (((((st_20.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_lock))) with
        | None =>
          if ((((((st_20.(share)).(granules)) @ (v_rtt_addr / (GRANULE_SIZE))).(e_state)) - (6)) =? (0))
          then (
            if (
              if ((((((st_20.(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
              then true
              else (
                match ((((((lens 1135 st_20).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_lock))) with
                | (Some cid) => true
                | None => false
                end))
            then (
              if ((((((lens 1135 st_20).(share)).(granules)) @ ((v_rtt_addr / (GRANULE_SIZE)) + (24))).(e_refcount)) =? (0))
              then (
                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                if v_call9
                then (
                  (smc_rtt_destroy_2
                    v_wi
                    v_call16
                    v_map_addr
                    v_s2_ctx
                    (mkPtr "slot_rtt2" 0)
                    (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                    st_0
                    ((lens 1135 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE))))))
                else (
                  (smc_rtt_destroy_1
                    v_wi
                    v_call16
                    v_map_addr
                    v_s2_ctx
                    (mkPtr "slot_rtt2" 0)
                    (mkPtr "granules" (16 * ((v_rtt_addr / (GRANULE_SIZE)))))
                    st_0
                    ((lens 1135 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT2 == (v_rtt_addr / (GRANULE_SIZE)))))))
              else (
                rely (((v_call16.(poffset)) = (0)));
                rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
                rely (
                  (((((((lens 9425 st_20).(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                    (((((((lens 9425 st_20).(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
                (Some (5, ((lens 9531 st_20).[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT == (- 1)))))))
            else None)
          else None
        | (Some cid) => None
        end))
    else None)
  else (
    rely (((v_call16.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (
      ((((((st_20.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_20.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    when cid == (((((st_20.(share)).(granules)) @ (((((st_20.(stack)).(smc_rtt_destroy_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
    (Some (1, (lens 9620 (st_20.[share].[slots] :< (((st_20.(share)).(slots)) # SLOT_RTT == (- 1))))))).

Definition smc_rtt_destroy_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, (lens 9771 st)))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == ((((lens 9712 st).(repl)) (((lens 9712 st).(oracle)) ((lens 9712 st).(log))) ((lens 9712 st).(share))));
      if ((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0))
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        when cid == ((((((lens 9721 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)));
        if (
          ((v_ulevel >? (3)) ||
            ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + (1)) - (v_ulevel)) >? (0)))))
        then (Some (1, ((lens 9924 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
        else (
          rely (((Some cid) = ((Some CPU_ID))));
          if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
          then (
            if (
              ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                (v_map_addr)) =?
                (0)))
            then (
              rely (
                (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                  (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              rely (
                ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) -
                  (6)) =
                  (0)));
              rely (
                (("granules" = ("granules")) /\
                  ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
              when sh_0 == (
                  (((lens 9721 st).(repl))
                    (((lens 9721 st).(oracle)) ((lens 9721 st).(log)))
                    (((lens 9721 st).(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              when st_14 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                    v_map_addr
                    (v_ulevel + ((- 1)))
                    (mkPtr "smc_rtt_destroy_stack" (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)))
                    ((lens 9971 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              if (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ ((((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)) + (16))) - ((v_ulevel + ((- 1))))) =? (0))
              then (
                rely (
                  ((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (STACK_VIRT)) < (0)) /\
                    ((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >= (0)))));
                rely (((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (
                  (((v_ulevel + ((- 1))) <? (3)) &&
                    ((((((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(smc_rtt_destroy_stack)) @ ((((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)) + (8)))))) &
                      (3)) =?
                      (3)))))
                then (
                  (smc_rtt_destroy_3
                    (((((st_14.(share)).(granule_data)) @ (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_14.(stack)).(smc_rtt_destroy_stack)) @ ((((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)) + (8))))))
                    v_ulevel
                    v_rtt_addr
                    ((((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
                    (mkPtr "smc_rtt_destroy_stack" (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)))
                    (mkPtr "slot_rtt" 0)
                    v_map_addr
                    (mkPtr "smc_rtt_destroy_stack" (((lens 9672 st).(func_sp)).(smc_rtt_destroy_sp)))
                    (lens 9632 st)
                    (st_14.[share].[slots] :<
                      (((st_14.(share)).(slots)) #
                        SLOT_RTT ==
                        (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >> (4))))))
                else (
                  when cid_1 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
                    (lens
                      10020
                      (st_14.[share].[slots] :<
                        ((((st_14.(share)).(slots)) #
                          SLOT_RTT ==
                          (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >> (4))) #
                          SLOT_RTT ==
                          (- 1))))
                  ))))
              else (
                rely (
                  ((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (STACK_VIRT)) < (0)) /\
                    ((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) >= (0)))));
                when cid_0 == (((((st_14.(share)).(granules)) @ (((((st_14.(stack)).(smc_rtt_destroy_stack)) @ (((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (
                  ((((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ ((((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
                    (((((((st_14.(stack)).(smc_rtt_destroy_stack)) @ ((((lens 9632 st).(func_sp)).(smc_rtt_destroy_sp)) + (16))) << (32)) + (4)) & (4294967295))))  ,
                  (lens 10116 st_14)
                ))))
            else (Some (1, ((lens 10269 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, ((lens 10415 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
      else (Some (1, (lens 10504 st)))))
  else (Some (1, (lens 10600 st))).

Definition smc_realm_activate_spec (v_rd_addr: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, st))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == (((st.(repl)) ((st.(oracle)) (st.(log))) (st.(share))));
      match (((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
      | None =>
        if ((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0))
        then (
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          if ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_rd_state)) =? (0))
          then (
            if (
              match ((((((lens 1135 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock))) with
              | (Some cid) => true
              | None => false
              end)
            then (
              (Some (
                0  ,
                (((lens 9262 st).[share].[granule_data] :<
                  (((st.(share)).(granule_data)) #
                    (v_rd_addr / (GRANULE_SIZE)) ==
                    ((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).[g_rd] :<
                      (((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).[e_rd_rd_state] :< 1)))).[share].[slots] :<
                  ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))
              )))
            else None)
          else (Some (2, ((lens 9264 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
        else (Some (1, (lens 1137 st)))
      | (Some cid) => None
      end))
  else (Some (1, st)).

Definition smc_version_spec (st: RData) : (option (Z * RData)) :=
  (Some (3670016, st)).

Definition smc_rtt_create_6 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_26: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  if ((v_call15 & (64)) =? (0))
  then (
    match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false 0 0 v_call16 st_26)) with
    | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) =>
      rely (
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
            (GRANULE_STATE_RD)) =?
            (0)))
        then true
        else (
          match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <?
            (0)))
        then None
        else (
          rely (
            (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
          if (
            match ((((((lens 170 st_1).(share)).(granules)) @ (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid_0) => true
            | None => false
            end)
          then (
            rely (((v_call16.(poffset)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (((v_call14.(poffset)) = (0)));
            rely (
              (((((((lens 7764 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7764 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
            rely (
              (((((((lens 7770 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7770 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
            (Some (
              0  ,
              (((lens 7942 st_1).[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call14.(poffset)) + ((8 * (((((lens 7764 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                      (v_rtt_addr |' (3)))))).[share].[slots] :<
                ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
            )))
          else None))
      else None
    | None => None
    end)
  else (
    match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false 64 0 v_call16 st_26)) with
    | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) =>
      rely (
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
          ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
      rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
      if (
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
            (GRANULE_STATE_RD)) =?
            (0)))
        then true
        else (
          match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
          | (Some cid) => true
          | None => false
          end))
      then (
        when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
        if (
          ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <?
            (0)))
        then None
        else (
          rely (
            (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely ((("granules" = ("granules")) /\ ((((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
          if (
            match ((((((lens 170 st_1).(share)).(granules)) @ (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
            | (Some cid_0) => true
            | None => false
            end)
          then (
            rely (((v_call16.(poffset)) = (0)));
            rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
            rely (((v_call14.(poffset)) = (0)));
            rely (
              (((((((lens 7969 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7969 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
            rely (
              (((((((lens 7975 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                (((((((lens 7975 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
            (Some (
              0  ,
              (((lens 8147 st_1).[share].[granule_data] :<
                (((st_1.(share)).(granule_data)) #
                  (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                  ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                    (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                      ((v_call14.(poffset)) + ((8 * (((((lens 7969 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                      (v_rtt_addr |' (3)))))).[share].[slots] :<
                ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
            )))
          else None))
      else None
    | None => None
    end).

Definition smc_rtt_create_5 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_27: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  match ((s2tt_init_destroyed_loop0 (z_to_nat 256) false 0 v_call16 st_27)) with
  | (Some (__return__, v_index_0, v_s2tt_0, st_1)) =>
    rely (
      ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
          (GRANULE_STATE_RD)) =?
          (0)))
      then true
      else (
        match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end))
    then (
      when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <?
          (0)))
      then None
      else (
        rely (
          (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 170 st_1).(share)).(granules)) @ (((((((lens 170 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_0) => true
          | None => false
          end)
        then (
          rely (((v_call16.(poffset)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (((v_call14.(poffset)) = (0)));
          rely (
            (((((((lens 7380 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 7380 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely (
            (((((((lens 7386 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 7386 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          (Some (
            0  ,
            (((lens 7558 st_1).[share].[granule_data] :<
              (((st_1.(share)).(granule_data)) #
                (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    (8 * (((((lens 7380 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                    (v_rtt_addr |' (3)))))).[share].[slots] :<
              ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
          )))
        else None))
    else None
  | None => None
  end.

Definition smc_rtt_create_4 (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_28: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  match (
    (s2tt_init_assigned_empty_loop700
      (z_to_nat 512)
      false
      (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
      0
      v_ulevel
      ((v_call15 & (281474976710655)) & (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
      v_call16
      st_28)
  ) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
    rely (
      ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
          (GRANULE_STATE_RD)) =?
          (0)))
      then true
      else (
        match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end))
    then (
      when cid == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
          (512)) <?
          (0)))
      then None
      else (
        rely (
          (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 284 st_1).(share)).(granules)) @ (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_0) => true
          | None => false
          end)
        then (
          rely (((v_call16.(poffset)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (((v_call14.(poffset)) = (0)));
          rely (
            (((((((lens 7585 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 7585 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
          rely (
            (((((((lens 7591 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 7591 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
          (Some (
            0  ,
            (((lens 7763 st_1).[share].[granule_data] :<
              (((st_1.(share)).(granule_data)) #
                (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                  (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                    (8 * (((((lens 7585 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                    (v_rtt_addr |' (3)))))).[share].[slots] :<
              ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
          )))
        else None))
    else None
  | None => None
  end.

Definition smc_rtt_create_3 (v_wi: Ptr) (v_map_addr: Z) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_s2_ctx: Ptr) (v_g_tbl: Ptr) (v_rtt_addr: Z) (v_ulevel: Z) (st_0: RData) (st_29: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_create_stack")));
  when cid == (((((st_29.(share)).(granules)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  match (
    (s2tt_init_valid_loop719
      (z_to_nat 512)
      false
      (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
      0
      v_ulevel
      ((v_call15 & (281474976710655)) & (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
      v_call16
      (st_29.[share].[granule_data] :<
        (((st_29.(share)).(granule_data)) #
          (((st_29.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_29.(share)).(granule_data)) @ (((st_29.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call14.(poffset)) + ((8 * ((((st_29.(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
              0)))))
  ) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
    rely (
      ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
          (GRANULE_STATE_RD)) =?
          (0)))
      then true
      else (
        match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end))
    then (
      when cid_0 == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
          (512)) <?
          (0)))
      then None
      else (
        rely (
          (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 284 st_1).(share)).(granules)) @ (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_1) => true
          | None => false
          end)
        then (
          rely (((v_call16.(poffset)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (((v_call14.(poffset)) = (0)));
          rely (
            (((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
          if (((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) >? (0))
          then (
            if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (MAX_ERR)) >=? (0))
            then None
            else (
              if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (SLOT_VIRT)) >= (0))
              then None
              else (
                if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) >= (0))
                then None
                else (
                  if ((((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0))
                  then (
                    rely (
                      (((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                        (((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
                    if (((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) >? (0))
                    then (
                      if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (MAX_ERR)) >=? (0))
                      then None
                      else (
                        if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (SLOT_VIRT)) >= (0))
                        then None
                        else (
                          if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) >= (0))
                          then None
                          else (
                            if ((((((lens 7201 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0))
                            then (
                              (Some (
                                0  ,
                                (((lens 7379 st_1).[share].[granule_data] :<
                                  (((st_1.(share)).(granule_data)) #
                                    (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                                    ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                                      (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                        (8 * (((((lens 7189 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))) ==
                                        (v_rtt_addr |' (3)))))).[share].[slots] :<
                                  ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
                              )))
                            else None))))
                    else None)
                  else None))))
          else None)
        else None))
    else None
  | None => None
  end.

Definition smc_rtt_create_2 (v_map_addr: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call15: Z) (v_call16: Ptr) (v_ulevel: Z) (v_g_tbl: Ptr) (v_s2_ctx: Ptr) (v_rtt_addr: Z) (st_0: RData) (st_30: RData) : (option (Z * RData)) :=
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_s2_ctx.(pbase)) = ("smc_rtt_create_stack")));
  when cid == (((((st_30.(share)).(granules)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  match (
    (s2tt_init_valid_ns_loop738
      (z_to_nat 512)
      false
      (1 << ((((3 - (v_ulevel)) * (9)) + (12))))
      0
      v_ulevel
      ((v_call15 & (281474976710655)) & (((- 1) << ((((((((v_ulevel + ((- 1))) * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295))))))
      v_call16
      (st_30.[share].[granule_data] :<
        (((st_30.(share)).(granule_data)) #
          (((st_30.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_30.(share)).(granule_data)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_30.(share)).(granule_data)) @ (((st_30.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call14.(poffset)) + ((8 * ((((st_30.(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
              0)))))
  ) with
  | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
    rely (
      ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
        ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely ((("granules" = ("granules")) /\ ((((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) -
          (GRANULE_STATE_RD)) =?
          (0)))
      then true
      else (
        match (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid_0) => true
        | None => false
        end))
    then (
      when cid_0 == (((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if (
        ((((((st_1.(share)).(granules)) @ ((((((st_1.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) +
          (512)) <?
          (0)))
      then None
      else (
        rely (
          (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
            (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
        rely ((("granules" = ("granules")) /\ ((((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
        if (
          match ((((((lens 284 st_1).(share)).(granules)) @ (((((((lens 284 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
          | (Some cid_1) => true
          | None => false
          end)
        then (
          rely (((v_call16.(poffset)) = (0)));
          rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
          rely (((v_call14.(poffset)) = (0)));
          rely (
            (((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
              (((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
          if (((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) >? (0))
          then (
            if ((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (MAX_ERR)) >=? (0))
            then None
            else (
              if ((((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (SLOT_VIRT)) >= (0))
              then None
              else (
                rely (
                  (((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
                    (((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
                if (((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) >? (0))
                then (
                  if ((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (MAX_ERR)) >=? (0))
                  then None
                  else (
                    if ((((((lens 7010 st_1).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (SLOT_VIRT)) >= (0))
                    then None
                    else (
                      (Some (
                        0  ,
                        (((lens 7188 st_1).[share].[granule_data] :<
                          (((st_1.(share)).(granule_data)) #
                            (((st_1.(share)).(slots)) @ SLOT_RTT) ==
                            ((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
                              (((((st_1.(share)).(granule_data)) @ (((st_1.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                                ((v_call14.(poffset)) + ((8 * (((((lens 6998 st_1).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
                                (v_rtt_addr |' (3)))))).[share].[slots] :<
                          ((((st_1.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
                      )))))
                else None)))
          else None)
        else None))
    else None
  | None => None
  end.

Definition smc_rtt_create_1 (v_ulevel: Z) (v_call14: Ptr) (v_call16: Ptr) (v_wi: Ptr) (v_g_tbl: Ptr) (st_0: RData) (st_31: RData) : (option (Z * RData)) :=
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (((v_call16.(poffset)) = (0)));
  rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
  rely (((v_call14.(poffset)) = (0)));
  rely (
    ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
  when cid == (((((st_31.(share)).(granules)) @ (((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
  rely (
    (((((((lens 6945 (st_31.[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) -
      (STACK_VIRT)) <
      (0)) /\
      (((((((lens 6945 (st_31.[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) -
        (GRANULES_BASE)) >=
        (0)))));
  (Some (
    ((((((v_ulevel + ((- 1))) << (32)) + (4)) >> (24)) & (4294967040)) |' (((((v_ulevel + ((- 1))) << (32)) + (4)) & (4294967295))))  ,
    (lens 6997 (st_31.[share].[slots] :< ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1))))
  )).

Definition smc_rtt_create_0 (v_g_tbl: Ptr) (v_rtt_addr: Z) (v_ulevel: Z) (v_wi: Ptr) (v_call14: Ptr) (v_call16: Ptr) (st_0: RData) (st_31: RData) : (option (Z * RData)) :=
  rely (((v_g_tbl.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_wi.(pbase)) = ("smc_rtt_create_stack")));
  rely (((v_call16.(pbase)) = ("slot_delegated")));
  rely (((v_call14.(pbase)) = ("slot_rtt")));
  rely (
    ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
      ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
  rely ((("granules" = ("granules")) /\ (((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
  if (
    match (((((st_31.(share)).(granules)) @ ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock))) with
    | (Some cid) => true
    | None => false
    end)
  then (
    when cid == (((((st_31.(share)).(granules)) @ ((((((st_31.(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (20))).(e_lock)));
    rely (((v_call16.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call14.(poffset)) = (0)));
    rely (
      (((((((lens 633 st_31).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 633 st_31).(stack)).(smc_rtt_create_stack)) @ (v_wi.(poffset))) - (GRANULES_BASE)) >= (0)))));
    rely (
      (((((((lens 6771 st_31).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (STACK_VIRT)) < (0)) /\
        (((((((lens 6771 st_31).(stack)).(smc_rtt_create_stack)) @ (v_g_tbl.(poffset))) - (GRANULES_BASE)) >= (0)))));
    (Some (
      0  ,
      (((lens 6943 st_31).[share].[granule_data] :<
        (((st_31.(share)).(granule_data)) #
          (((st_31.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_31.(share)).(granule_data)) @ (((st_31.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_31.(share)).(granule_data)) @ (((st_31.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call14.(poffset)) + ((8 * (((((lens 633 st_31).(stack)).(smc_rtt_create_stack)) @ ((v_wi.(poffset)) + (8))))))) ==
              (v_rtt_addr |' (3)))))).[share].[slots] :<
        ((((st_31.(share)).(slots)) # SLOT_DELEGATED == (- 1)) # SLOT_RTT == (- 1)))
    )))
  else None.

(* Definition smc_rtt_create_spec (v_rtt_addr: Z) (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) := *)
(*     match ((find_lock_granules_loop0 (z_to_nat 2) false false false (mkPtr "find_lock_two_granules_stack" 0) 0 (lens 8328 st))) with *)
(*     | (Some (__return__, __retval__, __break__, v_granules_0, v_i_144, st_3)) => *)
(*       rely (((v_granules_0.(pbase)) = ("find_lock_two_granules_stack"))); *)
(*       if __return__ *)
(*       then ( *)
(*         if __retval__ *)
(*         then ( *)
(*           rely ( *)
(*             (((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*               (((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*           rely ((((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))); *)
(*           rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16))))); *)
(*           when cid == ((((((lens 2449 st_3).(share)).(granules)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock))); *)
(*           if ( *)
(*             ((v_ulevel >? (3)) || *)
(*               ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) + *)
(*                 (1)) - *)
(*                 (v_ulevel)) >? *)
(*                 (0))))) *)
(*           then ( *)
(*             rely ( *)
(*               (((((((lens 8333 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                 (((((((lens 8333 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*             (Some ( *)
(*               1  , *)
(*               ((lens 8456 st_3).[share].[slots] :< *)
(*                 ((((st_3.(share)).(slots)) # *)
(*                   SLOT_RD == *)
(*                   ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                   SLOT_RD == *)
(*                   (- 1))) *)
(*             ))) *)
(*           else ( *)
(*             rely (((Some cid) = ((Some CPU_ID)))); *)
(*             if ( *)
(*               (((1 << *)
(*                 (((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - *)
(*                 (v_map_addr)) >? *)
(*                 (0))) *)
(*             then ( *)
(*               if ( *)
(*                 ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) - *)
(*                   (v_map_addr)) =? *)
(*                   (0))) *)
(*               then ( *)
(*                 rely ( *)
(*                   (((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - *)
(*                     (STACK_VIRT)) < *)
(*                     (0)) /\ *)
(*                     (((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - *)
(*                       (GRANULES_BASE)) >= *)
(*                       (0))))); *)
(*                 rely ( *)
(*                   (("granules" = ("granules")) /\ *)
(*                     ((((((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - *)
(*                       (GRANULES_BASE)) mod *)
(*                       (ST_GRANULE_SIZE)) = *)
(*                       (0))))); *)
(*                 when sh == ( *)
(*                     (((lens 2449 st_3).(repl)) *)
(*                       (((lens 2449 st_3).(oracle)) ((lens 2449 st_3).(log))) *)
(*                       (((lens 2449 st_3).(share)).[slots] :< *)
(*                         ((((st_3.(share)).(slots)) # *)
(*                           SLOT_RD == *)
(*                           ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                           SLOT_RD == *)
(*                           (- 1))))); *)
(*                 rely ( *)
(*                   (((((((lens 8492 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 8492 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*                 when st_18 == ( *)
(*                     (rtt_walk_lock_unlock_spec *)
(*                       (mkPtr *)
(*                         "granules" *)
(*                         (((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - *)
(*                           (GRANULES_BASE))) *)
(*                       ((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)) *)
(*                       ((((((st_3.(share)).(granule_data)) @ ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)) *)
(*                       v_map_addr *)
(*                       (v_ulevel + ((- 1))) *)
(*                       (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                       ((lens 8503 st_3).[share].[slots] :< *)
(*                         ((((st_3.(share)).(slots)) # *)
(*                           SLOT_RD == *)
(*                           ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                           SLOT_RD == *)
(*                           (- 1))))); *)
(*                 if (((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (16))) - ((v_ulevel + ((- 1))))) =? (0)) *)
(*                 then ( *)
(*                   rely ( *)
(*                     ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                       ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*                   rely (((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))); *)
(*                   when cid_0 == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(e_lock))); *)
(*                   rely ( *)
(*                     ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                       ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*                   rely (((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0))); *)
(*                   if ( *)
(*                     (((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                       (3)) =? *)
(*                       (0))) *)
(*                   then ( *)
(*                     if ( *)
(*                       (((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                         (60)) =? *)
(*                         (0))) *)
(*                     then ( *)
(*                       (smc_rtt_create_6 *)
(*                         (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                         (mkPtr "slot_rtt" 0) *)
(*                         (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) *)
(*                         (mkPtr "slot_delegated" 0) *)
(*                         v_ulevel *)
(*                         (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                         v_rtt_addr *)
(*                         (lens 8164 st) *)
(*                         (st_18.[share].[slots] :< *)
(*                           ((((st_18.(share)).(slots)) # *)
(*                             SLOT_RTT == *)
(*                             (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                             SLOT_DELEGATED == *)
(*                             (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                     else ( *)
(*                       if ( *)
(*                         ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                           (60)) - *)
(*                           (8)) =? *)
(*                           (0))) *)
(*                       then ( *)
(*                         (smc_rtt_create_5 *)
(*                           (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                           (mkPtr "slot_rtt" 0) *)
(*                           (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) *)
(*                           (mkPtr "slot_delegated" 0) *)
(*                           v_ulevel *)
(*                           (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                           v_rtt_addr *)
(*                           (lens 8164 st) *)
(*                           (st_18.[share].[slots] :< *)
(*                             ((((st_18.(share)).(slots)) # *)
(*                               SLOT_RTT == *)
(*                               (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                               SLOT_DELEGATED == *)
(*                               (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                       else ( *)
(*                         if ( *)
(*                           ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                             (60)) - *)
(*                             (4)) =? *)
(*                             (0))) *)
(*                         then ( *)
(*                           (smc_rtt_create_4 *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             v_ulevel *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             v_rtt_addr *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                         else ( *)
(*                           (smc_rtt_create_0 *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             v_rtt_addr *)
(*                             v_ulevel *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))))))))) *)
(*                   else ( *)
(*                     if ( *)
(*                       (((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                         (36028797018963968)) =? *)
(*                         (0))) *)
(*                     then ( *)
(*                       if ( *)
(*                         (((v_ulevel + ((- 1))) =? (2)) && *)
(*                           ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                             (3)) =? *)
(*                             (1))))) *)
(*                       then ( *)
(*                         (smc_rtt_create_3 *)
(*                           (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                           v_map_addr *)
(*                           (mkPtr "slot_rtt" 0) *)
(*                           (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) *)
(*                           (mkPtr "slot_delegated" 0) *)
(*                           (mkPtr "smc_rtt_create_stack" (((lens 8284 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                           (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                           v_rtt_addr *)
(*                           v_ulevel *)
(*                           (lens 8164 st) *)
(*                           (st_18.[share].[slots] :< *)
(*                             ((((st_18.(share)).(slots)) # *)
(*                               SLOT_RTT == *)
(*                               (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                               SLOT_DELEGATED == *)
(*                               (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                       else ( *)
(*                         if ( *)
(*                           (((v_ulevel + ((- 1))) <? (3)) && *)
(*                             ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                               (3)) =? *)
(*                               (3))))) *)
(*                         then ( *)
(*                           (smc_rtt_create_1 *)
(*                             v_ulevel *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                         else ( *)
(*                           (smc_rtt_create_0 *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             v_rtt_addr *)
(*                             v_ulevel *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))))) *)
(*                     else ( *)
(*                       if ( *)
(*                         ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                           (36028797018963968)) - *)
(*                           (36028797018963968)) =? *)
(*                           (0))) *)
(*                       then ( *)
(*                         if ( *)
(*                           (((v_ulevel + ((- 1))) =? (2)) && *)
(*                             ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                               (3)) =? *)
(*                               (1))))) *)
(*                         then ( *)
(*                           (smc_rtt_create_2 *)
(*                             v_map_addr *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             v_ulevel *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8284 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             v_rtt_addr *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                         else ( *)
(*                           if ( *)
(*                             (((v_ulevel + ((- 1))) <? (3)) && *)
(*                               ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                                 (3)) =? *)
(*                                 (3))))) *)
(*                           then ( *)
(*                             (smc_rtt_create_1 *)
(*                               v_ulevel *)
(*                               (mkPtr "slot_rtt" 0) *)
(*                               (mkPtr "slot_delegated" 0) *)
(*                               (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                               (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                               (lens 8164 st) *)
(*                               (st_18.[share].[slots] :< *)
(*                                 ((((st_18.(share)).(slots)) # *)
(*                                   SLOT_RTT == *)
(*                                   (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                   SLOT_DELEGATED == *)
(*                                   (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                           else ( *)
(*                             (smc_rtt_create_0 *)
(*                               (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                               v_rtt_addr *)
(*                               v_ulevel *)
(*                               (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                               (mkPtr "slot_rtt" 0) *)
(*                               (mkPtr "slot_delegated" 0) *)
(*                               (lens 8164 st) *)
(*                               (st_18.[share].[slots] :< *)
(*                                 ((((st_18.(share)).(slots)) # *)
(*                                   SLOT_RTT == *)
(*                                   (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                   SLOT_DELEGATED == *)
(*                                   (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))))) *)
(*                       else ( *)
(*                         if ( *)
(*                           (((v_ulevel + ((- 1))) <? (3)) && *)
(*                             ((((((((st_18.(share)).(granule_data)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (8)))))) & *)
(*                               (3)) =? *)
(*                               (3))))) *)
(*                         then ( *)
(*                           (smc_rtt_create_1 *)
(*                             v_ulevel *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))) *)
(*                         else ( *)
(*                           (smc_rtt_create_0 *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             v_rtt_addr *)
(*                             v_ulevel *)
(*                             (mkPtr "smc_rtt_create_stack" (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) *)
(*                             (mkPtr "slot_rtt" 0) *)
(*                             (mkPtr "slot_delegated" 0) *)
(*                             (lens 8164 st) *)
(*                             (st_18.[share].[slots] :< *)
(*                               ((((st_18.(share)).(slots)) # *)
(*                                 SLOT_RTT == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                                 SLOT_DELEGATED == *)
(*                                 (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4)))))))))) *)
(*                 else ( *)
(*                   rely ( *)
(*                     ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                       ((((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*                   when cid_0 == (((((st_18.(share)).(granules)) @ (((((st_18.(stack)).(smc_rtt_create_stack)) @ (((lens 8244 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*                   rely ( *)
(*                     (((((((lens 8505 st_18).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                       (((((((lens 8505 st_18).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*                   (Some ( *)
(*                     ((((((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |' *)
(*                       (((((((st_18.(stack)).(smc_rtt_create_stack)) @ ((((lens 8244 st).(func_sp)).(smc_rtt_create_sp)) + (16))) << (32)) + (4)) & (4294967295))))  , *)
(*                     (lens 8557 st_18) *)
(*                   )))  ) *)
(*               else ( *)
(*                 rely ( *)
(*                   (((((((lens 8715 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                     (((((((lens 8715 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*                 (Some ( *)
(*                   1  , *)
(*                   ((lens 8838 st_3).[share].[slots] :< *)
(*                     ((((st_3.(share)).(slots)) # *)
(*                       SLOT_RD == *)
(*                       ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                       SLOT_RD == *)
(*                       (- 1))) *)
(*                 )))) *)
(*             else ( *)
(*               rely ( *)
(*                 (((((((lens 8869 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (STACK_VIRT)) < (0)) /\ *)
(*                   (((((((lens 8869 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8204 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >= (0))))); *)
(*               (Some ( *)
(*                 1  , *)
(*                 ((lens 8992 st_3).[share].[slots] :< *)
(*                   ((((st_3.(share)).(slots)) # *)
(*                     SLOT_RD == *)
(*                     ((((((lens 2449 st_3).(stack)).(smc_rtt_create_stack)) @ (((lens 8164 st).(func_sp)).(smc_rtt_create_sp))) - (GRANULES_BASE)) >> (4))) # *)
(*                     SLOT_RD == *)
(*                     (- 1))) *)
(*               ))))) *)
(*         else (Some (1, (lens 9067 st_3)))) *)
(*       else ( *)
(*         if (v_i_144 >? (0)) *)
(*         then ( *)
(*           rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (STACK_VIRT)) < (0))); *)
(*           rely ((((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) >= (0))); *)
(*           when cid == ( *)
(*               ((((st_3.(share)).(granules)) @ *)
(*                 (((((st_3.(stack)).(find_lock_two_granules_stack)) @ ((v_granules_0.(poffset)) + (((40 * ((v_i_144 + ((- 1))))) + (24))))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock))); *)
(*           (Some (1, (lens 9163 st_3)))) *)
(*         else (Some (1, (lens 9259 st_3)))) *)
(*     | None => None *)
(*     end. *)

Definition smc_rtt_unmap_unprotected_spec (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (st: RData) : (option (Z * RData)) :=
  if ((v_rd_addr & (4095)) =? (0))
  then (
    if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
    then (Some (1, (lens 8955 st)))
    else (
      rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
      when sh == ((((lens 8897 st).(repl)) (((lens 8897 st).(oracle)) ((lens 8897 st).(log))) ((lens 8897 st).(share))));
      if ((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0))
      then (
        rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
        if (((v_ulevel + ((- 4))) - ((- 2))) <? (0))
        then (Some (1, ((lens 9110 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
        else (
          rely (((((((lens 8905 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))));
          if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
          then (
            if (
              ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                (v_map_addr)) =?
                (0)))
            then (
              rely (
                (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                  (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
              rely (
                ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) -
                  (6)) =
                  (0)));
              rely (
                (("granules" = ("granules")) /\
                  ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
              when sh_0 == (
                  (((lens 8905 st).(repl))
                    (((lens 8905 st).(oracle)) ((lens 8905 st).(log)))
                    (((lens 8905 st).(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              when st_15 == (
                  (rtt_walk_lock_unlock_spec
                    (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                    ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                    v_map_addr
                    v_ulevel
                    (mkPtr "map_unmap_ns_stack" (((lens 8817 st).(func_sp)).(map_unmap_ns_sp)))
                    ((lens 9154 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
              if (((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (16))) - (v_ulevel)) =? (0))
              then (
                rely ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)));
                rely ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)));
                rely (((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                when cid == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                if (
                  ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8)))))) &
                    (36028797018963968)) -
                    (36028797018963968)) =?
                    (0)))
                then (
                  if (
                    ((v_ulevel =? (3)) &&
                      ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8)))))) &
                        (3)) =?
                        (3)))))
                  then (
                    rely (
                      (("granules" = ("granules")) /\
                        ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                    if (
                      if (
                        ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                          (GRANULE_STATE_RD)) =?
                          (0)))
                      then true
                      else (
                        match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                        | (Some cid_0) => true
                        | None => false
                        end))
                    then (
                      when cid_0 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                      if (
                        ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                          ((- 1))) <?
                          (0)))
                      then None
                      else (
                        if (
                          ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                            (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                              (GRANULE_STATE_REC)) =?
                              (0)))))
                        then (
                          rely (((((((lens 7515 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)));
                          rely (((((((lens 7515 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)));
                          (Some (
                            0  ,
                            (((lens 7673 st_15).[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                    0)))).[share].[slots] :<
                              ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_RTT ==
                                (- 1)))
                          )))
                        else (
                          rely (((((((lens 7516 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)));
                          rely (((((((lens 7516 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)));
                          (Some (
                            0  ,
                            (((lens 7868 st_15).[share].[granule_data] :<
                              (((st_15.(share)).(granule_data)) #
                                (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                  (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                    (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                    0)))).[share].[slots] :<
                              ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_RTT ==
                                (- 1)))
                          )))))
                    else None)
                  else (
                    if (
                      ((v_ulevel =? (2)) &&
                        ((((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8)))))) &
                          (3)) =?
                          (1)))))
                    then (
                      rely (
                        (("granules" = ("granules")) /\
                          ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                      if (
                        if (
                          ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                            (GRANULE_STATE_RD)) =?
                            (0)))
                        then true
                        else (
                          match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                          | (Some cid_0) => true
                          | None => false
                          end))
                      then (
                        when cid_0 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                        if (
                          ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                            ((- 1))) <?
                            (0)))
                        then None
                        else (
                          if (
                            ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                              (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                (GRANULE_STATE_REC)) =?
                                (0)))))
                          then (
                            rely (((((((lens 7913 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)));
                            rely (((((((lens 7913 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)));
                            (Some (
                              0  ,
                              (((lens 8071 st_15).[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                      0)))).[share].[slots] :<
                                ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_RTT ==
                                  (- 1)))
                            )))
                          else (
                            rely (((((((lens 7914 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)));
                            rely (((((((lens 7914 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)));
                            (Some (
                              0  ,
                              (((lens 8266 st_15).[share].[granule_data] :<
                                (((st_15.(share)).(granule_data)) #
                                  (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                  ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                    (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                      (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                      0)))).[share].[slots] :<
                                ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_RTT ==
                                  (- 1)))
                            )))))
                      else None)
                    else (
                      when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                      (Some (
                        (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                        ((lens 8411 st_15).[share].[slots] :<
                          ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                            SLOT_RTT ==
                            (- 1)))
                      )))))
                else (
                  when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                  (Some (
                    (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                    ((lens 8557 st_15).[share].[slots] :<
                      ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                        SLOT_RTT ==
                        (- 1)))
                  ))))
              else (
                rely ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)));
                rely ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)));
                when cid == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                (Some (
                  ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
                    (((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (16))) << (32)) + (4)) & (4294967295))))  ,
                  (lens 8644 st_15)
                ))))
            else (Some (1, ((lens 9262 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
          else (Some (1, ((lens 9408 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
      else (Some (1, (lens 9495 st)))))
  else (Some (1, (lens 9591 st))).

Definition smc_rtt_map_unprotected_spec (v_rd_addr: Z) (v_map_addr: Z) (v_ulevel: Z) (v_s2tte: Z) (st: RData) : (option (Z * RData)) :=
  if (
    (((Z.lxor
      ((((- 1) & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) |' (988))
      (- 1)) &
      (v_s2tte)) =?
      (0)))
  then (
    if ((v_s2tte & (28)) =? (16))
    then (Some (1, st))
    else (
      if ((v_s2tte & (768)) =? (256))
      then (Some (1, st))
      else (
        if ((v_rd_addr & (4095)) =? (0))
        then (
          if ((v_rd_addr / (GRANULE_SIZE)) >? (1048575))
          then (Some (1, (lens 8955 st)))
          else (
            rely ((((0 - ((v_rd_addr / (GRANULE_SIZE)))) <= (0)) /\ (((v_rd_addr / (GRANULE_SIZE)) < (1048576)))));
            when sh == ((((lens 8897 st).(repl)) (((lens 8897 st).(oracle)) ((lens 8897 st).(log))) ((lens 8897 st).(share))));
            if ((((((st.(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_state)) - (2)) =? (0))
            then (
              rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
              if (((v_ulevel + ((- 4))) - ((- 2))) <? (0))
              then (Some (1, ((lens 9110 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
              else (
                rely (((((((lens 8905 st).(share)).(granules)) @ (v_rd_addr / (GRANULE_SIZE))).(e_lock)) = ((Some CPU_ID))));
                if (((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) - (v_map_addr)) >? (0))
                then (
                  if (
                    ((((v_map_addr & (281474976710655)) & (((- 1) << (((((((v_ulevel * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))))) -
                      (v_map_addr)) =?
                      (0)))
                  then (
                    rely (
                      (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (STACK_VIRT)) < (0)) /\
                        (((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) >= (0)))));
                    if ((((1 << (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)))) >> (1)) - (v_map_addr)) >? (0))
                    then (Some (1, ((lens 9150 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))
                    else (
                      rely (
                        ((((((st.(share)).(granules)) @ ((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE))).(e_state)) -
                          (6)) =
                          (0)));
                      rely (
                        (("granules" = ("granules")) /\
                          ((((((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)))));
                      when sh_0 == (
                          (((lens 8905 st).(repl))
                            (((lens 8905 st).(oracle)) ((lens 8905 st).(log)))
                            (((lens 8905 st).(share)).[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
                      when st_15 == (
                          (rtt_walk_lock_unlock_spec
                            (mkPtr "granules" (((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_g_rtt)) - (GRANULES_BASE)))
                            ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level))
                            ((((((st.(share)).(granule_data)) @ (v_rd_addr / (GRANULE_SIZE))).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits))
                            v_map_addr
                            v_ulevel
                            (mkPtr "map_unmap_ns_stack" (((lens 8817 st).(func_sp)).(map_unmap_ns_sp)))
                            ((lens 9152 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))));
                      if (((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (16))) - (v_ulevel)) =? (0))
                      then (
                        rely (
                          ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)) /\
                            ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)))));
                        rely (((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) mod (ST_GRANULE_SIZE)) = (0)));
                        when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(e_lock)));
                        if (
                          (((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8)))))) &
                            (3)) =?
                            (0)))
                        then (
                          if (
                            (((((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) @ (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8)))))) &
                              (60)) =?
                              (0)))
                          then (
                            if (v_ulevel =? (3))
                            then (
                              rely (
                                (("granules" = ("granules")) /\
                                  ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                              if (
                                if (
                                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                    (GRANULE_STATE_RD)) =?
                                    (0)))
                                then true
                                else (
                                  match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                                  | (Some cid_2) => true
                                  | None => false
                                  end))
                              then (
                                when cid_2 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                                if (
                                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                                    (1)) <?
                                    (0)))
                                then None
                                else (
                                  if (
                                    ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                      (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                        (GRANULE_STATE_REC)) =?
                                        (0)))))
                                  then (
                                    rely (
                                      (((((((lens 8791 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 8792 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      0  ,
                                      (((lens 8793 st_15).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                              (v_s2tte |' (54043195528446979)))))).[share].[slots] :<
                                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    )))
                                  else (
                                    rely (
                                      (((((((lens 8794 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 8795 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      0  ,
                                      (((lens 8796 st_15).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                              (v_s2tte |' (54043195528446979)))))).[share].[slots] :<
                                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    )))))
                              else None)
                            else (
                              rely (
                                (("granules" = ("granules")) /\
                                  ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
                              if (
                                if (
                                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                    (GRANULE_STATE_RD)) =?
                                    (0)))
                                then true
                                else (
                                  match (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock))) with
                                  | (Some cid_2) => true
                                  | None => false
                                  end))
                              then (
                                when cid_2 == (((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_lock)));
                                if (
                                  ((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_refcount)) +
                                    (1)) <?
                                    (0)))
                                then None
                                else (
                                  if (
                                    ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
                                      (((((((st_15.(share)).(granules)) @ ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE)) + (24))).(e_state)) -
                                        (GRANULE_STATE_REC)) =?
                                        (0)))))
                                  then (
                                    rely (
                                      (((((((lens 8797 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 8798 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      0  ,
                                      (((lens 8799 st_15).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                              (v_s2tte |' (54043195528446977)))))).[share].[slots] :<
                                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    )))
                                  else (
                                    rely (
                                      (((((((lens 8800 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)) /\
                                        (((((((lens 8801 st_15).(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)))));
                                    (Some (
                                      0  ,
                                      (((lens 8802 st_15).[share].[granule_data] :<
                                        (((st_15.(share)).(granule_data)) #
                                          (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4)) ==
                                          ((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).[g_norm] :<
                                            (((((st_15.(share)).(granule_data)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))).(g_norm)) #
                                              (8 * ((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (8))))) ==
                                              (v_s2tte |' (54043195528446977)))))).[share].[slots] :<
                                        ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                          SLOT_RTT ==
                                          (- 1)))
                                    )))))
                              else None))
                          else (
                            when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                            (Some (
                              (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                              ((lens 8803 st_15).[share].[slots] :<
                                ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                  SLOT_RTT ==
                                  (- 1)))
                            ))))
                        else (
                          when cid_1 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                          (Some (
                            (((((v_ulevel << (32)) + (4)) >> (24)) & (4294967040)) |' ((((v_ulevel << (32)) + (4)) & (4294967295))))  ,
                            ((lens 8804 st_15).[share].[slots] :<
                              ((((st_15.(share)).(slots)) # SLOT_RTT == (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >> (4))) #
                                SLOT_RTT ==
                                (- 1)))
                          ))))
                      else (
                        rely (
                          ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (STACK_VIRT)) < (0)) /\
                            ((((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) >= (0)))));
                        when cid_0 == (((((st_15.(share)).(granules)) @ (((((st_15.(stack)).(map_unmap_ns_stack)) @ (((lens 8817 st).(func_sp)).(map_unmap_ns_sp))) - (GRANULES_BASE)) / (ST_GRANULE_SIZE))).(e_lock)));
                        (Some (
                          ((((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (16))) << (32)) + (4)) >> (24)) & (4294967040)) |'
                            (((((((st_15.(stack)).(map_unmap_ns_stack)) @ ((((lens 8817 st).(func_sp)).(map_unmap_ns_sp)) + (16))) << (32)) + (4)) & (4294967295))))  ,
                          (lens 6727 st_15)
                        )))))
                  else (Some (1, ((lens 9262 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1))))))
                else (Some (1, ((lens 9408 st).[share].[slots] :< ((((st.(share)).(slots)) # SLOT_RD == (v_rd_addr / (GRANULE_SIZE))) # SLOT_RD == (- 1)))))))
            else (Some (1, (lens 9495 st)))))
        else (Some (1, (lens 9591 st))))))
  else (Some (1, st)).
