Require Import CheckFeature.is_feat_lpa2_4k_present.LowSpec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section CheckFeature_is_feat_lpa2_4k_present_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_is_feat_lpa2_4k_present_correct:
      forall st st' res
             (Hspec: is_feat_lpa2_4k_present_spec_low st = Some (res, st')),
        exec_func Helpers_layer code "is_feat_lpa2_4k_present"
                  []
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

End CheckFeature_is_feat_lpa2_4k_present_CodeProof.

