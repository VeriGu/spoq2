Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.fsc_is_external_abort.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers_fsc_is_external_abort_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_fsc_is_external_abort_correct:
      forall v_fsc st st' res
             (Hspec: fsc_is_external_abort_spec_low v_fsc st = Some (res, st')),
        exec_func MakeReturnCode_layer code "fsc_is_external_abort"
                  [VInt v_fsc]
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

End Helpers_fsc_is_external_abort_CodeProof.

