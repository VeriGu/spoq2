Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer8.emulate_stage2_data_abort.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_emulate_stage2_data_abort_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque iasm_get_elr_el2_spec.
  Local Opaque iasm_set_elr_el2_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_emulate_stage2_data_abort_correct:
      forall v_0 v_1 v_2 st st'
             (Hspec: emulate_stage2_data_abort_spec_low v_0 v_1 v_2 st = Some st'),
        exec_func Layer7_layer code "emulate_stage2_data_abort"
                  [VPtr v_0; VPtr v_1; VInt v_2]
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

End Layer8_emulate_stage2_data_abort_CodeProof.

