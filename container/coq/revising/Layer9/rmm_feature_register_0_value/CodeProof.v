Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Layer.
Require Import Layer8.Spec.
Require Import Layer9.rmm_feature_register_0_value.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rmm_feature_register_0_value_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque max_pa_size_spec.
    Lemma f_rmm_feature_register_0_value_correct:
      forall st st' res
             (Hspec: rmm_feature_register_0_value_spec_low st = Some (res, st')),
        exec_func Layer8_layer code "rmm_feature_register_0_value"
                  []
                  st st' (Some (VInt res)).
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

End Layer9_rmm_feature_register_0_value_CodeProof.

