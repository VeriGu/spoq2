Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.
Require Import RDState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter GranuleInfo_init: RData.

Section GranuleInfo_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition GranuleInfo_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition GranuleInfo_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition GranuleInfo_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition GranuleInfo_get_flag (f: flag) (st: RData) : bool := false.

  Definition GranuleInfo_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition GranuleInfo_layer :=
    {|
      State := RData;
      Init := GranuleInfo_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := GranuleInfo_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=GranuleInfo_get_reg;
      SetReg := GranuleInfo_set_reg;
      GetFlag := GranuleInfo_get_flag;
      SetFlag := GranuleInfo_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_to_granule", prim addr_to_granule_spec)
          :: ("arch_feat_get_pa_width", prim arch_feat_get_pa_width_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_granules", prim find_lock_granules_spec)
          :: ("get_cached_llt_info", prim get_cached_llt_info_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_refcount_read_acquire", prim granule_refcount_read_acquire_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("is_feat_vmid16_present", prim is_feat_vmid16_present_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memset", prim memset_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_ipa_size", prim rec_ipa_size_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("slot_to_va", prim slot_to_va_spec)
          :: ("stage2_tlbi_ipa", prim stage2_tlbi_ipa_spec)
          :: ("status_ptr", prim status_ptr_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End GranuleInfo_Layer.
