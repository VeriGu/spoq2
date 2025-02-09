Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer13.Spec.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Parameter Layer13_init: RData.

Section Layer13_Layer.

  Context `{int_ptr: IntPtrCast}.

  Definition Layer13_get_reg (reg: regset) (st: RData) : option Z := None.

  Definition Layer13_set_reg (reg: regset) (val: Z) (st: RData) : option RData := None.

  Definition Layer13_get_flag (f: flag) (st: RData) : bool := false.

  Definition Layer13_set_flag (f: flag) (val: bool) (st: RData) : option RData := None.

  Definition Layer13_layer :=
    {|
      State := RData;
      Init := Layer13_init;
      Load := load_RData;
      Store := store_RData;
      NewFrame := new_frame;
      Alloca := alloc_stack;
      Free := free_stack;
      GetReg :=Layer13_get_reg;
      SetReg := Layer13_set_reg;
      GetFlag := Layer13_get_flag;
      SetFlag := Layer13_set_flag;
      Ptr2Int := ptr_to_int;
      Int2Ptr := int_to_ptr;
      PtrEqb := ptr_eqb;
      PtrLtb := ptr_ltb;
      PtrGtb := ptr_gtb;
      PrimCall :=
      ("smc_data_create", prim smc_data_create_spec)
      :: ("smc_data_create_unknown", prim smc_data_create_unknown_spec)
      :: ("smc_data_destroy", prim smc_data_destroy_spec)
      :: ("smc_data_dispose", prim smc_data_dispose_spec)
      :: ("smc_read_feature_register", prim smc_read_feature_register_spec)
      :: ("smc_realm_activate", prim smc_realm_activate_spec)
      :: ("smc_rec_enter", prim smc_rec_enter_spec)
      :: ("smc_rtt_create", prim smc_rtt_create_spec)
      :: ("smc_rtt_destroy", prim smc_rtt_destroy_spec)
      :: ("smc_rtt_map_non_secure", prim smc_rtt_map_non_secure_spec)
      :: ("smc_rtt_map_protected", prim smc_rtt_map_protected_spec)
      :: ("smc_rtt_read_entry", prim smc_rtt_read_entry_spec)
      :: ("smc_rtt_unmap_non_secure", prim smc_rtt_unmap_non_secure_spec)
      :: ("smc_rtt_unmap_protected", prim smc_rtt_unmap_protected_spec)
      :: ("smc_system_interface_version", prim smc_system_interface_version_spec)
          (* ("data_granule_measure", prim data_granule_measure_spec) *)
          (* :: ("s1tte_is_writable", prim s1tte_is_writable_spec) *)
          (* :: ("s2tte_addr_type_mask", prim s2tte_addr_type_mask_spec) *)
          (* :: ("s2tte_create_destroyed", prim s2tte_create_destroyed_spec) *)
          (* :: ("stage1_tlbi_va", prim stage1_tlbi_va_spec) *)
          (* :: ("stage1_tlbi_val", prim stage1_tlbi_val_spec) *)
          :: nil
    |}.

End Layer13_Layer.
