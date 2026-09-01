Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Layer.
Require Import Layer2.addr_to_idx.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer2_addr_to_idx_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque MEM0_PHYS.
  Local Opaque MEM0_SIZE.
  Local Opaque MEM1_PHYS.
  Local Opaque MEM1_SIZE.
    Lemma f_addr_to_idx_correct:
      forall v_0 st st' res
             (Hspec: addr_to_idx_spec_low v_0 st = Some (res, st')),
        exec_func Layer1_layer code "addr_to_idx"
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

End Layer2_addr_to_idx_CodeProof.

