Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Layer.
Require Import Layer13.smc_read_feature_register.LowSpec.
Require Import Layer6.Spec.
Require Import Layer9.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_smc_read_feature_register_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque pack_return_code_spec.
  Local Opaque ptr_offset.
  Local Opaque rmm_feature_register_0_value_spec.
  Local Opaque store_RData.
    Lemma f_smc_read_feature_register_correct:
      forall v_0 v_1 st st'
             (Hspec: smc_read_feature_register_spec_low v_0 v_1 st = Some st'),
        exec_func Layer12_layer code "smc_read_feature_register"
                  [VInt v_0; VPtr v_1]
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

End Layer13_smc_read_feature_register_CodeProof.

