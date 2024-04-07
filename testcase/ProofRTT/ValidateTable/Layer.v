Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.
Require Import InvalidatePages.Spec.
Require Import LockGranules.Spec.
Require Import MemRW.Spec.
Require Import Mmap.Spec.
Require Import RDState.Spec.
Require Import S2TTEOps.Spec.
Require Import S2TTEPA.Spec.
Require Import S2TTEState.Spec.
Require Import ValidateAddr.Spec.
Require Import ValidateTable.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter ValidateTable_init: RData.

Section ValidateTable_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition ValidateTable_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition ValidateTable_alloca (fname: string) (size: Z) (align: Z) (st: RData) : option (Ptr * RData) := None.

  Definition ValidateTable_free (fname: string) (init_st: RData) (st: RData) : option RData := None.

  Definition ValidateTable_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition ValidateTable_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition ValidateTable_get_flag (f: flag) (st: RData) : bool := false.

  Definition ValidateTable_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition ValidateTable_layer :=
    {|
      State := RData;
      Init := ValidateTable_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := ValidateTable_newframe;
      Alloca := ValidateTable_alloca;
      Free := ValidateTable_free;
      GetReg :=ValidateTable_get_reg;
      SetReg := ValidateTable_set_reg;
      GetFlag := ValidateTable_get_flag;
      SetFlag := ValidateTable_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__find_next_level_idx", prim __find_next_level_idx_spec)
          :: ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_in_par", prim addr_in_par_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_memzero_mapped", prim granule_memzero_mapped_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("s2_addr_to_idx", prim s2_addr_to_idx_spec)
          :: ("s2_sl_addr_to_idx", prim s2_sl_addr_to_idx_spec)
          :: ("s2tte_create_assigned_empty", prim s2tte_create_assigned_empty_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_create_valid_ns", prim s2tte_create_valid_ns_spec)
          :: ("s2tte_is_assigned", prim s2tte_is_assigned_spec)
          :: ("s2tte_is_destroyed", prim s2tte_is_destroyed_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_is_valid", prim s2tte_is_valid_spec)
          :: ("s2tte_is_valid_ns", prim s2tte_is_valid_ns_spec)
          :: ("s2tte_map_size", prim s2tte_map_size_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("s2tte_pa_table", prim s2tte_pa_table_spec)
          :: ("set_rd_state", prim set_rd_state_spec)
          :: ("validate_data_create_unknown", prim validate_data_create_unknown_spec)
          :: ("validate_rtt_entry_cmds", prim validate_rtt_entry_cmds_spec)
          :: ("validate_rtt_map_cmds", prim validate_rtt_map_cmds_spec)
          :: ("validate_rtt_structure_cmds", prim validate_rtt_structure_cmds_spec)
          :: nil
    |}.

End ValidateTable_Layer.
