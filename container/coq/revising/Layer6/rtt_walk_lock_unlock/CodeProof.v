Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer5.Layer.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer6.rtt_walk_lock_unlock.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_rtt_walk_lock_unlock_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __find_lock_next_level_spec.
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
  Hint Unfold rtt_walk_lock_unlock_loop467_low:spec.
  Hint Unfold rtt_walk_lock_unlock_loop467_rank:spec.
  Local Opaque s2_addr_to_idx_spec.
  Local Opaque s2_sl_addr_to_idx_spec.
  Local Opaque store_RData.
    Lemma f_rtt_walk_lock_unlock_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 st st'
             (Hspec: rtt_walk_lock_unlock_spec_low v_0 v_1 v_2 v_3 v_4 v_5 st = Some st'),
        exec_func Layer5_layer code "rtt_walk_lock_unlock"
                  [VPtr v_0; VPtr v_1; VInt v_2; VInt v_3; VInt v_4; VInt v_5]
                  st st' None.
Admitted.

End Layer6_rtt_walk_lock_unlock_CodeProof.

