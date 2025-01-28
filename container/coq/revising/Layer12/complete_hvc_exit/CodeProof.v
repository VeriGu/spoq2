Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer11.Spec.
Require Import Layer12.complete_hvc_exit.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_complete_hvc_exit_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque load_RData.
  Local Opaque ptr_offset.
  Local Opaque reset_last_run_info_spec.
  Local Opaque store_RData.
    Lemma f_complete_hvc_exit_correct:
      forall v_0 v_1 st st'
             (Hspec: complete_hvc_exit_spec_low v_0 v_1 st = Some st'),
        exec_func Layer11_layer code "complete_hvc_exit"
                  [VPtr v_0; VPtr v_1]
                  st st' None.
Admitted.

End Layer12_complete_hvc_exit_CodeProof.

