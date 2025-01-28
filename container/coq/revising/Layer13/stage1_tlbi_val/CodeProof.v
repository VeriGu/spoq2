Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Layer.
Require Import Layer13.stage1_tlbi_val.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_stage1_tlbi_val_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_10_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_264_spec.
    Lemma f_stage1_tlbi_val_correct:
      forall v_0 v_1 st st'
             (Hspec: stage1_tlbi_val_spec_low v_0 v_1 st = Some st'),
        exec_func Layer12_layer code "stage1_tlbi_val"
                  [VInt v_0; VInt v_1]
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

End Layer13_stage1_tlbi_val_CodeProof.

