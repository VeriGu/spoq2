Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.validate_realm_params.LowSpec.
Require Import Layer5.Spec.
Require Import Layer6.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_validate_realm_params_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque load_RData.
  Local Opaque pack_return_code_spec.
  Local Opaque pack_struct_return_code_spec.
  Local Opaque ptr_offset.
  Local Opaque requested_ipa_bits_spec.
  Local Opaque s2_num_root_rtts_spec.
  Local Opaque validate_ipa_bits_and_sl_spec.
  Local Opaque validate_rmm_feature_register_value_spec.
  Local Opaque vmid_reserve_spec.
    Lemma f_validate_realm_params_correct:
      forall v_0 st st' res
             (Hspec: validate_realm_params_spec_low v_0 st = Some (res, st')),
        exec_func Layer11_layer code "validate_realm_params"
                  [VPtr v_0]
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

End Layer12_validate_realm_params_CodeProof.

