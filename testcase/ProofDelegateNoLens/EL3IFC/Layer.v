Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import EL3IFC.Spec.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import MemRW.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter EL3IFC_init: RData.

Section EL3IFC_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition EL3IFC_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition EL3IFC_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition EL3IFC_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition EL3IFC_get_flag (f: flag) (st: RData) : bool := false.

  Definition EL3IFC_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition EL3IFC_layer :=
    {|
      State := RData;
      Init := EL3IFC_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := EL3IFC_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=EL3IFC_get_reg;
      SetReg := EL3IFC_set_reg;
      GetFlag := EL3IFC_get_flag;
      SetFlag := EL3IFC_set_flag;
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
          :: ("rmm_el3_ifc_gtsi_delegate", prim rmm_el3_ifc_gtsi_delegate_spec)
          :: ("rmm_el3_ifc_gtsi_undelegate", prim rmm_el3_ifc_gtsi_undelegate_spec)
          :: nil
    |}.

End EL3IFC_Layer.
