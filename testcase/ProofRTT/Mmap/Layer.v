Require Import Bottom.Spec.
Require Import CheckFeature.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.
Require Import LockGranules.Spec.
Require Import Mmap.Spec.
Require Import RDState.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Mmap_init: RData.

Section Mmap_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Mmap_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition Mmap_alloca (fname: string) (size: Z) (align: Z) (st: RData) : option (Ptr * RData) := None.

  Definition Mmap_free (fname: string) (init_st: RData) (st: RData) : option RData := None.

  Definition Mmap_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Mmap_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Mmap_get_flag (f: flag) (st: RData) : bool := false.

  Definition Mmap_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Mmap_layer :=
    {|
      State := RData;
      Init := Mmap_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := Mmap_newframe;
      Alloca := Mmap_alloca;
      Free := Mmap_free;
      GetReg :=Mmap_get_reg;
      SetReg := Mmap_set_reg;
      GetFlag := Mmap_get_flag;
      SetFlag := Mmap_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_to_granule", prim addr_to_granule_spec)
          :: ("arch_feat_get_pa_width", prim arch_feat_get_pa_width_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("entry_is_table", prim entry_is_table_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("is_feat_vmid16_present", prim is_feat_vmid16_present_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memset", prim memset_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rec_ipa_size", prim rec_ipa_size_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("stage2_tlbi_ipa", prim stage2_tlbi_ipa_spec)
          :: nil
    |}.

End Mmap_Layer.
