Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer8.Layer.
Require Import Layer9.read_ap0r.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer9_read_ap0r_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_100_spec.
  Local Opaque iasm_101_spec.
  Local Opaque iasm_98_spec.
  Local Opaque iasm_99_spec.
    Lemma f_read_ap0r_correct:
      forall v_0 st st' res
             (Hspec: read_ap0r_spec_low v_0 st = Some (res, st')),
        exec_func Layer8_layer code "read_ap0r"
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

End Layer9_read_ap0r_CodeProof.

