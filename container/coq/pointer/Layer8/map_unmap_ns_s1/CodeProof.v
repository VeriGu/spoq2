Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer7.Layer.
Require Import Layer8.map_unmap_ns_s1.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer8_map_unmap_ns_s1_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_map_unmap_ns_s1_correct:
      forall v_0 v_1 v_2 v_3 v_4 st st' res
             (Hspec: map_unmap_ns_s1_spec_low v_0 v_1 v_2 v_3 v_4 st = Some (res, st')),
        exec_func Layer7_layer code "map_unmap_ns_s1"
                  [VInt v_0; VInt v_1; VInt v_2; VInt v_3; VInt v_4]
                  st st' (Some (VInt res)).
Admitted.

End Layer8_map_unmap_ns_s1_CodeProof.

