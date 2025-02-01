Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer4_init: RData.

Section Layer4_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer4_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer4_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer4_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer4_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer4_layer :=
    {|
      State := RData;
      Init := Layer4_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer4_get_reg;
      SetReg := Layer4_set_reg;
      GetFlag := Layer4_get_flag;
      SetFlag := Layer4_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__find_next_level_idx", prim __find_next_level_idx_spec)
          :: ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_try_lock", prim granule_try_lock_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memset", prim memset_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("smc_granule_any_to_ns", prim smc_granule_any_to_ns_spec)
          :: ("smc_granule_ns_to_any", prim smc_granule_ns_to_any_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: nil
    |}.

End Layer4_Layer.
