Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter GranuleLock_init: RData.

Section GranuleLock_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition GranuleLock_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition GranuleLock_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition GranuleLock_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition GranuleLock_get_flag (f: flag) (st: RData) : bool := false.

  Definition GranuleLock_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition GranuleLock_layer :=
    {|
      State := RData;
      Init := GranuleLock_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := GranuleLock_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=GranuleLock_get_reg;
      SetReg := GranuleLock_set_reg;
      GetFlag := GranuleLock_get_flag;
      SetFlag := GranuleLock_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("find_lock_granule", prim find_lock_granule_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End GranuleLock_Layer.
