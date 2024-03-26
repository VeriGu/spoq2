Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SMCHandler.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter SMCHandler_init: RData.

Section SMCHandler_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition SMCHandler_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition SMCHandler_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition SMCHandler_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition SMCHandler_get_flag (f: flag) (st: RData) : bool := false.

  Definition SMCHandler_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition SMCHandler_layer :=
    {|
      State := RData;
      Init := SMCHandler_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := SMCHandler_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=SMCHandler_get_reg;
      SetReg := SMCHandler_set_reg;
      GetFlag := SMCHandler_get_flag;
      SetFlag := SMCHandler_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("smc_granule_delegate", prim smc_granule_delegate_spec)
          :: ("smc_granule_undelegate", prim smc_granule_undelegate_spec)
          :: nil
    |}.

End SMCHandler_Layer.
