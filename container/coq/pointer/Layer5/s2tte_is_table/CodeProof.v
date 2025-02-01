Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Layer.
Require Import Layer5.s2tte_is_table.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer5_s2tte_is_table_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2tte_is_table_correct:
      forall v_0 v_1 st st' res
             (Hspec: s2tte_is_table_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer4_layer code "s2tte_is_table"
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

End Layer5_s2tte_is_table_CodeProof.

