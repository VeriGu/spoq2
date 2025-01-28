Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.va_to_s1tte.LowSpec.
Require Import Layer9.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_va_to_s1tte_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque ptr_to_int.
    Lemma f_va_to_s1tte_correct:
      forall v_0 st st' res
             (Hspec: va_to_s1tte_spec_low v_0 st = Some (res, st')),
        exec_func Layer9_layer code "va_to_s1tte"
                  [VPtr v_0]
                  st st' (Some (VPtr res)).
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

End Layer10_va_to_s1tte_CodeProof.

