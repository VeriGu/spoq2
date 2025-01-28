Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Bottom.Spec.
Require Import Layer13.Spec.
(* Require Import SMCHandler.Spec. *)

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

(* guest page frame --> rtt offset *)
Parameter gfn_to_rtt_offs: Z -> Z -> Z. 


(* the least significant 12 bits of the gfn *)
Parameter gfn_to_pte_offs: Z -> Z -> Z.

(* page table entry --> granule index *)
Parameter pte_to_gidx: Z -> Z.
Definition INVALID_GIDX : Z := NR_GRANULES + 1.

(* 
we assume pte_to_gidx is super powerful: 
  - 0 <= x < NR_GRANULES (valid PTE)
  - INVALID_GIDX (bad)
*)

Parameter addr_to_gidx: Z -> Z.
Parameter ADDR_MASK: Z.

(* invalid granule *)
Axiom invalid_granule_state: forall sh, (sh.(globals).(g_granules) @ INVALID_GIDX).(e_state_s_granule) = -1.

Parameter PTE_IS_VALID: Z -> bool.
Parameter PTE_IS_TABLE: Z -> bool.
Parameter gidx_to_table_pte : Z -> Z. 
Lemma gidx_to_table_pte_is_table:
  forall gidx, PTE_IS_TABLE (gidx_to_table_pte gidx) = true.
Admitted.

Lemma gidx_to_pte_to_gidx:
  forall gidx, pte_to_gidx (gidx_to_table_pte gidx) = gidx.
Admitted.

Definition walk_one_step (sh: Shared) (lvl: Z) (gfn: Z) (rtt_idx: Z) : Z :=
  let offs := gfn_to_rtt_offs gfn lvl in
  (sh.(granule_data) @ rtt_idx).(g_norm) @ offs.

