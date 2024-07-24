Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.
Require Import SecurityProof.SecurityDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Lemma gidx_to_table_pte_is_table:
  forall gidx, PTE_IS_TABLE (gidx_to_table_pte gidx) = true.
Admitted.

Lemma gidx_to_pte_to_gidx:
  forall gidx, pte_to_gidx (gidx_to_table_pte gidx) = gidx.
Admitted.

Lemma walk_star_prop:
  forall sh rd gfn rtt_idx (Hwalk_star: walk_star sh rd gfn rtt_idx),
    (rtt_idx = rd_rtt sh rd) \/
      exists rtt_idx0 offs0,
        walk_star sh rd gfn rtt_idx0
        /\ (sh.(granules) @ rtt_idx0).(e_state) = GRANULE_STATE_RTT
        /\ (rtt_idx = pte_to_gidx ((sh.(granule_data) @ rtt_idx0).(g_norm) @ offs0)).
Proof.
  intros.
  unfold walk_star in Hwalk_star.
  destruct Hwalk_star as (lvl & pte & N & Hwalk).
  induction N.
  - simpl in Hwalk. destruct Hwalk as (Hw1 & Hw2). inv Hw1.
    left. rewrite gidx_to_pte_to_gidx. reflexivity.
  - simpl in Hwalk. repeat simpl_hyp Hwalk; inv Hwalk.
    + right. repeat eexists. eapply C. bool_rel_all. assumption.
      inv H. reflexivity.
    + apply IHN. auto.
Qed.

Lemma walk_rtt_level_split:
  forall m,
  forall n sh lvl rd gfn pte lvl' pte' (Hwalk: walk_rtt_level n sh lvl rd gfn pte = (lvl', pte')),
    walk_rtt_level (m + n) sh lvl rd gfn pte = walk_rtt_level m sh lvl' rd gfn pte'.
Proof.
  induction m.
  simpl. intros. assumption.
  simpl. intros.
  erewrite IHm.
  2: apply Hwalk. reflexivity.
Qed.

Lemma invalid_start_walk_invalid:
  forall N sh lvl rd gidx pte (Hinvalid: pte_to_gidx pte = 0),
    walk_rtt_level N sh lvl rd gidx pte = (lvl, pte).
Proof.
  induction N.
  simpl; intros. reflexivity.
  intros. simpl. rewrite IHN. autounfold with spec.
  rewrite Hinvalid. rewrite zero_granule_state.
  destruct_if. lia. reflexivity. assumption.
Qed.

Lemma walk_rtt_level_unreachable_same:
  forall sh rd gfn Brtt (Hunreachable: forall rtt, Brtt rtt = true -> ~ walk_star sh rd gfn rtt),
  forall sh'
    (Hsame1: sh'.(granules) = sh.(granules))
    (Hsame2: forall rd, g_rd (sh'.(granule_data) @ rd) = g_rd (sh.(granule_data) @ rd))
    (Hsame3: forall rtt, Brtt rtt = false -> (sh'.(granule_data) @ rtt).(g_norm) = (sh.(granule_data) @ rtt).(g_norm)),
  forall N, walk_rtt_level N sh' 0 rd gfn (gidx_to_table_pte (rd_rtt sh' rd))
       = walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)).
Proof.
  simpl. intros until N.
  induction N.
  - simpl.
    unfold rd_rtt. simpl.
    rewrite Hsame2. reflexivity.
  - simpl. rewrite IHN.
    destruct (walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd))) eqn:Hwalk.
    rewrite Hsame1.
    destruct_if.
    unfold walk_one_step.
    destruct (Brtt (pte_to_gidx z0)) eqn:HB.
    + exploit Hunreachable. eassumption.
      unfold walk_star.
      repeat eexists. eassumption. contradiction.
    + rewrite Hsame3. reflexivity. assumption.
    + reflexivity.
Qed.

Lemma walk_unreachable_same:
  forall sh rd gfn Brtt (Hunreachable: forall rtt, Brtt rtt = true -> ~ walk_star sh rd gfn rtt),
  forall sh'
         (Hsame1: sh'.(granules) = sh.(granules))
         (Hsame2: forall rd, g_rd (sh'.(granule_data) @ rd) = g_rd (sh.(granule_data) @ rd))
         (Hsame3: forall rtt, Brtt rtt = false -> (sh'.(granule_data) @ rtt).(g_norm) = (sh.(granule_data) @ rtt).(g_norm)),
    walk_rtt sh' rd gfn = walk_rtt sh rd gfn.
Proof.
  intros. unfold walk_rtt.
  erewrite walk_rtt_level_unreachable_same; try eassumption.
  reflexivity.
Qed.

Lemma walk_rtt_same_set_slot:
  forall sh sl rd ipa, walk_rtt (sh.[slots] :< sl) rd ipa = walk_rtt sh rd ipa.
Admitted.

Lemma walk_rtt_same:
  forall sh' sh rd ipa,
    (forall g, (sh.(granules) @ g).(e_state) = GRANULE_STATE_RTT -> (sh.(granule_data) @ g).(g_norm) = (sh'.(granule_data) @ g).(g_norm)) ->
    walk_rtt sh rd ipa = walk_rtt sh' rd ipa.
Admitted.

Lemma walk_rtt_lens_same:
  forall st v rd ipa,
    walk_rtt (lens v st).(share) rd ipa = walk_rtt st.(share) rd ipa.
Admitted.

Lemma walk_rtt_granule_data_update_lens_same:
  forall st v v0 rd ipa,
    walk_rtt ((share (lens v st)).[granule_data] :< v0) rd ipa = walk_rtt ((share st).[granule_data] :< v0) rd ipa.
Admitted.

Lemma e_state_lens_same:
  forall st v i,
    ((lens v st).(share).(granules) @ i).(e_state) = (st.(share).(granules) @ i).(e_state).
Admitted.

Lemma g_norm_lens_same:
  forall st v i,
    ((lens v st).(share).(granule_data) @ i).(g_norm) = (st.(share).(granule_data) @ i).(g_norm).
Admitted.

Lemma walk_rtt_slots_unrelated:
  forall sh v rd ipa,
    walk_rtt (sh.[slots] :< v) rd ipa = walk_rtt sh rd ipa.
Admitted.

Lemma shared_inv_implies:
  forall sh, SharedInv sh -> SharedInvImply sh.
Admitted.

Lemma relate_walk_rtt_same:
  forall st st' rd ipa (Hrelate: id_share st.(share) st'.(share)),
    walk_rtt st.(share) rd ipa = walk_rtt st'.(share) rd ipa.
Admitted.

Lemma lens_same:
  forall st v, lens v st = st.
Admitted.

Ltac ext_repl Rsec Rnorm :=
  match type of Rsec with
  | repl ?sec_d ?l0 ?sh0 = Some ?sec_d' =>
      match type of Rnorm with
      | repl ?norm_d ?l1 ?sh1 = Some ?norm_d' =>
          exploit (oracle_rel sec_d norm_d sec_d' norm_d' Rsec Rnorm)
      end
  end.

Lemma granule_data_slots_update_permu:
  forall st v0 v1, ((share st).[granule_data] :< v0).[slots] :< v1 = ((share st).[slots] :< v1).[granule_data] :< v0.
Proof. easy. Qed.
