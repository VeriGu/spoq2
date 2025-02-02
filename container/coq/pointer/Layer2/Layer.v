Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer2_init: RData.

Section Layer2_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer2_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer2_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer2_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer2_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer2_layer :=
    {|
      State := RData;
      Init := Layer2_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer2_get_reg;
      SetReg := Layer2_set_reg;
      GetFlag := Layer2_get_flag;
      SetFlag := Layer2_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__sca_read64", prim __sca_read64_spec)
          :: ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("access_len", prim access_len_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("addr_to_idx", prim addr_to_idx_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("esr_is_write", prim esr_is_write_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_from_idx", prim granule_from_idx_spec)
          :: ("granule_get_state", prim granule_get_state_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_pages_in_block", prim invalidate_pages_in_block_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("masked_assign", prim masked_assign_spec)
          :: ("max_pa_size", prim max_pa_size_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memcpy_ns_write", prim memcpy_ns_write_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read_byte", prim ns_buffer_read_byte_spec)
          :: ("ns_buffer_write_byte", prim ns_buffer_write_byte_spec)
          :: ("pico_rec_enter", prim pico_rec_enter_spec)
          :: ("realm_ipa_size", prim realm_ipa_size_spec)
          :: ("rec_run_loop", prim rec_run_loop_spec)
          :: ("s1addr_is_level_aligned", prim s1addr_is_level_aligned_spec)
          :: ("set_tte_ns", prim set_tte_ns_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
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

End Layer2_Layer.
