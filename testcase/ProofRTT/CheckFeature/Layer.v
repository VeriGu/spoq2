Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter CheckFeature_init: RData.

Section CheckFeature_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition CheckFeature_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition CheckFeature_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition CheckFeature_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition CheckFeature_get_flag (f: flag) (st: RData) : bool := false.

  Definition CheckFeature_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition CheckFeature_layer :=
    {|
      State := RData;
      Init := CheckFeature_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := CheckFeature_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=CheckFeature_get_reg;
      SetReg := CheckFeature_set_reg;
      GetFlag := CheckFeature_get_flag;
      SetFlag := CheckFeature_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__sca_read64", prim __sca_read64_spec)
          :: ("__sca_read64_acquire", prim __sca_read64_acquire_spec)
          :: ("__sca_write64_release", prim __sca_write64_release_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("access_len", prim access_len_spec)
          :: ("arch_feat_get_pa_width", prim arch_feat_get_pa_width_spec)
          :: ("atomic_add_64", prim atomic_add_64_spec)
          :: ("atomic_load_add_release_64", prim atomic_load_add_release_64_spec)
          :: ("data_granule_measure", prim data_granule_measure_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("is_feat_lpa2_4k_present", prim is_feat_lpa2_4k_present_spec)
          :: ("is_feat_sve_present", prim is_feat_sve_present_spec)
          :: ("is_feat_vmid16_present", prim is_feat_vmid16_present_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memcpy_ns_read", prim memcpy_ns_read_spec)
          :: ("memcpy_ns_write", prim memcpy_ns_write_spec)
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
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("stage2_tlbi_ipa", prim stage2_tlbi_ipa_spec)
          :: ("status_ptr", prim status_ptr_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End CheckFeature_Layer.
