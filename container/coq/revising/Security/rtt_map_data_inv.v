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

Parameter rtt_walk_abs : RData -> Z -> Z -> option Z.

(* TODO: set a equivalency between walk_abs and real walk update on rtt *)
(* Axiom rtt_walk_abs_update: 
  forall (st: RData) (st': RData) (rtt_idx ipa_gidx data_gidx: Z)
  (Hwalk: rtt_walk_abs st rtt_idx ipa_gidx = Some data_gidx),
    rtt_walk_abs st' rtt_idx ipa_gidx = Some data_gidx. *)

Parameter same_rtt_structure : RData -> RData -> Prop.

Lemma rtt_same_cond1: 
  forall st v d
  (Hirrelevant: (st.(share).(globals).(g_granules) @ v).(e_state_s_granule) <> GRANULE_STATE_RTT /\ (st.(share).(globals).(g_granules) @ v).(e_state_s_granule) <> GRANULE_STATE_DATA),
  (* same_rtt_structure st (st.[share].[granule_data] :< (st.(share).(granule_data) # v == d)). *)
  forall rtt_idx ipa_gidx,
    rtt_walk_abs st rtt_idx ipa_gidx = rtt_walk_abs (st.[share].[granule_data] :< (st.(share).(granule_data) # v == d)) rtt_idx ipa_gidx.
Admitted.

Definition rtt_walk_as_same_def (st_0 st_1 : RData) : Prop :=
  forall rtt_gidx ipa_gidx data_gidx
    (Hsame: same_rtt_structure st_0 st_1),
    rtt_walk_abs st_0 rtt_gidx ipa_gidx = Some data_gidx <-> rtt_walk_abs st_1 rtt_gidx ipa_gidx = Some data_gidx. 

Lemma rtt_walk_as_same: 
  forall st_0 st_1,
    rtt_walk_as_same_def st_0 st_1.
Admitted.

  
(* TODO: instantiated sub-lemmas here *)

Definition rtt_map_data_inv (st: RData) : Prop := 
  forall rtt_idx ipa_gidx data_gidx
    (Hrtt_is_root : rtt_is_root rtt_idx = true)
    (Hrtt: (st.(share).(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT)
    (Hwalk: rtt_walk_abs st rtt_idx ipa_gidx = Some data_gidx),
    ((st.(share).(globals).(g_granules) @ data_gidx).(e_state_s_granule) = GRANULE_STATE_DATA \/
    (st.(share).(globals).(g_granules) @ data_gidx).(e_state_s_granule) = GRANULE_STATE_ANY).

Lemma spinlock_acquire_spec_map_data_inv: 
	forall lock st ret_st 
	(Hspec: spinlock_acquire_spec lock st = Some ret_st)
	(Hinv: rtt_map_data_inv st),
	rtt_map_data_inv ret_st.
Admitted.

Lemma spinlock_release_spec_map_data_inv:
  forall lock st ret_st 
  (Hspec: spinlock_release_spec lock st = Some ret_st)
  (Hinv: rtt_map_data_inv st),
  rtt_map_data_inv ret_st.
Admitted.


Lemma granule_unlock_spec_map_data_inv:
  forall d v_0 ret_d
    (Hspec: granule_unlock_spec v_0 d = Some(ret_d))
    (Hinv: rtt_map_data_inv d),
    rtt_map_data_inv ret_d.
Admitted.

(* collects all subspecs needed *)
Ltac apply_subspec_invariants :=
  repeat match goal with
  | H : spinlock_acquire_spec ?lk ?st = Some ?st' |- _ =>
      apply spinlock_acquire_spec_map_data_inv in H; try assumption
  | H : spinlock_release_spec ?lk ?st = Some ?st' |- _ =>
      apply spinlock_release_spec_map_data_inv in H; try assumption
  | H : granule_unlock_spec ?v ?d = Some ?d' |- _ =>
      apply granule_unlock_spec_map_data_inv in H; try assumption
  end.

Lemma smc_realm_activate_spec_map_data_inv:
  forall v_0 st ret_n ret_st
    (Hspec: smc_realm_activate_spec v_0 st = Some(ret_n, ret_st))
    (Hinv: rtt_map_data_inv st),
    rtt_map_data_inv ret_st.
Proof with assumption.
  intros. unfold smc_realm_activate_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try unfold GRANULE_STATE_DATA in *; try unfold GRANULE_STATE_ANY in *; try assumption; inv Hspec.
  - apply spinlock_acquire_spec_map_data_inv in C1; try assumption.
    (* try prove inv as precond of subspec *)
    match goal with 
    | [H: context[granule_unlock_spec _ ?x] |- _] => assert(rtt_map_data_inv x)
    end.
    unfold rtt_map_data_inv in *; try unfold GRANULE_STATE_DATA in *; try unfold GRANULE_STATE_ANY in *; simpl in *.
    intros rtt_idx ipa_gidx data_gidx Hrtt_is_root Hrtt Hwalk.
    {
      (* contra: will not update rtt *)
      eapply C1; try eassumption. rewrite <- Hwalk.
      apply rtt_same_cond1. split; unfold not; intros; rewrite H in C2; inv C2.
    }
    eapply granule_unlock_spec_map_data_inv; repeat eassumption.
  - apply_subspec_invariants.
  - apply_subspec_invariants.
  - apply_subspec_invariants.
  - apply_subspec_invariants.
Qed.  
