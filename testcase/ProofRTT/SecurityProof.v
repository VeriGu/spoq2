Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

(************************************************************************************)

Record SecureRealmState :=
  SecRm {
      sec_mem: ZMap.t (ZMap.t (option Z));
      sec_reg: ZMap.t (ZMap.t (option Z))
    }.

Definition update_SecureRealmState_sec_mem (a: SecureRealmState) b := SecRm b (sec_reg a).
Notation "a '.[sec_mem]' ':<' b" := (update_SecureRealmState_sec_mem a b) (at level 1).
Definition update_SecureRealmState_sec_reg (a: SecureRealmState) b := SecRm (sec_mem a) b.
Notation "a '.[sec_reg]' ':<' b" := (update_SecureRealmState_sec_reg a b) (at level 1).

Definition SecState := ZMap.t SecureRealmState.

(************************************************************************************)

Parameter addr_to_gidx: Z -> Z.
Parameter gfn_to_rtt_offs: Z -> Z -> Z.
Parameter gfn_to_pte_offs: Z -> Z -> Z.
Parameter ADDR_MASK: Z.
Parameter PTE_IS_VALID: Z -> bool.
Parameter PTE_IS_TABLE: Z -> bool.
Parameter gidx_to_table_pte : Z -> Z.
Parameter pte_to_gidx: Z -> Z.

Axiom zero_granule_state: forall sh, (sh.(granules) @ 0).(e_state) = -1.

Lemma gidx_to_table_pte_is_table:
  forall gidx, PTE_IS_TABLE (gidx_to_table_pte gidx) = true.
Admitted.

Lemma gidx_to_pte_to_gidx:
  forall gidx, pte_to_gidx (gidx_to_table_pte gidx) = gidx.
Admitted.

Definition walk_one_step sh lvl gfn rtt_idx :=
  let offs := gfn_to_rtt_offs gfn lvl in
  (sh.(granule_data) @ rtt_idx).(g_norm) @ offs.

Fixpoint walk_rtt_level (n: nat) (sh: Shared) (lvl: Z) (rd: Z) (gfn: Z) (pte: Z) :=
  match n with
  | O => (lvl, pte)
  | S n' =>
    match walk_rtt_level n' sh lvl rd gfn pte with
    | (lvl', pte') =>
      let rtt_idx' := pte_to_gidx pte' in
      if ((sh.(granules) @ rtt_idx').(e_state) =? GRANULE_STATE_RTT) then
        let pte'' := walk_one_step sh lvl' gfn rtt_idx' in
        (lvl' + 1, pte'')
      else
        (lvl', pte')
    end
  end.

Definition rd_rtt sh rd := (sh.(granule_data) @ rd).(g_rd).(e_rd_s2_ctx).(e_rls2ctx_g_rtt).

Definition walk_rtt sh rd gfn :=
  let rtt_pte := gidx_to_table_pte (rd_rtt sh rd) in
  match walk_rtt_level 4%nat sh 0 rd gfn rtt_pte with
  | (lvl', pte') =>
    if PTE_IS_VALID pte' then
      let idx' := pte_to_gidx pte' in
      Some (idx' + gfn_to_pte_offs lvl' gfn)
    else
      None
  end.

Definition walk_star (sh: Shared) (rd: Z) (gfn: Z) (rtt_idx: Z) : Prop :=
  exists lvl pte N,
    walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)) = (lvl, pte)
    /\ rtt_idx = pte_to_gidx pte.


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

Definition walk_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> (Z * Z)),
  forall rd gfn rtt_idx
    (Hwalk: walk_star sh rd gfn rtt_idx)
    (Hrtt: (sh.(granules) @ rtt_idx).(e_state) = GRANULE_STATE_RTT),
    forall par_idx ofs, rev rtt_idx = (par_idx, ofs) ->
                   ((rtt_idx = rd_rtt sh rd -> par_idx = rd /\ ofs = 0)
                    /\ (rtt_idx <> rd_rtt sh rd ->
                       ((sh.(granules) @ par_idx).(e_state) = GRANULE_STATE_RTT
                        /\ pte_to_gidx ((sh.(granule_data) @ par_idx).(g_norm) @ ofs) = rtt_idx))).

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

Definition rd_rtt_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> Z),
  forall rd rtt_idx (Hrtt: rd_rtt sh rd = rtt_idx), rev rtt_idx = rd.

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

