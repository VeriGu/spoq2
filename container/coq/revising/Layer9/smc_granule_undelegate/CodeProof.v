Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Layer.
Require Import Layer8.Spec.
Require Import Layer9.smc_granule_undelegate.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_smc_granule_undelegate_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_lock_granule_spec.
  Local Opaque granule_set_state_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque mkPtr.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque set_pas_ns_spec.
  Local Opaque set_tte_ns_spec.
    Lemma f_smc_granule_undelegate_correct:
      forall v_0 v_1 st st' res
             (Hspec: smc_granule_undelegate_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer8_layer code "smc_granule_undelegate"
                  [VInt v_0; VInt v_1]
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

End Layer9_smc_granule_undelegate_CodeProof.

