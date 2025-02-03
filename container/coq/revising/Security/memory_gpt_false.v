Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Bottom.Spec.
Require Import Layer13.Spec_gpt.
Require Import Layer9.Spec.
Require Import Layer8.Spec.
Require Import Layer2.Spec.
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

Lemma update_ripas_spec_gpt:
  forall norm_d v_0 v_1 v_2 norm_d' ret_n
  (Hspec: update_ripas_spec v_0 v_1 v_2 norm_d = Some(ret_n, norm_d'))
  (Hinv: gpt_false_ns norm_d.(share)),
    gpt_false_ns norm_d'.(share).
Admitted.

Lemma granule_map_gpt:
  forall norm_d v_0 v_1 norm_d' ret_n
  (Hspec: granule_map_spec v_0 v_1 norm_d = Some(ret_n, norm_d'))
  (Hinv: gpt_false_ns norm_d.(share)),
   gpt_false_ns norm_d'.(share).
Admitted.


Lemma rsi_rtt_set_ripas_spec:
  forall norm_d v_0 v_1 v_2 v_3 norm_d' ret_n
  (Hspec: rsi_rtt_set_ripas_gpt_spec v_0 v_1 v_2 v_3 norm_d = Some(ret_n, norm_d'))
  (Hinv: gpt_false_ns norm_d.(share)),
    gpt_false_ns norm_d'.(share).
Proof.
  intros. unfold rsi_rtt_set_ripas_gpt_spec in Hspec.
  unfold abstracted__tte_read_spec.
  autounfold with sem in *.
  (* repeat  *)
  (* ( *)
  repeat(simpl_hyp Hspec;
  unfold rtt_walk_lock_unlock_gpt_spec in *;
  unfold abstracted__tte_read_spec in *;
  unfold granule_unlock_gpt_spec in *).
  - inversion Hspec. apply lens_gpt. easy.
  - (* repeat simpl_func C9. *)
    (* repeat simpl_func C18. *)
    (* repeat simpl_func C15. *)
    assert (gpt_false_ns (share (lens 96 (lens 123 (lens 26 norm_d))))).
    repeat apply lens_gpt.
    easy. apply update_ripas_spec_gpt in C9.
    simpl_some. inversion Hspec. repeat apply lens_gpt. easy.
    repeat apply lens_gpt. easy.
  - simpl_some. inversion Hspec.
    autounfold with sem in *.
    repeat simpl_hyp C9.
    repeat simpl_func C10.
    unfold gpt_false_ns.
    intros. simpl in *.
    match goal with 
    | [H: context[gpt (share (lens ?a ?b))] |- _] => assert( gpt_false_ns (share (lens a b)) ); [ repeat apply lens_gpt; easy| ]
    end. 
    unfold gpt_false_ns in H0. destruct_zmap. simpl in *. rewrite <- Heq. 
    pose proof (H0 gidx) as H01. auto.
    pose proof (H0 gidx) as H01. auto.
  - simpl_some. inversion Hspec. repeat apply lens_gpt. easy.
  - match goal with 
    | [H: context[update_ripas_spec _ _ _ (lens ?a ?b)] |- _] => assert( gpt_false_ns (share (lens a b)) ); [ repeat apply lens_gpt; auto | apply update_ripas_spec_gpt in H] 
    end. inversion Hspec. repeat apply lens_gpt. auto. exact H.
  - admit.
  - simpl_some. inversion Hspec. repeat apply lens_gpt. easy.
  - admit.
  - admit.
  - simpl_some. inversion Hspec. repeat apply lens_gpt. easy. 
  -admit.
  - autounfold with sem in *. 
    repeat match goal with 
    | [H: (match _ with _ => _ end) = _ |- _] => repeat simpl_hyp H; repeat simpl_some
    end.  
    inversion Hspec.
    simpl_func C13. simpl_func C14. simpl in *. clear Hspec.
    unfold gpt_false_ns. simpl. intros.
    destruct_zmap.
    + simpl. rewrite <- Heq. d
    
    vcgen.


    unfold_spec C13.
  
  admit.
  -  simpl_some. inversion Hspec. repeat apply lens_gpt. easy. 
 
  
  
  repeat match goal with 
  | [H: (match _ with _ => _ end) = _ |- _] => repeat simpl_hyp H; repeat simpl_some
  end.  
    (* simpl_some.  inversion C18. inversion C15. *)
    (* assert (gpt_false_ns (share (lens 96 r))) as Hr. *)
    (* simpl in *.  frewrite. rewrite <- H3.  *)
    repeat apply lens_gpt; easy.
    match goal with 
    | [H: context[update_ripas_spec _ _ _ (lens ?a ?b)] |- _] => assert( gpt_false_ns (share (lens a b)) ); [ easy | apply update_ripas_spec_gpt in H]
    end. 
    repeat apply lens_gpt. easy. easy.
    match goal with 
    | [H: context[update_ripas_spec _ _ _ (lens ?a ?b)] |- _] => assert( gpt_false_ns (share (lens a b)) )
    end. 
    autounfold with sem in *.
    repeat match goal with 
    | [H: (match _ with _ => _ end) = _ |- _] => repeat simpl_hyp H; repeat simpl_some
    end. 
    inversion C18. inversion C15.
    rewrite <- H1. rewrite <- H3.
    repeat apply lens_gpt. easy.
    match goal with 
    | [H: context[update_ripas_spec _ _ _ (lens ?a ?b)] |- _] => assert( gpt_false_ns (share (lens a b)) ); [ easy | apply update_ripas_spec_gpt in H]
    end.  apply lens_gpt. easy.
    easy.
    autounfold with sem in *.
    repeat match goal with 
    | [H: (match _ with _ => _ end) = _ |- _] => repeat simpl_hyp H; repeat simpl_some
    end. 
    inversion C18. inversion C15.
    match goal with 
    | [H: context[update_ripas_spec _ _ _ (lens ?a ?b)] |- _] => assert( gpt_false_ns (share (lens a b)) )
    end. 
    rewrite <- H1. rewrite <- H3. 
    repeat apply lens_gpt. easy.
    apply update_ripas_spec_gpt in C11.
    repeat apply lens_gpt. easy. easy.
  - autounfold with sem in *.
    repeat simpl_hyp C9. unfold_spec C10. 
    autounfold with sem in *.
    repeat simpl_hyp C10.
    simpl in C10. simpl_some.
    unfold gpt_false_ns.
    intros. inversion Hspec. 
    solve_refproof.
    rewrite <- C10.
    simpl in *.
    destruct_zmap.
    + simpl in *. rewrite <- Heq. eapply lens_gpt.  repeat apply lens_gpt; easy. rewrite <- C10 in H. 
    simpl in *.  easy.
    + unfold gpt_false_ns in Hinv. rewrite <- C10 in H. simpl in *.  pose proof (Hinv gidx) as H_proof.
    destruct H_proof. repeat rewrite -> lens_gpt_same in H. easy. repeat rewrite -> lens_state_same.
    constructor. easy. right. repeat rewrite -> lens_state_same. easy.
  - simpl_some. inversion Hspec. repeat apply lens_gpt.  easy.
  - match goal with 
    | [H: context[update_ripas_spec _ _ _ (lens ?a ?b)] |- _] => assert( gpt_false_ns (share (lens a b)) )
    end.   
    simpl_func C9;
    autounfold with sem in *;
    repeat match goal with 
    | [H: (match _ with _ => _ end) = _ |- _] => repeat simpl_hyp H; repeat simpl_some
    end;
    repeat(inversion C18; inversion C15;
    rewrite <- H1; rewrite <- H3;
    repeat apply lens_gpt; easy).
    inversion Hspec. 
    apply update_ripas_spec_gpt in C11.
    repeat apply lens_gpt; easy.
    easy.
  -  simpl_func C9.  autounfold with sem in *. simpl in *.
     repeat match goal with 
     | [H: (match _ with _ => _ end) = _ |- _] => repeat simpl_hyp H; repeat simpl_some
     end.
     rewrite <- C11.
     unfold gpt_false_ns.
     simpl in *. intros.
     destruct_zmap
     + simpl in *. rewrite <- Heq. eapply lens_gpt.  repeat apply lens_gpt; easy. easy.
     + unfold gpt_false_ns in Hinv.   pose proof (Hinv gidx) as H_proof.
     destruct H_proof. repeat rewrite -> lens_gpt_same in H. easy. repeat rewrite -> lens_state_same.
     constructor. easy. right. repeat rewrite -> lens_state_same. easy.
  - simpl_some. inversion Hspec. repeat apply lens_gpt. easy.
  - assert (gpt_false_ns (share (r))) as H01.
    + assert (gpt_false_ns (share (lens 26 norm_d))) as H02. repeat apply lens_gpt. easy. 
      remember (lens 26 norm_d) as x.
      remember ({|
        pbase := "granules";
        poffset := (v_0 & -2 + - MEM1_PHYS) >> 524300 * 16
      |}) as y.
      apply (granule_map_gpt x y 3 r p0).  exact C5.
      exact H02.
    + admit.
  - admit.
   -simpl_some. inversion Hspec. repeat apply lens_gpt. easy.
  - admit.
  - admit.
  -simpl_some. inversion Hspec. repeat apply lens_gpt. easy.
Admitted.