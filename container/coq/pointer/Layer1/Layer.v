Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer3.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer1_init: RData.

Section Layer1_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer1_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer1_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer1_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer1_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer1_layer :=
    {|
      State := RData;
      Init := Layer1_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer1_get_reg;
      SetReg := Layer1_set_reg;
      GetFlag := Layer1_get_flag;
      SetFlag := Layer1_set_flag;
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
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("buffer_map", prim buffer_map_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_addr", prim granule_addr_spec)
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

End Layer1_Layer.
