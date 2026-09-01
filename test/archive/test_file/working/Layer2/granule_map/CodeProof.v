Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer1.Layer.
Require Import Layer1.Spec.
Require Import Layer2.granule_map.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer2_granule_map_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque buffer_map_spec.
  Local Opaque granule_addr_spec.
    Lemma f_granule_map_correct:
      forall v_0 v_1 st st' res
             (Hspec: granule_map_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer1_layer code "granule_map"
                  [VPtr v_0; VInt v_1]
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

End Layer2_granule_map_CodeProof.

