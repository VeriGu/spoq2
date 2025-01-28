Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer12.get_realm_params.LowSpec.
Require Import Layer4.Spec.
Require Import Layer6.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_get_realm_params_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_granule_spec.
  Local Opaque mkPtr.
  Local Opaque ns_buffer_read_spec.
  Local Opaque ns_buffer_unmap_spec.
  Local Opaque ptr_eqb.
    Lemma f_get_realm_params_correct:
      forall v_0 v_1 st st' res
             (Hspec: get_realm_params_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer11_layer code "get_realm_params"
                  [VPtr v_0; VInt v_1]
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

End Layer12_get_realm_params_CodeProof.

