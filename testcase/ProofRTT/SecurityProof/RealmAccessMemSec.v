Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma realm_access_mem_secure:
  forall rd addr val sd sec nd sd' sec' nd' ret_s ret_d
    (Hsec: secure_realm_access_mem rd addr val (sd, sec) = Some ((sd', sec'), ret_s))
    (Hnorm: normal_realm_access_mem rd addr val nd = Some (nd', ret_d))
    (Hrel: relate sd sec nd)
    (Hinv: SharedInv (nd.(share))),
    ret_s = ret_d /\ relate sd' sec' nd'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold secure_realm_access_mem, normal_realm_access_mem in *; autounfold with sem in *.
  repeat simpl_hyp Hsec; inv Hsec.
  - (* secure data exists *)
    destruct relate_sec_data0. simpl in mem_rel0.
    Frewrite.
    erewrite <- relate_walk_rtt_same in Hnorm. erewrite C3 in Hnorm.
    2: assumption.
    exploit mem_rel0; try eassumption.
    grewrite. intros. frewrite. inv Hnorm.
    split. reflexivity.
    constructor.
    + constructor.
      simpl. intros.
      destruct_zmap; simpl.
      * (* rd is the running rd *)
        subst.
        destruct_zmap; simpl.
        { (* data_gidx is used *)
          subst. simpl.
          destruct_zmap; simpl.
          reflexivity.
          apply mem_rel0; assumption. }
        { (* data_gidx is not used *)
          apply mem_rel0; assumption. }
      * (* rd is not the running rd *)
        assert(Hne: data_gidx <> z).
        { pose proof (shared_inv_implies _ Hinv) as Hinv'.
          inv Hinv'. Frewrite.
          eapply diff_rd_diff_data0.
          eapply Hrd. eapply e. lia.
          erewrite <- relate_walk_rtt_same. eapply Hwalk. assumption.
          erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
        rewrite (ZMap.gso _ _ Hne).
        apply mem_rel0; Frewrite; reflexivity.
    + simpl. constructor; simpl; Frewrite; try reflexivity.
      all: intros; try solve[destruct_zmap; simpl; Frewrite; reflexivity].
      assert(Hne: i <> z).
      { red; intros; subst.
        inv Hinv. unfold rtt_map_data in *; autounfold with spec in *.
        erewrite rtt_map_data_inv0 in Hnd. lia.
        eapply  e. erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
      rewrite (ZMap.gso _ _ Hne).
      eapply (id_g_norm _ _ relate_share0). Frewrite. assumption.
    + constructor; simpl; Frewrite; reflexivity.
  - (* secure data not exists *)
    destruct relate_sec_data0. simpl in mem_rel0.
    Frewrite.
    erewrite <- relate_walk_rtt_same in Hnorm. erewrite C3 in Hnorm.
    2: assumption.
    exploit mem_rel0; try eassumption.
    grewrite. intros. frewrite. inv Hnorm.
    split. reflexivity.
    constructor.
    + constructor.
      simpl. intros.
      destruct_zmap; simpl.
      * (* rd is the running rd *)
        subst.
        destruct_zmap; simpl.
        { (* data_gidx is used *)
          subst. simpl.
          destruct_zmap; simpl.
          reflexivity.
          apply mem_rel0; assumption. }
        { (* data_gidx is not used *)
          apply mem_rel0; assumption. }
      * (* rd is not the running rd *)
        assert(Hne: data_gidx <> z).
        { pose proof (shared_inv_implies _ Hinv) as Hinv'.
          inv Hinv'. Frewrite.
          eapply diff_rd_diff_data0.
          eapply Hrd. eapply e. lia.
          erewrite <- relate_walk_rtt_same. eapply Hwalk. assumption.
          erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
        rewrite (ZMap.gso _ _ Hne).
        apply mem_rel0; Frewrite; reflexivity.
    + simpl. constructor; simpl; Frewrite; try reflexivity.
      all: intros; try solve[destruct_zmap; simpl; Frewrite; reflexivity].
      assert(Hne: i <> z).
      { red; intros; subst.
        inv Hinv. unfold rtt_map_data in *; autounfold with spec in *.
        erewrite rtt_map_data_inv0 in Hnd. lia.
        eapply  e. erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
      rewrite (ZMap.gso _ _ Hne).
      eapply (id_g_norm _ _ relate_share0). Frewrite. assumption.
    + constructor; simpl; Frewrite; reflexivity.
  - (* no mapping *)
    destruct relate_sec_data0. simpl in mem_rel0.
    Frewrite.
    erewrite <- relate_walk_rtt_same in Hnorm. erewrite C3 in Hnorm.
    2: assumption.
    inv Hnorm.
    split. reflexivity. assumption.
Qed.
