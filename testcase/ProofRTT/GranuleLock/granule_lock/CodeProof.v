Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Layer.
Require Import GlobalDefs.
Require Import GranuleLock.granule_lock.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section GranuleLock_granule_lock_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_granule_lock_correct:
      forall v_g v_expected_state st st'
             (Hspec: granule_lock_spec_low v_g v_expected_state st = Some st'),
        exec_func FindGranule_layer code "granule_lock"
                  [VPtr v_g; VInt v_expected_state]
                  st st' None.
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

End GranuleLock_granule_lock_CodeProof.

