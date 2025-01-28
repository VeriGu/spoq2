Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer8.write_lr.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_write_lr_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_289_spec.
  Local Opaque iasm_290_spec.
  Local Opaque iasm_291_spec.
  Local Opaque iasm_292_spec.
  Local Opaque iasm_293_spec.
  Local Opaque iasm_294_spec.
  Local Opaque iasm_295_spec.
  Local Opaque iasm_296_spec.
  Local Opaque iasm_297_spec.
  Local Opaque iasm_298_spec.
  Local Opaque iasm_299_spec.
  Local Opaque iasm_300_spec.
  Local Opaque iasm_301_spec.
  Local Opaque iasm_302_spec.
  Local Opaque iasm_303_spec.
  Local Opaque iasm_304_spec.
    Lemma f_write_lr_correct:
      forall v_0 v_1 st st'
             (Hspec: write_lr_spec_low v_0 v_1 st = Some st'),
        exec_func Layer7_layer code "write_lr"
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

End Layer8_write_lr_CodeProof.

