Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RTTFold.table_is_destroyed_block.LowSpec.
Require Import TableBlock.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RTTFold_table_is_destroyed_block_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_table_is_destroyed_block_correct:
      forall v_table st st' res
             (Hspec: table_is_destroyed_block_spec_low v_table st = Some (res, st')),
        exec_func TableBlock_layer code "table_is_destroyed_block"
                  [VPtr v_table]
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

End RTTFold_table_is_destroyed_block_CodeProof.

