Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer8_init: RData.

Section Layer8_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer8_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer8_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer8_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer8_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer8_layer :=
    {|
      State := RData;
      Init := Layer8_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer8_get_reg;
      SetReg := Layer8_set_reg;
      GetFlag := Layer8_get_flag;
      SetFlag := Layer8_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("rtt_create_s1_el1", prim rtt_create_s1_el1_spec)
          :: nil
    |}.

End Layer8_Layer.
