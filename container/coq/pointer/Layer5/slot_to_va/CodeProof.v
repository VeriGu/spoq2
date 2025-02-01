Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Layer.
Require Import Layer4.Spec.
Require Import Layer5.slot_to_va.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer5_slot_to_va_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque cpuid_spec.
  Local Opaque int_to_ptr.
  Local Opaque ptr_offset.
    Lemma f_slot_to_va_correct:
      forall v_0 st st' res
             (Hspec: slot_to_va_spec_low v_0 st = Some (res, st')),
        exec_func Layer4_layer code "slot_to_va"
                  [VInt v_0]
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

End Layer5_slot_to_va_CodeProof.

