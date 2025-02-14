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
Require Import rd_reverse.
Require Import SecurityProof.


Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma map_unmap_ns_s1_spec_rd_rev:
  forall d v_0 v_1 v_2 v_3 v_4 ret_n ret_d
    (Hspec: map_unmap_ns_s1_spec v_0 v_1 v_2 v_3 v_4 d = Some(ret_n, ret_d))
    (Hinv: rd_rev d.(share)),
    rd_rev ret_d.(share).
Proof.
  intros.  unfold map_unmap_ns_s1_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try intros_ensure_state; repeat simpl_component; partial_simpl_rd_rev_and_solve Hspec.
  all: try simpl in *; repeat simpl_component; try partial_simpl_rd_rev_and_solve.
  all: simpl_rtt_idx_all_2.
  all: repeat rewrite strong_lens in *; intros.
  all: pose proof Hinv as Hinv2.
  all: apply (@keep_rd_rev (share d) (share ret_d) Hinv2).
  all: intros; inv Hspec. 
  all: try(simpl in *; retrieve_idx).
  all: try( split; [ try auto | try auto]).
  all: try rewrite lens_ignore_g_granules_update in H; auto.
  all: simpl_walk_rev.
  all: try (destruct_zmap' H; simpl in *; [ try lia | repeat rewrite lens_ignore_g_granules_update in H ]).
  all: try auto.
  all: repeat rewrite lens_ignore_g_granules_update in *; try auto.
  all: try(destruct_zmap; [ rewrite Heq in *; simpl in *; try lia | auto ]).
  all: try(destruct_zmap; [ rewrite Heq0 in *; simpl in *; try lia | auto ]).
Qed.
 
