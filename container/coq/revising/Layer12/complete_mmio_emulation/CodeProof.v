Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.complete_mmio_emulation.LowSpec.
Require Import Layer7.Spec.
Require Import Layer8.Spec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_complete_mmio_emulation_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque access_len_spec.
  Local Opaque access_mask_spec.
  Local Opaque esr_is_write_spec.
  Local Opaque esr_sign_extend_spec.
  Local Opaque esr_sixty_four_spec.
  Local Opaque esr_srt_spec.
  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_complete_mmio_emulation_correct:
      forall v_0 v_1 st st' res
             (Hspec: complete_mmio_emulation_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer11_layer code "complete_mmio_emulation"
                  [VPtr v_0; VPtr v_1]
                  st st' (Some (VBool res)).
Admitted.

End Layer12_complete_mmio_emulation_CodeProof.

