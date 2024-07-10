Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleLock.Spec.
Require Import InitRec.Spec.
Require Import InitRec.free_rec_aux_granules.LowSpec.
Require Import MemRW.Layer.
Require Import MemRW.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section InitRec_free_rec_aux_granules_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Hint Unfold free_rec_aux_granules_loop176_low:spec.
  Hint Unfold free_rec_aux_granules_loop176_rank:spec.
  Local Opacque granule_lock_spec.
  Local Opacque granule_memzero_spec.
  Local Opacque granule_unlock_transition_spec.
  Local Opacque int_to_ptr.
  Local Opacque load_RData.
  Local Opacque ptr_offset.
    Lemma f_free_rec_aux_granules_correct:
      forall v_rec_aux v_cnt v_scrub st st'
             (Hspec: free_rec_aux_granules_spec_low v_rec_aux v_cnt v_scrub st = Some st'),
        exec_func MemRW_layer code "free_rec_aux_granules"
                  [VPtr v_rec_aux; VInt v_cnt; VBool v_scrub]
                  st st' None.
Admitted.

End InitRec_free_rec_aux_granules_CodeProof.

