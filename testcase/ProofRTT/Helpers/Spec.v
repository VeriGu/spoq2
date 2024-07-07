Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Section Helpers_Spec.

  Context `{int_ptr: IntPtrCast}.

  Definition save_input_parameters_spec (v_rec: Ptr) (st: RData) : (option RData) :=
    (Some st).

  Definition my_cpuid_spec (st: RData) : (option (Z * RData)) :=
    (Some (CPU_ID, st)).

  Definition status_ptr_spec (v_status: Z) (st: RData) : (option (Ptr * RData)) :=
    rely (((v_status >= (0)) /\ ((GRANULES_BASE > (0)))));
    if ((0 - (v_status)) <? (0))
    then (Some ((mkPtr "status" v_status), st))
    else (Some ((mkPtr "null" 0), st)).

  Definition __granule_refcount_dec_spec (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then true
      else (
        match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end))
    then (
      when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) - (512)) <? (0))
      then None
      else (
        if (
          (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
            (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
        then (Some (lens 56 st))
        else (Some (lens 2 st))))
    else None.

  Definition __granule_put_spec (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then true
      else (
        match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end))
    then (
      when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + ((- 1))) <? (0))
      then None
      else (
        if (
          (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
            (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
        then (Some (lens 113 st))
        else (Some (lens 59 st))))
    else None.

  Definition __granule_get_spec (v_g: Ptr) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then true
      else (
        match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end))
    then (
      when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (1)) <? (0))
      then None
      else (
        if (
          (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
            (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
        then (Some (lens 170 st))
        else (Some (lens 116 st))))
    else None.

  Definition pack_return_code_spec (v_status: Z) (v_index: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((((v_index << (32)) + (v_status)) >> (24)) & (4294967040)) |' ((((v_index << (32)) + (v_status)) & (4294967295)))), st)).

  Definition realm_rtt_starting_level_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
    (Some (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_s2_starting_level)), st)).

  Definition realm_ipa_bits_spec (v_rd: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rd.(pbase)) = ("slot_rd")) /\ (((v_rd.(poffset)) = (0)))));
    when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RD)).(e_lock)));
    (Some (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RD)).(g_rd)).(e_rd_s2_ctx)).(e_rls2ctx_ipa_bits)), st)).

  Definition s2_addr_to_idx_spec (v_addr: Z) (v_level: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_addr >> (((((((v_level * (18446744069414584320)) + (12884901888)) >> (32)) * (9)) + (12)) & (4294967295)))) & (511)), st)).

  Definition s2_sl_addr_to_idx_spec (v_addr: Z) (v_start_level: Z) (v_ipa_bits: Z) (st: RData) : (option (Z * RData)) :=
    (Some ((((Z.lxor ((- 1) << (v_ipa_bits)) (- 1)) & (v_addr)) >> ((((3 - (v_start_level)) * (9)) + (12)))), st)).

  Definition entry_is_table_spec (v_entry1: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_entry1 & (3)) =? (3)), st)).

  Definition __tte_read_spec (v_ttep: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
    if ((v_ttep.(pbase)) =s ("slot_rtt"))
    then (
      when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
      (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(g_norm)) @ (v_ttep.(poffset))), st)))
    else (
      when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
      (Some ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) @ (v_ttep.(poffset))), st))).

  Definition __tte_write_spec (v_ttep: Ptr) (v_tte: Z) (st: RData) : (option RData) :=
    rely ((((v_ttep.(pbase)) = ("slot_rtt")) \/ (((v_ttep.(pbase)) = ("slot_rtt2")))));
    if ((v_ttep.(pbase)) =s ("slot_rtt"))
    then (
      when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(e_lock)));
      (Some (st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) #
          (((st.(share)).(slots)) @ SLOT_RTT) ==
          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT)).[g_norm] :<
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT)).(g_norm)) # (v_ttep.(poffset)) == v_tte))))))
    else (
      when cid == (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(e_lock)));
      (Some (st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) #
          (((st.(share)).(slots)) @ SLOT_RTT2) ==
          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).[g_norm] :<
            (((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_RTT2)).(g_norm)) # (v_ttep.(poffset)) == v_tte)))))).

  Definition __granule_refcount_inc_spec (v_g: Ptr) (v_val: Z) (st: RData) : (option RData) :=
    rely ((((v_g.(pbase)) = ("granules")) /\ (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) = (8)))));
    if (
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_RD)) =? (0))
      then true
      else (
        match (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock))) with
        | (Some cid) => true
        | None => false
        end))
    then (
      when cid == (((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_lock)));
      if ((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_refcount)) + (512)) <? (0))
      then None
      else (
        if (
          (((((v_g.(poffset)) + (8)) mod (ST_GRANULE_SIZE)) =? (8)) &&
            (((((((st.(share)).(granules)) @ (((v_g.(poffset)) + (8)) / (ST_GRANULE_SIZE))).(e_state)) - (GRANULE_STATE_REC)) =? (0)))))
        then (Some (lens 284 st))
        else (Some (lens 230 st))))
    else None.

  Definition mpidr_is_valid_spec (v_mpidr: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_mpidr & (18446742978476114160)) =? (0)), st)).

  Definition ptr_status_spec (v_ptr: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_ptr.(pbase)) = ("status")) \/ (((v_ptr.(pbase)) = ("null")))));
    if ((v_ptr.(pbase)) =s ("status"))
    then (Some ((0 - ((MAX_ERR + ((v_ptr.(poffset)))))), st))
    else (Some (0, st)).

  Definition ptr_is_err_spec (v_ptr: Ptr) (st: RData) : (option (bool * RData)) :=
    if ((v_ptr.(pbase)) <>s ("status"))
    then (Some (false, st))
    else (Some (((v_ptr.(poffset)) >? (0)), st)).

  Definition s2_inconsistent_sl_spec (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((((((3 - (v_sl)) * (9)) + (13)) - (v_ipa_bits)) >? (0)) || ((((((3 - (v_sl)) * (9)) + (25)) - (v_ipa_bits)) <? (0)))), st)).

  Definition s2_num_root_rtts_spec' (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (Z * RData)) :=
    if (((48 + (((- 9) * (v_sl)))) - (v_ipa_bits)) <? (0))
    then (Some ((1 << ((v_ipa_bits - ((48 + (((- 9) * (v_sl)))))))), st))
    else (Some (1, st)).

  Definition s2_num_root_rtts_spec (v_ipa_bits: Z) (v_sl: Z) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((s2_num_root_rtts_spec' v_ipa_bits v_sl st));
    (Some (ret, st)).

  Definition requested_ipa_bits_spec' (v_p: Ptr) (st: RData) : (option (Z * RData)) :=
    rely (((v_p.(pbase)) = ("stack_realm_params")));
    if (((v_p.(poffset)) >=? (0)) && (((v_p.(poffset)) <? (256))))
    then (
      if ((v_p.(poffset)) =? (0))
      then (Some ((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_0)).(e_union_anon_7_0)) & (255)), st))
      else (
        if ((v_p.(poffset)) <? (249))
        then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_0)).(e_union_anon_7_1)) @ ((v_p.(poffset)) - (1))) & (255)), st))
        else None))
    else (
      if (((v_p.(poffset)) >=? (256)) && (((v_p.(poffset)) <? (1024))))
      then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_1)).(e_union_anon_0_95_0)) @ ((v_p.(poffset)) - (256))) & (255)), st))
      else (
        if (((v_p.(poffset)) >=? (1024)) && (((v_p.(poffset)) <? (2048))))
        then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_2)).(e_union_anon_1_96_0)) @ ((v_p.(poffset)) - (1024))) & (255)), st))
        else (
          if (((v_p.(poffset)) >=? (2048)) && (((v_p.(poffset)) <? (4096))))
          then (
            if (((v_p.(poffset)) - (2048)) <? (32))
            then (
              if (((v_p.(poffset)) - (2048)) =? (0))
              then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_vmid)) & (255)), st))
              else (
                if (((v_p.(poffset)) - (2048)) =? (8))
                then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_base)) & (255)), st))
                else (
                  if (((v_p.(poffset)) - (2048)) =? (16))
                  then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_level_start)) & (255)), st))
                  else (
                    if (((v_p.(poffset)) - (2048)) =? (24))
                    then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_3)).(e_union_anon_2_98_0)).(e_rtt_num_start)) & (255)), st))
                    else None))))
            else (
              if (((v_p.(poffset)) - (2048)) <? (2017))
              then (Some (((((((st.(stack)).(stack_realm_params)).(e_rmi_realm_params_3)).(e_union_anon_2_98_1)) @ ((- 2049) + ((v_p.(poffset))))) & (255)), st))
              else None))
          else None))).

  Definition requested_ipa_bits_spec (v_p: Ptr) (st: RData) : (option (Z * RData)) :=
    when ret, st' == ((requested_ipa_bits_spec' v_p st));
    (Some (ret, st)).

  Definition addr_is_contained_spec (v_container_base: Z) (v_container_end: Z) (v_address: Z) (st: RData) : (option (bool * RData)) :=
    (Some ((((v_address - (v_container_base)) >=? (0)) && ((((v_container_end + ((- 1))) - (v_address)) >=? (0)))), st)).

  Definition psci_reset_rec_spec (v_rec: Ptr) (v_caller_sctlr_el1: Z) (st: RData) : (option RData) :=
    rely ((((v_rec.(pbase)) = ("slot_rec2")) /\ (((v_rec.(poffset)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_lock))) with
      | (Some cid) => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (0))
      | None => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(e_refcount)) =? (1))
      end)
    then (
      (Some (st.[share].[granule_data] :<
        (((st.(share)).(granule_data)) #
          (((st.(share)).(slots)) @ SLOT_REC2) ==
          ((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).[g_rec] :<
            ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).[e_pstate] :< 965).[e_sysregs] :<
              ((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC2)).(g_rec)).(e_sysregs)).[e_sysreg_sctlr_el1] :<
                ((v_caller_sctlr_el1 & (33554432)) |' (12912760)))))))))
    else None.

  Definition advance_pc_spec (st: RData) : (option RData) :=
    (Some (lens 344 st)).

  Definition calc_vector_entry_spec (v_vbar: Z) (v_spsr: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_spsr & (15)) =? (5))
    then (Some ((512 + (v_vbar)), st))
    else (
      if ((v_spsr & (15)) =? (4))
      then (Some (v_vbar, st))
      else (
        if ((v_spsr & (15)) =? (0))
        then (
          if ((v_spsr & (16)) =? (0))
          then (Some ((1024 + (v_vbar)), st))
          else (Some ((1536 + (v_vbar)), st)))
        else (Some (v_vbar, st)))).

  Definition rec_is_simd_allowed_spec (v_rec: Ptr) (st: RData) : (option (bool * RData)) :=
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)));
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)));
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    (Some ((((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_aux_data)).(e_rec_simd)).(e_simd_allowed)) & (1)) <>? (0)), st)).

  Definition rec_simd_type_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) = (1)));
    rely ((((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock)) = (None)));
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    if ((((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_sve_enabled)) & (1)) =? (0))
    then (Some (1, st))
    else (Some (2, st)).

  Definition esr_is_write_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_esr & (64)) <>? (0)), st)).

  Definition rec_ipa_size_spec (v_rec: Ptr) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    if (
      match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
      | (Some cid) => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
      | None => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
      end)
    then (Some ((1 << (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_realm_info)).(e_ipa_bits)))), st))
    else None.

  Definition esr_sas_spec (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_esr >> (22)) & (3)), st)).

  Definition esr_srt_spec (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    (Some (((v_esr >> (16)) & (31)), st)).

  Definition fsc_is_external_abort_spec (v_fsc: Z) (st: RData) : (option (bool * RData)) :=
    if (v_fsc =? (16))
    then (Some (true, st))
    else (
      if ((v_fsc + ((- 19))) <? (5))
      then (Some (true, st))
      else (Some (false, st))).

  Definition calc_esr_idabort_spec (v_esr_el2: Z) (v_spsr_el2: Z) (v_fsc: Z) (st: RData) : (option (Z * RData)) :=
    if ((v_spsr_el2 & (15)) =? (0))
    then (Some (((((v_esr_el2 & (18446744069481691456)) |' (512)) |' (v_fsc)) |' ((v_esr_el2 & (4227858432)))), st))
    else (Some (((((v_esr_el2 & (18446744069481691456)) |' (512)) |' (v_fsc)) |' (((v_esr_el2 & (4227858432)) + (67108864)))), st)).

  Definition get_sysreg_write_value_spec (v_rec: Ptr) (v_esr: Z) (st: RData) : (option (Z * RData)) :=
    rely ((((v_rec.(pbase)) = ("slot_rec")) /\ (((v_rec.(poffset)) = (0)))));
    if (((v_esr >> (5)) & (31)) =? (31))
    then (Some (0, st))
    else (
      rely ((((0 - (((v_esr >> (5)) & (31)))) <= (0)) /\ ((((v_esr >> (5)) & (31)) < (31)))));
      if (
        match (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_lock))) with
        | (Some cid) => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (0))
        | None => (((((st.(share)).(granules)) @ (((st.(share)).(slots)) @ SLOT_REC)).(e_refcount)) =? (1))
        end)
      then (Some (((((((st.(share)).(granule_data)) @ (((st.(share)).(slots)) @ SLOT_REC)).(g_rec)).(e_regs)) @ ((v_esr >> (5)) & (31))), st))
      else None).

  Definition is_valid_vintid_spec (v_intid: Z) (st: RData) : (option (bool * RData)) :=
    if (v_intid <? (1020))
    then (Some (true, st))
    else (
      if (v_intid >? (8191))
      then (
        if ((gic_virt_feature_3 - (v_intid)) <? (0))
        then (
          if ((gic_virt_feature_4 & (1)) =? (0))
          then (Some (false, st))
          else (Some (((v_intid & (18446744073709550592)) =? (4096)), st)))
        else (Some (true, st)))
      else (
        if ((gic_virt_feature_4 & (1)) =? (0))
        then (Some (false, st))
        else (Some (((v_intid & (18446744073709550592)) =? (4096)), st)))).

  Definition esr_sign_extend_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_esr & (2097152)) <>? (0)), st)).

  Definition esr_sixty_four_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
    (Some (((v_esr & (32768)) <>? (0)), st)).

  Definition is_el2_data_abort_gpf_spec (v_esr: Z) (st: RData) : (option (bool * RData)) :=
    if ((v_esr & (4227858432)) =? (2483027968))
    then (
      if ((v_esr & (63)) =? (40))
      then (Some (true, st))
      else (Some (false, st)))
    else (Some (false, st)).

  Definition sve_config_vq_spec (v_vq: Z) (st: RData) : (option RData) :=
    if ((((((st.(priv)).(pcpu_regs)).(pcpu_zcr_el2)) & (15)) - (v_vq)) =? (0))
    then (Some st)
    else (Some (lens 345 st)).

End Helpers_Spec.

Opaque requested_ipa_bits_spec'.
Opaque s2_num_root_rtts_spec'.
#[global] Hint Unfold save_input_parameters_spec: spec.
#[global] Hint Unfold my_cpuid_spec: spec.
#[global] Hint Unfold status_ptr_spec: spec.
#[global] Hint Unfold __granule_refcount_dec_spec: spec.
#[global] Hint Unfold __granule_put_spec: spec.
#[global] Hint Unfold __granule_get_spec: spec.
#[global] Hint Unfold pack_return_code_spec: spec.
#[global] Hint Unfold realm_rtt_starting_level_spec: spec.
#[global] Hint Unfold realm_ipa_bits_spec: spec.
#[global] Hint Unfold s2_addr_to_idx_spec: spec.
#[global] Hint Unfold s2_sl_addr_to_idx_spec: spec.
#[global] Hint Unfold entry_is_table_spec: spec.
#[global] Hint Unfold __tte_read_spec: spec.
#[global] Hint Unfold __tte_write_spec: spec.
#[global] Hint Unfold __granule_refcount_inc_spec: spec.
#[global] Hint Unfold mpidr_is_valid_spec: spec.
#[global] Hint Unfold ptr_status_spec: spec.
#[global] Hint Unfold ptr_is_err_spec: spec.
#[global] Hint Unfold s2_inconsistent_sl_spec: spec.
#[global] Hint Unfold s2_num_root_rtts_spec: spec.
#[global] Hint Unfold requested_ipa_bits_spec: spec.
#[global] Hint Unfold addr_is_contained_spec: spec.
#[global] Hint Unfold psci_reset_rec_spec: spec.
#[global] Hint Unfold advance_pc_spec: spec.
#[global] Hint Unfold calc_vector_entry_spec: spec.
#[global] Hint Unfold rec_is_simd_allowed_spec: spec.
#[global] Hint Unfold rec_simd_type_spec: spec.
#[global] Hint Unfold esr_is_write_spec: spec.
#[global] Hint Unfold rec_ipa_size_spec: spec.
#[global] Hint Unfold esr_sas_spec: spec.
#[global] Hint Unfold esr_srt_spec: spec.
#[global] Hint Unfold fsc_is_external_abort_spec: spec.
#[global] Hint Unfold calc_esr_idabort_spec: spec.
#[global] Hint Unfold get_sysreg_write_value_spec: spec.
#[global] Hint Unfold is_valid_vintid_spec: spec.
#[global] Hint Unfold esr_sign_extend_spec: spec.
#[global] Hint Unfold esr_sixty_four_spec: spec.
#[global] Hint Unfold is_el2_data_abort_gpf_spec: spec.
#[global] Hint Unfold sve_config_vq_spec: spec.
