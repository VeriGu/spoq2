Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Layer.
Require Import Layer5.Spec.
Require Import Layer6.set_pas_ns_to_any.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_set_pas_ns_to_any_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque monitor_call_spec.
    Lemma f_set_pas_ns_to_any_correct:
      forall v_0 st st'
             (Hspec: set_pas_ns_to_any_spec_low v_0 st = Some st'),
        exec_func Layer5_layer code "set_pas_ns_to_any"
                  [VInt v_0]
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

End Layer6_set_pas_ns_to_any_CodeProof.

