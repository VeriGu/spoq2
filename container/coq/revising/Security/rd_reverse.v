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
Require Import walk_inv_2.
Require Import walk_inv_3.
Require Import SecurityProof.

Definition rd_rev (sh: Shared) : Prop :=
  exists (rev: Z -> (Z)),
  forall rd_idx rtt_idx
    (Hrd: (sh.(globals).(g_granules) @ rd_idx).(e_state_s_granule) = GRANULE_STATE_RD)
    (Hrtt_state: (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT)
    (Hrtt: (sh.(granule_data) @ rd_idx).(g_norm) @ 32 = rtt_idx),
    (* 32 : (sh.(granule_data) @ rd).(g_rd).(e_rd_s2_ctx).(e_g_rtt). *)
    rev rtt_idx = rd_idx.

Lemma keep_rd_rev :
  forall sh ret_sh (Hinv: rd_rev sh)
    (Hrd_ret: 
      forall rd_idx, 
      (ret_sh.(globals).(g_granules) @ rd_idx).(e_state_s_granule) = GRANULE_STATE_RD
      -> (sh.(globals).(g_granules) @ rd_idx).(e_state_s_granule) = GRANULE_STATE_RD
      /\ (sh.(granule_data) @ rd_idx).(g_norm) @ 32 = (ret_sh.(granule_data) @ rd_idx).(g_norm) @ 32
    ) 
    (Hrtt_ret:
      forall rtt_idx,
       (ret_sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT 
       -> (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT
    ), rd_rev ret_sh.
Proof.
    intros.
    unfold rd_rev in *.
    destruct Hinv as [rev Hinv].
    exists rev.
    intros.
    destruct((g_norm (granule_data sh) @ rd_idx) @ 32 =? rtt_idx) eqn:Ha; bool_rel.
    - pose proof (Hrd_ret rd_idx) as H.  
      apply H in Hrd.
      destruct Hrd as [Hrd Hrd1].
      pose proof (Hrtt_ret rtt_idx) as H3.
      apply H3 in Hrtt_state.
      pose proof (Hinv rd_idx rtt_idx) as H2.
      repeat simpl_imply H2. auto.
    - pose proof (Hrd_ret rd_idx) as H.  
      apply H in Hrd.     
      destruct Hrd as [Hrd Hrd1].
      pose proof (Hrtt_ret rtt_idx) as H3.
      apply H3 in Hrtt_state.
      pose proof (Hinv rd_idx rtt_idx) as H2.
      rewrite Hrd1 in *.
      repeat simpl_imply H2. 
      auto.
Qed.

Ltac partial_simpl_rd_rev_and_solve Hspec :=
  try intros_ensure;
  try partial_simpl_walk_rev;
  repeat match goal with
    | [H: _ = lens _ _ |- _] => rewrite -> H in *; clear H
  end;
  repeat match goal with
    | [H: (_, _, _) = (_, _, _) |- _] => inv H
  end;
  repeat match goal with
    | [H: context[lens _ (lens _ _)] |- _] => rewrite <- lens_repeat in H
  end; simpl_some; try simpl_walk_rev_strong Hspec; bool_rel; try (inv Hspec; easy).


Lemma smc_rec_destroy_spec_rd_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_rec_destroy_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.
  intros.  unfold smc_rec_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: partial_simpl_rd_rev_and_solve Hspec.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: repeat rewrite strong_lens in *; intros; inv Hspec; simpl in *.
  all: try(simpl in *; retrieve_idx; split; [ | auto]).
  all: simpl_walk_rev. 
  - destruct (gidx0 =? rd_idx) eqn: H3; bool_rel.
    + rewrite H3 in *; assumption.
    + rewrite ZMap.gso in H; simpl in *; [ | auto].
      destruct (gidx =? rd_idx) eqn: H2; bool_rel.
      * rewrite H2 in *.  rewrite ZMap.gss in H; simpl in *; lia.
      * rewrite ZMap.gso in *; [ simpl in *; auto | auto].
  - simpl in *; retrieve_idx; destruct (gidx0 =? rtt_idx) eqn: H3; bool_rel.
    + rewrite H3 in *. simpl in *. rewrite ZMap.gss in H.
      assert(gidx <> rtt_idx); [ unfold not; intros Hneq; rewrite Hneq in *; lia | 
        rewrite ZMap.gso in H; [ simpl in *; auto | auto ] ].
    + rewrite ZMap.gso in H; simpl in *; [ | auto].
      destruct (gidx =? rtt_idx) eqn: H2; bool_rel.
      * rewrite H2 in *.  rewrite ZMap.gss in H; simpl in *; lia.
      * rewrite ZMap.gso in *; [ simpl in *; auto | auto].
Qed.

   



    

