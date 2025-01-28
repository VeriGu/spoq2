Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Spec.
Require Import Layer7.Layer.
Require Import Layer7.Spec.
Require Import Layer8.rsi_memory_dispose.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_rsi_memory_dispose_CodeProof.

  Context `{int_ptr: IntPtrCast}.

  Local Opaque GRANULE_STATE_REC.
  Local Opaque load_RData.
  Local Opaque pack_return_code_spec.
  Local Opaque ptr_offset.
  Local Opaque region_is_contained_spec.
  Local Opaque store_RData.
    Lemma f_rsi_memory_dispose_correct:
      forall v_0 v_1 st st' res
             (Hspec: rsi_memory_dispose_spec_low v_0 v_1 st = Some (res, st')),
        exec_func Layer7_layer code "rsi_memory_dispose"
                  [VPtr v_0; VPtr v_1]
                  st st' (Some (VBool res)).
Admitted.

End Layer8_rsi_memory_dispose_CodeProof.

