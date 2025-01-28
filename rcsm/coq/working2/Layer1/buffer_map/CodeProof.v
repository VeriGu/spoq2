Require Import Bottom.Layer.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.buffer_map.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer1_buffer_map_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque MEM0_PHYS.
  Local Opaque MEM0_SIZE.
  Local Opaque int_to_ptr.
    Lemma f_buffer_map_correct:
      forall v_0 v_1 v_2 st st' res
             (Hspec: buffer_map_spec_low v_0 v_1 v_2 st = Some (res, st')),
        exec_func Bottom_layer code "buffer_map"
                  [VInt v_0; VInt v_1; VBool v_2]
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

End Layer1_buffer_map_CodeProof.

