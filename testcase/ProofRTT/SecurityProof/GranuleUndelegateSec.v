Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_granule_undelegate_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    v_addr ret_s ret_n sec_d' norm_d'
    (Hsec: smc_granule_undelegate_spec v_addr sec_d = Some (ret_s, sec_d'))
    (Hnorm: smc_granule_undelegate_spec v_addr norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv (norm_d.(share))),
  ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_granule_undelegate_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hsec; inv Hsec; inv Hnorm.
  - repeat (auto; constructor).
  - autounfold with sem in *.
    Frewrite. simpl_hyp H0.
    inv H0.
    split. auto.
    { constructor.
      - constructor.
        + simpl. inv relate_sec_data0. autounfold with spec in *.
          intros.
          rewrite (walk_rtt_same (share (lens 422 sec_d))) in Hwalk.
          rewrite walk_rtt_lens_same in Hwalk.
          assert_gso' Hrd.
          { red; intros T; inv T. rewrite ZMap.gss in Hrd.
            simpl in Hrd. rewrite e_state_lens_same in Hrd.
            Frewrite. lia. }
          rewrite (ZMap.gso _ _ Hneq) in Hrd.
          rewrite e_state_lens_same in Hrd.
          exploit mem_rel0; try eassumption.
          repeat rewrite g_norm_lens_same. auto.
          simpl. intros. reflexivity.
      - constructor; intros; simpl in *.
        all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
        autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        destruct_zmap' Hnd; simpl in *; Frewrite; assumption.
      - constructor; intros; simpl in *;
          repeat rewrite lens_same; Frewrite; reflexivity.
    }
  - autounfold with sem in *.
    Frewrite. simpl_hyp H0; inv H0.
    split. auto.
    { constructor.
      - constructor. simpl. inv relate_sec_data0. repeat rewrite lens_same.
        intros. destruct_zmap' Hrd. subst.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
      - simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
        inv relate_share0. eapply id_g_norm0.
        autounfold with spec in *.
        destruct_zmap' Hnd; simpl in *; Frewrite; assumption.
      - simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
    }
  - split. reflexivity.
    assumption.
Qed.
