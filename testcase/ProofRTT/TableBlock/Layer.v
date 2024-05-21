Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import Helpers.Spec.
Require Import LockGranules.Spec.
Require Import MemRW.Spec.
Require Import Mmap.Spec.
Require Import S2TTCreate.Spec.
Require Import S2TTEOps.Spec.
Require Import S2TTEPA.Spec.
Require Import S2TTEState.Spec.
Require Import TableAux.Spec.
Require Import TableBlock.Spec.
Require Import TableWalk.Spec.
Require Import ValidateAddr.Spec.
Require Import ValidateTable.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter TableBlock_init: RData.

Section TableBlock_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition TableBlock_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition TableBlock_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition TableBlock_get_flag (f: flag) (st: RData) : bool := false.

  Definition TableBlock_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition TableBlock_layer :=
    {|
      State := RData;
      Init := TableBlock_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=TableBlock_get_reg;
      SetReg := TableBlock_set_reg;
      GetFlag := TableBlock_get_flag;
      SetFlag := TableBlock_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__table_is_uniform_block", prim __table_is_uniform_block_spec)
          :: ("__table_maps_block", prim __table_maps_block_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_in_par", prim addr_in_par_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("data_granule_measure", prim data_granule_measure_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("granule_unlock_transition", prim granule_unlock_transition_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("memset", prim memset_spec)
          :: ("ns_buffer_read", prim ns_buffer_read_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
          :: ("s2tte_create_assigned_empty", prim s2tte_create_assigned_empty_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_create_valid", prim s2tte_create_valid_spec)
          :: ("s2tte_create_valid_ns", prim s2tte_create_valid_ns_spec)
          :: ("s2tte_get_ripas", prim s2tte_get_ripas_spec)
          :: ("s2tte_is_destroyed", prim s2tte_is_destroyed_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_is_valid", prim s2tte_is_valid_spec)
          :: ("s2tte_map_size", prim s2tte_map_size_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("validate_data_create", prim validate_data_create_spec)
          :: ("validate_data_create_unknown", prim validate_data_create_unknown_spec)
          :: nil
    |}.

End TableBlock_Layer.
