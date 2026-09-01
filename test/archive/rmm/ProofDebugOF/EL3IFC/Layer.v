Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import EL3IFC.Spec.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.
Require Import InitRec.Spec.
Require Import LockGranules.Spec.
Require Import MemRW.Spec.
Require Import Mmap.Spec.
Require Import RDState.Spec.
Require Import RealmParams.Spec.
Require Import RecInfo.Spec.
Require Import ValidateAddr.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter EL3IFC_init: RData.

Section EL3IFC_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition EL3IFC_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition EL3IFC_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition EL3IFC_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition EL3IFC_get_flag (f: flag) (st: RData) : bool := false.

  Definition EL3IFC_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition EL3IFC_layer :=
    {|
      State := RData;
      Init := EL3IFC_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := EL3IFC_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=EL3IFC_get_reg;
      SetReg := EL3IFC_set_reg;
      GetFlag := EL3IFC_get_flag;
      SetFlag := EL3IFC_set_flag;
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
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("access_len", prim access_len_spec)
          :: ("access_mask", prim access_mask_spec)
          :: ("addr_in_par", prim addr_in_par_spec)
          :: ("addr_in_rec_par", prim addr_in_rec_par_spec)
          :: ("addr_is_contained", prim addr_is_contained_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("atomic_granule_put", prim atomic_granule_put_spec)
          :: ("atomic_granule_put_release", prim atomic_granule_put_release_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("complete_host_call", prim complete_host_call_spec)
          :: ("configure_realm_stage2", prim configure_realm_stage2_spec)
          :: ("data_granule_measure", prim data_granule_measure_spec)
          :: ("esr_is_write", prim esr_is_write_spec)
          :: ("esr_sign_extend", prim esr_sign_extend_spec)
          :: ("esr_sixty_four", prim esr_sixty_four_spec)
          :: ("esr_srt", prim esr_srt_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_rd_granules", prim find_lock_rd_granules_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("find_lock_unused_granule", prim find_lock_unused_granule_spec)
          :: ("free_rec_aux_granules", prim free_rec_aux_granules_spec)
          :: ("free_sl_rtts", prim free_sl_rtts_spec)
          :: ("get_rd_rec_count_locked", prim get_rd_rec_count_locked_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("get_rd_state_unlocked", prim get_rd_state_unlocked_spec)
          :: ("get_realm_params", prim get_realm_params_spec)
          :: ("gic_cpu_state_init", prim gic_cpu_state_init_spec)
          :: ("gic_restore_state", prim gic_restore_state_spec)
          :: ("gic_save_state", prim gic_save_state_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_memzero", prim granule_memzero_spec)
          :: ("granule_memzero_mapped", prim granule_memzero_mapped_spec)
          :: ("granule_refcount_read_acquire", prim granule_refcount_read_acquire_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("handle_exception_irq_lel", prim handle_exception_irq_lel_spec)
          :: ("handle_exception_serror_lel", prim handle_exception_serror_lel_spec)
          :: ("handle_exception_sync", prim handle_exception_sync_spec)
          :: ("host_ns_s2tte", prim host_ns_s2tte_spec)
          :: ("host_ns_s2tte_is_valid", prim host_ns_s2tte_is_valid_spec)
          :: ("init_rec_regs", prim init_rec_regs_spec)
          :: ("inject_sync_idabort_rec", prim inject_sync_idabort_rec_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_page", prim invalidate_page_spec)
          :: ("invalidate_pages_in_block", prim invalidate_pages_in_block_spec)
          :: ("is_valid_vintid", prim is_valid_vintid_spec)
          :: ("isb", prim isb_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("map_unmap_ns", prim map_unmap_ns_spec)
          :: ("memcpy", prim memcpy_spec)
          :: ("memset", prim memset_spec)
          :: ("mpidr_is_valid", prim mpidr_is_valid_spec)
          :: ("mpidr_to_rec_idx", prim mpidr_to_rec_idx_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
          :: ("ns_buffer_write", prim ns_buffer_write_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
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
          :: ("read_elr_el2", prim read_elr_el2_spec)
          :: ("read_esr_el2", prim read_esr_el2_spec)
          :: ("read_far_el2", prim read_far_el2_spec)
          :: ("read_hpfar_el2", prim read_hpfar_el2_spec)
          :: ("read_icc_hppir1_el1", prim read_icc_hppir1_el1_spec)
          :: ("read_icc_sre_el2", prim read_icc_sre_el2_spec)
          :: ("read_spsr_el2", prim read_spsr_el2_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_params_measure", prim realm_params_measure_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_params_measure", prim rec_params_measure_spec)
          :: ("rec_run_loop", prim rec_run_loop_spec)
          :: ("rec_simd_type", prim rec_simd_type_spec)
          :: ("requested_ipa_bits", prim requested_ipa_bits_spec)
          :: ("restore_sysreg_state", prim restore_sysreg_state_spec)
          :: ("ripas_granule_measure", prim ripas_granule_measure_spec)
          :: ("rmm_el3_ifc_gtsi_delegate", prim rmm_el3_ifc_gtsi_delegate_spec)
          :: ("rmm_el3_ifc_gtsi_undelegate", prim rmm_el3_ifc_gtsi_undelegate_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
          :: ("s2tt_init_assigned_empty", prim s2tt_init_assigned_empty_spec)
          :: ("s2tt_init_destroyed", prim s2tt_init_destroyed_spec)
          :: ("s2tt_init_unassigned", prim s2tt_init_unassigned_spec)
          :: ("s2tt_init_valid", prim s2tt_init_valid_spec)
          :: ("s2tt_init_valid_ns", prim s2tt_init_valid_ns_spec)
          :: ("s2tte_create_assigned_empty", prim s2tte_create_assigned_empty_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("s2tte_create_table", prim s2tte_create_table_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_create_valid", prim s2tte_create_valid_spec)
          :: ("s2tte_create_valid_ns", prim s2tte_create_valid_ns_spec)
          :: ("s2tte_get_ripas", prim s2tte_get_ripas_spec)
          :: ("s2tte_is_assigned", prim s2tte_is_assigned_spec)
          :: ("s2tte_is_destroyed", prim s2tte_is_destroyed_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_is_valid", prim s2tte_is_valid_spec)
          :: ("s2tte_is_valid_ns", prim s2tte_is_valid_ns_spec)
          :: ("s2tte_map_size", prim s2tte_map_size_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("s2tte_pa_table", prim s2tte_pa_table_spec)
          :: ("save_sysreg_state", prim save_sysreg_state_spec)
          :: ("set_rd_rec_count", prim set_rd_rec_count_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("simd_disable", prim simd_disable_spec)
          :: ("simd_enable", prim simd_enable_spec)
          :: ("simd_restore_state", prim simd_restore_state_spec)
          :: ("simd_save_state", prim simd_save_state_spec)
          :: ("simd_state_init", prim simd_state_init_spec)
          :: ("table_is_destroyed_block", prim table_is_destroyed_block_spec)
          :: ("table_is_unassigned_block", prim table_is_unassigned_block_spec)
          :: ("table_maps_assigned_block", prim table_maps_assigned_block_spec)
          :: ("table_maps_valid_block", prim table_maps_valid_block_spec)
          :: ("table_maps_valid_ns_block", prim table_maps_valid_ns_block_spec)
          :: ("total_root_rtt_refcount", prim total_root_rtt_refcount_spec)
          :: ("update_ripas", prim update_ripas_spec)
          :: ("validate_data_create", prim validate_data_create_spec)
          :: ("validate_data_create_unknown", prim validate_data_create_unknown_spec)
          :: ("validate_map_addr", prim validate_map_addr_spec)
          :: ("validate_realm_params", prim validate_realm_params_spec)
          :: ("validate_rtt_entry_cmds", prim validate_rtt_entry_cmds_spec)
          :: ("validate_rtt_structure_cmds", prim validate_rtt_structure_cmds_spec)
          :: ("vmid_free", prim vmid_free_spec)
          :: ("write_cnthctl_el2", prim write_cnthctl_el2_spec)
          :: ("write_elr_el2", prim write_elr_el2_spec)
          :: ("write_hcr_el2", prim write_hcr_el2_spec)
          :: ("write_icc_sre_el2", prim write_icc_sre_el2_spec)
          :: ("write_mdcr_el2", prim write_mdcr_el2_spec)
          :: ("write_spsr_el2", prim write_spsr_el2_spec)
          :: ("write_vsesr_el2", prim write_vsesr_el2_spec)
          :: ("write_zcr_el2", prim write_zcr_el2_spec)
          :: nil
    |}.

End EL3IFC_Layer.