Parameter dummy_rd: Z.
(* starts from level `lvl`, and steps `n` layers *)
Fixpoint walk_rtt_level (n: nat) (sh: Shared) (lvl: Z) (rd: Z) (gfn: Z) (pte: Z) : (Z * Z) :=
  match n with
  | O => (lvl, pte)
  | S n' => 
    match walk_rtt_level n' sh lvl rd gfn pte with
    | (lvl', pte') => (
      let rtt_idx' := pte_to_gidx pte' in
      if ((sh.(globals).(g_granules) @ rtt_idx').(e_state_s_granule) =? GRANULE_STATE_RTT) then
        let pte'' := walk_one_step sh lvl' gfn rtt_idx' in
        (lvl' + 1, pte'')
      else
        (lvl', pte')
    )
    end
  end.

(* Definition container_rtt_stage_1 sh g_rtt := g_rtt *)

(** Definition that returns the RTT page address *)
Parameter rtt_to_dummy_pte : Z -> Z.

(* REC stage 1 ttbr0 or ttbr1 *)
Definition rec_rtt_s1_ttbr0_raw sh rec_idx := (sh.(granule_data) @ rec_idx).(g_rec).(e_s1_ctx).(e_g_ttbr0).
Definition rec_rtt_s1_ttbr0 sh rec_idx := rtt_to_dummy_pte (rec_rtt_s1_ttbr0_raw sh rec_idx).
Definition gidx_rec_rtt_ttbr0 sh rec_idx := (gidx_to_table_pte (rec_rtt_s1_ttbr0 sh rec_idx)).

(* REC stage 1 ttbr0 or ttbr1 *)
Definition rec_rtt_s1_ttbr1_raw sh rec_idx := (sh.(granule_data) @ rec_idx).(g_rec).(e_s1_ctx).(e_g_ttbr1).
Definition rec_rtt_s1_ttbr1 sh rec_idx := rtt_to_dummy_pte (rec_rtt_s1_ttbr1_raw sh rec_idx).
Definition gidx_rec_rtt_ttbr1 sh rec_idx := (gidx_to_table_pte (rec_rtt_s1_ttbr1 sh rec_idx)).

(** RD stage 2 rtt *)
Definition rd_rtt_stage_2_raw sh rd_idx := (sh.(granule_data) @ rd_idx).(g_rd).(e_s2_ctx).(e_g_rtt).
Definition rd_rtt sh rd_idx := rtt_to_dummy_pte (rd_rtt_stage_2_raw sh rd_idx).
Definition gidx_rd_rtt sh rd := (gidx_to_table_pte (rd_rtt sh rd)).


Definition walk_rtt_rec_ttbr0 sh rec gfn :=
  let rtt_pte := gidx_to_table_pte (rec_rtt_s1_ttbr0 sh rec) in
  match walk_rtt_level 4%nat sh 0 dummy_rd gfn rtt_pte with
  | (lvl', pte') =>
    if PTE_IS_VALID pte' then
      let idx' := pte_to_gidx pte' in
      Some (idx' + gfn_to_pte_offs lvl' gfn)
    else
      None
  end.

Definition walk_rtt_rec_ttbr1 sh rec gfn :=
  let rtt_pte := gidx_to_table_pte (rec_rtt_s1_ttbr1 sh rec) in
  match walk_rtt_level 4%nat sh 0 dummy_rd gfn rtt_pte with
  | (lvl', pte') =>
    if PTE_IS_VALID pte' then
      let idx' := pte_to_gidx pte' in
      Some (idx' + gfn_to_pte_offs lvl' gfn)
    else
      None
  end.


Definition walk_rtt_rd sh rd gfn :=
  let rtt_pte := gidx_to_table_pte (rd_rtt sh rd) in
  match walk_rtt_level 4%nat sh 0 rd gfn rtt_pte with
  | (lvl', pte') =>
    if PTE_IS_VALID pte' then
      let idx' := pte_to_gidx pte' in
      Some (idx' + gfn_to_pte_offs lvl' gfn)
    else
      None
  end.


Definition walk_rtt_general sh rtt_pte gfn :=
  match walk_rtt_level 4%nat sh 0 dummy_rd gfn rtt_pte with
  | (lvl', pte') =>
    if PTE_IS_VALID pte' then
      let idx' := pte_to_gidx pte' in
      Some (idx' + gfn_to_pte_offs lvl' gfn)
    else
      None
  end.

Definition walk_start_general (sh: Shared) (root_rtt: Z) (gfn: Z) (target_rtt_idx: Z) : Prop :=
  exists lvl pte N,
    walk_rtt_level N sh 0 dummy_rd gfn root_rtt = (lvl, pte)
    /\ target_rtt_idx = pte_to_gidx pte.

Definition walk_start_rec_ttbr0 (sh: Shared) (rec: Z) (gfn: Z) (rtt_idx: Z) : Prop :=
  exists lvl pte N,
    walk_rtt_level N sh 0 dummy_rd gfn (gidx_rec_rtt_ttbr0 sh rec) = (lvl, pte)
    /\ rtt_idx = pte_to_gidx pte.

Definition walk_start_rec_ttbr1 (sh: Shared) (rec: Z) (gfn: Z) (rtt_idx: Z) : Prop :=
  exists lvl pte N,
    walk_rtt_level N sh 0 dummy_rd gfn (gidx_rec_rtt_ttbr1 sh rec) = (lvl, pte)
    /\ rtt_idx = pte_to_gidx pte.

Definition walk_start_rd (sh: Shared) (rd: Z) (gfn: Z) (rtt_idx: Z) : Prop :=
  exists lvl pte N,
    walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)) = (lvl, pte)
    /\ rtt_idx = pte_to_gidx pte.

Lemma walk_start_rd_prop:
  forall sh rd gfn rtt_idx (Hwalk_star: walk_start_rd sh rd gfn rtt_idx),
    (rtt_idx = rd_rtt sh rd) \/
      exists rtt_idx0 offs0,
        walk_start_rd sh rd gfn rtt_idx0
        /\ (sh.(globals).(g_granules) @ rtt_idx0).(e_state_s_granule) = GRANULE_STATE_RTT
        /\ (rtt_idx = pte_to_gidx ((sh.(granule_data) @ rtt_idx0).(g_norm) @ offs0)).
Proof.
  intros.
  unfold walk_start_rd in Hwalk_star.
  destruct Hwalk_star as (lvl & pte & N & Hwalk).
  induction N.
  - simpl in Hwalk. destruct Hwalk as (Hw1 & Hw2). inv Hw1.
    left. rewrite gidx_to_pte_to_gidx. reflexivity.
  - simpl in Hwalk. repeat simpl_hyp Hwalk; inv Hwalk.
   + right. repeat eexists. eapply C. bool_rel_all. assumption.
    inv H. reflexivity.
   + apply IHN. auto.
Qed.

(* walk(m + n) = walk(m(walk(n)) *)
Lemma walk_rtt_level_split:
  forall m,
  forall n sh lvl gfn pte lvl' pte' (Hwalk: walk_rtt_level n sh lvl dummy_rd gfn pte = (lvl', pte')),
    walk_rtt_level (m + n) sh lvl dummy_rd gfn pte = walk_rtt_level m sh lvl' dummy_rd gfn pte'.
Proof.
  induction m.
  simpl. intros. assumption.
  simpl. intros.
  erewrite IHm.
  2: apply Hwalk. reflexivity.
Qed.

Lemma invalid_start_walk_invalid:
  forall N sh lvl rd gidx pte (Hinvalid: pte_to_gidx pte = INVALID_GIDX),
    walk_rtt_level N sh lvl rd gidx pte = (lvl, pte).
Proof.
  induction N.
  simpl; intros. reflexivity.
  intros. simpl. rewrite IHN. autounfold with spec.
  rewrite Hinvalid. rewrite invalid_granule_state.
  destruct_if. lia. reflexivity. assumption.
Qed.

Parameter granules_rtt_is_root : (ZMap.t s_granule) -> Z -> Prop.
Lemma root_rtt_is_rtt:
  forall gidx gs, (granules_rtt_is_root gs gidx) -> ((gs @ gidx).(e_state_s_granule) = GRANULE_STATE_RTT).
Admitted.

Parameter granules_rtt_to_parent_rd : (ZMap.t s_granule) -> Z -> Z.
Definition walk_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> (Z * Z)),
  forall rd gfn rtt_idx root_rtt
    (Hrtt_rd: granules_rtt_to_parent_rd sh.(globals).(g_granules) root_rtt = rd)
    (Hwalk: walk_start_general sh root_rtt gfn rtt_idx)
    (Hrtt: (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT),
    forall parent_idx ofs, rev rtt_idx = (parent_idx, ofs) ->
                   (((granules_rtt_is_root sh.(globals).(g_granules) rtt_idx) -> parent_idx = rd /\ ofs = -1) 
                   (* an RD can have multiple entries, therefore multiple rtt may map to the same (RD, -1) *)
                    /\ ((~(granules_rtt_is_root sh.(globals).(g_granules) rtt_idx)) ->
                       ((sh.(globals).(g_granules) @ parent_idx).(e_state_s_granule) = GRANULE_STATE_RTT
                        /\ pte_to_gidx ((sh.(granule_data) @ parent_idx).(g_norm) @ ofs) = rtt_idx))).

Lemma walk_rtt_level_unreachable_same_rd:
  forall sh rd gfn Brtt (Hunreachable: forall rtt, Brtt rtt = true -> ~ walk_start_rd sh rd gfn rtt),
  forall sh'
    (Hsame1: sh'.(globals).(g_granules) = sh.(globals).(g_granules))
    (Hsame2: forall rd, g_rd (sh'.(granule_data) @ rd) = g_rd (sh.(granule_data) @ rd))
    (Hsame3: forall rtt, Brtt rtt = false -> (sh'.(granule_data) @ rtt).(g_norm) = (sh.(granule_data) @ rtt).(g_norm)),
  forall N, walk_rtt_level N sh' 0 rd gfn (gidx_to_table_pte (rd_rtt sh' rd))
       = walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)).
Proof.
  simpl. intros until N.
  induction N.
  - simpl.
    unfold rd_rtt. unfold rd_rtt_stage_2_raw. simpl.
    rewrite Hsame2. reflexivity.
  - simpl. rewrite IHN.
    destruct (walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd))) eqn:Hwalk.
    rewrite Hsame1.
    destruct_if.
    unfold walk_one_step.
    destruct (Brtt (pte_to_gidx z0)) eqn:HB.
    + exploit Hunreachable. eassumption.
      unfold walk_start_rd.
      repeat eexists. eassumption. contradiction.
    + rewrite Hsame3. reflexivity. assumption.
    + reflexivity.
Qed.

Lemma walk_unreachable_same_rd:
  forall sh rd gfn Brtt (Hunreachable: forall rtt, Brtt rtt = true -> ~ walk_start_rd sh rd gfn rtt),
  forall sh'
         (Hsame1: sh'.(globals).(g_granules) = sh.(globals).(g_granules))
         (Hsame2: forall rd, g_rd (sh'.(granule_data) @ rd) = g_rd (sh.(granule_data) @ rd))
         (Hsame3: forall rtt, Brtt rtt = false -> (sh'.(granule_data) @ rtt).(g_norm) = (sh.(granule_data) @ rtt).(g_norm)),
    walk_rtt_rd sh' rd gfn = walk_rtt_rd sh rd gfn.
Proof.
  intros. unfold walk_rtt_rd.
  erewrite walk_rtt_level_unreachable_same_rd; try eassumption.
  reflexivity.
Qed.

Definition secure_realm_access_mem_general
  (rd_gidx: Z) (addr: Z) (val: Z) (start_rtt_idx: Z) (st: (RData * SecState)) : option ((RData * SecState) * Z)
  :=
  let (st, sec_st) := st in
  rely ((0 < addr < 4294967296));
  rely (0 <= val < 256);
  rely (0 <= rd_gidx < 1048576);
  rely (0 <= start_rtt_idx < NR_GRANULES);
  (* rely (e_state_s_granule rd = GRANULE_STATE_RD); *)
  rely (granules_rtt_to_parent_rd st.(share).(globals).(g_granules) start_rtt_idx = rd_gidx);
  rely (granules_rtt_is_root st.(share).(globals).(g_granules) start_rtt_idx);
  let ipa_gidx := addr_to_gidx addr in
  let offset := addr mod 4096 in
  match walk_rtt_general st.(share) start_rtt_idx ipa_gidx with
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

Definition normal_realm_access_mem_general
  (rd_gidx: Z) (addr: Z) (val: Z) (start_rtt_idx: Z) (st: RData) : option (RData * Z)
  :=
  rely ((0 < addr < 4294967296));
  rely (0 <= val < 256);
  rely (0 <= start_rtt_idx < NR_GRANULES);
  rely (granules_rtt_to_parent_rd st.(share).(globals).(g_granules) start_rtt_idx = rd_gidx);
  rely (granules_rtt_is_root st.(share).(globals).(g_granules) start_rtt_idx);
  let ipa_gidx := addr_to_gidx addr in
  let offset := addr mod 4096 in
  match walk_rtt_general st.(share) start_rtt_idx ipa_gidx with
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

(* ********************************************************************************** *)

(* a gpt false can be either NS state or ANY state *)
Definition gpt_false_ns (sh: Shared) :=
  forall gidx, sh.(gpt) @ gidx = false -> ( 
    (sh.(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_NS \/ 
    (sh.(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_ANY ).


Definition delegated_zero (sh: Shared) :=
  forall gidx (Hdel: (sh.(globals).(g_granules) @ gidx).(e_state_s_granule) = GRANULE_STATE_DELEGATED),
    (sh.(granule_data) @ gidx).(g_norm) = zero_granule_data.


Definition rtt_map_data_any (sh: Shared) :=
  forall rtt_gidx 
    (Hrd: (sh.(globals).(g_granules) @ rtt_gidx).(e_state_s_granule) = GRANULE_STATE_RTT)
    (Hrtt_is_root: granules_rtt_is_root sh.(globals).(g_granules) rtt_gidx)
    ipa_gidx data_gidx (Hwalk: walk_rtt_general sh rtt_gidx ipa_gidx = Some data_gidx),
    (sh.(globals).(g_granules) @ data_gidx).(e_state_s_granule) = GRANULE_STATE_DATA \/
    (sh.(globals).(g_granules) @ data_gidx).(e_state_s_granule) = GRANULE_STATE_ANY.

(* Parameter granules_rtt_to_parent_rd : (ZMap.t s_granule) -> Z -> Z. *)
Definition rd_rtt_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> Z),
  forall rtt_idx
    (Hrtt: (sh.(globals).(g_granules) @ rtt_idx).(e_state_s_granule) = GRANULE_STATE_RTT), 
    exists rd, rev rtt_idx = rd /\ ((sh.(globals).(g_granules) @ rd).(e_state_s_granule) = GRANULE_STATE_RD).

Record SharedInv (sh: Shared) : Prop :=
  {
    gpt_false_ns_inv: gpt_false_ns sh;
    delegated_zero_inv: delegated_zero sh;
    rtt_map_data_inv: rtt_map_data_any sh; 
    walk_reverse_inv: walk_reverse sh;
    rd_rtt_reverse_inv: rd_rtt_reverse sh (* Unlike RMM, container has a one(RD)-> many(RTT) mapping *)
  }.

(* Record SharedInvImply (sh: Shared) : Prop :=
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
  }. *)

(* Lemma shared_inv_implies:
  forall sh, SharedInv sh -> SharedInvImply sh.
Admitted.  *)

(************************************************************************************)

Record relate_secure (sec_rdata: RData) (sec_st: SecState) (norm_rdata: RData) : Prop :=
  {
    mem_rel:
    forall rd_gidx (Hrd: (sec_rdata.(share).(globals).(g_granules) @ rd_gidx).(e_state_s_granule) = GRANULE_STATE_RD)
      vaddr data_gidx rtt_gidx
      (Hrtt_rd: granules_rtt_to_parent_rd norm_rdata.(share).(globals).(g_granules) rtt_gidx = rd_gidx)
      (Hwalk: walk_rtt_general (sec_rdata.(share)) rtt_gidx (addr_to_gidx vaddr) = Some data_gidx),
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
    id_gpt: norm_share.(gpt) = sec_share.(gpt); (* granuie-idx --> {true, false(NS/ANY)} *)

    (* id_glk: norm_share.(glk) = sec_share.(glk); *)

    (* id_slots: norm_share.(slots) = sec_share.(slots); *)
    id_granules: norm_share.(globals).(g_granules) = sec_share.(globals).(g_granules);

    id_gd_g_idx: forall i, (norm_share.(granule_data) @ i).(gd_g_idx) = (sec_share.(granule_data) @ i).(gd_g_idx);
    id_g_rd: forall i, (norm_share.(granule_data) @ i).(g_rd) = (sec_share.(granule_data) @ i).(g_rd);
    id_g_rec: forall i, (norm_share.(granule_data) @ i).(g_rec) = (sec_share.(granule_data) @ i).(g_rec);

    (* id_g_aux_pmu_state: forall i, (norm_share.(granule_data) @ i).(g_aux_pmu_state) = (sec_share.(granule_data) @ i).(g_aux_pmu_state); *)
    (* id_g_aux_simd_state: forall i, (norm_share.(granule_data) @ i).(g_aux_simd_state) = (sec_share.(granule_data) @ i).(g_aux_simd_state); *)
    (* id_rec_gidx: forall i, (norm_share.(granule_data) @ i).(rec_gidx) = (sec_share.(granule_data) @ i).(rec_gidx); *)
    id_g_norm:
      forall i (Hnd: (norm_share.(globals).(g_granules) @ i).(e_state_s_granule) <> GRANULE_STATE_DATA),
        (norm_share.(granule_data) @ i).(g_norm) = (sec_share.(granule_data) @ i).(g_norm);

    (* id_gv_g_sve_max_vq: norm_share.(gv_g_sve_max_vq) = sec_share.(gv_g_sve_max_vq); *)
    (* id_gv_g_ns_simd: norm_share.(gv_g_ns_simd) = sec_share.(gv_g_ns_simd); *)
    (* id_gv_g_cpu_simd_type: norm_share.(gv_g_cpu_simd_type) = sec_share.(gv_g_cpu_simd_type); *)
    (* id_gv_vmids: norm_share.(gv_vmids) = sec_share.(gv_vmids); *)
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
  rewrite id_granules1. try intuition.
  intro.
  rewrite id_gd_g_idx1. try intuition.
  intro. rewrite id_g_rd1. try intuition.
  intro. rewrite id_g_rec1. try intuition.
  intros. rewrite id_g_norm1. rewrite id_g_norm0. reflexivity.
  rewrite <- id_granules1. assumption. assumption.
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
(*

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
*)

Record relate (sec_rdata: RData) (sec_st: SecState) (norm_rdata: RData) : Prop :=
  {
    relate_sec_data: relate_secure sec_rdata sec_st norm_rdata;
    relate_share: id_share sec_rdata.(share) norm_rdata.(share);
    relate_local: id_local sec_rdata norm_rdata
  }. 