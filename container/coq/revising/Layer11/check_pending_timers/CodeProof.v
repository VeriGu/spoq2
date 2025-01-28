Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer10.Spec.
Require Import Layer11.check_pending_timers.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_check_pending_timers_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_6_spec.
  Local Opaque iasm_7_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque timer_output_is_asserted_spec.
    Lemma f_check_pending_timers_correct:
      forall v_0 st st' res
             (Hspec: check_pending_timers_spec_low v_0 st = Some (res, st')),
        exec_func Layer10_layer code "check_pending_timers"
                  [VPtr v_0]
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

End Layer11_check_pending_timers_CodeProof.

