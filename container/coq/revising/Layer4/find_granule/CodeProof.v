Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer3.Layer.
Require Import Layer4.find_granule.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer4_find_granule_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque MEM0_PHYS.
  Local Opaque MEM0_SIZE.
  Local Opaque MEM1_PHYS.
  Local Opaque MEM1_SIZE.
  Local Opaque addr_to_idx_spec.
  Local Opaque granule_from_idx_spec.
  Local Opaque mkPtr.
    Lemma f_find_granule_correct:
      forall v_0 st st' res
             (Hspec: find_granule_spec_low v_0 st = Some (res, st')),
        exec_func Layer3_layer code "find_granule"
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

End Layer4_find_granule_CodeProof.

