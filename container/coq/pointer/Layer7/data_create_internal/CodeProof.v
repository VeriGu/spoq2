Require Import Code.
Require Import CommonDeps.
Require Import DataTypes.
Require Import GlobalDefs.
Require Import Layer6.Layer.
Require Import Layer7.data_create_internal.LowSpec.
Require Import Zwf.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Opaque Z.add Z.mul Z.div Z.sub Z.land Z.lor Z.lxor Z.shiftl Z.shiftr Z.quot Z.rem Z.testbit Z.setbit Z.clearbit xorb List.nth.

Section Layer7_data_create_internal_CodeProof.

  Context `{int_ptr: IntPtrCast}.

    Lemma f_data_create_internal_correct:
      forall v_0 v_1 v_2 v_3 v_4 v_5 st st' res
             (Hspec: data_create_internal_spec_low v_0 v_1 v_2 v_3 v_4 v_5 st = Some (res, st')),
        exec_func Layer6_layer code "data_create_internal"
                  [VInt v_0; VPtr v_1; VInt v_2; VPtr v_3; VPtr v_4; VInt v_5]
                  st st' (Some (VInt res)).
Admitted.

End Layer7_data_create_internal_CodeProof.

