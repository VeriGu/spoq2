Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Layer.
Require Import Layer8.Spec.
Require Import Layer9.rsi_rtt_create.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rsi_rtt_create_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_lock_granule_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque mkPtr.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque rtt_create_internal_spec.
  Local Opaque rtt_create_s1_el1_spec.
    Lemma f_rsi_rtt_create_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: rsi_rtt_create_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer8_layer code "rsi_rtt_create"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3]
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

End Layer9_rsi_rtt_create_CodeProof.

