Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import ExceptionOps.Spec.
Require Import GlobalDefs.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter ExceptionOps_init: RData.

Section ExceptionOps_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition ExceptionOps_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition ExceptionOps_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition ExceptionOps_get_flag (f: flag) (st: RData) : bool := false.

  Definition ExceptionOps_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition ExceptionOps_layer :=
    {|
      State := RData;
      Init := ExceptionOps_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=ExceptionOps_get_reg;
      SetReg := ExceptionOps_set_reg;
      GetFlag := ExceptionOps_get_flag;
      SetFlag := ExceptionOps_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("data_create", prim data_create_spec)
          :: nil
    |}.

End ExceptionOps_Layer.
