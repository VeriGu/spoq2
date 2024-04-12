Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helper.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Helper_init: RData.

Section Helper_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Helper_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition Helper_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Helper_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Helper_get_flag (f: flag) (st: RData) : bool := false.

  Definition Helper_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Helper_layer :=
    {|
      State := RData;
      Init := Helper_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := Helper_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Helper_get_reg;
      SetReg := Helper_set_reg;
      GetFlag := Helper_get_flag;
      SetFlag := Helper_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("iasm_0", prim iasm_0_spec)
          :: ("iasm_2", prim iasm_2_spec)
          :: ("iasm_335", prim iasm_335_spec)
          :: ("isb", prim isb_spec)
          :: ("read_id_aa64mmfr0_el1", prim read_id_aa64mmfr0_el1_spec)
          :: ("xlat_arch_tlbi_va", prim xlat_arch_tlbi_va_spec)
          :: ("xlat_arch_tlbi_va_sync", prim xlat_arch_tlbi_va_sync_spec)
          :: nil
    |}.

End Helper_Layer.
