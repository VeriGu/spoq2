Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Layer.
Require Import S2TTEState.s2tte_is_destroyed.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEState_s2tte_is_destroyed_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_s2tte_is_destroyed_correct:
      forall v_s2tte st st' res
             (Hspec: s2tte_is_destroyed_spec_low v_s2tte st = Some (res, st')),
        exec_func S2TTEDesc_layer code "s2tte_is_destroyed"
                  [VInt v_s2tte]
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

End S2TTEState_s2tte_is_destroyed_CodeProof.

