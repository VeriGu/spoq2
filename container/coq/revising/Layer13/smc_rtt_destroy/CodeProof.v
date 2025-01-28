Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Layer.
Require Import Layer12.Spec.
Require Import Layer13.smc_rtt_destroy.LowSpec.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_smc_rtt_destroy_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __granule_put_spec.
  Local Opaque __tte_read_spec.
  Local Opaque __tte_write_spec.
  Local Opaque find_lock_granule_spec.
  Local Opaque free_stack.
  Local Opaque g_refcount_spec.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_memzero_mapped_spec.
  Local Opaque granule_set_state_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque int_to_ptr.
  Local Opaque invalidate_block_spec.
  Local Opaque llvm_memcpy_p0i8_p0i8_i64_spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque realm_ipa_bits_spec.
  Local Opaque realm_rtt_starting_level_spec.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s2tte_is_table_spec.
  Local Opaque s2tte_pa_spec.
  Local Opaque validate_rtt_structure_cmds_spec.
    Lemma f_smc_rtt_destroy_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: smc_rtt_destroy_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer12_layer code "smc_rtt_destroy"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3]
                  st st' (Some (VInt res)).
Admitted.

End Layer13_smc_rtt_destroy_CodeProof.

