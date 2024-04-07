Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import RDState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter RDState_init: RData.

Section RDState_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition RDState_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition RDState_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition RDState_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition RDState_get_flag (f: flag) (st: RData) : bool := false.

  Definition RDState_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition RDState_layer :=
    {|
      State := RData;
      Init := RDState_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := RDState_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=RDState_get_reg;
      SetReg := RDState_set_reg;
      GetFlag := RDState_get_flag;
      SetFlag := RDState_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("arch_feat_get_pa_width", prim arch_feat_get_pa_width_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("get_rd_rec_count_locked", prim get_rd_rec_count_locked_spec)
          :: ("get_rd_rec_count_unlocked", prim get_rd_rec_count_unlocked_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("get_rd_state_unlocked", prim get_rd_state_unlocked_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("is_feat_vmid16_present", prim is_feat_vmid16_present_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memset", prim memset_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("plat_granule_addr_to_idx", prim plat_granule_addr_to_idx_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_ipa_size", prim rec_ipa_size_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("set_rd_rec_count", prim set_rd_rec_count_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("stage2_tlbi_ipa", prim stage2_tlbi_ipa_spec)
          :: ("status_ptr", prim status_ptr_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End RDState_Layer.
