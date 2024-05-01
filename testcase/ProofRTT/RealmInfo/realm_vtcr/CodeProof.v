Require Import CheckFeature.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import RealmInfo.realm_vtcr.LowSpec.
Require Import S2TTEOps.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section RealmInfo_realm_vtcr_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque is_feat_vmid16_present_spec.
  Local Opacque load_RData.
  Local Opacque mkPtr.
  Local Opacque ptr_offset.
  Local Opacque realm_ipa_bits_spec.
  Local Opacque realm_rtt_starting_level_spec.
    Lemma f_realm_vtcr_correct:
      forall v_rd st st' res
             (Hspec: realm_vtcr_spec_low v_rd st = Some (res, st')),
        exec_func S2TTEOps_layer code "realm_vtcr"
                  [VPtr v_rd]
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

End RealmInfo_realm_vtcr_CodeProof.

