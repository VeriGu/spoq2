Require Import CheckFeature.Layer.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RDState.get_rd_rec_count_unlocked.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RDState_get_rd_rec_count_unlocked_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_get_rd_rec_count_unlocked_correct:
      forall v_rd st st' res
             (Hspec: get_rd_rec_count_unlocked_spec_low v_rd st = Some (res, st')),
        exec_func CheckFeature_layer code "get_rd_rec_count_unlocked"
                  [VPtr v_rd]
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

End RDState_get_rd_rec_count_unlocked_CodeProof.

