Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer8.Layer.
Require Import Layer9.rsi_set_ttbr0.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rsi_set_ttbr0_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque find_lock_granule_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_82_spec.
  Local Opaque mkPtr.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
  Local Opaque ptr_to_int.
  Local Opaque store_RData.
    Lemma f_rsi_set_ttbr0_correct:
      forall v_0 v_1 st st' res
             (Hspec: rsi_set_ttbr0_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer8_layer code "rsi_set_ttbr0"
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

End Layer9_rsi_set_ttbr0_CodeProof.

