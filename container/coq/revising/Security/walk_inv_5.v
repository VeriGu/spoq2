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
(* Require Import SMCHandler.Spec. *)

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.


Lemma handle_rsi_realm_get_attest_token_spec_walk_rev :
  forall d v_0 v_1 ret_d
    (Hspec: handle_rsi_realm_get_attest_token_spec v_0 v_1 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold handle_rsi_realm_get_attest_token_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
Qed.


Lemma handle_rsi_realm_extend_measurement_spec_walk_rev :
  forall d v_0 ret_n ret_d
    (Hspec: handle_rsi_realm_extend_measurement_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold handle_rsi_realm_extend_measurement_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
Qed.

Lemma smc_rtt_read_entry_spec_walk_rev :
  forall d v_0 v_1 v_2 v_3 ret_d
    (Hspec: smc_rtt_read_entry_spec v_0 v_1 v_2 v_3 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold smc_rtt_read_entry_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
Qed.

Lemma rsi_data_destroy_spec_rd_rev:
  forall d v_0 v_1 ret_d ret_n
  (Hspec: rsi_data_destroy_spec v_0 v_1 d = Some(ret_n, ret_d))
  (Hinv: walk_rev d.(share)),
  walk_rev ret_d.(share).
Proof.   
  intros.  unfold rsi_data_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_walk_rev_and_solve Hspec.
  all: inv Hspec.
  all: simpl_rtt_idx_all.
  all: try(
      unfold walk_rev; simpl in *; unfold walk_rev in Hinv; unfold GRANULE_STATE_RTT in *; destruct Hinv as [rev Hinv];  
      retrieve_idx; intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt ).
  (* all: ( assert((meta_granule_offset (test_PA v_0) + 4) / 4096 = (meta_granule_offset (test_PA v_0)) / 4096) as Hoff; [ admit | rewrite -> Hoff in *; try rewrite <- Heqgidx in *; clear Hoff ]). *)
  all: try match goal with
       | [H: (meta_desc_type _ =? _) && _ && _ = true |- _] => simple_abs_tte_read H 
       end.
  all: repeat match goal with
    | [H: (_ =? 0) && _ = true |- _] => simpl_andb_true_iff H
    end.
  all: try match goal with 
    | [H: (meta_desc_type (abs_tte_read ?ptr ?d)) = 0 |- _] => assert( (meta_desc_type (abs_tte_read ptr d)) <> 3) as H_neq_3; [ rewrite H; lia | 
        pose proof (abs_tte_read_no_pa ptr d H_neq_3); simpl in *  ]
    end.
  all: simpl_rtt_idx_all.
  all:
    try rewrite Heqnormidx in *;
    repeat match goal with
    | [H: ?gidx = poffset (e_2 ?r) / 4096 |- _] => rewrite -> H in *; clear H
    end;
    match goal with
    | |- context[poffset (e_2 ?r) / 4096] => remember (poffset (e_2 r) / 4096) as Hgp_idx; try rewrite <- Hgp_idx in *
    end.
  all: rewrite <- Heqnormidx in *.
  all: rewrite strong_lens in *.
  all: try rewrite test_PTE_Z_PTE_same in *.
  all: exists rev; intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt.
  all: repeat rewrite lens_ignore_g_granules_update in *; repeat rewrite strong_lens in *.
  all: try (pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv).
  all: try (pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv).  
  all: try (destruct Hinv as [Hinv0 Hinv1]; split; simpl in *; [try auto | try auto]).
  all: try (rewrite lens_ignore_g_granules_update in *; destruct_zmap; simpl in *; [ 
    destruct_zmap; simpl in *; [ 
    rewrite abs_tte_read_sem in Heqgidx0; simpl in *;
    simpl_rtt_idx_all; rewrite -> Heq in *; rewrite -> Heq0 in *; 
    rewrite <- Heqnormidx in *; rewrite <- HeqHgp_idx in *;  
    rewrite -> Hinv1 in Heqgidx0; rewrite rtt_mul_div_4096_same_2 in Heqgidx0;
    rewrite Heqgidx0 in *; try lia
     (* rewrite <- HeqHgp_idx in *; rewrite <- Heqnormidx in * *)
    | rewrite Heq in *; try auto ]  | try auto]).
  all: destruct_zmap' Hrtt.
  all: try apply abs_tte_read_no_pa in H_neq_3.
  all: rewrite abs_tte_read_sem in *; simpl in *.
  all: simpl_rtt_idx_all.
  all: try(rewrite <- HeqHgp_idx in *; rewrite <- Heqnormidx in *).
  all: try lia.
  all: rewrite lens_ignore_g_granules_update in *.
  all: simpl_imply Hinv.
  all: try (pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv).  
  all: try (destruct Hinv as [Hinv0 Hinv1]; split; simpl in *; [try auto | try auto]).
  all: unfold s2tte_create_destroyed_abs in *.
  all: try (destruct ( (parent_idx =? Hgp_idx) && (offset =? normidx) ) eqn: Hidx;
        [ simpl in *;  apply Bool.andb_true_iff in Hidx;  
          destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *;
          repeat (simpl in *; rewrite ZMap.gss; simpl in *); lia | 
          rewrite Bool.andb_false_iff in Hidx; destruct Hidx; bool_rel; [ simpl in *; rewrite ZMap.gso; [easy | easy] 
          | simpl in *; destruct (parent_idx =? Hgp_idx) eqn: Hp; bool_rel; 
            [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]
            | rewrite ZMap.gso; [easy | easy] 
            ] 
          ]
        ] ). 
  all: try (destruct ( (parent_idx =? Hgp_idx) && (offset =? normidx) ) eqn: Hidx; [ simpl in *;  apply Bool.andb_true_iff in Hidx;  destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *; rewrite Hinv1 in * | ] ). 
  all: try rewrite rtt_mul_div_4096_same_2 in Heq; try lia.
  all: rewrite Bool.andb_false_iff in Hidx; destruct Hidx; bool_rel; simpl in *.
  all: retrieve_idx.
  all: try match goal with
       | |- context[(test_PTE_Z _)] => try(destruct (parent_idx =? Hgp_idx) eqn: Hidx2; bool_rel; simpl in *; 
       [ rewrite Hidx2 in *; rewrite ZMap.gss; simpl in *; rewrite ZMap.gso; simpl in *; auto | rewrite ZMap.gso; simpl in *; [ auto | auto ] ])
       end.
  all: rewrite ZMap.gso; simpl in *; repeat rewrite lens_ignore_g_granules_update in *; try auto.
  all: rewrite <- Heqgidx0 in *. 
  all: unfold not; intros Heq3; rewrite Heq3 in *; simpl in *; try lia.
Qed.
