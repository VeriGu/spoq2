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

Ltac simpl_component :=
  match goal with 
  | [H: context[memset_spec _ _ _] |- _] => try apply memset_spec_walk_rev_lens in H 
  | [H: context[granule_unlock_spec _ _] |- _] => try apply granule_unlock_spec_walk_rev_lens in H 
  | [H: context[spinlock_acquire_spec _ _] |- _] => try apply spinlock_acquire_spec_walk_rev_lens in H 
  | [H: context[spinlock_release_spec _ _] |- _] => try apply spinlock_release_spec_walk_rev_lens in H 
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

Lemma smc_rec_destroy_spec_walk_rev:
  forall d v_0 ret_n ret_d
    (Hspec: smc_rec_destroy_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros.  unfold smc_rec_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; simpl_walk_rev;
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



