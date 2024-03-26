Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.s2_inconsistent_sl.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers_s2_inconsistent_sl_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2_inconsistent_sl_correct:
      forall v_ipa_bits v_sl st st' res
             (Hspec: s2_inconsistent_sl_spec_low v_ipa_bits v_sl st = Some (res, st')),
        exec_func MakeReturnCode_layer code "s2_inconsistent_sl"
                  [VInt v_ipa_bits; VInt v_sl]
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

End Helpers_s2_inconsistent_sl_CodeProof.

