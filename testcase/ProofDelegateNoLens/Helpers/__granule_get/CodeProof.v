Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.__granule_get.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers___granule_get_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f___granule_get_correct:
      forall v_g st st'
             (Hspec: __granule_get_spec_low v_g st = Some st'),
        exec_func MakeReturnCode_layer code "__granule_get"
                  [VPtr v_g]
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

End Helpers___granule_get_CodeProof.

