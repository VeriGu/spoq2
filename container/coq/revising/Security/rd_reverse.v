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


Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Parameter test_Z_Ptr : (Z -> (Ptr)).

Lemma test_Z_Ptr_Z_same:
  forall a, test_Z_Ptr (test_Ptr_Z a) = a.
Admitted.

Lemma test_Ptr_Z_Ptr_same:
  forall a, test_Ptr_Z (test_Z_Ptr a) = a.
Admitted.


Lemma rtt_idx_compute_3 :
  forall a b, (0 <= b < 4096) ->
      (meta_granule_offset (test_PA a) + b) / 4096 = (meta_granule_offset (test_PA a)) / 4096.
Admitted.

Lemma rtt_idx_compute_4 :
  forall a b, (0 <= b < 4096) ->
      (meta_granule_offset (test_PA a) + b) mod 4096 = b.
Admitted.

Ltac simpl_rtt_idx_all_2 :=
  try rewrite rtt_idx_compute_1 in *; try rewrite rtt_idx_compute_2 in *;
  try (rewrite rtt_idx_compute_3 in *; [ | lia]);
  try (rewrite rtt_idx_compute_4 in *; [ | lia]).


Definition rd_rev (sh: Shared) : Prop :=
  exists (rev: Z -> (Z)),
  forall rd_idx rtt_idx
    (Hrd: (sh.(globals).(g_granules) @ rd_idx).(e_state_s_granule) = GRANULE_STATE_RD)
    (Hrtt: (test_Z_Ptr (sh.(granule_data) @ rd_idx).(g_norm) @ 32).(poffset) / 4096 = rtt_idx),
    (* (Hrtt_state: (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT) *)
    (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT
    /\
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
       (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT 
       -> (ret_sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT
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
      (* apply Ha in H3. *)
      pose proof (Hinv rd_idx rtt_idx) as H2.
      rewrite <- Hrd1 in Hrtt.
      repeat simpl_imply H2. 
      destruct H2 as [H20 H21]; split; auto.
    - pose proof (Hrd_ret rd_idx) as H.  
      apply H in Hrd.     
      destruct Hrd as [Hrd Hrd1].
      pose proof (Hrtt_ret rtt_idx) as H3.
      pose proof (Hinv rd_idx rtt_idx) as H2.
      rewrite <- Hrd1 in Hrtt.
      repeat simpl_imply H2.
      destruct H2 as [H20 H21]; split; auto.
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
    + simpl in *; rewrite H3 in *. simpl in *. (* rewrite ZMap.gss in H. *)
      assert(gidx <> rtt_idx); [ unfold not; intros Hneq; rewrite Hneq in *; lia |  ].
      rewrite ZMap.gso; [ simpl in *; lia | auto ].
    + rewrite ZMap.gso; simpl in *; [ | auto].
      destruct (gidx =? rtt_idx) eqn: H2; bool_rel.
      * rewrite H2 in *.  simpl in *; lia.
      * rewrite ZMap.gso in *; [ simpl in *; auto | unfold not; intros Hb; rewrite Hb in *; lia].
      *unfold not. intros Hb. rewrite Hb in *. lia.
Qed.

Lemma smc_realm_activate_spec_rd_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_realm_activate_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_realm_activate_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: partial_simpl_rd_rev_and_solve Hspec.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: repeat rewrite strong_lens in *; intros; inv Hspec; simpl in *.
  all: try(simpl in *; retrieve_idx; split; [ try auto | try auto]).
  all: simpl_walk_rev; try auto.
  all: destruct (gidx =? rd_idx) eqn: Hp_idx; bool_rel;
      [ rewrite Hp_idx in *; rewrite ZMap.gss; simpl in *;
        assert (normidx <> 32) as Hn_idx;
        [ unfold not; intros Hn_idx; rewrite Hn_idx in *; try lia |
          rewrite ZMap.gso in *; simpl in *; [ try auto | try auto ]
        ]
        | 
        rewrite ZMap.gso; simpl in *; [ try auto | try auto] ].
Qed.

Lemma smc_granule_delegate_spec_rd_rev:
  forall d v_0 v_1 ret_n ret_d
    (Hspec: smc_granule_delegate_spec v_0 v_1 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_granule_delegate_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: partial_simpl_rd_rev_and_solve Hspec.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: repeat rewrite strong_lens in *; intros; inv Hspec; simpl in *.
  all: simpl_rtt_idx_all_2.
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: simpl_walk_rev; try auto.
  all: match goal with
       | |- e_state_s_granule (_ @ ?idx) = _ => remember idx as Htidx
       end.
  all: try(destruct (gidx =? Htidx) eqn: Hp_idx; bool_rel;
         [ rewrite Hp_idx in *; try rewrite ZMap.gss in H; simpl in *; try lia 
         | rewrite ZMap.gso in *; simpl in *; [ auto | auto ] ]).
Qed.


Lemma smc_granule_undelegate_spec_rd_rev:
  forall d v_0 v_1 ret_n ret_d
    (Hspec: smc_granule_undelegate_spec v_0 v_1 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_granule_undelegate_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: repeat rewrite strong_lens in *; intros; inv Hspec; simpl in *.
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: simpl_walk_rev; try auto.
  all: match goal with
       | |- e_state_s_granule (_ @ ?idx) = _ => remember idx as Htidx
       end;
        destruct (gidx =? Htidx) eqn: Hp_idx; bool_rel;
        [ rewrite Hp_idx in *; rewrite ZMap.gss in *; simpl in *;
          try lia
          | rewrite ZMap.gso in *; simpl in *; [ try auto | try auto] ].
Qed.

Lemma smc_system_interface_version_spec_rd_rev:
  forall d ret_n ret_d
    (Hspec: smc_system_interface_version_spec d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_system_interface_version_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
Qed.
    
Lemma smc_read_feature_register_spec_rd_rev:
  forall d v_0 v_1 ret_d
    (Hspec: smc_read_feature_register_spec v_0 v_1 d = Some(ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_read_feature_register_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
Qed.

Ltac retrieve_norm_idx := 
  match goal with
  | [H: context[(g_norm _) # (?app ?idx) == _] |- _] =>
      let gidx := fresh "normidx" in 
      (* let name := fresh "Heqgidx" in  *)
        remember (app idx) as gidx
         (* eqn: name; rewrite <- name in * *)
  end.

Lemma rsi_data_map_extra_spec_rd_rev:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: rsi_data_map_extra_spec v_0 v_1 v_2 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold rsi_data_map_extra_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: simpl_walk_rev; try auto.
  all: try match goal with
       | |- context[_ (_ @ ?idx) = _] => remember idx as Htidx
       | |- context[(_ (_ @ ?idx)) @ 32 = _] => remember idx as Htidx
       end.
  all: repeat rewrite lens_ignore_g_granules_update in *; try auto.
  all: destruct (gidx =? Htidx) eqn: Hp_idx; bool_rel;
      [ rewrite Hp_idx in *; rewrite ZMap.gss; simpl in *;
        assert (normidx <> 32) as Hn_idx;
        [ unfold not; intros Hn_idx; rewrite Hn_idx in *; try lia |
          rewrite ZMap.gso in *; simpl in *; [ try auto | try auto ]
        ]
        | 
        rewrite ZMap.gso; simpl in *; [ try auto | try auto] ].
Qed.
(* 
Lemma smc_realm_create_spec_rd_rev:
  forall d v_0 v_1 ret_n ret_d
    (Hspec: smc_realm_create_spec v_0 v_1 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_realm_create_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: simpl_rtt_idx_all_2. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: simpl_walk_rev; try auto.
  all: try match goal with
       | |- context[_ (_ @ ?idx) = _] => remember idx as Htidx
       | |- context[(_ (_ @ ?idx)) @ 32 = _] => remember idx as Htidx
       end.
  all: try match goal with
       | [H: e_state_s_granule (g_granules (globals (share _))) @ ?rd_idx = 2 |- _]
          => remember rd_idx as Hrd_idx
       end.
  all: repeat rewrite lens_ignore_g_granules_update in *; try auto.
  - destruct (gidx0 =? Htidx) eqn: Hp_idx; bool_rel.
    * rewrite Hp_idx in *. rewrite ZMap.gss in H; simpl in *.
       
  all: destruct (gidx =? Htidx) eqn: Hp_idx; bool_rel;
      [ rewrite Hp_idx in *; rewrite ZMap.gss; simpl in *;
        assert (normidx <> 32) as Hn_idx;
        [ unfold not; intros Hn_idx; rewrite Hn_idx in *; try lia |
          rewrite ZMap.gso in *; simpl in *; [ try auto | try auto ]
        ]
        | 
        rewrite ZMap.gso; simpl in *; [ try auto | try auto] ].
Qed. *)