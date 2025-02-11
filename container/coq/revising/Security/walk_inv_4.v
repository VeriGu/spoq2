Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Bottom.Spec.
Require Import Layer13.Spec.
Require Import Layer9.Spec.
Require Import Layer8.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import walk_inv.
Require Import SecurityProof.
(* Require Import SMCHandler.Spec. *)

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_system_interface_version_spec_walk_rev:
  forall d ret_n ret_d
    (Hspec: smc_system_interface_version_spec d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. inv Hspec. easy.
Qed.

Lemma smc_read_feature_register_spec_walk_rev:
  forall d v_0 v_1 ret_d
    (Hspec: smc_read_feature_register_spec v_0 v_1 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. inv Hspec. unfold smc_read_feature_register_spec in *.
  autounfold with sem in *. remember (prop (pbase v_1 = "stack_s_smc_result" /\ poffset v_1 = 0)) as p.
  destruct p eqn:Hp.
  - destruct (v_0 =? 0) eqn:Hv0.
    + inv H0. unfold walk_rev in *. auto.
    + inv H0. unfold walk_rev in *. auto.
  - easy.
Qed.

Lemma aligned_z_plus_4_mod_same:
  forall (x: Z)
    (Haligned: x mod 4096 = 0 /\ x >= 0),
      x / 4096 = (x + 4) / 4096.
Admitted.
  

Lemma smc_granule_delegate_spec_walk_rev:
  forall v_0 v_1 d ret_n ret_d
    (Hspec: smc_granule_delegate_spec v_0 v_1 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
      walk_rev ret_d.(share).
Proof.
  intros. unfold smc_granule_delegate_spec in Hspec.
  autounfold with sem in *. repeat simpl_hyp Hspec.
  simpl_some. simpl_walk_rev. repeat rewrite strong_lens in *.
  inversion Hspec. bool_rel.
  - unfold walk_rev in *. subst. destruct Hinv as [rev Hinv].
  exists rev. simpl in *. simpl_walk_rev. inv Hspec.
  retrieve_idx. intros. specialize (Hinv rtt_idx).
  specialize (Hinv Hgood_idx Hrtt_not_root).
  destruct (gidx0 =? rtt_idx) eqn:Hgidx; bool_rel.
    + rewrite Hgidx in *. rewrite ZMap.gss in *. inv Hrtt.
    + remember (meta_granule_offset (test_PA v_0)) as mgo.
    specialize (aligned_z_plus_4_mod_same mgo a). intros.
    rewrite <- Heqgidx in *. rewrite <- Heqgidx0 in *. rewrite <- H0 in *.
    rewrite ZMap.gso in Hrtt. specialize (Hinv Hrtt parent_idx offset H).
    destruct (parent_idx =? gidx) eqn:Hparent_idx; bool_rel.
      * subst. destruct Hinv. lia.
      * rewrite ZMap.gso. easy. easy.
      * lia.
  - simpl_some. inv Hspec. simpl_walk_rev. repeat rewrite strong_lens in *.
  subst. unfold walk_rev in *. auto.
  - simpl_some. inv Hspec. simpl_walk_rev. repeat rewrite strong_lens in *.
  subst. unfold walk_rev in *. auto.
  - simpl_some. inv Hspec. simpl_walk_rev. repeat rewrite strong_lens in *.
  subst. unfold walk_rev in *. auto.
Qed.

Lemma smc_granule_undelegate_spec_walk_rev:
  forall v_0 v_1 d ret_n ret_d
    (Hspec: smc_granule_undelegate_spec v_0 v_1 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
      walk_rev ret_d.(share).
Proof.
  intros. unfold smc_granule_undelegate_spec in Hspec.
  autounfold with sem in *. repeat simpl_hyp Hspec.
  simpl_some. simpl_walk_rev. repeat rewrite strong_lens in *.
  inversion Hspec. bool_rel.
  - subst. inv Hspec. remember (meta_granule_offset (test_PA v_0)) as mgo.
  specialize (aligned_z_plus_4_mod_same mgo a). intros. rewrite <- H in *.
  simpl. unfold walk_rev in *. destruct Hinv as [rev Hinv]. exists rev.
  intros. specialize (Hinv rtt_idx Hgood_idx Hrtt_not_root).
  unfold GRANULE_STATE_RTT in *. simpl in *. remember (mgo / 4096) as gidx.
  destruct (gidx =? rtt_idx) eqn:Hgidx; bool_rel.
    + rewrite Hgidx in *. rewrite ZMap.gss in *. inv Hrtt.
    + rewrite ZMap.gso in Hrtt. specialize (Hinv Hrtt parent_idx offset H0).
    destruct (parent_idx =? gidx) eqn:Hparent_idx; bool_rel.
      * subst. destruct Hinv. lia.
      * rewrite ZMap.gso. easy. easy.
      * lia.
  - simpl_some. inv Hspec. simpl_walk_rev. repeat rewrite strong_lens in *.
  subst. unfold walk_rev in *. auto.
  - simpl_some. inv Hspec. simpl_walk_rev. repeat rewrite strong_lens in *.
  subst. unfold walk_rev in *. auto.
Qed.
