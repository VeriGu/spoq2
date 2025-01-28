Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer12.validate_rtt_structure_cmds.LowSpec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Layer9.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_validate_rtt_structure_cmds_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque make_return_code_spec.
  Local Opaque realm_rtt_starting_level_spec.
  Local Opaque validate_map_addr_spec.
    Lemma f_validate_rtt_structure_cmds_correct:
      forall v_0 v_1 v_2 st st' res
             (Hspec: validate_rtt_structure_cmds_spec_low v_0 v_1 v_2 st = Some (res, st')),
        exec_func Layer11_layer code "validate_rtt_structure_cmds"
                  [VInt v_0; VInt v_1; VPtr v_2]
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

End Layer12_validate_rtt_structure_cmds_CodeProof.

