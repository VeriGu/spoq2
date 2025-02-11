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


(* a gpt false can be either NS state or ANY state *)
Definition gpt_false_ns (sh: Shared) :=
  forall gidx, sh.(gpt) @ gidx = false -> ( 
    (sh.(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_NS \/ 
    (sh.(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_ANY ).

Lemma lens_repeat:
  forall m n st,
    (lens m st) = (lens n (lens m st)).
Admitted.

Lemma rec_to_rd_para_state_rec:
  forall rd st,
    (st.(share).(globals).(g_granules) @ ((rec_to_rd_para rd st).(poffset) / 4096)).(e_state_s_granule) = GRANULE_STATE_RD.
Admitted.


Parameter len_para: Z.
Lemma memset_spec_gpt_false_lens:
  forall d v_0 v_1 v_2 ret_n ret_d
    (Hspec: memset_spec v_0 v_1 v_2 d = Some(ret_n, ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma granule_unlock_spec_gpt_false_lens:
  forall d v_0 ret_d
    (Hspec: granule_unlock_spec v_0 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma spinlock_acquire_spec_gpt_false_lens:
  forall d v_0 ret_d
    (Hspec: spinlock_acquire_spec v_0 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.

Lemma spinlock_release_spec_gpt_false_lens:
  forall d v_0 ret_d
    (Hspec: spinlock_release_spec v_0 d = Some(ret_d)),
    ret_d = (lens len_para d).
Admitted.


Ltac simpl_component :=
  match goal with 
  | [H: context[memset_spec _ _ _] |- _] => try apply memset_spec_gpt_false_lens in H
  | [H: context[granule_unlock_spec _ _] |- _] => try apply granule_unlock_spec_gpt_false_lens in H
  | [H: context[spinlock_acquire_spec _ _] |- _] => try apply spinlock_acquire_spec_gpt_false_lens in H
  | [H: context[spinlock_release_spec _ _] |- _] => try apply spinlock_release_spec_gpt_false_lens in H
  end. 

Lemma strong_lens:
  forall m st,
    (lens m st) = st.
Admitted.

Ltac intros_rd_para_state := 
  match goal with 
  | [H: context[rec_to_rd_para ?ptr ?x] |- _] => pose proof (rec_to_rd_para_state_rec ptr x) as Hrd; unfold GRANULE_STATE_RD in *
  end. 

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

Lemma smc_rec_destroy_spec_gpt_false:
  forall d v_0 ret_n ret_d
    (Hspec: smc_rec_destroy_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: gpt_false_ns d.(share)),
    gpt_false_ns ret_d.(share).
Proof.
  intros.  unfold smc_rec_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec.
  - simpl_some. repeat simpl_component.
  rewrite C4 in C6. rewrite C0 in C6. repeat rewrite strong_lens in *.
  unfold gpt_false_ns. rewrite C6 in *. inv Hspec.
  intros gidx. remember (meta_granule_offset (test_PA v_0) / 4096) as off. destruct (off =? gidx) eqn:Hidx.
    + bool_rel. rewrite Hidx in *. remember (poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} d) / 4096) as off2.
    destruct (off2 =? gidx) eqn:Hidx2.
      * bool_rel. rewrite Hidx2 in *.
      repeat (simpl in *; rewrite ZMap.gss). intros_rd_para_state. rewrite <- Heqoff2 in *. lia.
      * bool_rel. repeat simpl in *; rewrite ZMap.gso. unfold gpt_false_ns in Hinv. intros.
      pose proof (Hinv gidx) as Hname. apply Hname in H. unfold GRANULE_STATE_NS in *.
      unfold GRANULE_STATE_ANY in *. destruct H. lia. lia. auto.
    + bool_rel. remember (poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} d) / 4096) as off2.
    destruct (off2 =? gidx) eqn:Hidx2. 
      * bool_rel. rewrite Hidx2 in *. simpl in *; rewrite ZMap.gss. simpl in *. rewrite ZMap.gso.
      unfold gpt_false_ns in Hinv. pose proof (Hinv gidx) as Hname. auto. auto.
      * bool_rel. repeat simpl in *; rewrite ZMap.gso. rewrite ZMap.gso. unfold gpt_false_ns in Hinv.
      pose proof (Hinv gidx) as Hname. auto. auto. auto.
  - simpl_some. repeat simpl_component. rewrite C3 in Hspec. rewrite C0 in Hspec.
    repeat rewrite strong_lens in Hspec. inversion Hspec. rewrite H1 in Hinv. assumption.
  - simpl_some. repeat simpl_component. rewrite C2 in Hspec. rewrite C0 in Hspec.
    repeat rewrite strong_lens in Hspec. inversion Hspec. rewrite H1 in Hinv. assumption.
  - simpl_some. repeat simpl_component. rewrite C3 in Hspec. rewrite C0 in Hspec.
    repeat rewrite strong_lens in Hspec. inversion Hspec. rewrite H1 in Hinv. assumption. 
  - simpl_some. repeat simpl_component. rewrite C2 in Hspec. rewrite C0 in Hspec.
    repeat rewrite strong_lens in Hspec. inversion Hspec. rewrite H1 in Hinv. assumption.
Qed.



