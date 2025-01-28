Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Spec.
Require Import Layer12.Layer.
Require Import Layer12.Spec.
Require Import Layer13.smc_rtt_read_entry.LowSpec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_smc_rtt_read_entry_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __tte_read_spec.
  Local Opaque find_lock_granule_spec.
  Local Opaque free_stack.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque host_ns_s2tte_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque realm_ipa_bits_spec.
  Local Opaque realm_rtt_starting_level_spec.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s2tte_is_assigned_spec.
  Local Opaque s2tte_is_destroyed_spec.
  Local Opaque s2tte_is_table_spec.
  Local Opaque s2tte_is_unassigned_spec.
  Local Opaque s2tte_is_valid_ns_spec.
  Local Opaque s2tte_is_valid_spec.
  Local Opaque s2tte_pa_spec.
  Local Opaque store_RData.
  Local Opaque validate_rtt_entry_cmds_spec.
    Lemma f_smc_rtt_read_entry_correct:
      forall v_0 v_1 v_2 v_3 st st'
             (Hspec: smc_rtt_read_entry_spec_low v_0 v_1 v_2 v_3 st = Some st'),
        exec_func Layer12_layer code "smc_rtt_read_entry"
                  [VInt v_0; VInt v_1; VInt v_2; VPtr v_3]
                  st st' None.
Admitted.

End Layer13_smc_rtt_read_entry_CodeProof.

