Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer8.write_ap1r.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_write_ap1r_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_285_spec.
  Local Opaque iasm_286_spec.
  Local Opaque iasm_287_spec.
  Local Opaque iasm_288_spec.
    Lemma f_write_ap1r_correct:
      forall v_0 v_1 st st'
             (Hspec: write_ap1r_spec_low v_0 v_1 st = Some st'),
        exec_func Layer7_layer code "write_ap1r"
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

End Layer8_write_ap1r_CodeProof.

