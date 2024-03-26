Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import MemRW.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter MemRW_init: RData.

Section MemRW_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition MemRW_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition MemRW_alloca (fname: string) (size: Z) (align: Z) (st: RData) : option (Ptr * RData) := None.

  Definition MemRW_free (fname: string) (init_st: RData) (st: RData) : option RData := None.

  Definition MemRW_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition MemRW_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition MemRW_get_flag (f: flag) (st: RData) : bool := false.

  Definition MemRW_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition MemRW_layer :=
    {|
      State := RData;
      Init := MemRW_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := MemRW_newframe;
      Alloca := MemRW_alloca;
      Free := MemRW_free;
      GetReg :=MemRW_get_reg;
      SetReg := MemRW_set_reg;
      GetFlag := MemRW_get_flag;
      SetFlag := MemRW_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("find_lock_granule", prim find_lock_granule_spec)
          :: ("granule_memzero", prim granule_memzero_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: nil
    |}.

End MemRW_Layer.
