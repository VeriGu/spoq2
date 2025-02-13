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
Require Import SecurityProof.


Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

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

Ltac retrieve_idx_2 :=
  repeat match goal with
  | [H: context[(g_granules _) @ (?app ?idx)] |- _ ]  =>
      let gidx := fresh "gidx" in remember (app idx) as gidx
  end.
 
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
  - intros; inv Hspec.  unfold rd_rev in *.
    repeat match goal with
    | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
      => rewrite rtt_idx_compute_4 with z v; [ |lia]
    end.
    repeat match goal with
    | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
      => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
    end.
    simpl in *.
    simpl_rtt_idx_all_2. 
    repeat match goal with
        | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
          let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
        end.
    try(simpl in *; retrieve_idx).
    destruct Hinv as [rev Hinv]; clear Hinv2.
    pose (rev_ans := fun idx => if (idx =? gidx0) then (gidx) else rev idx); exists rev_ans.
    intros.  destruct(gidx0 =? rd_idx) eqn:Heq; bool_rel; simpl in *.
      * rewrite Heq in *. assert(gidx <> rd_idx) as Heq_rd.
        { unfold not; intros Heq_rd; rewrite Heq_rd in *. rewrite ZMap.gss in C12.
          simpl in *; try lia. }
        { rewrite ZMap.gso in Hrd. rewrite ZMap.gss in Hrd. unfold GRANULE_STATE_RD in *.
          simpl in Hrd; try lia. try auto. }
      * split.
        + destruct (gidx =? rd_idx) eqn:Heq_rd; bool_rel; simpl in *.
          { rewrite Heq_rd in *. rewrite ZMap.gss in Hrtt.
            simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
            simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
            simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
            simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
            simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
            simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
            simpl in Hrtt. rewrite ZMap.gss in Hrtt.
            rewrite test_Z_Ptr_Z_same in Hrtt. simpl in Hrtt.
            rewrite <- Heqgidx0 in *.
            rewrite -> Hrtt in *. 
            rewrite ZMap.gso; [ | try auto ].
            rewrite ZMap.gss. simpl in *. unfold GRANULE_STATE_RTT in *. try auto.
          }
          { simpl in *. rewrite ZMap.gso in Hrtt; [ | try auto ].
            rewrite ZMap.gso in Hrd; [ | try auto].
            rewrite ZMap.gso in Hrd; [ | try auto].
            pose proof (Hinv rd_idx rtt_idx) as Hinv.
            repeat simpl_imply Hinv.
            destruct Hinv as [Hinv0 Hinv1].
            simpl_walk_rev.
            clear C13; clear e.
            rewrite ZMap.gso in C12; [ | unfold not; intros Heq_idx0; rewrite Heq_idx0 in *; simpl in *; rewrite ZMap.gss in C12; simpl in *; try lia ].
            destruct (gidx =? rtt_idx) eqn: Heq_rtt; bool_rel; simpl in *;
            [ rewrite Heq_rtt in *; simpl in *; try lia | ].
            rewrite ZMap.gso; [ | try auto].
            rewrite ZMap.gso; [ | unfold not; intros Heq1; rewrite Heq1 in *; simpl in *; try lia ].
            auto.
         }
        + destruct (gidx =? rd_idx) eqn:Heq_rd; bool_rel; simpl in *.
        { rewrite Heq_rd in *. rewrite ZMap.gss in Hrtt.
          simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
          simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
          simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
          simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
          simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
          simpl in Hrtt. rewrite ZMap.gso in Hrtt; [ | try lia].
          simpl in Hrtt. rewrite ZMap.gss in Hrtt.
          rewrite test_Z_Ptr_Z_same in Hrtt. simpl in Hrtt.
          rewrite <- Heqgidx0 in *.
          rewrite -> Hrtt in *. 
          unfold rev_ans in *. 
          destruct (rtt_idx =? gidx0) eqn: cond; bool_rel.
          auto. lia.
        }
        { simpl in *. rewrite ZMap.gso in Hrtt; [ | try auto ].
          rewrite ZMap.gso in Hrd; [ | try auto].
          rewrite ZMap.gso in Hrd; [ | try auto].
          pose proof (Hinv rd_idx rtt_idx) as Hinv.
          repeat simpl_imply Hinv.
          destruct Hinv as [Hinv0 Hinv1].
          simpl_walk_rev.
          unfold rev_ans in *.
          destruct (rtt_idx =? gidx0) eqn: cond; bool_rel.
          rewrite cond in *; try lia.
          auto.
         }
  -
     intros; inv Hspec.
     unfold rd_rev in *.
     repeat match goal with
    | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
      => rewrite rtt_idx_compute_4 with z v; [ |lia]
    end.
    repeat match goal with
    | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
      => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
    end.
       simpl in *.
      simpl_rtt_idx_all_2. 
       repeat match goal with     | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>       let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx      end.
      try(simpl in *; retrieve_idx).
      destruct Hinv as [rev Hinv]; clear Hinv2.
      exists rev; intros. 
      assert(gidx <> rd_idx) as Heq; [ 
      unfold not; intros Heq; rewrite Heq in *; rewrite ZMap.gss in Hrd; simpl in *; 
      unfold GRANULE_STATE_RD in *; try lia | ].
      rewrite ZMap.gso in Hrd; simpl in *; [ | try auto].
      rewrite ZMap.gso in Hrd; [ | try auto].
      pose proof (Hinv rd_idx rtt_idx) as Hinv; repeat simpl_imply Hinv; destruct Hinv as [Hinv0 Hinv1]; try auto.
      split; [ 
          assert (rtt_idx <> gidx) as Heq2; 
          [ unfold not; intros Heq2; rewrite Heq2 in *; unfold GRANULE_STATE_RTT in *; try lia| rewrite ZMap.gso; simpl in *; [ auto | auto] ]
          | auto ].
      rewrite ZMap.gso; [ auto | auto ].
  - apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all:  intros; inv Hspec. 
  all: repeat match goal with
        | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
      => rewrite rtt_idx_compute_4 with z v; [ |lia]
    end.
  all:  repeat match goal with
    | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
      => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
    end.
  all:  simpl in *.
  all: simpl_rtt_idx_all_2. 
  all:  repeat match goal with
        | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
          let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
        end.
  all: try(simpl in *; retrieve_idx).
  all: try (assert( gidx <> gidx0 ) as Heq_0; 
        [ unfold not; intros Heq_0; rewrite Heq_0 in *; rewrite ZMap.gss in *; simpl in *; try lia |  ]).
  (* all: try(destruct (gidx =? rtt_idx) eqn:Heq; bool_rel; simpl in *; *)
        (* [ try rewrite Heq in *; rewrite ZMap.gss; simpl in *; try auto |  *)
          (* rewrite ZMap.gso; [ try auto | try auto ] *)
        (* ]). *)
  all: try( split; [ | try auto ]).
  all: try( destruct (rd_idx =? gidx) eqn: Heq; bool_rel; simpl in *;
    [ rewrite Heq in *; rewrite ZMap.gss in H; unfold GRANULE_STATE_RD in *; simpl in *; try lia |
      rewrite ZMap.gso in H; simpl in *; [ try auto | try auto] ]).
  all: try (rewrite ZMap.gso in H; simpl in *; [ try auto | try auto ]).
  all: simpl_walk_rev; assert (rtt_idx <> gidx) as Hrtt; simpl in *; [ unfold not; intros Hrtt; rewrite Hrtt in *; try lia |  
       rewrite ZMap.gso; simpl in *; [ try auto | try auto ] ].
  all: rewrite ZMap.gso; simpl in *; [ try auto | try auto ].
   - apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all:  intros; inv Hspec. 
  all: repeat match goal with
        | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
      => rewrite rtt_idx_compute_4 with z v; [ |lia]
    end.
  all:  repeat match goal with
    | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
      => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
    end.
  all:  simpl in *.
  all: simpl_rtt_idx_all_2. 
  all:  repeat match goal with
        | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
          let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
        end.
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ | try auto ]).
  all: try( destruct (rd_idx =? gidx) eqn: Heq; bool_rel; simpl in *;
    [ rewrite Heq in *; rewrite ZMap.gss in H; unfold GRANULE_STATE_RD in *; simpl in *; try lia |
      rewrite ZMap.gso in H; simpl in *; [ try auto | try auto] ]).
  all: try (rewrite ZMap.gso in H; simpl in *; [ try auto | try auto ]).
  all: simpl_walk_rev; assert (rtt_idx <> gidx0) as Hrtt; simpl in *; [ unfold not; intros Hrtt; rewrite Hrtt in *; try lia |  
       rewrite ZMap.gso; simpl in *; [ try auto | try auto ] ].
  -     apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
       all:  intros; inv Hspec. 
       all: repeat match goal with
             | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
           => rewrite rtt_idx_compute_4 with z v; [ |lia]
         end.
       all:  repeat match goal with
         | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
           => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
         end.
       all:  simpl in *.
       all: simpl_rtt_idx_all_2. 
       all:  repeat match goal with
             | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
               let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
             end.
       all: try(simpl in *; retrieve_idx).
       all: try( split; [ | try auto ]).
       all: try( destruct (rd_idx =? gidx) eqn: Heq; bool_rel; simpl in *;
         [ rewrite Heq in *; rewrite ZMap.gss in H; unfold GRANULE_STATE_RD in *; simpl in *; try lia |
           rewrite ZMap.gso in H; simpl in *; [ try auto | try auto] ]).
       all: try (rewrite ZMap.gso in H; simpl in *; [ try auto | try auto ]).
       all: simpl_walk_rev; assert (rtt_idx <> gidx) as Hrtt; simpl in *; [ unfold not; intros Hrtt; rewrite Hrtt in *; try lia |  
            rewrite ZMap.gso; simpl in *; [ try auto | try auto ] ].
       all: rewrite ZMap.gso; simpl in *; [ try auto | try auto ].
       - apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
       all:  intros; inv Hspec. 
       all: repeat match goal with
             | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
           => rewrite rtt_idx_compute_4 with z v; [ |lia]
         end.
       all:  repeat match goal with
         | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
           => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
         end.
       all:  simpl in *.
       all: simpl_rtt_idx_all_2. 
       all:  repeat match goal with
             | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
               let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
             end.
       all: try(simpl in *; retrieve_idx).
       all: try (assert( gidx <> gidx0 ) as Heq_0; 
             [ unfold not; intros Heq_0; rewrite Heq_0 in *; rewrite ZMap.gss in *; simpl in *; try lia |  ]).
       (* all: try(destruct (gidx =? rtt_idx) eqn:Heq; bool_rel; simpl in *; *)
             (* [ try rewrite Heq in *; rewrite ZMap.gss; simpl in *; try auto |  *)
               (* rewrite ZMap.gso; [ try auto | try auto ] *)
             (* ]). *)
       all: try( split; [ | try auto ]).
       all: try( destruct (rd_idx =? gidx) eqn: Heq; bool_rel; simpl in *;
         [ rewrite Heq in *; rewrite ZMap.gss in H; unfold GRANULE_STATE_RD in *; simpl in *; try lia |
           rewrite ZMap.gso in H; simpl in *; [ try auto | try auto] ]).
       all: try (rewrite ZMap.gso in H; simpl in *; [ try auto | try auto ]).
       all: simpl_walk_rev; assert (rtt_idx <> gidx) as Hrtt; simpl in *; [ unfold not; intros Hrtt; rewrite Hrtt in *; try lia |  
            rewrite ZMap.gso; simpl in *; [ try auto | try auto ] ].
       all: rewrite ZMap.gso; simpl in *; [ try auto | try auto ].
        - apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
       all:  intros; inv Hspec. 
       all: repeat match goal with
             | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
           => rewrite rtt_idx_compute_4 with z v; [ |lia]
         end.
       all:  repeat match goal with
         | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
           => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
         end.
       all:  simpl in *.
       all: simpl_rtt_idx_all_2. 
       all:  repeat match goal with
             | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
               let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
             end.
       all: try(simpl in *; retrieve_idx).
       all: try( split; [ | try auto ]).
       all: try( destruct (rd_idx =? gidx) eqn: Heq; bool_rel; simpl in *;
         [ rewrite Heq in *; rewrite ZMap.gss in H; unfold GRANULE_STATE_RD in *; simpl in *; try lia |
           rewrite ZMap.gso in H; simpl in *; [ try auto | try auto] ]).
       all: try (rewrite ZMap.gso in H; simpl in *; [ try auto | try auto ]).
       all: simpl_walk_rev; assert (rtt_idx <> gidx0) as Hrtt; simpl in *; [ unfold not; intros Hrtt; rewrite Hrtt in *; try lia |  
            rewrite ZMap.gso; simpl in *; [ try auto | try auto ] ].
