Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
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
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("addr_level_mask", prim addr_level_mask_spec)
          :: ("atomic_granule_get", prim atomic_granule_get_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_pa_to_va", prim granule_pa_to_va_spec)
          :: ("granule_try_lock", prim granule_try_lock_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("masked_assign", prim masked_assign_spec)
          :: ("max_pa_size", prim max_pa_size_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read_byte", prim ns_buffer_read_byte_spec)
          :: ("ns_buffer_write_byte", prim ns_buffer_write_byte_spec)
          :: ("pack_struct_return_code", prim pack_struct_return_code_spec)
          :: ("realm_ipa_size", prim realm_ipa_size_spec)
          :: ("s1addr_is_level_aligned", prim s1addr_is_level_aligned_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("set_tte_ns", prim set_tte_ns_spec)
          :: ("slot_to_va", prim slot_to_va_spec)
          :: ("write_ap0r", prim write_ap0r_spec)
          :: ("write_ap1r", prim write_ap1r_spec)
          :: ("write_lr", prim write_lr_spec)
          :: nil
    |}.

End Layer5_Layer.
