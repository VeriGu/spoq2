Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer11.free_sl_rtts.LowSpec.
Require Import Layer4.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_free_sl_rtts_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Hint Unfold free_sl_rtts_loop194_low:spec.
  Hint Unfold free_sl_rtts_loop194_rank:spec.
  Local Opaque granule_lock_spec.
  Local Opaque granule_memzero_spec.
  Local Opaque granule_unlock_transition_spec.
  Local Opaque ptr_offset.
    Lemma f_free_sl_rtts_correct:
      forall v_0 v_1 v_2 st st'
             (Hspec: free_sl_rtts_spec_low v_0 v_1 v_2 st = Some st'),
        exec_func Layer10_layer code "free_sl_rtts"
                  [VPtr v_0; VInt v_1; VBool v_2]
                  st st' None.
Admitted.

End Layer11_free_sl_rtts_CodeProof.

