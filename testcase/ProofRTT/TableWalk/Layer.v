Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import Helpers.Spec.
Require Import InvalidatePages.Spec.
Require Import Mmap.Spec.
Require Import S2TTEState.Spec.
Require Import TableWalk.Spec.
Require Import ValidateAddr.Spec.
Require Import ValidateTable.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter TableWalk_init: RData.

Section TableWalk_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition TableWalk_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition TableWalk_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition TableWalk_get_flag (f: flag) (st: RData) : bool := false.

  Definition TableWalk_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition TableWalk_layer :=
    {|
      State := RData;
      Init := TableWalk_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=TableWalk_get_reg;
      SetReg := TableWalk_set_reg;
      GetFlag := TableWalk_get_flag;
      SetFlag := TableWalk_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_in_par", prim addr_in_par_spec)
          :: ("buffer_unmap", prim buffer_unmap_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("invalidate_block", prim invalidate_block_spec)
          :: ("invalidate_page", prim invalidate_page_spec)
          :: ("llvm_memcpy_p0i8_p0i8_i64", prim llvm_memcpy_p0i8_p0i8_i64_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("realm_ipa_bits", prim realm_ipa_bits_spec)
          :: ("realm_rtt_starting_level", prim realm_rtt_starting_level_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
          :: ("s2tte_create_valid_ns", prim s2tte_create_valid_ns_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_is_valid_ns", prim s2tte_is_valid_ns_spec)
          :: ("validate_rtt_map_cmds", prim validate_rtt_map_cmds_spec)
          :: nil
    |}.

End TableWalk_Layer.
