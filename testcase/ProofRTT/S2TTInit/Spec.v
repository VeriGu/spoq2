Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.Spec.
Require Import S2TTEOps.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section S2TTInit_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition s2tt_init_valid_ns_loop738_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
    (512 - (v_indvars_iv)).

  Definition s2tt_init_valid_loop719_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
    (512 - (v_indvars_iv)).

  Definition s2tt_init_assigned_empty_loop700_rank (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) : Z :=
    (512 - (v_indvars_iv)).

  Definition s2tt_init_destroyed_loop0_rank (v_index: Z) (v_s2tt: Ptr) : Z :=
    (256 - ((v_index / (2)))).

  Definition s2tt_init_unassigned_loop0_rank (v_call: Z) (v_index: Z) (v_s2tt: Ptr) : Z :=
    (256 - ((v_index / (2)))).

  (* Definition realm_ipa_get_ripas_1_low (v_call: Ptr) (v_g_llt: Ptr) (v_ws_0: Z) (init_st: RData) (st: RData) : (option (Z * RData)) := *)
  (*   rely (((v_call.(pbase)) = ("slot_rtt"))); *)
  (*   rely (((v_g_llt.(pbase)) = ("realm_ipa_get_ripas_stack"))); *)
  (*   when st == ((buffer_unmap_spec v_call st)); *)
  (*   when v_8_tmp, st == ((load_RData 8 v_g_llt st)); *)
  (*   rely (((v_8_tmp < (STACK_VIRT)) /\ ((v_8_tmp >= (GRANULES_BASE))))); *)
  (*   let v_8 := (int_to_ptr v_8_tmp) in *)
  (*   when st == ((granule_unlock_spec v_8 st)); *)
  (*   let __retval__ := v_ws_0 in *)
  (*   when st == ((free_stack "realm_ipa_get_ripas" init_st st)); *)
  (*   (Some (__retval__, st)). *)

  Fixpoint s2tt_init_valid_ns_loop738 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
    | (S _N__0) =>
      match ((s2tt_init_valid_ns_loop738 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
      | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
        if __return___0
        then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
        else (
          rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
          if (v_level_0 =? (3))
          then (
            when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
            if ((v_indvars_iv_0 + (1)) <>? (512))
            then (
              (Some (
                false  ,
                v_call_0  ,
                (v_indvars_iv_0 + (1))  ,
                v_level_0  ,
                (v_pa_addr_6 + (v_call_0))  ,
                v_s2tt_0  ,
                (st_0.[share].[granule_data] :<
                  (((st_0.(share)).(granule_data)) #
                    (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                    ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                      (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                        ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                        (v_pa_addr_6 |' (54043195528446979))))))
              )))
            else (
              (Some (
                true  ,
                v_call_0  ,
                v_indvars_iv_0  ,
                v_level_0  ,
                v_pa_addr_6  ,
                v_s2tt_0  ,
                (st_0.[share].[granule_data] :<
                  (((st_0.(share)).(granule_data)) #
                    (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                    ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                      (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                        ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                        (v_pa_addr_6 |' (54043195528446979))))))
              ))))
          else (
            when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
            if ((v_indvars_iv_0 + (1)) <>? (512))
            then (
              (Some (
                false  ,
                v_call_0  ,
                (v_indvars_iv_0 + (1))  ,
                v_level_0  ,
                (v_pa_addr_6 + (v_call_0))  ,
                v_s2tt_0  ,
                (st_0.[share].[granule_data] :<
                  (((st_0.(share)).(granule_data)) #
                    (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                    ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                      (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                        ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                        (v_pa_addr_6 |' (54043195528446977))))))
              )))
            else (
              (Some (
                true  ,
                v_call_0  ,
                v_indvars_iv_0  ,
                v_level_0  ,
                v_pa_addr_6  ,
                v_s2tt_0  ,
                (st_0.[share].[granule_data] :<
                  (((st_0.(share)).(granule_data)) #
                    (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                    ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                      (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                        ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                        (v_pa_addr_6 |' (54043195528446977))))))
              )))))
      | None => None
      end
    end.

  Definition s2tt_init_valid_ns_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    match ((s2tt_init_valid_ns_loop738 (z_to_nat 512) false (1 << ((39 + (((- 9) * (v_level)))))) 0 v_level v_pa v_s2tt st)) with
    | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      (Some st_1)
    | None => None
    end.

  Fixpoint s2tt_init_valid_loop719 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
    | (S _N__0) =>
      match ((s2tt_init_valid_loop719 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
      | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
        if __return___0
        then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
        else (
          rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
          when ret == ((s2tte_create_valid_spec' v_pa_addr_6 v_level_0));
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) == ret))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) == ret))))
            ))))
      | None => None
      end
    end.

  Lemma s2tte_create_valid_ret_valid:
    forall pa level ret,
      s2tte_create_valid_spec' pa level = Some ret -> Z.testbit ret 0 = true.
  Proof.
  Admitted.

  Lemma Z_of_nat_S_N_N_plus_1:
    forall N, Z.of_nat (S N) = Z.of_nat N + 1.
  Admitted.

  Lemma s2tt_init_valid_loop719_body_st_valid:
    forall (N: nat) v_call v_level v_pa_addr v_s2tt st
           ret' v_call' v_indvars_iv' v_level' v_pa_addr' v_s2tt' st'
      (HN: Nat.le N 512)
      (Hspec: s2tt_init_valid_loop719 N false v_call 0 v_level v_pa_addr v_s2tt st =
                Some (ret', v_call', v_indvars_iv', v_level', v_pa_addr', v_s2tt', st')),

      (v_s2tt = v_s2tt') /\
      (Z.of_nat N < 512 -> v_indvars_iv' = Z.of_nat N) /\
      (Z.of_nat N < 512 -> ret' = false) /\
      (v_indvars_iv' >= 0) /\
      (forall table_idx
      (Htable_idx: 0 <= table_idx < Z.of_nat N),
          let slot := (st'.(share).(slots) @ SLOT_DELEGATED) in
          let table_ofs := v_s2tt.(poffset) + (8 * table_idx) in
          let pte := (st'.(share).(granule_data) @ slot).(g_norm) @ table_ofs in
          Z.testbit pte 0 = true).
  Proof.
    Local Opaque Z.mul.
    induction N.
    - intros.
      simpl in Hspec. inv Hspec.
      repeat split. lia. lia.
    - repeat rewrite Z_of_nat_S_N_N_plus_1.
      intros.
      simpl in Hspec. simpl_hyp Hspec. repeat destruct p.
      apply IHN in C.
      destruct C as (C0 & C1 & C2 & C3 & C4).
      subst.
      rewrite C2 in Hspec.
      rewrite Z.add_0_r in *.
      autounfold with sem in Hspec. repeat simpl_hyp Hspec; inv Hspec.
      * repeat split. lia. lia.
        simpl in *. exploit C1. lia.
        intros.
        repeat (rewrite ZMap.gss; simpl).
        destruct (table_idx =? Z.of_nat N) eqn:Heq.
        bool_rel. subst.
        repeat (rewrite ZMap.gss; simpl).
        apply s2tte_create_valid_ret_valid in C6. assumption.
        assert_gso. lia. rewrite ZMap.gso. apply C4. lia. lia.
      * repeat split. lia. lia. lia.
        simpl in *. exploit C1. lia.
        intros.
        repeat (rewrite ZMap.gss; simpl).
        destruct (table_idx =? v_indvars_iv') eqn:Heq.
        bool_rel. subst.
        repeat (rewrite ZMap.gss; simpl).
        apply s2tte_create_valid_ret_valid in C6. assumption.
        assert_gso. lia. rewrite ZMap.gso. apply C4. lia. lia.
      * lia.
      * lia.
  Qed.

  Definition s2tt_init_valid_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    match ((s2tt_init_valid_loop719 (z_to_nat 512) false (1 << ((39 + (((- 9) * (v_level)))))) 0 v_level v_pa v_s2tt st)) with
    | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      (Some st_1)
    | None => None
    end.

  Lemma s2tt_init_assigned_empty_ret_assigned_empty:
    forall pa level ret,
      s2tte_create_assigned_empty_spec pa level = Some ret -> ret = pa |' 4.
  Proof.
    Admitted.

  Fixpoint s2tt_init_assigned_empty_loop700 (_N_: nat) (__return__: bool) (v_call: Z) (v_indvars_iv: Z) (v_level: Z) (v_pa_addr_05: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_call, v_indvars_iv, v_level, v_pa_addr_05, v_s2tt, st))
    | (S _N__0) =>
      match ((s2tt_init_assigned_empty_loop700 _N__0 __return__ v_call v_indvars_iv v_level v_pa_addr_05 v_s2tt st)) with
      | (Some (__return___0, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0)) =>
        if __return___0
        then (Some (true, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_0))
        else (
          rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_indvars_iv_0 + (1)) <>? (512))
          then (
            (Some (
              false  ,
              v_call_0  ,
              (v_indvars_iv_0 + (1))  ,
              v_level_0  ,
              (v_pa_addr_6 + (v_call_0))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (4))))))
            )))
          else (
            (Some (
              true  ,
              v_call_0  ,
              v_indvars_iv_0  ,
              v_level_0  ,
              v_pa_addr_6  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    (((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) #
                      ((v_s2tt_0.(poffset)) + (((8 * (v_indvars_iv_0)) + (0)))) ==
                      (v_pa_addr_6 |' (4))))))
            ))))
      | None => None
      end
    end.

  Definition s2tt_init_assigned_empty_spec (v_s2tt: Ptr) (v_pa: Z) (v_level: Z) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    match ((s2tt_init_assigned_empty_loop700 (z_to_nat 512) false (1 << ((39 + (((- 9) * (v_level)))))) 0 v_level v_pa v_s2tt st)) with
    | (Some (__return__, v_call_0, v_indvars_iv_0, v_level_0, v_pa_addr_6, v_s2tt_0, st_1)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      (Some st_1)
    | None => None
    end.

  Fixpoint s2tt_init_destroyed_loop0 (_N_: nat) (__return__: bool) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_index, v_s2tt, st))
    | (S _N__0) =>
      match ((s2tt_init_destroyed_loop0 _N__0 __return__ v_index v_s2tt st)) with
      | (Some (__return___0, v_index_0, v_s2tt_0, st_0)) =>
        if __return___0
        then (Some (true, v_index_0, v_s2tt_0, st_0))
        else (
          rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_index_0 + (2)) =? (512))
          then (
            (Some (
              true  ,
              v_index_0  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == 8) #
                      ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                      8))))
            )))
          else (
            (Some (
              false  ,
              (v_index_0 + (2))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == 8) #
                      ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                      8))))
            ))))
      | None => None
      end
    end.

  Definition s2tt_init_destroyed_spec (v_s2tt: Ptr) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    match ((s2tt_init_destroyed_loop0 (z_to_nat 256) false 0 v_s2tt st)) with
    | (Some (__return__, v_index_0, v_s2tt_0, st_0)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      (Some st_0)
    | None => None
    end.

  Fixpoint s2tt_init_unassigned_loop0 (_N_: nat) (__return__: bool) (v_call: Z) (v_index: Z) (v_s2tt: Ptr) (st: RData) : (option (bool * Z * Z * Ptr * RData)) :=
    match (_N_) with
    | O => (Some (__return__, v_call, v_index, v_s2tt, st))
    | (S _N__0) =>
      match ((s2tt_init_unassigned_loop0 _N__0 __return__ v_call v_index v_s2tt st)) with
      | (Some (__return___0, v_call_0, v_index_0, v_s2tt_0, st_0)) =>
        if __return___0
        then (Some (true, v_call_0, v_index_0, v_s2tt_0, st_0))
        else (
          rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
          when cid == (((((st_0.(share)).(granules)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(e_lock)));
          if ((v_index_0 + (2)) =? (512))
          then (
            (Some (
              true  ,
              v_call_0  ,
              v_index_0  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == v_call_0) #
                      ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                      v_call_0))))
            )))
          else (
            (Some (
              false  ,
              v_call_0  ,
              (v_index_0 + (2))  ,
              v_s2tt_0  ,
              (st_0.[share].[granule_data] :<
                (((st_0.(share)).(granule_data)) #
                  (((st_0.(share)).(slots)) @ SLOT_DELEGATED) ==
                  ((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).[g_norm] :<
                    ((((((st_0.(share)).(granule_data)) @ (((st_0.(share)).(slots)) @ SLOT_DELEGATED)).(g_norm)) # ((v_s2tt_0.(poffset)) + (((8 * (v_index_0)) + (0)))) == v_call_0) #
                      ((v_s2tt_0.(poffset)) + (((8 * ((v_index_0 + (1)))) + (0)))) ==
                      v_call_0))))
            ))))
      | None => None
      end
    end.

  Definition s2tt_init_unassigned_spec (v_s2tt: Ptr) (v_ripas: Z) (st: RData) : (option RData) :=
    rely (((v_s2tt.(pbase)) = ("slot_delegated")));
    when ret == ((s2tte_create_unassigned_spec' v_ripas));
    match ((s2tt_init_unassigned_loop0 (z_to_nat 256) false ret 0 v_s2tt st)) with
    | (Some (__return__, v_call_0, v_index_0, v_s2tt_0, st_1)) =>
      rely (((v_s2tt_0.(pbase)) = ("slot_delegated")));
      (Some st_1)
    | None => None
    end.

End S2TTInit_Spec.

#[global] Hint Unfold s2tt_init_valid_ns_loop738_rank: spec.
#[global] Hint Unfold s2tt_init_valid_loop719_rank: spec.
#[global] Hint Unfold s2tt_init_assigned_empty_loop700_rank: spec.
#[global] Hint Unfold s2tt_init_destroyed_loop0_rank: spec.
#[global] Hint Unfold s2tt_init_unassigned_loop0_rank: spec.
(* #[global] Hint Unfold realm_ipa_get_ripas_1_low: spec. *)
#[global] Hint Unfold s2tt_init_valid_ns_loop738: spec.
Opaque s2tt_init_valid_ns_spec.
#[global] Hint Unfold s2tt_init_valid_loop719: spec.
Opaque s2tt_init_valid_spec.
#[global] Hint Unfold s2tt_init_assigned_empty_loop700: spec.
Opaque s2tt_init_assigned_empty_spec.
#[global] Hint Unfold s2tt_init_destroyed_loop0: spec.
Opaque s2tt_init_destroyed_spec.
#[global] Hint Unfold s2tt_init_unassigned_loop0: spec.
Opaque s2tt_init_unassigned_spec.
