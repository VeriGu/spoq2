Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleState.Spec.
Require Import Helpers.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter FindGranule_init: RData.

Section FindGranule_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition FindGranule_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition FindGranule_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition FindGranule_get_flag (f: flag) (st: RData) : bool := false.

  Definition FindGranule_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition FindGranule_layer :=
    {|
      State := RData;
      Init := FindGranule_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=FindGranule_get_reg;
      SetReg := FindGranule_set_reg;
      GetFlag := FindGranule_get_flag;
      SetFlag := FindGranule_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("find_granule", prim find_granule_spec)
          :: ("granule_lock_on_state_match", prim granule_lock_on_state_match_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("iasm_10", prim iasm_10_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("my_cpuid", prim my_cpuid_spec)
          :: ("plat_granule_idx_to_addr", prim plat_granule_idx_to_addr_spec)
          :: ("spinlock_release", prim spinlock_release_spec)
          :: ("xlat_map_memory_page_with_attrs", prim xlat_map_memory_page_with_attrs_spec)
          :: ("xlat_unmap_memory_page", prim xlat_unmap_memory_page_spec)
          :: nil
    |}.

End FindGranule_Layer.
