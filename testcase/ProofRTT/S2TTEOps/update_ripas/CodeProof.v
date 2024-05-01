Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import S2TTEOps.update_ripas.LowSpec.
Require Import S2TTEPA.Layer.
Require Import S2TTEPA.Spec.
Require Import S2TTEState.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEOps_update_ripas_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque load_RData.
  Local Opacque s2tte_create_assigned_empty_spec.
  Local Opacque s2tte_create_ripas_spec.
  Local Opacque s2tte_is_assigned_spec.
  Local Opacque s2tte_is_table_spec.
  Local Opacque s2tte_is_unassigned_spec.
  Local Opacque s2tte_is_valid_spec.
  Local Opacque s2tte_pa_spec.
  Local Opacque store_RData.
    Lemma f_update_ripas_correct:
      forall v_s2tte v_level v_ripas st st' res
             (Hspec: update_ripas_spec_low v_s2tte v_level v_ripas st = Some (res, st')),
        exec_func S2TTEPA_layer code "update_ripas"
                  [VPtr v_s2tte; VInt v_level; VInt v_ripas]
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

End S2TTEOps_update_ripas_CodeProof.

