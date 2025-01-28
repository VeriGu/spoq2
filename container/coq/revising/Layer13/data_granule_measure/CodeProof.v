Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer12.Layer.
Require Import Layer13.data_granule_measure.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer13_data_granule_measure_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque free_stack.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_data_granule_measure_correct:
      forall v_0 v_1 v_2 v_3 st st'
             (Hspec: data_granule_measure_spec_low v_0 v_1 v_2 v_3 st = Some st'),
        exec_func Layer12_layer code "data_granule_measure"
                  [VPtr v_0; VPtr v_1; VInt v_2; VInt v_3]
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

End Layer13_data_granule_measure_CodeProof.

