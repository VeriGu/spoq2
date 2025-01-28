Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.vmid_free.LowSpec.
Require Import Layer3.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_vmid_free_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque bitmap_clear_spec.
  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque spinlock_acquire_spec.
  Local Opaque spinlock_release_spec.
    Lemma f_vmid_free_correct:
      forall v_0 st st'
             (Hspec: vmid_free_spec_low v_0 st = Some st'),
        exec_func Layer11_layer code "vmid_free"
                  [VInt v_0]
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

End Layer12_vmid_free_CodeProof.

