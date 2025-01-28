Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Layer.
Require Import Layer3.Spec.
Require Import Layer4.__find_next_level_idx.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer4___find_next_level_idx_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __table_get_entry_spec.
  Local Opaque addr_to_granule_spec.
  Local Opaque entry_is_table_spec.
  Local Opaque mkPtr.
  Local Opaque table_entry_to_phys_spec.
    Lemma f___find_next_level_idx_correct:
      forall v_0 v_1 st st' res
             (Hspec: __find_next_level_idx_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer3_layer code "__find_next_level_idx"
                  [VPtr v_0; VInt v_1]
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

End Layer4___find_next_level_idx_CodeProof.

