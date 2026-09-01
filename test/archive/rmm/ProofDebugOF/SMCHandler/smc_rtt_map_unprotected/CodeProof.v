Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTCreate.Layer.
Require Import S2TTCreate.Spec.
Require Import S2TTEState.Spec.
Require Import SMCHandler.smc_rtt_map_unprotected.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SMCHandler_smc_rtt_map_unprotected_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque host_ns_s2tte_is_valid_spec.
  Local Opaque map_unmap_ns_spec.
    Lemma f_smc_rtt_map_unprotected_correct:
      forall v_rd_addr v_map_addr v_ulevel v_s2tte st st' res
             (Hspec: smc_rtt_map_unprotected_spec_low v_rd_addr v_map_addr v_ulevel v_s2tte st = Some (res, st')),
        exec_func S2TTCreate_layer code "smc_rtt_map_unprotected"
                  [VInt v_rd_addr; VInt v_map_addr; VInt v_ulevel; VInt v_s2tte]
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

End SMCHandler_smc_rtt_map_unprotected_CodeProof.

