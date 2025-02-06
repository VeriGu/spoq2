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
Require Import SecurityProof.
(* Require Import SMCHandler.Spec. *)

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.


(* Lens keeping the invariant *)
Lemma lens_gpt:
  forall m st 
    (* (H_1: (lens m st) = st_1) *)
    (H_2: gpt_false_ns st.(share)),
    gpt_false_ns (lens m st).(share).
Admitted.

Lemma lens_gpt_same:
  forall m st,
    (lens m st).(share).(gpt) = st.(share).(gpt).
Admitted.

Lemma lens_state_same:
  forall st v i,
    ((lens v st).(share).(globals).(g_granules) @ i).(e_state_s_granule) = (st.(share).(globals).(g_granules) @ i).(e_state_s_granule).
Admitted.

Lemma z_pte_z_same:
  forall z, (test_PTE_Z (test_Z_PTE z)) = z.
Admitted.

Lemma pte_z_pte_same:
  forall z, (test_Z_PTE (test_PTE_Z z)) = z.
Admitted.

Parameter rtt_is_root : (Z -> bool).
Definition walk_rev (sh: Shared) : Prop :=
  exists (rev: Z -> (Z * Z)),
  forall rtt_idx
    (Hgood_idx: (0 <= rtt_idx /\ rtt_idx < NR_GRANULES))
    (Hrtt_not_root: (rtt_is_root rtt_idx) = false)
    (Hrtt: (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT),
      forall parent_idx offset, rev rtt_idx = (parent_idx, offset) ->
      ( (sh.(globals).(g_granules) @ parent_idx).(e_state_s_granule) = GRANULE_STATE_RTT /\
        (test_Z_PTE ((sh.(granule_data) @ parent_idx).(g_norm) @ offset)).(meta_PA).(meta_granule_offset) = rtt_idx * 4096
      ).

Lemma spinlock_acquire_spec_walk_rev:
  forall d v_0 ret_d
    (Hspec: spinlock_acquire_spec v_0 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Admitted.

Lemma spinlock_release_spec_walk_rev:
  forall d v_0 ret_d
    (Hspec: spinlock_release_spec v_0 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Admitted.


Lemma granule_unlock_spec_walk_rev:
  forall d v_0 ret_d
    (Hspec: granule_unlock_spec v_0 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Admitted.

Lemma smc_realm_activate_spec_walk_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_realm_activate_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold smc_realm_activate_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try unfold GRANULE_STATE_RTT in *; try unfold GRANULE_STATE_RD in *.
  - apply spinlock_acquire_spec_walk_rev in C1.
    + match goal with 
      | [H: context[granule_unlock_spec _ ?x] |- _] => assert(walk_rev x.(share))
      end. 
      { 
        unfold walk_rev in *.
        unfold GRANULE_STATE_RTT in *.
        simpl in *.
        destruct C1 as [rev Hinv_sub].
        exists rev.
        intros.  destruct_zmap.
        { 
          simpl in *. 
          clear Hinv.
          pose proof (Hinv_sub rtt_idx) as Hinv_rtt_idx.
          repeat simpl_imply Hinv_rtt_idx.
          pose proof (Hinv_rtt_idx parent_idx offset) as Hinv_rtt_idx.
          repeat simpl_imply Hinv_rtt_idx.
          inv Hinv_rtt_idx.
          rewrite -> H0 in C2.  easy.
        }
        { 
          pose proof (Hinv_sub rtt_idx) as Hinv_rtt_idx.
          repeat simpl_imply Hinv_rtt_idx.
          pose proof (Hinv_rtt_idx parent_idx offset) as Hinv_rtt_idx.
          repeat simpl_imply Hinv_rtt_idx.
          easy.
        }
      }
      { apply granule_unlock_spec_walk_rev in C5; [ | easy].
        simpl_some. inv Hspec. easy.
      }
    + easy.
  - simpl_some. simpl in *.  inv Hspec. apply spinlock_acquire_spec_walk_rev in C1; [ | easy].
    apply granule_unlock_spec_walk_rev in C5; [ |easy]. easy.
  -  simpl_some. simpl in *.  inv Hspec. apply spinlock_acquire_spec_walk_rev in C1; [ | easy].
    apply spinlock_release_spec_walk_rev in C3; [ |easy]. easy.
  -  simpl_some. simpl in *.  inv Hspec. apply spinlock_acquire_spec_walk_rev in C1; [ | easy].
    apply spinlock_release_spec_walk_rev in C3; [ |easy]. easy.
  -  simpl_some. simpl in *.  inv Hspec. apply spinlock_acquire_spec_walk_rev in C0; [ | easy].
    apply spinlock_release_spec_walk_rev in C2; [ |easy]. easy.
Qed.

Lemma lens_walk_rev:
  forall m st 
    (H_2: walk_rev st.(share)),
    walk_rev (lens m st).(share).
Admitted.

Lemma lens_repeat:
  forall m n st,
    (lens m st) = (lens n (lens m st)).
Admitted.

Lemma lens_walk_rev_same:
  forall m st,
    walk_rev st.(share) = walk_rev (lens m st).(share).
Admitted.

Lemma memset_spec_walk_rev:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: memset_spec v_0 v_1 v_2 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Admitted.

Parameter len_para: Z.
Lemma memset_spec_walk_rev_lens:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: memset_spec v_0 v_1 v_2 d = Some(ret_n, ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma memcpy_ns_read_spec_walk_rev_lens:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: memcpy_ns_read_spec v_0 v_1 v_2 d = Some(ret_n, ret_d)),
    ret_d = (lens len_para d).
Admitted.


Lemma spinlock_acquire_spec_walk_rev_lens:
  forall d v_0 ret_d
    (Hspec: spinlock_acquire_spec v_0 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma spinlock_release_spec_walk_rev_lens:
  forall d v_0 ret_d
    (Hspec: spinlock_release_spec v_0 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma granule_unlock_spec_walk_rev_lens:
  forall d v_0 ret_d
    (Hspec: granule_unlock_spec v_0 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma rec_to_rd_para_state_rec:
  forall rd st,
    (st.(share).(globals).(g_granules) @ ((rec_to_rd_para rd st).(poffset) / 4096)).(e_state_s_granule) = GRANULE_STATE_RD.
Admitted.

Lemma rtt_walk_lock_unlock_spec_walk_rev_lens:
  forall d v_0 v_1 v_2 v_3 v_4 v_5 ret_d ret_n
    (Hspec: rtt_walk_lock_unlock_spec_abs v_0 v_1 v_2 v_3 v_4 v_5 d = Some(ret_n, ret_d)),
    ret_d = (lens len_para d).
Admitted.




Ltac simpl_component :=
  match goal with 
  | [H: context[memset_spec _ _ _] |- _] => try apply memset_spec_walk_rev_lens in H 
  | [H: context[granule_unlock_spec _ _] |- _] => try apply granule_unlock_spec_walk_rev_lens in H 
  | [H: context[spinlock_acquire_spec _ _] |- _] => try apply spinlock_acquire_spec_walk_rev_lens in H 
  | [H: context[spinlock_release_spec _ _] |- _] => try apply spinlock_release_spec_walk_rev_lens in H 
  | [H: context[memcpy_ns_read_spec _ _ _ _] |- _] => try apply memcpy_ns_read_spec_walk_rev_lens in H 
  | [H: context[rtt_walk_lock_unlock_spec_abs _ _ _ _ _ _ _] |- _] => try apply rtt_walk_lock_unlock_spec_walk_rev_lens in H 
  end. 




Ltac intros_rd_para_state := 
  match goal with 
  | [H: context[rec_to_rd_para ?ptr ?x] |- _] => pose proof (rec_to_rd_para_state_rec ptr x) as Hrd; unfold GRANULE_STATE_RD in *
  end. 

Ltac simpl_walk_rev :=
  try unfold GRANULE_STATE_RTT in *; try unfold GRANULE_STATE_RD in *;
  try unfold GRANULE_STATE_REC in *; repeat simpl_component; try intros_rd_para_state.

Lemma powerful_lens :
  forall m st,
    st = (lens m st).
Admitted.

Lemma lens_granule_data_same :
  forall st v i
  (Hrttpage: (st.(share).(globals).(g_granules) @ i).(e_state_s_granule) = GRANULE_STATE_RTT) ,
  (lens v st).(share).(granule_data) @ i = st.(share).(granule_data) @ i.
Admitted.

Lemma rtt_walk_lock_unlock_spec_ensure:
  forall d v_0 v_1 v_2 v_3 v_4 v_5 ret_d ret_n
    (Hspec: rtt_walk_lock_unlock_spec_abs v_0 v_1 v_2 v_3 v_4 v_5 d = Some(ret_n, ret_d)),
    (((poffset (e_2 ret_n)) mod 4096 = 0))
     /\ (0 <= (e_3 ret_n))
     /\ (512 > (e_3 ret_n))
     /\ (
      (((poffset (e_2 ret_n)) + 8 * (e_3 ret_n)) / 4096) = 
      ((poffset (e_2 ret_n)) / 4096)
     ).
Admitted.

Lemma smc_rec_destroy_spec_walk_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_rec_destroy_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold smc_rec_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec;
  try simpl_walk_rev;
  repeat match goal with
    | [H: _ = lens _ _ |- _] => rewrite -> H in *; clear H
  end;
  repeat match goal with
    | [H: context[lens _ (lens _ _)] |- _] => rewrite <- lens_repeat in H
  end; simpl_some.
  - 
  repeat match goal with
  | [H: _ = lens _ _ |- _] => rewrite -> H in *; clear H
  end.
  repeat match goal with
  | [H: context[lens _ (lens _ _)] |- _] => rewrite <- lens_repeat in H
  end.
  simpl_some. inv Hspec.
  match goal with
  | |- context[lens _ ?x] => let core := fresh "core" in remember x as core
  end. 
  assert (walk_rev core.(share)) as Hcore.
    + unfold walk_rev in *. 
      destruct Hinv as [rev_inv Hinv_sub].
      exists rev_inv.
      intros.
      pose proof (Hinv_sub rtt_idx) as Hinv_rtt_idx.
      repeat simpl_imply Hinv_rtt_idx.
      rewrite Heqcore in Hrtt.
      simpl in *.
      repeat match goal with
      | [H: context[ e_state_s_granule (g_granules (globals (share ?st))) @ (?app ?idx)] |- _ ]  =>
          let gidx := fresh "gidx" in remember (app idx) as gidx
      end.
      bool_rel.
      assert (rtt_idx <> gidx0).
      { 
        unfold not. intros.
        rewrite H0 in *.
        rewrite ZMap.gss in Hrtt.
        unfold GRANULE_STATE_RTT in *.
        simpl in *.
        inv Hrtt.
      }
      { rewrite ZMap.gso in Hrtt; [ | easy].
        rewrite lens_state_same in Hrtt.
        simpl_imply Hinv_rtt_idx.
        pose proof (Hinv_rtt_idx parent_idx offset) as Hinv_rtt_idx.
        simpl_imply Hinv_rtt_idx.
        rewrite Heqcore. simpl in *.
        assert (parent_idx <> gidx0).
        { unfold not. intros. 
          destruct Hinv_rtt_idx as [Hl Hr].
          rewrite H1 in *. rewrite lens_state_same in C1.
          rewrite Hl in C1. unfold GRANULE_STATE_RTT in *.
          inv C1.
        }
        { simpl in *. split.
          { rewrite ZMap.gso. rewrite lens_state_same. destruct Hinv_rtt_idx as [Hl Hr]. easy. exact H1. }
          { destruct Hinv_rtt_idx as [Hl Hr]. pose proof (lens_granule_data_same d len_para parent_idx).
            simpl_imply H2. rewrite H2. easy.
          }
        }
      }
    + let wrap := fresh "wrap" in remember (lens len_para core) as wrap. 
      assert (walk_rev wrap.(share)) as Hwrap.
      rewrite -> Heqwrap. apply lens_walk_rev. easy.
      unfold walk_rev in Hwrap.
      destruct Hwrap as [rev_wrap Hwrap_sub].
      unfold walk_rev.
      simpl in *.
      exists rev_wrap.
      intros.
      pose proof (Hwrap_sub rtt_idx) as Hwrap_rtt_idx.
      match goal with
      | [H: context[ (?m # ?i == ?v) @ ?j] |- _ ] => let other := fresh "other" in remember i as other
      end.
      assert (rtt_idx <> other).
        * unfold not. intros. 
          bool_rel.
          repeat match goal with
          | [H: context[ e_state_s_granule (g_granules (globals (share ?st))) @ (?app ?idx)] |- _ ]  =>
              let gidx := fresh "gidx" in remember (app idx) as gidx
          end.
          assert (gidx <> parent_idx).
          { 
            unfold not. intros.
            assert ((e_state_s_granule (g_granules (globals (share (core)))) @ parent_idx ) <> 5). 
            { unfold not. intros. rewrite -> Heqcore in H2. simpl in *. 
              rewrite -> H1 in H2. rewrite ZMap.gss in H2. simpl in *. inv H2.  }
            { 
              simpl in *. 
              rewrite <- H0 in Hrtt.
              rewrite ZMap.gss in Hrtt.
              simpl in *.
              pose proof (Hwrap_sub rtt_idx) as Hwrap_sub.
              repeat simpl_imply Hwrap_sub.
              pose proof (Hwrap_sub parent_idx offset) as Hwrap_sub.
              repeat simpl_imply Hwrap_sub.
              destruct Hwrap_sub as [Hl Hr].
              rewrite -> H1 in *. unfold GRANULE_STATE_RTT in *.
              rewrite Heqwrap in Hl.
              rewrite lens_state_same in Hl.
              rewrite Hl in H2.
              contra.

            }
          } 
          { 
            rewrite H0 in Hrtt.  rewrite ZMap.gss in Hrtt. simpl in *.
            assert ((e_state_s_granule (g_granules (globals (share (core)))) @ other ) <> 5).
            { 
              unfold not. intros.
              assert (other <> gidx).
              { 
                unfold not. intros.
                rewrite H3 in *.
                rewrite Heqcore in H2.
                simpl in *. rewrite ZMap.gss in H2. simpl in *.
                inv H2.
              }
              { 
                rewrite Heqcore in H2. simpl in *.
                rewrite ZMap.gso in H2; [ | easy]. rewrite H2 in Hrd.
                inv Hrd.
              }
            }
            { 
              rewrite Heqwrap in Hrtt.
              rewrite lens_state_same in Hrtt.
              unfold GRANULE_STATE_RTT in *.
              rewrite -> Hrtt in H2.
              contra.
            }
          }
        * rewrite ZMap.gso in Hrtt; [ | easy].
          assert (parent_idx <> other).
          { 
            repeat simpl_imply Hwrap_rtt_idx.
            pose proof (Hwrap_rtt_idx parent_idx offset) as Hwrap_rtt_idx.
            repeat simpl_imply Hwrap_rtt_idx.
            bool_rel.
            unfold not. intros.
            rewrite <- H1 in *.
            unfold GRANULE_STATE_RTT in *.
            destruct Hwrap_rtt_idx as [Hr Hl].
            assert ((e_state_s_granule (g_granules (globals (share (core)))) @ parent_idx ) <> 5).
            {
              unfold not. intros.
              rewrite -> Heqcore in H2. simpl in *. 
              assert( meta_granule_offset (test_PA v_0) / 4096 <> parent_idx ).
              { unfold not. intros. rewrite -> H3 in C1. rewrite -> H3 in H2. 
                rewrite ZMap.gss in H2. unfold update_s_granule_e_state_s_granule in H2.  simpl in H2. inv H2.
              } 
              { remember ((meta_granule_offset (test_PA v_0)) / 4096) as rec. rewrite ZMap.gso in H2. rewrite -> H2 in Hrd. inv Hrd. unfold not. intros. rewrite H4 in H3. contra. }
            } 
            { rewrite Heqwrap in Hr. rewrite lens_state_same in Hr. contra.  }
          } 
          { 
            rewrite ZMap.gso; [ | easy ].
            repeat simpl_imply Hwrap_rtt_idx.
            pose proof (Hwrap_rtt_idx parent_idx offset) as Hwrap_rtt_idx.
            repeat simpl_imply Hwrap_rtt_idx.
            easy.
          }
  - inv Hspec. apply lens_walk_rev. easy.
  - inv Hspec. apply lens_walk_rev. easy.
  - inv Hspec. apply lens_walk_rev. easy.
  - inv Hspec. apply lens_walk_rev. easy.
Qed.

Lemma strong_lens:
  forall m st,
    (lens m st) = st.
Admitted.

Ltac simpl_walk_rev_strong H :=
  try repeat rewrite strong_lens in H.


Ltac retrieve_idx :=
  repeat match goal with
  | [H: context[(g_granules (globals (share ?st))) @ (?app ?idx)] |- _ ]  =>
      let gidx := fresh "gidx" in remember (app idx) as gidx
  | |- context[(g_granules (globals (share ?st))) @ (?app ?idx)]  =>
      let gidx := fresh "gidx" in remember (app idx) as gidx
  | |- context[(granule_data ((share ?st))) @ (?app ?idx)]  =>
      let gidx := fresh "gidx" in remember (app idx) as gidx
  | |- context[(g_norm _) # (?app ?idx) == _]  =>
      let gidx := fresh "normidx" in 
      (* let name := fresh "Heqgidx" in  *)
        remember (app idx) as gidx
         (* eqn: name; rewrite <- name in * *)
  end.

Ltac intros_ensure :=
    match goal with 
   | [H: context[rtt_walk_lock_unlock_spec_abs _ _ _ _ _ _ _] |- _] => let H2 := fresh "Hcopy" in pose proof H as H2; try (apply rtt_walk_lock_unlock_spec_ensure in H2; 
    destruct H2 as [Hrtt_ret0 H2]; 
    destruct H2 as [Hrtt_ret1 H2]; 
    destruct H2 as [Hrtt_ret2 Hrtt_ret3]
   )
end. 

Lemma quick_index_compute :
  forall a off
    (He: (a + off) mod 4096 = off),
    (a + off) / 4096 = a / 4096.
Admitted.

Lemma abs_tte_read_no_pa:
  forall ptr st
    (Htype: (abs_tte_read ptr st).(meta_desc_type) <> 3),
    (test_Z_PTE
      ((g_norm (granule_data (share st)) @ (ptr.(poffset) / 4096)) @ (ptr.(poffset) mod 4096))
    ).(meta_PA).(meta_granule_offset) = (-1).
Admitted.

Lemma lens_ignore_g_granules_update:
  forall gs idx idx2 elem1,
    (e_state_s_granule ((gs) # idx == (update_s_granule_e_ref (gs @ idx) elem1)) @ idx2)  = 
    (e_state_s_granule (gs) @ idx2).
Proof.
  intros.
  unfold update_s_granule_e_ref.
  destruct (idx =? idx2) eqn:Hidx; bool_rel.
  rewrite Hidx in *.
  rewrite ZMap.gss. simpl in *. reflexivity.
  rewrite ZMap.gso. auto. auto.
Qed.
  
Ltac simple_abs_tte_read H :=
  let E1 := fresh "E" in
  let E2 := fresh "E" in
  let E3 := fresh "E" in
  apply Bool.andb_true_iff in H;
  destruct H as (E2 & E3);
  apply Bool.andb_true_iff in E2;
  destruct E2 as (E1 & E2);
  bool_rel;
  try simpl_walk_rev_strong E1;
  try simpl_walk_rev_strong E2;
  try simpl_walk_rev_strong E3.

Lemma rsi_data_map_extra_spec_walk_rev:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: rsi_data_map_extra_spec v_0 v_1 v_2 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold rsi_data_map_extra_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec;
  try intros_ensure;
  try simpl_walk_rev;
  repeat match goal with
    | [H: _ = lens _ _ |- _] => rewrite -> H in *; clear H
  end;
  repeat match goal with
    | [H: context[lens _ (lens _ _)] |- _] => rewrite <- lens_repeat in H
  end; simpl_some; try simpl_walk_rev_strong Hspec; bool_rel.
  - simpl in *. inv Hspec.
    simple_abs_tte_read C9.
    pose E as Etype.
    match type of Etype with 
    | context[(meta_desc_type ?r)] => assert((meta_desc_type r) <> 3) as Etype2; [ rewrite Etype; easy | ]
    end.
    match type of Etype2 with 
    | context[(meta_desc_type (abs_tte_read ?ptr ?st))] => pose proof (abs_tte_read_no_pa ptr st Etype2)
    end.
    simpl in *.
    unfold walk_rev. simpl in *.
    unfold walk_rev in Hinv.
    destruct Hinv as [rev Hinv].
    exists rev.
    retrieve_idx.
    intros.
    repeat rewrite lens_ignore_g_granules_update.
    repeat rewrite lens_ignore_g_granules_update in Hrtt.
    repeat rewrite lens_state_same.
    pose proof (Hinv rtt_idx) as Hinv.
    repeat simpl_imply Hinv.
    pose proof (Hinv parent_idx offset) as Hinv.
    repeat simpl_imply Hinv.
    destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ].
    match goal with
    | [H: ?gp = (poffset (e_2 ?a) + 8 * (e_3 ?a)) / 4096 |- _] => remember gp as gp_idx
    end.
    assert (not (parent_idx = gp_idx /\ offset = normidx)).
    * unfold not. intros. destruct H1 as [H10 H11].
      rewrite H10 in *. rewrite H11 in *.
      rewrite Hinv_2 in H. 
      unfold NR_GRANULES in *.
      lia.
    * apply not_and_or in H1. destruct H1.
      { 
        simpl in *. rewrite ZMap.gso. easy. easy.
      }
      {
        simpl in *. 
        destruct (parent_idx =? gp_idx) eqn: Hp; bool_rel.
        {  rewrite Hp in *. rewrite ZMap.gss. simpl in *. 
           rewrite ZMap.gso. simpl in *. easy. easy.
        }
        { rewrite ZMap.gso. easy. easy.  }
      }
  - inv Hspec. easy.
  - simpl in *. inv Hspec.
    simple_abs_tte_read C9.
    pose E as Etype.
    match type of Etype with 
    | context[(meta_desc_type ?r)] => assert((meta_desc_type r) <> 3) as Etype2; [ rewrite Etype; easy | ]
    end.
    match type of Etype2 with 
    | context[(meta_desc_type (abs_tte_read ?ptr ?st))] => pose proof (abs_tte_read_no_pa ptr st Etype2)
    end.
    simpl in *.
    unfold walk_rev. simpl in *.
    unfold walk_rev in Hinv.
    destruct Hinv as [rev Hinv].
    exists rev.
    retrieve_idx.
    intros.
    repeat rewrite lens_ignore_g_granules_update.
    repeat rewrite lens_ignore_g_granules_update in Hrtt.
    pose proof (Hinv rtt_idx) as Hinv.
    repeat simpl_imply Hinv.
    pose proof (Hinv parent_idx offset) as Hinv.
    repeat simpl_imply Hinv.
    destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ].
    match goal with
    | [H: ?gp = (poffset (e_2 ?a) + 8 * (e_3 ?a)) / 4096 |- _] => remember gp as gp_idx
    end.
    assert (not (parent_idx = gp_idx /\ offset = normidx)).
    * unfold not. intros. destruct H1 as [H10 H11].
      rewrite H10 in *. rewrite H11 in *.
      rewrite Hinv_2 in H. 
      unfold NR_GRANULES in *.
      lia.
    * apply not_and_or in H1. destruct H1.
      { 
        simpl in *. rewrite ZMap.gso. easy. easy.
      }
      {
        simpl in *. 
        destruct (parent_idx =? gp_idx) eqn: Hp; bool_rel.
        {  rewrite Hp in *. rewrite ZMap.gss. simpl in *. 
           rewrite ZMap.gso. simpl in *. easy. easy.
        }
        { rewrite ZMap.gso. easy. easy.  }
      }
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
  - inv Hspec. easy.
Qed.

Lemma test_Z_PTE_Z_same:
  (forall a, (test_Z_PTE (test_PTE_Z a)) = a).
Admitted.

Lemma abs_tte_read_sem:
  (forall a st, (abs_tte_read a st) = (test_Z_PTE (g_norm (granule_data (share st)) @ (a.(poffset) / 4096)) @ (a.(poffset) mod 4096))).
Admitted.

Ltac simpl_andb_true_iff H :=
  let E1 := fresh "E" in
  let E2 := fresh "E" in
  apply Bool.andb_true_iff in H;
  destruct H as (E1 & E2);
  try simpl_walk_rev_strong E1;
  try simpl_walk_rev_strong E2;
  bool_rel.

Lemma rsi_rtt_set_ripas_spec_walk_rev :
  forall d v_0 v_1 v_2 v_3 ret_n ret_d
    (Hspec: rsi_rtt_set_ripas_spec v_0 v_1 v_2 v_3 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold rsi_rtt_set_ripas_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec;
  try intros_ensure;
  try simpl_walk_rev;
  repeat match goal with
    | [H: _ = lens _ _ |- _] => rewrite -> H in *; clear H
  end;
  repeat match goal with
    | [H: context[lens _ (lens _ _)] |- _] => rewrite <- lens_repeat in H
  end; simpl_some; try simpl_walk_rev_strong Hspec; bool_rel; try (inv Hspec; easy).
  all: inv Hspec. 
  all: try(match goal with
          | [H: (?a =? 3) && _ = true |- _] => simpl_andb_true_iff H
            end; simpl in *; retrieve_idx;
            unfold walk_rev; simpl in *; unfold walk_rev in Hinv; destruct Hinv as [rev Hinv];  exists rev;
            intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt;
            pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;  pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
            destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ];
            destruct ( (parent_idx =? gidx0) && (offset =? normidx) ) eqn: Hidx;
            [ simpl in *;  apply Bool.andb_true_iff in Hidx;  destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *; rewrite ZMap.gss; simpl in *; rewrite ZMap.gss in * ;
              rewrite test_Z_PTE_Z_same; simpl in *;  rewrite abs_tte_read_sem; simpl in *; rewrite <- Heqgidx0; rewrite <- Heqnormidx; easy
            | 
             rewrite Bool.andb_false_iff in Hidx; 
             destruct Hidx; bool_rel; [ 
              simpl in *; rewrite ZMap.gso; [ easy | easy ]
              |  simpl in *;   destruct (parent_idx =? gidx0) eqn: Hp; bool_rel; 
                 [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]| rewrite ZMap.gso; [easy | easy] ]
             ]
            ]
            ).
  all: try(match goal with
          | [H: (?a <>? 3) && _ = true |- _] => simpl_andb_true_iff H
          end; simpl in *; retrieve_idx;
          unfold walk_rev; simpl in *; unfold walk_rev in Hinv; destruct Hinv as [rev Hinv];  exists rev;
          intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt;
          pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;  pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
          destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ];
          destruct ( (parent_idx =? gidx0) && (offset =? normidx) ) eqn: Hidx; 
          [ simpl in *;  apply Bool.andb_true_iff in Hidx;  destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *; rewrite ZMap.gss; simpl in *; rewrite ZMap.gss in * ;
          rewrite test_Z_PTE_Z_same; simpl in *;  rewrite abs_tte_read_sem; simpl in *; rewrite <- Heqgidx0; rewrite <- Heqnormidx; easy
          | rewrite Bool.andb_false_iff in Hidx; 
            destruct Hidx; bool_rel; [ 
            simpl in *; rewrite ZMap.gso; [ easy | easy ]
            |  simpl in *;   destruct (parent_idx =? gidx0) eqn: Hp; bool_rel; 
             [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]| rewrite ZMap.gso; [easy | easy] ]
            ]
          ]
          ).
    all: try(match goal with
         | [H: (meta_desc_type _ =? _) && _ && _ = true |- _] => simple_abs_tte_read H 
         end; retrieve_idx;
         pose E as Etype;
         match type of Etype with 
         | context[(meta_desc_type ?r)] => assert((meta_desc_type r) <> 3) as Etype2; [ rewrite Etype; easy | ]
         end;
         match type of Etype2 with 
         | context[(meta_desc_type (abs_tte_read ?ptr ?st))] => pose proof (abs_tte_read_no_pa ptr st Etype2) as Hpa
         end; simpl in *;
         unfold walk_rev; simpl in *; unfold walk_rev in Hinv; destruct Hinv as [rev Hinv];  exists rev;
         intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt;
         pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;  pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
         destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ];
         rewrite <- Heqgidx0 in Hpa; rewrite <- Heqnormidx in Hpa;
         let H1 := fresh "H1" in assert (not (parent_idx = gidx0 /\ offset = normidx)) as H1;
         [ 
          unfold not; let H2 := fresh "H2" in intros H2;
          destruct H2 as [H20 H21];
          rewrite H20 in *; rewrite H21 in *;
          rewrite Hinv_2 in Hpa;
          unfold NR_GRANULES in *;
          lia
          | apply not_and_or in H1; destruct H1;
           [ simpl in *; rewrite ZMap.gso; [easy | easy]
           |
             simpl in *; destruct (parent_idx =? gidx0) eqn: Hp; bool_rel;
             [ rewrite Hp in *; rewrite ZMap.gss; simpl in *;
               rewrite ZMap.gso; simpl in *; [ easy | easy]
             | rewrite ZMap.gso; [easy | easy]  ]
           ]
         ]
      ).
  all: try(match goal with
      | [H: (?a =? 3) && _ = true |- _] => simpl_andb_true_iff H
        end; simpl in *; retrieve_idx;
        unfold walk_rev; simpl in *; unfold walk_rev in Hinv; destruct Hinv as [rev Hinv];  exists rev;
        intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt;
        pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;  pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
        destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ];
        destruct ((parent_idx =? gidx1) && (offset =? normidx) ) eqn: Hidx;
        [ simpl in *;  apply Bool.andb_true_iff in Hidx;  destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *; rewrite ZMap.gss; simpl in *; rewrite ZMap.gss in * ;
          rewrite test_Z_PTE_Z_same; simpl in *;  rewrite abs_tte_read_sem; simpl in *; rewrite <- Heqgidx1; rewrite <- Heqnormidx; easy
        | 
         rewrite Bool.andb_false_iff in Hidx; 
         destruct Hidx; bool_rel; [ 
          simpl in *; rewrite ZMap.gso; [ easy | easy ]
          |  simpl in *;   destruct (parent_idx =? gidx1) eqn: Hp; bool_rel; 
             [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]| rewrite ZMap.gso; [easy | easy] ]
         ]
        ] 
   ).
  all:  try( 
        simpl in *;
        unfold walk_rev; simpl in *; unfold walk_rev in Hinv; destruct Hinv as [rev Hinv];  exists rev;
        intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt;
        pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;  pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
        destruct Hinv as [Hinv_1 Hinv_2]; split; [ exact Hinv_1 | ];
        retrieve_idx;
        destruct ((parent_idx =? gidx1) && (offset =? normidx) ) eqn: Hidx;
        [ simpl in *;  apply Bool.andb_true_iff in Hidx;  destruct Hidx as [Hidx1 Hidx2]; bool_rel; rewrite Hidx1 in *; rewrite Hidx2 in *; rewrite ZMap.gss; simpl in *; rewrite ZMap.gss in * ;
        rewrite test_Z_PTE_Z_same; simpl in *;  rewrite abs_tte_read_sem; simpl in *; rewrite <- Heqgidx1; rewrite <- Heqnormidx; easy 
        | 
        rewrite Bool.andb_false_iff in Hidx; 
        destruct Hidx; bool_rel; [ 
         simpl in *; rewrite ZMap.gso; [ easy | easy ]
         |  simpl in *;   destruct (parent_idx =? gidx1) eqn: Hp; bool_rel; 
            [ rewrite Hp in *; rewrite ZMap.gss; simpl in * ; rewrite ZMap.gso; simpl in *; [ easy| easy]| rewrite ZMap.gso; [easy | easy] ]
        ]
        ]
  ).
Qed.

Lemma rtt_walk_lock_unlock_spec_ensure_state:
  forall d v_0 v_1 v_2 v_3 v_4 v_5 ret_d ret_n
    (Hspec: rtt_walk_lock_unlock_spec_abs v_0 v_1 v_2 v_3 v_4 v_5 d = Some(ret_n, ret_d)),
      ((ret_d.(share).(globals).(g_granules) @ ((poffset (e_2 ret_n)) / 4096)).(e_state_s_granule) = 5).
Admitted.

Ltac intros_ensure_state :=
   match goal with 
   | [H: context[rtt_walk_lock_unlock_spec_abs _ _ _ _ _ _ _] |- _] => let H2 := fresh "Hcopy" in pose proof H as H2; try (apply rtt_walk_lock_unlock_spec_ensure_state in H2)
end. 

Lemma s2tt_init_unassigned_spec_walk_rev_lens:
  forall d v_0 v_1 ret_d
    (Hspec: s2tt_init_unassigned_spec v_0 v_1 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.



Ltac partial_simpl_component :=
  match goal with 
  | [H: memset_spec _ _ _ = _|- _] => apply memset_spec_walk_rev_lens in H 
  | [H: granule_unlock_spec _ _ = _ |- _] => apply granule_unlock_spec_walk_rev_lens in H 
  | [H: spinlock_acquire_spec _ _ = _ |- _] => apply spinlock_acquire_spec_walk_rev_lens in H 
  | [H: spinlock_release_spec _ _ = _  |- _] => apply spinlock_release_spec_walk_rev_lens in H 
  | [H: memcpy_ns_read_spec _ _ _ _ = _ |- _] =>  apply memcpy_ns_read_spec_walk_rev_lens in H 
  | [H: rtt_walk_lock_unlock_spec_abs _ _ _ _ _ _ _ = _ |- _] =>  apply rtt_walk_lock_unlock_spec_walk_rev_lens in H 
  | [H: s2tt_init_unassigned_spec _ _ _ = _ |- _] => apply s2tt_init_unassigned_spec_walk_rev_lens in H
  end. 

Ltac partial_simpl_walk_rev :=
  try unfold GRANULE_STATE_RTT in *; try unfold GRANULE_STATE_RD in *;
  try unfold GRANULE_STATE_REC in *; repeat partial_simpl_component; try intros_rd_para_state.

Ltac partial_simpl_walk_rev_and_solve Hspec :=
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


Lemma rtt_idx_compute_1 :
  (forall a, (poffset (e_2 a) + 8 * e_3 a) / 4096 = (poffset (e_2 a)) / 4096 ).
Admitted.

Lemma rtt_idx_compute_2 :
  (forall a, (poffset (e_2 a) + 8) / 4096 = (poffset (e_2 a)) / 4096).
Admitted.

Lemma rtt_mul_div_4096_same :
  (forall a (Hmod: a mod 4096 = 0), a = a / 4096 * 4096).
Admitted.

Ltac simpl_rtt_idx :=
  try rewrite rtt_idx_compute_1; try rewrite rtt_idx_compute_2.

Lemma rtt_create_internal_built_in_assert :
  (forall ptr d v_3
                (Ht: ((meta_desc_type (abs_tte_read ptr d)) =? 0) && ((meta_ripas (abs_tte_read ptr d)) =? 0) = false )
                (Ht: (v_3 + -1 <? 3) && ((meta_desc_type (abs_tte_read ptr d)) =? 3) = false ),
                (meta_granule_offset (meta_PA (test_Z_PTE ((g_norm 
                    ( (granule_data (share d)) @ ((poffset ptr) / 4096))
                ) @ ((poffset ptr) mod 4096))))) = -1
                ).
Admitted.

Lemma argument_ensure :
  forall v_0,
  ((meta_granule_offset (test_PA v_0) + 4) / 4096 = (meta_granule_offset (test_PA v_0)) / 4096).
Admitted.

Lemma rsi_rtt_create_walk_rev :
  forall d v_0 v_1 v_2 v_3 ret_n ret_d
    (Hspec: rsi_rtt_create_spec v_0 v_1 v_2 v_3 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold rsi_rtt_create_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; partial_simpl_walk_rev_and_solve Hspec.
  all: partial_simpl_walk_rev_and_solve Hspec.
  all: inv Hspec.
  all: simpl_rtt_idx.
  all: try(
      unfold walk_rev; simpl in *; unfold walk_rev in Hinv; unfold GRANULE_STATE_RTT in *; destruct Hinv as [rev Hinv];  
      retrieve_idx; intros; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt ).
  (* all: ( assert((meta_granule_offset (test_PA v_0) + 4) / 4096 = (meta_granule_offset (test_PA v_0)) / 4096) as Hoff; [ admit | rewrite -> Hoff in *; try rewrite <- Heqgidx in *; clear Hoff ]). *)
  all: (rewrite -> argument_ensure in *).
  all: repeat match goal with
    | [H: (_ =? 0) && _ = true |- _] => simpl_andb_true_iff H
    end.
  all: try match goal with 
    | [H: (meta_desc_type (abs_tte_read ?ptr ?d)) = 0 |- _] => assert( (meta_desc_type (abs_tte_read ptr d)) <> 3) as H_neq_3; [ rewrite H; lia | 
        pose proof (abs_tte_read_no_pa ptr d H_neq_3); simpl in *  ]
    end.
  all: simpl_rtt_idx.
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
  all: match goal with
       | [H:(e_state_s_granule (g_granules (globals (share _))) @ (?r)) - 1 = 0 |- _] => remember r as Hrtt_idx; remember H as Hrtt_state;
          match goal with
          | [H: Hrtt_idx = meta_granule_offset _ / 4096 |- _] => rewrite <- H in *; pose H as Hrtt_val
          end;
          repeat match goal with
          | [H: ?a = Hrtt_idx |- _] => rewrite -> H in *; clear H
          end;
          assert (Hgp_idx <> Hrtt_idx) as Hneq_gp_rtt; [ unfold not; intros Heq_gp_rtt; rewrite Heq_gp_rtt in *; lia | ] 
       end.
  all: simpl in *.
  all: pose (rev_ans := fun idx => if (idx =? Hrtt_idx) then (Hgp_idx, normidx) else rev idx);
      exists rev_ans;  intros rtt_idx ? ? ? parent_idx offset H_rev_ans.
  all: destruct (rtt_idx =? Hrtt_idx) eqn: H_real_rtt_idx; bool_rel;
       [ rewrite H_real_rtt_idx in *; unfold rev_ans in H_rev_ans; simpl_hyp H_rev_ans; bool_rel;
        [ injection H_rev_ans; intros Hpp Hrr; rewrite <- Hrr in *; rewrite <- Hpp in *; split;
          [ rewrite ZMap.gso; repeat rewrite lens_ignore_g_granules_update; try assumption 
            | rewrite ZMap.gss; simpl in *; rewrite  ZMap.gss; rewrite test_Z_PTE_Z_same; simpl in *; rewrite Hrtt_val;
              (* assert(forall a (Hmod: a mod 4096 = 0), a = a / 4096 * 4096) as Hass; [ admit | ]; *)
              apply rtt_mul_div_4096_same; easy
          ]
        | contra ]
       |  ].
  all: unfold rev_ans in H_rev_ans; simpl_hyp H_rev_ans; bool_rel; [ contra | ]. 
  all: rewrite ZMap.gso in Hrtt; repeat rewrite lens_ignore_g_granules_update; repeat rewrite lens_ignore_g_granules_update in Hrtt; try easy;
        pose proof (Hinv rtt_idx) as Hinv;  repeat simpl_imply Hinv;  pose proof (Hinv parent_idx offset) as Hinv;  repeat simpl_imply Hinv;
        assert (parent_idx <> Hrtt_idx) as Hneq_p_rtt; [ unfold not; intros Heq_p_rtt; rewrite Heq_p_rtt in *; lia | ];
        rewrite ZMap.gso in *; simpl in *; try rewrite lens_ignore_g_granules_update; try easy; split; try easy.
  all:  try rewrite <- Hgp_idx in *.
  all:  assert(not (parent_idx = Hgp_idx /\ offset = normidx)) as Hsame; [ 
          unfold not; intros Hnsame; destruct Hnsame as [H10 H11];
          rewrite H10 in *; rewrite H11 in *;
          destruct Hinv as [Hinv1 Hinv2];
          unfold NR_GRANULES in *; try lia | ].
  all: try( (* assert(forall ptr d v_3
              (Ht: ((meta_desc_type (abs_tte_read ptr d)) =? 0) && ((meta_ripas (abs_tte_read ptr d)) =? 0) = false )
              (Ht: (v_3 + -1 <? 3) && ((meta_desc_type (abs_tte_read ptr d)) =? 3) = false ),
              (meta_granule_offset (meta_PA (test_Z_PTE ((g_norm 
                  ( (granule_data (share d)) @ ((poffset ptr) / 4096))
              ) @ ((poffset ptr) mod 4096))))) = -1
              )
              as Hassert_false; [ admit| ]; *)
            pose proof rtt_create_internal_built_in_assert as Hassert_false;
            match goal with
            |  [H: ((meta_desc_type (abs_tte_read ?ptr ?d)) =? 0) && ((meta_ripas (abs_tte_read ?ptr ?d)) =? 0) = false |- _] => pose proof (Hassert_false ptr d) as Hassert_false
            end;
            match goal with
            |  [H: (?v + -1 <? 3 ) && (_) = false |- _] => pose proof (Hassert_false v) as Hassert_false; simpl in *
            end;
            repeat simpl_imply Hassert_false).
  all: repeat simpl_rtt_idx; try rewrite Hrtt_ret3 in *; try rewrite <- Heqnormidx in *; try rewrite <- HeqHgp_idx in *; simpl in *. 
  all: try lia.
  all: apply not_and_or in Hsame; destruct Hsame;
       [ simpl in *; rewrite ZMap.gso; [ easy | easy ] | 
         simpl in *;
         let Hp := fresh "Hp" in destruct (parent_idx =? Hgp_idx) eqn: Hp; bool_rel;
         [ rewrite Hp in *; rewrite ZMap.gss; simpl in *; rewrite ZMap.gso; simpl in *; [ easy | easy] 
         | rewrite ZMap.gso; [easy | easy ] ]
       ].
Qed.