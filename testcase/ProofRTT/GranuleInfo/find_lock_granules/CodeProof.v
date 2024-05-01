Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleInfo.Spec.
Require Import GranuleInfo.find_lock_granules.LowSpec.
Require Import GranuleLock.Layer.
Require Import GranuleLock.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section GranuleInfo_find_lock_granules_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque find_lock_granule_spec.
  Hint Unfold find_lock_granules_loop0_low:spec.
  Hint Unfold find_lock_granules_loop0_rank:spec.
  Hint Unfold find_lock_granules_loop197_low:spec.
  Hint Unfold find_lock_granules_loop197_rank:spec.
  Local Opacque granule_unlock_spec.
  Local Opacque int_to_ptr.
  Local Opacque load_RData.
  Local Opacque mkPtr.
  Local Opacque ptr_eqb.
  Local Opacque ptr_offset.
  Local Opacque ptr_to_int.
  Local Opacque sort_granules_spec.
  Local Opacque store_RData.
    Lemma f_find_lock_granules_correct:
      forall v_granules v_n st st' res
             (Hspec: find_lock_granules_spec_low v_granules v_n st = Some (res, st')),
        exec_func GranuleLock_layer code "find_lock_granules"
                  [VPtr v_granules; VInt v_n]
                  st st' (Some (VBool res)).
Admitted.

End GranuleInfo_find_lock_granules_CodeProof.

