Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import EL3IFC.Layer.
Require Import GlobalDefs.
Require Import SMCHandler.smc_granule_delegate.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SMCHandler_smc_granule_delegate_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_smc_granule_delegate_correct:
      forall v_addr st st' res
             (Hspec: smc_granule_delegate_spec_low v_addr st = Some (res, st')),
        exec_func EL3IFC_layer code "smc_granule_delegate"
                  [VInt v_addr]
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

End SMCHandler_smc_granule_delegate_CodeProof.

