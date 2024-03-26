Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.

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
          ("find_lock_granule", prim find_lock_granule_spec)
          :: ("get_cached_llt_info", prim get_cached_llt_info_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("slot_to_va", prim slot_to_va_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End GranuleInfo_Layer.
