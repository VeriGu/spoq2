Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Layer.
Require Import Layer12.Spec.
Require Import Layer13.smc_data_create_unknown.LowSpec.
Require Import Layer8.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_smc_data_create_unknown_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque data_create_s1_el1_spec.
  Local Opaque data_create_spec.
  Local Opaque mkPtr.
    Lemma f_smc_data_create_unknown_correct:
      forall v_0 v_1 v_2 st st' res
             (Hspec: smc_data_create_unknown_spec_low v_0 v_1 v_2 st = Some (res, st')),
        exec_func Layer12_layer code "smc_data_create_unknown"
                  [VInt v_0; VInt v_1; VInt v_2]
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

End Layer13_smc_data_create_unknown_CodeProof.

