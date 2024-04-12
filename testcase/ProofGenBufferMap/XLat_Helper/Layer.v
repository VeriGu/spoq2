Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import XLat_Helper.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter XLat_Helper_init: RData.

Section XLat_Helper_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition XLat_Helper_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition XLat_Helper_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition XLat_Helper_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition XLat_Helper_get_flag (f: flag) (st: RData) : bool := false.

  Definition XLat_Helper_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition XLat_Helper_layer :=
    {|
      State := RData;
      Init := XLat_Helper_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := XLat_Helper_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=XLat_Helper_get_reg;
      SetReg := XLat_Helper_set_reg;
      GetFlag := XLat_Helper_get_flag;
      SetFlag := XLat_Helper_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("iasm_335", prim iasm_335_spec)
          :: ("isb", prim isb_spec)
          :: ("xlat_arch_get_max_supported_pa", prim xlat_arch_get_max_supported_pa_spec)
          :: ("xlat_arch_tlbi_va", prim xlat_arch_tlbi_va_spec)
          :: ("xlat_arch_tlbi_va_sync", prim xlat_arch_tlbi_va_sync_spec)
          :: ("xlat_desc", prim xlat_desc_spec)
          :: ("xlat_get_tte_ptr", prim xlat_get_tte_ptr_spec)
          :: ("xlat_read_tte", prim xlat_read_tte_spec)
          :: ("xlat_write_tte", prim xlat_write_tte_spec)
          :: nil
    |}.

End XLat_Helper_Layer.
