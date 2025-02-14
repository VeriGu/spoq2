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
 
Lemma smc_data_create_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 ret_n ret_d
    (Hspec: smc_data_create_spec v_0 v_1 v_2 v_3 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_data_create_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: try rewrite lens_ignore_g_granules_update in H.
  all: simpl_walk_rev.
  all: try (destruct_zmap' H; simpl in *; [ try lia | repeat rewrite lens_ignore_g_granules_update in H ]).
  all: try auto.
  all: try match goal with
       | |- context[(granule_data (share _)) # ?idx == _] => remember idx as H32idx; 
          assert (H32idx <> rd_idx); [ unfold not; intros Heq2; rewrite Heq2 in *; try lia | rewrite ZMap.gso; simpl in *; [ try auto | try auto ] ]
       end.
  all: try (match goal with
            | |- context[(g_granules (globals (share _))) # ?idx == _] => remember idx as Hrttidx; 
               assert (Hrttidx <> rtt_idx); [ unfold not; intros Heq3; rewrite Heq3 in *; lia |  rewrite ZMap.gso; simpl in *; auto ]
            end).
  all: try (unfold not; intros Heq4; rewrite Heq4 in *; try lia ).
  all: try repeat rewrite lens_ignore_g_granules_update; auto.
  all: destruct_zmap; simpl in *.
  all: try (rewrite Heq in *; lia).
  all: rewrite lens_ignore_g_granules_update in *; auto.
Qed.



Lemma smc_rec_enter_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 ret_d
    (Hspec: smc_rec_enter_spec v_0 v_1 v_2 v_3 d = Some(ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_rec_enter_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: try rewrite lens_ignore_g_granules_update in H.
  all: simpl_walk_rev; auto.
  all: repeat match goal with
  | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
    => rewrite rtt_idx_compute_4 with z v; [ |lia]
  end.
  all: repeat match goal with
  | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
    => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
  end.
  all: rewrite Heqnormidx in *. rewrite Heqnormidx0 in *.
  - admit.
  - admit.
Admitted.

Lemma smc_rtt_read_entry_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 ret_d
  (Hspec: smc_rtt_read_entry_spec v_0 v_1 v_2 v_3 d = Some(ret_d))
  (Hinv: rd_rev d.(share)),
  rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_rtt_read_entry_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
Qed.

Lemma rsi_data_destroy_spec_rd_rev:
  forall d v_0 v_1 ret_d ret_n
  (Hspec: rsi_data_destroy_spec v_0 v_1 d = Some(ret_n, ret_d))
  (Hinv: rd_rev d.(share)),
  rd_rev ret_d.(share).
Proof.   
  intros.  unfold rsi_data_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: try rewrite lens_ignore_g_granules_update in H.
  all: simpl_walk_rev; auto.
  all: repeat match goal with
  | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
    => rewrite rtt_idx_compute_4 with z v; [ |lia]
  end.
  all: repeat match goal with
  | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
    => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
  end.
  all: try destruct_zmap' H; simpl in *; repeat rewrite lens_ignore_g_granules_update in *; simpl in *; try lia.
  all: try destruct_zmap; try auto.
  all: try(rewrite Heq0 in *; simpl in *; try lia).
  all: repeat rewrite lens_ignore_g_granules_update in *; auto.
  all: rewrite <- Heq in *.
  all: try lia.
Qed.

Lemma rsi_rtt_set_ripas_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 ret_d ret_n
  (Hspec: rsi_rtt_set_ripas_spec v_0 v_1 v_2 v_3 d = Some(ret_n, ret_d))
  (Hinv: rd_rev d.(share)),
  rd_rev ret_d.(share).
Proof.  
  intros.  unfold rsi_rtt_set_ripas_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: try rewrite lens_ignore_g_granules_update in H.
  all: simpl_walk_rev; auto.
  all: destruct_zmap; try auto.
  all: rewrite Heq in *; simpl in *; try lia.
Qed.

Lemma handle_rsi_realm_get_attest_token_spec_rd_rev:
  forall d v_0 v_1 ret_d
  (Hspec: handle_rsi_realm_get_attest_token_spec v_0 v_1 d = Some(ret_d))
  (Hinv: rd_rev d.(share)),
  rd_rev ret_d.(share).
Proof.  
  intros.  unfold handle_rsi_realm_get_attest_token_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
Qed.

Lemma handle_rsi_realm_extend_measurement_spec_rd_rev:
  forall d v_0 ret_n ret_d
  (Hspec: handle_rsi_realm_extend_measurement_spec v_0 d = Some(ret_n, ret_d))
  (Hinv: rd_rev d.(share)),
  rd_rev ret_d.(share).
Proof.  
  intros.  unfold handle_rsi_realm_extend_measurement_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
Qed.

Lemma rsi_data_create_unknown_s1_spec_rd_rev:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: rsi_data_create_unknown_s1_spec v_0 v_1 v_2 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.
  intros.  unfold rsi_data_create_unknown_s1_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: try rewrite lens_ignore_g_granules_update in H.
  all: try (destruct_zmap' H; simpl in *; [ try lia | repeat rewrite lens_ignore_g_granules_update in H ]).
  all: simpl_walk_rev; auto; try lia.
  all: destruct_zmap; try auto.
  all: try(rewrite Heq in *; simpl in *; try lia).
  all: try(rewrite Heq0 in *; simpl in *; try lia).
  all: repeat rewrite lens_ignore_g_granules_update in *; auto.
Qed.

