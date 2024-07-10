Require Import .
Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import InitRec.Spec.
Require Import LockGranules.Spec.
Require Import MemRW.Spec.
Require Import Mmap.Spec.
Require Import RecInfo.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter InitRec_init: RData.

Section InitRec_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition InitRec_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition InitRec_alloca (fname: string) (size: Z) (align: Z) (st: RData) : option (Ptr * RData) := None.

  Definition InitRec_free (fname: string) (init_st: RData) (st: RData) : option RData := None.

  Definition InitRec_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition InitRec_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition InitRec_get_flag (f: flag) (st: RData) : bool := false.

  Definition InitRec_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition InitRec_layer :=
    {|
      State := RData;
      Init := InitRec_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := InitRec_newframe;
      Alloca := InitRec_alloca;
      Free := InitRec_free;
      GetReg :=InitRec_get_reg;
      SetReg := InitRec_set_reg;
      GetFlag := InitRec_get_flag;
      SetFlag := InitRec_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__find_next_level_idx", prim __find_next_level_idx_spec)
          :: ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_dec", prim __granule_refcount_dec_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_is_contained", prim addr_is_contained_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("arch_feat_get_pa_width", prim arch_feat_get_pa_width_spec)
          :: ("atomic_bit_clear_release_64", prim atomic_bit_clear_release_64_spec)
          :: ("atomic_bit_set_acquire_release_64", prim atomic_bit_set_acquire_release_64_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("atomic_granule_put", prim atomic_granule_put_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("data_granule_measure", prim data_granule_measure_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_rd_granules", prim find_lock_rd_granules_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("find_lock_unused_granule", prim find_lock_unused_granule_spec)
          :: ("free_rec_aux_granules", prim free_rec_aux_granules_spec)
          :: ("get_rd_rec_count_locked", prim get_rd_rec_count_locked_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_memzero", prim granule_memzero_spec)
          :: ("granule_memzero_mapped", prim granule_memzero_mapped_spec)
          :: ("granule_refcount_read_acquire", prim granule_refcount_read_acquire_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("host_ns_s2tte_is_valid", prim host_ns_s2tte_is_valid_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_page", prim invalidate_page_spec)
          :: ("invalidate_pages_in_block", prim invalidate_pages_in_block_spec)
          :: ("is_feat_lpa2_4k_present", prim is_feat_lpa2_4k_present_spec)
          :: ("is_feat_sve_present", prim is_feat_sve_present_spec)
          :: ("is_feat_vmid16_present", prim is_feat_vmid16_present_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("max_ipa_size", prim max_ipa_size_spec)
          :: ("memcpy", prim memcpy_spec)
          :: ("memset", prim memset_spec)
          :: ("mpidr_is_valid", prim mpidr_is_valid_spec)
          :: ("mpidr_to_rec_idx", prim mpidr_to_rec_idx_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("ptr_is_err", prim ptr_is_err_spec)
          :: ("ptr_status", prim ptr_status_spec)
          :: ("read_pmcr_el0", prim read_pmcr_el0_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_ipa_size", prim realm_ipa_size_spec)
          :: ("realm_par_size", prim realm_par_size_spec)
          :: ("realm_params_measure", prim realm_params_measure_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_params_measure", prim rec_params_measure_spec)
          :: ("requested_ipa_bits", prim requested_ipa_bits_spec)
          :: ("ripas_granule_measure", prim ripas_granule_measure_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_inconsistent_sl", prim s2_inconsistent_sl_spec)
          :: ("s2_num_root_rtts", prim s2_num_root_rtts_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("s2tte_create_assigned_empty", prim s2tte_create_assigned_empty_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_is_assigned", prim s2tte_is_assigned_spec)
          :: ("s2tte_is_destroyed", prim s2tte_is_destroyed_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_is_valid", prim s2tte_is_valid_spec)
          :: ("s2tte_is_valid_ns", prim s2tte_is_valid_ns_spec)
          :: ("s2tte_map_size", prim s2tte_map_size_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("s2tte_pa_table", prim s2tte_pa_table_spec)
          :: ("set_rd_rec_count", prim set_rd_rec_count_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("simd_sve_get_max_vq", prim simd_sve_get_max_vq_spec)
          :: ("update_ripas", prim update_ripas_spec)
          :: nil
    |}.

End InitRec_Layer.
