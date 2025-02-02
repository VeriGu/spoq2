Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer9_init: RData.

Section Layer9_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer9_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer9_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer9_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer9_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer9_layer :=
    {|
      State := RData;
      Init := Layer9_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer9_get_reg;
      SetReg := Layer9_set_reg;
      GetFlag := Layer9_get_flag;
      SetFlag := Layer9_set_flag;
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
          :: ("access_len", prim access_len_spec)
          :: ("access_mask", prim access_mask_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("atomic_granule_put", prim atomic_granule_put_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("data_create_s1_el1", prim data_create_s1_el1_spec)
          :: ("esr_is_write", prim esr_is_write_spec)
          :: ("esr_srt", prim esr_srt_spec)
          :: ("esr_sysreg_rt", prim esr_sysreg_rt_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("g_refcount", prim g_refcount_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_memzero", prim granule_memzero_spec)
          :: ("granule_memzero_mapped", prim granule_memzero_mapped_spec)
          :: ("granule_pa_to_va", prim granule_pa_to_va_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_pages_in_block", prim invalidate_pages_in_block_spec)
          :: ("is_addr_in_par", prim is_addr_in_par_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("map_unmap_ns_s1", prim map_unmap_ns_s1_spec)
          :: ("max_pa_size", prim max_pa_size_spec)
          :: ("memcpy_ns_write", prim memcpy_ns_write_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
          :: ("ns_buffer_unmap", prim ns_buffer_unmap_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("pack_struct_return_code", prim pack_struct_return_code_spec)
          :: ("pico_rec_enter", prim pico_rec_enter_spec)
          :: ("ranges_intersect", prim ranges_intersect_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_run_loop", prim rec_run_loop_spec)
          :: ("region_is_contained", prim region_is_contained_spec)
          :: ("rsi_data_destroy", prim rsi_data_destroy_spec)
          :: ("rsi_rtt_destroy", prim rsi_rtt_destroy_spec)
          :: ("rtt_create_s1_el1", prim rtt_create_s1_el1_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
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
          :: ("table_is_destroyed_block", prim table_is_destroyed_block_spec)
          :: ("table_is_unassigned_block", prim table_is_unassigned_block_spec)
          :: ("table_maps_assigned_block", prim table_maps_assigned_block_spec)
          :: ("table_maps_valid_block", prim table_maps_valid_block_spec)
          :: ("table_maps_valid_ns_block", prim table_maps_valid_ns_block_spec)
          :: ("validate_gic_state", prim validate_gic_state_spec)
          :: ("validate_ns_struct", prim validate_ns_struct_spec)
          :: nil
    |}.

End Layer9_Layer.
