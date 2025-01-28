Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer12.__granule_refcount_dec.LowSpec.
Require Import Layer4.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12___granule_refcount_dec_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque atomic_add_64_spec.
  Local Opaque ptr_offset.
    Lemma f___granule_refcount_dec_correct:
      forall v_0 v_1 st st'
             (Hspec: __granule_refcount_dec_spec_low v_0 v_1 st = Some st'),
        exec_func Layer11_layer code "__granule_refcount_dec"
                  [VPtr v_0; VInt v_1]
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

End Layer12___granule_refcount_dec_CodeProof.

