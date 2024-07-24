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
Parameter PTE_PERM: Z -> Z.

Axiom zero_granule_state: forall sh, (sh.(granules) @ 0).(e_state) = -1.

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

Definition walk_star (sh: Shared) (rd: Z) (gfn: Z) (rtt_idx: Z) : Prop :=
  exists lvl pte N,
    walk_rtt_level N sh 0 rd gfn (gidx_to_table_pte (rd_rtt sh rd)) = (lvl, pte)
    /\ rtt_idx = pte_to_gidx pte.

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

Definition pte_table_equiv (pte: Z) (table: ZMap.t Z) : Prop :=
  PTE_IS_TABLE pte = false /\
  forall idx, 
         if pte_to_gidx pte =? 0 then
           pte_to_gidx (table @ idx) = 0
         else
           PTE_PERM pte = PTE_PERM (table @ idx) /\  pte_to_gidx (table @ idx) = pte_to_gidx pte + idx.

Definition rd_rtt_reverse (sh: Shared) : Prop :=
  exists (rev: Z -> Z),
  forall rd rtt_idx (Hrtt: rd_rtt sh rd = rtt_idx), rev rtt_idx = rd.

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
      new_entry (Hne: PTE_IS_TABLE new_entry = false \/ pte_to_gidx new_entry <> rtt2),
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

    pte_table_equiv_walk_same:
    forall sh rd gfn rtt
      (Hwalk1: walk_star sh rd gfn rtt)
      (Htable1: (sh.(granules) @ rtt).(e_state) = GRANULE_STATE_RTT)
      idx rtt2
      (Hchild: pte_to_gidx ((sh.(granule_data) @ rtt).(g_norm) @ idx) = rtt2)
      (Htable2: (sh.(granules) @ rtt2).(e_state) = GRANULE_STATE_RTT)
      pte (Hequiv: pte_table_equiv pte (sh.(granule_data) @ rtt2).(g_norm)),
    forall rd' gfn',
      walk_rtt
        (sh.[granule_data] :<
           (sh.(granule_data) # rtt == ((sh.(granule_data) @ rtt).[g_norm] :< ((sh.(granule_data) @ rtt).(g_norm) # idx == pte))))
        rd' gfn'
      = walk_rtt sh rd' gfn';
  }.

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

Axiom oracle_rel:
  forall sec_d norm_d sec_sh' norm_sh'
         (Hrepl_sec: repl sec_d (oracle sec_d (log sec_d)) (sec_d.(share)) = Some sec_sh')
         (Hrepl_norm: repl norm_d (oracle norm_d (log norm_d)) (norm_d.(share)) = Some norm_sh')
         sec_st
         (Hrelate: relate sec_d sec_st norm_d)
         (Hinv: SharedInv sec_d.(share)),
    relate (sec_d.[share] :< sec_sh') sec_st (norm_d.[share] :< norm_sh') /\ SharedInv sec_sh'.

Record lens_field_same: Prop := {
    lens_gpt_same: forall st v, gpt (share (lens v st)) = gpt (share st)
  }.

Parameter lens_field_same_prop: lens_field_same.

Ltac rewrite_lens :=
  match goal with
  | [|- context[gpt (share (lens ?v ?st))] ] => rewrite (lens_gpt_same lens_field_same_prop st v)
  | [H: context[gpt (share (lens ?v ?st)) ] |- _] => rewrite (lens_gpt_same lens_field_same_prop st v) in H
  end.

Ltac Frewrite := repeat (repeat rewrite_id; frewrite).
