Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer5_init: RData.

Section Layer5_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer5_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer5_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer5_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer5_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer5_layer :=
    {|
      State := RData;
      Init := Layer5_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer5_get_reg;
      SetReg := Layer5_set_reg;
      GetFlag := Layer5_get_flag;
      SetFlag := Layer5_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__find_lock_next_level", prim __find_lock_next_level_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memset", prim memset_spec)
          :: ("pack_struct_return_code", prim pack_struct_return_code_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("smc_granule_any_to_ns", prim smc_granule_any_to_ns_spec)
          :: ("smc_granule_ns_to_any", prim smc_granule_ns_to_any_spec)
          :: nil
    |}.

End Layer5_Layer.
