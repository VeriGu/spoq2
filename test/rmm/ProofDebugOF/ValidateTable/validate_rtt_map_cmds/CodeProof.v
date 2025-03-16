Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import ValidateAddr.Layer.
Require Import ValidateAddr.Spec.
Require Import ValidateTable.validate_rtt_map_cmds.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section ValidateTable_validate_rtt_map_cmds_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque validate_map_addr_spec.
    Lemma f_validate_rtt_map_cmds_correct:
      forall v_map_addr v_level v_rd st st' res
             (Hspec: validate_rtt_map_cmds_spec_low v_map_addr v_level v_rd st = Some (res, st')),
        exec_func ValidateAddr_layer code "validate_rtt_map_cmds"
                  [VInt v_map_addr; VInt v_level; VPtr v_rd]
                  st st' (Some (VBool res)).
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

End ValidateTable_validate_rtt_map_cmds_CodeProof.

