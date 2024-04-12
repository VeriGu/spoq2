Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import SCA.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter SCA_init: RData.

Section SCA_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition SCA_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition SCA_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition SCA_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition SCA_get_flag (f: flag) (st: RData) : bool := false.

  Definition SCA_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition SCA_layer :=
    {|
      State := RData;
      Init := SCA_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := SCA_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=SCA_get_reg;
      SetReg := SCA_set_reg;
      GetFlag := SCA_get_flag;
      SetFlag := SCA_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__sca_read64", prim __sca_read64_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("arch_feat_get_pa_width", prim arch_feat_get_pa_width_spec)
          :: ("iasm_335", prim iasm_335_spec)
          :: ("isb", prim isb_spec)
          :: ("xlat_arch_get_pas", prim xlat_arch_get_pas_spec)
          :: ("xlat_arch_tlbi_va", prim xlat_arch_tlbi_va_spec)
          :: ("xlat_arch_tlbi_va_sync", prim xlat_arch_tlbi_va_sync_spec)
          :: nil
    |}.

End SCA_Layer.
