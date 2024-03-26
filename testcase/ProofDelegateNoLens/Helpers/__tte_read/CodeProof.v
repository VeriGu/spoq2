Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.__tte_read.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers___tte_read_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f___tte_read_correct:
      forall v_ttep st st' res
             (Hspec: __tte_read_spec_low v_ttep st = Some (res, st')),
        exec_func MakeReturnCode_layer code "__tte_read"
                  [VPtr v_ttep]
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

End Helpers___tte_read_CodeProof.

