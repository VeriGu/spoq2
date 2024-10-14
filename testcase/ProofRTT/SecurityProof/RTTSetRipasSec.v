Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Print smc_rtt_set_ripas_spec.


Lemma find_lock_two_granules_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    v_addr1 v_expected_state1 v_g1 v_addr2 v_expected_state2 v_g2 ret_s ret_n sec_d' norm_d'
    (Hsec: find_lock_two_granules_spec
             v_addr1 v_expected_state1 v_g1 v_addr2 v_expected_state2 v_g2 sec_d = Some (ret_s, sec_d'))
    (Hnorm: find_lock_two_granules_spec
             v_addr1 v_expected_state1 v_g1 v_addr2 v_expected_state2 v_g2 norm_d = Some (ret_n, norm_d'))
    (Hinv_sec: SharedInv (sec_d.(share)))
    (Hinv_norm: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d' /\ SharedInv (sec_d.(share)) /\ SharedInv (norm_d.(share)).
Admitted.

Lemma validate_rtt_entry_cmds_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    v_map_addr v_level v_rd ret_s ret_n sec_d' norm_d'
    (Hsec: Spec.validate_rtt_entry_cmds_spec'
             v_map_addr v_level v_rd sec_d = Some (ret_s, sec_d'))
    (Hnorm: Spec.validate_rtt_entry_cmds_spec'
             v_map_addr v_level v_rd norm_d = Some (ret_n, norm_d')),
    ret_s = ret_n.
Admitted.

Ltac extract_match H name:=
  match type of H with
  | match ?f with | _ => _ end = _ => destruct f eqn:name
  end.

Lemma smc_rtt_set_ripas_secure:
      forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
        v_rd_addr v_rec_addr v_map_addr v_ulevel v_uripas ret_s ret_n sec_d' norm_d'
        (Hsec: smc_rtt_set_ripas_spec v_rd_addr v_rec_addr v_map_addr v_ulevel v_uripas sec_d = Some (ret_s, sec_d'))
        (Hnorm: smc_rtt_set_ripas_spec v_rd_addr v_rec_addr v_map_addr v_ulevel v_uripas norm_d = Some (ret_n, norm_d'))

        (Hinv_sec: SharedInv (sec_d.(share)))
        (Hinv_norm: SharedInv (norm_d.(share))),
        ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rtt_set_ripas_spec in *; autounfold with sem in *.
  simpl_hyp Hsec.
  inv Hsec. inv Hnorm. split. reflexivity. assumption.
  destruct (find_lock_two_granules_spec
              v_rd_addr 2 {| pbase := "stack_g0"; poffset := 0 |} v_rec_addr 3
              {| pbase := "stack_g1"; poffset := 0 |} sec_d) eqn:Hsec_find_lock; contra.
  destruct p.
  destruct (find_lock_two_granules_spec
              v_rd_addr 2 {| pbase := "stack_g0"; poffset := 0 |} v_rec_addr 3
              {| pbase := "stack_g1"; poffset := 0 |} norm_d) eqn:Hnorm_find_lock; contra.
  destruct p.
  exploit (find_lock_two_granules_secure sec_d sec_st norm_d); try eassumption.
  clear Hinv_sec Hinv_norm Hrel relate_local relate_share relate_sec_data.
  intros (? & Hrel & Hinv_sec & Hinv_norm).
  pose proof Hrel as D. destruct D.
  subst.
  simpl_hyp Hsec.
  - repeat rewrite_id.
    do 12 simpl_hyp Hsec.
    + extract_match Hsec Hvalidate_sec.
      extract_match Hnorm Hvalidate_norm.
      all: contra.
      destruct p, p0.
      exploit validate_rtt_entry_cmds_secure.
      2: eapply Hvalidate_sec. 2: eapply Hvalidate_norm.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. eassumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      intros. subst.
      simpl_hyp Hsec.
      * inv Hsec; inv Hnorm.
        split. reflexivity.
        repeat rewrite lens_same.
        constructor; simpl.
        constructor; simpl. inv relate_sec_data. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
        pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
      * inv Hsec; inv Hnorm.
        split. reflexivity.
        repeat rewrite lens_same.
        constructor; simpl.
        constructor; simpl. inv relate_sec_data. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
        pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
    + repeat simpl_hyp Hsec.
    + extract_match Hsec Hvalidate_sec.
      extract_match Hnorm Hvalidate_norm.
      all: contra.
      destruct p, p0.
      exploit validate_rtt_entry_cmds_secure.
      2: eapply Hvalidate_sec. 2: eapply Hvalidate_norm.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. eassumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      intros. subst.
      simpl_hyp Hsec.
      * simpl_hyp Hsec. simpl_hyp Hsec.
        repeat rewrite oracle_rel in *.
        extract_match Hsec Hwalk_sec.
        extract_match Hnorm Hwalk_norm.
        all: contra.

        Hwalk_sec : rtt_walk_lock_unlock_spec
                {|
                  pbase := "granules";
                  poffset :=
                    e_rls2ctx_g_rtt
                      (e_rd_s2_ctx
                         (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))) -
                    GRANULES_BASE
                |}
                (e_rls2ctx_s2_starting_level
                   (e_rd_s2_ctx
                      (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))))
                (e_rls2ctx_ipa_bits
                   (e_rd_s2_ctx
                      (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))))
                v_map_addr v_ulevel {| pbase := "stack_wi"; poffset := 0 |}
                ((lens 117 r).[share].[slots]
                 :< (((slots (share r)) # SLOT_REC == ((stack_g1 (stack r) - GRANULES_BASE) >> 4))
                     # SLOT_RD == ((stack_g0 (stack r) - GRANULES_BASE) >> 4))).[stack].[stack_s2_ctx]
                :< (e_rd_s2_ctx
                      (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))) =
              Some r3


        Hwalk_norm : rtt_walk_lock_unlock_spec
                 {|
                   pbase := "granules";
                   poffset :=
                     e_rls2ctx_g_rtt
                       (e_rd_s2_ctx
                          (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))) -
                     GRANULES_BASE
                 |}
                 (e_rls2ctx_s2_starting_level
                    (e_rd_s2_ctx
                       (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))))
                 (e_rls2ctx_ipa_bits
                    (e_rd_s2_ctx
                       (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))))
                 v_map_addr v_ulevel {| pbase := "stack_wi"; poffset := 0 |}
                 ((lens 117 r0).[share].[slots]
                  :< (((slots (share r)) # SLOT_REC == ((stack_g1 (stack r) - GRANULES_BASE) >> 4))
                      # SLOT_RD == ((stack_g0 (stack r) - GRANULES_BASE) >> 4))).[stack].[stack_s2_ctx]
                 :< (e_rd_s2_ctx
                       (g_rd (granule_data (share r)) @ ((stack_g0 (stack r) - GRANULES_BASE) >> 4))) =
               Some r4

        simpl_hyp Hsec. simpl_hyp Hnorm.
      * simpl_hyp Hsec.
        inv Hsec; inv Hnorm.
        split. reflexivity.
        repeat rewrite lens_same.
        constructor; simpl.
        constructor; simpl. inv relate_sec_data. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
        pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
    + repeat simpl_hyp Hsec; repeat simpl_hyp Hnorm;
        inv Hsec; inv Hnorm.
      split. reflexivity.
      repeat rewrite lens_same.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
    + inv Hsec; inv Hnorm.
      split. reflexivity.
      repeat rewrite lens_same.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
    + inv Hsec; inv Hnorm.
      split. reflexivity.
      repeat rewrite lens_same.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
    + inv Hsec; inv Hnorm. split. reflexivity.
      repeat rewrite lens_same.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. rewrite_id. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
    + inv Hsec; inv Hnorm.
      split. reflexivity.
      repeat rewrite lens_same. assumption.
  - inv Hsec. inv Hnorm. split. reflexivity. assumption.
Qed.
