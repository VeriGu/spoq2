Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer11.Layer.
Require Import Layer12.copy_gic_state_from_ns.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer12_copy_gic_state_from_ns_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Hint Unfold copy_gic_state_from_ns_loop48_low:spec.
  Hint Unfold copy_gic_state_from_ns_loop48_rank:spec.
  Local Opaque load_RData.
  Local Opaque mkPtr.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_copy_gic_state_from_ns_correct:
      forall v_0 v_1 st st'
             (Hspec: copy_gic_state_from_ns_spec_low v_0 v_1 st = Some st'),
        exec_func Layer11_layer code "copy_gic_state_from_ns"
                  [VPtr v_0; VPtr v_1]
                  st st' None.
Admitted.

End Layer12_copy_gic_state_from_ns_CodeProof.

