Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import MemRW.Layer.
Require Import MemRW.Spec.
Require Import RealmCreate.Spec.
Require Import RealmCreate.free_sl_rtts.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RealmCreate_free_sl_rtts_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Hint Unfold free_sl_rtts_loop193_low:spec.
  Hint Unfold free_sl_rtts_loop193_rank:spec.
  Local Opacque granule_lock_spec.
  Local Opacque granule_memzero_spec.
  Local Opacque granule_unlock_transition_spec.
  Local Opacque ptr_offset.
    Lemma f_free_sl_rtts_correct:
      forall v_g_rtt v_num_rtts st st'
             (Hspec: free_sl_rtts_spec_low v_g_rtt v_num_rtts st = Some st'),
        exec_func MemRW_layer code "free_sl_rtts"
                  [VPtr v_g_rtt; VInt v_num_rtts]
                  st st' None.
Admitted.

End RealmCreate_free_sl_rtts_CodeProof.

