Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.granule_refcount_read_acquire.LowSpec.
Require Import Layer9.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_granule_refcount_read_acquire_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __sca_read64_acquire_spec.
  Local Opaque ptr_offset.
    Lemma f_granule_refcount_read_acquire_correct:
      forall v_0 st st' res
             (Hspec: granule_refcount_read_acquire_spec_low v_0 st = Some (res, st')),
        exec_func Layer9_layer code "granule_refcount_read_acquire"
                  [VPtr v_0]
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

End Layer10_granule_refcount_read_acquire_CodeProof.

