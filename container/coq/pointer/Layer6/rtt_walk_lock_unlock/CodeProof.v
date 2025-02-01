Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Layer.
Require Import Layer6.rtt_walk_lock_unlock.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_rtt_walk_lock_unlock_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_rtt_walk_lock_unlock_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 st st'
             (Hspec: rtt_walk_lock_unlock_spec_low v_0 v_1 v_2 v_3 v_4 v_5 st = Some st'),
        exec_func Layer5_layer code "rtt_walk_lock_unlock"
                  [VPtr v_0; VPtr v_1; VInt v_2; VInt v_3; VInt v_4; VInt v_5]
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

End Layer6_rtt_walk_lock_unlock_CodeProof.

