Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
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
Require Import TableAux.Spec.
Require Import ValidateAddr.Spec.
Require Import ValidateTable.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter TableAux_init: RData.

Section TableAux_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition TableAux_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition TableAux_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition TableAux_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition TableAux_get_flag (f: flag) (st: RData) : bool := false.

  Definition TableAux_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition TableAux_layer :=
    {|
      State := RData;
      Init := TableAux_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := TableAux_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=TableAux_get_reg;
      SetReg := TableAux_set_reg;
      GetFlag := TableAux_get_flag;
      SetFlag := TableAux_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__find_lock_next_level", prim __find_lock_next_level_spec)
          :: ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__granule_refcount_inc", prim __granule_refcount_inc_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_in_par", prim addr_in_par_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("data_granule_measure", prim data_granule_measure_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("get_rd_state_locked", prim get_rd_state_locked_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_memzero_mapped", prim granule_memzero_mapped_spec)
          :: ("granule_refcount_read_acquire", prim granule_refcount_read_acquire_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("host_ns_s2tte_is_valid", prim host_ns_s2tte_is_valid_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_page", prim invalidate_page_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("llvm_memset_p0i8_i64", prim llvm_memset_p0i8_i64_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
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
          :: ("update_ripas", prim update_ripas_spec)
          :: ("validate_data_create", prim validate_data_create_spec)
          :: ("validate_data_create_unknown", prim validate_data_create_unknown_spec)
          :: ("validate_rtt_entry_cmds", prim validate_rtt_entry_cmds_spec)
          :: ("validate_rtt_map_cmds", prim validate_rtt_map_cmds_spec)
          :: ("validate_rtt_structure_cmds", prim validate_rtt_structure_cmds_spec)
          :: nil
    |}.

End TableAux_Layer.
