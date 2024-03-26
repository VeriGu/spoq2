Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter GranuleState_init: RData.

Section GranuleState_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition GranuleState_newframe (fname: string) (st: RData) : option (RData) := None.

  Definition GranuleState_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition GranuleState_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition GranuleState_get_flag (f: flag) (st: RData) : bool := false.

  Definition GranuleState_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition GranuleState_layer :=
    {|
      State := RData;
      Init := GranuleState_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := GranuleState_newframe;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=GranuleState_get_reg;
      SetReg := GranuleState_set_reg;
      GetFlag := GranuleState_get_flag;
      SetFlag := GranuleState_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("granule_from_idx", prim granule_from_idx_spec)
          :: ("granule_get_state", prim granule_get_state_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("plat_granule_addr_to_idx", prim plat_granule_addr_to_idx_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("spinlock_acquire", prim spinlock_acquire_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End GranuleState_Layer.
