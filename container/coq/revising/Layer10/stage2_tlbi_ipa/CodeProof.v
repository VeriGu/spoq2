Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer10.stage2_tlbi_ipa.LowSpec.
Require Import Layer9.Layer.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer10_stage2_tlbi_ipa_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque iasm_10_spec.
  Local Opaque iasm_12_isb_spec.
  Local Opaque iasm_258_spec.
  Local Opaque iasm_270_spec.
  Local Opaque iasm_get_vttbr_el2_spec.
  Local Opaque iasm_set_vttbr_el2_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Hint Unfold stage2_tlbi_ipa_loop210_low:spec.
  Hint Unfold stage2_tlbi_ipa_loop210_rank:spec.
    Lemma f_stage2_tlbi_ipa_correct:
      forall v_0 v_1 v_2 st st'
             (Hspec: stage2_tlbi_ipa_spec_low v_0 v_1 v_2 st = Some st'),
        exec_func Layer9_layer code "stage2_tlbi_ipa"
                  [VPtr v_0; VInt v_1; VInt v_2]
                  st st' None.
Admitted.

End Layer10_stage2_tlbi_ipa_CodeProof.

