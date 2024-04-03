Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Helpers_init: RData.

Section Helpers_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Helpers_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition Helpers_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Helpers_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Helpers_get_flag (f: flag) (st: RData) : bool := false.

  Definition Helpers_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Helpers_layer :=
    {|
      State := RData;
      Init := Helpers_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := Helpers_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Helpers_get_reg;
      SetReg := Helpers_set_reg;
      GetFlag := Helpers_get_flag;
      SetFlag := Helpers_set_flag;
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
          :: ("advance_pc", prim advance_pc_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("calc_esr_idabort", prim calc_esr_idabort_spec)
          :: ("calc_vector_entry", prim calc_vector_entry_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("esr_is_write", prim esr_is_write_spec)
          :: ("esr_sas", prim esr_sas_spec)
          :: ("esr_sign_extend", prim esr_sign_extend_spec)
          :: ("esr_sixty_four", prim esr_sixty_four_spec)
          :: ("esr_srt", prim esr_srt_spec)
          :: ("fsc_is_external_abort", prim fsc_is_external_abort_spec)
          :: ("get_sysreg_write_value", prim get_sysreg_write_value_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("is_el2_data_abort_gpf", prim is_el2_data_abort_gpf_spec)
          :: ("is_valid_vintid", prim is_valid_vintid_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memset", prim memset_spec)
          :: ("mpidr_is_valid", prim mpidr_is_valid_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("plat_granule_addr_to_idx", prim plat_granule_addr_to_idx_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("psci_reset_rec", prim psci_reset_rec_spec)
          :: ("ptr_is_err", prim ptr_is_err_spec)
          :: ("ptr_status", prim ptr_status_spec)
          :: ("read_id_aa64mmfr0_el1", prim read_id_aa64mmfr0_el1_spec)
          :: ("read_id_aa64mmfr1_el1", prim read_id_aa64mmfr1_el1_spec)
          :: ("read_id_aa64pfr0_el1", prim read_id_aa64pfr0_el1_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_ipa_size", prim rec_ipa_size_spec)
          :: ("rec_is_simd_allowed", prim rec_is_simd_allowed_spec)
          :: ("rec_simd_type", prim rec_simd_type_spec)
          :: ("requested_ipa_bits", prim requested_ipa_bits_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_inconsistent_sl", prim s2_inconsistent_sl_spec)
          :: ("s2_num_root_rtts", prim s2_num_root_rtts_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("save_input_parameters", prim save_input_parameters_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("stage2_tlbi_ipa", prim stage2_tlbi_ipa_spec)
          :: ("status_ptr", prim status_ptr_spec)
          :: ("sve_config_vq", prim sve_config_vq_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End Helpers_Layer.
