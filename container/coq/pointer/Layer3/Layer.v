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

Parameter Layer3_init: RData.

Section Layer3_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer3_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer3_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer3_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer3_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer3_layer :=
    {|
      State := RData;
      Init := Layer3_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer3_get_reg;
      SetReg := Layer3_set_reg;
      GetFlag := Layer3_get_flag;
      SetFlag := Layer3_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__table_get_entry", prim __table_get_entry_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("addr_to_granule", prim addr_to_granule_spec)
          :: ("addr_to_idx", prim addr_to_idx_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_from_idx", prim granule_from_idx_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_try_lock", prim granule_try_lock_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("masked_assign", prim masked_assign_spec)
          :: ("max_pa_size", prim max_pa_size_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read_byte", prim ns_buffer_read_byte_spec)
          :: ("ns_buffer_write_byte", prim ns_buffer_write_byte_spec)
          :: ("realm_ipa_size", prim realm_ipa_size_spec)
          :: ("s1addr_is_level_aligned", prim s1addr_is_level_aligned_spec)
          :: ("set_tte_ns", prim set_tte_ns_spec)
          :: ("smc_granule_any_to_ns", prim smc_granule_any_to_ns_spec)
          :: ("smc_granule_ns_to_any", prim smc_granule_ns_to_any_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("table_entry_to_phys", prim table_entry_to_phys_spec)
          :: ("write_ap0r", prim write_ap0r_spec)
          :: ("write_ap1r", prim write_ap1r_spec)
          :: ("write_lr", prim write_lr_spec)
          :: nil
    |}.

End Layer3_Layer.
