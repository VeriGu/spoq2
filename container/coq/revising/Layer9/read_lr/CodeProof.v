Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Layer.
Require Import Layer9.read_lr.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_read_lr_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_117_spec.
  Local Opaque iasm_118_spec.
  Local Opaque iasm_119_spec.
  Local Opaque iasm_120_spec.
  Local Opaque iasm_121_spec.
  Local Opaque iasm_122_spec.
  Local Opaque iasm_123_spec.
  Local Opaque iasm_124_spec.
  Local Opaque iasm_125_spec.
  Local Opaque iasm_126_spec.
  Local Opaque iasm_127_spec.
  Local Opaque iasm_128_spec.
  Local Opaque iasm_129_spec.
  Local Opaque iasm_130_spec.
  Local Opaque iasm_131_spec.
  Local Opaque iasm_132_spec.
    Lemma f_read_lr_correct:
      forall v_0 st st' res
             (Hspec: read_lr_spec_low v_0 st = Some (res, st')),
        exec_func Layer8_layer code "read_lr"
                  [VInt v_0]
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

End Layer9_read_lr_CodeProof.

