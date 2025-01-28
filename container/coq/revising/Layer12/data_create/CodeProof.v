Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Spec.
Require Import Layer10.Spec.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.data_create.LowSpec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_data_create_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __granule_get_spec.
  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque find_lock_two_granules_spec.
  Local Opaque free_stack.
  Local Opaque granule_addr_spec.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque granule_unlock_transition_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque memset_spec.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque ns_buffer_read_spec.
  Local Opaque ns_buffer_unmap_spec.
  Local Opaque pack_return_code_spec.
  Local Opaque pack_struct_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque realm_ipa_bits_spec.
  Local Opaque realm_rtt_starting_level_spec.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s2tte_create_assigned_spec.
  Local Opaque s2tte_create_valid_spec.
  Local Opaque s2tte_get_ripas_spec.
  Local Opaque s2tte_is_unassigned_spec.
  Local Opaque validate_data_create_spec.
  Local Opaque validate_data_create_unknown_spec.
    Lemma f_data_create_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: data_create_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer11_layer code "data_create"
                  [VInt v_0; VInt v_1; VInt v_2; VPtr v_3]
                  st st' (Some (VInt res)).
Admitted.

End Layer12_data_create_CodeProof.