Definition secure_realm_access_mem
  (rd_gidx: Z) (addr: Z) (val: Z) (st: (RData * SecState)) : option ((RData * SecState) * Z)
  :=
  let (st, sec_st) := st in
  rely ((0 < addr < 4294967296));
  rely (0 <= val < 256);
  rely (0 <= rd_gidx < 1048576);
  let grd := st.(share).(granules) @ rd_gidx in
  let rd := st.(share).(granules) @ rd_gidx in
  rely (e_state rd = GRANULE_STATE_RD);
  let ipa_gidx := addr_to_gidx addr in
  let offset := addr mod 4096 in
  match walk_rtt st.(share) rd_gidx ipa_gidx with
  | Some pa_gidx =>
    let data := (st.(share).(granule_data) @ pa_gidx).(g_norm) in
    let sec_data := (sec_st @ rd_gidx).(sec_mem) in
    let sec_data' := sec_data # pa_gidx == ((sec_data @ pa_gidx) # offset == (Some val)) in
    let sec_st' := sec_st # rd_gidx == ((sec_st @ rd_gidx) .[sec_mem] :< sec_data') in
    match (sec_data @ pa_gidx) @ offset with
    | Some val => Some ((st, sec_st'), val)
    | None => Some ((st, sec_st'), data @ offset)
    end
  | None => Some ((st, sec_st), 0)
  end.

Definition normal_realm_access_mem
  (rd_gidx: Z) (addr: Z) (val: Z) (st: RData) : option (RData * Z)
  :=
  rely ((0 < addr < 4294967296));
  rely (0 <= val < 256);
  rely (0 <= rd_gidx < 1048576);
  let grd := st.(share).(granules) @ rd_gidx in
  let rd := st.(share).(granules) @ rd_gidx in
  rely (e_state rd = GRANULE_STATE_RD);
  let ipa_gidx := addr_to_gidx addr in
  let offset := addr mod 4096 in
  match walk_rtt st.(share) rd_gidx ipa_gidx with
  | Some pa_gidx =>
    let data := (st.(share).(granule_data) @ pa_gidx).(g_norm) in
    let data' := data # offset == val in
    let gd' := (st.(share).(granule_data) @ pa_gidx).[g_norm] :< data' in
    let st' := st.[share].[granule_data] :< (st.(share).(granule_data) # pa_gidx == gd') in
    Some (st', data @ offset)
  | None => Some (st, 0)
  end.

Definition host_access_mem
  (addr: Z) (val: Z) (st: RData) : option (RData * Z)
  :=
  rely ((0 < addr < 4294967296));
  rely (0 <= val < 256);
  let pa_gidx := addr_to_gidx addr in
  let offset := addr mod 4096 in
  if st.(share).(gpt) @ pa_gidx then
    None
  else
    let data := (st.(share).(granule_data) @ pa_gidx).(g_norm) in
    let data' := data # offset == val in
    let gd' := (st.(share).(granule_data) @ pa_gidx).[g_norm] :< data' in
    let st' := st.[share].[granule_data] :< (st.(share).(granule_data) # pa_gidx == gd') in
    Some (st', data @ offset).

(************************************************************************************)

Definition gpt_false_ns (sh: Shared) :=
  forall gidx, sh.(gpt) @ gidx = false -> (sh.(granules) @ gidx).(e_state) = GRANULE_STATE_NS.

Parameter zero_granule: GranuleDataNormal.

Definition delegated_zero (sh: Shared) :=
  forall gidx (Hdel: (sh.(granules) @ gidx).(e_state) = GRANULE_STATE_DELEGATED),
    sh.(granule_data) @ gidx = zero_granule.

Definition rtt_map_data (sh: Shared) :=
  forall rd_gidx (Hrd: (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
    ipa_gidx data_gidx (Hwalk: walk_rtt sh rd_gidx ipa_gidx = Some data_gidx),
    (sh.(granules) @ data_gidx).(e_state) = GRANULE_STATE_DATA.

Definition rec_rd_prop (sh: Shared) :=
  forall gidx (Hrec: (sh.(granules) @ gidx).(e_state) = GRANULE_STATE_REC),
    let rd_gidx := (sh.(granule_data) @ gidx).(g_rec).(e_realm_info).(e_g_rd) in
    (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD.


Record SharedInv (sh: Shared) : Prop :=
  {
    gpt_false_ns_inv: gpt_false_ns sh;
    delegated_zero_inv: delegated_zero sh;
    rtt_map_data_inv: rtt_map_data sh;
    walk_reverse_inv: walk_reverse sh;
    rd_rtt_reverse_inv: rd_rtt_reverse sh;
  }.

Record SharedInvImply (sh: Shared) : Prop :=
  {
    diff_rd_diff_data:
    forall rd_gidx rd_gidx'
      (Hrd: (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
      (Hrd': (sh.(granules) @ rd_gidx').(e_state) = GRANULE_STATE_RD)
      (Hrd_ne: rd_gidx <> rd_gidx')
      ipa_gidx data_gidx ipa_gidx' data_gidx'
      (Hwalk: walk_rtt sh rd_gidx ipa_gidx = Some data_gidx)
      (Hwalk': walk_rtt sh rd_gidx' ipa_gidx' = Some data_gidx'),
      data_gidx <> data_gidx';

    diff_ipa_diff_data:
    forall rd_gidx rd_gidx'
      (Hrd: (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
      (Hrd': (sh.(granules) @ rd_gidx').(e_state) = GRANULE_STATE_RD)
      ipa_gidx data_gidx ipa_gidx' data_gidx'
      (Hrd_ne: ipa_gidx <> rd_gidx')
      (Hwalk: walk_rtt sh rd_gidx ipa_gidx = Some data_gidx)
      (Hwalk': walk_rtt sh rd_gidx' ipa_gidx' = Some data_gidx'),
      data_gidx <> data_gidx';

    rtt_reverse_inv:
    exists data_to_rd,
    forall rd_gidx (Hrd: (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
      ipa_gidx data_gidx (Hwalk: walk_rtt sh rd_gidx ipa_gidx = Some data_gidx),
      data_to_rd data_gidx = (rd_gidx, ipa_gidx);

    walk_rd_unique_inv:
    forall rd1 gfn1 rd2 gfn2 rtt_idx
      (Hwalk: walk_star sh rd1 gfn1 rtt_idx)
      (Hwalk: walk_star sh rd2 gfn2 rtt_idx),
      rd1 = rd2;

    update_entry_child_unreachable:
    forall rd gfn rtt
      (Hwalk1: walk_star sh rd gfn rtt)
      (Htable1: (sh.(granules) @ rtt).(e_state) = GRANULE_STATE_RTT)
      idx rtt2
      (Hchild: pte_to_gidx ((sh.(granule_data) @ rtt).(g_norm) @ idx) = rtt2)
      new_entry (Hne: PTE_IS_VALID new_entry = false \/ pte_to_gidx new_entry <> rtt2),
      forall rd' gfn',
        ~ walk_star (sh.[granule_data] :<
                       (sh.(granule_data) # rtt ==
                          ((sh.(granule_data) @ rtt).[g_norm] :<
                            (((sh.(granule_data) @ rtt).(g_norm)) # idx == new_entry))))
          rd' gfn' rtt2;

    child_unreachable_update_entry_same:
    forall rd gfn rtt
      (Hwalk1: walk_star sh rd gfn rtt)
      (Htable1: (sh.(granules) @ rtt).(e_state) = GRANULE_STATE_RTT)
      idx rtt2
      (Hchild: pte_to_gidx ((sh.(granule_data) @ rtt).(g_norm) @ idx) = rtt2),
    forall rd' gfn' (Hunreachable: ~ walk_star sh rd' gfn' rtt2),
    forall new_entry N,
      let sh' :=
        (sh.[granule_data] :<
           (sh.(granule_data) # rtt ==
              ((sh.(granule_data) @ rtt).[g_norm] :<
                 (((sh.(granule_data) @ rtt).(g_norm)) # idx == new_entry))))
      in
      walk_rtt_level N sh' 0 rd' gfn' (gidx_to_table_pte (rd_rtt sh' rd')) =
        walk_rtt_level N sh 0 rd' gfn' (gidx_to_table_pte (rd_rtt sh rd'));

    modify_leaf_same:
    forall N rd gfn lvl pte (Hwalk: walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)) = (lvl, pte))
      (Htable: (sh.(granules) @ (pte_to_gidx pte)).(e_state) = GRANULE_STATE_RTT),
    forall new_table,
      let sh' :=
        (sh.[granule_data] :<
           (sh.(granule_data) # (pte_to_gidx pte) == ((sh.(granule_data) @ (pte_to_gidx pte)).[g_norm] :< new_table)))
      in
      walk_rtt_level N sh' 0 rd gfn (gidx_to_table_pte (rd_rtt sh' rd)) = (lvl, pte);

    walk_star_continue:
    forall rd gfn rtt
      (Hwalk1: walk_star sh rd gfn rtt)
      (Htable1: (sh.(granules) @ rtt).(e_state) = GRANULE_STATE_RTT),
    exists N,
      walk_rtt_level 4 sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)) =
        walk_rtt_level (S N) sh (3 - Z.of_nat N) rd gfn (gidx_to_table_pte rtt);

    walk_same_parent_same:
    forall rd gfn rtt
      (Hwalk1: walk_star sh rd gfn rtt)
      (Htable1: (sh.(granules) @ rtt).(e_state) = GRANULE_STATE_RTT)
      idx rtt2
      (Hchild: pte_to_gidx ((sh.(granule_data) @ rtt).(g_norm) @ idx) = rtt2)
      (Htable2: (sh.(granules) @ rtt2).(e_state) = GRANULE_STATE_RTT)
      rd' gfn'
      (Hwalk': walk_star sh rd' gfn' rtt2),
    exists N,
      walk_rtt_level N sh 0 rd' gfn' (gidx_to_table_pte (rd_rtt sh rd')) = (Z.of_nat N, gidx_to_table_pte rtt) /\
        gfn_to_rtt_offs gfn' (Z.of_nat N) = idx /\ Z.of_nat N < 4;
  }.

Lemma shared_inv_implies:
  forall sh, SharedInv sh -> SharedInvImply sh.
Admitted.

(************************************************************************************)

Record relate_secure (sec_rdata: RData) (sec_st: SecState) (norm_rdata: RData) : Prop :=
  {
    mem_rel:
    forall rd_gidx (Hrd: (sec_rdata.(share).(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
      vaddr data_gidx (Hwalk: walk_rtt (sec_rdata.(share)) rd_gidx (addr_to_gidx vaddr) = Some data_gidx),
      let norm_data := (norm_rdata.(share).(granule_data) @ data_gidx).(g_norm) in
      let sec_data := (sec_rdata.(share).(granule_data) @ data_gidx).(g_norm) in
      let offset := vaddr mod 4096 in
      match ((sec_st @ rd_gidx).(sec_mem) @ data_gidx) @ offset with
      | Some val => norm_data @ offset = val
      | None => norm_data @ offset = sec_data @ offset
      end
  }.

Record id_share (sec_share: Shared) (norm_share: Shared) : Prop :=
  {
    id_gpt: norm_share.(gpt) = sec_share.(gpt);
    id_glk: norm_share.(glk) = sec_share.(glk);
    id_slots: norm_share.(slots) = sec_share.(slots);
    id_granules: norm_share.(granules) = sec_share.(granules);
    id_gd_g_idx: forall i, (norm_share.(granule_data) @ i).(gd_g_idx) = (sec_share.(granule_data) @ i).(gd_g_idx);
    id_g_rd: forall i, (norm_share.(granule_data) @ i).(g_rd) = (sec_share.(granule_data) @ i).(g_rd);
    id_g_rec: forall i, (norm_share.(granule_data) @ i).(g_rec) = (sec_share.(granule_data) @ i).(g_rec);
    id_g_aux_pmu_state: forall i, (norm_share.(granule_data) @ i).(g_aux_pmu_state) = (sec_share.(granule_data) @ i).(g_aux_pmu_state);
    id_g_aux_simd_state: forall i, (norm_share.(granule_data) @ i).(g_aux_simd_state) = (sec_share.(granule_data) @ i).(g_aux_simd_state);
    id_rec_gidx: forall i, (norm_share.(granule_data) @ i).(rec_gidx) = (sec_share.(granule_data) @ i).(rec_gidx);
    id_g_norm:
      forall i (Hnd: (norm_share.(granules) @ i).(e_state) <> GRANULE_STATE_DATA),
        (norm_share.(granule_data) @ i).(g_norm) = (sec_share.(granule_data) @ i).(g_norm);
    id_gv_g_sve_max_vq: norm_share.(gv_g_sve_max_vq) = sec_share.(gv_g_sve_max_vq);
    id_gv_g_ns_simd: norm_share.(gv_g_ns_simd) = sec_share.(gv_g_ns_simd);
    id_gv_g_cpu_simd_type: norm_share.(gv_g_cpu_simd_type) = sec_share.(gv_g_cpu_simd_type);
    id_gv_vmids: norm_share.(gv_vmids) = sec_share.(gv_vmids);
  }.

Record id_local (sec_rdata: RData) (norm_rdata: RData) : Prop :=
  {
    id_log: norm_rdata.(log) = sec_rdata.(log);
    id_oracle: norm_rdata.(oracle) = sec_rdata.(oracle);
    id_repl: norm_rdata.(repl) = sec_rdata.(repl);
    id_priv: norm_rdata.(priv) = sec_rdata.(priv);
    id_stack: norm_rdata.(stack) = sec_rdata.(stack);
  }.

Require Export Setoid.
Require Export Relation_Definitions.

Theorem id_share_reflexive : reflexive _ id_share.
Proof.
  unfold reflexive.
  intro. constructor; try reflexivity.
Qed.


Theorem id_share_symmetric : symmetric _ id_share.
Proof.
  unfold symmetric.
  intros. inv H. constructor; try symmetry; try intuition.
  apply id_g_norm0.
  rewrite <- id_granules0 in Hnd. auto.
Qed.

Theorem id_share_transitive: transitive _ id_share.
Proof.
  unfold transitive.
  intros. inv H. inv H0.
  constructor.
  rewrite id_gpt1. try intuition.
  rewrite id_glk1. try intuition.
  rewrite id_slots1. try intuition.
  rewrite id_granules1. try intuition.
  intro.
  rewrite id_gd_g_idx1. try intuition.
  
  intro. rewrite id_g_rd1. try intuition.
  intro. rewrite id_g_rec1. try intuition.
  intro. rewrite id_g_aux_pmu_state1. try intuition.
  intro. rewrite id_g_aux_simd_state1. try intuition.
  intro. rewrite id_rec_gidx1. try intuition.
  intros. rewrite id_g_norm1. rewrite id_g_norm0. reflexivity.
  rewrite <- id_granules1. assumption. assumption.
  rewrite id_gv_g_sve_max_vq1. assumption.
  rewrite id_gv_g_ns_simd1. assumption.
  rewrite id_gv_g_cpu_simd_type1. assumption.
  rewrite id_gv_vmids1. assumption.
Qed.

Theorem id_local_reflexive: reflexive _ id_local.
Proof.
  unfold reflexive.
  intro. constructor. all: reflexivity.
Qed.

Theorem id_local_symmetric: symmetric _ id_local.
Proof.
  unfold symmetric.
  intros. inv H. constructor. all: symmetry. all : auto.
Qed.

Theorem id_local_transitive: transitive _ id_local.
Proof.
  unfold transitive.
  intros. inv H. inv H0.
  frewrite. apply id_local_symmetric.
  constructor; auto.
Qed.


Add Parametric Relation : (Shared) (@id_share)
    reflexivity proved by id_share_reflexive
    symmetry proved by id_share_symmetric
    transitivity proved by id_share_transitive                          
    as eq_id_share_rel.

Add Parametric Relation: (RData) (@id_local)
    reflexivity proved by id_local_reflexive
    symmetry proved by id_local_symmetric
    transitivity proved by id_local_transitive
    as eq_id_local_rel.

Lemma id_local_preserve_change_share:
  forall sd nd ss ns (Hlocal: id_local (sd.[share]:<ss) (nd.[share]:<ns)),
    id_local sd nd.
Proof.
  intros. inv Hlocal; simpl in *.
  constructor; simpl; assumption.
Qed.


Ltac rewrite_id :=
  match goal with
  | [H: id_local (?sd.[share]:<?ss) (?nd.[share]:<?ns) |- _] => apply id_local_preserve_change_share in H
  | [H: id_local ?sd ?nd |- context[?nd.(log)] ] => rewrite (id_log sd nd H)
  | [H: id_local ?sd ?nd |- context[?nd.(oracle)] ] => rewrite (id_oracle sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(glk)] ] => rewrite (id_glk sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(gpt)] ] => rewrite (id_gpt sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(slots)] ] => rewrite (id_slots sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(granules)] ] => rewrite (id_granules sd nd H)
  | [H: id_share ?sd ?nd |- context[(?nd.(granule_data) @ ?i).(gd_g_idx)] ] => rewrite (id_gd_g_idx sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?nd.(granule_data) @ ?i).(g_rd)] ] => rewrite (id_g_rd sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?nd.(granule_data) @ ?i).(g_rec)] ] => rewrite (id_g_rec sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?nd.(granule_data) @ ?i).(g_aux_pmu_state)] ] => rewrite (id_g_aux_pmu_state sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?nd.(granule_data) @ ?i).(g_aux_simd_state)] ] => rewrite (id_g_aux_simd_state sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?nd.(granule_data) @ ?i).(rec_gidx)] ] => rewrite (id_rec_gidx sd nd H i)
  | [H: id_share ?sd ?nd |- context[?nd.(gv_g_sve_max_vq)] ] => rewrite (id_gv_g_sve_max_vq sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(gv_g_ns_simd)] ] => rewrite (id_gv_g_ns_simd sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(gv_g_cpu_simd_type)] ] => rewrite (id_gv_g_cpu_simd_type sd nd H)
  | [H: id_share ?sd ?nd |- context[?nd.(gv_vmids)] ] => rewrite (id_gv_vmids sd nd H)
  | [H: id_local ?sd ?nd |- context[?nd.(repl)] ] => rewrite (id_repl sd nd H)
  | [H: id_local ?sd ?nd |- context[?nd.(priv)] ] => rewrite (id_priv sd nd H)
  | [H: id_local ?sd ?nd |- context[?nd.(stack)] ] => rewrite (id_stack sd nd H)
  | [H1: id_local ?sd ?nd, H2: context[?nd.(log)] |- _] => rewrite (id_log sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?nd.(oracle)] |- _] => rewrite (id_oracle sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(glk)] |- _] => rewrite (id_glk sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(gpt)] |- _] => rewrite (id_gpt sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(slots)] |- _] => rewrite (id_slots sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(granules)] |- _] => rewrite (id_granules sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?nd.(granule_data) @ ?i).(gd_g_idx)] |- _] => rewrite (id_gd_g_idx sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?nd.(granule_data) @ ?i).(g_rd)] |- _] => rewrite (id_g_rd sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?nd.(granule_data) @ ?i).(g_rec)] |- _] => rewrite (id_g_rec sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?nd.(granule_data) @ ?i).(g_aux_pmu_state)] |- _] => rewrite (id_g_aux_pmu_state sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?nd.(granule_data) @ ?i).(g_aux_simd_state)] |- _] => rewrite (id_g_aux_simd_state sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?nd.(granule_data) @ ?i).(rec_gidx)] |- _] => rewrite (id_rec_gidx sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(gv_g_sve_max_vq)] |- _] => rewrite (id_gv_g_sve_max_vq sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(gv_g_ns_simd)] |- _] => rewrite (id_gv_g_ns_simd sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(gv_g_cpu_simd_type)] |- _] => rewrite (id_gv_g_cpu_simd_type sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?nd.(gv_vmids)] |- _] => rewrite (id_gv_vmids sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?nd.(repl)] |- _] => rewrite (id_repl sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?nd.(priv)] |- _] => rewrite (id_priv sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?nd.(stack)] |- _] => rewrite (id_stack sd nd H1) in H2
  end.

