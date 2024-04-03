Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import TableAux.__find_lock_next_level.LowSpec.
Require Import ValidateTable.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section TableAux___find_lock_next_level_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f___find_lock_next_level_correct:
      forall v_g_tbl v_map_addr v_level st st' res
             (Hspec: __find_lock_next_level_spec_low v_g_tbl v_map_addr v_level st = Some (res, st')),
        exec_func ValidateTable_layer code "__find_lock_next_level"
                  [VPtr v_g_tbl; VInt v_map_addr; VInt v_level]
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

End TableAux___find_lock_next_level_CodeProof.

