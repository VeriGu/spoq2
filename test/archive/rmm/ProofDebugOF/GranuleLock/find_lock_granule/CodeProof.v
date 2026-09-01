Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Layer.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import GranuleLock.find_lock_granule.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section GranuleLock_find_lock_granule_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_granule_spec.
  Local Opaque granule_lock_on_state_match_spec.
  Local Opaque mkPtr.
  Local Opaque ptr_eqb.
    Lemma f_find_lock_granule_correct:
      forall v_addr v_expected_state st st' res
             (Hspec: find_lock_granule_spec_low v_addr v_expected_state st = Some (res, st')),
        exec_func FindGranule_layer code "find_lock_granule"
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

End GranuleLock_find_lock_granule_CodeProof.

