Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer3.Spec.
Require Import Layer4.Spec.
Require Import Layer6.Layer.
Require Import Layer7.get_tte.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_get_tte_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque entry_is_table_spec.
  Local Opaque int_to_ptr.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque s2_addr_to_idx_spec.
  Local Opaque table_entry_to_phys_spec.
    Lemma f_get_tte_correct:
      forall v_0 st st' res
             (Hspec: get_tte_spec_low v_0 st = Some (res, st')),
        exec_func Layer6_layer code "get_tte"
                  [VInt v_0]
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

End Layer7_get_tte_CodeProof.

