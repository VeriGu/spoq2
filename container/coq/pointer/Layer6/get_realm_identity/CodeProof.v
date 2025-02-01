Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer5.Layer.
Require Import Layer6.get_realm_identity.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer6_get_realm_identity_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque ptr_to_int.
  Local Opaque store_RData.
    Lemma f_get_realm_identity_correct:
      forall v_0 v_1 st st'
             (Hspec: get_realm_identity_spec_low v_0 v_1 st = Some st'),
        exec_func Layer5_layer code "get_realm_identity"
                  [VPtr v_0; VPtr v_1]
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

End Layer6_get_realm_identity_CodeProof.

