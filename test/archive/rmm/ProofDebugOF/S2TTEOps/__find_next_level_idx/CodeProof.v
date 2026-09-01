Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import FindGranule.Spec.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import S2TTEDesc.Spec.
Require Import S2TTEOps.__find_next_level_idx.LowSpec.
Require Import S2TTEState.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEOps___find_next_level_idx_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __table_get_entry_spec.
  Local Opaque addr_to_granule_spec.
  Local Opaque entry_is_table_spec.
  Local Opaque mkPtr.
  Local Opaque table_entry_to_phys_spec.
    Lemma f___find_next_level_idx_correct:
      forall v_g_tbl v_idx st st' res
             (Hspec: __find_next_level_idx_spec_low v_g_tbl v_idx st = Some (res, st')),
        exec_func S2TTEState_layer code "__find_next_level_idx"
                  [VPtr v_g_tbl; VInt v_idx]
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

End S2TTEOps___find_next_level_idx_CodeProof.

