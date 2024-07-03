Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

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
Parameter PTE_VALID: Z.

Definition walk_one_step sh lvl gfn rtt_idx :=
  let offs := gfn_to_rtt_offs gfn lvl in
  let pte := (sh.(granule_data) @ rtt_idx).(g_norm) @ offs in
  let addr := pte & ADDR_MASK in
  let gidx := addr_to_gidx addr in
  (gidx, pte).

Fixpoint walk_rtt_level (n: nat) (sh: Shared) (lvl: Z) (rd: Z) (gfn: Z) (rtt_idx: Z) (pte: Z) :=
  match n with
  | O => (lvl, rtt_idx, pte)
  | S n' =>
    match walk_rtt_level n' sh lvl rd gfn rtt_idx pte with
    | (lvl', rtt_idx', pte') =>
      if ((pte & PTE_VALID) =? PTE_VALID) && ((sh.(granules) @ rtt_idx').(e_state) =? GRANULE_STATE_RTT) then
        let (gidx, pte') := walk_one_step sh lvl' gfn rtt_idx' in
        (lvl' + 1, gidx, pte')
      else
        (lvl', rtt_idx', pte')
    end
  end.

Definition rd_rtt sh rd := (sh.(granule_data) @ rd).(g_rd).(e_rd_s2_ctx).(e_rls2ctx_g_rtt).

Definition walk_rtt sh rd gfn :=
  let rtt_idx := rd_rtt sh rd in
  match walk_rtt_level 4%nat sh 0 rd gfn rtt_idx 0 with
  | (lvl', idx', pte') =>
    if (pte' & PTE_VALID) <>? PTE_VALID then None
    else Some (idx' + gfn_to_pte_offs lvl' gfn)
  end.

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
  forall gidx (Hdel: (sh.(granules) @ gidx).(e_state) = GRANULE_STATE_DELEAGATE),
    sh.(granule_data) @ gidx = zero_granule.

Definition rtt_map_data (sh: Shared) :=
  forall rd_gidx (Hrd: (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
    ipa_gidx data_gidx (Hwalk: walk_rtt sh rd_gidx ipa_gidx = Some data_gidx),
    (sh.(granules) @ data_gidx).(e_state) = GRANULE_STATE_DATA.

Definition rtt_reverse (sh: Shared) :=
  exists data_to_rd,
    forall rd_gidx (Hrd: (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD)
      ipa_gidx data_gidx (Hwalk: walk_rtt sh rd_gidx ipa_gidx = Some data_gidx),
      data_to_rd data_gidx = (rd_gidx, ipa_gidx).

Definition rec_rd_prop (sh: Shared) :=
  forall gidx (Hrec: (sh.(granules) @ gidx).(e_state) = GRANULE_STATE_REC),
    let rd_gidx := (sh.(granule_data) @ gidx).(g_rec).(e_realm_info).(e_g_rd) in
    (sh.(granules) @ rd_gidx).(e_state) = GRANULE_STATE_RD.


Record SharedInv (sh: Shared) : Prop :=
  {
    gpt_false_ns_inv: gpt_false_ns sh;
    delegated_zero_inv: delegated_zero sh;
    rtt_map_data_inv: rtt_map_data sh;
    rtt_reverse_inv: rtt_reverse sh
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
    id_gpt: sec_share.(gpt) = norm_share.(gpt);
    id_glk: sec_share.(glk) = norm_share.(glk);
    id_slots: sec_share.(slots) = norm_share.(slots);
    id_granules: sec_share.(granules) = norm_share.(granules);
    id_gd_g_idx: forall i, (sec_share.(granule_data) @ i).(gd_g_idx) = (norm_share.(granule_data) @ i).(gd_g_idx);
    id_g_rd: forall i, (sec_share.(granule_data) @ i).(g_rd) = (norm_share.(granule_data) @ i).(g_rd);
    id_g_rec: forall i, (sec_share.(granule_data) @ i).(g_rec) = (norm_share.(granule_data) @ i).(g_rec);
    id_g_aux_pmu_state: forall i, (sec_share.(granule_data) @ i).(g_aux_pmu_state) = (norm_share.(granule_data) @ i).(g_aux_pmu_state);
    id_g_aux_simd_state: forall i, (sec_share.(granule_data) @ i).(g_aux_simd_state) = (norm_share.(granule_data) @ i).(g_aux_simd_state);
    id_rec_gidx: forall i, (sec_share.(granule_data) @ i).(rec_gidx) = (norm_share.(granule_data) @ i).(rec_gidx);
    id_g_norm:
      forall i (Hnd: (sec_share.(granules) @ i).(e_state) <> GRANULE_STATE_DATA),
        (sec_share.(granule_data) @ i).(g_norm) = (norm_share.(granule_data) @ i).(g_norm);
    id_gv_g_sve_max_vq: sec_share.(gv_g_sve_max_vq) = norm_share.(gv_g_sve_max_vq);
    id_gv_g_ns_simd: sec_share.(gv_g_ns_simd) = norm_share.(gv_g_ns_simd);
    id_gv_g_cpu_simd_type: sec_share.(gv_g_cpu_simd_type) = norm_share.(gv_g_cpu_simd_type);
    id_gv_vmids: sec_share.(gv_vmids) = norm_share.(gv_vmids);
  }.

Record id_local (sec_rdata: RData) (norm_rdata: RData) : Prop :=
  {
    id_log: sec_rdata.(log) = norm_rdata.(log);
    id_oracle: sec_rdata.(oracle) = norm_rdata.(oracle);
    id_repl: sec_rdata.(repl) = norm_rdata.(repl);
    id_priv: sec_rdata.(priv) = norm_rdata.(priv);
    id_stack: sec_rdata.(stack) = norm_rdata.(stack);
    id_func_sp: sec_rdata.(func_sp) = norm_rdata.(func_sp)
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
  | [H: id_local ?sd ?nd |- context[?sd.(log)] ] => rewrite (id_log sd nd H)
  | [H: id_local ?sd ?nd |- context[?sd.(oracle)] ] => rewrite (id_oracle sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(glk)] ] => rewrite (id_glk sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(gpt)] ] => rewrite (id_gpt sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(slots)] ] => rewrite (id_slots sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(granules)] ] => rewrite (id_granules sd nd H)
  | [H: id_share ?sd ?nd |- context[(?sd.(granule_data) @ ?i).(gd_g_idx)] ] => rewrite (id_gd_g_idx sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?sd.(granule_data) @ ?i).(g_rd)] ] => rewrite (id_g_rd sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?sd.(granule_data) @ ?i).(g_rec)] ] => rewrite (id_g_rec sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?sd.(granule_data) @ ?i).(g_aux_pmu_state)] ] => rewrite (id_g_aux_pmu_state sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?sd.(granule_data) @ ?i).(g_aux_simd_state)] ] => rewrite (id_g_aux_simd_state sd nd H i)
  | [H: id_share ?sd ?nd |- context[(?sd.(granule_data) @ ?i).(rec_gidx)] ] => rewrite (id_rec_gidx sd nd H i)
  | [H: id_share ?sd ?nd |- context[?sd.(gv_g_sve_max_vq)] ] => rewrite (id_gv_g_sve_max_vq sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(gv_g_ns_simd)] ] => rewrite (id_gv_g_ns_simd sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(gv_g_cpu_simd_type)] ] => rewrite (id_gv_g_cpu_simd_type sd nd H)
  | [H: id_share ?sd ?nd |- context[?sd.(gv_vmids)] ] => rewrite (id_gv_vmids sd nd H)
  | [H: id_local ?sd ?nd |- context[?sd.(repl)] ] => rewrite (id_repl sd nd H)
  | [H: id_local ?sd ?nd |- context[?sd.(priv)] ] => rewrite (id_priv sd nd H)
  | [H: id_local ?sd ?nd |- context[?sd.(stack)] ] => rewrite (id_stack sd nd H)
  | [H: id_local ?sd ?nd |- context[?sd.(func_sp)] ] => rewrite (id_func_sp sd nd H)
  | [H1: id_local ?sd ?nd, H2: context[?sd.(log)] |- _] => rewrite (id_log sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?sd.(oracle)] |- _] => rewrite (id_oracle sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(glk)] |- _] => rewrite (id_glk sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(gpt)] |- _] => rewrite (id_gpt sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(slots)] |- _] => rewrite (id_slots sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(granules)] |- _] => rewrite (id_granules sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?sd.(granule_data) @ ?i).(gd_g_idx)] |- _] => rewrite (id_gd_g_idx sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?sd.(granule_data) @ ?i).(g_rd)] |- _] => rewrite (id_g_rd sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?sd.(granule_data) @ ?i).(g_rec)] |- _] => rewrite (id_g_rec sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?sd.(granule_data) @ ?i).(g_aux_pmu_state)] |- _] => rewrite (id_g_aux_pmu_state sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?sd.(granule_data) @ ?i).(g_aux_simd_state)] |- _] => rewrite (id_g_aux_simd_state sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[(?sd.(granule_data) @ ?i).(rec_gidx)] |- _] => rewrite (id_rec_gidx sd nd H1 i) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(gv_g_sve_max_vq)] |- _] => rewrite (id_gv_g_sve_max_vq sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(gv_g_ns_simd)] |- _] => rewrite (id_gv_g_ns_simd sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(gv_g_cpu_simd_type)] |- _] => rewrite (id_gv_g_cpu_simd_type sd nd H1) in H2
  | [H1: id_share ?sd ?nd, H2: context[?sd.(gv_vmids)] |- _] => rewrite (id_gv_vmids sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?sd.(repl)] |- _] => rewrite (id_repl sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?sd.(priv)] |- _] => rewrite (id_priv sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?sd.(stack)] |- _] => rewrite (id_stack sd nd H1) in H2
  | [H1: id_local ?sd ?nd, H2: context[?sd.(func_sp)] |- _] => rewrite (id_func_sp sd nd H1) in H2
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
    (Hinv: SharedInv norm_d.(share)),
    relate (sec_d.[share] :< sec_sh') sec_st (norm_d.[share] :< norm_sh') /\ SharedInv norm_sh'.

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
  forall s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init norm_d ret_n norm_d'
    (Hspec: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init norm_d = Some (ret_n, norm_d'))
    (Hinv: SharedInv norm_d.(share)),
    SharedInv norm_d'.(share).
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
          /\ walk_rtt_level (Z.to_nat lvl) (st_34.(share)) 0 rd gfn (rd_rtt (st_34.(share)) rd) 0 =
              (lvl, (((st_34.(stack)).(stack_wi)).(e_g_llt)), pte)
          /\ gfn_to_rtt_offs gfn lvl = 8 * (((st_34.(stack)).(stack_wi)).(e_index))
          /\ walk_one_step (st_34.(share)) lvl gfn (((st_34.(stack)).(stack_wi)).(e_g_llt)) = ((((st_34.(share)).(slots)) @ SLOT_RTT2), pte'));
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

Lemma smc_rtt_fold_3_secure:
  forall sec_d sec_st norm_d (Hrel: relate sec_d sec_st norm_d)
    s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init ret_n ret_s sec_d' norm_d'
    (Hnorm: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init norm_d = Some (ret_n, norm_d'))
    (Hsec: smc_rtt_fold_3 s2_ctx map_addr wi call15 call34 call44 call33 norm_d_init sec_d = Some (ret_s, sec_d'))
    (Hinv: SharedInv (norm_d.(share))),
    ret_s = ret_n /\ relate sec_d' sec_st norm_d'.
Proof.
  intros. pose proof Hrel as D. destruct D.
  unfold smc_rtt_fold_3 in *; autounfold with sem in *.
  repeat simpl_hyp Hsec. repeat simpl_hyp Hnorm. inv Hnorm.
  destruct e11 as (? & ? & ? & ? & ? & ? & ? & ? & ?).
  clear C19.
  Frewrite. simpl_hyp Hsec. inv Hsec.
  extract_prop.
  split.
  - reflexivity.
  - constructor.
    {
      constructor; simpl.
      inv relate_sec_data0.
      rewrite_id.
      remember ((e_g_llt (stack_wi (stack norm_d)))) as rtt_idx. symmetry in Heqrtt_idx.
      remember ((slots (share sec_d)) @ SLOT_RTT2) as rtt2_idx. symmetry in Heqrtt2_idx.
      remember (match e_index (stack_wi (stack norm_d)) with | 0 => 0  | Z.pos y' => Z.pos y'~0~0~0 | Z.neg y' => Z.neg y'~0~0~0 end) as e_idx.
      remember (poffset call15) as call15_ofs. symmetry in Heqcall15_ofs.
      remember (call15_ofs + e_idx) as g_norm_idx. symmetry in Heqg_norm_idx.
      remember ((granule_data (share sec_d))) as granule_data_sec. symmetry in Heqgranule_data_sec.
      intros.
      rewrite lens_same in Hrd. repeat rewrite_id.
      repeat rewrite lens_same in Hwalk.
      match type of Hwalk with
      | walk_rtt ?d ?rd ?addr = _ =>
        assert(Hwalk_eq: walk_rtt d rd addr = walk_rtt (share sec_d) rd addr)
      end.
      {
        rewrite Heqrtt2_idx.
        assert_gso. lia. rewrite (ZMap.gso _ _ Hneq).
        rewrite walk_rtt_same_set_slot.

        admit.
      }
      rewrite Hwalk_eq in Hwalk.
      pose proof (mem_rel0 rd_gidx Hrd vaddr data_gidx Hwalk) as mem_rel.
      simpl in mem_rel.
      inv Hinv. unfold rtt_map_data in *.
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
