Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer12.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer8_init: RData.

Section Layer8_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer8_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer8_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer8_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer8_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer8_layer :=
    {|
      State := RData;
      Init := Layer8_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer8_get_reg;
      SetReg := Layer8_set_reg;
      GetFlag := Layer8_get_flag;
      SetFlag := Layer8_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__sca_read64", prim __sca_read64_spec)
          :: ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("access_mask", prim access_mask_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("atomic_granule_put", prim atomic_granule_put_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("data_create", prim data_create_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("data_create_s1_el1", prim data_create_s1_el1_spec)
          :: ("esr_srt", prim esr_srt_spec)
          :: ("esr_sysreg_rt", prim esr_sysreg_rt_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_transition_rtts", prim find_lock_transition_rtts_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("g_refcount", prim g_refcount_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_memzero_mapped", prim granule_memzero_mapped_spec)
          :: ("granule_pa_to_va", prim granule_pa_to_va_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_try_lock", prim granule_try_lock_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_100", prim iasm_100_spec)
          :: ("iasm_101", prim iasm_101_spec)
          :: ("iasm_102", prim iasm_102_spec)
          :: ("iasm_103", prim iasm_103_spec)
          :: ("iasm_104", prim iasm_104_spec)
          :: ("iasm_105", prim iasm_105_spec)
          :: ("iasm_117", prim iasm_117_spec)
          :: ("iasm_118", prim iasm_118_spec)
          :: ("iasm_119", prim iasm_119_spec)
          :: ("iasm_120", prim iasm_120_spec)
          :: ("iasm_121", prim iasm_121_spec)
          :: ("iasm_122", prim iasm_122_spec)
          :: ("iasm_123", prim iasm_123_spec)
          :: ("iasm_124", prim iasm_124_spec)
          :: ("iasm_125", prim iasm_125_spec)
          :: ("iasm_126", prim iasm_126_spec)
          :: ("iasm_127", prim iasm_127_spec)
          :: ("iasm_128", prim iasm_128_spec)
          :: ("iasm_129", prim iasm_129_spec)
          :: ("iasm_12_isb", prim iasm_12_isb_spec)
          :: ("iasm_130", prim iasm_130_spec)
          :: ("iasm_131", prim iasm_131_spec)
          :: ("iasm_132", prim iasm_132_spec)
          :: ("iasm_136", prim iasm_136_spec)
          :: ("iasm_139", prim iasm_139_spec)
          :: ("iasm_145", prim iasm_145_spec)
          :: ("iasm_153", prim iasm_153_spec)
          :: ("iasm_154", prim iasm_154_spec)
          :: ("iasm_162", prim iasm_162_spec)
          :: ("iasm_166", prim iasm_166_spec)
          :: ("iasm_167", prim iasm_167_spec)
          :: ("iasm_168", prim iasm_168_spec)
          :: ("iasm_169", prim iasm_169_spec)
          :: ("iasm_170", prim iasm_170_spec)
          :: ("iasm_172", prim iasm_172_spec)
          :: ("iasm_174", prim iasm_174_spec)
          :: ("iasm_175", prim iasm_175_spec)
          :: ("iasm_182", prim iasm_182_spec)
          :: ("iasm_183", prim iasm_183_spec)
          :: ("iasm_184", prim iasm_184_spec)
          :: ("iasm_185", prim iasm_185_spec)
          :: ("iasm_207", prim iasm_207_spec)
          :: ("iasm_212", prim iasm_212_spec)
          :: ("iasm_213", prim iasm_213_spec)
          :: ("iasm_219", prim iasm_219_spec)
          :: ("iasm_221", prim iasm_221_spec)
          :: ("iasm_224", prim iasm_224_spec)
          :: ("iasm_225", prim iasm_225_spec)
          :: ("iasm_226", prim iasm_226_spec)
          :: ("iasm_227", prim iasm_227_spec)
          :: ("iasm_228", prim iasm_228_spec)
          :: ("iasm_229", prim iasm_229_spec)
          :: ("iasm_230", prim iasm_230_spec)
          :: ("iasm_231", prim iasm_231_spec)
          :: ("iasm_233", prim iasm_233_spec)
          :: ("iasm_234", prim iasm_234_spec)
          :: ("iasm_258", prim iasm_258_spec)
          :: ("iasm_261", prim iasm_261_spec)
          :: ("iasm_264", prim iasm_264_spec)
          :: ("iasm_270", prim iasm_270_spec)
          :: ("iasm_31", prim iasm_31_spec)
          :: ("iasm_33", prim iasm_33_spec)
          :: ("iasm_35", prim iasm_35_spec)
          :: ("iasm_36", prim iasm_36_spec)
          :: ("iasm_37", prim iasm_37_spec)
          :: ("iasm_38", prim iasm_38_spec)
          :: ("iasm_39", prim iasm_39_spec)
          :: ("iasm_6", prim iasm_6_spec)
          :: ("iasm_7", prim iasm_7_spec)
          :: ("iasm_75", prim iasm_75_spec)
          :: ("iasm_76", prim iasm_76_spec)
          :: ("iasm_77", prim iasm_77_spec)
          :: ("iasm_8", prim iasm_8_spec)
          :: ("iasm_81", prim iasm_81_spec)
          :: ("iasm_82", prim iasm_82_spec)
          :: ("iasm_84", prim iasm_84_spec)
          :: ("iasm_88", prim iasm_88_spec)
          :: ("iasm_98", prim iasm_98_spec)
          :: ("iasm_99", prim iasm_99_spec)
          :: ("iasm_get_actlr_el1", prim iasm_get_actlr_el1_spec)
          :: ("iasm_get_cnthctl_el2", prim iasm_get_cnthctl_el2_spec)
          :: ("iasm_get_cntvoff_el2", prim iasm_get_cntvoff_el2_spec)
          :: ("iasm_get_csselr_el1", prim iasm_get_csselr_el1_spec)
          :: ("iasm_get_disr_el1", prim iasm_get_disr_el1_spec)
          :: ("iasm_get_elr_el2", prim iasm_get_elr_el2_spec)
          :: ("iasm_get_mdccint_el1", prim iasm_get_mdccint_el1_spec)
          :: ("iasm_get_mdscr_el1", prim iasm_get_mdscr_el1_spec)
          :: ("iasm_get_par_el1", prim iasm_get_par_el1_spec)
          :: ("iasm_get_pmcr_el0", prim iasm_get_pmcr_el0_spec)
          :: ("iasm_get_pmuserenr_el0", prim iasm_get_pmuserenr_el0_spec)
          :: ("iasm_get_sp_el0", prim iasm_get_sp_el0_spec)
          :: ("iasm_get_sp_el1", prim iasm_get_sp_el1_spec)
          :: ("iasm_get_spsr_el2", prim iasm_get_spsr_el2_spec)
          :: ("iasm_get_tpidr_el0", prim iasm_get_tpidr_el0_spec)
          :: ("iasm_get_tpidr_el1", prim iasm_get_tpidr_el1_spec)
          :: ("iasm_get_tpidrro_el0", prim iasm_get_tpidrro_el0_spec)
          :: ("iasm_get_vttbr_el2", prim iasm_get_vttbr_el2_spec)
          :: ("iasm_set_actlr_el1", prim iasm_set_actlr_el1_spec)
          :: ("iasm_set_cnthctl_el2", prim iasm_set_cnthctl_el2_spec)
          :: ("iasm_set_cntvoff_el2", prim iasm_set_cntvoff_el2_spec)
          :: ("iasm_set_csselr_el1", prim iasm_set_csselr_el1_spec)
          :: ("iasm_set_disr_el1", prim iasm_set_disr_el1_spec)
          :: ("iasm_set_elr_el2", prim iasm_set_elr_el2_spec)
          :: ("iasm_set_hcr_el2", prim iasm_set_hcr_el2_spec)
          :: ("iasm_set_mdccint_el1", prim iasm_set_mdccint_el1_spec)
          :: ("iasm_set_mdscr_el1", prim iasm_set_mdscr_el1_spec)
          :: ("iasm_set_par_el1", prim iasm_set_par_el1_spec)
          :: ("iasm_set_pmcr_el0", prim iasm_set_pmcr_el0_spec)
          :: ("iasm_set_pmuserenr_el0", prim iasm_set_pmuserenr_el0_spec)
          :: ("iasm_set_sp_el0", prim iasm_set_sp_el0_spec)
          :: ("iasm_set_sp_el1", prim iasm_set_sp_el1_spec)
          :: ("iasm_set_spsr_el2", prim iasm_set_spsr_el2_spec)
          :: ("iasm_set_tpidr_el0", prim iasm_set_tpidr_el0_spec)
          :: ("iasm_set_tpidr_el1", prim iasm_set_tpidr_el1_spec)
          :: ("iasm_set_tpidrro_el0", prim iasm_set_tpidrro_el0_spec)
          :: ("iasm_set_vmpidr_el2", prim iasm_set_vmpidr_el2_spec)
          :: ("iasm_set_vttbr_el2", prim iasm_set_vttbr_el2_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_pages_in_block", prim invalidate_pages_in_block_spec)
          :: ("is_addr_in_par", prim is_addr_in_par_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("measurement_start", prim measurement_start_spec)
          :: ("memcpy_ns_write", prim memcpy_ns_write_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
          :: ("ns_buffer_read_byte", prim ns_buffer_read_byte_spec)
          :: ("ns_buffer_unmap", prim ns_buffer_unmap_spec)
          :: ("ns_buffer_write_byte", prim ns_buffer_write_byte_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("pack_struct_return_code", prim pack_struct_return_code_spec)
          :: ("pico_rec_enter", prim pico_rec_enter_spec)
          :: ("ranges_intersect", prim ranges_intersect_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_run_loop", prim rec_run_loop_spec)
          :: ("region_is_contained", prim region_is_contained_spec)
          :: ("rtt_create_internal", prim rtt_create_internal_spec)
          :: ("rtt_create_s1_el1", prim rtt_create_s1_el1_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
          :: ("s1tte_is_valid", prim s1tte_is_valid_spec)
          :: ("s1tte_pa", prim s1tte_pa_spec)
          :: ("s2tt_init_unassigned", prim s2tt_init_unassigned_spec)
          :: ("s2tte_create_assigned", prim s2tte_create_assigned_spec)
          :: ("s2tte_create_table", prim s2tte_create_table_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_get_ripas", prim s2tte_get_ripas_spec)
          :: ("s2tte_is_assigned", prim s2tte_is_assigned_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_is_valid", prim s2tte_is_valid_spec)
          :: ("s2tte_map_size", prim s2tte_map_size_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("stage1_tlbi_all", prim stage1_tlbi_all_spec)
          :: ("table_is_destroyed_block", prim table_is_destroyed_block_spec)
          :: ("table_is_unassigned_block", prim table_is_unassigned_block_spec)
          :: ("table_maps_assigned_block", prim table_maps_assigned_block_spec)
          :: ("table_maps_valid_block", prim table_maps_valid_block_spec)
          :: ("table_maps_valid_ns_block", prim table_maps_valid_ns_block_spec)
          :: ("validate_gic_state", prim validate_gic_state_spec)
          :: ("validate_ns_struct", prim validate_ns_struct_spec)
          :: nil
    |}.

End Layer8_Layer.
