Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Layer.
Require Import Layer7.find_lock_two_granules.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_find_lock_two_granules_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_find_lock_two_granules_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 st st' res
             (Hspec: find_lock_two_granules_spec_low v_0 v_1 v_2 v_3 v_4 v_5 st = Some (res, st')),
        exec_func Layer6_layer code "find_lock_two_granules"
                  [VInt v_0; VInt v_1; VPtr v_2; VInt v_3; VInt v_4; VPtr v_5]
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

End Layer7_find_lock_two_granules_CodeProof.