Qed.
   

Local Opaque vmid_free_spec.
Local Opaque memset_spec.


Lemma smc_realm_destroy_spec_rd_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_realm_destroy_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.   
  intros.  unfold smc_realm_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat let H := Hspec in
  let cond := fresh "C" in
  match type of H with
  | context[if ?x then _ else _] => destruct (x) eqn:cond; contra;  repeat simpl_hyp cond
  | context[match ?x with | Some _ => _ | None => None end] => destruct (x) eqn:cond; contra;  repeat simpl_hyp cond
  | context[match ?x with | _ => _  end] => destruct (x) eqn:cond; contra; repeat simpl_hyp cond
  | _ => idtac
  end.
  all: try intros_ensure_state; partial_simpl_rd_rev_and_solve Hspec.
  all: repeat rewrite strong_lens in *; intros.
  all: intros; inv Hspec.
  all: simpl in *.
  - unfold rd_rev in *.
    repeat match goal with
    | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
      => rewrite rtt_idx_compute_4 with z v; [ |lia]
    end.
    repeat match goal with
    | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
      => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
    end.
    simpl in *.
    simpl_rtt_idx_all_2. 
    repeat match goal with
        | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
          let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
        end.
    try(simpl in *; retrieve_idx).
    destruct Hinv as [rev Hinv].
    (* pose (rev_ans := fun idx => if (idx =? gidx0) then (gidx) else rev idx); exists rev_ans. *)
    exists rev.
    intros.  
    destruct_zmap' Hrd.
    + simpl in Hrd. unfold GRANULE_STATE_RD in *. try lia.
    + destruct_zmap' Hrd.
      { simpl in Hrd; unfold GRANULE_STATE_RD in *; try lia. }
      { pose proof Hinv as Hinv2.
        pose proof (Hinv rd_idx rtt_idx) as Hinv.
        repeat simpl_imply Hinv.
        destruct Hinv as [Hinv0 Hinv1].
        split; [ | auto ].
        destruct_zmap.
        { rewrite Heq1 in *. unfold GRANULE_STATE_RTT in *; try lia. }
        { destruct_zmap; [ | try auto ].
          rewrite Heq2 in *.
          rewrite rtt_idx_compute_3 in Heqgidx0.
          rewrite <- Heqgidx in *.
          pose proof (Hinv2 gidx gidx0) as Hinv_r.
          unfold GRANULE_STATE_RD in *.
          apply Z.sub_move_r in C1. ring_simplify in C1.
          repeat simpl_imply Hinv_r.
          apply eq_sym in Heqgidx0.
          repeat simpl_imply Hinv_r.
          destruct Hinv_r as [Hinv_r0 Hinv_r1].
          try lia.
          try lia.
        }
      }
      - unfold rd_rev in *. unfold rd_rev in *.
      repeat match goal with
      | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
        => rewrite rtt_idx_compute_4 with z v; [ |lia]
      end.
      repeat match goal with
      | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
        => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
      end.
      simpl in *.
      simpl_rtt_idx_all_2. 
      repeat match goal with
          | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
            let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
          end.
      try(simpl in *; retrieve_idx).
      destruct Hinv as [rev Hinv].
      (* pose (rev_ans := fun idx => if (idx =? gidx0) then (gidx) else rev idx); exists rev_ans. *)
      exists rev.
      intros.  
      destruct_zmap' Hrd.
      + simpl in Hrd. unfold GRANULE_STATE_RD in *. try lia.
      + destruct_zmap' Hrd.
        { simpl in Hrd; unfold GRANULE_STATE_RD in *; try lia. }
        { pose proof Hinv as Hinv2.
          pose proof (Hinv rd_idx rtt_idx) as Hinv.
          repeat simpl_imply Hinv.
          destruct Hinv as [Hinv0 Hinv1].
          split; [ | auto ].
          destruct_zmap.
          { rewrite Heq1 in *. unfold GRANULE_STATE_RTT in *; try lia. }
          { destruct_zmap; [ | try auto ].
            rewrite Heq2 in *.
            rewrite rtt_idx_compute_3 in Heqgidx0.
            rewrite <- Heqgidx in *.
            pose proof (Hinv2 gidx gidx0) as Hinv_r.
            unfold GRANULE_STATE_RD in *.
            apply Z.sub_move_r in C1. ring_simplify in C1.
            repeat simpl_imply Hinv_r.
            apply eq_sym in Heqgidx0.
            repeat simpl_imply Hinv_r.
            destruct Hinv_r as [Hinv_r0 Hinv_r1].
            try lia.
            try lia.
          }
        }
        - unfold rd_rev in *. unfold rd_rev in *.
        repeat match goal with
        | |- context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096]
          => rewrite rtt_idx_compute_4 with z v; [ |lia]
        end.
        repeat match goal with
        | [H: context[(meta_granule_offset (test_PA ?z) + ?v) mod 4096] |- _]
          => rewrite rtt_idx_compute_4 with z v in H; [ |lia]
        end.
        simpl in *.
        simpl_rtt_idx_all_2. 
        repeat match goal with
            | [H: context[_ @ (meta_granule_offset (test_PA ?v) / 4096)] |- _] =>
              let gidx := fresh "gidx" in remember ((meta_granule_offset (test_PA v)) / 4096) as gidx 
            end.
        try(simpl in *; retrieve_idx).
        destruct Hinv as [rev Hinv].
        (* pose (rev_ans := fun idx => if (idx =? gidx0) then (gidx) else rev idx); exists rev_ans. *)
        exists rev.
        intros.  
        destruct_zmap' Hrd.
        + simpl in Hrd. unfold GRANULE_STATE_RD in *. try lia.
        +  pose proof Hinv as Hinv2.
            pose proof (Hinv rd_idx rtt_idx) as Hinv.
            repeat simpl_imply Hinv.
            destruct Hinv as [Hinv0 Hinv1].
            split; [ | auto ].
            destruct_zmap.
            { rewrite Heq0 in *. unfold GRANULE_STATE_RTT in *; try lia. }
            { auto. }
Qed.            
      
