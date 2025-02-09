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

Lemma test_PTE_Z_PTE_same:
  (forall a, (test_PTE_Z (test_Z_PTE a)) = a).
Admitted.

Lemma map_unmap_uart0:
( forall p s (Huart: uart0_phys_para (abs_tte_read p s) = true), 
              e_state_s_granule (g_granules (globals (share s))) @ ((meta_granule_offset (meta_PA (abs_tte_read p s))) / 4096) = 6
            ).
Admitted.

Lemma rtt_mul_div_4096_same_2 :
  (forall a, a * 4096 / 4096 = a).
Admitted.

Lemma block_is_not_rtt :
  (forall v ptr st, 
          ((v <>? 3) && ((meta_desc_type (abs_tte_read ptr st)) =? 1) = true)
           -> e_state_s_granule (g_granules (globals (share st))) @ 
          ((meta_granule_offset (meta_PA (abs_tte_read ptr st))) / 4096) <> 5).
Admitted.

Lemma page_is_not_rtt:
(forall v ptr st, 
       ((v =? 3) && ((meta_desc_type (abs_tte_read ptr st)) =? 3) = true)
        -> e_state_s_granule (g_granules (globals (share st))) @ 
       ((meta_granule_offset (meta_PA (abs_tte_read ptr st))) / 4096) <> 5).
Admitted.


Ltac simpl_rtt_idx_all :=
  try rewrite rtt_idx_compute_1 in *; try rewrite rtt_idx_compute_2 in *.

