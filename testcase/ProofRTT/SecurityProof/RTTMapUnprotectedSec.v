Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Print smc_rtt_map_unprotected_spec.


Lemma validate_rtt_map_cmds_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    v_map_addr v_level v_rd ret_s ret_n sec_d' norm_d'
    (Hsec: Spec.validate_rtt_map_cmds_spec'
             v_map_addr v_level v_rd sec_d = Some (ret_s, sec_d'))
    (Hnorm: Spec.validate_rtt_map_cmds_spec'
             v_map_addr v_level v_rd norm_d = Some (ret_n, norm_d')),
    ret_s = ret_n.
Admitted.

Ltac extract_match H name:=
  match type of H with
  | match ?f with | _ => _ end = _ => destruct f eqn:name
  end.

Lemma smc_rtt_map_unprotected_secure:
      forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
        v_rd_addr v_map_addr v_ulevel v_s2tte ret_s ret_n sec_d' norm_d'
        (Hsec: smc_rtt_map_unprotected_spec v_rd_addr v_map_addr v_ulevel v_s2tte sec_d = Some (ret_s, sec_d'))
        (Hnorm: smc_rtt_map_unprotected_spec v_rd_addr v_map_addr v_ulevel v_s2tte norm_d = Some (ret_n, norm_d'))
        (Hinv_sec: SharedInv (sec_d.(share)))
        (Hinv_norm: SharedInv (norm_d.(share))),
        ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rtt_map_unprotected_spec in *; autounfold with sem in *.
  all: repeat rewrite oracle_rel in *.
  do 3 simpl_hyp Hsec.
  - destruct b.
    inv Hsec; inv Hnorm. split. reflexivity. assumption.
    inv Hsec; inv Hnorm. split. reflexivity. assumption.
  - extract_match Hsec Hs2tte_valid.
    destruct b. all: contra.
    + repeat rewrite_id. repeat rewrite lens_same in *.
      simpl_hyp Hsec. simpl_hyp Hsec.
      extract_match Hsec Hvalidate_sec.
      extract_match Hnorm Hvalidate_norm.
      destruct p, p0. all: contra.
      exploit validate_rtt_map_cmds_secure.
      2: eapply Hvalidate_sec. 2: eapply Hvalidate_norm.
      constructor; simpl.
      constructor; simpl. inv relate_sec_data. eassumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      pose proof relate_share as D. inv D. eapply id_g_norm. assumption.
      constructor; simpl; intros; try rewrite_id; try reflexivity.
      intros. subst. destruct b0.
      * repeat rewrite_id.
        simpl_hyp Hsec. simpl_hyp Hsec. simpl_hyp Hsec.
        inv Hsec; inv Hnorm. split. reflexivity.
        constructor; simpl.
        constructor; simpl. inv relate_sec_data. eassumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
        pose proof relate_share as D. inv D. eapply id_g_norm. repeat rewrite_id. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
        simpl_hyp Hsec. simpl_hyp Hsec.
        extract_match Hsec Hwalk_sec.
        extract_match Hnorm Hwalk_norm.
        all: contra.
        assert(relate r1 sec_st r2 /\ SharedInv (r1.(share)) /\ SharedInv (r2.(share))).
        { admit. }
        clear Hinv_sec Hinv_norm relate_sec_data relate_share relate_local Hrel.
        destruct H as (Hrel & Hinv_sec & Hinv_norm).
        pose proof Hrel as D. destruct D.
        repeat rewrite_id.
        simpl_hyp Hsec. simpl_hyp Hsec. simpl_hyp Hsec. simpl_hyp Hsec.
        simpl_hyp Hsec.
        erewrite id_g_norm in Hnorm. 2: eassumption.
        extract_match Hsec Hs2ttr_hipas.
        destruct b. all: contra.
        repeat simpl_hyp Hsec. admit.
        repeat simpl_hyp Hsec. admit.
        repeat simpl_hyp Hsec. admit.
        admit.
        erewrite id_g_norm in Hnorm. 2: eassumption.
        extract_match Hsec Hs2ttr_hipas.
        destruct b. all: contra.
        repeat simpl_hyp Hsec. admit.
        repeat simpl_hyp Hsec. admit.
        repeat simpl_hyp Hsec. admit.
        admit.
        repeat simpl_hyp Hsec. admit.
      * inv Hsec; inv Hnorm. split. reflexivity.
        constructor; simpl.
        constructor; simpl. inv relate_sec_data. eassumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
        pose proof relate_share as D. inv D. eapply id_g_norm. repeat rewrite_id. assumption.
        constructor; simpl; intros; try rewrite_id; try reflexivity.
    + inv Hsec; inv Hnorm. split. reflexivity. assumption.
  - repeat simpl_hyp Hsec; repeat simpl_hyp Hnorm; inv Hsec; inv Hnorm.
    split. reflexivity. assumption.
  - inv Hsec; inv Hnorm. split. reflexivity. assumption.
  - inv Hsec; inv Hnorm. split. reflexivity. assumption.
Qed.
