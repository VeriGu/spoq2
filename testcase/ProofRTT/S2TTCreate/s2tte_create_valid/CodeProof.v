Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.s2tte_create_valid.LowSpec.
Require Import TableWalk.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTCreate_s2tte_create_valid_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2tte_create_valid_correct:
      forall v_pa v_level st st' res
             (Hspec: s2tte_create_valid_spec_low v_pa v_level st = Some (res, st')),
        exec_func TableWalk_layer code "s2tte_create_valid"
                  [VInt v_pa; VInt v_level]
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

End S2TTCreate_s2tte_create_valid_CodeProof.

