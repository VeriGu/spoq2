Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
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
          ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("addr_to_idx", prim addr_to_idx_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_from_idx", prim granule_from_idx_spec)
          :: ("granule_get_state", prim granule_get_state_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memset", prim memset_spec)
          :: ("smc_granule_any_to_ns", prim smc_granule_any_to_ns_spec)
          :: ("smc_granule_ns_to_any", prim smc_granule_ns_to_any_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: nil
    |}.

End Layer2_Layer.
