Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Layer.
Require Import Layer6.Spec.
Require Import Layer7.get_sysreg_write_value.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_get_sysreg_write_value_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque esr_sysreg_rt_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
    Lemma f_get_sysreg_write_value_correct:
      forall v_0 v_1 st st' res
             (Hspec: get_sysreg_write_value_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer6_layer code "get_sysreg_write_value"
                  [VPtr v_0; VInt v_1]
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

End Layer7_get_sysreg_write_value_CodeProof.