Record relate (sec_rdata: RData) (sec_st: SecState) (norm_rdata: RData) : Prop :=
  {
    relate_sec_data: relate_secure sec_rdata sec_st norm_rdata;
    relate_share: id_share sec_rdata.(share) norm_rdata.(share);
    relate_local: id_local sec_rdata norm_rdata
  }.

(************************************************************************************)

Lemma relate_walk_rtt_same:
  forall st st' rd ipa (Hrelate: id_share st.(share) st'.(share)),
    walk_rtt st.(share) rd ipa = walk_rtt st'.(share) rd ipa.
Admitted.

Lemma lens_same:
  forall st v, lens v st = st.
Admitted.

Axiom oracle_rel:
  forall sec_d norm_d sec_sh' norm_sh'
    (Hrepl_sec: repl sec_d (oracle sec_d (log sec_d)) (sec_d.(share)) = Some sec_sh')
    (Hrepl_norm: repl norm_d (oracle norm_d (log norm_d)) (norm_d.(share)) = Some norm_sh')
    sec_st
    (Hrelate: relate sec_d sec_st norm_d)
    (Hinv: SharedInv sec_d.(share)),
    relate (sec_d.[share] :< sec_sh') sec_st (norm_d.[share] :< norm_sh') /\ SharedInv sec_sh'.

Ltac ext_repl Rsec Rnorm :=
  match type of Rsec with
  | repl ?sec_d ?l0 ?sh0 = Some ?sec_d' =>
      match type of Rnorm with
      | repl ?norm_d ?l1 ?sh1 = Some ?norm_d' =>
          exploit (oracle_rel sec_d norm_d sec_d' norm_d' Rsec Rnorm)
      end
  end.

Ltac Frewrite := repeat (repeat rewrite_id; frewrite).

Lemma smc_rtt_fold_3_inv:
  forall s2_ctx map_addr wi call15 call34 call44 call33 sec_d_init sec_d ret_n sec_d'
    (Hspec: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 sec_d_init sec_d = Some (ret_n, sec_d'))
    (Hinv: SharedInv sec_d.(share)),
    SharedInv sec_d'.(share).
Admitted.

Lemma granule_data_slots_update_permu:
  forall st v0 v1, ((share st).[granule_data] :< v0).[slots] :< v1 = ((share st).[slots] :< v1).[granule_data] :< v0.
Proof. easy. Qed.

Definition smc_rtt_fold_3 (v_s2_ctx: Ptr) (v_map_addr: Z) (v_wi: Ptr) (v_call15: Ptr) (v_call34: Ptr) (v_call44: Z) (v_call33: Ptr) (st_0: RData) (st_34: RData) : (option (Z * RData)) :=
  rely (((v_s2_ctx.(pbase)) = ("stack_s2_ctx")));
  rely (((v_s2_ctx.(poffset)) = (0)));
  rely (((v_wi.(pbase)) = ("stack_wi")));
  rely (((v_wi.(poffset)) = (0)));
  rely (((v_call15.(pbase)) = ("slot_rtt")));
  rely (((v_call34.(pbase)) = ("slot_rtt2")));
  rely (((v_call33.(pbase)) = ("granules")));
  rely ((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(e_state) = GRANULE_STATE_RTT);
  rely ((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(e_state) = GRANULE_STATE_RTT);
  when cid == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
  when cid_0 == (((((st_34.(share)).(granules)) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
  rely ((((v_call33.(pbase)) = ("granules")) /\ ((((v_call33.(poffset)) mod (ST_GRANULE_SIZE)) = (0)))));
  rely ((((st_34.(share)).(slots)) @ SLOT_RTT) <> (((st_34.(share)).(slots)) @ SLOT_RTT2)); (* MANUALLY ADDED *)
  if (
    match (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock))) with
    | (Some cid_1) => true
    | None => false
    end)
  then (
    when cid_1 == (((((st_34.(share)).(granules)) @ (((v_call33.(poffset)) + (4)) / (ST_GRANULE_SIZE))).(e_lock)));
    rely (((v_call34.(poffset)) = (0)));
    rely ((((0 - (CPU_ID)) <= (0)) /\ ((CPU_ID < (16)))));
    rely (((v_call15.(poffset)) = (0)));
    rely (((((((st_34.(stack)).(stack_wi)).(e_g_llt)) - (STACK_VIRT)) < (0)) /\ ((((((st_34.(stack)).(stack_wi)).(e_g_llt)) - (GRANULES_BASE)) >= (0)))));
    rely ((((st_34.(share)).(slots)) @ SLOT_RTT) = ((st_34.(stack)).(stack_wi)).(e_g_llt)); (* MANUALLY ADDED *)
    rely (exists rd gfn lvl pte pte',  (* MANUALLY ADDED *)
          ((st_34.(share).(granules) @ rd).(e_state) = GRANULE_STATE_RD)
          /\ walk_rtt_level (Z.to_nat lvl) (st_34.(share)) 0 rd gfn (gidx_to_table_pte (rd_rtt (st_34.(share)) rd)) =
              (lvl, pte)
          /\ (((st_34.(stack)).(stack_wi)).(e_g_llt)) = pte_to_gidx pte
          /\ gfn_to_rtt_offs gfn lvl = 8 * (((st_34.(stack)).(stack_wi)).(e_index))
          /\ walk_one_step (st_34.(share)) lvl gfn (((st_34.(stack)).(stack_wi)).(e_g_llt)) = pte'
          /\ ((st_34.(share)).(slots)) @ SLOT_RTT2 = pte_to_gidx pte');
    rely (PTE_IS_VALID v_call44 = false); (* MANUALLY ADDED *)
    rely (pte_to_gidx v_call44 = 0); (* MANUALLY ADDED *)
    rely (forall idx, pte_to_gidx ((st_34.(share).(granule_data) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(g_norm) @ idx) = 0); (* MANUALLY ADDED *)
    rely (forall idx, PTE_IS_VALID ((st_34.(share).(granule_data) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).(g_norm) @ idx) = false); (* MANUALLY ADDED *)
    (Some (
      0  ,
      (((lens 106 st_34).[share].[granule_data] :<
        ((((st_34.(share)).(granule_data)) #
          (((st_34.(share)).(slots)) @ SLOT_RTT) ==
          ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
              ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(stack_wi)).(e_index)))))) ==
              v_call44))) #
          (((st_34.(share)).(slots)) @ SLOT_RTT2) ==
          (((((st_34.(share)).(granule_data)) #
            (((st_34.(share)).(slots)) @ SLOT_RTT) ==
            ((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
              (((((st_34.(share)).(granule_data)) @ (((st_34.(share)).(slots)) @ SLOT_RTT)).(g_norm)) #
                ((v_call15.(poffset)) + ((8 * ((((st_34.(stack)).(stack_wi)).(e_index)))))) ==
                v_call44))) @ (((st_34.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
            zero_granule_data_normal))).[share].[slots] :<
        ((((st_34.(share)).(slots)) # SLOT_RTT2 == (- 1)) # SLOT_RTT == (- 1)))
    )))
  else None.

Record lens_field_same: Prop := {
    lens_gpt_same: forall st v, gpt (share (lens v st)) = gpt (share st)
  }.

Parameter lens_field_same_prop: lens_field_same.

Ltac rewrite_lens :=
  match goal with
  | [|- context[gpt (share (lens ?v ?st))] ] => rewrite (lens_gpt_same lens_field_same_prop st v)
  | [H: context[gpt (share (lens ?v ?st)) ] |- _] => rewrite (lens_gpt_same lens_field_same_prop st v) in H
  end.

Lemma smc_rec_destroy_secure:
forall v_rd_addr norm_d sec_d norm_d' sec_d' sec_st ret_n ret_s (Hrel: relate sec_d sec_st norm_d)
         (Hnorm: smc_rec_destroy_spec v_rd_addr norm_d = Some (ret_n, norm_d'))
         (Hsec: smc_rec_destroy_spec v_rd_addr sec_d = Some (ret_s, sec_d'))
         (Hinv_sec: SharedInv (sec_d.(share)))
         (Hinv_norm: SharedInv (norm_d.(share))),
     ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rec_destroy_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hsec. repeat simpl_hyp Hnorm. inv Hnorm. inv Hsec.
  -split. reflexivity. split; auto.
  -autounfold with sem in *.
   Frewrite. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   split. auto.
   {
     constructor.
     +constructor. simpl in *. intros. inv relate_sec_data0.
      rewrite (walk_rtt_same (share (lens 34 sec_d))) in Hwalk.
      rewrite walk_rtt_lens_same in Hwalk.
      rewrite e_state_lens_same in Hrd.
      exploit mem_rel0.
      apply  Hrd. apply Hwalk. simpl.
      intros. simpl_hyp H.
      *assert_gso. {
         inv Hinv_norm. unfold rtt_map_data in *. autounfold with spec in *.
         Frewrite. erewrite relate_walk_rtt_same in Hwalk; try eassumption. exploit rtt_map_data_inv0. apply Hrd.
         apply Hwalk.
         intros. red.  intro T. inv T. lia.
       }
       rewrite (ZMap.gso _ _ Hneq). assumption.
      *destruct_zmap. simpl in *. subst. assumption. assumption.
      *simpl in *. intros. rewrite lens_same in *. Frewrite.
       destruct_zmap. simpl. reflexivity. reflexivity.
     +simpl in *. repeat rewrite lens_same. Frewrite. simpl.
      constructor; intros; simpl in *.
      all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
      all: (destruct_zmap; simpl; Frewrite; try reflexivity).
       autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        Frewrite. auto.
         eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
         Frewrite. auto.
     +simpl. repeat rewrite lens_same. Frewrite. simpl.
      constructor; intros; simpl in *; repeat rewrite lens_same; Frewrite; reflexivity.
   }
   inv Hsec. inv Hnorm. rewrite lens_same in *. Frewrite. inv C10.
  -autounfold with sem in *. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   repeat rewrite lens_same in *. Frewrite. lia.
   inv Hsec. inv Hnorm. split. reflexivity. repeat rewrite lens_same.
   apply Hrel.
  -autounfold with sem in *. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   split. reflexivity. apply Hrel.
Qed.


Lemma smc_realm_destroy_secure:
   forall v_rd_addr norm_d sec_d norm_d' sec_d' sec_st ret_n ret_s (Hrel: relate sec_d sec_st norm_d)
         (Hnorm: smc_realm_destroy_spec v_rd_addr norm_d = Some (ret_n, norm_d'))
         (Hsec: smc_realm_destroy_spec v_rd_addr sec_d = Some (ret_s, sec_d'))
         (Hinv_sec: SharedInv (sec_d.(share)))
         (Hinv_norm: SharedInv (norm_d.(share))),
     ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_realm_destroy_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hsec. repeat simpl_hyp Hnorm. inv Hnorm. inv Hsec.
  -split. reflexivity. split; auto.
  -autounfold with sem in *.
   Frewrite. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   split. auto.
   {
     constructor.
     +constructor. simpl in *. intros. inv relate_sec_data0. autounfold with spec in *.
       rewrite (walk_rtt_same (share (lens 35 sec_d))) in Hwalk.
      inv C9. inv C26. inv C12. inv C29.
      rewrite walk_rtt_lens_same in Hwalk.
      rewrite e_state_lens_same in Hrd.
      rewrite lens_same in *.
      exploit mem_rel0; try eassumption. 
      simpl. intros. simpl_hyp H.
      *assert_gso. {
         inv Hinv_norm.
             unfold rtt_map_data in *.
              autounfold with spec in *.
              Frewrite. erewrite relate_walk_rtt_same in Hwalk; try eassumption.
              exploit rtt_map_data_inv0; try eassumption.
              intros. red. intro T. inv T. lia.}
       rewrite (ZMap.gso _ _ Hneq). assumption.
      *destruct_zmap. simpl in *. subst. rewrite lens_same. apply H.
       rewrite lens_same. apply H.
      *simpl in *. intros. rewrite lens_same in *. Frewrite. inv C12. inv C9. destruct_zmap.
       simpl. reflexivity. simpl. reflexivity.  
     +inv C9. inv C12. inv C29. inv C26. repeat rewrite lens_same. Frewrite. simpl.
        constructor; intros; simpl in *.
        all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
        all: (destruct_zmap; simpl; Frewrite; try reflexivity).
        autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        Frewrite. auto.
         eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
         Frewrite. auto.
     +inv C9. inv C12. inv C29. inv C26. repeat rewrite lens_same. Frewrite. simpl.
        constructor; intros; simpl in *; repeat rewrite lens_same; Frewrite; reflexivity.
   }
   rewrite lens_same in *.
   inv Hsec. inv Hnorm. 
   Frewrite. unfold Spec.total_root_rtt_refcount_loop348 in *.
   simpl in *. Frewrite. inv C26. inv C9. lia.
    inv Hsec. inv Hnorm. split. reflexivity.
   {
     constructor.
     +constructor. simpl in *. intros. inv relate_sec_data0. autounfold with spec in *.
      inv C9. inv C26. inv C12. inv C29.  simpl in *.
      repeat rewrite lens_same in *. Frewrite. inv C11.
     +inv C9. inv C26. inv C12. inv C29. simpl. repeat rewrite lens_same in *. Frewrite.
      simpl.
      constructor; intros; simpl in *.
       all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
       all: (destruct_zmap; simpl; Frewrite; try reflexivity).
       autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        Frewrite. auto.
         eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
         Frewrite. auto.
     +inv C9. inv C12. inv C29. inv C26. repeat rewrite lens_same. Frewrite. simpl.
       constructor; intros; simpl in *; repeat rewrite lens_same; Frewrite; reflexivity.
   }
   rewrite lens_same in *.
   Frewrite. lia.
  -autounfold with sem in *.
   Frewrite. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   unfold Spec.total_root_rtt_refcount_loop348 in *. simpl in *.
   Frewrite. inv C9. inv C21. lia.
   split. inv Hsec. inv Hnorm. reflexivity.
   {
     constructor; inv C9; inv C12; inv C21; inv C24; inv C27.
   }
   unfold Spec.total_root_rtt_refcount_loop348 in *. simpl in *.
   Frewrite. inv C9. inv C21. lia.
   inv Hsec. inv Hnorm. split. reflexivity.
   {
     inv C9. inv C12. inv C15.
   }
  -autounfold with sem in *.
   Frewrite. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   unfold Spec.total_root_rtt_refcount_loop348 in *. simpl in *.
   Frewrite. inv C9. inv C12. inv C26. inv C29.
   split. reflexivity. repeat rewrite lens_same. simpl in *. Frewrite. inv C11.
   Frewrite. inv C9. inv C12. inv C26. inv C29. Frewrite. inv C11.
   Frewrite. inv C9. inv C12. inv C26. inv C29. Frewrite. inv C11.
   Frewrite. inv C12. inv C9. repeat rewrite lens_same in *.
   Frewrite. inv C25.
  -autounfold with sem in *.
   Frewrite. repeat simpl_hyp Hnorm. inv Hsec. inv Hnorm.
   split. reflexivity. simpl in *. constructor.
   *repeat rewrite lens_same. inv relate_sec_data0. autounfold with spec in *.
    Frewrite. constructor. simpl. intros.
     erewrite walk_rtt_same in Hwalk.
     simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
     destruct_zmap. simpl. rewrite <- Heq. assumption.
     simpl. assumption.
     simpl. intros. destruct_zmap. simpl. reflexivity.
     simpl. reflexivity.
   *simpl. repeat rewrite lens_same; simpl. constructor; intros; simpl in *; Frewrite; try reflexivity.
    inv relate_share0. destruct_zmap; eapply id_gd_g_idx0.
    inv relate_share0. destruct_zmap. simpl. reflexivity.
    eapply id_g_rd0.
    inv relate_share0. destruct_zmap; eapply id_g_rec0.
    inv relate_share0. destruct_zmap;  eapply id_g_aux_pmu_state0.
    inv relate_share0. destruct_zmap;  eapply id_g_aux_simd_state0.
    inv relate_share0. destruct_zmap;  eapply id_rec_gidx0.
    simpl. inv relate_share0. destruct_zmap. eapply id_g_norm0.
    autounfold with spec in *. Frewrite. assumption. simpl.
    eapply id_g_norm0. autounfold with spec in *. Frewrite.
    assumption.
   *simpl. repeat rewrite lens_same; simpl. constructor; intros; simpl in *; Frewrite; try reflexivity.
   *repeat rewrite lens_same in *. Frewrite. inv C10.
  -autounfold with sem in *. Frewrite. repeat simpl_hyp Hnorm. repeat rewrite lens_same in *. Frewrite. inv C6. repeat rewrite lens_same in *. Frewrite. inv C6. repeat rewrite lens_same in *. Frewrite. inv C6. repeat rewrite lens_same in *. Frewrite. inv C6. inv Hnorm. inv Hsec.
   split. constructor. repeat rewrite lens_same. assumption.
  -autounfold with sem in *. Frewrite. inv Hnorm. inv Hsec. split. reflexivity. assumption.
Qed.
  


Lemma smc_realm_activate_secure:
  forall v_rd_addr norm_d sec_d norm_d' sec_d' sec_st ret_n ret_s (Hrel: relate sec_d sec_st norm_d)
         (Hnorm: smc_realm_activate_spec v_rd_addr norm_d = Some (ret_n, norm_d'))
         (Hsec: smc_realm_activate_spec v_rd_addr sec_d = Some (ret_s, sec_d'))
         (Hinv_sec: SharedInv (sec_d.(share)))
         (Hinv_norm: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_realm_activate_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hsec; inv Hsec; inv Hnorm.
  -split. reflexivity. split; auto.
  -autounfold with sem in *.
    Frewrite. simpl_hyp H0.
    inv H0.
    split. auto.
    { constructor.
      - constructor.
        + simpl. inv relate_sec_data0. autounfold with spec in *.
          intros.
          rewrite (walk_rtt_same (share (lens 21 sec_d))) in Hwalk.
          rewrite walk_rtt_lens_same in Hwalk.
          rewrite e_state_lens_same in Hrd.
          exploit mem_rel0; try eassumption. intros. simpl_hyp H.
          *assert_gso.
           {
             inv Hinv_norm.
             unfold rtt_map_data in *.
              autounfold with spec in *.
              Frewrite. erewrite relate_walk_rtt_same in Hwalk; try eassumption.
              exploit rtt_map_data_inv0; try eassumption.
              intros. red. intro T. inv T. lia.}
           rewrite (ZMap.gso _ _ Hneq). assumption.
          * 
            destruct_zmap. simpl in *. subst.
            autounfold with spec in *.
            Frewrite. reflexivity. Frewrite. reflexivity.
          
          * intros. simpl in *. destruct_zmap. simpl.
            subst. simpl in H.
            autounfold with spec in *.
            rewrite e_state_lens_same in H.
            Frewrite. lia. rewrite g_norm_lens_same.
            reflexivity.
      - simpl. repeat rewrite lens_same. Frewrite.
        
        constructor; intros; simpl in *.
        all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
        all: (destruct_zmap; simpl; Frewrite; try reflexivity).
        autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        Frewrite. auto.
         eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        Frewrite. auto.        
     -simpl in *. repeat rewrite lens_same.        
           constructor; intros; simpl in *;
          repeat rewrite lens_same; Frewrite; reflexivity.
    }
    - autounfold with sem in *.
    Frewrite. simpl_hyp H0; inv H0.
    split. auto. {
      - constructor. constructor. simpl. inv relate_sec_data0. repeat rewrite lens_same.
        intros. subst.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
        simpl. repeat rewrite lens_same; simpl. constructor; intros; simpl in *; Frewrite; try reflexivity. inv relate_share0. eapply id_g_norm0. autounfold with spec in *.
        Frewrite. assumption. simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
    }
    -split. reflexivity.
     constructor. constructor. intros.
     simpl. inv relate_sec_data0.
     eapply mem_rel0 in Hrd. 2: eapply Hwalk.
     assumption.
     assumption.
     assumption.
Qed.
  

Lemma smc_realm_activate_inv':
  forall v_rd_addr  nd nd' ret_d
    (Hspec: smc_realm_activate_spec v_rd_addr nd = Some (ret_d, nd'))
    (Hinv: SharedInv (nd.(share))),
    SharedInv (nd'.(share)).
Proof.
  (* intros.  unfold smc_realm_activate_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hspec; inv Hspec.
  auto.
  -inv Hinv.
   constructor; simpl; repeat rewrite lens_same; simpl.
   + unfold gpt_false_ns in *. simpl. intros. apply gpt_false_ns_inv0. assumption.
   + unfold delegated_zero in *. simpl; intros.
     destruct_zmap. subst.
     assert (e_state (granules (share nd)) @ (v_rd_addr / GRANULE_SIZE) = 2) by lia.
     unfold GRANULE_STATE_DELEGATED in Hdel. lia.
     apply delegated_zero_inv0. auto.
   +unfold rtt_map_data in *. simpl; intros.
    erewrite walk_rtt_same in Hwalk.
    exploit rtt_map_data_inv0.
    apply Hrd. apply Hwalk.
    intros. apply H. simpl. intros.
    destruct_zmap. subst.
    assert (e_state (granules (share nd)) @ (v_rd_addr / GRANULE_SIZE) = 2) by lia.
    unfold GRANULE_STATE_RTT in *.
    lia. reflexivity.
   +unfold walk_reverse in *. simpl. admit.
   +admit.
  -inv Hinv. constructor; simpl; repeat rewrite lens_same; simpl; admit.
  -admit.            *)
Admitted.
 
Lemma smc_rtt_fold_3_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init ret_n ret_s sec_d' norm_d'
    (Hnorm: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init norm_d = Some (ret_n, norm_d'))
    (Hsec: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init sec_d = Some (ret_s, sec_d'))
    (Hinv_sec: SharedInv (sec_d.(share)))
    (Hinv_norm: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rtt_fold_3 in *; autounfold with sem in *.
  repeat simpl_hyp Hsec. repeat simpl_hyp Hnorm. inv Hnorm.
  destruct e11 as (? & ? & ? & ? & ? & ? & ? & ? & ? & ? & ?).
  clear C19.
  Frewrite. inv Hsec.
  extract_prop. repeat match goal with | [H: prop _ = _ |- _ ] => clear H end.
  bool_rel. simpl_some. clear_hyp. subst.
  split.
  - reflexivity.
  - constructor.
    {
      constructor; simpl.
      inv relate_sec_data0.
      rewrite_id. frewrite. subst.
      intros. rewrite lens_same in Hrd. repeat rewrite_id.
      remember (pte_to_gidx x2) as rtt_idx. symmetry in Heqrtt_idx.
      remember (pte_to_gidx (walk_one_step (share sec_d) x1 x0 rtt_idx)) as rtt2_idx. symmetry in Heqrtt2_idx.
      rewrite Z.add_0_l in *.
      remember (8 * e_index (stack_wi (stack sec_d))) as e_idx. symmetry in Heqe_idx.
      repeat rewrite lens_same in *.
      match type of Hwalk with
      | walk_rtt ?d ?rd ?addr = _ =>
          assert(Hwalk_eq: walk_rtt d rd addr = walk_rtt (share sec_d) rd addr)
      end.
      {
        assert_gso. lia. rewrite (ZMap.gso _ _ Hneq) in *.
        repeat (rewrite walk_rtt_same_set_slot in * ).
        rename x1 into lvl0.
        rename x into rd0.
        rename x0 into gfn0.
        rename x2 into pte0.
        assert(Hwalk0: walk_star (share sec_d) rd0 gfn0 rtt_idx).
        { unfold walk_star. repeat eexists. eassumption. lia. }
        assert(Hwalk1: walk_star (share sec_d) rd0 gfn0 rtt2_idx).
        { unfold walk_star.
          eexists. eexists. exists (S (Z.to_nat lvl0)).
          simpl. rewrite e22. clear e13. repeat grewrite. simpl_bool_eq.
          split. reflexivity. auto. }
        erewrite walk_unreachable_same with
          (sh:= (share sec_d).[granule_data] :<
                  (((granule_data (share sec_d)) # rtt_idx ==
                      (((granule_data (share sec_d)) @ rtt_idx).[g_norm]
                       :< ((g_norm (granule_data (share sec_d)) @ rtt_idx) # e_idx ==
                             call44))))) at 1.
        + destruct (prop (walk_star (share sec_d) rd_gidx (addr_to_gidx vaddr) rtt2_idx)).
          * exploit walk_same_parent_same.
            2: eapply Hwalk0. all: try eassumption.
            apply shared_inv_implies. assumption.
            intros (? & w1 & i1 & Hx).
            exploit modify_leaf_same.
            2: eapply w1.
            apply shared_inv_implies. assumption. rewrite gidx_to_pte_to_gidx. assumption.
            simpl. intro T.
            exploit (walk_rtt_level_split (Z.to_nat (4 - Z.of_nat x))).
            eapply T. replace ((Z.to_nat (4 - Z.of_nat x)) + x)%nat with 4%nat by lia.
            intros W1. rewrite gidx_to_pte_to_gidx in W1.
            exploit walk_star_continue. 2: apply w.
            apply shared_inv_implies. assumption. assumption.
            intros (? & W2).
            unfold walk_rtt.
            rewrite W2. erewrite W1.
            replace (Z.to_nat (4 - Z.of_nat x)) with ((Z.to_nat (3 - Z.of_nat x)) + 1)%nat by lia.
            erewrite walk_rtt_level_split.
            Focus 2. simpl. rewrite gidx_to_pte_to_gidx. grewrite. simpl_bool_eq.
            unfold walk_one_step. simpl. rewrite ZMap.gss. simpl. grewrite. rewrite ZMap.gss. reflexivity.
            erewrite invalid_start_walk_invalid at 1; try assumption.
            grewrite. symmetry.
            replace (S x0) with (x0 + 1)%nat by lia.
            erewrite walk_rtt_level_split.
            Focus 2. simpl. rewrite gidx_to_pte_to_gidx. grewrite. simpl_bool_eq.
            unfold walk_one_step. reflexivity.
            erewrite invalid_start_walk_invalid; try assumption.
            rewrite Prop0. reflexivity.
            apply e14.
          * unfold walk_rtt.
            erewrite child_unreachable_update_entry_same;
              try eassumption.
            reflexivity.
            apply shared_inv_implies. assumption.
            subst. unfold walk_one_step. grewrite. reflexivity.
        + instantiate (1:= fun r => r =? rtt2_idx).
          simpl. intros. bool_rel. rewrite H in *. clear H.
          eapply update_entry_child_unreachable.
          apply shared_inv_implies. assumption.
          eassumption. assumption.
          subst. unfold walk_one_step. grewrite. reflexivity.
          auto.
        + simpl. reflexivity.
        + simpl. intros. repeat (destruct_zmap; simpl); reflexivity.
        + simpl. intros. bool_rel. rewrite ZMap.gso. reflexivity. lia.
      }
      rewrite Hwalk_eq in Hwalk.
      pose proof (mem_rel0 rd_gidx Hrd vaddr data_gidx Hwalk) as mem_rel.
      simpl in mem_rel.
      inv Hinv_norm. unfold rtt_map_data in *. repeat rewrite_id.
      erewrite relate_walk_rtt_same in *; try eassumption.
      pose proof (rtt_map_data_inv0 rd_gidx Hrd (addr_to_gidx vaddr) data_gidx Hwalk) as Hdata.
      autounfold with spec in *.
      assert_gso. red; intro T; inv T; lia.
      rewrite (ZMap.gso _ _ Hneq).
      assert_gso. red; intro T; inv T; lia.
      rewrite (ZMap.gso _ _ Hneq0).
      rewrite (ZMap.gso _ _ Hneq).
      rewrite (ZMap.gso _ _ Hneq0).
      assumption.
    }
    {
      pose proof relate_share0 as D; destruct D.
      constructor; simpl; repeat rewrite lens_same; rewrite_id; try reflexivity.
      all:intros; rewrite_id; simpl; repeat (destruct_zmap; simpl; rewrite_id); try reflexivity.
      all:rewrite id_g_norm0; rewrite_id; subst; try reflexivity; try assumption.
    }
    {
      constructor; simpl; repeat rewrite lens_same; rewrite_id; try reflexivity.
    }
Qed.


Lemma realm_access_mem_inv:
  forall rd addr val nd nd' ret_d
    (Hspec: normal_realm_access_mem rd addr val nd = Some (nd', ret_d))
    (Hinv: SharedInv (nd.(share))),
    SharedInv (nd'.(share)).
Proof.
  intros.
  unfold normal_realm_access_mem in *; autounfold with sem in *.
  repeat simpl_hyp Hspec; inv Hspec.
  inv Hinv.
  { constructor.
    - unfold gpt_false_ns. simpl. eapply gpt_false_ns_inv0.
    - unfold delegated_zero; simpl.
      intros. assert_gso.
      red; intros; subst. autounfold with spec in *.
      unfold rtt_map_data in *. autounfold with spec in *.
      erewrite rtt_map_data_inv0 in Hdel. lia.
      eassumption. eassumption.
      rewrite (ZMap.gso _ _ Hneq). apply delegated_zero_inv0. assumption.
    - unfold rtt_map_data; simpl.
      intros. eapply rtt_map_data_inv0. eapply Hrd.
      erewrite walk_rtt_same. eapply Hwalk.
      intros; simpl; autounfold with spec in *. assert_gso.
      red; intros; subst.
      unfold rtt_map_data in *. autounfold with spec in *.
      erewrite rtt_map_data_inv0 in H. lia.
      eapply e. eassumption.
      rewrite (ZMap.gso _ _ Hneq). reflexivity.
    - unfold rtt_reverse in *; simpl.
      destruct rtt_reverse_inv0 as (data_to_rd & rtt_reverse_inv0).
      exists data_to_rd. intros. eapply rtt_reverse_inv0. eapply Hrd.
      erewrite walk_rtt_same. eapply Hwalk.
      intros; simpl; autounfold with spec in *. assert_gso.
      red; intros; subst.
      unfold rtt_map_data in *. autounfold with spec in *.
      erewrite rtt_map_data_inv0 in H. lia.
      eapply e. eassumption.
      rewrite (ZMap.gso _ _ Hneq). reflexivity.
  }
  assumption.
Qed.

Lemma realm_access_mem_secure:
  forall rd addr val sd sec nd sd' sec' nd' ret_s ret_d
    (Hsec: secure_realm_access_mem rd addr val (sd, sec) = Some ((sd', sec'), ret_s))
    (Hnorm: normal_realm_access_mem rd addr val nd = Some (nd', ret_d))
    (Hrel: relate sd sec nd)
    (Hinv: SharedInv (nd.(share))),
    ret_s = ret_d /\ relate sd' sec' nd'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold secure_realm_access_mem, normal_realm_access_mem in *; autounfold with sem in *.
  repeat simpl_hyp Hsec; inv Hsec.
  - (* secure data exists *)
    destruct relate_sec_data0. simpl in mem_rel0.
    Frewrite.
    erewrite <- relate_walk_rtt_same in Hnorm. erewrite C3 in Hnorm.
    2: assumption.
    exploit mem_rel0; try eassumption.
    grewrite. intros. frewrite. inv Hnorm.
    split. reflexivity.
    constructor.
    + constructor.
      simpl. intros.
      destruct_zmap; simpl.
      * (* rd is the running rd *)
        subst.
        destruct_zmap; simpl.
        { (* data_gidx is used *)
          subst. simpl.
          destruct_zmap; simpl.
          reflexivity.
          apply mem_rel0; assumption. }
        { (* data_gidx is not used *)
          apply mem_rel0; assumption. }
      * (* rd is not the running rd *)
        assert(Hne: data_gidx <> z).
        { pose proof (shared_inv_implies _ Hinv) as Hinv'.
          inv Hinv'. Frewrite.
          eapply diff_rd_diff_data0.
          eapply Hrd. eapply e. lia.
          erewrite <- relate_walk_rtt_same. eapply Hwalk. assumption.
          erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
        rewrite (ZMap.gso _ _ Hne).
        apply mem_rel0; Frewrite; reflexivity.
    + simpl. constructor; simpl; Frewrite; try reflexivity.
      all: intros; try solve[destruct_zmap; simpl; Frewrite; reflexivity].
      assert(Hne: i <> z).
      { red; intros; subst.
        inv Hinv. unfold rtt_map_data in *; autounfold with spec in *.
        erewrite rtt_map_data_inv0 in Hnd. lia.
        eapply  e. erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
      rewrite (ZMap.gso _ _ Hne).
      eapply (id_g_norm _ _ relate_share0). Frewrite. assumption.
    + constructor; simpl; Frewrite; reflexivity.
  - (* secure data not exists *)
    destruct relate_sec_data0. simpl in mem_rel0.
    Frewrite.
    erewrite <- relate_walk_rtt_same in Hnorm. erewrite C3 in Hnorm.
    2: assumption.
    exploit mem_rel0; try eassumption.
    grewrite. intros. frewrite. inv Hnorm.
    split. reflexivity.
    constructor.
    + constructor.
      simpl. intros.
      destruct_zmap; simpl.
      * (* rd is the running rd *)
        subst.
        destruct_zmap; simpl.
        { (* data_gidx is used *)
          subst. simpl.
          destruct_zmap; simpl.
          reflexivity.
          apply mem_rel0; assumption. }
        { (* data_gidx is not used *)
          apply mem_rel0; assumption. }
      * (* rd is not the running rd *)
        assert(Hne: data_gidx <> z).
        { pose proof (shared_inv_implies _ Hinv) as Hinv'.
          inv Hinv'. Frewrite.
          eapply diff_rd_diff_data0.
          eapply Hrd. eapply e. lia.
          erewrite <- relate_walk_rtt_same. eapply Hwalk. assumption.
          erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
        rewrite (ZMap.gso _ _ Hne).
        apply mem_rel0; Frewrite; reflexivity.
    + simpl. constructor; simpl; Frewrite; try reflexivity.
      all: intros; try solve[destruct_zmap; simpl; Frewrite; reflexivity].
      assert(Hne: i <> z).
      { red; intros; subst.
        inv Hinv. unfold rtt_map_data in *; autounfold with spec in *.
        erewrite rtt_map_data_inv0 in Hnd. lia.
        eapply  e. erewrite <- relate_walk_rtt_same. eapply C3. assumption. }
      rewrite (ZMap.gso _ _ Hne).
      eapply (id_g_norm _ _ relate_share0). Frewrite. assumption.
    + constructor; simpl; Frewrite; reflexivity.
  - (* no mapping *)
    destruct relate_sec_data0. simpl in mem_rel0.
    Frewrite.
    erewrite <- relate_walk_rtt_same in Hnorm. erewrite C3 in Hnorm.
    2: assumption.
    inv Hnorm.
    split. reflexivity. assumption.
Qed.


Lemma smc_granule_delegate_inv:
forall norm_d v_addr ret_n norm_d'
  (Hspec: smc_granule_delegate_spec v_addr norm_d = Some (ret_n, norm_d'))
  (Hinv: SharedInv norm_d.(share)),
  SharedInv norm_d'.(share).
(*

      - inv Hinv.
        constructor; simpl; repeat rewrite lens_same; simpl.
        + unfold gpt_false_ns in *. simpl.
          intros. destruct_zmap; subst; simpl; apply gpt_false_ns_inv0; assumption.
        + unfold delegated_zero in *. simpl; intros.
          destruct_zmap' Hdel; subst; simpl; apply delegated_zero_inv0; assumption.
        + unfold rtt_prop in *. simpl; intros.
          erewrite walk_rtt_same in Hwalk.
          eapply rtt_prop_inv0 in Hwalk.
          destruct_zmap; simpl; subst; assumption.
          destruct_zmap' Hrd; simpl in *; subst; assumption.
          intros. simpl in *. reflexivity.

 *)
Admitted.

Lemma smc_granule_delegate_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    v_addr ret_s ret_n sec_d' norm_d'
    (Hsec: smc_granule_delegate_spec v_addr sec_d = Some (ret_s, sec_d'))
    (Hnorm: smc_granule_delegate_spec v_addr norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_granule_delegate_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hsec; inv Hsec; inv Hnorm.
  - repeat (auto; constructor).
  - autounfold with sem in *.
    Frewrite. simpl_hyp H0.
    inv H0.
    split. auto.
    { constructor.
      - constructor.
        + simpl. inv relate_sec_data0. autounfold with spec in *.
          intros.
          rewrite (walk_rtt_same (share (lens 416 sec_d))) in Hwalk.
          rewrite walk_rtt_lens_same in Hwalk.
          assert_gso' Hrd.
          { red; intros T; inv T. rewrite ZMap.gss in Hrd.
            simpl in Hrd. rewrite e_state_lens_same in Hrd.
            Frewrite. lia. }
          rewrite (ZMap.gso _ _ Hneq) in Hrd.
          rewrite e_state_lens_same in Hrd.
          exploit mem_rel0; try eassumption.
          intros. simpl_hyp H.
          * assert_gso.
            { inv Hinv. unfold rtt_map_data in *. autounfold with spec in *.
              Frewrite. erewrite relate_walk_rtt_same in Hwalk; try eassumption.
              exploit rtt_map_data_inv0; try eassumption.
              intros. red; intro T; inv T. lia. }
            rewrite (ZMap.gso _ _ Hneq0). assumption.
          * destruct_zmap. simpl. reflexivity. assumption.
          * intros. simpl in *. destruct_zmap. simpl.
            subst. rewrite ZMap.gss in H. simpl in H.
            autounfold with spec in *.
            rewrite e_state_lens_same in H.
            Frewrite. lia. rewrite g_norm_lens_same.
            reflexivity.
      - constructor; intros; simpl in *.
        all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
        all: (destruct_zmap; simpl; Frewrite; try reflexivity).
        autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        assert_gso' Hnd.
        red; intro T; inv T. rewrite ZMap.gss in Hnd. simpl in Hnd.
        lia. rewrite (ZMap.gso _ _ Hneq) in Hnd. Frewrite. assumption.
      - constructor; intros; simpl in *;
          repeat rewrite lens_same; Frewrite; reflexivity.
    }
  - autounfold with sem in *.
    Frewrite. simpl_hyp H0; inv H0.
    split. auto.
    { constructor.
      - constructor. simpl. inv relate_sec_data0. repeat rewrite lens_same.
        intros. destruct_zmap' Hrd. subst.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
      - simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
        inv relate_share0. eapply id_g_norm0.
        autounfold with spec in *.
        destruct_zmap' Hnd; simpl in *; Frewrite; assumption.
      - simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
    }
  - split. reflexivity.
    assumption.
Qed.

Lemma smc_granule_undelegate_inv:
  forall norm_d v_addr ret_n norm_d'
    (Hspec: smc_granule_undelegate_spec v_addr norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv norm_d.(share)),
    SharedInv norm_d'.(share).
Admitted.

Lemma smc_granule_undelegate_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    v_addr ret_s ret_n sec_d' norm_d'
    (Hsec: smc_granule_undelegate_spec v_addr sec_d = Some (ret_s, sec_d'))
    (Hnorm: smc_granule_undelegate_spec v_addr norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv (norm_d.(share))),
  ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_granule_undelegate_spec in *; autounfold with sem in *.
  repeat simpl_hyp Hsec; inv Hsec; inv Hnorm.
  - repeat (auto; constructor).
  - autounfold with sem in *.
    Frewrite. simpl_hyp H0.
    inv H0.
    split. auto.
    { constructor.
      - constructor.
        + simpl. inv relate_sec_data0. autounfold with spec in *.
          intros.
          rewrite (walk_rtt_same (share (lens 422 sec_d))) in Hwalk.
          rewrite walk_rtt_lens_same in Hwalk.
          assert_gso' Hrd.
          { red; intros T; inv T. rewrite ZMap.gss in Hrd.
            simpl in Hrd. rewrite e_state_lens_same in Hrd.
            Frewrite. lia. }
          rewrite (ZMap.gso _ _ Hneq) in Hrd.
          rewrite e_state_lens_same in Hrd.
          exploit mem_rel0; try eassumption.
          repeat rewrite g_norm_lens_same. auto.
          simpl. intros. reflexivity.
      - constructor; intros; simpl in *.
        all: (repeat rewrite lens_same in *; simpl in *; Frewrite; try reflexivity).
        autounfold with spec in *.
        eapply (id_g_norm _ _ relate_share0). autounfold with spec in *.
        destruct_zmap' Hnd; simpl in *; Frewrite; assumption.
      - constructor; intros; simpl in *;
          repeat rewrite lens_same; Frewrite; reflexivity.
    }
  - autounfold with sem in *.
    Frewrite. simpl_hyp H0; inv H0.
    split. auto.
    { constructor.
      - constructor. simpl. inv relate_sec_data0. repeat rewrite lens_same.
        intros. destruct_zmap' Hrd. subst.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
        erewrite walk_rtt_same in Hwalk.
        simpl in *. eapply mem_rel0 in Hrd. 2: eapply Hwalk.
        assumption.
        simpl. intros. reflexivity.
      - simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
        inv relate_share0. eapply id_g_norm0.
        autounfold with spec in *.
        destruct_zmap' Hnd; simpl in *; Frewrite; assumption.
      - simpl. repeat rewrite lens_same; simpl.
        constructor; intros; simpl in *; Frewrite; try reflexivity.
    }
  - split. reflexivity.
    assumption.
Qed.
