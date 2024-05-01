Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Helpers.Spec.
Require Import S2TTEOps.realm_ipa_size.LowSpec.
Require Import S2TTEPA.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTEOps_realm_ipa_size_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opacque realm_ipa_bits_spec.
    Lemma f_realm_ipa_size_correct:
      forall v_rd st st' res
             (Hspec: realm_ipa_size_spec_low v_rd st = Some (res, st')),
        exec_func S2TTEPA_layer code "realm_ipa_size"
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

End S2TTEOps_realm_ipa_size_CodeProof.

