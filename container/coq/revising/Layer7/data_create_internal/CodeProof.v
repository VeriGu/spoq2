Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Layer.
Require Import Layer6.Spec.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_data_create_internal_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque __granule_get_spec.
  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque find_granule_spec.
  Local Opaque free_stack.
  Local Opaque g_mapped_addr_set_spec.
  Local Opaque granule_addr_spec.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_8_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque memset_spec.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque ns_buffer_read_spec.
  Local Opaque ns_buffer_unmap_spec.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s1tte_create_valid_spec.
  Local Opaque s1tte_pa_spec.
  Local Opaque s2tte_create_assigned_spec.
  Local Opaque s2tte_get_ripas_spec.
  Local Opaque s2tte_is_unassigned_spec.
  Local Opaque stage1_tlbi_all_spec.
    Lemma f_data_create_internal_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 st st' res
             (Hspec: data_create_internal_spec_low v_0 v_1 v_2 v_3 v_4 v_5 st = Some (res, st')),
        exec_func Layer6_layer code "data_create_internal"
                  [VInt v_0; VPtr v_1; VInt v_2; VPtr v_3; VPtr v_4; VInt v_5]
                  st st' (Some (VInt res)).
Admitted.

End Layer7_data_create_internal_CodeProof.

