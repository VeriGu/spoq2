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
 
 
