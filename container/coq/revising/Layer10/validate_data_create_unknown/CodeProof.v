Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.validate_data_create_unknown.LowSpec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer9.Layer.
Require Import Layer9.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_validate_data_create_unknown_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque is_addr_in_par_spec.
  Local Opaque make_return_code_spec.
  Local Opaque validate_map_addr_spec.
    Lemma f_validate_data_create_unknown_correct:
      forall v_0 v_1 st st' res
             (Hspec: validate_data_create_unknown_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer9_layer code "validate_data_create_unknown"
                  [VInt v_0; VPtr v_1]
                  st st' (Some (VInt res)).
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

End Layer10_validate_data_create_unknown_CodeProof.

