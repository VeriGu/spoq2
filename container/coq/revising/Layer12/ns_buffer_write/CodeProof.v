Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer12.ns_buffer_write.LowSpec.
Require Import Layer5.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_ns_buffer_write_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque granule_pa_to_va_spec.
  Local Opaque memcpy_ns_write_spec.
    Lemma f_ns_buffer_write_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: ns_buffer_write_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer11_layer code "ns_buffer_write"
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

End Layer12_ns_buffer_write_CodeProof.

