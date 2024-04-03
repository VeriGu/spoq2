Require Import CheckFeature.Layer.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RDState.set_rd_state.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RDState_set_rd_state_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_set_rd_state_correct:
      forall v_rd v_state st st'
             (Hspec: set_rd_state_spec_low v_rd v_state st = Some st'),
        exec_func CheckFeature_layer code "set_rd_state"
                  [VPtr v_rd; VInt v_state]
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

End RDState_set_rd_state_CodeProof.

