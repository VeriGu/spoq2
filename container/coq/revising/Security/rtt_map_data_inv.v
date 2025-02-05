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
Require Import walk_inv.
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

Require Import Nat.
Require Import PeanoNat.

Lemma eqb_eq : forall n m : Z, (n =? m) = true -> n = m.
Proof. apply Z.eqb_eq. Qed.

Lemma eqb_neq : forall n m : Z, (n =? m) = false -> n <> m.
Proof. apply Z.eqb_neq. Qed.

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

Lemma rtt_same_cond2: 
  forall st v d
  (Hirrelevant: (st.(share).(globals).(g_granules) @ v).(e_state_s_granule) <> GRANULE_STATE_RTT /\ (st.(share).(globals).(g_granules) @ v).(e_state_s_granule) <> GRANULE_STATE_DATA),
  (* same_rtt_structure st (st.[share].[granule_data] :< (st.(share).(granule_data) # v == d)). *)
  forall rtt_idx ipa_gidx,
    rtt_walk_abs st rtt_idx ipa_gidx = rtt_walk_abs (st.[share].[globals].[g_granules] :< (st.(share).(globals).(g_granules) # v == d)) rtt_idx ipa_gidx.
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


Lemma lens_rtt_map_data_same: 
  forall m st, 
    rtt_map_data_inv st <-> rtt_map_data_inv (lens m st).
Admitted.


(* Abstracted-Pointer-specification for granule_unlock_spec *)
(* Lemma granule_unlock_spec_pointer_preserve: 
  forall d v_0 ret_d
    (Hspec: granule_unlock_spec v_0 d = Some(ret_d))
    (Hinv: rtt_map_data_inv d),
    rec_to_rd_para *)

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


Ltac intros_rd_para_state := 
  match goal with 
  | [H: context[rec_to_rd_para ?ptr ?x] |- _] => pose proof (rec_to_rd_para_state_rec ptr x) as Hrd; unfold GRANULE_STATE_RD in *
  end. 
  
(* Ltac simpl_component :=
  match goal with 
  | [H: context[memset_spec _ _ _] |- _] => try apply memset_spec_walk_rev_lens in H 
  | [H: context[granule_unlock_spec _ _] |- _] => try apply granule_unlock_spec_walk_rev_lens in H 
  | [H: context[spinlock_acquire_spec _ _] |- _] => try apply spinlock_acquire_spec_walk_rev_lens in H 
  | [H: context[spinlock_release_spec _ _] |- _] => try apply spinlock_release_spec_walk_rev_lens in H 
  end. 

Ltac simpl_walk_rev :=
  try unfold GRANULE_STATE_RTT in *; try unfold GRANULE_STATE_RD in *;
  try unfold GRANULE_STATE_REC in *; repeat simpl_component; try intros_rd_para_state. *)


Lemma memset_spec_rtt_map_data_lens : 
  forall st v_0 v_1 v_2 ret_n ret_st
  (Hspec: memset_spec v_0 v_1 v_2 st = Some(ret_n, ret_st)),
  ret_st = lens len_para st.
Admitted.

Lemma granule_unlock_spec_rtt_map_data_lens : 
  forall v_0 st ret_st
  (Hspec: granule_unlock_spec v_0 st = Some ret_st),
  ret_st = lens len_para st.
Admitted.

Axiom rtt_root_state : 
  forall st addr, 
    rtt_is_root addr = true -> 
    (st.(share).(globals).(g_granules) @ addr).(e_state_s_granule) = GRANULE_STATE_RTT.

Lemma lens_rtt_walk_abs_same: 
  forall m st rtt_idx ipa_gidx,
    rtt_walk_abs st rtt_idx ipa_gidx = rtt_walk_abs (lens m st) rtt_idx ipa_gidx.
Admitted.

(* Axiom rec_to_rd_para_get_offset: 
  forall ptr st,
    (rec_to_rd_para ptr st).(poffset) = ptr.(poffset). *)

Lemma rec_to_rd_para_offset_neq:
forall st rd,
  (rec_to_rd_para rd st).(poffset) <> rd.(poffset).
Admitted.

Lemma set_get_simpl1: 
  forall st idx d, 
    (st.(share).(globals).(g_granules) # idx == d) @ idx = d.
Admitted.
    (* Hrtt: ((g_granules (globals (share r0))) # rtt_idx == (((g_granules (globals (share r0))) @ rtt_idx).[e_state_s_granule]:< 1)) @ rtt_idx =  *)

Lemma smc_rec_destroy_spec_mem_data_inv: 
  forall v_0 st ret_n ret_st
    (Hspec: smc_rec_destroy_spec v_0 st = Some(ret_n, ret_st))
    (Hinv: rtt_map_data_inv st),
    rtt_map_data_inv ret_st.
Proof.
  intros. unfold smc_rec_destroy_spec in Hspec.
  autounfold with sem in *.
  repeat simpl_hyp Hspec; try unfold GRANULE_STATE_DATA in *; try unfold GRANULE_STATE_ANY in *; try assumption; inv Hspec.
  apply spinlock_acquire_spec_map_data_inv in C0; try assumption. 
  - pose proof C0 as Hinv_r.
    (* r -> (memset) -> r0 -> update state -> granule_unlock -> r1 *)
    apply (lens_rtt_map_data_same len_para r) in C0.
    apply memset_spec_rtt_map_data_lens in C4. rewrite <- C4 in *.
    apply granule_unlock_spec_rtt_map_data_lens in C6.  
    (* backward proof start *)
    remember (r0.[share].[globals].[g_granules] :< ((g_granules (globals (share r0))) # meta_granule_offset (test_PA v_0) / 4096 ==
    (((g_granules (globals (share r0))) @ (meta_granule_offset (test_PA v_0) / 4096)).[e_state_s_granule]:< 1))) as st'.
    remember (meta_granule_offset (test_PA v_0) / 4096) as goal_idx.
    {
      assert (rtt_map_data_inv st').
      {
        unfold rtt_map_data_inv; try unfold GRANULE_STATE_RTT, GRANULE_STATE_ANY, GRANULE_STATE_DATA in *; 
        intros rtt_idx ipa_gidx data_gidx Hrtt_is_root Hrtt Hwalk.
        assert (rtt_walk_abs st' rtt_idx ipa_gidx = rtt_walk_abs r0 rtt_idx ipa_gidx) as Heq_rtt_abs.
        { 
          rewrite Heqst'. symmetry. eapply rtt_same_cond2. 
          pose proof (lens_state_same r len_para goal_idx). rewrite <- C4 in H. rewrite H.
          split; unfold not; intros; rewrite H0 in C1; inv C1.
        }
        assert ((st'.(share).(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = (r.(share).(globals).(g_granules) @ rtt_idx).(e_state_s_granule)).
        { 
          rewrite Heqst'. simpl. destruct_zmap; subst. 
          apply (rtt_root_state r) in Hrtt_is_root. rewrite Hrtt_is_root in *. inv C1. 
          pose proof (lens_state_same r len_para rtt_idx). rewrite H. reflexivity. 
        }
        rewrite Heqst'. simpl in *. destruct_zmap; simpl;
        unfold rtt_map_data_inv in Hinv_r;
        rewrite Heq_rtt_abs in Hwalk; rewrite H in Hrtt; 
        pose proof (lens_rtt_walk_abs_same len_para r rtt_idx ipa_gidx) as Heq_rtt_abs0; rewrite <- C4 in Heq_rtt_abs0; rewrite <- Heq_rtt_abs0 in Hwalk;
        pose proof (Hinv_r rtt_idx ipa_gidx data_gidx Hrtt_is_root Hrtt Hwalk).
        + destruct H0; subst data_gidx goal_idx; rewrite H0 in C1; inv C1.
        + pose proof (lens_state_same r len_para data_gidx). subst r0. rewrite H1. auto.
      }
      assert (rtt_map_data_inv r1).
      { pose proof (lens_rtt_map_data_same len_para st') as Heqv_st'. rewrite <- C6 in Heqv_st'. apply Heqv_st'. assumption. }
      unfold rtt_map_data_inv; try unfold GRANULE_STATE_RTT, GRANULE_STATE_ANY, GRANULE_STATE_DATA in *.
      (* intros rtt_idx ipa_gidx data_gidx Hrtt_is_root Hrtt Hwalk; simpl in *. *)
        intros rtt_idx ipa_gidx data_gidx Hrtt_is_root; simpl in *.
      (* rtt_idx will not be updated entry *)
      destruct_zmap; simpl in *.
      + pose proof (rec_to_rd_para_state_rec {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) as Hrd.
        rewrite <- Heq in *.
        apply (rtt_root_state r) in Hrtt_is_root. rewrite Hrtt_is_root in Hrd. inv Hrd. 
      + intros.
        pose proof (rec_to_rd_para_state_rec {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) as Hrd.
        remember (poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) / 4096) as rd_idx.
        remember (r1.[share].[globals].[g_granules]
        :< ((g_granules (globals (share r1))) # poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) / 4096 ==
            (((g_granules (globals (share r1))) @
              (poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) / 4096)).[e_ref]
             :< ((e_ref
                    (g_granules (globals (share r1))) @
                    (poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) / 4096)).[e_u_anon_3_0]
                 :< (e_u_anon_3_0
                       (e_ref
                          (g_granules (globals (share r1))) @
                          (poffset (rec_to_rd_para {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r) / 4096)) + -1))))) as st''.
        assert (rtt_walk_abs st'' rtt_idx ipa_gidx = rtt_walk_abs r1 rtt_idx ipa_gidx) as Heq_rtt_abs.
        {
          rewrite Heqst''. symmetry. eapply rtt_same_cond2;
          remember (meta_granule_offset (test_PA v_0) / 4096) as rec_idx. destruct (rd_idx =? rec_idx) eqn:Hrd_rec.
          - split; unfold not; intros; rewrite Heqgoal_idx in *. 
            pose proof (lens_state_same st' len_para rd_idx). subst goal_idx. rewrite C6 in H1.
            rewrite <- Heqrd_idx in H1. rewrite H1 in H2. symmetry in H2. 
            pose proof (rec_to_rd_para_state_rec {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r). rewrite <- Heqrd_idx in *. 
            rewrite Heqst' in H2. simpl in H2.
            apply eqb_eq in Hrd_rec. rewrite Hrd_rec in H3. rewrite H3 in C1. inv C1.
            pose proof (lens_state_same st' len_para rd_idx). subst goal_idx. rewrite C6 in H1.
            rewrite <- Heqrd_idx in H1. rewrite H1 in H2. symmetry in H2. 
            pose proof (rec_to_rd_para_state_rec {| pbase := "granule_data"; poffset := meta_granule_offset (test_PA v_0) |} r). rewrite <- Heqrd_idx in *. 
            rewrite Heqst' in H2. simpl in H2.
            apply eqb_eq in Hrd_rec. rewrite Hrd_rec in H3. rewrite H3 in C1. inv C1.
          - apply eqb_neq in Hrd_rec. rewrite <- Heqrd_idx.
            pose proof (lens_state_same st' len_para rd_idx). rewrite <- C6 in H1. rewrite Heqst' in H1. rewrite H1. simpl in *. destruct_zmap. 
            rewrite Heq0 in Hrd_rec. contra. 
            pose proof (lens_state_same r len_para rd_idx). rewrite C4, H2. 
            split; unfold not; intros; rewrite Hrd in H3; inv H3.
        }
        rewrite <- Heqrd_idx in Heqst''. rewrite <- Heqst'' in Hwalk. rewrite Heq_rtt_abs in Hwalk.
        destruct_zmap; simpl in *;
        unfold rtt_map_data_inv in H0; pose proof (H0 rtt_idx ipa_gidx data_gidx Hrtt_is_root Hrtt Hwalk); try assumption.
        rewrite Heq0 in H1; assumption.
    }
  - apply_subspec_invariants.
  - apply_subspec_invariants.
  - apply_subspec_invariants.
  - apply_subspec_invariants.
Qed.