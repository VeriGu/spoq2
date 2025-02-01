Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Layer.
Require Import Layer5.Spec.
Require Import Layer6.ns_buffer_read.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_ns_buffer_read_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque granule_pa_to_va_spec.
  Local Opaque memcpy_ns_read_spec.
    Lemma f_ns_buffer_read_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: ns_buffer_read_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer5_layer code "ns_buffer_read"
                  [VInt v_0; VInt v_1; VInt v_2; VPtr v_3]
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

End Layer6_ns_buffer_read_CodeProof.

