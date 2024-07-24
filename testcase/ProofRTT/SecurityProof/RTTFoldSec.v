Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_rtt_fold_2_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init ret_n ret_s sec_d' norm_d'
    (Hnorm: smc_rtt_fold_2 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init norm_d = Some (ret_n, norm_d'))
    (Hsec: smc_rtt_fold_2 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init sec_d = Some (ret_s, sec_d'))

    (Hrtt1: (((sec_d.(share)).(granules)) @ (((sec_d.(share)).(slots)) @ SLOT_RTT)).(e_state) = GRANULE_STATE_RTT)
    (Hrtt2: (((sec_d.(share)).(granules)) @ (((sec_d.(share)).(slots)) @ SLOT_RTT2)).(e_state) = GRANULE_STATE_RTT)
    (Hrtt_neq: (((sec_d.(share)).(slots)) @ SLOT_RTT) <> (((sec_d.(share)).(slots)) @ SLOT_RTT2))
    (Hllt: (((sec_d.(share)).(slots)) @ SLOT_RTT) = ((sec_d.(stack)).(stack_wi)).(e_g_llt))
    (Hwalk: exists rd gfn lvl pte pte',
        ((sec_d.(share).(granules) @ rd).(e_state) = GRANULE_STATE_RD)
        /\ walk_rtt_level (Z.to_nat lvl) (sec_d.(share)) 0 rd gfn (gidx_to_table_pte (rd_rtt (sec_d.(share)) rd)) =
            (lvl, pte)
        /\ (((sec_d.(stack)).(stack_wi)).(e_g_llt)) = pte_to_gidx pte
        /\ gfn_to_rtt_offs gfn lvl = 8 * (((sec_d.(stack)).(stack_wi)).(e_index))
        /\ walk_one_step (sec_d.(share)) lvl gfn (((sec_d.(stack)).(stack_wi)).(e_g_llt)) = pte'
        /\ ((sec_d.(share)).(slots)) @ SLOT_RTT2 = pte_to_gidx pte')
    (Hpte: pte_table_equiv call44 ((sec_d.(share).(granule_data) @ (((sec_d.(share)).(slots)) @ SLOT_RTT2)).(g_norm)))

    (Hinv_sec: SharedInv (sec_d.(share)))
    (Hinv_norm: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rtt_fold_2 in *; autounfold with sem in *.
  repeat simpl_hyp Hsec. repeat simpl_hyp Hnorm. inv Hnorm.
  destruct Hwalk as (? & ? & ? & ? & ? & ? & ? & ? & ? & ? & ?).
  Frewrite. inv Hsec.
  extract_prop. repeat match goal with | [H: prop _ = _ |- _ ] => clear H end.
  bool_rel. simpl_some. clear_hyp. subst.
  split.
  - reflexivity.
  - constructor.
    {
      constructor; simpl.
      inv relate_sec_data.
      rewrite_id. frewrite. subst.
      intros. rewrite lens_same in Hrd. repeat rewrite_id.
      remember (pte_to_gidx x2) as rtt_idx. symmetry in Heqrtt_idx.
      remember (pte_to_gidx (walk_one_step (share sec_d) x1 x0 rtt_idx)) as rtt2_idx. symmetry in Heqrtt2_idx.
      rewrite Z.add_0_l in *.
      remember (8 * e_index (stack_wi (stack sec_d))) as e_idx. symmetry in Heqe_idx.
      repeat rewrite lens_same in *.
      match type of Hwalk with
      | walk_rtt ?d ?rd ?addr = _ =>
          assert(Hwalk_eq: walk_rtt d rd addr = walk_rtt (share sec_d) rd addr)
      end.
      {
        assert_gso. lia. rewrite (ZMap.gso _ _ Hneq) in *.
        repeat (rewrite walk_rtt_same_set_slot in * ).
        rename x1 into lvl0.
        rename x into rd0.
        rename x0 into gfn0.
        rename x2 into pte0.
        assert(Hwalk0: walk_star (share sec_d) rd0 gfn0 rtt_idx).
        { unfold walk_star. repeat eexists. eassumption. lia. }
        assert(Hwalk1: walk_star (share sec_d) rd0 gfn0 rtt2_idx).
        { unfold walk_star.
          eexists. eexists. exists (S (Z.to_nat lvl0)).
          simpl. repeat grewrite. simpl_bool_eq.
          split. reflexivity. reflexivity. }
        erewrite walk_unreachable_same with
          (sh:= (share sec_d).[granule_data] :<
                  (((granule_data (share sec_d)) # rtt_idx ==
                      (((granule_data (share sec_d)) @ rtt_idx).[g_norm]
                       :< ((g_norm (granule_data (share sec_d)) @ rtt_idx) # e_idx ==
                             call44))))) at 1.
        + destruct (prop (walk_star (share sec_d) rd_gidx (addr_to_gidx vaddr) rtt2_idx)).
          * eapply pte_table_equiv_walk_same; try eassumption.
            apply shared_inv_implies. eassumption.
            unfold walk_one_step in Heqrtt2_idx. simpl in Heqrtt2_idx.
            frewrite. reflexivity.
          * unfold walk_rtt.
            erewrite child_unreachable_update_entry_same;
              try eassumption.
            reflexivity.
            apply shared_inv_implies. assumption.
            subst. unfold walk_one_step. grewrite. reflexivity.
        + instantiate (1:= fun r => r =? rtt2_idx).
          simpl. intros. bool_rel. rewrite H3 in *. clear H3.
          eapply update_entry_child_unreachable.
          apply shared_inv_implies. assumption.
          eassumption. assumption.
          subst. unfold walk_one_step. grewrite. reflexivity.
          left. unfold pte_table_equiv in Hpte. apply Hpte.
        + simpl. reflexivity.
        + simpl. intros. repeat (destruct_zmap; simpl); reflexivity.
        + simpl. intros. bool_rel. rewrite ZMap.gso. reflexivity. lia.
      }
      rewrite Hwalk_eq in Hwalk.
      pose proof (mem_rel rd_gidx Hrd vaddr data_gidx Hwalk) as mem_rel.
      simpl in mem_rel.
      inv Hinv_norm. unfold rtt_map_data in *. repeat rewrite_id.
      erewrite relate_walk_rtt_same in *; try eassumption.
      pose proof (rtt_map_data_inv rd_gidx Hrd (addr_to_gidx vaddr) data_gidx Hwalk) as Hdata.
      autounfold with spec in *.
      assert_gso. red; intro T; inv T; lia.
      rewrite (ZMap.gso _ _ Hneq).
      assert_gso. red; intro T; inv T; lia.
      rewrite (ZMap.gso _ _ Hneq0).
      rewrite (ZMap.gso _ _ Hneq).
      rewrite (ZMap.gso _ _ Hneq0).
      assumption.
    }
    {
      pose proof relate_share as D; destruct D.
      constructor; simpl; repeat rewrite lens_same; rewrite_id; try reflexivity.
      all:intros; rewrite_id; simpl; repeat (destruct_zmap; simpl; rewrite_id); try reflexivity.
      all:rewrite id_g_norm; rewrite_id; subst; try reflexivity; try assumption.
    }
    {
      constructor; simpl; repeat rewrite lens_same; rewrite_id; try reflexivity.
    }
Qed.

Lemma smc_rtt_fold_3_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init ret_n ret_s sec_d' norm_d'
    (Hnorm: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init norm_d = Some (ret_n, norm_d'))
    (Hsec: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init sec_d = Some (ret_s, sec_d'))

    (Hrtt1: (((sec_d.(share)).(granules)) @ (((sec_d.(share)).(slots)) @ SLOT_RTT)).(e_state) = GRANULE_STATE_RTT)
    (Hrtt2: (((sec_d.(share)).(granules)) @ (((sec_d.(share)).(slots)) @ SLOT_RTT2)).(e_state) = GRANULE_STATE_RTT)
    (Hrtt_neq: (((sec_d.(share)).(slots)) @ SLOT_RTT) <> (((sec_d.(share)).(slots)) @ SLOT_RTT2))
    (Hllt: (((sec_d.(share)).(slots)) @ SLOT_RTT) = ((sec_d.(stack)).(stack_wi)).(e_g_llt))
    (Hwalk: exists rd gfn lvl pte pte',
        ((sec_d.(share).(granules) @ rd).(e_state) = GRANULE_STATE_RD)
        /\ walk_rtt_level (Z.to_nat lvl) (sec_d.(share)) 0 rd gfn (gidx_to_table_pte (rd_rtt (sec_d.(share)) rd)) =
            (lvl, pte)
        /\ (((sec_d.(stack)).(stack_wi)).(e_g_llt)) = pte_to_gidx pte
        /\ gfn_to_rtt_offs gfn lvl = 8 * (((sec_d.(stack)).(stack_wi)).(e_index))
        /\ walk_one_step (sec_d.(share)) lvl gfn (((sec_d.(stack)).(stack_wi)).(e_g_llt)) = pte'
        /\ ((sec_d.(share)).(slots)) @ SLOT_RTT2 = pte_to_gidx pte')
    (Hpte: pte_table_equiv call44 ((sec_d.(share).(granule_data) @ (((sec_d.(share)).(slots)) @ SLOT_RTT2)).(g_norm)))

    (Hinv_sec: SharedInv (sec_d.(share)))
    (Hinv_norm: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rtt_fold_3 in *; autounfold with sem in *.
  repeat simpl_hyp Hsec. repeat simpl_hyp Hnorm. inv Hnorm.
  destruct Hwalk as (? & ? & ? & ? & ? & ? & ? & ? & ? & ? & ?).
  Frewrite. inv Hsec.
  extract_prop. repeat match goal with | [H: prop _ = _ |- _ ] => clear H end.
  bool_rel. simpl_some. clear_hyp. subst.
  split.
  - reflexivity.
  - constructor.
    {
      constructor; simpl.
      inv relate_sec_data.
      rewrite_id. frewrite. subst.
      intros. rewrite lens_same in Hrd. repeat rewrite_id.
      remember (pte_to_gidx x2) as rtt_idx. symmetry in Heqrtt_idx.
      remember (pte_to_gidx (walk_one_step (share sec_d) x1 x0 rtt_idx)) as rtt2_idx. symmetry in Heqrtt2_idx.
      rewrite Z.add_0_l in *.
      remember (8 * e_index (stack_wi (stack sec_d))) as e_idx. symmetry in Heqe_idx.
      repeat rewrite lens_same in *.
      match type of Hwalk with
      | walk_rtt ?d ?rd ?addr = _ =>
          assert(Hwalk_eq: walk_rtt d rd addr = walk_rtt (share sec_d) rd addr)
      end.
      {
        assert_gso. lia. rewrite (ZMap.gso _ _ Hneq) in *.
        repeat (rewrite walk_rtt_same_set_slot in * ).
        rename x1 into lvl0.
        rename x into rd0.
        rename x0 into gfn0.
        rename x2 into pte0.
        assert(Hwalk0: walk_star (share sec_d) rd0 gfn0 rtt_idx).
        { unfold walk_star. repeat eexists. eassumption. lia. }
        assert(Hwalk1: walk_star (share sec_d) rd0 gfn0 rtt2_idx).
        { unfold walk_star.
          eexists. eexists. exists (S (Z.to_nat lvl0)).
          simpl. repeat grewrite. simpl_bool_eq.
          split. reflexivity. reflexivity. }
        erewrite walk_unreachable_same with
          (sh:= (share sec_d).[granule_data] :<
                  (((granule_data (share sec_d)) # rtt_idx ==
                      (((granule_data (share sec_d)) @ rtt_idx).[g_norm]
                       :< ((g_norm (granule_data (share sec_d)) @ rtt_idx) # e_idx ==
                             call44))))) at 1.
        + destruct (prop (walk_star (share sec_d) rd_gidx (addr_to_gidx vaddr) rtt2_idx)).
          * eapply pte_table_equiv_walk_same; try eassumption.
            apply shared_inv_implies. eassumption.
            unfold walk_one_step in Heqrtt2_idx. simpl in Heqrtt2_idx.
            frewrite. reflexivity.
          * unfold walk_rtt.
            erewrite child_unreachable_update_entry_same;
              try eassumption.
            reflexivity.
            apply shared_inv_implies. assumption.
            subst. unfold walk_one_step. grewrite. reflexivity.
        + instantiate (1:= fun r => r =? rtt2_idx).
          simpl. intros. bool_rel. rewrite H3 in *. clear H3.
          eapply update_entry_child_unreachable.
          apply shared_inv_implies. assumption.
          eassumption. assumption.
          subst. unfold walk_one_step. grewrite. reflexivity.
          left. unfold pte_table_equiv in Hpte. apply Hpte.
        + simpl. reflexivity.
        + simpl. intros. repeat (destruct_zmap; simpl); reflexivity.
        + simpl. intros. bool_rel. rewrite ZMap.gso. reflexivity. lia.
      }
      rewrite Hwalk_eq in Hwalk.
      pose proof (mem_rel rd_gidx Hrd vaddr data_gidx Hwalk) as mem_rel.
      simpl in mem_rel.
      inv Hinv_norm. unfold rtt_map_data in *. repeat rewrite_id.
      erewrite relate_walk_rtt_same in *; try eassumption.
      pose proof (rtt_map_data_inv rd_gidx Hrd (addr_to_gidx vaddr) data_gidx Hwalk) as Hdata.
      autounfold with spec in *.
      assert_gso. red; intro T; inv T; lia.
      rewrite (ZMap.gso _ _ Hneq).
      assert_gso. red; intro T; inv T; lia.
      rewrite (ZMap.gso _ _ Hneq0).
      rewrite (ZMap.gso _ _ Hneq).
      rewrite (ZMap.gso _ _ Hneq0).
      assumption.
    }
    {
      pose proof relate_share as D; destruct D.
      constructor; simpl; repeat rewrite lens_same; rewrite_id; try reflexivity.
      all:intros; rewrite_id; simpl; repeat (destruct_zmap; simpl; rewrite_id); try reflexivity.
      all:rewrite id_g_norm; rewrite_id; subst; try reflexivity; try assumption.
    }
    {
      constructor; simpl; repeat rewrite lens_same; rewrite_id; try reflexivity.
    }
Qed.
