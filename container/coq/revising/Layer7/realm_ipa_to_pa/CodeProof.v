Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer2.Spec.
Require Import Layer4.Spec.
Require Import Layer5.Spec.
Require Import Layer6.Layer.
Require Import Layer6.Spec.
Require Import Layer7.realm_ipa_to_pa.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_realm_ipa_to_pa_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_RD.
  Local Opaque __tte_read_spec.
  Local Opaque free_stack.
  Local Opaque granule_lock_spec.
  Local Opaque granule_map_spec.
  Local Opaque granule_unlock_spec.
  Local Opaque int_to_ptr.
  Local Opaque is_addr_in_par_spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque new_frame.
  Local Opaque ptr_offset.
  Local Opaque ptr_to_int.
  Local Opaque realm_ipa_bits_spec.
  Local Opaque realm_rtt_starting_level_spec.
  Local Opaque rtt_walk_lock_unlock_spec.
  Local Opaque s2tte_is_valid_spec.
  Local Opaque s2tte_map_size_spec.
  Local Opaque s2tte_pa_spec.
  Local Opaque store_RData.
    Lemma f_realm_ipa_to_pa_correct:
      forall v_0 v_1 v_2 v_3 v_4 st st' res
             (Hspec: realm_ipa_to_pa_spec_low v_0 v_1 v_2 v_3 v_4 st = Some (res, st')),
        exec_func Layer6_layer code "realm_ipa_to_pa"
                  [VPtr v_0; VInt v_1; VPtr v_2; VPtr v_3; VPtr v_4]
                  st st' (Some (VInt res)).
Admitted.

End Layer7_realm_ipa_to_pa_CodeProof.

