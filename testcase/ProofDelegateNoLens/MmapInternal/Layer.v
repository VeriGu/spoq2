Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import MmapInternal.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter MmapInternal_init: RData.

Section MmapInternal_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition MmapInternal_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition MmapInternal_alloca (fname: string) (size: Z) (align: Z) (st: RData) : option (Ptr * RData) := None.

  Definition MmapInternal_free (fname: string) (init_st: RData) (st: RData) : option RData := None.

  Definition MmapInternal_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition MmapInternal_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition MmapInternal_get_flag (f: flag) (st: RData) : bool := false.

  Definition MmapInternal_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition MmapInternal_layer :=
    {|
      State := RData;
      Init := MmapInternal_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := MmapInternal_newframe;
      Alloca := MmapInternal_alloca;
      Free := MmapInternal_free;
      GetReg :=MmapInternal_get_reg;
      SetReg := MmapInternal_set_reg;
      GetFlag := MmapInternal_get_flag;
      SetFlag := MmapInternal_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("buffer_map_internal", prim buffer_map_internal_spec)
          :: ("buffer_unmap_internal", prim buffer_unmap_internal_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: nil
    |}.

End MmapInternal_Layer.
