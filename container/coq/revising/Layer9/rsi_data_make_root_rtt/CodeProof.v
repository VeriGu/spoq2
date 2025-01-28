Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer6.Spec.
Require Import Layer7.Spec.
Require Import Layer8.Layer.
Require Import Layer9.rsi_data_make_root_rtt.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_rsi_data_make_root_rtt_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque find_granule_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_try_lock_spec.
  Local Opaque granule_unlock_transition_spec.
  Local Opaque mkPtr.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_eqb.
  Local Opaque s2tt_init_unassigned_spec.
    Lemma f_rsi_data_make_root_rtt_correct:
      forall v_0 st st' res
             (Hspec: rsi_data_make_root_rtt_spec_low v_0 st = Some (res, st')),
        exec_func Layer8_layer code "rsi_data_make_root_rtt"
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

End Layer9_rsi_data_make_root_rtt_CodeProof.

