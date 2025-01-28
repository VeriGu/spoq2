Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Spec.
Require Import Layer7.Layer.
Require Import Layer7.Spec.
Require Import Layer8.rtt_create_s1_el1.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_rtt_create_s1_el1_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque granule_lock_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque rtt_create_internal_spec.
    Lemma f_rtt_create_s1_el1_correct:
      forall v_0 v_1 v_2 v_3 st st' res
             (Hspec: rtt_create_s1_el1_spec_low v_0 v_1 v_2 v_3 st = Some (res, st')),
        exec_func Layer7_layer code "rtt_create_s1_el1"
                  [VPtr v_0; VInt v_1; VInt v_2; VInt v_3]
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

End Layer8_rtt_create_s1_el1_CodeProof.

