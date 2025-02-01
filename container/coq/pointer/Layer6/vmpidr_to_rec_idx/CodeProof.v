Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Layer.
Require Import Layer6.vmpidr_to_rec_idx.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_vmpidr_to_rec_idx_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_vmpidr_to_rec_idx_correct:
      forall v_0 st st' res
             (Hspec: vmpidr_to_rec_idx_spec_low v_0 st = Some (res, st')),
        exec_func Layer5_layer code "vmpidr_to_rec_idx"
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

End Layer6_vmpidr_to_rec_idx_CodeProof.

