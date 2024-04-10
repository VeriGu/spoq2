Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter S2TTCreate_init: RData.

Section S2TTCreate_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition S2TTCreate_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition S2TTCreate_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition S2TTCreate_get_flag (f: flag) (st: RData) : bool := false.

  Definition S2TTCreate_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition S2TTCreate_layer :=
    {|
      State := RData;
      Init := S2TTCreate_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=S2TTCreate_get_reg;
      SetReg := S2TTCreate_set_reg;
      GetFlag := S2TTCreate_get_flag;
      SetFlag := S2TTCreate_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("map_unmap_ns", prim map_unmap_ns_spec)
          :: ("s2tte_create_table", prim s2tte_create_table_spec)
          :: ("s2tte_create_valid", prim s2tte_create_valid_spec)
          :: ("s2tte_get_ripas", prim s2tte_get_ripas_spec)
          :: nil
    |}.

End S2TTCreate_Layer.
