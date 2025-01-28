Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.Layer.
Require Import Layer11.verify_header.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer11_verify_header_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque ptr_eqb.
  Local Opaque ptr_offset.
    Lemma f_verify_header_correct:
      forall v_0 st st' res
             (Hspec: verify_header_spec_low v_0 st = Some (res, st')),
        exec_func Layer10_layer code "verify_header"
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

End Layer11_verify_header_CodeProof.

