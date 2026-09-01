Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter CheckFeature_init: RData.

Section CheckFeature_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition CheckFeature_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition CheckFeature_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition CheckFeature_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition CheckFeature_get_flag (f: flag) (st: RData) : bool := false.

  Definition CheckFeature_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition CheckFeature_layer :=
    {|
      State := RData;
      Init := CheckFeature_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := CheckFeature_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=CheckFeature_get_reg;
      SetReg := CheckFeature_set_reg;
      GetFlag := CheckFeature_get_flag;
      SetFlag := CheckFeature_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_dec", prim __granule_refcount_dec_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__sca_read64", prim __sca_read64_spec)
          :: ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_is_contained", prim addr_is_contained_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_bit_clear_release_64", prim atomic_bit_clear_release_64_spec)
          :: ("atomic_bit_set_acquire_release_64", prim atomic_bit_set_acquire_release_64_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("complete_host_call", prim complete_host_call_spec)
          :: ("configure_realm_stage2", prim configure_realm_stage2_spec)
          :: ("data_granule_measure", prim data_granule_measure_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("esr_is_write", prim esr_is_write_spec)
          :: ("esr_sas", prim esr_sas_spec)
          :: ("esr_sign_extend", prim esr_sign_extend_spec)
          :: ("esr_sixty_four", prim esr_sixty_four_spec)
          :: ("esr_srt", prim esr_srt_spec)
          :: ("fpu_restore_state", prim fpu_restore_state_spec)
          :: ("fpu_save_state", prim fpu_save_state_spec)
          :: ("gic_restore_state", prim gic_restore_state_spec)
          :: ("gic_save_state", prim gic_save_state_spec)
          :: ("handle_exception_irq_lel", prim handle_exception_irq_lel_spec)
          :: ("handle_exception_serror_lel", prim handle_exception_serror_lel_spec)
          :: ("handle_exception_sync", prim handle_exception_sync_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("inject_sync_idabort_rec", prim inject_sync_idabort_rec_spec)
          :: ("is_feat_vmid16_present", prim is_feat_vmid16_present_spec)
          :: ("is_valid_vintid", prim is_valid_vintid_spec)
          :: ("isb", prim isb_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memcpy", prim memcpy_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memcpy_ns_write", prim memcpy_ns_write_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("mpidr_is_valid", prim mpidr_is_valid_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("plat_granule_addr_to_idx", prim plat_granule_addr_to_idx_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("pmu_restore_state", prim pmu_restore_state_spec)
          :: ("pmu_save_state", prim pmu_save_state_spec)
          :: ("pmu_update_rec_exit", prim pmu_update_rec_exit_spec)
          :: ("ptr_is_err", prim ptr_is_err_spec)
          :: ("ptr_status", prim ptr_status_spec)
          :: ("read_cnthctl_el2", prim read_cnthctl_el2_spec)
          :: ("read_cntp_ctl_el02", prim read_cntp_ctl_el02_spec)
          :: ("read_cntp_cval_el02", prim read_cntp_cval_el02_spec)
          :: ("read_cntpoff_el2", prim read_cntpoff_el2_spec)
          :: ("read_cntv_ctl_el02", prim read_cntv_ctl_el02_spec)
          :: ("read_cntv_cval_el02", prim read_cntv_cval_el02_spec)
          :: ("read_cntvoff_el2", prim read_cntvoff_el2_spec)
          :: ("read_cptr_el2", prim read_cptr_el2_spec)
          :: ("read_elr_el2", prim read_elr_el2_spec)
          :: ("read_esr_el2", prim read_esr_el2_spec)
          :: ("read_far_el2", prim read_far_el2_spec)
          :: ("read_hpfar_el2", prim read_hpfar_el2_spec)
          :: ("read_icc_hppir1_el1", prim read_icc_hppir1_el1_spec)
          :: ("read_icc_sre_el2", prim read_icc_sre_el2_spec)
          :: ("read_mdcr_el2", prim read_mdcr_el2_spec)
          :: ("read_pmcr_el0", prim read_pmcr_el0_spec)
          :: ("read_spsr_el2", prim read_spsr_el2_spec)
          :: ("read_zcr_el2", prim read_zcr_el2_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_params_measure", prim realm_params_measure_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_ipa_size", prim rec_ipa_size_spec)
          :: ("rec_params_measure", prim rec_params_measure_spec)
          :: ("rec_run_loop", prim rec_run_loop_spec)
          :: ("rec_simd_type", prim rec_simd_type_spec)
          :: ("requested_ipa_bits", prim requested_ipa_bits_spec)
          :: ("restore_sysreg_state", prim restore_sysreg_state_spec)
          :: ("ripas_granule_measure", prim ripas_granule_measure_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_inconsistent_sl", prim s2_inconsistent_sl_spec)
          :: ("s2_num_root_rtts", prim s2_num_root_rtts_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("save_sysreg_state", prim save_sysreg_state_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("stage2_tlbi_ipa", prim stage2_tlbi_ipa_spec)
          :: ("status_ptr", prim status_ptr_spec)
          :: ("sve_config_vq", prim sve_config_vq_spec)
          :: ("sve_restore_ffr_p_state", prim sve_restore_ffr_p_state_spec)
          :: ("sve_restore_z_state", prim sve_restore_z_state_spec)
          :: ("sve_restore_zcr_fpu_state", prim sve_restore_zcr_fpu_state_spec)
          :: ("sve_save_p_ffr_state", prim sve_save_p_ffr_state_spec)
          :: ("sve_save_z_state", prim sve_save_z_state_spec)
          :: ("sve_save_zcr_fpu_state", prim sve_save_zcr_fpu_state_spec)
          :: ("table_entry_to_phys", prim table_entry_to_phys_spec)
          :: ("write_cnthctl_el2", prim write_cnthctl_el2_spec)
          :: ("write_cptr_el2", prim write_cptr_el2_spec)
          :: ("write_elr_el2", prim write_elr_el2_spec)
          :: ("write_hcr_el2", prim write_hcr_el2_spec)
          :: ("write_icc_sre_el2", prim write_icc_sre_el2_spec)
          :: ("write_mdcr_el2", prim write_mdcr_el2_spec)
          :: ("write_spsr_el2", prim write_spsr_el2_spec)
          :: ("write_vsesr_el2", prim write_vsesr_el2_spec)
          :: ("write_zcr_el2", prim write_zcr_el2_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End CheckFeature_Layer.
