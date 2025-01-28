Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer13.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer13_init: RData.

Section Layer13_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer13_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer13_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer13_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer13_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer13_layer :=
    {|
      State := RData;
      Init := Layer13_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer13_get_reg;
      SetReg := Layer13_set_reg;
      GetFlag := Layer13_get_flag;
      SetFlag := Layer13_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("smc_realm_destroy", prim smc_realm_destroy_spec)
          :: nil
    |}.

End Layer13_Layer.
