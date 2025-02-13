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
(* Require Import SMCHandler.Spec. *)

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.


Lemma handle_rsi_realm_get_attest_token_spec_walk_rev :
  forall d v_0 v_1 ret_d
    (Hspec: handle_rsi_realm_get_attest_token_spec v_0 v_1 d = Some(ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold handle_rsi_realm_get_attest_token_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
Qed.


Lemma handle_rsi_realm_extend_measurement_spec_walk_rev :
  forall d v_0 ret_n ret_d
    (Hspec: handle_rsi_realm_extend_measurement_spec v_0 d = Some(ret_n, ret_d))
    (Hinv: walk_rev d.(share)),
    walk_rev ret_d.(share).
Proof.
  intros. unfold handle_rsi_realm_extend_measurement_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; simpl_walk_rev; partial_simpl_walk_rev_and_solve Hspec.
Qed.
