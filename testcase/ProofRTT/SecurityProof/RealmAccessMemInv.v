Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.
Require Import SecurityProof.SecurityLemma.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma realm_access_mem_inv:
  forall rd addr val nd nd' ret_d
    (Hspec: normal_realm_access_mem rd addr val nd = Some (nd', ret_d))
    (Hinv: SharedInv (nd.(share))),
    SharedInv (nd'.(share)).
Proof.
  intros.
  unfold normal_realm_access_mem in *; autounfold with sem in *.
  repeat simpl_hyp Hspec; inv Hspec.
  inv Hinv.
  { constructor.
    - unfold gpt_false_ns. simpl. eapply gpt_false_ns_inv0.
    - unfold delegated_zero; simpl.
      intros. assert_gso.
      red; intros; subst. autounfold with spec in *.
      unfold rtt_map_data in *. autounfold with spec in *.
      erewrite rtt_map_data_inv0 in Hdel. lia.
      eassumption. eassumption.
      rewrite (ZMap.gso _ _ Hneq). apply delegated_zero_inv0. assumption.
    - unfold rtt_map_data; simpl.
      intros. eapply rtt_map_data_inv0. eapply Hrd.
      erewrite walk_rtt_same. eapply Hwalk.
      intros; simpl; autounfold with spec in *. assert_gso.
      red; intros; subst.
      unfold rtt_map_data in *. autounfold with spec in *.
      erewrite rtt_map_data_inv0 in H. lia.
      eapply e. eassumption.
      rewrite (ZMap.gso _ _ Hneq). reflexivity.
    - unfold rtt_reverse in *; simpl.
      destruct rtt_reverse_inv0 as (data_to_rd & rtt_reverse_inv0).
      exists data_to_rd. intros. eapply rtt_reverse_inv0. eapply Hrd.
      erewrite walk_rtt_same. eapply Hwalk.
      intros; simpl; autounfold with spec in *. assert_gso.
      red; intros; subst.
      unfold rtt_map_data in *. autounfold with spec in *.
      erewrite rtt_map_data_inv0 in H. lia.
      eapply e. eassumption.
      rewrite (ZMap.gso _ _ Hneq). reflexivity.
  }
  assumption.
Qed.
