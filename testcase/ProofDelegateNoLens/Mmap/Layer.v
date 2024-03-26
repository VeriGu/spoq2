Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Mmap.Spec.

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
          ("buffer_unmap", prim buffer_unmap_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: nil
    |}.

End Mmap_Layer.
