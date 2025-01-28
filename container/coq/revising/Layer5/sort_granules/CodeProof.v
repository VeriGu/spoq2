Require Import Bottom.Spec.
Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer4.Layer.
Require Import Layer5.sort_granules.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer5_sort_granules_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque alloc_stack.
  Local Opaque free_stack.
  Local Opaque llvm_memcpy_p0i8_p0i8_i64_spec.
  Local Opaque load_RData.
  Local Opaque new_frame.
  Local Opaque ptr_offset.
  Local Opaque store_RData.
    Lemma f_sort_granules_correct:
      forall v_0 v_1 st st'
             (Hspec: sort_granules_spec_low v_0 v_1 st = Some st'),
        exec_func Layer4_layer code "sort_granules"
                  [VPtr v_0; VInt v_1]
                  st st' None.
Admitted.

End Layer5_sort_granules_CodeProof.

