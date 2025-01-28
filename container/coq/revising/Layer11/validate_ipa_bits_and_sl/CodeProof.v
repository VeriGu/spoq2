Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer10.Spec.
Require Import Layer11.validate_ipa_bits_and_sl.LowSpec.
Require Import Layer5.Spec.
Require Import Layer8.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_validate_ipa_bits_and_sl_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque make_return_code_spec.
  Local Opaque max_pa_size_spec.
  Local Opaque s2_inconsistent_sl_spec.
    Lemma f_validate_ipa_bits_and_sl_correct:
      forall v_0 v_1 st st' res
             (Hspec: validate_ipa_bits_and_sl_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer10_layer code "validate_ipa_bits_and_sl"
                  [VInt v_0; VInt v_1]
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

End Layer11_validate_ipa_bits_and_sl_CodeProof.

