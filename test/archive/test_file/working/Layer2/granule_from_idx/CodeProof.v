Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Layer.
Require Import Layer2.granule_from_idx.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer2_granule_from_idx_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque NR_GRANULES.
  Local Opaque mkPtr.
  Local Opaque ptr_offset.
    Lemma f_granule_from_idx_correct:
      forall v_0 st st' res
             (Hspec: granule_from_idx_spec_low v_0 st = Some (res, st')),
        exec_func Layer1_layer code "granule_from_idx"
                  [VInt v_0]
                  st st' (Some (VPtr res)).
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

End Layer2_granule_from_idx_CodeProof.

