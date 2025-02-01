Require Import Bottom.Spec.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer7_init: RData.

Section Layer7_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer7_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer7_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer7_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer7_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer7_layer :=
    {|
      State := RData;
      Init := Layer7_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer7_get_reg;
      SetReg := Layer7_set_reg;
      GetFlag := Layer7_get_flag;
      SetFlag := Layer7_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
          ("__granule_get", prim __granule_get_spec)
          :: ("__granule_put", prim __granule_put_spec)
          :: ("__tte_read", prim __tte_read_spec)
          :: ("__tte_write", prim __tte_write_spec)
          :: ("addr_is_level_aligned", prim addr_is_level_aligned_spec)
          :: ("data_create_internal", prim data_create_internal_spec)
          :: ("find_granule", prim find_granule_spec)
          :: ("find_lock_granule", prim find_lock_granule_spec)
          :: ("find_lock_two_granules", prim find_lock_two_granules_spec)
          :: ("g_refcount", prim g_refcount_spec)
          :: ("get_tte", prim get_tte_spec)
          :: ("granule_addr", prim granule_addr_spec)
          :: ("granule_lock", prim granule_lock_spec)
          :: ("granule_map", prim granule_map_spec)
          :: ("granule_set_state", prim granule_set_state_spec)
          :: ("granule_try_lock", prim granule_try_lock_spec)
          :: ("granule_unlock", prim granule_unlock_spec)
          :: ("make_return_code", prim make_return_code_spec)
          :: ("masked_assign", prim masked_assign_spec)
          :: ("max_pa_size", prim max_pa_size_spec)
          :: ("memset", prim memset_spec)
          :: ("monitor_call", prim monitor_call_spec)
          :: ("ns_buffer_read_byte", prim ns_buffer_read_byte_spec)
          :: ("ns_buffer_write_byte", prim ns_buffer_write_byte_spec)
          :: ("pack_return_code", prim pack_return_code_spec)
          :: ("realm_ipa_size", prim realm_ipa_size_spec)
          :: ("rtt_walk_lock_unlock", prim rtt_walk_lock_unlock_spec)
          :: ("s1addr_is_level_aligned", prim s1addr_is_level_aligned_spec)
          :: ("s1tte_pa", prim s1tte_pa_spec)
          :: ("s2tt_init_unassigned", prim s2tt_init_unassigned_spec)
          :: ("s2tte_create_assigned", prim s2tte_create_assigned_spec)
          :: ("s2tte_create_ripas", prim s2tte_create_ripas_spec)
          :: ("s2tte_create_unassigned", prim s2tte_create_unassigned_spec)
          :: ("s2tte_is_table", prim s2tte_is_table_spec)
          :: ("s2tte_is_unassigned", prim s2tte_is_unassigned_spec)
          :: ("s2tte_pa", prim s2tte_pa_spec)
          :: ("set_tte_ns", prim set_tte_ns_spec)
          :: ("stage1_tlbi_all", prim stage1_tlbi_all_spec)
          :: ("write_ap0r", prim write_ap0r_spec)
          :: ("write_ap1r", prim write_ap1r_spec)
          :: ("write_lr", prim write_lr_spec)
          :: nil
    |}.

End Layer7_Layer.
