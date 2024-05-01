Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.psci_reset_rec.LowSpec.
Require Import MakeReturnCode.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Helpers_psci_reset_rec_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque ptr_offset.
  Local Opacque store_RData.
    Lemma f_psci_reset_rec_correct:
      forall v_rec v_caller_sctlr_el1 st st'
             (Hspec: psci_reset_rec_spec_low v_rec v_caller_sctlr_el1 st = Some st'),
        exec_func MakeReturnCode_layer code "psci_reset_rec"
                  [VPtr v_rec; VInt v_caller_sctlr_el1]
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

End Helpers_psci_reset_rec_CodeProof.

