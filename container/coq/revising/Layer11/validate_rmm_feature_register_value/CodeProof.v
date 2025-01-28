Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer10.Spec.
Require Import Layer11.validate_rmm_feature_register_value.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_validate_rmm_feature_register_value_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque validate_rmm_feature_register_0_value_spec.
    Lemma f_validate_rmm_feature_register_value_correct:
      forall v_0 v_1 st st' res
             (Hspec: validate_rmm_feature_register_value_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer10_layer code "validate_rmm_feature_register_value"
                  [VInt v_0; VInt v_1]
                  st st' (Some (VBool res)).
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

End Layer11_validate_rmm_feature_register_value_CodeProof.

