Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleLock.Spec.
Require Import Helpers.Spec.
Require Import TableAux.Layer.
Require Import TableAux.Spec.
Require Import TableWalk.Spec.
Require Import TableWalk.rtt_walk_lock_unlock.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section TableWalk_rtt_walk_lock_unlock_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __find_lock_next_level_spec.
  Local Opaque alloc_stack.
  Local Opaque free_stack.
  Local Opaque granule_lock_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque int_to_ptr.
  Local Opaque llvm_memset_p0i8_i64_spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque ptr_to_int.
  Hint Unfold rtt_walk_lock_unlock_loop370_low:spec.
  Hint Unfold rtt_walk_lock_unlock_loop370_rank:spec.
  Local Opaque s2_addr_to_idx_spec.
  Local Opaque s2_sl_addr_to_idx_spec.
  Local Opaque store_RData.
    Lemma f_rtt_walk_lock_unlock_correct:
      forall v_g_root v_start_level v_ipa_bits v_map_addr v_level v_wi st st'
             (Hspec: rtt_walk_lock_unlock_spec_low v_g_root v_start_level v_ipa_bits v_map_addr v_level v_wi st = Some st'),
        exec_func TableAux_layer code "rtt_walk_lock_unlock"
                  [VPtr v_g_root; VInt v_start_level; VInt v_ipa_bits; VInt v_map_addr; VInt v_level; VPtr v_wi]
                  st st' None.
Admitted.

End TableWalk_rtt_walk_lock_unlock_CodeProof.

