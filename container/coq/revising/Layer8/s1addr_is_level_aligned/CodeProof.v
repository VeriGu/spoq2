Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer7.Spec.
Require Import Layer8.s1addr_is_level_aligned.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_s1addr_is_level_aligned_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque s1addr_level_mask_spec.
    Lemma f_s1addr_is_level_aligned_correct:
      forall v_0 v_1 st st' res
             (Hspec: s1addr_is_level_aligned_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer7_layer code "s1addr_is_level_aligned"
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

End Layer8_s1addr_is_level_aligned_CodeProof.

