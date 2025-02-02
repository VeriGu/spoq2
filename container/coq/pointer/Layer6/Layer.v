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

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer6_init: RData.

Section Layer6_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer6_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer6_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer6_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer6_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer6_layer :=
    {|
      State := RData;
      Init := Layer6_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer6_get_reg;
      SetReg := Layer6_set_reg;
      GetFlag := Layer6_get_flag;
      SetFlag := Layer6_set_flag;
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
          :: ("addr_is_contained", prim addr_is_contained_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("atomic_granule_put", prim atomic_granule_put_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("esr_is_write", prim esr_is_write_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("g_mapped_addr_set", prim g_mapped_addr_set_spec)
          :: ("g_refcount", prim g_refcount_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_pa_to_va", prim granule_pa_to_va_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_try_lock", prim granule_try_lock_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_pages_in_block", prim invalidate_pages_in_block_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("masked_assign", prim masked_assign_spec)
          :: ("max_pa_size", prim max_pa_size_spec)
          :: ("memcpy_ns_write", prim memcpy_ns_write_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
          :: ("ns_buffer_read_byte", prim ns_buffer_read_byte_spec)
          :: ("ns_buffer_unmap", prim ns_buffer_unmap_spec)
          :: ("ns_buffer_write_byte", prim ns_buffer_write_byte_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("pack_struct_return_code", prim pack_struct_return_code_spec)
          :: ("pico_rec_enter", prim pico_rec_enter_spec)
          :: ("realm_ipa_size", prim realm_ipa_size_spec)
          :: ("rec_run_loop", prim rec_run_loop_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
          :: ("s1addr_is_level_aligned", prim s1addr_is_level_aligned_spec)
          :: ("s1tte_create_valid", prim s1tte_create_valid_spec)
          :: ("s1tte_pa", prim s1tte_pa_spec)
          :: ("s2tt_init_unassigned", prim s2tt_init_unassigned_spec)
          :: ("s2tte_create_assigned", prim s2tte_create_assigned_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("s2tte_create_table", prim s2tte_create_table_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_get_ripas", prim s2tte_get_ripas_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("set_pas_any_to_ns", prim set_pas_any_to_ns_spec)
          :: ("set_pas_ns_to_any", prim set_pas_ns_to_any_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("set_tte_ns", prim set_tte_ns_spec)
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
          :: ("write_ap0r", prim write_ap0r_spec)
          :: ("write_ap1r", prim write_ap1r_spec)
          :: ("write_lr", prim write_lr_spec)
          :: nil
    |}.

End Layer6_Layer.
