Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer9.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer9_init: RData.

Section Layer9_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer9_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer9_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer9_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer9_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer9_layer :=
    {|
      State := RData;
      Init := Layer9_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer9_get_reg;
      SetReg := Layer9_set_reg;
      GetFlag := Layer9_get_flag;
      SetFlag := Layer9_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("rsi_data_destroy", prim rsi_data_destroy_spec)
          :: nil
    |}.

End Layer9_Layer.
