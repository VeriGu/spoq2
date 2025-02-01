Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Layer.
Require Import Layer2.Spec.
Require Import Layer3.__table_get_entry.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer3___table_get_entry_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque __tte_read_spec.
  Local Opaque granule_map_spec.
  Local Opaque ptr_offset.
    Lemma f___table_get_entry_correct:
      forall v_0 v_1 st st' res
             (Hspec: __table_get_entry_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer2_layer code "__table_get_entry"
                  [VPtr v_0; VInt v_1]
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

End Layer3___table_get_entry_CodeProof.

