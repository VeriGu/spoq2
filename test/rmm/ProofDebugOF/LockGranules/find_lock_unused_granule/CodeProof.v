Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.Layer.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import LockGranules.find_lock_unused_granule.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section LockGranules_find_lock_unused_granule_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_lock_granule_spec.
  Local Opaque granule_refcount_read_acquire_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque mkPtr.
  Local Opaque ptr_eqb.
  Local Opaque status_ptr_spec.
    Lemma f_find_lock_unused_granule_correct:
      forall v_addr v_expected_state st st' res
             (Hspec: find_lock_unused_granule_spec_low v_addr v_expected_state st = Some (res, st')),
        exec_func GranuleInfo_layer code "find_lock_unused_granule"
                  [VInt v_addr; VInt v_expected_state]
                  st st' (Some (VPtr res)).
    Proof.
        intros; simpl_func Hspec; simpl in *;
          unshelve (eapply exec_func_call);
         (lia ||
          match goal with
          | [ |- temp_env ] => shelve
          | [ |- function ] => shelve
          | [ |- function_body ] => shelve
          | [ |- State _ ] => shelve
          | _ => idtac
          end);
         unshelve (try reflexivity; try solve [repeat vcgen | (frewrite; repeat vcgen)]);
         (lia ||
          match goal with
          | [ |- temp_env ] => shelve
          | _ => idtac
          end).
    Qed.

End LockGranules_find_lock_unused_granule_CodeProof.

