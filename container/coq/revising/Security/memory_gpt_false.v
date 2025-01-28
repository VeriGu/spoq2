Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Bottom.Spec.
Require Import Layer13.Spec_gpt.
Require Import Layer9.Spec.
Require Import Layer8.Spec.
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






Ltac find_if_inside_and_simpl H Hspec :=
  match type of H with
    | context[if ?X then _ else _]  => 
      destruct X in H; try(inversion Hspec; apply lens_gpt; assumption)
  end.

Lemma smc_read_feature_register_gpt:
  forall norm_d v_0 v_1 norm_d'
   (Hspec: smc_read_feature_register_spec v_0 v_1 norm_d = Some (norm_d'))
   (Hinv: gpt_false_ns norm_d.(share)),
     gpt_false_ns norm_d'.(share).
Proof.
  intros. unfold smc_read_feature_register_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec.
  unfold max_pa_size_spec' in C1.
  find_if_inside_and_simpl C1 Hspec.
  inversion Hspec. apply lens_gpt. assumption.
Qed.

Ltac inversion_apply H I :=
  inversion H; apply I; assumption.

Lemma smc_realm_activate_gpt:
  forall norm_d v_0 norm_d' ret_n
   (Hspec: smc_realm_activate_spec v_0 norm_d = Some (ret_n, norm_d'))
   (Hinv: gpt_false_ns norm_d.(share)),
     gpt_false_ns norm_d'.(share).
Proof.
  intros. unfold smc_realm_activate_spec in Hspec.
  autounfold with sem in *. 
  repeat simpl_hyp Hspec; inversion_apply Hspec lens_gpt.
Qed.

Lemma find_lock_granule_spec_gpt:
  forall norm_d v_0 v_1 norm_d' ret_n
  (Hspec: find_lock_granule_spec v_0 v_1 norm_d = Some(ret_n, norm_d'))
  (Hinv: gpt_false_ns norm_d.(share)),
    gpt_false_ns norm_d'.(share).
Admitted.

Lemma pack_return_code_spec_gpt:
  forall norm_d v_0 v_1 norm_d' ret_n
  (Hspec: pack_return_code_spec v_0 v_1 norm_d = Some(ret_n, norm_d'))
  (Hinv: gpt_false_ns norm_d.(share)),
    gpt_false_ns norm_d'.(share).
Admitted.


Lemma smc_granule_delegate_gpt:
  forall norm_d v_0 v_1 norm_d' ret_n
  (Hspec: smc_granule_delegate_gpt_spec v_0 v_1 norm_d = Some(ret_n, norm_d'))
  (Hinv: gpt_false_ns norm_d.(share)),
    gpt_false_ns norm_d'.(share).
Proof.
  intros. unfold smc_granule_delegate_gpt_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec.
  - apply pack_return_code_spec_gpt in C5. inversion Hspec.
    rewrite <- H1. assumption.
    apply find_lock_granule_spec_gpt in C0. assumption.
    assumption.
  -  inversion Hspec. unfold gpt_false_ns. intros.
    rewrite lens_gpt_same in H.  rewrite lens_gpt_same in H.
    auto. rewrite lens_state_same.
    rewrite lens_state_same.
    match goal with
    | |- context [(?m # ?b == ?c)] => destruct (gidx =? b) eqn: H2; bool_rel
    end.
    + rewrite <- H2 in *. simpl in *. rewrite lens_gpt_same in H. simpl in *.
    solve_refproof. easy.
    + solve_refproof. repeat(rewrite lens_gpt_same in *). repeat(rewrite lens_state_same in *).  rewrite <- H0 in *. unfold gpt_false_ns in Hinv.
    pose proof (Hinv gidx) as Hinv_gidx. 
    vcgen. simpl in H.  rewrite lens_gpt_same in H. simpl in H. rewrite ZMap.gso in H. 
    { 
      apply find_lock_granule_spec_gpt in C0.
      unfold gpt_false_ns in C0.
      pose proof (C0 gidx) as Hinv_gidx2.
      simpl_imply Hinv_gidx2.
      easy.
      easy. 
    }
    {  easy. }
Qed.
  



Lemma rsi_rtt_destroy_spec_gpt:
  forall norm_d v_0 v_1 v_2 v_3 norm_d' ret_n
   (Hspec: rsi_rtt_destroy_gpt_spec v_0 v_1 v_2 v_3 norm_d = Some (ret_n, norm_d'))
   (Hinv: gpt_false_ns norm_d.(share)),
     gpt_false_ns norm_d'.(share).
Proof.
  intros. unfold rsi_rtt_destroy_gpt_spec in Hspec.
  autounfold with sem in *.  
  unfold free_stack in *.
  unfold new_frame in *.
  repeat simpl_hyp Hspec;
  repeat(inversion Hspec; repeat(apply lens_gpt); easy).
Qed.



(*
Lemma map_unmap_ns_s1_gpt_false:
  forall norm_d v_0 v_1 v_2 v_3 v_4 ret_n norm_d'
    (Hspec: map_unmap_ns_s1_spec v_0 v_1 v_2 v_3 v_4 norm_d = Some (ret_n, norm_d'))
    (Hinv: gpt_false_ns norm_d.(share)),
    gpt_false_ns norm_d'.(share).
Proof.
intros.
unfold map_unmap_ns_s1_spec in Hspec.
autounfold with sem in *.
unfold free_stack in *.
autounfold with sem in *.
repeat simpl_hyp Hspec.
- inv Hspec. unfold new_frame in C1. inv C1. apply find_granule_spec_gpt_false in C2.
apply pack_return_code_gpt_false in C6. apply C6. apply C2. easy.
- 
unfold free_stack in C8. inv C8. simpl.

unfold free_stack in C8.
unfold new_frame in C1.
(* apply find_granule_spec_gpt_false in C2. *)
apply pack_return_code_gpt_false in C6.



inv Hnorm.
 inv Hsec; inv Hnorm.




 *)
