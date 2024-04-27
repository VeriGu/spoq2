Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import RTTFold.Layer.
Require Import S2TTInit.realm_ipa_get_ripas.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section S2TTInit_realm_ipa_get_ripas_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_realm_ipa_get_ripas_correct:
      forall v_rec v_ipa v_ripas_ptr v_rtt_level st st' res
             (Hspec: realm_ipa_get_ripas_spec_low v_rec v_ipa v_ripas_ptr v_rtt_level st = Some (res, st')),
        exec_func RTTFold_layer code "realm_ipa_get_ripas"
                  [VPtr v_rec; VInt v_ipa; VPtr v_ripas_ptr; VPtr v_rtt_level]
                  st st' (Some (VInt res)).
Admitted.

End S2TTInit_realm_ipa_get_ripas_CodeProof.

