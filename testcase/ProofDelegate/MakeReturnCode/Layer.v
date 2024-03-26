Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MakeReturnCode.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter MakeReturnCode_init: RData.

Section MakeReturnCode_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition MakeReturnCode_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition MakeReturnCode_alloca (fname: string) (size: Z) (align: Z) (st: RData) : option (Ptr * RData) := None.

  Definition MakeReturnCode_free (fname: string) (init_st: RData) (st: RData) : option RData := None.

  Definition MakeReturnCode_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition MakeReturnCode_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition MakeReturnCode_get_flag (f: flag) (st: RData) : bool := false.

  Definition MakeReturnCode_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition MakeReturnCode_layer :=
    {|
      State := RData;
      Init := MakeReturnCode_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := MakeReturnCode_newframe;
      Alloca := MakeReturnCode_alloca;
      Free := MakeReturnCode_free;
      GetReg :=MakeReturnCode_get_reg;
      SetReg := MakeReturnCode_set_reg;
      GetFlag := MakeReturnCode_get_flag;
      SetFlag := MakeReturnCode_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__sca_read64", prim __sca_read64_spec)
          :: ("__sca_write64", prim __sca_write64_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("iasm_4", prim iasm_4_spec)
          :: ("isb", prim isb_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("memcpy", prim memcpy_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("pack_struct_return_code", prim pack_struct_return_code_spec)
          :: ("plat_granule_addr_to_idx", prim plat_granule_addr_to_idx_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("read_elr_el2", prim read_elr_el2_spec)
          :: ("read_tpidr_el2", prim read_tpidr_el2_spec)
          :: ("read_zcr_el2", prim read_zcr_el2_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("write_elr_el2", prim write_elr_el2_spec)
          :: ("write_zcr_el2", prim write_zcr_el2_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End MakeReturnCode_Layer.
