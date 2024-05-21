Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import ExceptionOps.Layer.
Require Import GlobalDefs.
Require Import SMCHandler.smc_data_create.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section SMCHandler_smc_data_create_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_smc_data_create_correct:
      forall v_data_addr v_rd_addr v_map_addr v_src_addr v_flags st st' res
             (Hspec: smc_data_create_spec_low v_data_addr v_rd_addr v_map_addr v_src_addr v_flags st = Some (res, st')),
        exec_func ExceptionOps_layer code "smc_data_create"
                  [VInt v_data_addr; VInt v_rd_addr; VInt v_map_addr; VInt v_src_addr; VInt v_flags]
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

End SMCHandler_smc_data_create_CodeProof.

