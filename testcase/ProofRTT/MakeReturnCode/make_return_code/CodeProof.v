Require Import Bottom.Layer.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import MakeReturnCode.make_return_code.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section MakeReturnCode_make_return_code_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_make_return_code_correct:
      forall v_status v_index st st' res
             (Hspec: make_return_code_spec_low v_status v_index st = Some (res, st')),
        exec_func Bottom_layer code "make_return_code"
                  [VInt v_status; VInt v_index]
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

End MakeReturnCode_make_return_code_CodeProof.

