Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEDesc.Layer.
Require Import S2TTEDesc.Spec.
Require Import S2TTEState.s2tte_is_unassigned.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEState_s2tte_is_unassigned_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque s2tte_has_hipas_spec.
    Lemma f_s2tte_is_unassigned_correct:
      forall v_s2tte st st' res
             (Hspec: s2tte_is_unassigned_spec_low v_s2tte st = Some (res, st')),
        exec_func S2TTEDesc_layer code "s2tte_is_unassigned"
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

End S2TTEState_s2tte_is_unassigned_CodeProof.

