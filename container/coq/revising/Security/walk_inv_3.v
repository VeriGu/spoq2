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
Require Import SecurityProof.
(* Require Import SMCHandler.Spec. *)

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma rsi_data_create_unknown_s1_spec_walk_rev :
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: rsi_data_create_unknown_s1_spec v_0 v_1 v_2 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold rsi_data_create_unknown_s1_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
  all: partial_simpl_walk_rev_and_solve Hspec.
  all: inv Hspec.
  all: simpl_rtt_idx_all.
  all: try(
      unfold walk_rev; simpl in *; unfold walk_rev in Hinv; unfold GRANULE_STATE_RTT in *; destruct Hinv as [rev Hinv];  
      retrieve_idx; intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in * ).
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
  all: try (match goal with
    | [H: ?idx = meta_granule_offset (meta_PA (test_Z_PTE ?v)) / 4096 |- _]
      => remember idx as Hstate_idx
      (* ; assert (Hns_idx <> rtt_idx) as Hns_eq; *)
      (* [ unfold not; intros Hns_eq; rewrite Hns_eq in *; try rewrite ZMap.gss in Hrtt;  simpl in *; lia | rewrite ZMap.gso in Hrtt; simpl in *; [ | auto] ]  *)
    end).
  all: try rewrite strong_lens in *.
  all: simpl_rtt_idx_all.

 (* all: rewrite <- Heqnormidx in *. *)
  (* all: rewrite strong_lens in *. *)
  all: try rewrite test_PTE_Z_PTE_same in *.
  all: exists rev; intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt.
  all:
    try rewrite Heqnormidx in *;
    repeat match goal with
    | [H: ?gidx = poffset (e_2 ?r) / 4096 |- _] => rewrite -> H in *; clear H
    end;
    try match goal with
    | [H: context[poffset (e_2 ?r) / 4096] |- _] => remember (poffset (e_2 r) / 4096) as Hgp_idx; try rewrite <- Hgp_idx in *
    end.
  all: try( assert(Hstate_idx <> rtt_idx) as Heq_st_rtt; [
          unfold not; intros Heq_st_rtt; rewrite Heq_st_rtt in *; rewrite ZMap.gss in Hrtt; 
          simpl in *; lia | 
          rewrite ZMap.gso in Hrtt; simpl in Hrtt; [ | auto ];
          pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;
          pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv
          ] ).
  all: try (destruct Hinv as [Hinv_1 Hinv_2]; split; [ | auto ]).
  all: try( assert(Hstate_idx <> parent_idx) as Heq; [
          unfold not; intros Hseq; rewrite Hseq in *; try lia
          | rewrite ZMap.gso; simpl in *; [ auto | auto ] ] ).
  all: try(destruct (rtt_idx =? parent_idx) eqn:Heq_r_p; bool_rel;
    [
      rewrite Heq_r_p in *; rewrite ZMap.gss in Hrtt;  simpl in *; lia
    |
      rewrite ZMap.gso in Hrtt; [ repeat rewrite lens_ignore_g_granules_update in Hrtt;
      pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;
      pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
      destruct Hinv as [Hinv_1 Hinv_2]; 
      lia | auto ]
    ]).
  all: try(rewrite ZMap.gso in Hrtt; [ simpl in *; repeat rewrite lens_ignore_g_granules_update in Hrtt; lia | lia]).
  all: try( destruct (rtt_idx =? Hstate_idx) eqn:Heq_r_p; bool_rel;
          [ rewrite Heq_r_p in *; rewrite ZMap.gss in Hrtt;  simpl in *; lia
          | rewrite ZMap.gso in Hrtt; simpl in *; [ 
            repeat rewrite lens_ignore_g_granules_update in *
           | auto ]
          ] ).
  all: try(
      pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;
      pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
      destruct Hinv as [Hinv_1 Hinv_2]; 
      split; [ auto | ]).
  all: rewrite <- Heqnormidx in *.
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
Qed.
 