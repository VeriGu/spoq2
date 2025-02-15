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
(* Require Import SMCHandler.Spec. *)

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma smc_rc_rtt_read_entry_spec_walk_rev :
  forall d v_0 v_1 v_2 v_3 ret_d
    (Hspec: smc_rc_rtt_read_entry_spec v_0 v_1 v_2 v_3 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold smc_rc_rtt_read_entry_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
Qed.

Lemma smc_rec_enter_spec_walk_rev:
  forall d v_0 v_1 v_2 v_3 ret_d
    (Hspec: smc_rec_enter_spec v_0 v_1 v_2 v_3 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof. 
  intros. unfold smc_rec_enter_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
  all: simpl in *.
  all: simpl_rtt_idx_all_2.
  all: partial_simpl_walk_rev_and_solve Hspec.
  all: inv Hspec.
  all: simpl_rtt_idx_all_2.
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
  all: simpl_rtt_idx_all_2.
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
  all: try(
    pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;
    pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
    destruct Hinv as [Hinv_1 Hinv_2]; 
    split; [ auto | ]).
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
  - destruct_zmap; simpl in *.
    + rewrite Heqgidx in *; rewrite Heq in *; try lia.
    + destruct_zmap; simpl in *.
      * rewrite Heqgidx0  in *; rewrite Heq0 in *; try lia.
      * auto.
  - destruct_zmap; simpl in *.
      * rewrite Heqgidx0 in *; rewrite Heqgidx in *; rewrite Heq in *; try lia.
      * auto.
Qed.


 Lemma total_root_rtt_refcount_para_zero:
  forall d idx off rtt_idx
    (Href: total_root_rtt_refcount_para
     (g_norm (granule_data (share d)) @ idx) @ 32
     (g_norm (granule_data (share d)) @ idx) @ 24
     d = 0)
    (Hidx_rd: e_state_s_granule (g_granules (globals (share d))) @ idx = GRANULE_STATE_RD)
    (Hidx_rtt: e_state_s_granule (g_granules (globals (share d))) @ (poffset (test_Z_Ptr (g_norm (granule_data (share d)) @ idx) @ 32) / 4096) = GRANULE_STATE_RTT)
    (Hg_rtt: 0 <= rtt_idx < NR_GRANULES)
     ,
    (meta_granule_offset (meta_PA (test_Z_PTE ((g_norm (granule_data (share d)) @ (poffset (test_Z_Ptr (g_norm (granule_data (share d)) @ idx) @ 32) / 4096)) @ off )))) <> rtt_idx * 4096.
Admitted.

    

    

  
Lemma smc_realm_destroy_spec_walk_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_realm_destroy_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.   
  intros. unfold smc_realm_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
  all: simpl in *.
  all: simpl_rtt_idx_all_2.
  all: partial_simpl_walk_rev_and_solve Hspec.
  all: inv Hspec.
  all: simpl_rtt_idx_all_2.
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
  all: simpl_rtt_idx_all_2.
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
  all: try(
    pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;
    pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
    destruct Hinv as [Hinv_1 Hinv_2]; 
    split; [ auto | ]).
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
  all: split; try auto.
  all: destruct_zmap' Hrtt; simpl in *; try auto; try lia.
  all: try(destruct_zmap' Hrtt; simpl in *; try auto; try lia).
  all: try(
    pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;
    pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
    destruct Hinv as [Hinv_1 Hinv_2]; try auto ).
  all: simpl in *.
  all: rewrite Heqgidx in *; try rewrite Heqgidx1 in *.
  all: try rewrite <- Heqgidx0 in *; try rewrite <- Heqgidx in *; try rewrite Heqgidx1 in *.
  all: destruct_zmap; simpl in *; try auto; 
      try(rewrite Heq0 in *; simpl in *; try lia); try(rewrite Heq1 in *; simpl in *; try lia);  destruct_zmap; simpl in *; try auto; try(rewrite Heq1 in *; simpl in *; try lia); 
       try(rewrite Heq2 in *; simpl in *; try lia).
  all: rewrite Z.sub_move_r in C1; ring_simplify in C1.
  all: rewrite -> Heqgidx in *.
  all: pose proof total_root_rtt_refcount_para_zero as Ha; pose proof (Ha d gidx0 offset rtt_idx) as Hb; repeat simpl_imply Hb.
  all: simpl_walk_rev.
  all: rewrite Z.sub_move_r in C8; ring_simplify in C8.
  all: repeat simpl_imply Hb; clear Ha.
  all: rewrite Hinv_2 in Hb; try lia.
Qed.
  