Lemma map_unmap_ns_s1_spec_walk_rev :
  forall d v_0 v_1 v_2 v_3 v_4 ret_n ret_d
    (Hspec: map_unmap_ns_s1_spec v_0 v_1 v_2 v_3 v_4 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold map_unmap_ns_s1_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_walk_rev_and_solve Hspec.
  all: partial_simpl_walk_rev_and_solve Hspec.
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
  all: try (match goal with
    | [H: e_state_s_granule (g_granules (globals (share ?st))) @ ?idx = 0 |- _]
      => remember idx as Hns_idx; assert (Hns_idx <> rtt_idx) as Hns_eq;
      [ unfold not; intros Hns_eq; rewrite Hns_eq in *; try rewrite ZMap.gss in Hrtt;  simpl in *; lia | rewrite ZMap.gso in Hrtt; simpl in *; [ | auto] ] 
    end).
  all: try(match goal with
      | [H: uart0_phys_para (abs_tte_read ?ptr ?st) = true |- _] =>
            pose proof map_unmap_uart0 as Huart0; pose proof (Huart0 ptr st) as Huart0; repeat simpl_imply Huart0; rewrite abs_tte_read_sem in Huart0; simpl in *; simpl_rtt_idx_all
      end).
  all: try(
        match goal with
        | [H: ?idx = meta_granule_offset (meta_PA (abs_tte_read ?ptr ?d)) / 4096 |- _] => 
        rewrite -> H in *; clear H
        end; retrieve_idx;
        match goal with
        | [H: ?idx = meta_granule_offset (meta_PA (abs_tte_read ?ptr ?d)) / 4096 |- _] => 
        remember idx as Hunmap_idx;
        remember H as Hunmap_idx_eq;
          match goal with 
          | [H: ?idx = Hunmap_idx |- _] => rewrite -> H in *; clear H
          end;
        assert (Hunmap_idx <> rtt_idx) as Hun_eq;
        [ unfold not; intros Hun_eq; rewrite Hun_eq in *; try rewrite ZMap.gss in Hrtt; simpl in *; lia | 
        rewrite ZMap.gso in Hrtt; simpl in *; [ | auto] ]
        end
      ). 
  all: try (pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv).
  all: try (pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv).  
  all: try (destruct Hinv as [Hinv_1 Hinv_2]; split; [ repeat rewrite lens_ignore_g_granules_update; try exact Hinv_1 | ]).
  all: try (match goal with
     | [H: e_state_s_granule (g_granules (globals (share ?st))) @ ?idx = 0 |- _]
       => assert (idx <> parent_idx) as Hns_eq_p; 
       [ unfold not; intros Hns_eq_p; rewrite Hns_eq_p in *; try lia | ]
     end). 
  all: try (match goal with
     | [H: e_state_s_granule (g_granules (globals (share ?st))) @ ?idx - 6 = 0 |- _]
       => assert (idx <> parent_idx) as Hns_eq_p; 
       [ unfold not; intros Hns_eq_p; rewrite Hns_eq_p in *; try lia | ]
  end). 
  all: try ( match goal with
        | |- context[ update_s_granule_e_state_s_granule _ 6 ] => rewrite ZMap.gso; try auto
        | |- context[ update_s_granule_e_state_s_granule _ 0 ] => rewrite ZMap.gso; try auto
       end).
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
  all: try(simpl in Huart0; simpl_rtt_idx_all; rewrite <- HeqHgp_idx in *; rewrite <- Heqnormidx in * ).
  all: try(destruct ( (parent_idx =? Hgp_idx) && (offset =? normidx) ) eqn: Hidx;
        [ simpl in *;  apply Bool.andb_true_iff in Hidx;  
          destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *;
          repeat (simpl in *; rewrite ZMap.gss; simpl in *);
          (rewrite -> Hinv_2 in Huart0; pose proof rtt_mul_div_4096_same_2 as H_md; 
           rewrite H_md in Huart0; rewrite Huart0 in *; lia)
            |rewrite Bool.andb_false_iff in Hidx; destruct Hidx; bool_rel; 
            [ simpl in *; rewrite ZMap.gso; [easy | easy] 
            | simpl in *; destruct (parent_idx =? Hgp_idx) eqn: Hp; bool_rel; 
              [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]
              | rewrite ZMap.gso; [easy | easy] 
              ] 
            ]
          ]).
  all: pose proof block_is_not_rtt as Heq2.
  all: try(match goal with
       | [H: context[(meta_desc_type (abs_tte_read ?ptr ?st) =? _)] |- _] => 
          pose proof (Heq2 v_2 ptr st) as Heq2; repeat simpl_imply Heq2; rewrite abs_tte_read_sem in Heq2
       end).
  all: try(simpl in Heq2; simpl_rtt_idx_all; rewrite <- HeqHgp_idx in *; rewrite <- Heqnormidx in * ).
  all: try(
       destruct ( (parent_idx =? Hgp_idx) && (offset =? normidx) ) eqn: Hidx;
       [  simpl in *;  apply Bool.andb_true_iff in Hidx;  
          destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *;
          repeat (simpl in *; rewrite ZMap.gss; simpl in *);
          rewrite -> Hinv_2 in Heq2;  pose proof rtt_mul_div_4096_same_2 as H_md; 
          rewrite H_md in Heq2; lia  |
          rewrite Bool.andb_false_iff in Hidx; destruct Hidx; bool_rel; 
          [ simpl in *; rewrite ZMap.gso; [easy | easy] 
          | simpl in *; destruct (parent_idx =? Hgp_idx) eqn: Hp; bool_rel; 
            [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]
            | rewrite ZMap.gso; [easy | easy] 
            ] 
          ]
       ]).
  all: pose proof page_is_not_rtt as Heq.
  all: try(match goal with
      | [H: context[(meta_desc_type (abs_tte_read ?ptr ?st) =? _)] |- _] => 
         pose proof (Heq v_2 ptr st) as Heq; repeat simpl_imply Heq; rewrite abs_tte_read_sem in Heq
      end).
  all: try(simpl in Heq; simpl_rtt_idx_all; rewrite <- HeqHgp_idx in *; rewrite <- Heqnormidx in * ).
  all: try(
      destruct ( (parent_idx =? Hgp_idx) && (offset =? normidx) ) eqn: Hidx;
      [  simpl in *;  apply Bool.andb_true_iff in Hidx;  
         destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *;
         repeat (simpl in *; rewrite ZMap.gss; simpl in *);
         rewrite -> Hinv_2 in Heq; pose proof rtt_mul_div_4096_same_2 as H_md;
         rewrite H_md in Heq; lia |
         rewrite Bool.andb_false_iff in Hidx; destruct Hidx; bool_rel; 
         [ simpl in *; rewrite ZMap.gso; [easy | easy] 
         | simpl in *; destruct (parent_idx =? Hgp_idx) eqn: Hp; bool_rel; 
           [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]
           | rewrite ZMap.gso; [easy | easy] 
           ] 
         ]
      ]).
Qed.