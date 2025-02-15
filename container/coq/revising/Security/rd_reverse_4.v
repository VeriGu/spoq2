Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Bottom.Spec.
Require Import Layer13.Spec.
Require Import Layer12.Spec.
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
Require Import rd_reverse.
Require Import SecurityProof.


Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma rd_g_rtt_is_root:
  forall sh rd_idx rtt_idx parent_idx offset
    (Hrd: (sh.(globals).(g_granules) @ rd_idx).(e_state_s_granule) = GRANULE_STATE_RD)
    (Hrtt: (test_Z_Ptr (sh.(granule_data) @ rd_idx).(g_norm) @ 32).(poffset) / 4096 = rtt_idx)
    (Hprtt: (sh.(globals).(g_granules) @ parent_idx).(e_state_s_granule) = GRANULE_STATE_RTT),
    (test_Z_PTE ((sh.(granule_data) @ parent_idx).(g_norm) @ offset)).(meta_PA).(meta_granule_offset) <> rtt_idx * 4096.
Admitted.
 
Lemma rsi_rtt_destroy_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 ret_n ret_d
    (Hspec: rsi_rtt_destroy_spec v_0 v_1 v_2 v_3 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.
  intros.  unfold rsi_rtt_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  inv Hspec.
  simpl in *; rewrite strong_lens in *; simpl in *.
  simpl_rtt_idx_all_2.
  retrieve_idx.
  unfold rd_rev in *.
  simpl in *.
  destruct Hinv as [rev Hinv]; simpl in *.
  exists rev.
  intros.
  simpl_walk_rev.
  destruct_zmap' Hrd; simpl in *; [ try lia | ].
  rewrite lens_ignore_g_granules_update in Hrd.
  destruct_zmap; simpl in *; try rewrite lens_ignore_g_granules_update in *; simpl in *.
  - rewrite ZMap.gso in Hrtt; [ | unfold not; intros Heq1; rewrite Heq1 in *; simpl in *; try lia].
    rewrite <- Heq0 in *.
    apply Z.sub_move_r in C8. ring_simplify in C8.
    rewrite <- C8 in *.
    pose proof (rd_g_rtt_is_root (share d) rd_idx rtt_idx gidx normidx) as Hnot_root.
    repeat simpl_imply Hnot_root.
    rewrite -> Heqgidx0 in *.
    rewrite abs_tte_read_sem in *.
    simpl in *.
    simpl_rtt_idx_all_2.
    rewrite <- Heqgidx in *. rewrite <- Heqnormidx in *.
    rewrite -> C8 in *.
    destruct a0 as [a00 a01].
    pose proof (rtt_mul_div_4096_same  (meta_granule_offset (test_PA v_0)) a00) as Hmod.
    try lia.
  - destruct_zmap' Hrtt; simpl in *.
    + try rewrite Heq1 in *; simpl in *; try lia.
    + pose proof (Hinv rd_idx rtt_idx) as Hinv; repeat simpl_imply Hinv.
      auto.
Qed.


Lemma smc_rtt_fold_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 ret_n ret_d
    (Hspec: smc_rtt_fold_spec v_0 v_1 v_2 v_3 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.
  intros.  unfold smc_rtt_fold_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: repeat rewrite strong_lens in *; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat match goal with
  | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
  => rewrite rtt_idx_compute_4 with z v; [ |lia]
  end.
  all: repeat match goal with
  | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
  => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
  end.
  all: repeat match goal with
    | |- context[(meta_granule_offset (test_PA ?z) + ?v) / 4096]
  => rewrite rtt_idx_compute_3 with z v; [ |lia]
  end.
  all: repeat match goal with
  | [H: context[(meta_granule_offset (test_PA ?z) + ?v) / 4096] |- _]
  => rewrite rtt_idx_compute_3 with z v in H; [ |lia]
  end.
  all: inv Hspec.
  all: retrieve_idx; simpl in *.
  all: unfold rd_rev in *.
  all: simpl in *.
  all: destruct Hinv as [rev Hinv]; simpl in *; exists rev; intros.
  all: simpl_walk_rev; destruct_zmap' Hrd; simpl in *; try lia.
  all: destruct_zmap' Hrtt; simpl in *; try lia.
  all: try(pose proof (Hinv rd_idx rtt_idx) as Hinv; repeat simpl_imply Hinv; destruct Hinv as [Hinv0 Hinv1]; simpl in *).
  all: split; try auto.
  all: destruct_zmap; simpl in *; try auto.
  all: pose proof rd_g_rtt_is_root as Ha; simpl_walk_rev.
  all: match goal with
       | [H: context[(meta_granule_offset (meta_PA (abs_tte_read _ _)))] |- _] => 
          rewrite abs_tte_read_sem in H; simpl in H;
          rewrite Z.sub_move_r in H; try(ring_simplify in H); simpl_rtt_idx_all_2;
          repeat rewrite <- Heqgidx in *; repeat rewrite <- Heqnormidx in *;
          match type of H with
          | context[(g_norm ((granule_data (share ?d)) @ ?pidx)) @?sidx]
          => pose proof (Ha (share d) rd_idx rtt_idx (pidx) (sidx)) as Hb; repeat simpl_imply Hb;
             rewrite -> Heqgidx0 in *; rewrite -> Heq1 in *; destruct a0 as [a00 a01];
             rewrite <- rtt_mul_div_4096_same in Hb; [ contra | try auto ]
             (* eapply rtt_mul_div_4096_same in Hb *)
             (* rewrite -> H in *; rewrite Heq1 in *; rewrite <- Hrtt in * *)
             (* try rewrite rtt_mul_div_4096_same in Hb *)
          end
        end.
Qed.
 