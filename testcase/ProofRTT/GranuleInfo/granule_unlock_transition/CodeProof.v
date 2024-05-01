Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import GranuleInfo.granule_unlock_transition.LowSpec.
Require Import GranuleLock.Layer.
Require Import GranuleLock.Spec.
Require Import GranuleState.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section GranuleInfo_granule_unlock_transition_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque granule_set_state_spec.
  Local Opacque granule_unlock_spec.
    Lemma f_granule_unlock_transition_correct:
      forall v_g v_new_state st st'
             (Hspec: granule_unlock_transition_spec_low v_g v_new_state st = Some st'),
        exec_func GranuleLock_layer code "granule_unlock_transition"
                  [VPtr v_g; VInt v_new_state]
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

End GranuleInfo_granule_unlock_transition_CodeProof.

