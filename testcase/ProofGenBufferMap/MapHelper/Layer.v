Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MapHelper.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter MapHelper_init: RData.

Section MapHelper_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition MapHelper_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition MapHelper_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition MapHelper_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition MapHelper_get_flag (f: flag) (st: RData) : bool := false.

  Definition MapHelper_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition MapHelper_layer :=
    {|
      State := RData;
      Init := MapHelper_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := MapHelper_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=MapHelper_get_reg;
      SetReg := MapHelper_set_reg;
      GetFlag := MapHelper_get_flag;
      SetFlag := MapHelper_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End MapHelper_Layer.
